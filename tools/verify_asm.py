#!/usr/bin/env python3
"""verify_asm.py CPP FUNC[,FUNC...] — compile a recon .cpp (cc1plus+maspsx) and diff each
named function against its asm/nonmatchings/main/<FUNC>.s oracle (spimdisasm format).
Reloc-name + branch-target lenient. Prints PASS/diff per function."""
import re, sys, subprocess
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent
MIPS = Path(r'C:/Tools/mips-ps1/mips/bin')
OBJD = str(MIPS / 'mipsel-none-elf-objdump.exe')

cpp = ROOT / sys.argv[1]
funcs = sys.argv[2].split(',')

# compile via build.py's compile_cpp
import importlib.util
spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
bld = importlib.util.module_from_spec(spec); spec.loader.exec_module(bld)
bld.OUT = bld.BUILD
obj = bld.compile_cpp(cpp)
dis = subprocess.run([OBJD, '-d', '-r', '-z', str(obj)], capture_output=True, text=True).stdout

_COP0 = {'sr':'12','status':'12','cause':'13','epc':'14','badvaddr':'8','prid':'15','index':'0',
         'random':'1','entrylo':'2','context':'4','config':'16','bpc':'3','bda':'5','dcic':'7','bdam':'9','bpcm':'11'}

def norm_ins(t):
    t = re.sub(r'\s+', ' ', t.strip())
    t = t.replace('$', '')                                    # drop $ on regs (oracle has them, objdump doesn't)
    t = re.sub(r'\bs8\b', 'fp', t)                            # $30 aliases: objdump=s8, oracle=fp (same reg)
    t = re.sub(r',\s+', ',', t)                               # normalize space after commas
    t = re.sub(r'0x([0-9a-fA-F]+)', lambda m: str(int(m.group(1),16)), t)  # hex->dec (case-insens)
    # `break` code/param: objdump omits code 0 (prints bare `break`) while the oracle .s prints
    # `break 0`; and `break 0, N` vs `break N`. Canonicalize: strip ALL operands that are 0,
    # keeping only nonzero ones (the real BIOS/SN call id). So `break`==`break 0`==`break 0,0`,
    # and `break 0,259`==`break 259` (byte-identical; same artifact as the move/li normalizers).
    m = re.match(r'^break\b(.*)$', t)
    if m:
        ops = [o for o in re.split(r'[ ,]+', m.group(1).strip()) if o and o != '0']
        t = 'break' + ((' ' + ','.join(ops)) if ops else '')
    m = re.match(r'^syscall\b(.*)$', t)              # objdump `syscall` == oracle `syscall 0` (code 0)
    if m:
        ops = [o for o in re.split(r'[ ,]+', m.group(1).strip()) if o and o != '0']
        t = 'syscall' + ((' ' + ','.join(ops)) if ops else '')
    t = re.sub(r'\bc0_(\w+)\b', lambda mm: _COP0.get(mm.group(1), mm.group(0)), t)  # objdump cop0 reg-names -> $N numbers (oracle uses $12 etc.)
    t = re.sub(r'\((\d+) ?>> ?(\d+)\)', lambda m: str(int(m.group(1))>>int(m.group(2))), t)  # eval (N>>M)
    t = re.sub(r'\((\d+) ?& ?(\d+)\)', lambda m: str(int(m.group(1))&int(m.group(2))), t)     # eval (N&M)
    t = re.sub(r'%hi\([^)]*\)', '0', t)            # %hi(SYM) -> 0 (objdump shows lui r,0)
    t = re.sub(r'%lo\([^)]*\)', '0', t)            # %lo(SYM) -> 0
    t = re.sub(r'%gp_rel\([^)]*\)', '0', t)        # %gp_rel(SYM) -> 0
    t = re.sub(r'^move (\w+),(\w+)$', r'addu \1,\2,zero', t)   # objdump move idiom -> addu
    # normalize load-immediate idioms BOTH ways -> `li reg,N` (objdump shows `li`;
    # oracle .s shows addiu/ori reg,zero,N depending on the value's sign-range)
    t = re.sub(r'^(?:addiu|ori) (\w+),zero,(\-?\d+)$', r'li \1,\2', t)
    # branch/jump target masking (handles objdump `38 <f+20>`, oracle `.Lxxx`, `funcname`)
    m = re.match(r'(beq|bne)\s+(\w+,\w+),', t)
    if m: return f"{m.group(1)} {m.group(2)},T"
    m = re.match(r'(b\w+z|bgez|blez|bgtz|bltz)\s+(\w+),', t)
    if m: return f"{m.group(1)} {m.group(2)},T"
    m = re.match(r'(j|jal|b)\s+', t)
    if m: return f"{m.group(1)} T"
    return t

def base(n):
    # Normalize a call-target symbol to its function BASE name so benign naming
    # differences don't read as a wrong callee: strip the C++ free-fn param-signature
    # mangling (`BWAllocMem__Fi` == `__Fl`), and the splat synthetic VA suffix
    # (`CD_init_80108140` -> `CD_init`). A genuine wrong-FUNCTION call (`fastintcos`
    # vs `intcos`) survives this and is what we want to surface.
    n = re.sub(r'__F.*$', '', n)
    n = re.sub(r'_8[0-9a-fA-F]{7}$', '', n)
    return n

def ours(fn):
    # Collect the function's raw objdump lines (instructions + the reloc lines that
    # objdump -r interleaves AFTER each relocated instruction).
    lines=[]; inb=False
    for ln in dis.splitlines():
        m=re.match(r'^[0-9a-f]{8} <(.+)>:',ln)
        if m:
            if inb: break
            inb=(m.group(1)==fn); continue
        if inb: lines.append(ln)
    out=[]; calls=[]
    for i,ln in enumerate(lines):
        mm=re.match(r'^\s*[0-9a-f]+:\t[0-9a-f]+\s*\t(.*)',ln)
        if not mm: continue
        insn=mm.group(1)
        # A R_MIPS_LO16 reloc on this instruction means the displacement/immediate is
        # a relocation ADDEND (our object is UNLINKED). The oracle is LINKED + re-split
        # by splat, which folds that addend into a per-address symbol -> `%lo(SYM)` which
        # we already normalize to 0. So zero OUR addend too: `simGlobal+4` reloc (objdump
        # `lw r,4(b)`) is byte-identical after link to the oracle's `lw r,%lo(D_…+4)(b)`.
        # (Symmetric with the existing reloc-name leniency; HI16 already shows 0 in objdump.)
        nxt = lines[i+1] if i+1 < len(lines) else ''
        # CALL-TARGET capture (reloc-aware): a jal/j's real target is the R_MIPS_26 reloc
        # symbol (external), or — for a `.text` reloc (same-object call/jump) — the resolved
        # `<name+off>` objdump annotation. Skip intra-fn jumps + self-recursion (base==self).
        op = insn.split()[0] if insn.split() else ''
        if op in ('jal','j'):
            rel = re.search(r'R_MIPS_26\s+(\S+)', nxt)
            tgt = None
            if rel and rel.group(1) != '.text':
                tgt = base(rel.group(1))
            else:
                ann = re.search(r'<([^>+]+)', insn)
                if ann: tgt = base(ann.group(1))
            if tgt and tgt != base(fn): calls.append(tgt)
        if 'R_MIPS_LO16' in nxt:
            insn = re.sub(r',\s*-?(?:0x)?[0-9a-fA-F]+\(', ',0(', insn)   # lw rD,N(base) -> 0(base)
            insn = re.sub(r',\s*-?(?:0x)?[0-9a-fA-F]+$', ',0', insn)     # addiu/ori rD,rS,N -> ,0
        out.append(norm_ins(insn))
    return out, calls

def oracle(fn):
    p = ROOT / 'asm' / 'nonmatchings' / 'main' / (fn + '.s')
    if not p.exists():
        p = ROOT / 'asm' / 'nonmatchings' / 'front' / (fn + '.s')   # front overlay segment
    if not p.exists(): return None
    out=[]; calls=[]
    for ln in p.read_text().splitlines():
        ln = re.sub(r'/\*.*?\*/', '', ln)                     # strip /* addr hex */ comments
        s = ln.strip()
        if s.startswith('endlabel'):
            break                                              # fn ends here; trailing align-nops/data are NOT the fn
        if not s or s.startswith(('.','glabel','nonmatching','dlabel','jlabel')) or s.startswith('.L') or s.endswith(':'):
            continue
        m = re.match(r'(jal|j)\s+(\S+)', s)                    # oracle names its call targets directly
        if m and not m.group(2).startswith('.L'):
            b = base(m.group(2))
            if b != base(fn): calls.append(b)
        out.append(norm_ins(s))
    return out, calls

allpass=True
from collections import Counter
for fn in funcs:
    o=ours(fn); e=oracle(fn)
    if e is None: print(f"  {fn}: NO ORACLE"); allpass=False; continue
    oi,oc=o; ei,ec=e
    if not oi: print(f"  {fn}: NOT IN OBJECT"); allpass=False; continue
    d=[l for l in __import__('difflib').unified_diff(oi,ei,lineterm='') if l[0] in '+-' and not l.startswith(('+++','---'))]
    callmis = Counter(oc) != Counter(ec)                       # normalized jal/j callee multiset differs
    if not d and not callmis:
        print(f"  {fn}: PASS ({len(oi)} insns)")
    elif not d and callmis:                                    # insns byte-match but a CALL goes elsewhere (leniency gap)
        allpass=False
        extra=sorted((Counter(oc)-Counter(ec)).elements()); miss=sorted((Counter(ec)-Counter(oc)).elements())
        print(f"  {fn}: FAIL call-target (insns match) — ours {extra} vs oracle {miss}")
    else:
        allpass=False; print(f"  {fn}: FAIL {len(d)} diffs (ours {len(oi)} / oracle {len(ei)})")
        for l in d[:12]: print("      "+l)
        if callmis:
            extra=sorted((Counter(oc)-Counter(ec)).elements()); miss=sorted((Counter(ec)-Counter(oc)).elements())
            print(f"      [+ call-target: ours {extra} vs oracle {miss}]")
sys.exit(0 if allpass else 1)
