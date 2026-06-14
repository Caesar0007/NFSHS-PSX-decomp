#!/usr/bin/env python3
"""Auto-match relocation-only functions (set/return a global) header-free.

objdiff is relocation-aware: it compares a reloc's *target symbol*, not the
resolved gp-offset/address. So `extern int G; void f(void){ G = 0; }` emits
`sw $zero, %gp_rel(G)` whose reloc points at G — matching the target object's
reloc to G, with NO need to place G correctly. This unlocks the many trivial
"set global" / "return global" functions without any struct/header environment.

Patterns recognised (whole function, ignoring nops):
  set global 0 (gp):     sw $zero,%gp_rel(G)            ; jr ra
  return global (gp):    lw $v0,%gp_rel(G)             ; jr ra
  set global 0 (lui):    lui $at,%hi(G); sw $zero,%lo(G)($at) ; jr ra
  return global (lui):   lui $v0,%hi(G); lw $v0,%lo(G)($v0)   ; jr ra

Splices candidates, rebuilds, keeps ONLY objdiff-verified matches (reverts the
rest back to INCLUDE_ASM), so imperfect guesses do no harm.
"""
import json
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
ASM = ROOT / "asm" / "nonmatchings" / "main"
MAIN = ROOT / "src" / "main.c"
PY = sys.executable
OBJDIFF = Path(r"C:/Temp/objdiff/objdiff-cli.exe")
INSTR = re.compile(r'/\* \w+ \w+ [0-9A-Fa-f]{8} \*/\s+(\S+)\s*(.*)$')


def insns(text):
    out = []
    for line in text.splitlines():
        m = INSTR.search(line)
        if m:
            out.append((m.group(1), m.group(2).replace(' ', '')))
    return [(o, a) for o, a in out if o != 'nop']


def decode(ins):
    """Return (c_stmt, [globals]) or None. c_stmt is the body line(s)."""
    ops = [o for o, _ in ins]
    if not ops or ops[-1] != 'jr':
        return None
    body = ins[:-1]  # drop jr ra
    # gp set 0
    if len(body) == 1:
        o, a = body[0]
        m = re.match(r'\$zero,%gp_rel\((\w+)\)$', a)
        if o == 'sw' and m:
            return (f"    {m.group(1)} = 0;", [m.group(1)])
        m = re.match(r'\$v0,%gp_rel\((\w+)\)$', a)
        if o == 'lw' and m:
            return (f"    return {m.group(1)};", [m.group(1)], 'int')
    # lui/lo set 0
    if len(body) == 2:
        (o0, a0), (o1, a1) = body
        m0 = re.match(r'\$at,%hi\((\w+)\)$', a0)
        m1 = re.match(r'\$zero,%lo\((\w+)\)\(\$at\)$', a1)
        if o0 == 'lui' and o1 == 'sw' and m0 and m1 and m0.group(1) == m1.group(1):
            return (f"    {m0.group(1)} = 0;", [m0.group(1)])
        m0 = re.match(r'\$v0,%hi\((\w+)\)$', a0)
        m1 = re.match(r'\$v0,%lo\((\w+)\)\(\$v0\)$', a1)
        if o0 == 'lui' and o1 == 'lw' and m0 and m1 and m0.group(1) == m1.group(1):
            return (f"    return {m0.group(1)};", [m0.group(1)], 'int')
    return None


def main():
    src0 = MAIN.read_text()
    still = set(re.findall(r'INCLUDE_ASM\("asm/nonmatchings/main", (\w+)\);', src0))
    cands = {}  # sym -> (stmt, globals, rettype)
    globs = set()
    for s in sorted(ASM.glob("*.s")):
        sym = s.name[:-2]
        if sym not in still:
            continue
        d = decode(insns(s.read_text()))
        if not d:
            continue
        stmt, gl = d[0], d[1]
        rt = d[2] if len(d) > 2 else 'void'
        cands[sym] = (stmt, gl, rt)
        globs.update(gl)
    if not cands:
        print("no candidates"); return
    # build src with extern block + all candidate bodies
    extern = "/* auto_reloc externs */\n" + "".join(f"extern int {g};\n" for g in sorted(globs))
    src = src0
    for sym, (stmt, gl, rt) in cands.items():
        body = f"{rt} {sym}(void) {{\n{stmt}\n}}"
        src = re.sub(r'^INCLUDE_ASM\("asm/nonmatchings/main", ' + re.escape(sym) + r'\);\s*$',
                     lambda m: body, src, count=1, flags=re.M)
    src = src.replace('#include "common.h"', '#include "common.h"\n' + extern, 1)
    MAIN.write_text(src)
    print(f"spliced {len(cands)} candidates ({len(globs)} externs); building...")
    r = subprocess.run([PY, "tools/build.py", "--skip-asm"], cwd=ROOT,
                       capture_output=True, text=True)
    if r.returncode:
        print("BUILD FAILED, reverting:\n", r.stdout[-1500:], r.stderr[-1500:])
        MAIN.write_text(src0); return
    subprocess.run([str(OBJDIFF), "report", "generate", "-p", ".",
                    "-o", "build/report.json", "-f", "json"], cwd=ROOT,
                   capture_output=True, text=True)
    rep = json.load(open(ROOT / "build" / "report.json"))
    u = rep["units"][0]
    matched = {f["name"] for f in u["functions"] if f.get("fuzzy_match_percent", 0) == 100.0}
    keep = {s for s in cands if s in matched}
    # revert non-matching candidates back to INCLUDE_ASM; trim unused externs
    src = src0
    used = set()
    for sym, (stmt, gl, rt) in cands.items():
        if sym in keep:
            body = f"{rt} {sym}(void) {{\n{stmt}\n}}"
            src = re.sub(r'^INCLUDE_ASM\("asm/nonmatchings/main", ' + re.escape(sym) + r'\);\s*$',
                         lambda m: body, src, count=1, flags=re.M)
            used.update(gl)
    extern = "/* auto_reloc externs */\n" + "".join(f"extern int {g};\n" for g in sorted(used))
    src = src.replace('#include "common.h"', '#include "common.h"\n' + extern, 1)
    MAIN.write_text(src)
    print(f"kept {len(keep)} verified matches (of {len(cands)} tried)")


if __name__ == "__main__":
    main()
