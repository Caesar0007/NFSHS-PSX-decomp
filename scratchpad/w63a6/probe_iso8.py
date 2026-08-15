"""w63a6 CdSearchFile -- inner-loop DISTINCT-EXTENSION probe on the NEW (19-diff) basin.

Registers are now retail-exact; the whole residual is the inner split loop:
  retail  lb v0,0(s0) / beq v0,s5 / li a1,0x5C / beqz v1 / lb v0,0(s0) / bne v0,a1
  ours    j T / beqz a1 / sll v0,v1,24 / sra v0,v0,24 / bne v0,s5 / addu a1,v1
Retail loads the SAME byte with BOTH `lb` (signed, feeds the != sep compare) and
`lbu` (unsigned, feeds the zero test AND the *q store) -- no sign-extend anywhere.
04Z basin law: the pre-fence falsifications of these spellings are re-tested here.
"""
import os, subprocess, sys

ROOT = r"C:\Temp\nfs4-decomp"
TU = os.path.join(ROOT, "recon", "syslib", "psx", "libcd", "iso9660.c")
BAK = os.path.join(ROOT, "scratchpad", "w63a6", "iso9660.c.fence_19_20260815.bak")

DECL = "    signed char    ch;\r\n"
BODY = (
    "        ch = *s;\r\n"
    "        q = (signed char *)comp;\r\n"
    "        while (*s != sep) {\r\n"
    "            if (!*s)\r\n"
    "                goto out;                                   /* reached the filename */\r\n"
    "            *q++ = ch;\r\n"
    "            ch = *++s;\r\n"
    "        }\r\n"
)


def L(*lines):
    return "".join(l + "\r\n" for l in lines)


VARIANTS = {
    # U1: u_char cache read explicitly unsigned; compare re-reads *s signed
    "U1_uch_cache": (
        L(
            "        ch = *(u_char *)s;",
            "        q = (signed char *)comp;",
            "        while (*s != sep) {",
            "            if (!ch)",
            "                goto out;",
            "            *q++ = ch;",
            "            s++;",
            "            ch = *(u_char *)s;",
            "        }",
        ),
        "u",
    ),
    # U2: minimal change -- ch declared u_char, everything else as-is
    "U2_uch_decl_only": (BODY, "u"),
    # U3: signed ch but the zero-test off the cached value (retail's beqz v1)
    "U3_ch_zero_test": (
        L(
            "        ch = *s;",
            "        q = (signed char *)comp;",
            "        while (*s != sep) {",
            "            if (!ch)",
            "                goto out;",
            "            *q++ = ch;",
            "            ch = *++s;",
            "        }",
        ),
        None,
    ),
    # U4: u_char cache + zero test off cache, ++s inside the read
    "U4_uch_preinc": (
        L(
            "        ch = *(u_char *)s;",
            "        q = (signed char *)comp;",
            "        while (*s != sep) {",
            "            if (!ch)",
            "                goto out;",
            "            *q++ = ch;",
            "            ch = *(u_char *)++s;",
            "        }",
        ),
        "u",
    ),
    # U5: no cache at all -- both extensions spelled at the use sites
    "U5_dualread": (
        L(
            "        q = (signed char *)comp;",
            "        while (*s != sep) {",
            "            if (!*(u_char *)s)",
            "                goto out;",
            "            *q++ = *(u_char *)s;",
            "            s++;",
            "        }",
        ),
        "drop",
    ),
}


def gate(fn):
    p = subprocess.run([sys.executable, "tools/verify_asm.py", "recon/syslib/psx/libcd/iso9660.c", fn],
                       cwd=ROOT, capture_output=True, text=True, timeout=900)
    out = p.stdout + p.stderr
    for line in out.splitlines():
        if line.strip().startswith(fn + ":"):
            return line.strip()
    return (out.strip().splitlines() or ["NO OUTPUT"])[-1]


base = open(BAK, "rb").read()
assert BODY.encode("ascii") in base and DECL.encode("ascii") in base
try:
    for name in (sys.argv[1:] or list(VARIANTS)):
        body, decl = VARIANTS[name]
        new = base.replace(BODY.encode("ascii"), body.encode("ascii"), 1)
        if decl == "u":
            new = new.replace(DECL.encode("ascii"), b"    u_char         ch;\r\n", 1)
        elif decl == "drop":
            new = new.replace(DECL.encode("ascii"), b"", 1)
        tmp = TU + ".tmp"
        open(tmp, "wb").write(new)
        assert os.path.getsize(tmp) > 20000
        os.replace(tmp, TU)
        print("%-20s %s" % (name, gate("CdSearchFile")), flush=True)
finally:
    open(TU, "wb").write(base)
    print("restored", os.path.getsize(TU))
