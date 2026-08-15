"""w63a6 iso9660 CdSearchFile -- reqdelta272-PRICED 2-DIAL fence probe.

qty272 on this basin:
    73 name     refs  6 live 88 -> pri .1363  ($s4; retail $s3)
    76 sep      refs  6 live 60 -> pri .2000  ($s3; retail $s5)
    77 notfound refs  3 live 58 -> pri .0517  ($s5; retail $s4)
Retail order = name > notfound > sep.  Priced minimal dials (272 rule
pri = floor_log2(refs)*refs/live, no size term):
    name     6 ->  8 refs :  3*8/88  = .2727   (floor_log2 STEP at 8)
    notfound 3 ->  7 refs :  2*7/58  = .2413
    sep      unchanged     = .2000
=> name > notfound > sep.  In-loop read-only fence operand = +2 weighted refs,
so name x1 + notfound x2 operands inside the outer for-body buys exactly that.
"""
import os, subprocess, sys

ROOT = r"C:\Temp\nfs4-decomp"
TU = os.path.join(ROOT, "recon", "syslib", "psx", "libcd", "iso9660.c")
BAK = os.path.join(ROOT, "scratchpad", "w63a6", "iso9660.c.base_20260815.bak")

HEAD = "    sep = '\\\\'; notfound = -1; for (i = 0; i < 8; i++) {\r\n"
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
TAILBLK = (
    "        if (!*s)\r\n"
    "            break;\r\n"
    "        s++;                                                /* skip the separator */\r\n"
    "        *q = 0;\r\n"
    "        dir = _cd_find_path(dir, comp);\r\n"
    "        if (dir == notfound) {                                    /* directory not found */\r\n"
    "            comp[0] = 0;\r\n"
    "            break;\r\n"
    "        }\r\n"
)
BASE = HEAD + BODY + TAILBLK + "    }\r\n"

F_NAME1_NF2 = '        __asm__("" : : "r"(name), "r"(notfound), "r"(notfound));\r\n'
F_NAME1 = '        __asm__("" : : "r"(name));\r\n'
F_NF2 = '        __asm__("" : : "r"(notfound), "r"(notfound));\r\n'
F_NAME2_NF3 = '        __asm__("" : : "r"(name), "r"(name), "r"(notfound), "r"(notfound), "r"(notfound));\r\n'

VARIANTS = {
    "M_top_n1f2": HEAD + F_NAME1_NF2 + BODY + TAILBLK + "    }\r\n",
    "N_bot_n1f2": HEAD + BODY + TAILBLK + F_NAME1_NF2 + "    }\r\n",
    "O_top_n1": HEAD + F_NAME1 + BODY + TAILBLK + "    }\r\n",
    "P_top_f2": HEAD + F_NF2 + BODY + TAILBLK + "    }\r\n",
    "Q_top_n2f3": HEAD + F_NAME2_NF3 + BODY + TAILBLK + "    }\r\n",
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
            print("%-14s %s" % (name, gate("CdSearchFile")), flush=True)
    finally:
        with open(TU, "wb") as f:
            f.write(base)
        print("restored", os.path.getsize(TU))


main()
