"""w63a6 CD_newmedia -- the psyz/sotn PVD-STRUCT spelling for the misaligned +140 read.

Open residual (a), 11 diffs: retail reads the type-L path-table LBA off the SHARED base
register (`lwl 143($s0) / lwr 140($s0)`); ours const-folds `buf` back to the symbol and
mints its own `la $5,_cd_secbuf+140`.  Falsified so far: `(LBA*)(buf+140)`, `((LBA*)buf)[35]`,
decl reorder, -fforce-addr/-fforce-mem/-fno-schedule-insns, a block-local copy, an identity
fence at the read (works but costs +8 elsewhere).
UNTRIED: the matched twins spell it as a real COMPONENT_REF off a PVD STRUCT TYPE --
  psyz  C:/Temp/psyz/decomp/src/libcd/iso9660.c:145
        (&pathTableLBA)->i = ((IsoPVD*)load_buf_)->pathTableLBA.i;
  (IsoPVD = type/id[5]/version/_unused[0x85] = exactly the 140-byte prefix.)
That is the catalog's STRUCT-READ ANTI-DEP law applied to the LOAD side: a COMPONENT_REF
carries MEM_IN_STRUCT_P where a cast-int deref is a plain mem.
"""
import os, subprocess, sys

ROOT = r"C:\Temp\nfs4-decomp"
TU = os.path.join(ROOT, "recon", "syslib", "psx", "libcd", "iso9660.c")
BAK = os.path.join(ROOT, "scratchpad", "w63a6", "iso9660.c.newmedia_base_20260815.bak")

TYPEDEF_ANCHOR = "struct RawWord { u_char bytes[4]; };\r\n"
PVD = (
    TYPEDEF_ANCHOR
    + "/* ISO9660 Primary Volume Descriptor prefix -- type/id/version + 0x85 unused = the\r\n"
    + " * 140-byte offset of the type-L path-table LBA (psyz/sotn spell it this way). */\r\n"
    + "struct IsoPVD { u_char type; char id[5]; u_char version; u_char _unused[0x85]; LBA ptLBA; };\r\n"
    + "typedef struct IsoPVD IsoPVD;\r\n"
)

OLD = (
    "    pt_lba = *(RawWord *)(buf + 140);                        /* type-L path table LBA (misaligned;\r\n"
    "                                                              * indexed off buf so the +140 folds into\r\n"
    "                                                              * the lwl/lwr displacement, oracle\r\n"
    "                                                              * `lwl 143(s0)/lwr 140(s0)`) */\r\n"
)

VARIANTS = {
    # P1: psyz spelling verbatim (LBA union local, address-of-then-arrow LHS)
    "P1_pvd_component": (PVD, "    (&pt_lba_u)->i = ((IsoPVD *)buf)->ptLBA.i;\r\n", "LBA"),
    # P2: plain member-to-member assignment
    "P2_pvd_plain": (PVD, "    pt_lba_u.i = ((IsoPVD *)buf)->ptLBA.i;\r\n", "LBA"),
    # P3: whole-union struct assignment through the PVD type
    "P3_pvd_whole": (PVD, "    pt_lba_u = ((IsoPVD *)buf)->ptLBA;\r\n", "LBA"),
    # P4: keep RawWord but read it as a COMPONENT_REF of the PVD struct
    "P4_pvd_rawword": (PVD, "    pt_lba = *(RawWord *)&((IsoPVD *)buf)->ptLBA;\r\n", None),
}

DECL_OLD = "    RawWord pt_lba;\r\n"


def gate(fn):
    p = subprocess.run([sys.executable, "tools/verify_asm.py", "recon/syslib/psx/libcd/iso9660.c", fn],
                       cwd=ROOT, capture_output=True, text=True, timeout=900)
    out = p.stdout + p.stderr
    for line in out.splitlines():
        if line.strip().startswith(fn + ":"):
            return line.strip()
    return (out.strip().splitlines() or ["NO OUTPUT"])[-1]


base = open(BAK, "rb").read()
assert TYPEDEF_ANCHOR.encode("ascii") in base, "typedef anchor"
assert OLD.encode("ascii") in base, "read anchor"
assert DECL_OLD.encode("ascii") in base, "decl anchor"
try:
    for name in (sys.argv[1:] or list(VARIANTS)):
        pvd, read, newdecl = VARIANTS[name]
        new = base.replace(TYPEDEF_ANCHOR.encode("ascii"), pvd.encode("ascii"), 1)
        new = new.replace(OLD.encode("ascii"), read.encode("ascii"), 1)
        if newdecl:
            new = new.replace(DECL_OLD.encode("ascii"), ("    LBA     pt_lba_u;\r\n").encode("ascii"), 1)
            new = new.replace(b"*(int *)&pt_lba", b"pt_lba_u.addr")
        tmp = TU + ".tmp"
        open(tmp, "wb").write(new)
        assert os.path.getsize(tmp) > 20000
        os.replace(tmp, TU)
        print("%-20s %s" % (name, gate("CD_newmedia")), flush=True)
finally:
    open(TU, "wb").write(base)
    print("restored", os.path.getsize(TU))
