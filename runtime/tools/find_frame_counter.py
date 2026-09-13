#!/usr/bin/env python3
"""find_frame_counter.py -- locate a per-frame counter via live shared-RAM sampling.

Reads the 2 MiB RAM three times (no CPU stops) with a fixed wall gap, and
reports words that increase LINEARLY (delta1==delta2, small positive) -- i.e.
a value that ticks a fixed amount per frame.  The best candidate keys the
shared-memory recorder's tape.
"""
import sys, time, struct
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from shared_ram import SharedRAM

def snap(sr):
    return sr.read(0x80000000, 0x200000)

def main():
    sr = SharedRAM('127.0.0.1', 2350)
    a = snap(sr); time.sleep(1.0)
    b = snap(sr); time.sleep(1.0)
    c = snap(sr)
    sr.close()
    cands = []
    for off in range(0, 0x200000, 4):
        wa = struct.unpack_from('<I', a, off)[0]
        wb = struct.unpack_from('<I', b, off)[0]
        wc = struct.unpack_from('<I', c, off)[0]
        d1 = (wb - wa) & 0xFFFFFFFF
        d2 = (wc - wb) & 0xFFFFFFFF
        if d1 == d2 and 0 < d1 < 5000 and wa < 0x08000000:
            cands.append((off, wa, d1))
    cands.sort(key=lambda x: x[2])
    print(f'{len(cands)} linear-increment words (delta1==delta2, ~per-frame):')
    for off, wa, d in cands[:40]:
        print(f'  0x{0x80000000+off:08X}: start {wa} delta {d}/sec')
    # heuristic: a 60Hz frame counter increments ~60/sec; a vsync ~50/60
    print('\nlikely 1x-per-frame counters (delta 55..75):')
    for off, wa, d in cands:
        if 55 <= d <= 75:
            print(f'  0x{0x80000000+off:08X}: start {wa} delta {d}')

if __name__ == '__main__':
    main()
