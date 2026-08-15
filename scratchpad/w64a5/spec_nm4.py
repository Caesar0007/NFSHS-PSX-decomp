import os
TU = "recon/syslib/psx/libcd/iso9660.c"
FUNC = "CD_newmedia"
EXTRA_FUNCS = []

_d = os.path.dirname(__file__)
FULL = open(os.path.join(_d, "nm_body.txt"), encoding="utf-8", newline="").read()
HEAD = "    idx = 0;\n    rec = buf;\n    end = buf + 0x800;\n    while (rec < end) {\n"
assert FULL.startswith(HEAD), repr(FULL[:80])
INNER = FULL[len(HEAD):]
INNER_BODY = INNER[: INNER.rindex("\n    }")]

RO_BUF = '    __asm__("" : : "r"(buf));\n'
ID_BUF = '    __asm__("" : "=r"(buf) : "0"(buf));\n'
DECL = "    u_char *rec;\n    u_char *end;\n"
DECL2 = "    u_char *rec;\n    u_char *end;\n    u_char *lim;\n"
LAUNDER = [(RO_BUF, ID_BUF), (DECL, DECL2)]


def indent(t, n=4):
    return "\n".join((" " * n + l if l.strip() else l) for l in t.split("\n"))


PRE = "    idx = 0;\n    rec = buf;\n    lim = buf + 0x800;\n    if (rec < lim) {\n        end = lim;\n"
DOWHILE = PRE + "        do {\n" + indent(INNER_BODY) + "\n        } while (rec < end);\n    }"
WHILEIN = PRE + "        while (rec < end) {\n" + indent(INNER_BODY) + "\n        }\n    }"
GOTO = PRE + "nmscan:\n" + indent(INNER_BODY) + "\n        if (rec < end) goto nmscan;\n    }"

VARIANTS = {
    "L":         LAUNDER,
    "L_dowhile": LAUNDER + [(FULL, DOWHILE)],
    "L_whilein": LAUNDER + [(FULL, WHILEIN)],
    "L_goto":    LAUNDER + [(FULL, GOTO)],
    "dowhile":   [(DECL, DECL2), (FULL, DOWHILE)],
}
