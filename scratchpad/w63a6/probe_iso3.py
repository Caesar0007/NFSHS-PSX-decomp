"""w63a6 iso9660 CdSearchFile -- PEELED-GUARD + rotated do-while probe.

qty272 (this basin) prices the three long-lived allocnos:
    73 name     refs 6 live 88  pri 1363 -> $s4   (retail wants $s3)
    76 sep      refs 6 live 60  pri 2000 -> $s3   (retail wants $s5)
    77 notfound refs 3 live 58  pri  517 -> $s5   (retail wants $s4)
Retail's order = name > notfound > sep, i.e. sep must drop BELOW 517.
At refs 3 sep prices 1*3/60 = 500 < 517 -> exactly retail's handout.
Retail reaches that by keeping the sep compare at outer-loop depth only:
its inner do-while tests a SEPARATE caller-saved copy (`li a1,0x5C` in the
inner preheader, oracle .L800F9130), so sep itself is referenced only by the
peeled guard `beq v0,s5`.  These variants spell the peel explicitly.
"""
import os, subprocess, sys

ROOT = r"C:\Temp\nfs4-decomp"
TU = os.path.join(ROOT, "recon", "syslib", "psx", "libcd", "iso9660.c")
BAK = os.path.join(ROOT, "scratchpad", "w63a6", "iso9660.c.base_20260815.bak")

BASE = (
    "    sep = '\\\\'; notfound = -1; for (i = 0; i < 8; i++) {\r\n"
    "        ch = *s;\r\n"
    "        q = (signed char *)comp;\r\n"
    "        while (*s != sep) {\r\n"
    "            if (!*s)\r\n"
    "                goto out;                                   /* reached the filename */\r\n"
    "            *q++ = ch;\r\n"
    "            ch = *++s;\r\n"
    "        }\r\n"
    "        if (!*s)\r\n"
    "            break;\r\n"
    "        s++;                                                /* skip the separator */\r\n"
    "        *q = 0;\r\n"
    "        dir = _cd_find_path(dir, comp);\r\n"
    "        if (dir == notfound) {                                    /* directory not found */\r\n"
    "            comp[0] = 0;\r\n"
    "            break;\r\n"
    "        }\r\n"
    "    }\r\n"
)

HEAD = "    sep = '\\\\'; notfound = -1; for (i = 0; i < 8; i++) {\r\n"
TAIL = (
    "        if (!*s)\r\n"
    "            break;\r\n"
    "        s++;\r\n"
    "        *q = 0;\r\n"
    "        dir = _cd_find_path(dir, comp);\r\n"
    "        if (dir == notfound) {\r\n"
    "            comp[0] = 0;\r\n"
    "            break;\r\n"
    "        }\r\n"
    "    }\r\n"
)


def L(*lines):
    return "".join(l + "\r\n" for l in lines)


def body(guard, inner):
    return (
        HEAD
        + L(
            "        ch = *s;",
            "        q = (signed char *)comp;",
            "        if (*s != %s) {" % guard,
            "            do {",
            "                if (!*s)",
            "                    goto out;",
            "                *q++ = ch;",
            "                ch = *++s;",
            "            } while (*s != %s);" % inner,
            "        }",
        )
        + TAIL
    )


VARIANTS = {
    "J_peel_sep_sep": body("sep", "sep"),
    "K_peel_sep_lit": body("sep", "'\\\\'"),
    "L_peel_lit_sep": body("'\\\\'", "sep"),
}


def gate(fn):
    p = subprocess.run(
        [sys.executable, "tools/verify_asm.py", "recon/syslib/psx/libcd/iso9660.c", fn],
        cwd=ROOT, capture_output=True, text=True, timeout=900,
    )
    out = p.stdout + p.stderr
    for line in out.splitlines():
        if line.strip().startswith(fn + ":"):
            return line.strip()
    return (out.strip().splitlines() or ["NO OUTPUT"])[-1]


def main():
    names = sys.argv[1:] or list(VARIANTS)
    base = open(BAK, "rb").read()
    assert BASE.encode("ascii") in base
    try:
        for name in names:
            new = base.replace(BASE.encode("ascii"), VARIANTS[name].encode("ascii"), 1)
            assert new != base
            tmp = TU + ".tmp"
            with open(tmp, "wb") as f:
                f.write(new)
            assert os.path.getsize(tmp) > 20000
            os.replace(tmp, TU)
            print("%-18s %s" % (name, gate("CdSearchFile")), flush=True)
    finally:
        with open(TU, "wb") as f:
            f.write(base)
        print("restored", os.path.getsize(TU))


main()
