#!/usr/bin/env python3
"""Load a packaged-image startup checkpoint and exercise its overlay file API.

This is a focused loader smoke test.  It calls the injected MIPS routine through
DuckStation's GDB stub, verifies its return value and validates the loaded map and
captured snapshot against the host-side artifacts.
"""
import argparse
import hashlib
import json
import os
import struct
import sys
from pathlib import Path

RT_TOOLS = Path(r'C:\Temp\nfs4-runtime')
sys.path.insert(0, str(RT_TOOLS))
os.environ.setdefault('FF_GDB_RAM_BACKEND', 'auto')
from gdb_remote import Remote

RETURN_SENTINEL = 0x800A41A8


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def set_reg(remote, number, value):
    reply = remote.packet(f'P{number:x}=' + struct.pack('<I', value & 0xFFFFFFFF).hex())
    if reply != 'OK':
        raise RuntimeError(f'register write r{number}: {reply}')


def get_reg(remote, number):
    return int.from_bytes(bytes.fromhex(remote.packet(f'p{number:x}')), 'little')


def write_memory(remote, address, data):
    for offset in range(0, len(data), 512):
        part = data[offset:offset + 512]
        reply = remote.packet(f'M{address + offset:x},{len(part):x}:{part.hex()}')
        if reply != 'OK':
            raise RuntimeError(f'memory write {address + offset:#x}: {reply}')


def wait_stop(remote, timeout=15):
    remote.s.settimeout(timeout)
    try:
        while True:
            packet = remote._receive_packet()
            if packet[:1] in ('S', 'T'):
                return packet
    finally:
        remote.s.settimeout(3)


def call(remote, address, args):
    if len(args) > 4:
        raise ValueError('only o32 register arguments are supported')
    for index, value in enumerate(args):
        set_reg(remote, 4 + index, value)
    set_reg(remote, 31, RETURN_SENTINEL)
    set_reg(remote, 37, address)
    if remote.packet(f'Z0,{RETURN_SENTINEL:x},4') != 'OK':
        raise RuntimeError('return breakpoint rejected')
    remote.send_no_reply('c')
    wait_stop(remote)
    pc = get_reg(remote, 37)
    remote.packet(f'z0,{RETURN_SENTINEL:x},4')
    if pc != RETURN_SENTINEL:
        raise RuntimeError(f'call stopped at {pc:#x}, expected {RETURN_SENTINEL:#x}')
    return get_reg(remote, 2)


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--startup-report', type=Path, required=True)
    p.add_argument('--image-report', type=Path, required=True)
    p.add_argument('--output', type=Path, required=True)
    p.add_argument('--memory-only', action='store_true',
                   help='upload the map and call SyslibMod_SaveDynamic without EAC file I/O')
    a = p.parse_args()
    if a.output.exists():
        p.error('output must not already exist')
    startup = json.loads(a.startup_report.read_text())
    image = json.loads(a.image_report.read_text())
    if not startup.get('passed') or startup.get('image_report_sha256') != sha(a.image_report):
        raise ValueError('startup report is not a passing run bound to this image report')
    candidate = next(x for x in startup['records'] if x['role'] == 'candidate')
    record_path = Path(candidate['record_path'])
    record = json.loads(record_path.read_text(encoding='utf-8-sig'))
    if sha(record['image']) != record['image_sha256'] or record['image_sha256'] != image['image_sha256']:
        raise ValueError('running candidate/image identity mismatch')
    symbols = {name: int(value, 16) for name, value in image['loader_symbols'].items()}
    name_address = int(image['name_buffer'], 16)
    work_address = int(image['work_buffer']['address'], 16)
    work_size = image['work_buffer']['size']
    snapshot_address = int(image['snapshot']['address'], 16)
    snapshot_size = image['snapshot']['size']
    remote = Remote('127.0.0.1', record['port'])
    try:
        remote.packet('qSupported')
        remote.checkpoint(candidate['checkpoint'], load=True)
        expected_map = Path(r'C:\Temp\nfs4-syslib-pair\overlay\SYSLIB.DYN').read_bytes()
        if a.memory_only:
            write_memory(remote, work_address, expected_map)
            function = 'SyslibMod_SaveDynamic'
            result = call(remote, symbols[function], [work_address, snapshot_address])
        else:
            filename = image['dynamic_file'].encode('ascii') + b'\0'
            write_memory(remote, name_address, filename)
            function = 'SyslibMod_SaveDynamicFile'
            result = call(remote, symbols[function],
                          [name_address, work_address, work_size, snapshot_address])
        work = remote.read_memory(work_address, work_size)
        snapshot = remote.read_memory(snapshot_address, snapshot_size)
        report = {
            'schema': 'nfs4-syslib-overlay-api-smoke-v1',
            'passed': result == snapshot_size and work == expected_map and len(snapshot) == snapshot_size,
            'function': function,
            'return_value': result,
            'expected_return': snapshot_size,
            'map_equal': work == expected_map,
            'map_sha256': hashlib.sha256(work).hexdigest(),
            'snapshot_size': len(snapshot),
            'snapshot_sha256': hashlib.sha256(snapshot).hexdigest(),
            'startup_report_sha256': sha(a.startup_report),
            'image_report_sha256': sha(a.image_report),
        }
    finally:
        remote.close()
    a.output.mkdir(parents=True)
    (a.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n', encoding='utf-8')
    print(json.dumps(report, indent=2))
    return 0 if report['passed'] else 1


if __name__ == '__main__':
    raise SystemExit(main())
