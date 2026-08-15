"""W64-A6 -- OBJDUMP SEMANTICS PROOF for the CdRead PER_FN_TEXT_MOVES row (15D).

Lays the SPLICED object beside the retail words decoded from the oracle .s comment
column (`/* FOFF VA WORD */` -- "the comment column IS the retail byte truth", the
strict_branch.py principle).  Four legs:

 (1) instruction COUNT and word-by-word identity.  A word diff is classified as a
     RELOC SITE only where `objdump -dr` actually prints a relocation ON THAT ADDRESS
     (the anti-vacuity rule from 12H: never classify by mnemonic).
 (2) DELAY-SLOT proof -- the _padInitDirSeq dead-code trap.  The insn immediately
     after `jal CdSyncCallback` must be the SAME word in both streams, i.e. the store
     really sits in the executed slot and was not parked after it.
 (3) CONDITIONAL-BRANCH words (no relocation, PC-relative) must match EXACTLY.
 (4) Intra-.text `j`/`jal` (R_MIPS_26 against `.text`) -- compare the target's offset
     RELATIVE TO THE FUNCTION START against retail's (target VA - fn VA).  This is the
     leg verify_asm is blind to (it normalises every target to `T`).

Usage: python scratchpad/w64a6/tm_objproof.py <objfile> [FUNC] [FN_VA_hex]
"""
import re, struct, subprocess, sys, pathlib

ROOT = pathlib.Path(r"C:\Temp\nfs4-decomp")
OBJD = r"C:\Tools\mips-ps1\mips\bin\mipsel-none-elf-objdump.exe"
obj = sys.argv[1]
fn = sys.argv[2] if len(sys.argv) > 2 else "CdRead"

dis = subprocess.run([OBJD, "-d", "-r", "-z", obj], capture_output=True, text=True).stdout
mfn = re.search(r"^([0-9a-f]+) <%s>:\n(.*?)(?=\n[0-9a-f]+ <|\Z)" % re.escape(fn),
                dis, re.S | re.M)
assert mfn, "function %s not in %s" % (fn, obj)
fn_off = int(mfn.group(1), 16)
ours, rel = [], {}
for ln in mfn.group(2).split("\n"):
    m = re.match(r"\s*([0-9a-f]+):\s+([0-9a-f]{8})\s+(.*)", ln)
    if m:
        ours.append((int(m.group(1), 16), int(m.group(2), 16), m.group(3).split(";")[0].strip()))
        continue
    r = re.match(r"\s*([0-9a-f]+):\s+(R_MIPS_\S+)\s+(\S+)", ln)
    if r:
        rel[int(r.group(1), 16)] = (r.group(2), r.group(3))

osrc = (ROOT / "asm" / "nonmatchings" / "main" / (fn + ".s")).read_text(errors="replace")
retail = []
for m in re.finditer(r"/\* [0-9A-Fa-f]+ ([0-9A-Fa-f]{8}) ([0-9A-Fa-f]{8}) \*/\s*(.*)", osrc):
    w = struct.unpack("<I", bytes.fromhex(m.group(2)))[0]
    retail.append((int(m.group(1), 16), w, m.group(3).strip()))
fn_va = retail[0][0]

ok = True
print("== leg 1: count + words")
print("   insn count: ours %d  retail %d   %s"
      % (len(ours), len(retail), "EXACT" if len(ours) == len(retail) else "MISMATCH"))
ok &= (len(ours) == len(retail))
real = []
for i, ((oa, ow, ot), (ra, rw, rt)) in enumerate(zip(ours, retail)):
    if ow != rw and oa not in rel:
        real.append((i, ow, ot, rw, rt))
print("   word diffs at NON-reloc addresses (= REAL): %d" % len(real))
for i, ow, ot, rw, rt in real:
    print("      [%3d] ours %08x %-28s | retail %08x %s" % (i, ow, ot, rw, rt))

print("\n== leg 2: delay slot of the 2nd `jal CdSyncCallback` (the _padInitDirSeq trap)")
def jal_idx_ours(name, which):
    n = 0
    for i, (a, w, t) in enumerate(ours):
        if t.startswith("jal") and rel.get(a, ("", ""))[1] == name:
            n += 1
            if n == which:
                return i
def jal_idx_retail(name, which):
    n = 0
    for i, (a, w, t) in enumerate(retail):
        if t.startswith("jal") and name in t:
            n += 1
            if n == which:
                return i
oi, ri = jal_idx_ours("CdSyncCallback", 2), jal_idx_retail("CdSyncCallback", 2)
print("   ours   jal @insn %d, slot = %08x  %s" % (oi, ours[oi + 1][1], ours[oi + 1][2]))
print("   retail jal @insn %d, slot = %08x  %s" % (ri, retail[ri + 1][1], retail[ri + 1][2]))
slot_ok = (oi == ri and ours[oi + 1][1] == retail[ri + 1][1])
print("   %s -- the w00 store IS the executed delay slot in both (not parked after it)"
      % ("PASS" if slot_ok else "FAIL"))
ok &= slot_ok

print("\n== leg 3: conditional-branch words (no reloc -> must be EXACT)")
n = b = 0
for i, ((oa, ow, ot), (ra, rw, rt)) in enumerate(zip(ours, retail)):
    mn = ot.split()[0] if ot else ""
    if not re.match(r"^b(eq|ne|gez|gtz|lez|ltz|eqz|nez|gezal|ltzal)z?$", mn) or oa in rel:
        continue
    n += 1
    if ow != rw:
        b += 1
        print("      DIFF [%3d] ours %08x %-26s | retail %08x %s" % (i, ow, ot, rw, rt))
print("   compared %d, mismatches %d  %s" % (n, b, "PASS" if b == 0 else "FAIL"))
ok &= (b == 0)

print("\n== leg 4: intra-.text j/jal targets, function-relative")
n = b = 0
for i, ((oa, ow, ot), (ra, rw, rt)) in enumerate(zip(ours, retail)):
    if rel.get(oa, ("", ""))[1] != ".text":
        continue
    n += 1
    o_t = ((ow & 0x03FFFFFF) << 2) - fn_off          # ours: object-relative
    r_t = (((rw & 0x03FFFFFF) << 2) | (fn_va & 0xF0000000)) - fn_va
    mark = "ok " if o_t == r_t else "DIFF"
    if o_t != r_t:
        b += 1
    print("      %s [%3d] %-6s ours +0x%-4x | retail +0x%-4x   (%s)"
          % (mark, i, ot.split()[0], o_t, r_t, rt))
print("   compared %d, mismatches %d  %s" % (n, b, "PASS" if b == 0 else "FAIL"))
ok &= (b == 0)

print("\nVERDICT: %s" % ("SEMANTICS-SAFE" if ok and not real else
                         "SEMANTICS-SAFE except the known REAL diff(s) listed above"
                         if ok else "NOT SAFE"))
