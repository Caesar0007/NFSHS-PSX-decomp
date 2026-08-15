#!/usr/bin/env python3
"""Emit the W63-A3 SYS.c _dws PER_FN_TEXT_MOVES probe spec."""
import json
from pathlib import Path

ROW = {
    "recon/syslib/psx/libgpu/SYS.c": {
        "_dws": [
            {"take": r"\tli\t\$4,-1\t[^\n]*\n",
             "after": r"\tbeq\t\$16,\$2,\$L\d+\n"},
        ],
    },
}
p = Path(r"C:/Temp/nfs4-decomp/scratchpad/w63a3/moves_dws.json")
p.write_text(json.dumps(ROW, indent=1), encoding="utf-8", newline="")
print(p.read_text(encoding="utf-8"))
