#!/usr/bin/env python3
r"""catalog_gapfinder.py — surface matched-function TRICKS not yet in the ASM pattern catalog.

It COLLECTS, it does NOT classify (the symptom->fix framing needs judgment). Two sources:
  (1) git commit subjects that mention matching  (the fix-tag is in the message)
  (2) recon/ comments tagging a trick: `MATCH:` (preferred convention) + free-form markers
Each harvested (function, fix-text) is bucketed:
  - NOVEL   = its vocabulary hits NO known catalog pattern-keyword AND the fn isn't named
              in the catalog  -> these are the real gaps; review & add a symptom row.
  - COVERED = matches a known pattern -> grouped, so you can enrich the example lists.

Usage:
  python tools/catalog_gapfinder.py [--catalog PATH] [--since GITREV] [--all]
    --catalog PATH  catalog .md to dedup against (default $NFS4_CATALOG or the memory path)
    --since GITREV  only scan commits in GITREV..HEAD (default: all history)
    --all           also print the COVERED groups (default: NOVEL + summary only)

Convention going forward: tag the matching trick in the recon comment with `MATCH:` e.g.
    newLen = p[1] + 4;   /* MATCH: function-scope split temp keeps len in $v0 */
so the harvester has a clean anchor instead of guessing from free-form prose.
"""
import os, re, sys, subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
RECON = ROOT / "recon"
DEFAULT_CATALOG = Path(os.environ.get(
    "NFS4_CATALOG",
    r"C:/Users/Vyacheslav/.claude/projects/C--Temp-claud/memory/reference_asm_pattern_catalog.md"))

# --- known catalog pattern-keywords (lowercase substrings). A fix-text containing ANY of
#     these is treated as an already-catalogued pattern. SEED from the catalog vocabulary;
#     extend when you add a genuinely new pattern category. ---
KNOWN_PATTERNS = [
    # A. coloring / coalescing
    "coloring", "coalesce", "coalescing", "v0/v1", "a0/a1", "register swap", "reg swap",
    "index-form", "array-index", "array index", "nested if", "nested-if", "&&", "||",
    "direct return", "direct-return", "in-place", "dead-ptr", "dead pointer",
    "^zero", "^ zero", "runtime-zero", "runtime zero", "multi-basin", "basin", "re-seed",
    "pseudo numbering", "function-scope", "block-local", "declaration order", "decl order",
    "unused local", "unused;",
    # B. loops
    "rotation", "rotate", "down-count", "split load", "split the load", "split-load",
    "post-incr", "post-increment", "delay slot", "delay-slot",
    # C. arithmetic
    "u_short", "u_char", "0xffff", "0xff mask", "promotion", "expand-div", "div+break",
    "div-guard", "break guard", "__builtin_abs", "abs idiom", "reassoc", "split temp",
    "mfhi", "high-part", "high part", "transpose", "/256", "/2 ",
    # D. structure / mangling
    "flattened", "free-fn", "free fn", "method", "mangl", "class::", "__fp", "not in object",
    "deleting", "__in_chrg", "inheritance", "vptr", "extern-c", "extern c", "nullsub",
    "tail-merge", "tail merge", "tail-merged", "duplicated-call", "p-vs-r",
    "reference-vs-pointer", "__fr", "dtor", "re-attribut",
    # E. gp-rel / reloc / data
    "gp-rel", "gprel", "gp rel", "tentative-def", "tentative def", "unsized", "-g4", "-g0",
    "lo16", "reloc addend", "base-anchor", "base anchor",
    # F. scheduling / epilogue
    "store-in-branch", "noreorder", "epilogue", "sll-scheduling", "eval-order", "eval order",
    # G. bios / lib / toolchain
    "bios_thunk", "thunk", "tail-call", "sotn", "psyz", "psy-q-decomp", "psxsdk",
    "ctc2", "sign-ext", "rematerial",
]

MARKERS = [  # free-form recon-comment markers (fallback when no MATCH: tag)
    "match:", "to match", "for match", "doesn't match", "does not match", "do not remove",
    "do NOT remove".lower(), "reverts to", "@hack", "pseudo numbering", "codegen device",
    "byte-match", "near-miss", "near miss",
]

BANNER = re.compile(r"/\*\s*-+\s*([A-Za-z_][\w:]*?__[\w]+|[A-Za-z_]\w+)\b")  # /* ---- Name__sig ... */
# a C/C++ function-definition header (loose): has (...), not a control kw / call / decl
SIGLINE = re.compile(r"^[A-Za-z_][\w\s\*:&]*\b([A-Za-z_][\w:]*)\s*\([^;{]*\)\s*$")
CTRLKW = ("if", "for", "while", "switch", "return", "else", "do", "sizeof")


def harvest_git(since):
    rng = [f"{since}..HEAD"] if since else []
    out = subprocess.run(["git", "log", "--no-merges", "--pretty=format:%h%x09%s", *rng],
                         cwd=ROOT, capture_output=True, text=True).stdout
    items = []
    rx = re.compile(r"\b(match|crack|byte-?match|diff|coloring|coalesc|gp-?rel|reloc|"
                    r"delay|epilogue|sched|rematerial|sign|swap|guard|\bdiv\b|mask|pin|"
                    r"thunk|mangl|dtor|fuse|fusion|transpose|tail-?merge)\b", re.I)
    # bulk bookkeeping commits (no single pattern) — wave/cluster/import counts
    skip = re.compile(r"(cluster|\bwave\b|modules,|near-misses across|dense modules|"
                      r"bulk-import|^recon: import)", re.I)
    for ln in out.splitlines():
        if "\t" not in ln:
            continue
        h, subj = ln.split("\t", 1)
        if not rx.search(subj) or skip.search(subj):
            continue
        # function token: word with __ (mangled) or CamelCase_with_caps; else the lead phrase
        m = re.search(r"\b([A-Za-z_]\w*__\w+|[A-Z][A-Za-z0-9]*_[A-Za-z0-9_]+|[A-Z][a-z]+[A-Z]\w+)\b", subj)
        fn = m.group(1) if m else "(multi)"
        items.append((fn, f"commit {h}", subj.strip()))
    return items


def enclosing_fn(lines, i):
    """walk backward from line i for the nearest banner or function-sig header."""
    for j in range(i, max(-1, i - 60), -1):
        b = BANNER.search(lines[j])
        if b and "----" in lines[j]:
            return b.group(1)
    for j in range(i, max(-1, i - 60), -1):
        s = lines[j].strip()
        if not s or s.startswith(("/*", "*", "//", "#")):
            continue
        m = SIGLINE.match(s)
        if m and not s.split("(")[0].strip().split()[-1] in CTRLKW \
                and not any(s.startswith(k) for k in CTRLKW):
            nxt = lines[j + 1].strip() if j + 1 < len(lines) else ""
            if s.endswith("{") or nxt.startswith("{"):
                return m.group(1)
    return "(?)"


def harvest_comments():
    items = []
    for f in sorted(RECON.rglob("*.cpp")) + sorted(RECON.rglob("*.h")):
        try:
            lines = f.read_text(errors="replace").splitlines()
        except Exception:
            continue
        rel = f.relative_to(ROOT).as_posix()
        for i, ln in enumerate(lines):
            low = ln.lower()
            tag = None
            mm = re.search(r"\bMATCH:\s*(.+?)(?:\*/|//|$)", ln)
            if mm:
                tag = mm.group(1).strip().rstrip("*/ ").strip()
            elif any(k in low for k in MARKERS):
                # only treat comment lines as markers (avoid code w/ 'match' substrings)
                if "/*" in ln or "*" == ln.lstrip()[:1] or "//" in ln:
                    tag = re.sub(r"^.*?(/\*|//|\*)\s*", "", ln).rstrip("*/ ").strip()
            if tag:
                items.append((enclosing_fn(lines, i), f"{rel}:{i+1}", tag))
    return items


def main():
    args = sys.argv[1:]
    catalog = DEFAULT_CATALOG
    since = None
    show_all = "--all" in args
    if "--catalog" in args:
        catalog = Path(args[args.index("--catalog") + 1])
    if "--since" in args:
        since = args[args.index("--since") + 1]

    cat_text = catalog.read_text(errors="replace").lower() if catalog.exists() else ""
    if not cat_text:
        print(f"[warn] catalog not found at {catalog} — everything will look novel.")

    def covered(fn, tag):
        t = tag.lower()
        if fn != "(?)" and fn != "(multi)" and fn.lower() in cat_text:
            return "fn-in-catalog"
        for k in KNOWN_PATTERNS:
            if k in t:
                return k
        return None

    git_items = harvest_git(since)
    com_items = harvest_comments()
    allitems = [("git", *x) for x in git_items] + [("comment", *x) for x in com_items]

    novel, groups = [], {}
    seen = set()
    for src, fn, loc, tag in allitems:
        key = (fn, re.sub(r"\s+", " ", tag.lower())[:80])
        if key in seen:
            continue
        seen.add(key)
        c = covered(fn, tag)
        if c is None:
            novel.append((fn, loc, tag))
        else:
            groups.setdefault(c, []).append((fn, loc))

    print("=== CATALOG GAP-FINDER ===")
    print(f"catalog : {catalog}  ({'found' if cat_text else 'MISSING'})")
    print(f"sources : git={len(git_items)} match-commits, comments={len(com_items)} "
          f"(MATCH: + markers)\n")

    print(f"--- NOVEL tricks (vocabulary not in catalog -- REVIEW & ADD a symptom row) [{len(novel)}] ---")
    for fn, loc, tag in novel:
        print(f"  {fn:<34} {loc:<26} :: {tag[:90]}")
    if not novel:
        print("  (none — catalog vocabulary covers every harvested trick)")

    if show_all:
        print(f"\n--- COVERED (grouped by matched pattern; enrich examples if a fn is missing) ---")
        for k in sorted(groups, key=lambda k: -len(groups[k])):
            fns = sorted({fn for fn, _ in groups[k] if fn not in ("(?)", "(multi)")})
            print(f"  [{k}] ({len(groups[k])})  {', '.join(fns[:18])}{' …' if len(fns) > 18 else ''}")

    covered_n = sum(len(v) for v in groups.values())
    print(f"\nsummary : {len(novel)} novel / {covered_n} covered / {len(seen)} unique harvested")
    print("note    : COLLECTS only — classify the NOVEL rows into symptom->fix by hand.")


if __name__ == "__main__":
    main()
