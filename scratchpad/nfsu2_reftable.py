import re

SRC = r"C:/Temp/nfs4-decomp/scratchpad/nfsu2_allmap.txt"
REF = r"C:/Users/Vyacheslav/.claude/projects/C--Temp-claud/memory/reference_nfs4_mobile_nfsu2.md"

# rows known to be false (cross-TU collisions / the Physics_Real attractor)
FALSE = {
    ("aih_basiccop.cpp", "0x4fa169"),   # = Newton_FindGroundElevationAndNormal
    ("aispeeds.cpp", "0x4d3a2e"),       # = AIPhysic_GetDesiredVector
    ("newton.cpp", "0x5037ea"),         # = Physics_CalculateDerivedCarSpecs
    ("newton.cpp", "0x53b19f"),         # IwHudUI band
    ("audiotrk.cpp", "0x4ddca0"),       # weak, single generic -- keep? mark tentative below instead
}

out = []
cur = None
for line in open(SRC, encoding='utf-8'):
    m = re.match(r'=== (\S+\.cpp) ', line)
    if m:
        cur = m.group(1)
        continue
    m = re.match(r'\s+(0x[0-9a-f]+)\s+(\S+)\s+score=(\d+) distinct=(\d+)', line)
    if not m:
        continue
    va, fn, sc, dst = m.groups()
    if va == '0x507fb4' and cur != 'physics.cpp':
        continue  # Physics_Real false attractor
    if (cur, va) in FALSE:
        continue
    tag = "" if int(sc) >= 40 else " (tentative)" if int(sc) < 25 else ""
    out.append((cur, va, fn, sc, dst, tag))

lines = ["", "## PER-FUNCTION ANCHOR VA TABLE (constant-fingerprint sweep, curated; "
         "false attractors removed; physics.cpp full table above supersedes its rows here)",
         "", "| module | PSX function | mobile VA | score/distinct |", "|---|---|---|---|"]
for cur, va, fn, sc, dst, tag in out:
    lines.append(f"| {cur} | {fn}{tag} | `sub_{va[2:].upper()}` | {sc}/{dst} |")
lines.append("")
lines.append("Raw sweep output: `C:\\Temp\\nfs4-decomp\\scratchpad\\nfsu2_allmap.txt` "
             "(84 rows incl. the removed false matches). aih_play rows all matched the "
             "same sub_51A5A0 = ambiguous within the 0x51A5A0-0x51B5B2 band.")

with open(REF, "a", encoding='utf-8', newline='') as f:
    f.write("\n".join(lines) + "\n")
print(f"appended {len(out)} anchor rows to reference")
