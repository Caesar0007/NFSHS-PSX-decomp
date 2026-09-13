#!/usr/bin/env python3
"""checkpoint.py -- save/load a full DuckStation state over GDB (patched runtime).

Usage:
  py -3.14 runtime/tools/checkpoint.py save <name>
  py -3.14 runtime/tools/checkpoint.py load <name>

Names are 1-64 ASCII [A-Za-z0-9_-]; files land in the runtime's savestates
dir as ff-audit-<name>.sav.  Saving never overwrites; loading clears GDB
breakpoints (reinstall yours).  CPU must be stoppable; it is left stopped.
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from gdb_remote import Remote

PORT = 2350

def main():
    op, name = sys.argv[1], sys.argv[2]
    g = Remote('127.0.0.1', PORT)
    try:
        try:
            r = g.packet('?', timeout=2)
            if r.startswith(('S', 'T')):
                g.stopped = True
            else:
                g.interrupt()
        except (TimeoutError, OSError):
            g.interrupt()
        g.checkpoint(name, load=(op == 'load'))
        print(f'{op} {name}: OK (CPU left stopped; send c to resume)')
    finally:
        g.close()

if __name__ == '__main__':
    main()
