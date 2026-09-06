"""Read-only P867 corroboration of nfs4_data.txt transport ranges.

This does NOT infer original object boundaries or C storage sizes from chunks.
Named rows are derived from SYM, not independent CPE type/name information.
The frontend is checked separately: NFS4.CPE holds its reserved zero hole,
whereas rom/nfs4-f.exe contains the merged frontend overlay.
No compiler, binary, source, reference, or build configuration is modified.
"""

import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
import re
import struct


def parse_loads(data):
    if data[:4] != b"CPE\x01":
        raise ValueError("Unexpected CPE signature/version")
    pos = 4
    loads = {}
    commands = Counter()
    while pos < len(data):
        cmd = data[pos]
        commands[str(cmd)] += 1
        if cmd == 0:
            if pos + 1 != len(data):
                raise ValueError("Unexpected bytes after CPE EOF")
            return loads, commands
        if cmd == 1:
            if pos + 9 > len(data):
                raise ValueError("Truncated CPE load header")
            va, size = struct.unpack_from("<II", data, pos + 1)
            end = pos + 9 + size
            if end > len(data) or (va, size) in loads:
                raise ValueError("Truncated or duplicate CPE load extent")
            loads[va, size] = data[pos + 9:end]
        else:
            # CPE command lengths include the opcode; 03..06 carry a
            # 16-bit register selector followed by a 4/2/1/3-byte value.
            width = {2: 5, 3: 7, 4: 5, 5: 4, 6: 6, 7: 5, 8: 2}.get(cmd)
            if width is None:
                raise ValueError("Unknown CPE command %d at 0x%x" % (cmd, pos))
            end = pos + width
            if end > len(data):
                raise ValueError("Truncated CPE metadata")
        pos = end
    raise ValueError("Missing CPE EOF")


def main():
    root = Path(__file__).resolve().parents[2]
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--cpe", type=Path, default=Path(r"C:\Temp\nfs4-clean\NFS4.CPE"))
    parser.add_argument("--map", type=Path, default=Path(r"C:\Temp\nfs4-clean\nfs4_data.txt"))
    parser.add_argument("--rom", type=Path, default=root / "rom/nfs4-f.exe")
    args = parser.parse_args()
    cpe = args.cpe.read_bytes()
    rom = args.rom.read_bytes()
    map_bytes = args.map.read_bytes()
    if rom[:8] != b"PS-X EXE":
        raise ValueError("Expected merged PS-X EXE oracle")
    load_va, load_size = struct.unpack_from("<II", rom, 0x18)
    loads, commands = parse_loads(cpe)
    pattern = re.compile(r"^(\d+)-CPE\s+0x([0-9A-Fa-f]+)\s+0x([0-9A-Fa-f]+)\s+(\d+)\s+(\S+)")
    sections = Counter()
    checked_bytes = 0
    failures = []
    seen = set()
    for line in map_bytes.decode("utf-8-sig").splitlines():
        match = pattern.match(line)
        if not match:
            if re.match(r"^\d+-CPE\b", line):
                raise ValueError("Unparsed CPE map row: " + line)
            continue
        num, va, size, decimal, section = match.groups()
        va, size = int(va, 16), int(size, 16)
        if num in seen or size != int(decimal):
            raise ValueError("Duplicate row or inconsistent size: " + num)
        seen.add(num)
        sections[section] += 1
        payload = loads.get((va, size))
        if payload is None:
            failures.append({"row": num, "reason": "no exact CPE load extent"})
            continue
        offset = va - load_va + 0x800
        if va < load_va or va + size > load_va + load_size or offset + size > len(rom):
            failures.append({"row": num, "reason": "outside executable load extent"})
            continue
        different = sum(a != b for a, b in zip(payload, rom[offset:offset + size]))
        checked_bytes += size
        if different:
            failures.append({"row": num, "reason": "payload mismatch", "bytes": different})
    if not seen:
        raise ValueError("No CPE map rows parsed")
    reservation = loads.get((0x80010000, 0x44D90))
    report = {
        "scope": "numbered CPE rows only; no declaration/ownership/full-image proof",
        "sha256": {str(path): hashlib.sha256(data).hexdigest()
                   for path, data in ((args.cpe, cpe), (args.map, map_bytes), (args.rom, rom))},
        "cpe_commands": dict(commands),
        "cpe_load_records": len(loads),
        "map_rows": len(seen),
        "map_sections": dict(sections),
        "payload_bytes_checked": checked_bytes,
        "failures": failures,
        "reserved_overlay_range": "[0x80010000,0x80054D90)",
        "reserved_overlay_zero_bytes": (len(reservation) if reservation is not None
                                        and not any(reservation) else None),
    }
    print(json.dumps(report, indent=2))
    return 1 if failures else 0


if __name__ == "__main__":
    raise SystemExit(main())
