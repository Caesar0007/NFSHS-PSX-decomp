#!/usr/bin/env python
"""addPrim P_TAG rewriter for hud.cpp OT-link pairs.

Finds the two-statement hand-masked link idiom

    <TAG> = <TAG> & 0xff000000 | <PAL> & 0xffffff;
    <PAL> = <PAL> & 0xff000000 | (u_int)<PRIM> & 0xffffff;

(with arbitrary whitespace/newlines and optional (u_long *)/(u_int) casts) and
rewrites it as the PsyQ addPrim()/setaddr() house idiom over the P_TAG bitfield:

    ((Hud_PTag *)<PRIM>)->addr = ((Hud_PTag *)<PALPTR>)->addr;
    ((Hud_PTag *)<PALPTR>)->addr = (u_int)<PRIM>;

<PALPTR> is <PAL> with its leading dereference/cast stripped
(`*pal` / `*(u_int *)pal` -> `pal`).

Usage: python scratch/ptag.py <file> <startMarker> <endMarker> [--dry]
"""
import re
import sys

path, start, end = sys.argv[1], sys.argv[2], sys.argv[3]
dry = "--dry" in sys.argv

src = open(path, "rb").read().decode("utf-8")
i, j = src.index(start), src.index(end)
body = src[i:j]


def statements(text):
    """Yield (start, end) offsets of ';'-terminated statements, depth-0 only."""
    depth = 0
    beg = 0
    for k, ch in enumerate(text):
        if ch in "([":
            depth += 1
        elif ch in ")]":
            depth -= 1
        elif ch == ";" and depth == 0:
            yield beg, k + 1
            beg = k + 1


def norm(s):
    return re.sub(r"\s+", " ", s).strip()


def deref(pal):
    """`*(u_int *)pal` / `*pal` -> `pal`."""
    p = norm(pal)
    m = re.match(r"^\*\s*(?:\(\s*u_int\s*\*\s*\))?\s*(.+)$", p)
    return m.group(1).strip() if m else p


LINK1 = re.compile(
    r"^(?P<tag>.+?)\s*=\s*(?:\(u_long \*\))?\(?\s*(?:\(u_int\))?\s*(?P=tag)"
    r"\s*&\s*0xff000000\s*\|\s*(?P<pal>.+?)\s*&\s*0xffffff\s*\)?\s*;$"
)
LINK2 = re.compile(
    r"^(?P<pal>.+?)\s*=\s*(?P=pal)\s*&\s*0xff000000"
    r"\s*\|\s*\(u_int\)\s*(?P<prim>.+?)\s*&\s*0xffffff\s*;$"
)

stmts = list(statements(body))
out = []
prev_end = 0
n = 0
k = 0
while k < len(stmts) - 1:
    (a0, a1), (b0, b1) = stmts[k], stmts[k + 1]
    ta, tb = body[a0:a1], body[b0:b1]
    ca = max(ta.rfind('{'), ta.rfind('}')) + 1   # skip brace/keyword prefix
    cb = max(tb.rfind('{'), tb.rfind('}')) + 1
    m1 = LINK1.match(norm(ta[ca:]))
    m2 = LINK2.match(norm(tb[cb:]))
    if m1 and m2 and norm(m1.group("pal")) == norm(m2.group("pal")):
        pal = deref(m2.group("pal"))
        prim = norm(m2.group("prim"))
        a0 = a0 + ca
        lead = body[a0:a1]
        indent = re.match(r"[\r\n]*([ \t]*)", lead).group(1)
        nl = "\r\n" if "\r\n" in body else "\n"
        pre = lead[: len(lead) - len(lead.lstrip("\r\n \t"))]
        out.append(body[prev_end:a0])
        out.append(
            pre
            + "((Hud_PTag *)%s)->addr = ((Hud_PTag *)%s)->addr;" % (prim, pal)
            + nl
            + indent
            + "((Hud_PTag *)%s)->addr = (u_int)%s;" % (pal, prim)
        )
        prev_end = b1
        n += 1
        k += 2
        continue
    k += 1
out.append(body[prev_end:])
newbody = "".join(out)
print("converted pairs:", n)
if not dry:
    open(path, "wb").write((src[:i] + newbody + src[j:]).encode("utf-8"))
