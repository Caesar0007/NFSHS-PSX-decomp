"""W62-A17 DECLARATION DIVERGENCE SCANNER (read-only).

Parses every file-scope declaration in recon/ (.h/.c/.cpp), normalizes the declared
type of each *data* symbol, and groups by symbol name.  Emits:
  A) symbols declared with >=2 DISTINCT normalized types  (divergence candidates)
  B) function decls with a `(...)` / K&R-empty signature   (10C float-promotion class)

Deliberately conservative: only handles simple `extern <type> a, *b, c[N];` forms and
`static <type> x asm("y");` forms.  Anything it cannot parse is reported in SKIPPED.
"""
import os
import re
import sys
import collections

ROOT = r"C:\Temp\nfs4-decomp"
RECON = os.path.join(ROOT, "recon")

BLOCK = re.compile(r"/\*.*?\*/", re.S)


def strip_comments(text):
    text = BLOCK.sub(lambda m: re.sub(r"[^\n]", " ", m.group(0)), text)
    text = re.sub(r"//[^\n]*", lambda m: " " * len(m.group(0)), text)
    return text


def walk(root, exts):
    for dp, dn, fn in os.walk(root):
        for f in sorted(fn):
            if f.endswith(exts):
                yield os.path.join(dp, f)


# --- brace-depth tracker so we only take file-scope (depth 0) statements -------
def toplevel_statements(src):
    """yield (line_no, statement_text) for every ';'-terminated run at brace depth 0"""
    depth = 0
    buf = []
    startline = 1
    line = 1
    i = 0
    n = len(src)
    while i < n:
        ch = src[i]
        if ch == "\n":
            line += 1
        if ch == "{":
            depth += 1
        elif ch == "}":
            depth -= 1
            if depth < 0:
                depth = 0
            buf = []
            startline = line
            i += 1
            continue
        if depth == 0:
            if ch == ";":
                stmt = "".join(buf).strip()
                if stmt:
                    yield startline, stmt
                buf = []
                startline = line
            else:
                if not buf and ch.isspace():
                    startline = line
                else:
                    buf.append(ch)
        i += 1


DECLSPEC = ("extern", "static", "const", "volatile", "unsigned", "signed",
            "struct", "union", "enum", "register")

FUNCPAT = re.compile(r"\)\s*$")


def parse_decl(stmt):
    """Return list of (name, normtype, kind) for a file-scope declaration statement.
    kind = 'data' | 'func'"""
    s = " ".join(stmt.split())
    if s.startswith(("#", "typedef", "class ", "namespace", "template", "using ",
                     "__asm__", "asm ", "public:", "private:", "protected:")):
        return []
    if 'extern "C"' in s and "{" in s:
        return []
    out = []
    # split off the asm("...") label + attributes
    asmlab = None
    m = re.search(r'\basm\s*\(\s*"([^"]+)"\s*\)', s)
    if m:
        asmlab = m.group(1)
        s = s[: m.start()] + s[m.end():]
    s = re.sub(r"__attribute__\s*\(\(.*?\)\)", " ", s)
    s = " ".join(s.split())
    if not s:
        return []

    # function declaration?  '(' at top level that is not a fn-pointer
    # crude: a '(' followed eventually by ')' at the end
    if "(" in s and s.rstrip().endswith(")"):
        # function pointer variable?  e.g. extern void (*f)(int)
        if re.search(r"\(\s*\*", s):
            pass  # treat as data below
        else:
            nm = re.search(r"([A-Za-z_][A-Za-z0-9_]*)\s*\(", s)
            if nm:
                args = s[s.index("(", nm.start()) :]
                out.append((nm.group(1), args.strip(), "func"))
                return out

    # data declaration: leading type, then comma-separated declarators
    # find where the declarator list begins: after the last type token
    toks = s.split()
    # peel storage/qualifier/type words until we hit something that looks like a declarator
    # strategy: the type is everything before the FIRST declarator; a declarator starts at
    # the token that (after stripping * and () ) is followed by , ; [ = or end
    # simpler: use regex on the whole string
    m = re.match(
        r"^((?:extern|static|const|volatile|register|inline)\s+)*"
        r"((?:unsigned|signed|struct|union|enum|const|volatile)\s+)*"
        r"([A-Za-z_][A-Za-z0-9_:<>]*(?:\s*\*+)?(?:\s+(?:int|char|long|short|double))*)"
        r"\s+(.*)$",
        s,
    )
    if not m:
        return []
    quals = "".join(x or "" for x in m.groups()[:2])
    base = m.group(3)
    rest = m.group(4)
    isextern = "extern" in s.split(base)[0]
    isstatic = re.match(r"^\s*static\b", s) is not None
    isvol = "volatile" in quals or re.match(r"^\s*(extern\s+)?volatile\b", s) is not None
    isconst = "const" in quals
    # split declarators on top-level commas
    parts, d, lvl = [], "", 0
    for ch in rest:
        if ch in "([":
            lvl += 1
        elif ch in ")]":
            lvl -= 1
        if ch == "," and lvl == 0:
            parts.append(d)
            d = ""
        else:
            d += ch
    parts.append(d)
    for p in parts:
        p = p.strip()
        if not p or "=" in p:
            p = p.split("=")[0].strip()
        if not p:
            continue
        nm = re.search(r"([A-Za-z_][A-Za-z0-9_]*)", p)
        if not nm:
            continue
        name = nm.group(1)
        stars = p[: nm.start()].count("*") + base.count("*")
        arr = ""
        am = re.search(r"\[([^\]]*)\]", p)
        if am is not None:
            arr = "[%s]" % am.group(1).strip()
            if p.count("[") > 1:
                arr = p[p.index("[") :].replace(" ", "")
        if "(" in p and "*" in p:
            # fn pointer or array-of-ptr-to-array; keep raw
            norm = (("volatile " if isvol else "") + base.replace(" ", "") + " " +
                    p.replace(name, "@", 1).replace(" ", ""))
        else:
            norm = (("volatile " if isvol else "") + ("const " if isconst else "") +
                    base.replace("*", "").replace(" ", "") + "*" * stars + arr)
        out.append((name, norm.strip(), "data",
                    dict(extern=isextern, static=isstatic, asmlab=asmlab, raw=stmt)))
    return out


data_decls = collections.defaultdict(list)   # symbol -> list of dict
func_decls = collections.defaultdict(list)
skipped = []

files = list(walk(RECON, (".h", ".c", ".cpp")))
for path in files:
    rel = os.path.relpath(path, ROOT).replace("\\", "/")
    raw = open(path, "r", encoding="utf-8", errors="replace").read()
    src = strip_comments(raw)
    # drop preprocessor lines
    src = re.sub(r"^[ \t]*#.*$", "", src, flags=re.M)
    for ln, stmt in toplevel_statements(src):
        if len(stmt) > 4000:
            continue
        try:
            res = parse_decl(stmt)
        except Exception as e:
            skipped.append((rel, ln, stmt[:80], str(e)))
            continue
        for item in res:
            if item[2] == "func":
                func_decls[item[0]].append(dict(file=rel, line=ln, sig=item[1], raw=stmt[:200]))
            else:
                d = item[3]
                d.update(file=rel, line=ln, type=item[1])
                data_decls[item[0]].append(d)

print("scanned %d files; %d data symbols; %d function names; %d skipped" %
      (len(files), len(data_decls), len(func_decls), len(skipped)))
print()

# ---------- A) data type divergence ----------
print("=" * 78)
print("A) DATA SYMBOLS WITH DIVERGENT DECLARED TYPES")
print("=" * 78)
ndiv = 0
rows = []
for sym in sorted(data_decls):
    ds = data_decls[sym]
    # ignore symbols only declared once
    if len(ds) < 2:
        continue
    # normalize away pure array-view differences for the FIRST cut? no - report raw
    types = collections.Counter(d["type"] for d in ds)
    if len(types) < 2:
        continue
    ndiv += 1
    rows.append((sym, ds, types))

# sort: most-divergent first
rows.sort(key=lambda r: (-len(r[2]), r[0]))
for sym, ds, types in rows:
    print("--- %s   (%d decls, %d distinct types)" % (sym, len(ds), len(types)))
    for t, c in types.most_common():
        locs = [d for d in ds if d["type"] == t]
        print("      %-42s x%-3d  %s" % (t, c, ", ".join(
            "%s:%d%s" % (d["file"], d["line"], "[asm:%s]" % d["asmlab"] if d["asmlab"] else "")
            for d in locs[:6])))
    print()
print("TOTAL divergent data symbols: %d" % ndiv)
print()

# ---------- B) (...) function decls ----------
print("=" * 78)
print("B) FUNCTION DECLS WITH A `(...)` / EMPTY SIGNATURE  (10C class)")
print("=" * 78)
nvar = 0
for fn in sorted(func_decls):
    bad = [d for d in func_decls[fn] if re.match(r"^\(\s*(\.\.\.)?\s*\)$", d["sig"])]
    if bad:
        nvar += 1
        print("%-52s %s" % (fn, ", ".join("%s:%d %s" % (d["file"], d["line"], d["sig"]) for d in bad[:6])))
print("TOTAL: %d function names with a (...)/() decl" % nvar)
print()

# ---------- C) function signature divergence ----------
print("=" * 78)
print("C) FUNCTION NAMES DECLARED WITH DIVERGENT SIGNATURES")
print("=" * 78)
nfd = 0
for fn in sorted(func_decls):
    sigs = collections.Counter(re.sub(r"\s+", "", d["sig"]) for d in func_decls[fn])
    if len(sigs) > 1:
        nfd += 1
        print("--- %s" % fn)
        for s, c in sigs.most_common():
            locs = [d for d in func_decls[fn] if re.sub(r"\s+", "", d["sig"]) == s]
            print("      %-46s x%-3d  %s" % (s[:46], c, ", ".join("%s:%d" % (d["file"], d["line"]) for d in locs[:4])))
print("TOTAL: %d function names with divergent signatures" % nfd)
