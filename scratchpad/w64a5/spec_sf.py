TU = "recon/syslib/psx/libcd/iso9660.c"
FUNC = "CdSearchFile"
EXTRA_FUNCS = []

BASE = """        ch = *s;
        q = (signed char *)comp;
        while (*s != sep) {
            if (!*s)
                goto out;                                   /* reached the filename */
            *q++ = ch;
            ch = *++s;
        }
"""


def mk(head="ch = *s;", cond="*s != sep", zero="!*s", store="*q++ = ch;",
       adv="ch = *++s;", extra=""):
    return ("        %s\n        q = (signed char *)comp;\n%s"
            "        while (%s) {\n            if (%s)\n"
            "                goto out;\n            %s\n            %s\n        }\n"
            % (head, extra, cond, zero, store, adv))


ID_S = '        __asm__("" : "=r"(s) : "0"(s));\n'

VARIANTS = {
    "ctl":      [],
    # 09I DISTINCT-EXTENSION: the zero test through an UNSIGNED view of the same byte
    "u_zero":   [(BASE, mk(zero="!*(u_char *)s"))],
    "u_zero_c": [(BASE, mk(cond="*(signed char *)s != sep", zero="!*(u_char *)s"))],
    "u_cond":   [(BASE, mk(cond="*(u_char *)s != sep"))],
    "u_zero_uch": [(BASE, mk(head="ch = *s;", zero="!*(u_char *)s", adv="ch = *(signed char *)++s;"))],
    "id_s":     [(BASE, mk(extra=ID_S))],
    "id_s_uz":  [(BASE, mk(zero="!*(u_char *)s", extra=ID_S))],
    "u_zero_st": [(BASE, mk(zero="!*(u_char *)s", store="*q++ = *(signed char *)s;", adv="s++;"))],
}
