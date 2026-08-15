"""w63a6 iso9660 CdSearchFile -- DISTINCT-EXTENSION double-read loop probe.

Oracle (asm/nonmatchings/main/CdSearchFile.s .L800F9120..L800F915C) loads the SAME
byte TWICE per iteration: `lb v0,0(s0)` (signed, feeds the != sep compare) AND
`lbu v1,0(s0)` (unsigned, feeds BOTH the zero-test and the *q store).  No cached
`ch` variable exists in retail; ours carries one and pays sll24/sra24.

Patches the REAL path (PER_TU_FLAGS path-keyed) + restores in finally.
"""
import os, subprocess, sys

ROOT = r"C:\Temp\nfs4-decomp"
TU = os.path.join(ROOT, "recon", "syslib", "psx", "libcd", "iso9660.c")
BAK = os.path.join(ROOT, "scratchpad", "w63a6", "iso9660.c.base_20260815.bak")

DECL = "    signed char    ch;\r\n"

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

HEAD = "    sep = '\\\\'; notfound = -1; for (i = 0; i < 8; i++) {\r\n"


def L(*lines):
    return "".join(l + "\r\n" for l in lines)


VARIANTS = {
    # F: no cached ch at all; both extensions spelled at the use sites
    "F_dualread": (
        HEAD
        + L(
            "        q = (signed char *)comp;",
            "        while (*s != sep) {",
            "            if (!*(u_char *)s)",
            "                goto out;",
            "            *q++ = *(u_char *)s;",
            "            s++;",
            "        }",
        )
        + TAIL,
        True,  # drop the `ch` decl
    ),
    # G: same, but keep the (now unused) ch decl -- frame/pseudo-numbering control
    "G_dualread_keepdecl": (
        HEAD
        + L(
            "        q = (signed char *)comp;",
            "        while (*s != sep) {",
            "            if (!*(u_char *)s)",
            "                goto out;",
            "            *q++ = *(u_char *)s;",
            "            s++;",
            "        }",
        )
        + TAIL,
        False,
    ),
    # H: unsigned cached byte inside the loop (one lbu), signed compare re-read
    "H_uch_local": (
        HEAD
        + L(
            "        q = (signed char *)comp;",
            "        while (*s != sep) {",
            "            uch = *(u_char *)s;",
            "            if (!uch)",
            "                goto out;",
            "            *q++ = uch;",
            "            s++;",
            "        }",
        )
        + TAIL,
        "uch",
    ),
    # I: dual read, store/incr order as the oracle schedules it (s++ before the store)
    "I_dualread_incfirst": (
        HEAD
        + L(
            "        q = (signed char *)comp;",
            "        while (*s != sep) {",
            "            if (!*(u_char *)s)",
            "                goto out;",
            "            *q = *(u_char *)s;",
            "            s++;",
            "            q++;",
            "        }",
        )
        + TAIL,
        True,
    ),
}


def gate(fn, tu="recon/syslib/psx/libcd/iso9660.c"):
    p = subprocess.run(
        [sys.executable, "tools/verify_asm.py", tu, fn],
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
            body, decl_mode = VARIANTS[name]
            new = base.replace(BASE.encode("ascii"), body.encode("ascii"), 1)
            if decl_mode is True:
                new = new.replace(DECL.encode("ascii"), b"", 1)
            elif isinstance(decl_mode, str):
                new = new.replace(DECL.encode("ascii"), ("    u_char         %s;\r\n" % decl_mode).encode("ascii"), 1)
            tmp = TU + ".tmp"
            with open(tmp, "wb") as f:
                f.write(new)
            assert os.path.getsize(tmp) > 20000
            os.replace(tmp, TU)
            print("%-24s %s" % (name, gate("CdSearchFile")), flush=True)
    finally:
        with open(TU, "wb") as f:
            f.write(base)
        print("restored", os.path.getsize(TU))


main()
