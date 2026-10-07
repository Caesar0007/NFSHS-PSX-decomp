#!/usr/bin/env python3
"""Trace compact-libcd boot entries in a relinked Route-D image."""

import argparse
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
from gdb_remote import Remote, decode_registers


def symbols(path: Path):
    text = path.read_text(encoding="latin-1")
    return {
        match.group(2): int(match.group(1), 16)
        for match in re.finditer(r"^ ([0-9A-F]{8}) (\S+)\s*$", text, re.M)
    }


def register(remote: Remote, number: int) -> int:
    return int.from_bytes(bytes.fromhex(remote.packet(f"p{number:x}")), "little")


def wait_stop(remote: Remote, timeout: int):
    remote.s.settimeout(timeout)
    try:
        while True:
            packet = remote._receive_packet()
            if packet[:1] in ("T", "S"):
                return packet
    finally:
        remote.s.settimeout(3)


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--cue", type=Path, required=True)
    parser.add_argument("--map", type=Path, required=True)
    parser.add_argument("--exe", type=Path, required=True)
    parser.add_argument("--timeout", type=int, default=120)
    parser.add_argument("--minimal", action="store_true", help="break only at CdInit and PAD_update return")
    args = parser.parse_args()

    table = symbols(args.map)
    image = args.exe.read_bytes()
    load = struct.unpack_from("<I", image, 0x18)[0]
    pad_update = table["PAD_update"]
    offset = 0x800 + pad_update - load
    pad_return = next(
        pad_update + index
        for index in range(0, 0x400, 4)
        if struct.unpack_from("<I", image, offset + index)[0] == 0x03E00008
    )
    names = (
        "CdInit",
        "CD_init",
        "CD_initvol",
        "CD_initintr",
        "CD_sync",
        "CD_ready",
        "CD_cw",
        "_cd_intr_dispatch",
    )
    if args.minimal:
        names = ("CdInit",)
    watched = {table[name]: name for name in names}
    watched[pad_return] = "PAD_update:return"

    startup = subprocess.STARTUPINFO()
    startup.dwFlags |= subprocess.STARTF_USESHOWWINDOW
    startup.wShowWindow = 7
    process = subprocess.Popen(
        [str(DUCKSTATION), "-batch", "-fastboot", str(args.cue)],
        cwd=DUCKSTATION.parent,
        startupinfo=startup,
    )
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
        for address in watched:
            if remote.packet(f"Z0,{address:x},4") != "OK":
                raise RuntimeError(f"breakpoint rejected at {address:08X}")

        counts = {name: 0 for name in watched.values()}
        deadline = time.time() + args.timeout
        while time.time() < deadline:
            remote.send_no_reply("c")
            try:
                wait_stop(remote, max(1, int(deadline - time.time())))
            except TimeoutError:
                break
            pc = register(remote, 37)
            name = watched.get(pc)
            if name is None:
                print(f"unexpected stop pc={pc:08X}")
                break
            counts[name] += 1
            print(f"{name:20s} count={counts[name]} pc={pc:08X} sp={register(remote,29):08X} ra={register(remote,31):08X}")
            if name == "PAD_update:return":
                break
            remote.packet(f"z0,{pc:x},4")
            remote.packet("s", timeout=10)
            remote.packet(f"Z0,{pc:x},4")
        else:
            pc = register(remote, 37)
            print(f"deadline pc={pc:08X}")

        remote.interrupt()
        decoded = decode_registers(remote.packet("g"))
        print("final", {key: decoded.get(key) for key in
              ("pc", "r29", "r31", "cause", "epc", "badvaddr", "r37", "r38", "r39")})
        print("register_keys", sorted(decoded))
        print("counts", counts)
    finally:
        if remote is not None:
            try:
                remote.close()
            except Exception:
                pass
        process.kill()


if __name__ == "__main__":
    main()
