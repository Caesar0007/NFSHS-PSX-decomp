#!/usr/bin/env python3
"""jeb.py -- auxiliary JEB 5.42 per-function decompile oracle for NFS4.

Dump: C:/JEB-542/nfs4  (one sub_<VA>.c per function, full-binary JEB decompile).
SYM : nfs4-f-v3.txt    (trusted v3 SYM; resolves sub_/gvar_ tokens to real names).

Usage:
  python tools/jeb.py 800eb234              # by VA (0x prefix optional, any case)
  python tools/jeb.py iSPCH_BankMemAlloc    # by exact SYM name
  python tools/jeb.py iSPCH_                # substring -> lists matches
  python tools/jeb.py --raw 800eb234        # skip name resolution

CAVEAT (verified 2026-07-28 on iSPCH_BankMemAlloc/iSPCH_MemAlloc): JEB drops
call ARGUMENTS on this binary (calls render bare).  Use it for control-flow /
dataflow shape only; IDA (nfs4-psx-IDA.c) stays the authority for arity+args.

Env overrides: NFS4_JEB_DIR, NFS4_SYM.
"""
import os
import re
import sys

JEB_DIR = os.environ.get("NFS4_JEB_DIR", r"C:\JEB-542\nfs4")
SYM_TXT = os.environ.get(
    "NFS4_SYM", r"C:\Temp\claud\dumpsym_clean\dumpsym_src\nfs4-f-v3.txt")

SYM_RE = re.compile(r"^[0-9a-f]+:\s+\$([0-9a-f]{8})\s+\d+\s+(\S+)\s*$")
TOK_RE = re.compile(r"\b(sub|gvar)_([0-9A-Fa-f]{8})\b")


def load_sym():
    va2name, name2va = {}, {}
    with open(SYM_TXT, encoding="utf-8", errors="replace") as f:
        for line in f:
            m = SYM_RE.match(line.strip())
            if not m:
                continue
            va, name = m.group(1).lower(), m.group(2)
            va2name.setdefault(va, name)
            name2va.setdefault(name, va)
    return va2name, name2va


def resolve_target(arg, name2va):
    a = arg.lower().lstrip("$")
    if a.startswith("0x"):
        a = a[2:]
    if re.fullmatch(r"[0-9a-f]{1,8}", a):
        return a.zfill(8), None
    if arg in name2va:
        return name2va[arg], None
    ci = {n.lower(): v for n, v in name2va.items()}
    if a in ci:
        return ci[a], None
    hits = sorted(n for n in name2va if a in n.lower())
    return None, hits


def main():
    argv = [x for x in sys.argv[1:] if x != "--raw"]
    raw = "--raw" in sys.argv
    if len(argv) != 1:
        sys.exit(__doc__)
    va2name, name2va = load_sym()
    va, hits = resolve_target(argv[0], name2va)
    if va is None:
        if hits:
            for n in hits[:40]:
                print(f"  {name2va[n]}  {n}")
            sys.exit(f"'{argv[0]}': not a VA/name; {len(hits)} substring matches above")
        sys.exit(f"'{argv[0]}': no such VA or SYM name")

    path = os.path.join(JEB_DIR, f"sub_{va.upper()}.c")
    if not os.path.isfile(path):
        sys.exit(f"no JEB dump for ${va} ({va2name.get(va, '?')}): {path} missing")

    body = open(path, encoding="utf-8", errors="replace").read()
    print(f"// ${va} = {va2name.get(va, '<not in SYM>')}  [{path}]")
    if raw:
        print(body)
        return

    legend = {}

    def sub(m):
        tva = m.group(2).lower()
        name = va2name.get(tva)
        if not name:
            return m.group(0)
        legend[tva] = name
        return name

    print(TOK_RE.sub(sub, body))
    if legend:
        print("// --- resolved symbols ---")
        for tva in sorted(legend):
            print(f"//   ${tva} = {legend[tva]}")


if __name__ == "__main__":
    main()
