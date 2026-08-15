#!/usr/bin/env python3
"""W66-A6: LAND the "=0 pair" lever on audiocmn's .sdata run (no restore).

Same transform probe_zeroinit.py gates; writes it permanently.
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import probe_zeroinit as P  # noqa: E402

if __name__ == "__main__":
    orig = P.SRC.read_bytes()
    new, n = P.patch(orig.decode("utf-8"))
    assert n == 32, n
    P.write_bytes(P.SRC, new.encode("utf-8"))
    assert P.SRC.read_bytes() != orig
    print("[landed] %d initialisers" % n)
