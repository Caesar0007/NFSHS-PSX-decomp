#!/usr/bin/env python3
"""w64-a20 mission 1 -- rewrite a recon TU's __asm__ blocks from the GNU-as
dialect into ASPSX-legal spellings AT THE SOURCE, so the TU is production-
buildable without tools/psyqproof.py's dialect shim.

Rules (the shim's own, probe-derived against the real ASPSX 2.77):
  1. ABI register NAMES `$a0` -> numeric `$4`, inside asm STRING LITERALS only.
  2. `.set push` dropped; `.set pop` -> the explicit axis restore, SPACE form.
     WHY SPACE FORM: maspsx reacts only to the TAB spelling (see
     maspsx/__init__.py:1013 `line.startswith(".set\\t")`), so a space-form
     restore is a maspsx NO-OP that reaches gnu-as verbatim -- exactly what
     `.set pop` did (maspsx never understood push/pop either).  Gate-neutral.
  3. `sym2 = sym` -> `sym2:` right after `sym:` (a 2nd label at one address;
     ASPSX has NO symbol-assignment form).
  4. 3-operand `div`/`divu` with a `$0`/`$zero` dest -> 2-operand raw form.
     NB at hand-asm sites the RIGHT cure is usually `.word <encoding>`: maspsx
     position-parses `divu` and dies on the 2-operand form.
  5. `.type`/`.size`/`.weak` (--drop-elf): ELF-only, ASPSX-rejected, and
     redundant with tools/fix_symsizes.py.  Measured bit-identical to drop.

SAFETY RULES LEARNED THE HARD WAY (every one was a real defect this wave):
  * lines inside a block comment are NEVER touched.  MATCH receipts quote asm
    and build.py regexes verbatim; the first cut renamed registers inside a
    drawc.cpp receipt and DOUBLED the backslashes of a quoted TEXT_MOVES anchor
    in nfile.c (encode() re-escaping text that was never decode()d as asm).
    Comments carry no bytes, so no gate can catch that class.
  * the banner is never placed inside a block comment or a #define continuation
    (it broke blkfill.c's header comment and nasync.c's macro body).
  * ASCII ONLY in this file: pathlib.write_text defaults to cp1251 here and
    TRUNCATES THE FILE TO 0 BYTES when it cannot encode a character (fired).
  * byte-mode I/O, line endings preserved, .bak per file, os.replace.
"""
import argparse
import os
import re
import sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")

REGS = {"zero": 0, "at": 1, "v0": 2, "v1": 3, "a0": 4, "a1": 5, "a2": 6,
        "a3": 7, "t0": 8, "t1": 9, "t2": 10, "t3": 11, "t4": 12, "t5": 13,
        "t6": 14, "t7": 15, "s0": 16, "s1": 17, "s2": 18, "s3": 19, "s4": 20,
        "s5": 21, "s6": 22, "s7": 23, "t8": 24, "t9": 25, "k0": 26, "k1": 27,
        "gp": 28, "sp": 29, "fp": 30, "s8": 30, "ra": 31}
RE_REG = re.compile(r"\$(" + "|".join(sorted(REGS, key=len, reverse=True)) + r")\b")
RE_STRDATA = re.compile(r"\.(ascii|asciiz|asciz|string)\b")
RE_STRLIT = re.compile(r'"(?:[^"\\]|\\.)*"')
RE_PUSH = re.compile(r"^\s*\.set\s+push\s*$")
RE_POP = re.compile(r"^\s*\.set\s+pop\s*$")
RE_SETOPT = re.compile(r"^\s*\.set\s+(\w+)\s*$")
RE_ELF = re.compile(r"^\s*\.(type|size|weak)\b")
RE_RAWDIV = re.compile(r"^(\s*)(div|divu)(\s+)\$(?:0|zero)\s*,\s*([^,\s]+)\s*,\s*([^,\s]+)\s*$")
RE_ALIAS = re.compile(r"^\s*([A-Za-z_$.][\w$.]*)\s*=\s*([A-Za-z_$.][\w$.]*)\s*$")
RE_LABEL = re.compile(r"^\s*([A-Za-z_$.][\w$.]*):\s*$")
SET_AXES = (("at", "at", "noat"), ("reorder", "reorder", "noreorder"),
            ("macro", "macro", "nomacro"))

BANNER = (
    "/* ASPSX-DIALECT (w64-a20): the asm below uses NUMERIC registers and no\n"
    " * `.set push/pop` -- ASPSX 2.77, the PRODUCTION assembler, rejects ABI\n"
    " * register NAMES and push/pop.  $0 zero $1 at $2-3 v0-v1 $4-7 a0-a3\n"
    " * $8-15 t0-t7 $16-23 s0-s7 $24-25 t8-t9 $28 gp $29 sp $30 fp $31 ra.\n"
    " * Gate-lane object is byte-identical (proven by hash); see\n"
    " * scratchpad/w64a20/RECEIPTS.md. */")
BANNER_MARK = "ASPSX-DIALECT (w64-a20)"


def block_comment_lines(lines):
    """indices of lines lying inside a C block comment"""
    inside, depth = set(), 0
    for idx, l in enumerate(lines):
        if depth:
            inside.add(idx)
        j = 0
        while j < len(l):
            if depth == 0 and l.startswith("/*", j):
                depth = 1
                inside.add(idx)
                j += 2
            elif depth and l.startswith("*/", j):
                depth = 0
                j += 2
            elif depth == 0 and l.startswith("//", j):
                break
            else:
                j += 1
    return inside


def decode(lit):
    body = lit[1:-1]
    return (body.replace(r"\t", "\t").replace(r"\n", "\n")
                .replace(r"\"", '"').replace(r"\\", "\\"))


def encode(txt):
    return ('"' + txt.replace("\\", r"\\").replace('"', r"\"")
            .replace("\t", r"\t").replace("\n", r"\n") + '"')


def _stmt_like(s):
    s = s.strip()
    if s.startswith("$"):                 # a local label, not prose
        return bool(re.match(r"^\$[\w.]+:?\s*$", s))
    return bool(re.match(r"^(\.|\w[\w$.]*\s*:|[a-z][a-z0-9._]*(\s|$)|#(APP|NO_APP))", s))


def looks_like_asm(payload):
    """Reject PROSE, accept asm -- including a CONTINUATION FRAGMENT.

    Two failure modes this has to straddle:
      * the first cut accepted anything starting with '$' and rewrote drawc's
        receipt string "$a0<->$a2 rotation";
      * requiring the FIRST line to be statement-shaped rejected the
        DRAWC_OTLINK macro fragments, which begin mid-instruction because the
        macro concatenates `... "(%0)\\n\\tlw\\t$t7," off1_ "(%0)..."` -- those
        left 90 ABI-named registers behind and ASPSX still refused the TU.
    So: asm iff ANY line of the payload is statement-shaped.  One-line prose has
    no statement-shaped line and stays rejected."""
    if payload.strip() == "":
        return True
    return any(_stmt_like(l) for l in payload.split("\n"))


def reg_pass_multiline(text):
    """Rule 1 for asm written as a GENUINE MULTI-LINE C string literal (real
    newlines inside the quotes -- eacpsxz/fastmovf.c, movf.c, and the
    `__asm__ volatile ("mfc2\t$t4,$19 <newline> ...")` blocks in drawc.cpp).
    The line engine cannot see those: its literal regex needs both quotes on one
    line.  A real C tokenizer here (block comments, line comments, char
    constants), plus the same prose guard, keeps it safe.  Idempotent.
    -> (new_text, n_rewrites)"""
    out, i, n, n_rw = [], 0, len(text), 0
    while i < n:
        c = text[i]
        if c == "/" and text.startswith("/*", i):
            j = text.find("*/", i + 2)
            j = n if j < 0 else j + 2
            out.append(text[i:j]); i = j; continue
        if c == "/" and text.startswith("//", i):
            j = text.find("\n", i)
            j = n if j < 0 else j
            out.append(text[i:j]); i = j; continue
        if c == "'":
            j = i + 1
            while j < n and text[j] != "'":
                j += 2 if text[j] == "\\" else 1
            j = min(j + 1, n)
            out.append(text[i:j]); i = j; continue
        if c == '"':
            j = i + 1
            while j < n and text[j] != '"':
                j += 2 if text[j] == "\\" else 1
            j = min(j + 1, n)
            lit = text[i:j]
            if "\n" in lit and not RE_STRDATA.search(lit) \
               and looks_like_asm(decode(lit)):
                lit, k = RE_REG.subn(lambda m: "$%d" % REGS[m.group(1)], lit)
                n_rw += k
            out.append(lit); i = j; continue
        out.append(c); i += 1
    return "".join(out), n_rw


def convert(src_text, drop_elf=False):
    lines = src_text.split("\n")
    stats = dict(reg=0, push=0, pop=0, alias=0, rawdiv=0, elf=0)
    notes = []
    commented = block_comment_lines(lines)
    out = []
    state = {"at": True, "reorder": True, "macro": True}
    stack, aliases = [], []
    for li, ln in enumerate(lines):
        if li in commented:
            out.append(ln)
            continue
        pieces, last = [], 0
        for h in RE_STRLIT.finditer(ln):
            pieces.append(("raw", ln[last:h.start()]))
            pieces.append(("lit", h.group(0)))
            last = h.end()
        pieces.append(("raw", ln[last:]))
        newpieces, dissolved = [], False
        for kind, txt in pieces:
            if kind == "raw":
                newpieces.append(txt)
                continue
            payload = decode(txt)
            if not looks_like_asm(payload):
                newpieces.append(txt)
                continue
            segs = payload.split("\n")
            tail_nl = payload.endswith("\n")
            if tail_nl:
                segs = segs[:-1]
            keep = []
            for seg in segs:
                if RE_PUSH.match(seg):
                    stack.append(dict(state))
                    stats["push"] += 1
                    continue
                if RE_POP.match(seg):
                    stats["pop"] += 1
                    if stack:
                        saved = stack.pop()
                        for key, on, off in SET_AXES:
                            if saved[key] != state[key]:
                                keep.append("\t.set " + (on if saved[key] else off))
                        state = saved
                    continue
                m = RE_SETOPT.match(seg)
                if m:
                    for key, on, off in SET_AXES:
                        if m.group(1) == on:
                            state[key] = True
                        elif m.group(1) == off:
                            state[key] = False
                if drop_elf and RE_ELF.match(seg):
                    stats["elf"] += 1
                    continue
                ma = RE_ALIAS.match(seg)
                if ma and ma.group(1) != ma.group(2):
                    aliases.append((ma.group(1), ma.group(2)))
                    stats["alias"] += 1
                    continue
                md = RE_RAWDIV.match(seg)
                if md:
                    seg = "%s%s%s%s,%s" % md.groups()
                    stats["rawdiv"] += 1
                if not RE_STRDATA.search(seg):
                    seg, k = RE_REG.subn(lambda x: "$%d" % REGS[x.group(1)], seg)
                    stats["reg"] += k
                keep.append(seg)
            if not keep:
                dissolved = True
                continue
            newpieces.append(encode("\n".join(keep) + ("\n" if tail_nl else "")))
        newln = "".join(newpieces)
        if dissolved and newln.strip() == "" and ln.strip() != "":
            continue
        out.append(newln)
    pending, guard = aliases, 0
    while pending and guard < 8:
        guard += 1
        still = []
        for new, tgt in pending:
            idx = None
            for i, l in enumerate(out):
                m = RE_STRLIT.search(l)
                if not m:
                    continue
                if any(RE_LABEL.match(s) and RE_LABEL.match(s).group(1) == tgt
                       for s in decode(m.group(0)).split("\n")):
                    idx = i
                    break
            if idx is None:
                still.append((new, tgt))
            else:
                ind = out[idx][:len(out[idx]) - len(out[idx].lstrip())]
                out.insert(idx + 1, ind + encode(new + ":\n"))
                notes.append("alias %s = %s -> label after %s:" % (new, tgt, tgt))
        if len(still) == len(pending):
            for new, tgt in still:
                notes.append("UNRESOLVED alias %s = %s (left verbatim)" % (new, tgt))
                out.append("    " + encode("%s = %s\n" % (new, tgt)))
            break
        pending = still
    if stack:
        notes.append("WARNING: %d unmatched .set push" % len(stack))
    res, extra = reg_pass_multiline("\n".join(out))
    stats["reg"] += extra
    return res, stats, notes


def add_banner(text):
    if BANNER_MARK in text:
        return text
    lines = text.split("\n")
    commented = block_comment_lines(lines)
    anchor = re.compile(r"^\s*(__asm__|__asm|asm)\s*(__volatile__|volatile)?\s*\(")

    def in_macro(idx):
        j = idx - 1
        while j >= 0 and lines[j].rstrip().endswith("\\"):
            j -= 1
        return lines[j + 1].lstrip().startswith("#")

    for i, ln in enumerate(lines):
        if (anchor.match(ln) and i not in commented and not in_macro(i)
                and not ln.lstrip().startswith("#")):
            ind = ln[:len(ln) - len(ln.lstrip())]
            lines.insert(i, "\n".join(ind + b for b in BANNER.split("\n")))
            return "\n".join(lines)
    return text


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("tu")
    ap.add_argument("--write", action="store_true")
    ap.add_argument("--drop-elf", action="store_true")
    ap.add_argument("--banner-only", action="store_true")
    a = ap.parse_args()
    p = ROOT / a.tu
    raw = p.read_bytes()
    assert b"\x00" not in raw, "NUL in source"
    crlf = b"\r\n" in raw
    text = raw.decode("utf-8").replace("\r\n", "\n")
    zero = dict(reg=0, push=0, pop=0, alias=0, rawdiv=0, elf=0)
    if a.banner_only:
        new, stats, notes = add_banner(text), zero, []
    else:
        new, stats, notes = convert(text, drop_elf=a.drop_elf)
        if new != text:
            new = add_banner(new)
    for n in notes:
        print("  note:", n)
    print("%s: reg=%d push=%d pop=%d alias=%d rawdiv=%d elf=%d"
          % (a.tu, stats["reg"], stats["push"], stats["pop"], stats["alias"],
             stats["rawdiv"], stats["elf"]))
    if new == text:
        print("  (no change)")
        return
    if not a.write:
        print("  (dry run; pass --write)")
        return
    outb = (new.replace("\n", "\r\n") if crlf else new).encode("utf-8")
    assert b"\x00" not in outb
    bak = Path(str(p) + ".w64a20.bak")
    if not bak.exists():
        bak.write_bytes(raw)
    tmp = Path(str(p) + ".tmp_w64a20")
    tmp.write_bytes(outb)
    os.replace(tmp, p)
    assert p.read_bytes() == outb, "write verification failed"
    print("  WROTE (%d -> %d bytes, %s)" % (len(raw), len(outb),
                                            "CRLF" if crlf else "LF"))


if __name__ == "__main__":
    main()
