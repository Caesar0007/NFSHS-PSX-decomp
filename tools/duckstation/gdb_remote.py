#!/usr/bin/env python3
"""Small DuckStation GDB-remote client for deterministic PSX trace capture."""
from __future__ import annotations

import argparse
import csv
import json
import mmap
import os
import socket
import struct
from pathlib import Path


class Remote:
    def __init__(self, host: str, port: int):
        self.s = socket.create_connection((host, port), timeout=10)
        self.s.settimeout(3)
        self.s.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)
        self._rx = bytearray()
        self.stopped = False
        self.shared_ram = None
        self.shared_ram_error = None
        self.shared_bytes = 0
        if os.environ.get('FF_GDB_RAM_BACKEND', 'auto') != 'rsp':
            try:
                from shared_ram import SharedRAM
                self.shared_ram = SharedRAM(host, port)
            except (OSError, ValueError, AttributeError) as exc:
                self.shared_ram_error = str(exc)
        # DuckStation's stub accepts the conventional initial positive ACK.
        self.s.sendall(b"+")

    @staticmethod
    def _sum(data: bytes) -> bytes:
        return f"{sum(data) & 255:02x}".encode()

    def _receive_packet(self) -> str:
        # Keep unread bytes: TCP may split one packet or coalesce several replies.
        while True:
            start = self._rx.find(b"$")
            if start >= 0:
                if start:
                    del self._rx[:start]
                end = self._rx.find(b"#", 1)
                if end >= 0 and len(self._rx) >= end + 3:
                    payload = bytes(self._rx[1:end])
                    checksum = bytes(self._rx[end + 1:end + 3])
                    del self._rx[:end + 3]
                    if checksum.lower() != self._sum(payload):
                        self.s.sendall(b"-")
                        raise RuntimeError("bad GDB packet checksum")
                    self.s.sendall(b"+")
                    if payload[:1] in (b'S', b'T'):
                        self.stopped = True
                    return payload.decode(errors="replace")
            else:
                self._rx.clear()  # Only ACK/NAK bytes before the packet marker.
            part = self.s.recv(65536)
            if not part:
                raise EOFError("GDB connection closed inside packet")
            self._rx.extend(part)

    def packet(self, command: str, timeout: float | None = None) -> str:
        if command.startswith('m') and self.stopped and self.shared_ram:
            address, size = (int(x,16) for x in command[1:].split(','))
            from shared_ram import ram_offset
            if ram_offset(address,size) is not None:
                data = self.shared_ram.read(address,size)
                self.shared_bytes += len(data)
                return data.hex()
        if command[:1] in ('c','s','C','S','v','D','k'):
            self.stopped = False
        previous_timeout = self.s.gettimeout()
        if timeout is not None:
            self.s.settimeout(timeout)
        data = command.encode()
        try:
            self.s.sendall(b"$" + data + b"#" + self._sum(data))
            while True:
                response = self._receive_packet()
                # RSP console-output packets are asynchronous and may appear in
                # front of the requested reply.  Treat only O + valid hex as a
                # console packet; ordinary replies such as qXfer's `l...` remain
                # untouched.
                if (response.startswith("O") and len(response) > 1 and
                        len(response[1:]) % 2 == 0 and
                        all(ch in "0123456789abcdefABCDEF" for ch in response[1:])):
                    continue
                return response
        finally:
            if timeout is not None:
                self.s.settimeout(previous_timeout)

    def checkpoint(self, name: str, *, load: bool = False) -> None:
        """Project DuckStation extension; full state, paused target, no UI.

        Saving never overwrites. Loading clears this client's breakpoints;
        reinstall them before continuing. Requires the patched runtime.
        """
        if not name or len(name) > 64 or any(c not in
                'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_' for c in name):
            raise ValueError('Checkpoint name must be 1..64 ASCII letters, digits, hyphens or underscores')
        features = self.packet('qSupported')
        command = 'qFFLoadState' if load else 'qFFSaveState'
        if command + '+' not in features:
            raise RuntimeError('DuckStation does not advertise the full-state API extension')
        reply = self.packet(command + ':' + name.encode('ascii').hex(), timeout=60)
        if reply != 'OK':
            raise RuntimeError(f'{command} failed: {reply}')
        self.stopped = True

    def close(self) -> None:
        if self.shared_ram:
            self.shared_ram.close()
        self.s.close()

    def read_memory(self, address: int, size: int) -> bytes:
        from shared_ram import ram_offset
        if size < 0:
            raise ValueError('Negative memory size')
        if self.stopped and self.shared_ram and ram_offset(address,size) is not None:
            data = self.shared_ram.read(address,size)
            self.shared_bytes += len(data)
            return data
        return b''.join(bytes.fromhex(self.packet(f'm{address+o:x},{min(1024,size-o):x}'))
                        for o in range(0,size,1024))

    def send_no_reply(self, command: str) -> None:
        """Send a run-control packet whose reply arrives only at the next stop."""
        data = command.encode()
        self.stopped = False
        self.s.sendall(b"$" + data + b"#" + self._sum(data))

    def interrupt(self) -> str:
        self.s.sendall(b"\x03")
        return self._receive_packet()


def symbols(path: Path) -> dict[str, int]:
    result = {}
    with path.open(newline="", encoding="utf-8-sig") as f:
        for row in csv.DictReader(f):
            result[row["name"]] = int(row["address"], 16)
    return result


def decode_registers(data: str) -> dict[str, str]:
    names = (
        [f"r{i}" for i in range(32)]
        + ["status", "lo", "hi", "badvaddr", "cause", "pc"]
        + [f"f{i}" for i in range(32)] + ["fcsr", "fir", "unused"]
        + [
            "gte_v0_xy", "gte_v0_z", "gte_v1_xy", "gte_v1_z",
            "gte_v2_xy", "gte_v2_z", "gte_rgbc", "gte_otz",
            "gte_ir0", "gte_ir1", "gte_ir2", "gte_ir3",
            "gte_sxy0", "gte_sxy1", "gte_sxy2", "gte_sxyp",
            "gte_sz0", "gte_sz1", "gte_sz2", "gte_sz3",
            "gte_rgb0", "gte_rgb1", "gte_rgb2", "gte_res1",
            "gte_mac0", "gte_mac1", "gte_mac2", "gte_mac3",
            "gte_irgb", "gte_orgb", "gte_lzcs", "gte_lzcr",
            "gte_rt_0", "gte_rt_1", "gte_rt_2", "gte_rt_3", "gte_rt_4",
            "gte_trx", "gte_try", "gte_trz",
            "gte_llm_0", "gte_llm_1", "gte_llm_2", "gte_llm_3", "gte_llm_4",
            "gte_rbk", "gte_gbk", "gte_bbk",
            "gte_lcm_0", "gte_lcm_1", "gte_lcm_2", "gte_lcm_3", "gte_lcm_4",
            "gte_rfc", "gte_gfc", "gte_bfc", "gte_ofx", "gte_ofy", "gte_h",
            "gte_dqa", "gte_dqb", "gte_zsf3", "gte_zsf4", "gte_flag",
        ]
    )
    decoded = {}
    for index, name in enumerate(names):
        word = data[index * 8:index * 8 + 8]
        if len(word) == 8 and "x" not in word.lower():
            decoded[name] = f"0x{int.from_bytes(bytes.fromhex(word), 'little'):08X}"
    return decoded


