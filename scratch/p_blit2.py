import os

HDR = "  *(u_int *)sprt = *(u_int *)sprt & 0xff000000 | *pal & 0xffffff;"
PALST = "    *pal = *pal & 0xff000000 | (addr24 & 0xffffff);"

HDR_S = ("  {\r\n  u_int hdr = *(u_int *)sprt & 0xff000000;\r\n"
         "  *(u_int *)sprt = (hdr & 0xff000000) | *pal & 0xffffff;\r\n  }")
PAL_S = ("    {\r\n    u_int ph = *pal & 0xff000000;\r\n"
         "    *pal = (ph & 0xff000000) | (addr24 & 0xffffff);\r\n    }")
PAL_S2 = ("    {\r\n    u_int ph = *pal & 0xff000000;\r\n"
          "    *pal = (ph & 0xff000000) | ((addr24 & 0xffffff) & 0xffffff);\r\n    }")

V = {
 's1': lambda s: s.replace(HDR, HDR_S),
 's2': lambda s: s.replace(PALST, PAL_S),
 's3': lambda s: s.replace(HDR, HDR_S).replace(PALST, PAL_S),
 's4': lambda s: s.replace(PALST, PAL_S2),
 's5': lambda s: s.replace(HDR, HDR_S).replace(PALST, PAL_S2),
}


def apply(src):
    assert src.count(HDR) == 1 and src.count(PALST) == 1
    return V[os.environ['V']](src)
