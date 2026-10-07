#!/usr/bin/env python3
"""Boot a compact-libcd image and capture the first non-interrupt exception EPC."""

import argparse
import json
import os
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


def reg(remote: Remote, number: int) -> int:
    return int.from_bytes(bytes.fromhex(remote.packet(f"p{number:x}")), "little")


def setreg(remote: Remote, number: int, value: int) -> None:
    if remote.packet(f"P{number:x}=" + struct.pack("<I", value).hex()) != "OK":
        raise RuntimeError("register write failed")


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
    parser.add_argument("--timeout", type=int, default=300)
    parser.add_argument("--code", type=int, default=4, help="CP0 exception code to capture")
    parser.add_argument("--checkpoint", help="optional DuckStation checkpoint to load before tracing")
    args = parser.parse_args()

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
        if args.checkpoint:
            remote.checkpoint(args.checkpoint, load=True)
        saved_scratch = remote.read_memory(SCRATCH, 8)
        if remote.packet(f"Z0,{VECTOR:x},4") != "OK":
            raise RuntimeError("exception-vector breakpoint rejected")

        events = 0
        deadline = time.time() + args.timeout
        while time.time() < deadline:
            remote.send_no_reply("c")
            wait_stop(remote, max(1, int(deadline - time.time())))
            cause = reg(remote, 36)
            code = (cause >> 2) & 31
            events += 1
            if code != args.code:
                remote.packet(f"z0,{VECTOR:x},4")
                remote.packet("s", timeout=10)
                remote.packet(f"Z0,{VECTOR:x},4")
                continue

            registers = remote.packet("g")
            bad = reg(remote, 35)
            pc = reg(remote, 37)
            probe = struct.pack("<2I", 0x40027000, 0)  # mfc0 v0,$14 (EPC); nop
            remote.packet(f"M{SCRATCH:x},8:{probe.hex()}")
            setreg(remote, 37, SCRATCH)
            remote.packet("s", timeout=10)
            remote.packet("s", timeout=10)
            epc = reg(remote, 2)
            remote.packet("G" + registers)
            remote.packet(f"M{SCRATCH:x},8:{saved_scratch.hex()}")
            decoded = decode_registers(registers)
            print(json.dumps({
                "events": events,
                "vector_pc": f"{pc:08X}",
                "cause": f"{cause:08X}",
                "code": code,
                "badvaddr": f"{bad:08X}",
                "epc": f"{epc:08X}",
                "registers": {key: decoded.get(key) for key in ("r28", "r29", "r31", "pc")},
            }, indent=2))
            return
        raise RuntimeError("no non-interrupt exception before timeout")
    finally:
        if remote is not None:
            try:
                remote.packet(f"z0,{VECTOR:x},4")
            except Exception:
                pass
            try:
                remote.close()
            except Exception:
                pass
        process.kill()


if __name__ == "__main__":
    main()
