#!/usr/bin/env python3
"""verify_asm.py CPP FUNC[,FUNC...] — compile a recon .cpp (cc1plus+maspsx) and diff each
named function against its asm/nonmatchings/main/<FUNC>.s oracle (spimdisasm format).
Reloc-name + branch-target lenient. Prints PASS/diff per function."""
import os, re, sys, subprocess
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
obj = bld.compile_c(cpp, skip_asm=False) if cpp.suffix == '.c' else bld.compile_cpp(cpp)
dis = subprocess.run([OBJD, '-d', '-r', '-z', str(obj)], capture_output=True, text=True).stdout

# Alias resolution: several XDEF names can share ONE address (a nullsub with N co-equal entry
# points, or rdiv/fixeddiv-style co-equal pairs). objdump -d labels the disassembly with the
# ALPHABETICALLY-FIRST symbol at the address, so a request for a non-alpha-first CANONICAL name
# (setclipwindow, intcos, rdiv) would miss it. Map name->addr (objdump -t) and addr->disasm label,
# then diff the block at the requested symbol's address whatever objdump happened to name it.
_symtab = subprocess.run([OBJD, '-t', str(obj)], capture_output=True, text=True).stdout
_name2addr = {}
for _ln in _symtab.splitlines():
    # Skip UNDEFINED (`*UND*`) and file/abs (`*ABS*`) symbols: an undefined extern decl has a
    # bogus address 00000000 that would otherwise alias-resolve to whatever real function objdump
    # labels at offset 0 (false PASS/FAIL). Only DEFINED symbols (real section) get an addr entry.
    if '*UND*' in _ln or '*ABS*' in _ln:
        continue
    _t = _ln.split()
    if len(_t) >= 2 and re.match(r'^[0-9a-f]{8}$', _t[0]):
        _name2addr[_t[-1]] = _t[0]
_addr2label = {}
for _ln in dis.splitlines():
    _m = re.match(r'^([0-9a-f]{8}) <(.+)>:', _ln)
    if _m:
        _addr2label.setdefault(_m.group(1), _m.group(2))
def _resolve(fn):
    a = _name2addr.get(fn)
    return _addr2label.get(a, fn) if a else fn

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
    # LITERAL-ADDRESS PSEUDO-LABELS: spimdisasm sometimes auto-names a hardcoded constant as
    # a synthetic `D_<hex>` data label. This includes PSX scratchpad addresses (0x1F80xxxx)
    # and short, unmapped values such as D_100FF; neither can be a relocatable executable
    # symbol (the image is linked in KSEG0). Resolve those literals before the blanket
    # %hi/%lo->0 handling below, while leaving eight-digit KSEG0 labels reloc-normalized.
    # Values outside KSEG0 are constants too: notably spimdisasm turns -0x62FFFF into
    # D_FF9D0001 in R3DCar_CalcCarDimensions even though the raw `lui 0xFF9D` / `addiu 1`
    # pair contains no address relocation.
    def _literal_dlabel(m):
        digits = m.group(1)
        addr = int(digits, 16)
        return addr, len(digits) < 8 or not (0x80000000 <= addr < 0xA0000000)
    def _dlabel_lo(m):
        addr, is_literal = _literal_dlabel(m)
        return str(addr & 0xFFFF) if is_literal else '0'
    def _dlabel_hi(m):
        addr, is_literal = _literal_dlabel(m)
        return str(addr >> 16) if is_literal else '0'
    t = re.sub(r'%lo\(D_([0-9A-Fa-f]{1,8})\)', _dlabel_lo, t)
    t = re.sub(r'%hi\(D_([0-9A-Fa-f]{1,8})\)', _dlabel_hi, t)
    t = re.sub(r'%hi\([^)]*\)', '0', t)            # %hi(SYM) -> 0 (objdump shows lui r,0)
    t = re.sub(r'%lo\([^)]*\)', '0', t)            # %lo(SYM) -> 0
    t = re.sub(r'%gp_rel\([^)]*\)', '0', t)        # %gp_rel(SYM) -> 0
    t = re.sub(r'^move (\w+),(\w+)$', r'addu \1,\2,zero', t)   # objdump move idiom -> addu
    # hand-asm `or rd,zero,rs`/`or rd,rs,zero`/`or rd,zero,zero` is a reg-move / zero-load: spimdisasm
    # (oracle .s) renders it raw as `or`, while objdump aliases the SAME bytes to `move` -> addu (above).
    # Normalize the or-move forms to the same `addu rd,rs,zero` canonical (mirrors the move rule; purely
    # additive -- ours always aliases to move, so an oracle-side raw `or`-move otherwise always false-diffs).
    t = re.sub(r'^or (\w+),zero,(\w+)$', r'addu \1,\2,zero', t)
    t = re.sub(r'^or (\w+),(\w+),zero$', r'addu \1,\2,zero', t)
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

def ours(fn):
    # Collect the function's raw objdump lines (instructions + the reloc lines that
    # objdump -r interleaves AFTER each relocated instruction).
    fn = _resolve(fn)                 # follow aliases to the block objdump actually labeled
    lines=[]; inb=False
    for ln in dis.splitlines():
        m=re.match(r'^[0-9a-f]{8} <(.+)>:',ln)
        if m:
            if inb: break
            inb=(m.group(1)==fn); continue
        if inb: lines.append(ln)
    out=[]
    for i,ln in enumerate(lines):
        mm=re.match(r'^\s*[0-9a-f]+:\t([0-9a-f]+)\s*\t(.*)',ln)
        if not mm: continue
        word=mm.group(1); insn=mm.group(2)
        # GTE compute op (rtps/rtpt/nclip/mvmva/...): objdump prints `c2 0xNNN` (cofun only).
        # The oracle .s encodes the SAME op as `.word 0x4Annnnnn` (spimdisasm can't name it).
        # Match by the RAW 32-bit instruction word (byte-identical) instead of the rendering.
        if re.match(r'c(?:op)?2\b', insn):
            out.append('cop2 '+word); continue
        # A R_MIPS_LO16 (or R_MIPS_GPREL16) reloc on this instruction means the
        # displacement/immediate is a relocation ADDEND (our object is UNLINKED). The oracle
        # is LINKED + re-split by splat, which folds that addend into a per-address symbol ->
        # `%lo(SYM)` / `%gp_rel(SYM)` which we already normalize to 0. So zero OUR addend too:
        # `simGlobal+4` reloc (objdump `lw r,4(b)`) is byte-identical after link to the oracle's
        # `lw r,%lo(D_…+4)(b)`. GPREL16 case: a CVECTOR `.g`/`.b` field store `sb v0,1(gp)`
        # (R_MIPS_GPREL16 vs base, addend 1 in the immediate) links to the SAME word as the
        # oracle's `sb v0,%gp_rel(D_…39D)(gp)` (splat's synthetic per-byte gp symbol) -- verified
        # by hand on R3DCcar_ReadTrackShadow (oracle 0xA3820E50..56 == ours after link).
        # (Symmetric with the existing reloc-name leniency; HI16 already shows 0 in objdump.)
        nxt = lines[i+1] if i+1 < len(lines) else ''
        if 'R_MIPS_LO16' in nxt or 'R_MIPS_GPREL16' in nxt:
            insn = re.sub(r',\s*-?(?:0x)?[0-9a-fA-F]+\(', ',0(', insn)   # lw rD,N(base) -> 0(base)
            insn = re.sub(r',\s*-?(?:0x)?[0-9a-fA-F]+$', ',0', insn)     # addiu/ori rD,rS,N -> ,0
        out.append(norm_ins(insn))
    return out

def _exists_exact(p: Path) -> bool:
    """Path.exists() is CASE-INSENSITIVE on this NTFS checkout -- a lookup for
    'cd_read.s' silently resolves to the unrelated 'CD_Read.s' (wrong oracle:
    the real cd_read oracle is func_800F9984.s), and 'CD_init.s' resolves to
    'CD_Init.s' instead of the true 'CD_init_80108140.s'. Both are REAL,
    differently-named functions that happen to case-fold to the same string,
    so silently accepting either one produces a false PASS/FAIL against the
    wrong bytes. Require the resolved directory entry's on-disk name to match
    byte-for-byte (Python str '==' is case-sensitive regardless of OS)."""
    return p.exists() and p.name in {e.name for e in p.parent.iterdir()}


_SYMBOL_ADDRS = None
def _symbol_addrs():
    """configs/symbol_addrs.txt: `NAME = 0xVA; // type:func` per line -- the
    project's authoritative name<->address map (methodology gotcha 0b)."""
    global _SYMBOL_ADDRS
    if _SYMBOL_ADDRS is None:
        _SYMBOL_ADDRS = {}
        p = ROOT / 'configs' / 'symbol_addrs.txt'
        if p.exists():
            for ln in p.read_text().splitlines():
                m = re.match(r'^(\w+)\s*=\s*0x([0-9A-Fa-f]+)\s*;', ln.strip())
                if m:
                    _SYMBOL_ADDRS[m.group(1)] = int(m.group(2), 16)
    return _SYMBOL_ADDRS


def _find_oracle_path(fn):
    """Resolve a function NAME to its oracle .s path. The naive 'fn + .s' guess
    fails two ways, both discovered via the NTFS case-insensitivity bug
    (_exists_exact above): (1) splat sometimes leaves a function's oracle file
    under its address-only name (func_800F9984.s holds `glabel cd_read`) when
    the name was assigned to symbol_addrs.txt AFTER the initial split; (2) a
    lowercase/uppercase name COLLISION (CD_init vs CD_Init) makes splat append
    the VA to one side's filename (CD_init_80108140.s) to keep them apart on a
    case-preserving-but-insensitive filesystem. Both are resolved by going
    through configs/symbol_addrs.txt's name->VA map rather than trusting the
    filename to equal the requested identifier."""
    segs = ('main', 'front')
    # 1) direct case-exact name match (the common case).
    for seg in segs:
        p = ROOT / 'asm' / 'nonmatchings' / seg / (fn + '.s')
        if _exists_exact(p):
            return p
    # 2) VA-based fallbacks, via symbol_addrs.txt.
    addrs = _symbol_addrs()
    va_candidates = []
    if fn in addrs:
        va_candidates.append(addrs[fn])
    else:
        # disambiguated variant: some OTHER name in symbol_addrs.txt of the
        # form `fn_XXXXXXXX` (case-collision suffix, e.g. CD_init_80108140
        # for requested fn=CD_init).
        pat = re.compile(r'^' + re.escape(fn) + r'_[0-9A-Fa-f]{8}$')
        for name, va in addrs.items():
            if pat.match(name):
                va_candidates.append(va)
    for va in va_candidates:
        for seg in segs:
            for cand in (f'{fn}_{va:08X}', f'func_{va:08X}'):
                p = ROOT / 'asm' / 'nonmatchings' / seg / (cand + '.s')
                if _exists_exact(p):
                    return p
    return None


def oracle(fn):
    p = _find_oracle_path(fn)
    if p is None:
        return None
    out=[]
    for ln in p.read_text().splitlines():
        ln = re.sub(r'/\*.*?\*/', '', ln)                     # strip /* addr hex */ comments
        s = ln.strip()
        if s.startswith('endlabel'):
            break                                              # fn ends here; trailing align-nops/data are NOT the fn
        # GTE compute op encoded as a raw word (opcode bits == COP2 0x12): treat as an
        # instruction, matched by its raw word (symmetric with the `cop2 <word>` ours-side).
        mw = re.match(r'\.word\s+0x([0-9a-fA-F]+)\b', s)
        if mw and (int(mw.group(1),16) >> 26) == 0x12:
            out.append('cop2 ' + mw.group(1).lower()); continue
        if not s or s.startswith(('.','glabel','nonmatching','dlabel','jlabel','alabel')) or s.startswith('.L') or s.endswith(':'):
            continue
        out.append(norm_ins(s))
    return out

allpass=True
for fn in funcs:
    o=ours(fn); e=oracle(fn)
    if e is None: print(f"  {fn}: NO ORACLE"); allpass=False; continue
    if not o: print(f"  {fn}: NOT IN OBJECT"); allpass=False; continue
    d=[l for l in __import__('difflib').unified_diff(o,e,lineterm='') if l[0] in '+-' and not l.startswith(('+++','---'))]
    if not d: print(f"  {fn}: PASS ({len(o)} insns)")
    else:
        allpass=False; print(f"  {fn}: FAIL {len(d)} diffs (ours {len(o)} / oracle {len(e)})")
        for l in d[:int(os.environ.get("VA_MAX","12"))]: print("      "+l)
sys.exit(0 if allpass else 1)
