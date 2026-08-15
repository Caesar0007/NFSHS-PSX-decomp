"""w63a6 iso9660 CdSearchFile split-loop variant probe.

Patches the REAL path (PER_TU_FLAGS is path-keyed) and restores in finally.
Usage: python scratchpad/w63a6/probe_iso.py <variant-name>...
"""
import os, subprocess, sys, io

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


def blk(lines):
    return "".join(l + "\r\n" for l in lines)


# psyz (PsyQ 4.0 matched twin, C:/Temp/psyz/decomp/src/libcd/iso9660.c:40) loop shape:
#   fp++; fp--;  ch = *pathPtr;  nameEnd = buf;  while (ch != '\\') {...}
PSYZ_BODY = [
    "        ch = *s;",
    "        q = (signed char *)comp;",
    "        while (ch != '\\\\') {",
    "            if (!ch)",
    "                goto out;",
    "            *q++ = ch;",
    "            ch = *++s;",
    "        }",
    "        if (!*s)",
    "            break;",
    "        s++;",
    "        *q = 0;",
    "        dir = _cd_find_path(dir, comp);",
    "        if (dir == -1) {",
    "            comp[0] = 0;",
    "            break;",
    "        }",
    "    }",
]

PSYZ_BODY_SEPVARS = [
    "        ch = *s;",
    "        q = (signed char *)comp;",
    "        while (ch != sep) {",
    "            if (!ch)",
    "                goto out;",
    "            *q++ = ch;",
    "            ch = *++s;",
    "        }",
    "        if (!*s)",
    "            break;",
    "        s++;",
    "        *q = 0;",
    "        dir = _cd_find_path(dir, comp);",
    "        if (dir == notfound) {",
    "            comp[0] = 0;",
    "            break;",
    "        }",
    "    }",
]

VARIANTS = {
    # A: psyz body verbatim, literals, WITH the fp++/fp-- no-op
    "A_psyz_nop_lit": blk(["    for (i = 0; i < 8; i++) {", "        fp++;", "        fp--;"] + PSYZ_BODY),
    # B: psyz body, literals, NO no-op
    "B_psyz_lit": blk(["    for (i = 0; i < 8; i++) {"] + PSYZ_BODY),
    # C: psyz body + our named sep/notfound preheader locals, no no-op
    "C_psyz_sepvars": blk(["    sep = '\\\\'; notfound = -1; for (i = 0; i < 8; i++) {"] + PSYZ_BODY_SEPVARS),
    # D: psyz body + named sep/notfound + the no-op
    "D_psyz_sepvars_nop": blk(
        ["    sep = '\\\\'; notfound = -1; for (i = 0; i < 8; i++) {", "        fp++;", "        fp--;"]
        + PSYZ_BODY_SEPVARS
    ),
    # E: current body but with the no-op restored (control for W62-A7's deletion)
    "E_base_plus_nop": BASE.replace(
        "for (i = 0; i < 8; i++) {\r\n", "for (i = 0; i < 8; i++) {\r\n        fp++;\r\n        fp--;\r\n", 1
    ),
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
    return out.strip().splitlines()[-1] if out.strip() else "NO OUTPUT"


def main():
    names = sys.argv[1:] or list(VARIANTS)
    base = open(BAK, "rb").read()
    assert BASE.encode("ascii") in base, "anchor not found"
    try:
        for name in names:
            body = VARIANTS[name]
            new = base.replace(BASE.encode("ascii"), body.encode("ascii"), 1)
            assert new != base
            tmp = TU + ".tmp"
            with open(tmp, "wb") as f:
                f.write(new)
            assert os.path.getsize(tmp) > 20000
            os.replace(tmp, TU)
            print("%-22s %s" % (name, gate("CdSearchFile")), flush=True)
    finally:
        with open(TU, "wb") as f:
            f.write(base)
        print("restored", os.path.getsize(TU))


main()
