#!/usr/bin/env python3
"""Dump named debug records retained in an SN-LNK object.

This is intentionally a scratch audit companion rather than a modification to
tools/objtruth.py.  Opcodes 0x40/0x42 carry named debug declarations; retaining
their offsets lets us test whether stripped/local function spellings survive in
the canonical PsyQ object even when they are not XDEF rows in INDEX.tsv.
"""

from __future__ import annotations

import struct
import sys
from pathlib import Path


def u16(data: bytes, pos: int) -> tuple[int, int]:
    return struct.unpack_from("<H", data, pos)[0], pos + 2


def u32(data: bytes, pos: int) -> tuple[int, int]:
    return struct.unpack_from("<I", data, pos)[0], pos + 4


def name(data: bytes, pos: int) -> tuple[str, int]:
    length = data[pos]
    pos += 1
    return data[pos : pos + length].decode("ascii", "replace"), pos + length


def parse_expr(data: bytes, pos: int) -> int:
    opcode = data[pos]
    pos += 1
    if opcode == 0x00:
        return pos + 4
    if opcode in (0x02, 0x04, 0x0C, 0x16):
        return pos + 2
    if opcode in (0x2C, 0x2E, 0x30, 0x32):
        return parse_expr(data, parse_expr(data, pos))
    raise ValueError(f"expression opcode 0x{opcode:02X} at {pos - 1}")


def records(path: Path):
    data = path.read_bytes()
    if data[:4] != b"LNK\x02":
        raise ValueError("not an SN-LNK v2 object")
    pos = 4
    while pos < len(data):
        opcode = data[pos]
        pos += 1
        if opcode == 0x00:
            break
        if opcode == 0x02:
            length, pos = u16(data, pos)
            pos += length
        elif opcode == 0x06:
            pos += 2
        elif opcode == 0x08:
            pos += 4
        elif opcode == 0x0A:
            pos += 3
            pos = parse_expr(data, pos)
        elif opcode == 0x0C:
            sym, pos = u16(data, pos)
            section, pos = u16(data, pos)
            offset, pos = u32(data, pos)
            record_name, pos = name(data, pos)
            yield opcode, sym, section, offset, record_name
        elif opcode == 0x0E:
            sym, pos = u16(data, pos)
            record_name, pos = name(data, pos)
            yield opcode, sym, 0, 0, record_name
        elif opcode == 0x10:
            pos += 5
            _section_name, pos = name(data, pos)
        elif opcode == 0x12:
            section, pos = u16(data, pos)
            offset, pos = u32(data, pos)
            record_name, pos = name(data, pos)
            yield opcode, 0, section, offset, record_name
        elif opcode in (0x14, 0x30):
            sym, pos = u16(data, pos)
            section, pos = u16(data, pos)
            size, pos = u32(data, pos)
            record_name, pos = name(data, pos)
            yield opcode, sym, section, size, record_name
        elif opcode == 0x1C:
            pos += 2
            _file_name, pos = name(data, pos)
        elif opcode == 0x2E:
            pos += 1
        elif opcode == 0x32:
            pos += 2
        elif opcode == 0x34:
            pos += 2
            _name, pos = name(data, pos)
        elif opcode == 0x36:
            pos += 4
        elif opcode == 0x38:
            pos += 18
            _name, pos = name(data, pos)
        elif opcode in (0x3A, 0x3C, 0x3E):
            pos += 10
        elif opcode == 0x40:
            sym, pos = u16(data, pos)
            offset, pos = u32(data, pos)
            section, pos = u16(data, pos)
            type_index, pos = u16(data, pos)
            size, pos = u32(data, pos)
            record_name, pos = name(data, pos)
            yield opcode, sym, section, offset, record_name
        elif opcode == 0x42:
            sym, pos = u16(data, pos)
            offset, pos = u32(data, pos)
            section, pos = u16(data, pos)
            type_index, pos = u16(data, pos)
            size, pos = u32(data, pos)
            dims, pos = u16(data, pos)
            pos += dims * 4
            record_name, pos = name(data, pos)
            yield opcode, sym, section, offset, record_name
        elif opcode == 0x44:
            pos += 2
            _name, pos = name(data, pos)
        elif opcode == 0x46:
            pos += 6
        elif opcode == 0x48:
            pos += 1
        elif opcode == 0x4C:
            pos += 3
        else:
            raise ValueError(f"object opcode 0x{opcode:02X} at {pos - 1}")


def main() -> int:
    for arg in sys.argv[1:]:
        path = Path(arg)
        print(f"== {path} ==")
        for opcode, sym, section, value, record_name in records(path):
            if opcode in (0x40, 0x42):
                print(
                    f"op{opcode:02X} sym={sym:04X} sect={section:04X} "
                    f"value=0x{value:X} {record_name}"
                )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
