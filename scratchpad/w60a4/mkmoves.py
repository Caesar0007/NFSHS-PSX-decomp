#!/usr/bin/env python3
"""Emit a PER_FN_TEXT_MOVES probe JSON for the W60-A4 libcd rows.

Usage:  python mkmoves.py <which> <outfile>
  which = getintr | cdcontrol
Regexes are written here as raw strings so no shell quoting can eat a backslash.
"""
import json
import sys

GETINTR = {
    "recon/syslib/psx/libcd/drv.c": {
        "CD_get_intr": [
            # case 4: retail materializes the _memcpy8 DEST before the Intr base.
            {"take": r"\tla\t\$2,D_8013C224\n(?= \#APP\n \#NO_APP\n\tla\t\$4,D_801489AC\n)",
             "after": r"\tla\t\$4,D_801489AC\n"},
            # case 5: same swap.
            {"take": r"\tla\t\$2,D_8013C224\n(?= \#APP\n \#NO_APP\n\tla\t\$4,D_8014899C\n)",
             "after": r"\tla\t\$4,D_8014899C\n"},
        ]
    }
}

CDCONTROL = {
    "recon/syslib/psx/libcd/cdcont.c": {
        "CdControl": [
            {"take": r"\tsw\t\$20,32\(\$sp\)\n\taddu\t\$20,\$4,\$0\n",
             "after": r"\taddu\t\$18,\$6,\$0\n"},
        ]
    }
}

TABLES = {"getintr": GETINTR, "cdcontrol": CDCONTROL}

which, out = sys.argv[1], sys.argv[2]
open(out, "w").write(json.dumps(TABLES[which], indent=1))
print(open(out).read())
