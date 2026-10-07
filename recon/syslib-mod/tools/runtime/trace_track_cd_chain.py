#!/usr/bin/env python3
"""Trace the CD/EAC callback chain from a pre-Track_Init checkpoint."""

import argparse
import collections
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
VECTOR = 0x80000080
SCRATCH = 0x801F0000
sys.path.insert(0, str(RUNTIME))
os.environ.setdefault("FF_GDB_RAM_BACKEND", "auto")
from gdb_remote import Remote, decode_registers


def reg(remote, number):
    return int.from_bytes(bytes.fromhex(remote.packet(f"p{number:x}")), "little")


def setreg(remote, number, value):
    remote.packet(f"P{number:x}=" + struct.pack("<I", value).hex())


def wait(remote, timeout):
    remote.s.settimeout(timeout)
    try:
        while True:
            packet = remote._receive_packet()
            if packet[:1] in ("T", "S"):
                return
    finally:
        remote.s.settimeout(3)


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--cue", type=Path, required=True)
    ap.add_argument("--map", type=Path, required=True)
    ap.add_argument("--checkpoint", required=True)
    ap.add_argument("--timeout", type=int, default=60)
    args = ap.parse_args()
    text = args.map.read_text(encoding="latin-1")
    syms = {m.group(2): int(m.group(1), 16)
            for m in re.finditer(r"^ ([0-9A-F]{8}) (\S+)\s*$", text, re.M)}
    watch = {
        VECTOR: "exception",
        syms["CD_init"] + 0x540: "_cd_intr_dispatch",
        syms["CD_Read"] - 0x9D4: "CdReadyHandler",
        syms["initasync"] - 0x430: "loadfilereadcallback",
        syms["savegp"]: "savegp",
        syms["restoregp"]: "restoregp",
    }
    startup = subprocess.STARTUPINFO()
    startup.dwFlags |= subprocess.STARTF_USESHOWWINDOW
    startup.wShowWindow = 7
    process = subprocess.Popen([str(DUCKSTATION), "-batch", "-fastboot", str(args.cue.resolve())],
                               cwd=DUCKSTATION.parent, startupinfo=startup)
    remote = None
    history = collections.deque(maxlen=100)
    counts = collections.Counter()
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
        track_return = reg(remote, 31)
        watch[track_return] = "Track_Init:return"
        for address in watch:
            remote.packet(f"Z0,{address:x},4")
        deadline = time.time() + args.timeout
        while time.time() < deadline:
            remote.send_no_reply("c")
            wait(remote, max(1, int(deadline - time.time())))
            pc = reg(remote, 37)
            name = watch.get(pc, "unexpected")
            cause = reg(remote, 36)
            code = (cause >> 2) & 31
            row = {
                "name": name, "pc": f"{pc:08X}", "gp": f"{reg(remote,28):08X}",
                "sp": f"{reg(remote,29):08X}", "ra": f"{reg(remote,31):08X}",
                "a0": f"{reg(remote,4):08X}", "a1": f"{reg(remote,5):08X}",
                "a2": f"{reg(remote,6):08X}", "cause_code": code,
            }
            history.append(row)
            counts[name] += 1
            if name == "Track_Init:return":
                print(json.dumps({"completed": True, "counts": counts,
                                  "history": list(history)}, indent=2))
                return
            if name == "exception" and code == 4:
                bad = reg(remote, 35)
                registers = remote.packet("g")
                saved = remote.read_memory(SCRATCH, 8)
                remote.packet(f"M{SCRATCH:x},8:{struct.pack('<2I', 0x40027000, 0).hex()}")
                setreg(remote, 37, SCRATCH)
                remote.packet("s", timeout=10)
                remote.packet("s", timeout=10)
                epc = reg(remote, 2)
                remote.packet("G" + registers)
                remote.packet(f"M{SCRATCH:x},8:{saved.hex()}")
                print(json.dumps({"counts": counts, "badvaddr": f"{bad:08X}",
                                  "epc": f"{epc:08X}", "history": list(history)}, indent=2))
                return
            remote.packet(f"z0,{pc:x},4")
            remote.packet("s", timeout=10)
            remote.packet(f"Z0,{pc:x},4")
        raise RuntimeError("target exception not reached")
    finally:
        if remote is not None:
            try:
                remote.close()
            except Exception:
                pass
        process.kill()


if __name__ == "__main__":
    main()
