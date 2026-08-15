#!/usr/bin/env python3
"""w67a3 vendor byte-truth comparator.

Compares a PsyQ 4.3 vendor library function's words (from the SN-LNK obj)
against the retail oracle words (from asm/nonmatchings/main/<fn>.s), masking
relocated fields, and prints a symbolized annotation of every patch site.

Usage:
  python vcmp.py <LIB> <member.obj> <fnname> <oracle.s> [--anchor SYM] [--dump]

Offsets: fn located by XDEF/local name; if absent, --anchor SYM gives a known
XDEF whose retail VA (configs/symbol_addrs.txt) anchors VA arithmetic:
  off(fn) = off(anchor) + VA(fn) - VA(anchor).
"""
import os, re, struct, sys

EXTR = r"C:\Temp\nfs4-clean\psyq43\extracted"
REPO = r"C:\Temp\nfs4-decomp"
sys.path.insert(0, r"C:\Temp\nfs3-clean")
import importlib.util
spec = importlib.util.spec_from_file_location("tpe", r"C:\Temp\nfs3-clean\tools_psyq_extract.py")
tpe = importlib.util.module_from_spec(spec)
spec.loader.exec_module(tpe)

def load_symaddrs():
    m = {}
    with open(os.path.join(REPO, "configs", "symbol_addrs.txt")) as f:
        for ln in f:
            mo = re.match(r"(\S+)\s*=\s*0x([0-9A-Fa-f]+)", ln)
            if mo:
                m[mo.group(1)] = int(mo.group(2), 16)
    return m

def oracle_words(spath):
    words, texts = [], []
    with open(spath) as f:
        for ln in f:
            mo = re.match(r"\s*/\* [0-9A-F]+ ([0-9A-F]{8}) ([0-9A-F]{8}) \*/\s+(.*)", ln)
            if mo:
                words.append(struct.unpack("<I", bytes.fromhex(mo.group(2)))[0])
                texts.append(mo.group(3).rstrip())
    return words, texts

def decode_expr(d, p, symmap):
    op = d[p]; p += 1
    if op == 0x00:
        v = struct.unpack("<I", d[p:p+4])[0]; return p+4, "0x%X" % v
    if op == 0x02:
        s = struct.unpack("<H", d[p:p+2])[0]; return p+2, symmap.get(s, "sym%d" % s)
    if op == 0x04:
        s = struct.unpack("<H", d[p:p+2])[0]; return p+2, "sect%d" % s
    if op in (0x2C, 0x2E, 0x30, 0x32):
        opn = {0x2C: "+", 0x2E: "-", 0x30: "/", 0x32: "*"}[op]
        p, a = decode_expr(d, p, symmap); p, b = decode_expr(d, p, symmap)
        return p, "(%s%s%s)" % (a, opn, b)
    if op in (0x0C, 0x16, 0x36):
        s = struct.unpack("<H", d[p:p+2])[0]; return p+2, "ref%02x:%d" % (op, s)
    raise ValueError("expr op %02x" % op)

def parse_with_exprs(data):
    """re-walk patches, decoding exprs (extractor only skips them)."""
    obj = tpe.parse_obj(data)
    # rebuild patch exprs: rewalk stream minimally
    d = data; p = 4; cur = None; chunk_base = {}
    symmap = {}
    # sym index -> name (XREFs carry indices; XDEFs too)
    # first pass for xref/xdef indices: need rewalk since parse_obj drops xref sym idx order
    patches = []
    n = len(d)
    while p < n:
        op = d[p]; p += 1
        if op == 0x00: break
        elif op == 0x02:
            ln = struct.unpack("<H", d[p:p+2])[0]; p += 2
            chunk_base[cur] = chunk_base.get(cur, 0)
            patches_base = chunk_base[cur]
            chunk_base[cur] = chunk_base[cur] + ln
            chunk_last = patches_base
            p += ln
            chunk_base.setdefault("_last_%s" % cur, 0)
            chunk_base["_last_%s" % cur] = patches_base
        elif op == 0x06:
            cur = struct.unpack("<H", d[p:p+2])[0]; p += 2
        elif op == 0x08:
            sz = struct.unpack("<I", d[p:p+4])[0]; p += 4
            chunk_base[cur] = chunk_base.get(cur, 0) + sz
        elif op == 0x0A:
            ptype = d[p]; p += 1
            poff = struct.unpack("<H", d[p:p+2])[0]; p += 2
            p, ex = decode_expr(d, p, symmap)
            patches.append(dict(sect=cur, off=chunk_base.get("_last_%s" % cur, 0)+poff,
                                type=ptype, expr=ex))
        elif op == 0x0C:
            sym, sect = struct.unpack("<HH", d[p:p+4]); p += 4
            off = struct.unpack("<I", d[p:p+4])[0]; p += 4
            ln = d[p]; p += 1
            nm = d[p:p+ln].decode("ascii", "replace"); p += ln
            symmap[sym] = nm
        elif op == 0x0E:
            sym = struct.unpack("<H", d[p:p+2])[0]; p += 2
            ln = d[p]; p += 1
            symmap[sym] = d[p:p+ln].decode("ascii", "replace"); p += ln
        elif op == 0x10:
            p += 4; al = d[p]; p += 1
            ln = d[p]; p += 1; p += ln
        elif op == 0x12:
            p += 2; p += 4
            ln = d[p]; p += 1; p += ln
        elif op in (0x14, 0x30):
            sym = struct.unpack("<H", d[p:p+2])[0]; p += 2
            p += 2 + 4
            ln = d[p]; p += 1
            symmap[sym] = d[p:p+ln].decode("ascii", "replace"); p += ln
        elif op == 0x1C:
            p += 2; ln = d[p]; p += 1; p += ln
        elif op == 0x2E:
            p += 1
        elif op == 0x32: p += 2
        elif op == 0x34:
            p += 2; ln = d[p]; p += 1; p += ln
        elif op == 0x36: p += 4
        elif op == 0x38:
            p += 2+4+2+2+4+4; ln = d[p]; p += 1; p += ln
        elif op == 0x3A: p += 2+4+4
        elif op == 0x3C: p += 2+4+4
        elif op == 0x3E: p += 2+4+4
        elif op == 0x40:
            p += 2+4+2+2+4; ln = d[p]; p += 1; p += ln
        elif op == 0x42:
            p += 2+4+2+2+4
            nd = struct.unpack("<H", d[p:p+2])[0]; p += 2 + nd*4
            ln = d[p]; p += 1; p += ln
        elif op == 0x44:
            p += 2; ln = d[p]; p += 1; p += ln
        elif op == 0x46: p += 2+4
        elif op == 0x48: p += 1
        elif op == 0x4A: pass
        elif op == 0x4C: p += 2+1
        else:
            raise ValueError("op %02x @%d" % (op, p-1))
    obj["patches2"] = patches
    return obj

def main():
    lib, member, fn, spath = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]
    anchor = None; dump = "--dump" in sys.argv
    if "--anchor" in sys.argv:
        anchor = sys.argv[sys.argv.index("--anchor")+1]
    objpath = os.path.join(EXTR, lib, "obj", member)
    data = open(objpath, "rb").read()
    obj = parse_with_exprs(data)
    # code section
    codesects = [s for s, nm in obj["sections"].items() if nm.startswith(".text")]
    cs = codesects[0]
    code = obj["code"].get(cs, b"")
    syms = {}
    for x in obj["xdefs"]:
        if x.get("sect") == cs and "bss" not in x:
            syms[x["name"]] = x["off"]
    for l in obj["locals"]:
        if l["sect"] == cs:
            syms[l["name"]] = l["off"]
    va = load_symaddrs()
    rwords, rtexts = oracle_words(os.path.join(REPO, spath))
    nwords = len(rwords)
    if "--scan" in sys.argv:
        # slide over .text word-aligned; score = matching words (ignoring patch sites & zeros)
        pset = set(pt["off"] // 4 for pt in obj["patches2"] if pt["sect"] == cs)
        best, boff = -1, 0
        maxw = len(code) // 4 - nwords
        cw = [struct.unpack("<I", code[j*4:j*4+4])[0] for j in range(len(code)//4)]
        for st in range(0, maxw + 1):
            sc = 0
            for i in range(nwords):
                if (st + i) in pset:
                    continue
                if cw[st+i] == rwords[i]:
                    sc += 1
            if sc > best:
                best, boff = sc, st
        off = boff * 4
        how = "scan best=%d/%d" % (best, nwords)
    elif fn in syms:
        off = syms[fn]
        how = "symbol"
    else:
        if not anchor or anchor not in syms:
            print("FN %s not in obj symbols; xdefs=%s; need --anchor" % (fn, sorted(syms)))
            return 2
        fva = va.get(fn) or va.get(fn + "_%x" % 0)
        if fva is None:
            for k, v in va.items():
                if k.startswith(fn):
                    fva = v; break
        off = syms[anchor] + fva - va[anchor]
        how = "anchor %s (+0x%x)" % (anchor, fva - va[anchor])
    vwords = [struct.unpack("<I", code[off+i*4:off+i*4+4])[0] for i in range(nwords)]
    # patch offsets in range
    prange = {}
    for pt in obj["patches2"]:
        if pt["sect"] == cs and off <= pt["off"] < off + nwords*4:
            prange[(pt["off"] - off) // 4] = pt
    ndrift = nreloc = 0
    lines = []
    for i in range(nwords):
        v, r = vwords[i], rwords[i]
        tag = ""
        pt = prange.get(i)
        if v != r:
            if pt is not None:
                nreloc += 1
                tag = "RELOC t%02x %s" % (pt["type"], pt["expr"])
            else:
                ndrift += 1
                tag = "DRIFT"
        else:
            if pt is not None:
                tag = "reloc= t%02x %s" % (pt["type"], pt["expr"])
        mark = "!" if tag.startswith("DRIFT") else (" " if not tag else "*")
        lines.append("%s %4d  V:%08X R:%08X  %-40s %s" % (mark, i, v, r, rtexts[i][:40], tag))
    verdict = "BYTE-IDENTICAL" if ndrift == 0 and nreloc == 0 else (
        "RELOC-ONLY" if ndrift == 0 else "DRIFTED(%d)" % ndrift)
    print("%s %s %s: %s  (%d words, %d reloc-covered diffs, %d drift) [loc:%s off=0x%x]" %
          (lib, member, fn, verdict, nwords, nreloc, ndrift, how, off))
    if dump or ndrift:
        for ln in lines:
            if dump or ln[0] in "!*":
                print(ln)
    return 0

if __name__ == "__main__":
    sys.exit(main())
