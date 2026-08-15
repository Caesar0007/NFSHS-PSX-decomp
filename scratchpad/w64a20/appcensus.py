#!/usr/bin/env python3
"""w64-a20 mission-1 EXACT worklist: compile every recon TU with the real psq43
cc1 and report what the ASPSX dialect shim changes INSIDE #APP..#NO_APP regions
(= the text that came from our source __asm__ blocks).

Why #APP-scoped: cc1's own codegen already emits NUMERIC registers ($2,$3,$6)
-- verified on nfile.c/crc.c -- so every ABI-name / .set push / alias / .type
hit in a cc1 .s is OURS, from source.  A TU with 0 in-APP changes is already
ASPSX-legal at the source level and needs no pass.

Usage: python appcensus.py [tu-rel ...]   (default: all recon TUs with a .i)
Output: JSONL rows {tu, napp, reg, pushpop, alias, rawdiv, drop, lines[]}
"""
import importlib.util, json, re, subprocess, sys, tempfile
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
spec = importlib.util.spec_from_file_location("pq", ROOT / "tools" / "psyqproof.py")
pq = importlib.util.module_from_spec(spec)
sys.modules["pq"] = pq
spec.loader.exec_module(pq)

RE_REG = pq._REG_RE
RE_PUSHPOP = re.compile(r"^\s*\.set\s+(push|pop)\s*$")
RE_ALIAS = pq._ALIAS_RE
RE_RAWDIV = pq._RAWDIV_RE
RE_DROP = pq._DROP_RE


def app_regions(text):
    """-> list of (line_index, line) for every line strictly inside #APP..#NO_APP"""
    out, inside = [], False
    for i, ln in enumerate(text.replace("\r\n", "\n").split("\n")):
        s = ln.strip()
        if s == "#APP":
            inside = True
            continue
        if s == "#NO_APP":
            inside = False
            continue
        if inside:
            out.append((i, ln))
    return out


def compile_tu(rel):
    src_rel = rel[:-2] if rel.endswith(".i") else rel
    i_file = ROOT / "build" / (src_rel + ".i")
    if not i_file.exists():
        return None, "no .i"
    tu_g, tu_extra, lane = pq.tu_settings(src_rel)
    cc1 = pq.CC1PL if src_rel.endswith(".cpp") else pq.CC1
    with tempfile.TemporaryDirectory() as td:
        s_out = Path(td) / "ps.s"
        r = subprocess.run([str(cc1), "-quiet", "-O2", f"-G{tu_g or 4}", *tu_extra,
                            str(i_file), "-o", str(s_out)],
                           capture_output=True, text=True)
        if r.returncode or not s_out.exists():
            return None, "cc1 failed: " + r.stderr[:200].replace("\n", " ")
        return s_out.read_text(errors="replace"), None


def main():
    if len(sys.argv) > 1:
        tus = [a.replace("\\", "/") for a in sys.argv[1:]]
    else:
        tus = []
        for p in sorted(ROOT.joinpath("build", "recon").rglob("*.i")):
            rel = str(p.relative_to(ROOT / "build")).replace("\\", "/")
            tus.append(rel[:-2])
    for rel in tus:
        txt, err = compile_tu(rel)
        if txt is None:
            print(json.dumps({"tu": rel, "error": err}))
            continue
        app = app_regions(txt)
        c = {"reg": 0, "pushpop": 0, "alias": 0, "rawdiv": 0, "drop": 0}
        hits = []
        for _, ln in app:
            n = len(RE_REG.findall(ln))
            if n:
                c["reg"] += n
            if RE_PUSHPOP.match(ln):
                c["pushpop"] += 1
            if RE_ALIAS.match(ln):
                c["alias"] += 1
            if RE_RAWDIV.match(ln):
                c["rawdiv"] += 1
            if RE_DROP.match(ln):
                c["drop"] += 1
            if n or RE_PUSHPOP.match(ln) or RE_ALIAS.match(ln) or \
               RE_RAWDIV.match(ln) or RE_DROP.match(ln):
                hits.append(ln.rstrip())
        row = {"tu": rel, "napp": len(app)}
        row.update(c)
        row["total"] = sum(c.values())
        if row["total"]:
            row["sample"] = hits[:6]
        print(json.dumps(row))
        sys.stdout.flush()


if __name__ == "__main__":
    main()
