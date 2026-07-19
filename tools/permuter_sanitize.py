#!/usr/bin/env python3
"""Turn a preprocessed cfront-C++ reconstruction TU into pycparser-parseable C.

decomp-permuter parses its base.c with pycparser (a strict C99 parser) and then
*regenerates* the whole TU from that AST before each compile. So the context has
to be C pycparser accepts — yet still compile, via CC1PLPSX, to byte-identical
code for the function under attack.

That is possible here because EA's cfront reconstruction keeps everything that
affects layout as explicit data members:
  * vtables are explicit `__vtbl_ptr_type (*_vf)[N]` fields (no implicit vptr),
  * inheritance is explicit `_base_X` members (no `: public Base`).
So C++ member functions / ctors / dtors contribute nothing to any struct's size
or field offsets, and dropping them is layout-neutral -> byte-identical.

cfront `(...)`-only prototypes are kept verbatim — the real compile needs them
(variadic vtable dispatch) and tools/run_permuter.py teaches pycparser to accept
them, so no lossy rewrite is required.

Transforms (all layout-neutral):
  1. drop `extern "C" {` / matching `}` linkage wrappers (keep their contents),
  2. strip struct-scope method/ctor/dtor declarations AND inline definitions
     (single-line via _is_method_line; multi-line bodies via _is_method_header +
     skip -- data members kept),
  3. `Class::method` scoped calls -> `Class__method` (only in sibling bodies).

Usage:  python tools/permuter_sanitize.py <in_preprocessed.c> <out_clean.c>
"""
import re
import sys


def _is_method_line(l: str) -> bool:
    """Inside a struct body: True if l is a C++ method/ctor/dtor declaration
    (strip) rather than a data member (keep). Discriminator: look at the first
    `(` — `(*name)` is a function-pointer DATA member; `name(` is a method."""
    s = l.strip()
    if not (s.endswith(";") or s.endswith("}")):
        return False
    i = l.find("(")
    if i < 0:
        return False
    j = i + 1
    while j < len(l) and l[j] == " ":
        j += 1
    if j < len(l) and l[j] == "*":
        return False  # (*name) -> function-pointer data member
    k = i - 1
    while k >= 0 and l[k] == " ":
        k -= 1
    return k >= 0 and (l[k].isalnum() or l[k] == "_")  # name( -> method


def _is_method_header(l: str) -> bool:
    """Inside a struct body: True if l STARTS an inline C++ method/ctor/dtor
    DEFINITION whose body opens on this line (line ends with `{`), e.g.
    `Name(args) : Base(args) {` or `rettype method(args) {`. Same `name(` (vs
    `(*name)` data member) discriminator as _is_method_line, but keyed on the
    trailing `{` instead of `;`/`}` — _is_method_line only catches single-line
    declarations/bodies; an inline ctor with a member-init-list + multi-line body
    ends in `{` and would otherwise leak its `: Base(args)` + body into pycparser
    (broke every permuter job on any TU pulling in such a header, e.g.
    AIState_NonActive)."""
    s = l.strip()
    if not s.endswith("{"):
        return False
    i = l.find("(")
    if i < 0:
        return False
    j = i + 1
    while j < len(l) and l[j] == " ":
        j += 1
    if j < len(l) and l[j] == "*":
        return False  # (*name) -> function-pointer data member
    k = i - 1
    while k >= 0 and l[k] == " ":
        k -= 1
    return k >= 0 and (l[k].isalnum() or l[k] == "_")  # name( ... { -> method def


STRUCT_OPEN = re.compile(r"^\s*(typedef\s+)?(struct|union)\b.*\{\s*$")


def sanitize(text: str) -> str:
    lines = text.splitlines()
    out = []
    depth = 0
    externc_depths = set()      # brace depths opened by `extern "C" {`
    struct_depths = []          # stack of depths that are struct/union bodies
    skip_until = None           # while dropping an inline method body: depth to return to
    for l in lines:
        # --- dropping the body of an inline struct-scope method/ctor/dtor ---
        if skip_until is not None:
            depth += l.count("{") - l.count("}")
            if depth <= skip_until:
                skip_until = None
            continue
        s = l.strip()
        # --- entering bodies (decide before counting this line's braces) ---
        if 'extern "C"' in s and "{" in s:
            externc_depths.add(depth)
            depth += l.count("{") - l.count("}")
            continue            # drop the `extern "C" {` line
        if 'extern "C"' in s:    # single-line form: extern "C" int f();  -> extern int f();
            l = l.replace('extern "C"', 'extern')
            s = l.strip()
        opening_struct = STRUCT_OPEN.match(s)
        # --- closing a tracked body ---
        if s.startswith("}"):
            close_depth = depth - 1
            depth += l.count("{") - l.count("}")
            if close_depth in externc_depths:
                externc_depths.discard(close_depth)
                continue        # drop the matching `}` of extern "C"
            if struct_depths and struct_depths[-1] == close_depth:
                struct_depths.pop()
            out.append(l)
            continue
        # --- inside a struct: strip method/ctor/dtor declarations ---
        if struct_depths and depth == struct_depths[-1] + 1 and _is_method_line(l):
            depth += l.count("{") - l.count("}")
            continue
        # --- inside a struct: strip inline method/ctor/dtor DEFINITIONS (body) ---
        if struct_depths and depth == struct_depths[-1] + 1 and _is_method_header(l):
            start = depth
            depth += l.count("{") - l.count("}")
            if depth > start:           # a body opened -> skip lines until it closes
                skip_until = start
            continue
        if opening_struct:
            struct_depths.append(depth)
            # transform 4: flatten C++ real inheritance `struct D : public B {`
            # into pycparser-parseable `struct D { B _vbase_;` — the base subobject
            # is laid out first, so injecting it as the first member preserves size
            # & field offsets. (cont.30 made AIDataRecord_AccTable_t real-inherit;
            # without this every module's permuter base.c fails to parse.)
            mi = re.match(
                r"^(\s*(?:typedef\s+)?(?:struct|union)\s+\w+)\s*:\s*public\s+(\w+)\s*\{\s*$",
                l)
            if mi:
                l = mi.group(1) + " { " + mi.group(2) + " _vbase_;"
        depth += l.count("{") - l.count("}")
        out.append(l)
    return "\n".join(out).replace("::", "__")    # transform 3


_KW = ("struct", "union", "enum", "typedef")


def _fn_name(header: str):
    """If `header` (text up to a top-level body `{`) is a function definition,
    return its name, else None. Skips struct/union/enum/typedef bodies and
    aggregate initializers (`= {`)."""
    h = header.strip()
    if h.split(None, 1)[:1] and h.split()[0] in _KW:
        return None
    # the FIRST top-level '(' opens the param list — using the last ')' breaks on
    # ctors whose header carries an initializer list `Class(params) : base(args)`
    # (the last ')' is the init list's, yielding the base-member name).
    lp = h.find("(")
    if lp <= 0 or "=" in h[:lp]:
        return None
    j = lp - 1
    while j >= 0 and h[j] == " ":
        j -= 1
    k = j
    while k >= 0 and (h[k].isalnum() or h[k] == "_"):
        k -= 1
    name = h[k + 1:j + 1]
    return name if name and not name[0].isdigit() else None


def reduce_to_fn(text: str, target: str) -> str:
    """Keep every top-level declaration (types, globals, prototypes) but drop
    all function *definitions* except `target`. Sibling bodies hold the C++
    pycparser can't digest (`bool`, `new`, ...); removing them leaves a clean
    single-function TU whose object also contains only the target function."""
    lines = text.splitlines(keepends=True)
    out = []
    chunk = []          # lines of the current top-level logical unit
    header = []         # text seen before this unit's first top-level body '{'
    depth = 0
    saw_body = False
    for l in lines:
        chunk.append(l)
        for ch in l:
            if ch == "{":
                if depth == 0:
                    saw_body = True
                    header_text = "".join(header)
                depth += 1
            elif ch == "}":
                depth -= 1
            elif depth == 0 and not saw_body:
                header.append(ch)
        if depth == 0 and (l.rstrip().endswith("}") or l.rstrip().endswith(";")):
            name = _fn_name(header_text) if saw_body else None
            if name is None or name == target:
                out.extend(chunk)
            chunk, header, saw_body = [], [], False
    out.extend(chunk)   # trailing fragment, if any
    result = "".join(out)
    # pycparser (C99) chokes on C++ keywords that survive in KEPT top-level
    # prototypes/decls (e.g. a `bool foo(bool);` forward-decl elsewhere in the
    # TU). Rewrite them -- parse-only: the target fn is compiled by the real
    # CC1PLPSX, and these keywords appear only in sibling prototypes the target
    # usually doesn't call, so it's codegen-neutral (proven on hud FBuildGT4/FT4).
    result = re.sub(r'\bbool\b', 'int', result)
    result = re.sub(r'\btrue\b', '1', result)
    result = re.sub(r'\bfalse\b', '0', result)
    # C++ default-argument syntax on a surviving `extern ... (...);` PROTOTYPE
    # LINE (e.g. `extern void f(int code = 0);`) is real C++ the actual
    # CC1PLPSX compile needs (a zero-arg call site relies on the default) but
    # pycparser (C99) rejects. Parse-only, codegen-neutral: strip
    # `= <default-expr>` from the parameter list of a *bare extern prototype*
    # line only (never a function body / call-site line, which can't start
    # with `extern` + end `;` on one line without braces), so a real `=`
    # assignment anywhere else in the TU is untouched.
    result = re.sub(
        r'^(\s*extern\b[^{};\n]*\([^()]*\));\s*$',
        lambda m: re.sub(r'\s*=\s*[^,()]+(?=[,)])', '', m.group(1)) + ';',
        result, flags=re.MULTILINE)
    # C++ reference parameters `T &name` surviving in a KEPT top-level PROTOTYPE
    # (a `<rettype> <name>(<params>);` forward-decl pulled from a shared externs
    # header, e.g. `int f(char *s, RECT &r, int n);`) are C++ that pycparser can't
    # parse -- and this breaks setup for EVERY fn in the TU, even ones that never
    # call `f`. Lower `&`->`*` in the param list of such prototype lines only.
    # Parse-only & codegen-neutral: CC1PLPSX diffs only the target fn, and these
    # are sibling forward-decls it doesn't call (splat externs pull the whole
    # module API). The `(?:word[\s*]+)+word(` prefix REQUIRES a return type before
    # the fn name, so it can't match a call `foo(&bar);` (no rettype), an
    # expression `a & b` (no `(...);`), or a definition `... ) {` (ends `{` not `;`).
    def _lower_ref(m):
        # GNU inline-asm statements (`__asm__ volatile ( ... : : "r"(&x) ... );`)
        # superficially match the `<rettype> <name>( ... );` prototype shape, but
        # their `&operand`s are ADDRESS-OF, not reference params -- lowering `&`->`*`
        # corrupts a GTE macro's address operand (`(char*)&m` -> `(char*)*m`,
        # dereferencing the MATRIX/VECTOR struct -> `no match for '*MATRIX &'`).
        # Leave asm lines untouched.
        if '__asm__' in m.group(0) or re.search(r'\basm\b', m.group(0)):
            return m.group(0)
        return m.group(1) + m.group(2).replace('&', '*') + m.group(3)
    result = re.sub(
        r'^(\s*(?:[A-Za-z_]\w*[\s\*]+)+[A-Za-z_]\w*\s*\()([^;{}=]*&[^;{}=]*)(\)\s*;)\s*$',
        _lower_ref,
        result, flags=re.MULTILINE)
    # C++ bare-struct-tag-as-type: a struct/union defined as a BARE TAG
    # (`struct Tag {...};`, no typedef) and later used as a bare `Tag var;` is
    # valid C++ (the tag doubles as a type name) but not C99 -- pycparser needs
    # the `struct` keyword or a typedef, and one bare use breaks setup for the
    # whole TU (e.g. audiocmn's `Audio_tFESFXTable Audio_gFESFXTable;`). For every
    # such bare tag with no existing typedef of that name, inject a forward
    # `typedef struct Tag Tag;` alias so bare uses parse. Parse-only &
    # codegen-neutral: the alias names the same struct; CC1PLPSX (real C++) already
    # accepts the bare form and diffs only the target fn.
    typedef_names = set(re.findall(r'\btypedef\b[^;{}]*?\b(\w+)\s*;', result))   # `typedef ... N;`
    typedef_names |= set(re.findall(r'\}\s*(\w+)\s*;', result))                  # `typedef struct{...} N;`
    aliases, seen = [], set()
    for m in re.finditer(r'\b(struct|union)\s+(\w+)\s*\{', result):
        pre = result[max(0, m.start() - 9):m.start()]
        if 'typedef' in pre:              # part of `typedef struct Tag {...} Name;`
            continue
        kw, tag = m.group(1), m.group(2)
        if tag not in typedef_names and tag not in seen:
            aliases.append(f'typedef {kw} {tag} {tag};')
            seen.add(tag)
    if aliases:
        result = '\n'.join(aliases) + '\n' + result
    return result


def main():
    args = sys.argv[1:]
    if len(args) == 2:
        src = open(args[0]).read()
        open(args[1], "w").write(sanitize(src))
    elif len(args) == 4 and args[0] == "--fn":
        # --fn <target_src_name> <in> <out>
        src = sanitize(open(args[2]).read())
        open(args[3], "w").write(reduce_to_fn(src, args[1]))
    else:
        sys.exit(__doc__)


if __name__ == "__main__":
    main()
