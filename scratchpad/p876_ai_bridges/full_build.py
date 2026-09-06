"""Run both ordinary full-build lanes with the established source-only gate.

Only in-memory diagnostic settings are adjusted, exactly as verify_asm.py does:
keep per-TU identities and permitted vendor compiler identities, disable other
function-specific interventions. No production tool or emitted output is edited.
"""
from pathlib import Path
import os
import sys

ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools'))
import build as b

os.environ['NFS4_STRICT']='1'
for name,table in vars(b).items():
    if not (name.startswith('PER_FN_') and isinstance(table,dict)):
        continue
    if name=='PER_FN_CC1_VER_SPLICE_272':
        continue
    if name=='PER_FN_CC1_VER_SPLICE':
        for source in list(table):
            if not source.startswith('recon/syslib/') and source!='recon/eaclib/psx/pad.c':
                del table[source]
        continue
    table.clear()
b.main()
