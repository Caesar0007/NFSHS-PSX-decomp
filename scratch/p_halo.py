import os

FENCE = '  __asm__ volatile("" : : "r"(scalex), "r"(scaley));'
PTASSIGN = "    pt = &pt2;\r\n"
COPY = ("    c = Flare_gType[flare_type].chalo;\r\n"
        "    *(u_long *)&gfrgb = c;\r\n"
        "    c = Flare_gType[flare_type].cbeam;\r\n"
        "    *(u_long *)&gfrgb2 = c;")

# (B) kill-the-base spellings
B_PTR = ("    {\r\n    Flare_tInfo *p = &Flare_gType[flare_type];\r\n"
         "    c = p->chalo;\r\n    *(u_long *)&gfrgb = c;\r\n"
         "    p = p;\r\n"
         "    c = *(u_long *)((char *)p + 4);\r\n    *(u_long *)&gfrgb2 = c;\r\n    }")
B_PTR2 = ("    {\r\n    Flare_tInfo *p = &Flare_gType[flare_type];\r\n"
          "    c = p->chalo;\r\n    *(u_long *)&gfrgb = c;\r\n"
          "    p = (Flare_tInfo *)((char *)p + 4);\r\n"
          "    c = *(u_long *)p;\r\n    *(u_long *)&gfrgb2 = c;\r\n    }")
B_PTR3 = ("    {\r\n    Flare_tInfo *p = &Flare_gType[flare_type];\r\n"
          "    c = p->chalo;\r\n    *(u_long *)&gfrgb = c;\r\n"
          "    c = p->cbeam;\r\n    *(u_long *)&gfrgb2 = c;\r\n    }")


def A(s):        # entry-block birth for pt + third fence operand
    s = s.replace(PTASSIGN, '')
    s = s.replace(FENCE, "  pt = &pt2;\r\n" + FENCE.replace(
        '"r"(scaley));', '"r"(scaley), "r"(pt));'))
    return s


def A2(s):       # entry-block birth for pt, fence unchanged
    s = s.replace(PTASSIGN, '')
    s = s.replace(FENCE, "  pt = &pt2;\r\n" + FENCE)
    return s


V = {
 'a1': A,
 'a2': A2,
 'b1': lambda s: s.replace(COPY, B_PTR),
 'b2': lambda s: s.replace(COPY, B_PTR2),
 'b3': lambda s: s.replace(COPY, B_PTR3),
 'ab1': lambda s: A(s.replace(COPY, B_PTR2)),
 'ab2': lambda s: A(s.replace(COPY, B_PTR3)),
}


def apply(src):
    assert src.count(FENCE) == 1 and src.count(PTASSIGN) == 1 and src.count(COPY) == 1
    return V[os.environ['V']](src)
