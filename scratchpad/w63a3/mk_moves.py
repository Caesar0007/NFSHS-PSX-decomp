#!/usr/bin/env python3
"""Emit the W63-A3 PER_FN_TEXT_MOVES JSON spec (regex strings, no heredocs)."""
import json
from pathlib import Path

ROW = {
    "recon/syslib/psx/libgpu/FONT.c": {
        "FntPrint": [
            {"take": r"\tli\t\$6,-1[^\n]*\n",
             "after": r"\tbeq\t\$5,\$2,\$L\d+\n"},
        ],
    },
}
p = Path(r"C:/Temp/nfs4-decomp/scratchpad/w63a3/moves_fntprint.json")
p.write_text(json.dumps(ROW, indent=1), encoding="utf-8", newline="")
print(p.read_text(encoding="utf-8"))
