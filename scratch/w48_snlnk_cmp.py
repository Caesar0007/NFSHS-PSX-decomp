# -*- coding: utf-8 -*-
# Minimal SN LNK v2 .OBJ parser: extract per-section code + XDEF symbols,
# slice a function's words, compare vs the expected ELF object's words
# (reloc-field-masked). Purpose: validate the real-ASPSX delay-slot theory.
import io, struct, subprocess, sys, re

import os
OBJ = os.environ.get("SNOBJ", r"C:\Temp\nfs4-decomp\scratch\rtl_a5\pad_aspsx.obj")
ELF = os.environ.get("SNELF", r"C:\Temp\nfs4-decomp\expected\src\eaclib\psx\pad.c.o")
OBJDUMP = r"C:\Tools\mips-ps1\mips\bin\mipsel-none-elf-objdump.exe"
FNS = os.environ.get("SNFNS", "padinit,PAD_state,PAD_convert,PAD_restore").split(",")

d = open(OBJ, "rb").read()
assert d[:3] == b"LNK", d[:8]
p = 4  # skip 'LNK' + version byte? ('LNK'=3 bytes, ver=1 byte)
cur_sec = None
code = {}      # sec -> bytearray
symbols = {}   # name -> (sec, off)
relocs = {}    # sec -> set(offsets)

def u8():
    global p; v = d[p]; p += 1; return v
def u16():
    global p; v = struct.unpack_from("<H", d, p)[0]; p += 2; return v
def u32():
    global p; v = struct.unpack_from("<I", d, p)[0]; p += 4; return v
def name():
    n = u8(); global p; s = d[p:p+n].decode("latin1"); p += n; return s

def skip_expr():
    t = u8()
    if t == 0:    u32()          # constant
    elif t == 2:  u16()          # symbol xref index
    elif t == 4:  u16()          # sectbase
    elif t == 12: u16()          # sectstart?
    elif t == 22: u16()          # sectend?
    elif t in (44, 50, 54, 46, 36, 38, 40, 42, 32, 34):  # binary ops
        skip_expr(); skip_expr()
    elif t in (10, 16, 18, 20, 24, 26, 28, 30):
        skip_expr(); skip_expr()
    else:
        raise SystemExit("unknown expr tag %d @%d" % (t, p-1))

while p < len(d):
    tag = u8()
    if tag == 0:      # EOF
        break
    elif tag == 2:    # code
        n = u16()
        code.setdefault(cur_sec, bytearray()).extend(d[p:p+n]); p += n
    elif tag == 6:    # switch section
        cur_sec = u16()
    elif tag == 8:    # uninit (bss advance)
        u32()
    elif tag == 10:   # reloc: type u8, offset u16, expr
        u8(); off = u16(); skip_expr()
        relocs.setdefault(cur_sec, set()).add(off)
    elif tag == 12:   # xdef: symnum u16, sec u16, off u32, name
        u16(); sec = u16(); off = u32(); nm = name()
        symbols[nm] = (sec, off)
    elif tag == 14:   # xref: symnum u16, name
        u16(); name()
    elif tag == 16:   # section: num u16, group u16, align u8, name
        u16(); u16(); u8(); name()
    elif tag == 18:   # local sym
        u16(); u32(); name()
    elif tag == 28:   # FILE: u16 index + name (verified by hex dump)
        u16(); name()
    elif tag == 80:   # SLD advance 0
        pass
    elif tag == 82:   # SLD inc by byte
        u8()
    elif tag == 84:   # SLD inc by word
        u16()
    elif tag == 86:   # SLD set line (u32)
        u32()
    elif tag == 88:   # SLD set file+line
        u16(); u32()
    elif tag == 48:   # BSS/SBSS symbol def: symnum u16, sec u16, size u32, name
        u16(); u16(); u32(); name()
    elif tag == 46:   # processor type: u8
        u8()
    elif tag == 60:   # FUNCTION debug start (present only with -g; skip fields)
        u16(); u32(); u16(); u32(); u16(); u32(); u16(); u32(); u32(); name()
    elif tag == 62:   # FUNCTION end
        u16(); u32(); u32()
    elif tag == 64:   # BLOCK start
        u16(); u32(); u32()
    elif tag == 66:   # BLOCK end
        u16(); u32(); u32()
    else:
        raise SystemExit("unknown tag %d @%d" % (tag, p-1))

print("sections with code:", {k: len(v) for k, v in code.items()})
print("symbols:", {k: v for k, v in symbols.items() if not k.startswith("__")})

# expected ELF side
out = subprocess.run([OBJDUMP, "-d", ELF], capture_output=True, text=True).stdout
def elf_words(fn):
    m = re.search(r"<%s>:\n(.*?)(?:\n\n|\Z)" % re.escape(fn), out, re.S)
    if not m:
        return None
    words = []
    for line in m.group(1).splitlines():
        mm = re.match(r"\s*[0-9a-f]+:\s+([0-9a-f]{8})\s", line)
        if mm:
            words.append(int(mm.group(1), 16))
    return words

# fn order in the SN obj: sort xdefs in the code section by offset to find spans
csec = max(code, key=lambda k: len(code[k]))
fn_offs = sorted([(off, nm) for nm, (sec, off) in symbols.items() if sec == csec])
spans = {}
for i, (off, nm) in enumerate(fn_offs):
    end = fn_offs[i+1][0] if i+1 < len(fn_offs) else len(code[csec])
    spans[nm] = (off, end)

rel = relocs.get(csec, set())
MASKS = {  # opcode-dependent reloc field masks
}
def masked(w, byteoff):
    # if a reloc targets this word, mask the low 16 bits (hi16/lo16) or 26 (jal)
    if byteoff in rel:
        op = w >> 26
        return w & (0xFC000000 if op in (2, 3) else 0xFFFF0000)
    return w

for fn in FNS:
    if fn not in spans:
        print(fn, ": not in SN obj (static? different name)"); continue
    a, b = spans[fn]
    sn = [struct.unpack_from("<I", code[csec], o)[0] for o in range(a, b, 4)]
    snm = [masked(w, a + i*4) for i, w in enumerate(sn)]
    ew = elf_words(fn)
    if ew is None:
        print(fn, ": not in expected ELF"); continue
    em = [masked(w, a + i*4) for i, w in enumerate(ew)]  # same mask offsets
    n = min(len(snm), len(em))
    diff = [i for i in range(n) if snm[i] != em[i]]
    print("%s: ASPSX %d insns vs oracle %d; masked-diff %d %s"
          % (fn, len(sn), len(ew), len(diff),
             ("at " + ",".join(str(x) for x in diff[:8])) if diff else "== BYTE-EXACT"))
    if fn == "padinit" and diff:
        for i in range(max(len(snm), len(em))):
            a_ = "%08x" % snm[i] if i < len(snm) else "--------"
            b_ = "%08x" % em[i] if i < len(em) else "--------"
            print("  %2d  aspsx %s   oracle %s %s" % (i, a_, b_, "  <<<" if (i >= len(em) or i >= len(snm) or snm[i] != em[i]) else ""))
