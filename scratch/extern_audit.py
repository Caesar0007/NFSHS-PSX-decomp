#!/usr/bin/env python3
"""
extern_audit.py — tree-wide EXTERN-TYPE-vs-OWNER audit for the NFS4 PSX recon tree.

Scans recon/**/*.{h,cpp,c} and:
  1. collects every `extern` DATA-OBJECT declaration (symbol name, declared type shape, file:line)
  2. collects every non-extern, non-static, file-scope global DEFINITION (symbol name, owner type shape,
     file:line)
  3. groups by symbol name; flags:
       (a) any extern decl whose SHAPE disagrees with the owning definition's SHAPE
       (b) any symbol with 2+ CONFLICTING extern decls (different shapes) and no def found in-tree
  4. prints a report + writes a text dump of all flags for manual triage.

"Shape" = (normalized base-type text, pointer-star count, is-paren-pointer, array-dim-count).
Per the task: `T x[]` vs `T *x` vs `T **x` vs `T x[N]` are DISTINCT shapes (array vs pointer vs
double-pointer). Unsized vs sized array of the SAME element type/dim-count is treated as the SAME
shape (that's the documented deliberate `extern T arr[]` idiom) -- only dim-COUNT and pointer-ness
matter for the primary flag; an actual dimension-size mismatch (both sides sized, values differ) is
reported as a separate lower-confidence NOTE, not a primary flag.

IMPORTANT: this is a proper STATEMENT tokenizer (character-level, brace/bracket/paren-depth aware),
NOT a line-based regex scan. Multiple `;`-terminated statements per physical line (very common in
this tree's header style: `extern int gFlip;  extern int Draw_gPlayer1View;` or
`int a, b, c;`) are split correctly; an earlier line-based draft of this tool produced false-positive
"mismatches" by bleeding sibling declarators' text into each other -- do not regress to that.

Known-benign carve-outs (per task brief -- do not flag):
  - fixeddiv/rdiv-style alias pairs (different NAMES entirely -- out of scope, this tool matches by
    exact symbol name only, so aliases never collide here).
  - `extern int X_arr[] asm("X")` TU-local asm-label views -- detected via the `asm(...)` suffix and
    reported in their own bucket, not compared.
  - Lines that are entirely inside a `//` comment (the `// [owned->defined in X.cpp] extern ...`
    documentation convention) -- comments are stripped BEFORE scanning, so these vanish naturally.
"""
import re, sys, pathlib, collections

ROOT = pathlib.Path(r"C:\Temp\nfs4-wt14-a1")
RECON = ROOT / "recon"

FUNC_END_RE = re.compile(r'\b\w+\s*\([^()]*\)\s*$')          # "...name(args)" at end -> function decl
PAREN_PTR_ARR_RE = re.compile(r'^(?P<base>.*?)\(\s*(?P<stars>\*+)\s*(?P<name>[A-Za-z_]\w*)\s*\)\s*(?P<arr>(?:\[[^\]]*\])*)$')
PAREN_PTR_FUNC_RE = re.compile(r'^(?P<base>.*?)\(\s*(?P<stars>\*+)\s*(?P<name>[A-Za-z_]\w*)\s*\)\s*\([^()]*\)\s*$')
ARR_SUFFIX_RE = re.compile(r'(\[[^\]]*\])$')
ASM_LABEL_RE = re.compile(r'\basm\s*\(\s*"[^"]*"\s*\)\s*$')

QUALIFIERS = re.compile(r'\b(const|volatile|struct|class)\b')

SKIP_KEYWORDS = ('static', 'typedef', 'namespace', 'class', 'struct', 'using', 'template',
                  'public', 'private', 'protected', 'friend', 'return', 'break', 'continue', 'else',
                  'case', 'default', 'goto', 'enum', 'union', 'inline', 'virtual', 'if', 'for',
                  'while', 'switch', 'do', 'new', 'delete', 'operator')


def strip_comments(text):
    def repl_block(m):
        return '\n' * m.group(0).count('\n')
    text = re.sub(r'/\*.*?\*/', repl_block, text, flags=re.DOTALL)
    out_lines = []
    for line in text.split('\n'):
        idx = line.find('//')
        if idx != -1:
            line = line[:idx]
        out_lines.append(line)
    return '\n'.join(out_lines)


def strip_preprocessor_lines(text):
    out_lines = []
    for line in text.split('\n'):
        if line.lstrip().startswith('#'):
            out_lines.append('')
        else:
            out_lines.append(line)
    return '\n'.join(out_lines)


def norm_base(t):
    t = QUALIFIERS.sub(' ', t)
    t = re.sub(r'\s+', ' ', t).strip()
    return t


def split_top_level_commas(s):
    parts = []
    depth_br = depth_pa = 0
    cur = []
    for ch in s:
        if ch == '[':
            depth_br += 1
        elif ch == ']':
            depth_br -= 1
        elif ch == '(':
            depth_pa += 1
        elif ch == ')':
            depth_pa -= 1
        if ch == ',' and depth_br == 0 and depth_pa == 0:
            parts.append(''.join(cur))
            cur = []
        else:
            cur.append(ch)
    parts.append(''.join(cur))
    return parts


class Decl:
    __slots__ = ('name', 'kind', 'base', 'stars', 'arr_dims', 'paren_ptr', 'raw', 'file', 'line', 'is_extern')
    def __init__(self, name, kind, base, stars, arr_dims, paren_ptr, raw, file, line, is_extern):
        self.name = name; self.kind = kind; self.base = base; self.stars = stars
        self.arr_dims = arr_dims
        self.paren_ptr = paren_ptr
        self.raw = raw; self.file = file; self.line = line; self.is_extern = is_extern

    def shape_key(self):
        return (self.base, self.stars, self.paren_ptr, len(self.arr_dims))

    def shape_text(self):
        stars = '*' * self.stars
        arr = ''.join('[' + (d if d else '') + ']' for d in self.arr_dims)
        if self.paren_ptr:
            return f"{self.base} ({stars}NAME){arr}"
        return f"{self.base} {stars}NAME{arr}"


def parse_declarator(declarator):
    """Return dict(base, stars, arr_dims, paren_ptr, name, is_asm) for ONE plain data-object
    declarator, or None if it's a function/function-pointer/unparseable (out of scope)."""
    d = declarator.strip()
    if not d:
        return None

    is_asm = bool(ASM_LABEL_RE.search(d))
    if is_asm:
        d = ASM_LABEL_RE.sub('', d).strip()

    # shape B: pointer-to-array  TYPE (*NAME)[dims...]
    m = PAREN_PTR_ARR_RE.match(d)
    if m:
        base = norm_base(m.group('base'))
        stars = len(m.group('stars'))
        name = m.group('name')
        dims = re.findall(r'\[([^\]]*)\]', m.group('arr'))
        if not base or not re.match(r'^[A-Za-z_]', base):
            return None
        return dict(base=base, stars=stars, arr_dims=dims, paren_ptr=True, name=name, is_asm=is_asm)

    if PAREN_PTR_FUNC_RE.match(d):
        return None  # function-pointer variable -- out of scope for this audit

    if FUNC_END_RE.search(d):
        return None  # function declaration -- out of scope

    # shape A: plain value / pointer / array   TYPE **NAME[dims...]
    dims = []
    rest = d
    while True:
        m = ARR_SUFFIX_RE.search(rest)
        if not m:
            break
        dims.insert(0, m.group(1)[1:-1])
        rest = rest[:m.start()].rstrip()
    m = re.search(r'([A-Za-z_]\w*)\s*$', rest)
    if not m:
        return None
    name = m.group(1)
    type_and_stars = rest[:m.start()].rstrip()
    stars = type_and_stars.count('*')
    base = norm_base(type_and_stars.replace('*', ' '))
    if not base or not re.match(r'^[A-Za-z_]', base):
        return None
    # reject if 'base' still looks like it has an unbalanced/garbage leftover (e.g. only keywords)
    if base in ('extern',):
        return None
    return dict(base=base, stars=stars, arr_dims=dims, paren_ptr=False, name=name, is_asm=is_asm)


def parse_multi(declarator):
    """Handle comma-separated multi-declarators sharing one leading type ('int a, *b, c[3];')."""
    parts = split_top_level_commas(declarator)
    if len(parts) == 1:
        p = parse_declarator(parts[0])
        return [p] if p else []
    first = parse_declarator(parts[0])
    if first is None:
        return []
    results = [first]
    type_prefix = first['base']
    for seg in parts[1:]:
        seg = seg.strip()
        if not seg:
            continue
        p = parse_declarator(type_prefix + ' ' + seg)
        if p:
            results.append(p)
    return results


def tokenize_statements(text):
    """Walk the whole (comment-stripped, preprocessor-blanked) file text and yield
    (statement_text, start_line, is_file_scope) for every ';'-terminated statement encountered at
    BRACE-DEPTH 0. Statements inside function/class/namespace bodies (brace_depth>0) are consumed
    for brace-balance only, never yielded. Initializer-list braces ('X = {...}') are tracked
    separately (init_depth) so they don't get mistaken for a scope-open."""
    depth = 0            # scope brace depth (function/class/namespace bodies)
    init_depth = 0        # nested-brace depth of an in-progress initializer list at depth==0
    buf = []
    line = 1
    start_line = 1
    buf_has_eq = False
    saw_nonspace_since_stmt_start = False

    i = 0
    n = len(text)
    while i < n:
        ch = text[i]
        if ch == '\n':
            line += 1
            buf.append(ch)
            i += 1
            continue

        if depth > 0:
            # inside a function/class/namespace body: just track braces, discard content
            if ch == '{':
                depth += 1
            elif ch == '}':
                depth -= 1
                if depth == 0:
                    buf = []
                    buf_has_eq = False
                    start_line = line
            i += 1
            continue

        # depth == 0 (file scope) -----------------------------------------------------------
        if init_depth > 0:
            buf.append(ch)
            if ch == '{':
                init_depth += 1
            elif ch == '}':
                init_depth -= 1
            i += 1
            continue

        if ch == '{':
            # is this an initializer-list brace (buffer so far has a top-level '=' ) or a scope-open?
            if buf_has_eq:
                init_depth = 1
                buf.append(ch)
            else:
                depth = 1
                buf = []
                buf_has_eq = False
                start_line = line
            i += 1
            continue
        if ch == '}':
            # stray close at depth 0 (shouldn't really happen at file scope) -- resync
            buf = []
            buf_has_eq = False
            start_line = line
            i += 1
            continue
        if ch == ';':
            stmt = ''.join(buf)
            if stmt.strip():
                yield stmt, start_line
            buf = []
            buf_has_eq = False
            start_line = line
            i += 1
            continue

        if not buf and not ch.isspace():
            start_line = line
        if ch == '=' and not buf_has_eq:
            # crude top-level '=' detection: good enough since we only need it to gate the NEXT '{'
            buf_has_eq = True
        buf.append(ch)
        i += 1


def classify_statement(stmt, rel, lineno, externs, defs, asm_views):
    s = stmt.strip()
    if not s:
        return
    # a file-scope statement can itself be a sequence the tokenizer already split correctly (one
    # ';'-terminated statement per yield), so 's' here is exactly one declaration (or garbage).
    m = re.match(r'^extern\s+(?:"C(?:\+\+)?"\s*)?(.+)$', s, re.DOTALL)
    if m:
        declarator = m.group(1).strip()
        for parsed in parse_multi(declarator):
            if parsed is None:
                continue
            if parsed['is_asm']:
                asm_views.append((parsed['name'], rel, lineno, declarator))
            else:
                externs.append(Decl(parsed['name'], 'extern', parsed['base'], parsed['stars'],
                                     parsed['arr_dims'], parsed['paren_ptr'], declarator, rel, lineno, True))
        return

    first_word_m = re.match(r'^([A-Za-z_]\w*)', s)
    if first_word_m and first_word_m.group(1) in SKIP_KEYWORDS:
        return
    if s.startswith(('#', '//')):
        return

    # cut at the first top-level '=' (initializer) so 'int x[3] = {...}' -> declarator 'int x[3]'
    eq_idx = None
    b1 = b2 = 0
    for i, ch in enumerate(s):
        if ch == '[': b1 += 1
        elif ch == ']': b1 -= 1
        elif ch == '(': b2 += 1
        elif ch == ')': b2 -= 1
        elif ch == '=' and b1 == 0 and b2 == 0:
            if i > 0 and s[i-1] in '=<>!':
                continue
            if i + 1 < len(s) and s[i+1] == '=':
                continue
            eq_idx = i
            break
    declarator = s[:eq_idx] if eq_idx is not None else s
    declarator = declarator.strip()
    if not declarator:
        return
    for parsed in parse_multi(declarator):
        if parsed is None:
            continue
        if parsed['is_asm']:
            continue
        defs.append(Decl(parsed['name'], 'def', parsed['base'], parsed['stars'],
                          parsed['arr_dims'], parsed['paren_ptr'], declarator, rel, lineno, False))


def scan_file(path, rel):
    text = path.read_text(encoding='utf-8', errors='replace')
    text = strip_comments(text)
    text = strip_preprocessor_lines(text)

    externs = []
    defs = []
    asm_views = []

    for stmt, lineno in tokenize_statements(text):
        classify_statement(stmt, rel, lineno, externs, defs, asm_views)

    return externs, defs, asm_views


def main():
    files = sorted(list(RECON.rglob('*.h')) + list(RECON.rglob('*.cpp')) + list(RECON.rglob('*.c')))
    all_externs = []
    all_defs = []
    all_asm_views = []
    for f in files:
        rel = str(f.relative_to(ROOT)).replace('\\', '/')
        ex, de, av = scan_file(f, rel)
        all_externs.extend(ex)
        all_defs.extend(de)
        all_asm_views.extend(av)

    print(f"Files scanned: {len(files)}")
    print(f"Extern data-object decls found: {len(all_externs)}")
    print(f"File-scope definitions found:   {len(all_defs)}")
    print(f"asm-label extern views found:   {len(all_asm_views)}")

    by_name_ext = collections.defaultdict(list)
    for e in all_externs:
        by_name_ext[e.name].append(e)
    by_name_def = collections.defaultdict(list)
    for d in all_defs:
        by_name_def[d.name].append(d)

    symbols = sorted(set(by_name_ext) | set(by_name_def))
    print(f"Distinct symbols (extern U def): {len(symbols)}")

    flagged_vs_owner = []
    flagged_conflict_noowner = []
    flagged_multi_owner = []
    size_notes = []

    for sym in symbols:
        exts = by_name_ext.get(sym, [])
        defs_ = by_name_def.get(sym, [])
        if len(defs_) > 1:
            shapes = set(d.shape_key() for d in defs_)
            if len(shapes) > 1:
                flagged_multi_owner.append((sym, defs_))
        if defs_:
            owner = defs_[0]
            owner_shape = owner.shape_key()
            mism = [e for e in exts if e.shape_key() != owner_shape]
            if mism:
                flagged_vs_owner.append((sym, owner, mism))
            for e in exts:
                if e.shape_key() == owner_shape and e.arr_dims and owner.arr_dims:
                    for ed, od in zip(e.arr_dims, owner.arr_dims):
                        if ed and od and ed != od:
                            size_notes.append((sym, e, owner))
                            break
        else:
            shapes = set(e.shape_key() for e in exts)
            if len(shapes) > 1:
                flagged_conflict_noowner.append((sym, exts))

    out = ROOT / 'scratch' / 'extern_audit_report.txt'
    with open(out, 'w', encoding='utf-8') as f:
        f.write(f"Files scanned: {len(files)}\n")
        f.write(f"Extern decls: {len(all_externs)}  Defs: {len(all_defs)}  asm-views: {len(all_asm_views)}\n")
        f.write(f"Distinct symbols: {len(symbols)}\n\n")

        f.write(f"=== FLAGGED: extern shape != owner def shape ({len(flagged_vs_owner)} symbols) ===\n")
        for sym, owner, mism in flagged_vs_owner:
            f.write(f"\n[{sym}]\n")
            f.write(f"  OWNER DEF  {owner.file}:{owner.line}  shape={owner.shape_text()}  raw='{owner.raw}'\n")
            for e in mism:
                f.write(f"  MISMATCH   {e.file}:{e.line}  shape={e.shape_text()}  raw='{e.raw}'\n")
            others_ok = [e for e in by_name_ext.get(sym, []) if e not in mism]
            for e in others_ok:
                f.write(f"  (ok match) {e.file}:{e.line}  shape={e.shape_text()}\n")

        f.write(f"\n\n=== FLAGGED: conflicting externs, NO owner def found in tree ({len(flagged_conflict_noowner)} symbols) ===\n")
        for sym, exts in flagged_conflict_noowner:
            f.write(f"\n[{sym}]\n")
            for e in exts:
                f.write(f"  {e.file}:{e.line}  shape={e.shape_text()}  raw='{e.raw}'\n")

        f.write(f"\n\n=== FLAGGED: multiple conflicting file-scope DEFS (possible ODR issue) ({len(flagged_multi_owner)} symbols) ===\n")
        for sym, defs_ in flagged_multi_owner:
            f.write(f"\n[{sym}]\n")
            for d in defs_:
                f.write(f"  {d.file}:{d.line}  shape={d.shape_text()}  raw='{d.raw}'\n")

        f.write(f"\n\n=== NOTE (low-confidence): same shape, differing explicit array size ({len(size_notes)}) ===\n")
        for sym, e, owner in size_notes:
            f.write(f"[{sym}] extern {e.file}:{e.line} dims={e.arr_dims}  vs owner {owner.file}:{owner.line} dims={owner.arr_dims}\n")

        f.write(f"\n\n=== asm-label TU-local views (skipped from comparison, {len(all_asm_views)}) ===\n")
        for name, file, line, raw in all_asm_views:
            f.write(f"[{name}] {file}:{line}  raw='{raw}'\n")

    print(f"\nFlagged (extern-vs-owner mismatch): {len(flagged_vs_owner)}")
    print(f"Flagged (conflicting externs, no owner in-tree): {len(flagged_conflict_noowner)}")
    print(f"Flagged (multiple conflicting defs / possible ODR): {len(flagged_multi_owner)}")
    print(f"Size-mismatch notes (low-confidence): {len(size_notes)}")
    print(f"Report written to {out}")


if __name__ == '__main__':
    main()
