#!/usr/bin/env python3
"""Load a pre-Track_Init checkpoint and capture a compact-libcd stall."""

import argparse
import bisect
import json
import os
import re
import struct
import subprocess
import sys
import time
from pathlib import Path

RUNTIME = Path(r"C:\Temp\nfs4-runtime")
DUCKSTATION = RUNTIME / "duckstation" / "duckstation-qt-x64-ReleaseLTCG.exe"
sys.path.insert(0, str(RUNTIME))
os.environ.setdefault("FF_GDB_RAM_BACKEND", "auto")
from gdb_remote import Remote, decode_registers


def reg(remote, number):
    return int.from_bytes(bytes.fromhex(remote.packet(f"p{number:x}")), "little")


def setreg(remote, number, value):
    if remote.packet(f"P{number:x}=" + struct.pack("<I", value).hex()) != "OK":
        raise RuntimeError("register write failed")


def symbols(path):
    text = path.read_text(encoding="latin-1")
    return {m.group(2): int(m.group(1), 16)
            for m in re.finditer(r"^ ([0-9A-F]{8}) (\S+)\s*$", text, re.M)}


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--cue", type=Path, required=True)
    ap.add_argument("--map", type=Path, required=True)
    ap.add_argument("--checkpoint", required=True)
    ap.add_argument("--seconds", type=int, default=30)
    args = ap.parse_args()
    syms = symbols(args.map)
    ordered = sorted((value, name) for name, value in syms.items())
    addresses = [value for value, _ in ordered]

    def symbolise(value):
        index = bisect.bisect_right(addresses, value) - 1
        if index >= 0 and 0x80010000 <= value < 0x80200000:
            base, name = ordered[index]
            return f"{name}+0x{value - base:X}"
        return f"0x{value:08X}"

    startup = subprocess.STARTUPINFO()
    startup.dwFlags |= subprocess.STARTF_USESHOWWINDOW
    startup.wShowWindow = 7
    process = subprocess.Popen([str(DUCKSTATION), "-batch", "-fastboot", str(args.cue.resolve())],
                               cwd=DUCKSTATION.parent, startupinfo=startup)
    remote = None
    try:
        for _ in range(150):
            try:
                remote = Remote("127.0.0.1", 2350)
                break
            except OSError:
                time.sleep(0.2)
        if remote is None:
            raise RuntimeError("DuckStation GDB port did not open")
        remote.packet("qSupported")
        remote.checkpoint(args.checkpoint, load=True)
        remote.send_no_reply("c")
        time.sleep(args.seconds)
        remote.interrupt()
        time.sleep(0.25)
        raw_registers = remote.packet("g")
        decoded = decode_registers(raw_registers)
        pc, ra, sp = (reg(remote, n) for n in (37, 31, 29))
        scratch = 0x801F0000
        saved_scratch = remote.read_memory(scratch, 8)
        remote.packet(f"M{scratch:x},8:{struct.pack('<2I', 0x40027000, 0).hex()}")
        setreg(remote, 37, scratch)
        remote.packet("s", timeout=10)
        remote.packet("s", timeout=10)
        epc = reg(remote, 2)
        remote.packet("G" + raw_registers)
        remote.packet(f"M{scratch:x},8:{saved_scratch.hex()}")
        state = {}
        for name in ("CD_com", "CD_status", "CD_cbready", "CD_cbsync", "Intr",
                     "CD_info", "CD_timeout", "CD_completionCallback", "D_801234E8"):
            if name not in syms:
                continue
            address = syms[name]
            state[name] = {
                "address": f"{address:08X}",
                "bytes": remote.read_memory(address, 16).hex(),
            }
        stack = []
        if 0x80000000 <= sp < 0x80200000:
            words = struct.unpack("<128I", remote.read_memory(sp, 512))
            stack = [symbolise(value) for value in words
                     if 0x80010000 <= value < 0x80200000][:32]
        print(json.dumps({
            "pc": f"{pc:08X}", "pc_symbol": symbolise(pc),
            "ra": f"{ra:08X}", "ra_symbol": symbolise(ra),
            "sp": f"{sp:08X}",
            "cause": decoded.get("cause"), "epc": f"{epc:08X}",
            "epc_symbol": symbolise(epc),
            "badvaddr": decoded.get("badvaddr"), "gp": decoded.get("r28"),
            "cd_state": state, "stack_code_pointers": stack,
        }, indent=2))
    finally:
        if remote is not None:
            try:
                remote.close()
            except Exception:
                pass
        process.kill()


if __name__ == "__main__":
    main()
