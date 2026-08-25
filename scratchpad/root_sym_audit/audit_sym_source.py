"""Read-only SYM-to-source declaration audit for reconstructed NFS4 functions.

This intentionally lives in scratchpad: tools/ is orchestrator-owned.  It joins
the trusted PsyQ SYM function blocks with Universal Ctags' view of reconstructed
C/C++ functions.  GCC-v2-mangled EXT/function names are linkage identities and
are decoded only for mapping; reconstructed C++ keeps demangled source names.
The REGPARM/ARG/REG/AUTO entries are the source-declaration evidence compared by
this audit.  The report is evidence for manual review, not an auto-fixer:
optimized-away debug locals and deliberate matching carriers both need oracle
validation before source is changed.
"""

from __future__ import annotations

import argparse
import collections
import functools
import json
import re
import subprocess
import sys
from dataclasses import dataclass, field
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
DEFAULT_SYM = Path(r"C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt")


@dataclass
class Decl:
    cls: str
    name: str
    typ: str
    tag: str = ""
    size: int = 0
    dims: str = ""
    raw_home: str = ""

    @property
    def display_type(self) -> str:
        toks = self.typ.split()
        ptrs = toks.count("PTR")
        base = toks[-1] if toks else ""
        base_map = {
            "INT": "int",
            "UINT": "unsigned int",
            "LONG": "long",
            "ULONG": "unsigned long",
            "SHORT": "short",
            "USHORT": "unsigned short",
            "CHAR": "char",
            "UCHAR": "unsigned char",
            # SYM base type 0 with the class-record boolean flag is GCC's
            # native C++ `bool`.  It is not the reconstruction's EA-style
            # `typedef int BOOL`; `...b` parameter mangling independently
            # proves the source spelling for parameter-bearing functions.
            "BOOL": "bool",
            "VOID": "void",
            "FLOAT": "float",
            "DOUBLE": "double",
        }
        if base in ("STRUCT", "UNION", "ENUM") and self.tag:
            text = self.tag
        else:
            text = base_map.get(base, base.lower())
        # PsyQ records constructors from the outside in.  In particular,
        # `PTR ARY SHORT dims 1 32` is `short (*)[32]`, not `short *[32]`;
        # preserving the parentheses prevents a false SYM type finding for a
        # pointer-to-array global such as Track_gInViewList.
        constructors = toks[:-1]
        leading_ptrs = 0
        for constructor in constructors:
            if constructor != "PTR":
                break
            leading_ptrs += 1
        if (
            leading_ptrs
            and constructors[leading_ptrs:]
            and all(c == "ARY" for c in constructors[leading_ptrs:])
            and self.dims
        ):
            nums = self.dims.split()
            try:
                count = int(nums[0])
            except (IndexError, ValueError):
                count = 0
            suffix = "".join("[%s]" % n for n in nums[1 : 1 + count])
            return f"{text} ({'*' * leading_ptrs}){suffix}"
        text += "*" * ptrs
        if "ARY" in toks and self.dims:
            nums = self.dims.split()
            if nums:
                try:
                    count = int(nums[0])
                    text += "".join("[%s]" % n for n in nums[1 : 1 + count])
                except ValueError:
                    pass
        return text


@dataclass
class SymFunction:
    name: str = ""
    va: str = ""
    source_file: str = ""
    source_line: int = 0
    fsize: int = 0
    mask: str = ""
    linkage_cls: str = ""
    return_type: str = ""
    decls: list[Decl] = field(default_factory=list)


@dataclass
class SymGlobal:
    obj: str
    va: str
    decl: Decl


@dataclass
class SourceFunction:
    path: str
    name: str
    scope: str
    line: int
    end: int
    signature: str
    typeref: str
    file_scope: bool = False
    decls: list[dict] = field(default_factory=list)

    @property
    def qualified(self) -> str:
        return f"{self.scope}::{self.name}" if self.scope else self.name


FUNC_START = re.compile(r"^(\S+): \$([0-9a-fA-F]{8}) 8c Function start")
FUNC_END = re.compile(r"^\S+: \$[0-9a-fA-F]{8} 8e Function end")
FILE_REC = re.compile(
    r"^\S+: \$[0-9a-fA-F]{8} 94 Def class FILE type NULL size 0 name (\S+)"
)
DEF = re.compile(
    r"^(\S+): \$([0-9a-fA-F]{8}) 9[46] Def2? class (\w+) "
    r"type (.+?) size (\d+)(.*?) name (\S+)\s*$"
)


def parse_sym(path: Path) -> list[SymFunction]:
    top_linkage: dict[tuple[str, str], tuple[str, str]] = {}
    in_function = False
    all_lines = path.read_text(encoding="utf-8", errors="replace").splitlines()
    for line in all_lines:
        if FUNC_START.match(line):
            in_function = True
            continue
        if FUNC_END.match(line):
            in_function = False
            continue
        if in_function:
            continue
        dm = DEF.match(line)
        if (
            dm
            and dm.group(3) in ("EXT", "STAT")
            and dm.group(4).split()
            and dm.group(4).split()[0] == "FCN"
        ):
            mid = dm.group(6)
            tag_m = re.search(r"\btag\s+(\S*)", mid)
            return_decl = Decl(
                cls=dm.group(3),
                name="",
                typ=" ".join(token for token in dm.group(4).split() if token != "FCN"),
                tag=(tag_m.group(1) if tag_m else ""),
                size=int(dm.group(5)),
            )
            top_linkage[("0x" + dm.group(2).lower(), dm.group(7))] = (
                dm.group(3),
                return_decl.display_type,
            )

    result: list[SymFunction] = []
    cur: SymFunction | None = None
    for line in all_lines:
        m = FUNC_START.match(line)
        if m:
            cur = SymFunction(va="0x" + m.group(2).lower())
            continue
        if cur is None:
            continue
        stripped = line.strip()
        if stripped.startswith("name = ") and not cur.name:
            cur.name = stripped[7:].strip()
            continue
        if stripped.startswith("file = "):
            cur.source_file = stripped[7:].strip()
            continue
        if stripped.startswith("line = "):
            try:
                cur.source_line = int(stripped[7:].strip())
            except ValueError:
                pass
            continue
        if stripped.startswith("fsize = "):
            try:
                cur.fsize = int(stripped[8:].strip())
            except ValueError:
                pass
            continue
        if stripped.startswith("mask = "):
            cur.mask = stripped[7:].strip()
            continue
        dm = DEF.match(line)
        if dm:
            mid = dm.group(6)
            tag_m = re.search(r"\btag\s+(\S*)", mid)
            dims_m = re.search(r"\bdims\s+([\d ]+)", mid)
            cur.decls.append(
                Decl(
                    cls=dm.group(3),
                    name=dm.group(7),
                    typ=dm.group(4).strip(),
                    tag=(tag_m.group(1) if tag_m else ""),
                    size=int(dm.group(5)),
                    dims=(dims_m.group(1).strip() if dims_m else ""),
                    raw_home=dm.group(2),
                )
            )
            continue
        if " 8e Function end" in line:
            if cur.name:
                cur.linkage_cls, cur.return_type = top_linkage.get(
                    (cur.va, cur.name), ("", "")
                )
                result.append(cur)
            cur = None
    return result


def parse_sym_globals(path: Path) -> list[SymGlobal]:
    """Return object-owned top-level EXT/STAT data records.

    A SYM FILE record terminates the preceding object's symbol block.  Function
    debug declarations are excluded explicitly; FCN records are linkage
    identities and belong to the function audit, not the data audit.
    """
    result: list[SymGlobal] = []
    pending: list[tuple[str, Decl]] = []
    in_function = False
    for line in path.read_text(encoding="utf-8", errors="replace").splitlines():
        if FUNC_START.match(line):
            in_function = True
            continue
        if FUNC_END.match(line):
            in_function = False
            continue
        fm = FILE_REC.match(line)
        if fm:
            obj = fm.group(1)
            result.extend(SymGlobal(obj=obj, va=va, decl=decl) for va, decl in pending)
            pending = []
            continue
        if in_function:
            continue
        dm = DEF.match(line)
        if not dm or dm.group(3) not in ("EXT", "STAT"):
            continue
        typ = dm.group(4).strip()
        # A top-level `FCN T` record is a function linkage identity.  A
        # `PTR FCN T` record is data: a file/global function-pointer object.
        # The old broad membership test silently dropped the two latter
        # records in this SYM (Draw_gSyncCallback and gCurrentBlitter).
        if typ.split() and typ.split()[0] == "FCN":
            continue
        mid = dm.group(6)
        tag_m = re.search(r"\btag\s+(\S*)", mid)
        dims_m = re.search(r"\bdims\s+([\d ]+)", mid)
        pending.append(
            (
                "0x" + dm.group(2).lower(),
                Decl(
                    cls=dm.group(3),
                    name=dm.group(7),
                    typ=typ,
                    tag=(tag_m.group(1) if tag_m else ""),
                    size=int(dm.group(5)),
                    dims=(dims_m.group(1).strip() if dims_m else ""),
                    raw_home=dm.group(2),
                ),
            )
        )
    return result


def ctags_records(paths: list[Path]) -> list[dict]:
    if not paths:
        return []
    command = [
        "ctags",
        "--output-format=json",
        "--fields=+neKSt",
        "--extras=+q",
        "--kinds-C++=+lz",
        "--kinds-C=+lz",
        "-o",
        "-",
        *[str(p) for p in paths],
    ]
    proc = subprocess.run(command, cwd=ROOT, capture_output=True, text=True)
    if proc.returncode:
        sys.stderr.write(proc.stderr)
        raise SystemExit(proc.returncode)
    records = []
    for line in proc.stdout.splitlines():
        try:
            rec = json.loads(line)
        except json.JSONDecodeError:
            continue
        if rec.get("_type") == "tag":
            records.append(rec)
    return records


def source_functions(records: list[dict]) -> tuple[list[SourceFunction], dict[str, list[dict]]]:
    funcs: list[SourceFunction] = []
    file_decls: dict[str, list[dict]] = collections.defaultdict(list)
    by_qualified: dict[tuple[str, str], list[SourceFunction]] = collections.defaultdict(list)
    by_simple: dict[tuple[str, str], list[SourceFunction]] = collections.defaultdict(list)
    for rec in records:
        if rec.get("kind") != "function" or "line" not in rec:
            continue
        scope = rec.get("scope", "") if rec.get("scopeKind") == "class" else ""
        fn = SourceFunction(
            path=Path(rec["path"]).name.lower(),
            name=rec["name"],
            scope=scope,
            line=int(rec["line"]),
            end=int(rec.get("end", rec["line"])),
            signature=rec.get("signature", ""),
            typeref=rec.get("typeref", ""),
            file_scope=bool(rec.get("file")),
        )
        funcs.append(fn)
        by_qualified[(fn.path, fn.qualified)].append(fn)
        by_simple[(fn.path, fn.name)].append(fn)

    for rec in records:
        if rec.get("kind") in ("variable", "externvar") and not rec.get("scope"):
            file_decls[Path(rec["path"]).name.lower()].append(rec)
        if rec.get("kind") not in ("local", "parameter"):
            continue
        file_name = Path(rec["path"]).name.lower()
        scope = rec.get("scope", "")
        candidates = list(by_qualified.get((file_name, scope), []))
        if not candidates:
            candidates = list(by_simple.get((file_name, scope), []))
        fn = None
        if len(candidates) == 1:
            fn = candidates[0]
        elif candidates:
            rec_line = int(rec.get("line", 0))
            containing = [f for f in candidates if f.line <= rec_line <= f.end]
            if len(containing) == 1:
                fn = containing[0]
            elif containing:
                fn = min(containing, key=lambda f: (f.end - f.line, abs(f.line - rec_line)))
        if fn is not None:
            fn.decls.append(rec)
    return funcs, file_decls


def add_register_asm_locals(sources: list[Path], funcs: list[SourceFunction]) -> None:
    """Recover function locals carrying an explicit GCC hard-register annotation.

    Universal Ctags 6.x omits declarations such as
    ``register int value asm("$21")`` entirely.  These are permitted, narrowly
    documented reconstruction carriers, and skipping them creates both false
    missing-SYM findings and an incomplete source-local census.  Admit only a
    single declaration ending in a literal MIPS register annotation, then bind
    it to the unique function whose ctags line range contains it.
    """
    register_asm = re.compile(
        r'^\s*register\s+(.+?[\s*&])([A-Za-z_]\w*)\s+'
        r'(?:__asm__|asm)\s*\("\$[A-Za-z0-9]+"\)\s*;',
        re.M,
    )
    by_file: dict[str, list[SourceFunction]] = collections.defaultdict(list)
    for fn in funcs:
        by_file[fn.path].append(fn)
    for source in sources:
        try:
            text = source.read_text(encoding="utf-8", errors="replace")
        except OSError:
            continue
        candidates = by_file.get(source.name.lower(), [])
        for match in register_asm.finditer(text):
            line = text.count("\n", 0, match.start()) + 1
            owners = [fn for fn in candidates if fn.line <= line <= fn.end]
            if len(owners) != 1:
                continue
            fn = owners[0]
            name = match.group(2)
            if any(row.get("name") == name for row in fn.decls):
                continue
            fn.decls.append(
                {
                    "name": name,
                    "kind": "local",
                    "typeref": "typename:" + match.group(1).strip(),
                    "line": line,
                    "pattern": match.group(0),
                    "asm_register": True,
                }
            )


def add_included_header_definitions(
    sources: list[Path], headers: list[Path], records: list[dict], file_decls: dict[str, list[dict]]
) -> None:
    """Attribute header-defined file statics to each TU that includes them.

    The reconstruction deliberately keeps many retail TU statics in the owning
    `<stem>_externs.h`.  Ctags does not follow includes when run on a `.cpp`, so
    a source-only audit falsely reports those definitions as missing.
    """
    header_set = {p.resolve() for p in headers}
    records_by_header: dict[Path, list[dict]] = collections.defaultdict(list)
    for rec in records:
        path = Path(rec.get("path", "")).resolve()
        if path in header_set and rec.get("kind") == "variable" and not rec.get("scope"):
            # Universal Ctags does not emit its `file` field for namespace-level
            # `static` variables parsed from headers.  Recover that property from
            # the declaration text so the TU-attributed copy keeps internal
            # linkage in the audit.
            try:
                source_line = path.read_text(
                    encoding="utf-8", errors="replace"
                ).splitlines()[int(rec["line"]) - 1]
            except (OSError, KeyError, ValueError, IndexError):
                source_line = ""
            if re.match(r"^\s*static\b", source_line):
                rec = dict(rec)
                rec["file"] = True
            records_by_header[path].append(rec)

    include_re = re.compile(r'^\s*#\s*include\s+"([^"]+)"', re.M)

    def closure(path: Path) -> set[Path]:
        found: set[Path] = set()
        stack = [path.resolve()]
        while stack:
            current = stack.pop()
            try:
                text = current.read_text(encoding="utf-8", errors="replace")
            except OSError:
                continue
            for include in include_re.findall(text):
                candidate = (current.parent / include).resolve()
                if candidate in header_set and candidate not in found:
                    found.add(candidate)
                    stack.append(candidate)
        return found

    for source in sources:
        dest = file_decls[source.name.lower()]
        for header in closure(source):
            dest.extend(records_by_header.get(header, []))


def add_asm_label_definitions(
    sources: list[Path], file_decls: dict[str, list[dict]]
) -> None:
    """Recover file-static definitions whose C identifier is an asm-label carrier.

    Universal Ctags 6.x skips declarations such as
    `static int storage asm("retailName")`.  The retail asm label, rather than
    the carrier identifier, is the source-level data identity relevant to SYM.
    Keep the parser deliberately narrow: only file-scope `static` declarations
    with a literal asm label are admitted, so extern alias views cannot be
    mistaken for owning definitions.
    """
    asm_def = re.compile(
        r'^\s*static\s+(.+?)([A-Za-z_]\w*)\s*((?:\[\d*\])*)\s+'
        r'asm\("([A-Za-z_]\w*)"\)',
        re.M,
    )
    for source in sources:
        try:
            text = source.read_text(encoding="utf-8", errors="replace")
        except OSError:
            continue
        rows = file_decls[source.name.lower()]
        known = {row.get("name") for row in rows}
        for match in asm_def.finditer(text):
            retail_name = match.group(4)
            if retail_name in known:
                continue
            rows.append(
                {
                    "name": retail_name,
                    "kind": "variable",
                    "typeref": "typename:" + match.group(1).strip() + match.group(3),
                    "file": True,
                    "line": text.count("\n", 0, match.start()) + 1,
                    "pattern": match.group(0),
                    "asm_carrier": match.group(2),
                }
            )
            known.add(retail_name)


def decode_member(sym_name: str) -> tuple[str, str]:
    ctor = re.fullmatch(r"__(\d+)([A-Za-z_]\w*)", sym_name)
    if ctor and len(ctor.group(2)) >= int(ctor.group(1)):
        cls = ctor.group(2)[: int(ctor.group(1))]
        return cls, cls
    dtor = re.fullmatch(r"_\._(\d+)([A-Za-z_]\w*)", sym_name)
    if dtor and len(dtor.group(2)) >= int(dtor.group(1)):
        cls = dtor.group(2)[: int(dtor.group(1))]
        return "~" + cls, cls
    """Return (simple function name, class name) for common GCC v2 manglings."""
    ctor = re.match(r"^__(\d+)(.+)$", sym_name)
    if ctor:
        n = int(ctor.group(1))
        cls = ctor.group(2)[:n]
        return cls, cls
    dtor = re.match(r"^_\._(\d+)(.+)$", sym_name)
    if dtor:
        n = int(dtor.group(1))
        cls = dtor.group(2)[:n]
        return "~" + cls, cls
    if "__F" in sym_name:
        return sym_name.split("__F", 1)[0], ""
    split = sym_name.rfind("__")
    if split >= 0:
        simple = sym_name[:split]
        tail = sym_name[split + 2 :]
        # GCC v2's Q<n> encoding names a nested scope as a sequence of
        # length-prefixed components, e.g. Q26Speech7CarBank.  The flattened
        # reconstruction declares that innermost class at file scope, which is
        # also the scope Universal Ctags reports for its member definitions.
        qm = re.match(r"Q(\d)(.+)", tail)
        if qm:
            count = int(qm.group(1))
            rest = qm.group(2)
            scopes: list[str] = []
            for _ in range(count):
                nm = re.match(r"(\d+)", rest)
                if not nm:
                    break
                n = int(nm.group(1))
                rest = rest[len(nm.group(1)) :]
                if len(rest) < n:
                    break
                scopes.append(rest[:n])
                rest = rest[n:]
            if len(scopes) == count:
                return simple, scopes[-1]
        cm = re.match(r"(\d+)(.+)", tail)
        if cm:
            n = int(cm.group(1))
            cls = cm.group(2)[:n]
            return simple, cls
    return sym_name, ""


def source_basename(sym_path: str) -> str:
    return re.split(r"[\\/]", sym_path)[-1].lower()


STRICT_NATIVE_BOOL = False


def norm_type(text: str) -> str:
    text = text.removeprefix("typename:")
    text = re.sub(r"\b(const|volatile|register|static)\b", "", text)
    replacements = {
        "u_int": "unsigned int",
        "uint": "unsigned int",
        "u_long": "unsigned long",
        "ulong": "unsigned long",
        "u_short": "unsigned short",
        "ushort": "unsigned short",
        "u_char": "unsigned char",
        "uchar": "unsigned char",
        "byte": "unsigned char",
    }
    # `bool` stays distinct from the project's `BOOL` typedef.  Although both
    # occupy four bytes under CC1PLPSX, native bool assignments can normalize
    # values and GCC-v2 encodes bool parameters as `b` rather than `i`.
    for old, new in replacements.items():
        text = re.sub(rf"\b{re.escape(old)}\b", new, text)
    text = re.sub(r"\s+", " ", text.strip())
    text = text.replace(" *", "*").replace(" &", "&")
    text = re.sub(r"\s+\(&\)", "(&)", text)
    text = re.sub(r"\s+\(\*\)", "(*)", text)
    return re.sub(r"\s+(?=\[)", "", text)


def source_record_type(rec: dict) -> str:
    """Recover pointer-to-array dimensions that Universal Ctags truncates.

    For declarations such as `char (*fMemIcon)[15][3][192]` (global or local), Ctags 6.x reports
    only `char (*)[15]` in typeref even though its declaration pattern retains
    all dimensions.  Use the pattern only for this narrow declarator shape so
    the audit compares the source actually written rather than hiding genuine
    fixed-array disagreements.
    """
    source_type = norm_type(rec.get("typeref", ""))
    name = rec.get("name", "")
    pattern = rec.get("pattern", "")
    if "(*" not in source_type or not name or not pattern:
        return source_type
    pointer_array = re.search(
        rf"\(\s*\*\s*{re.escape(name)}\s*((?:\[\d+\])+)\s*\)\s*((?:\[\d+\])+)",
        pattern,
    )
    if pointer_array:
        # `T (*name[N])[A][B]`: SYM prints this constructor as
        # `T*[N][A][B]`, while Ctags truncates the final dimensions.
        base = source_type.split("(*", 1)[0].rstrip()
        return base + "*" + pointer_array.group(1) + pointer_array.group(2)
    match = re.search(
        rf"\(\s*\*\s*{re.escape(name)}\s*\)\s*((?:\[\d+\])+)", pattern
    )
    if not match:
        return source_type
    base = source_type.split("(*)", 1)[0]
    return base + "(*)" + match.group(1)


def source_global_type(rec: dict) -> str:
    """Compatibility name for the global-data audit call site."""
    return source_record_type(rec)


@functools.lru_cache(maxsize=1)
def function_pointer_typedefs() -> frozenset[str]:
    """Return real source typedef names whose declarator is a function pointer.

    Ctags reports a parameter written with such a typedef as only the typedef
    name, while PsyQ records its lowered ``PTR FCN`` constructor.  Resolve the
    declaration from reconstructed headers instead of hard-coding individual
    typedef names or treating arbitrary pointer-sized aliases as equivalent.
    """
    typedef_re = re.compile(
        r"\btypedef\s+[^;]*?\(\s*\*\s*([A-Za-z_]\w*)\s*\)\s*\([^;]*\)\s*;",
        re.S,
    )
    names: set[str] = set()
    for header in (ROOT / "recon").rglob("*.h"):
        try:
            names.update(
                typedef_re.findall(header.read_text(encoding="utf-8", errors="replace"))
            )
        except OSError:
            continue
    return frozenset(names)


@functools.lru_cache(maxsize=1)
def named_type_aliases() -> dict[str, str]:
    """Recover source typedef aliases whose SYM spelling is the underlying tag.

    PsyQ writes ``typedef struct CARDINFO_def { ... } CARDINFO`` parameters as
    ``PTR STRUCT tag CARDINFO_def`` in the debug stream, while ctags correctly
    reports the source spelling ``CARDINFO *``.  Resolve only aliases proven by
    reconstructed declarations; do not equate arbitrary same-sized types.
    Definitions with bodies are brace-matched so function-pointer fields and
    comments cannot make a broad regular expression consume another typedef.
    """
    candidates: dict[str, set[str]] = collections.defaultdict(set)
    sources = [
        path
        for path in (ROOT / "recon").rglob("*")
        if path.suffix.lower() in {".h", ".c", ".cpp"}
    ]
    aggregate_start = re.compile(
        r"\btypedef\s+(?:struct|union|enum)\s+([A-Za-z_]\w*)\s*\{"
    )
    aggregate_forward = re.compile(
        r"\btypedef\s+(?:struct|union|enum)\s+([A-Za-z_]\w*)\s+"
        r"([A-Za-z_]\w*)\s*;"
    )
    simple_alias = re.compile(
        r"\btypedef\s+([A-Za-z_]\w*)\s+([A-Za-z_]\w*)\s*;"
    )
    for path in sources:
        try:
            text = path.read_text(encoding="utf-8", errors="replace")
        except OSError:
            continue
        for match in aggregate_forward.finditer(text):
            candidates[match.group(2)].add(match.group(1))
        for match in simple_alias.finditer(text):
            candidates[match.group(2)].add(match.group(1))
        for match in aggregate_start.finditer(text):
            tag = match.group(1)
            opening = match.end() - 1
            depth = 0
            closing = -1
            for index in range(opening, len(text)):
                if text[index] == "{":
                    depth += 1
                elif text[index] == "}":
                    depth -= 1
                    if depth == 0:
                        closing = index
                        break
            if closing < 0:
                continue
            alias_match = re.match(
                r"\s*([A-Za-z_]\w*)\s*;", text[closing + 1 :]
            )
            if alias_match:
                candidates[alias_match.group(1)].add(tag)

    # A name with conflicting reconstructed definitions is not safe evidence.
    aliases = {
        alias: next(iter(targets))
        for alias, targets in candidates.items()
        if len(targets) == 1
    }
    # Collapse unambiguous alias chains (e.g. CARDINFO -> CARDINFO_def).
    for alias in list(aliases):
        seen = {alias}
        target = aliases[alias]
        while target in aliases and target not in seen:
            seen.add(target)
            target = aliases[target]
        aliases[alias] = target
    return aliases


def expand_named_type_alias(text: str) -> str:
    """Expand one leading typedef name while retaining pointer/array shape."""
    match = re.fullmatch(r"([A-Za-z_]\w*)(.*)", text)
    if not match:
        return text
    target = named_type_aliases().get(match.group(1))
    return (target + match.group(2)) if target else text


def compatible_decl_types(sym_rows: list[Decl], src_rows: list[dict]) -> tuple[bool, str]:
    """Recognize PsyQ debug encodings that are not source-type conflicts.

    The SYM represents C++ references as PTR records.  It also records some
    stack-passed narrow scalar parameters as ABI-width INT ARGs even though the
    GCC-v2 linkage spelling retains the declared short/char/bool type.  Finally,
    PTR FCN records preserve only a generic function-pointer shape here because
    the SYM record does not carry the full prototype.
    """
    sym_types = {norm_type(d.display_type) for d in sym_rows}
    src_types = {source_record_type(d) for d in src_rows}
    if sym_types & src_types:
        return True, "exact"

    expanded_src_types = {expand_named_type_alias(t) for t in src_types}
    if sym_types & expanded_src_types:
        return True, "source-typedef-tag"

    # PsyQ's CHAR debug record does not retain the target's explicit source
    # signedness.  This project compiles plain char unsigned, while selected
    # source sites spell signed char to reproduce `lb`; both remain CHAR in SYM.
    def erase_char_sign(text: str) -> str:
        return re.sub(r"\b(?:signed|unsigned) char\b", "char", text)

    if {erase_char_sign(t) for t in sym_types} & {
        erase_char_sign(t) for t in src_types
    }:
        return True, "char-debug-signedness"

    # In a C translation unit ctags preserves the `struct` namespace as
    # `struct:tag`, whereas PsyQ's STRUCT/PTR debug display prints only `tag`.
    # This is the same named tag and pointer/array constructor, not a typedef
    # substitution.  Keep this normalization C-specific by requiring ctags'
    # explicit `struct:` marker on the source side.
    for sym_type in sym_types:
        for src_type in src_types:
            c_tag = re.fullmatch(r"struct:([A-Za-z_]\w*)(.*)", src_type)
            if c_tag and c_tag.group(1) + c_tag.group(2) == sym_type:
                return True, "c-struct-tag"

    for src_type in src_types:
        if src_type.endswith("&") and src_type[:-1] + "*" in sym_types:
            return True, "reference-as-pointer"
        array_ref = re.fullmatch(r"(.+)\(&\)(\[.+\])", src_type)
        if array_ref and array_ref.group(1) + "(*)" + array_ref.group(2) in sym_types:
            return True, "reference-as-pointer"

    # Function-local anonymous enums keep only a synthetic ._<n> tag in the
    # PsyQ debug stream; Ctags independently synthesizes __anon<n>.  Their enum
    # kind is the reliable identity, just as for anonymous global structs.
    if any(re.fullmatch(r"\._\d+", typ) for typ in sym_types):
        if any(
            re.fullmatch(r"enum:(?:[A-Za-z_]\w*::)*__anon[0-9A-Fa-f]+", typ)
            for typ in src_types
        ):
            return True, "anonymous-enum-tag"

    # GCC's VLA debug records add the runtime pointer constructor and record a
    # zero bound.  Ctags reports the declared source array.  Normalize those
    # two views without hiding fixed-size array disagreements.
    for sym_type in sym_types:
        for src_type in src_types:
            ptr_array = re.fullmatch(r"(.+)\(\*\)\[0\]", sym_type)
            source_array = re.fullmatch(r"(.+)\[\]", src_type)
            if ptr_array and source_array and ptr_array.group(1) == source_array.group(1):
                return True, "vla-runtime-pointer"
            if sym_type.endswith("*[0]") and source_array:
                if sym_type[:-4] == source_array.group(1):
                    return True, "vla-runtime-pointer"

    narrow_scalars = {
        "char",
        "signed char",
        "unsigned char",
        "short",
        "unsigned short",
        "bool",
    }
    if any(d.get("kind") == "parameter" for d in src_rows):
        for sym_decl in sym_rows:
            # PsyQ records the promoted ABI/debug view of narrow C/C++
            # parameters as INT even when the source declaration (and its
            # mangled name) is char/short.  Storage class says where that
            # promoted value lives, not whether promotion occurred.
            if norm_type(sym_decl.display_type) == "int":
                if src_types & narrow_scalars:
                    if sym_decl.cls == "ARG":
                        return True, "promoted-stack-argument"
                    if sym_decl.cls == "REGPARM":
                        return True, "promoted-register-argument"
                    return True, "promoted-debug-parameter"

    if any("FCN" in d.typ.split() for d in sym_rows):
        if any(
            "(*" in norm_type(d.get("typeref", ""))
            or norm_type(d.get("typeref", "")).startswith("fn_")
            for d in src_rows
        ) or bool(src_types & function_pointer_typedefs()):
            return True, "generic-function-pointer"

    return False, ""


def compatible_return_types(sym_type: str, src_type: str) -> bool:
    """Compare function return types retained by the top-level SYM FCN record."""
    sym_type = norm_type(sym_type)
    src_type = norm_type(src_type)
    if not sym_type or not src_type:
        return True
    if sym_type == src_type:
        return True
    if expand_named_type_alias(src_type) == sym_type:
        return True
    # Ctags keeps the C tag namespace in the return typeref.  PsyQ prints the
    # same named enum/struct tag without the namespace prefix.
    c_tag = re.fullmatch(r"(?:struct|union|enum):([A-Za-z_]\w*)(.*)", src_type)
    if c_tag and c_tag.group(1) + c_tag.group(2) == sym_type:
        return True
    erase_char_sign = lambda text: re.sub(
        r"\b(?:signed|unsigned) char\b", "char", text
    )
    if erase_char_sign(sym_type) == erase_char_sign(src_type):
        return True
    # As with parameter records, PsyQ represents C++ references as pointers.
    return src_type.endswith("&") and src_type[:-1] + "*" == sym_type


def compatible_global_types(sym_type: str, source_type: str) -> tuple[bool, str]:
    """Recognize global debug encodings that do not contradict source layout.

    PsyQ's `CHAR` record does not retain an explicit `signed char` spelling,
    while the reconstruction sometimes must spell it to reproduce signed byte
    loads under this target's unsigned-plain-char compiler mode.  Anonymous
    structs likewise receive unrelated synthetic tags from SYM and ctags; the
    array shape is the reliable portion of those records.  PsyQ emits both
    `._N` and `.Nfake` spellings for anonymous struct tags.
    """
    if source_type == "signed " + sym_type and sym_type.startswith("char"):
        return True, "explicit-signed-char"

    sym_anon = re.fullmatch(r"(?:\._\d+|\.\d+fake)((?:\[\d+\])*)", sym_type)
    source_anon = re.fullmatch(
        r"struct:__anon[0-9A-Fa-f]+((?:\[\d+\])*)", source_type
    )
    if sym_anon and source_anon and sym_anon.group(1) == source_anon.group(1):
        return True, "anonymous-struct-tag"

    return False, ""


def compatible_split_array_carrier(sym_type: str, source_type: str) -> bool:
    """Compare a SYM array with its measured per-element storage definition.

    Removing the first array bound gives the type of one retail element.  Ctags
    writes pointer-to-array declarators as ``T(*)[N]`` whereas SYM flattens the
    same constructor to ``T*[N]``; normalize that spelling before comparing.
    This is used only for an explicit ``SYM-CARRIER`` name, never heuristically.
    """
    source_element = source_type.replace("(*)", "*")
    sym_element = re.sub(r"\[\d*\]", "", sym_type, count=1)
    if sym_element == source_element:
        return True

    # The inverse carrier is also used: a retail scalar is deliberately
    # declared as a one-element/unsized source array so GCC materializes its
    # address in a separate temporary before loading the value.
    source_scalar = re.sub(r"\[\d*\]", "", source_element, count=1)
    return source_scalar == sym_type


def documented_global_types(
    target: Path, file_name: str
) -> tuple[set[str], set[str], set[str]]:
    """Return measured array carriers plus explicit type/storage overrides."""
    source = target / file_name
    paths = [source, *target.glob(source.stem + "*.h")]
    chunks: list[str] = []
    for path in paths:
        try:
            chunks.append(path.read_text(encoding="utf-8", errors="replace"))
        except OSError:
            pass
    if not chunks:
        return set(), set(), set()
    text = "\n".join(chunks)
    carriers = set(re.findall(r"\bSYM-CARRIER:\s*([A-Za-z_]\w*)", text))
    overrides = set(re.findall(r"\bSYM-TYPE-OVERRIDE:\s*([A-Za-z_]\w*)", text))
    storage_overrides = set(
        re.findall(r"\bSYM-STORAGE-OVERRIDE:\s*([A-Za-z_]\w*)", text)
    )
    return carriers, overrides, storage_overrides


def asm_data_labels() -> set[str]:
    """Return raw data labels and validated C-name aliases onto that lane."""
    labels: set[str] = set()
    for path in (ROOT / "asm/data").glob("**/*.s"):
        try:
            text = path.read_text(encoding="utf-8", errors="replace")
        except OSError:
            continue
        labels.update(re.findall(r"^dlabel\s+([A-Za-z_]\w*)\s*$", text, re.M))

    # Several reconstructed TUs already use the correct SYM name while the
    # extracted assembly retains a temporary D_<VA> label.  An explicit extern
    # asm-label declaration proves the two names share storage; count the C name
    # as blob-backed only when its target is an actual extracted data label.
    alias_re = re.compile(
        r'^\s*extern\b[^;\n]*?\b([A-Za-z_]\w*)\s*'
        r'(?:\[[^\]]*\]\s*)*(?:__asm__|asm)\s*'
        r'\(\s*"([A-Za-z_]\w*)"\s*\)',
        re.M,
    )
    aliases: set[str] = set()
    for path in (ROOT / "recon").glob("**/*"):
        if path.suffix.lower() not in {".h", ".c", ".cpp"}:
            continue
        try:
            text = path.read_text(encoding="utf-8", errors="replace")
        except OSError:
            continue
        for source_name, blob_name in alias_re.findall(text):
            if blob_name in labels:
                aliases.add(source_name)
    labels.update(aliases)
    return labels


def map_function(sym: SymFunction, candidates: list[SourceFunction]) -> tuple[SourceFunction | None, str]:
    simple, cls = decode_member(sym.name)
    file_name = source_basename(sym.source_file)
    same_file = [f for f in candidates if f.path == file_name]

    # Retail attributes this C-linkage accessor to MEMCARD.C, while the exact
    # reconstruction deliberately keeps its shared frontend implementation in
    # common/mcrd.cpp.  The catalog and the 18/18 instruction gate both confirm
    # that ownership closure; mapping it here is safer than moving a matched TU.
    cross_tu_owners = {
        ("memcard.c", "MCRD_getcard"): ("mcrd.cpp", "MCRD_getcard", ""),
    }
    owner = cross_tu_owners.get((file_name, sym.name))
    if owner:
        owner_hits = [
            f for f in candidates
            if (f.path, f.name, f.scope) == owner
        ]
        if len(owner_hits) == 1:
            return owner_hits[0], "cross-tu-owner"

    # These four retail symbols are deleting destructors.  Their current exact
    # reconstructions are explicit-this ABI carriers because GCC 2.x otherwise
    # synthesizes a different destructor body for these inheritance shapes.
    # Each carrier is individually verify_asm PASS; keep this table narrow and
    # evidence-backed rather than treating arbitrary linkage spellings as equal.
    destructor_abi_carriers = {
        "_._13AIState_Chase": "___13AIState_Chase",
        "_._15AIState_Offroad": "___15AIState_Offroad",
        "_._17AIState_Purgatory": "___17AIState_Purgatory",
        "_._14AIState_Donuts": "___14AIState_Donuts",
    }
    carrier_name = destructor_abi_carriers.get(sym.name)
    if carrier_name:
        carrier_hits = [f for f in same_file if f.name == carrier_name]
        if len(carrier_hits) == 1:
            return carrier_hits[0], "abi-carrier"

    exact = [f for f in same_file if f.name == simple and f.scope == cls]
    if len(exact) == 1:
        return exact[0], "exact"
    overload_hints = {
        "Draw__27tMenuItemGoToMenuNFS4Buttoniib": "(int x,int y,bool selected)",
        "Draw__20tMenuItemSlidingMenub": "(bool selected)",
        "Draw__20tMenuItemSlidingMenuiib": "(int offx,int offy,bool selected)",
        "Draw__9tMenuItemiib": "(int x,int y,bool selected)",
        "Draw__9tMenuItemiiib": "(int x,int y,int w,bool selected)",
        "CalcFadeVal__Fiii": "(int col1,int col2,int amount)",
        "CalcFadeVal__Fii": "(int col1,int amount)",
        "CalcFadeVal__Fiiii": "(int col1,int col2,int amount,int fFade)",
        "__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme": "firstItem,...)",
        "__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vs": "short title)",
        # game/common overloads: GCC-v2 parameter encodings uniquely select
        # these ctags signatures.  Their addresses are also recorded beside
        # the definitions and each function has an authoritative asm oracle.
        "AILife_PlaceCarAtLocation__FP8Car_tObjiiiii": "int slice,int desiredLatPos,int direction,int currentSpeed,int rotation1024)",
        "AILife_PlaceCarAtLocation__FP8Car_tObji": "(Car_tObj * carObj,int rotation1024)",
        "AIWorld_ZSplineDistance__FP8Car_tObjT0": "Car_tObj * carObj,Car_tObj * otherCarObj)",
        "AIWorld_ZSplineDistance__FP8coorddefT0P10matrixtdef": "coorddef * pos1,coorddef * pos2,matrixtdef * roadMatrix)",
        "AIWorld_ApxSplineDistance__FP8Car_tObjT0": "Car_tObj * carObj,Car_tObj * otherCarObj)",
        "AIWorld_ApxSplineDistance__FP8Car_tObji": "Car_tObj * carObj,int location)",
        "AIWorld_ApxSplineDistance__FiP8Car_tObj": "int location,Car_tObj * carObj)",
        "AIWorld_ApxSplineDistance__Fii": "int locationA,int locationB)",
        "AIWorld_SplineDistance__FP8Car_tObjT0": "Car_tObj * carObj,Car_tObj * otherCarObj)",
        "AIWorld_SplineDistance__FP8Car_tObjiP8coorddef": "Car_tObj * carObj,int location,coorddef * position)",
        "__10AnimScripti": "(int num)",
        "__10AnimScriptii": "(int num,int numParts)",
        "__10AnimScriptP5Groupiii": "(Group * instanceGroup,int type,int boomIndex,int numParts)",
        "GetTimedAnimPosRot__10AnimScriptP8coorddefP10matrixtdef": "(coorddef * pt,matrixtdef * mat)",
        "GetTimedAnimPosRot__10AnimScriptiP8coorddefP10matrixtdef": "(int index,coorddef * pt,matrixtdef * mat)",
    }
    hint = overload_hints.get(sym.name)
    if hint:
        hinted = [f for f in exact if hint in f.signature]
        if len(hinted) == 1:
            return hinted[0], "exact-signature"
    linkage_spelled = [f for f in same_file if f.name == sym.name]
    if len(linkage_spelled) == 1:
        return linkage_spelled[0], "linkage-spelled"
    simple_hits = [f for f in same_file if f.name == simple]
    if len(simple_hits) == 1:
        return simple_hits[0], "simple"
    return None, "ambiguous" if simple_hits else "unmapped"


def documented_sym_names(target: Path, src: SourceFunction) -> set[str]:
    """Read explicit, oracle-receipted SYM carrier/optimization mappings."""
    path = target / src.path
    try:
        body = path.read_text(encoding="utf-8", errors="replace").splitlines()[
            src.line - 1 : src.end
        ]
    except OSError:
        return set()
    text = "\n".join(body)
    return set(
        re.findall(r"\bSYM-(?:CARRIER|OPTIMIZED):\s*([A-Za-z_]\w*)", text)
    )


def documented_codegen_names(target: Path, src: SourceFunction) -> set[str]:
    """Return source-only temporaries with measured byte-matching receipts."""
    path = target / src.path
    try:
        body = path.read_text(encoding="utf-8", errors="replace").splitlines()[
            src.line - 1 : src.end
        ]
    except OSError:
        return set()
    text = "\n".join(body)
    return set(
        re.findall(r"\bSYM-CODEGEN-CARRIER:\s*([A-Za-z_]\w*)", text)
    )


def documented_function_type_overrides(target: Path, src: SourceFunction) -> set[str]:
    """Return measured lexical types retained despite a conflicting SYM row."""
    path = target / src.path
    try:
        body = path.read_text(encoding="utf-8", errors="replace").splitlines()[
            src.line - 1 : src.end
        ]
    except OSError:
        return set()
    return set(
        re.findall(
            r"\bSYM-TYPE-OVERRIDE:\s*([A-Za-z_]\w*)", "\n".join(body)
        )
    )


def documented_inline_locals(
    target: Path, src: SourceFunction, src_fns: list[SourceFunction]
) -> tuple[list[dict], dict[str, str]]:
    """Resolve SYM locals owned by an inlined source helper.

    PsyQ places an inlined callee's debug locals inside the emitted caller's
    function block.  A flat source-only audit therefore cannot find those
    names in the caller even when the original helper and its lexical local
    have both been restored.  ``SYM-INLINE-LOCAL: local = Helper`` is a narrow
    ownership receipt: admit the declaration only when ctags finds exactly one
    same-TU helper and that helper really declares the named local.
    """
    path = target / src.path
    try:
        body = path.read_text(encoding="utf-8", errors="replace").splitlines()[
            src.line - 1 : src.end
        ]
    except OSError:
        return [], {}
    body_text = "\n".join(body)
    mappings = re.findall(
        r"\bSYM-INLINE-LOCAL:\s*([A-Za-z_]\w*)\s*=\s*([A-Za-z_]\w*)",
        body_text,
    )
    resolved: list[dict] = []
    owners: dict[str, str] = {}
    for local_name, helper_name in mappings:
        helpers = [
            fn
            for fn in src_fns
            if fn.path == src.path and fn.name == helper_name
        ]
        if len(helpers) != 1:
            continue
        declarations = [
            decl for decl in helpers[0].decls if decl.get("name") == local_name
        ]
        if not declarations:
            continue
        resolved.extend(declarations)
        owners[local_name] = helper_name

    # Inline C++ member receivers are implicit and therefore absent from
    # ctags' local/parameter rows.  Admit a narrow `this` receipt only when
    # the caller visibly invokes the named member and a real inline body is
    # present in the reconstruction's shared type header.  This keeps the
    # marker evidentiary rather than turning it into a generic suppression.
    inline_this = re.findall(
        r"\bSYM-INLINE-THIS:\s*([A-Za-z_]\w*)", body_text
    )
    type_header = ROOT / "recon" / "nfs4_types.h"
    try:
        type_text = type_header.read_text(encoding="utf-8", errors="replace")
    except OSError:
        type_text = ""
    for helper_name in inline_this:
        invoked = re.search(rf"(?:->|\.)\s*{re.escape(helper_name)}\s*\(", body_text)
        defined = re.search(
            rf"\b{re.escape(helper_name)}\s*\([^;{{}}]*\)\s*(?:const\s*)?{{",
            type_text,
        )
        if invoked and defined:
            owners["this"] = helper_name
    return resolved, owners


def documented_macro_locals(
    target: Path, src: SourceFunction
) -> tuple[list[dict], dict[str, str]]:
    """Resolve repeated SYM lexical blocks owned by a same-TU macro.

    A macro expansion can give PsyQ several same-named debug locals in nested
    line-1 blocks even though Ctags cannot see declarations inside ``#define``
    replacement text.  ``SYM-MACRO-LOCALS: a, b = MACRO x3`` is accepted only
    when the macro exists in the same source file, declares every named local,
    and the audited function invokes it exactly the stated number of times.
    This validates the restored source shape instead of exempting missing names.
    """
    path = target / src.path
    try:
        full_lines = path.read_text(encoding="utf-8", errors="replace").splitlines()
    except OSError:
        return [], {}
    body_text = "\n".join(full_lines[src.line - 1 : src.end])
    mappings = re.findall(
        r"\bSYM-MACRO-LOCALS:\s*"
        r"([A-Za-z_]\w*(?:\s*,\s*[A-Za-z_]\w*)*)\s*=\s*"
        r"([A-Za-z_]\w*)\s+x(\d+)",
        body_text,
    )
    resolved: list[dict] = []
    owners: dict[str, str] = {}
    for local_list, macro_name, expansion_text in mappings:
        expected_expansions = int(expansion_text)
        if len(re.findall(rf"\b{re.escape(macro_name)}\s*\(", body_text)) != expected_expansions:
            continue
        start = next(
            (
                index
                for index, line in enumerate(full_lines)
                if re.match(
                    rf"^\s*#\s*define\s+{re.escape(macro_name)}\b", line
                )
            ),
            None,
        )
        if start is None:
            continue
        macro_lines = [full_lines[start]]
        while macro_lines[-1].rstrip().endswith("\\") and start + len(macro_lines) < len(full_lines):
            macro_lines.append(full_lines[start + len(macro_lines)])
        macro_text = "\n".join(macro_lines)
        local_rows: list[dict] = []
        for local_name in [name.strip() for name in local_list.split(",")]:
            declaration = re.search(
                rf"\b((?:(?:const|signed|unsigned)\s+)*[A-Za-z_]\w*(?:\s*\*)?)"
                rf"\s+{re.escape(local_name)}\s*(?:=|;)",
                macro_text,
            )
            if declaration is None:
                local_rows = []
                break
            local_rows.append(
                {
                    "name": local_name,
                    "kind": "local",
                    "typeref": "typename:" + declaration.group(1).strip(),
                    "line": start + 1,
                    "pattern": declaration.group(0),
                    "macro_local": macro_name,
                }
            )
        if not local_rows:
            continue
        resolved.extend(local_rows)
        owner = f"{macro_name} x{expected_expansions}"
        owners.update({row["name"]: owner for row in local_rows})
    return resolved, owners


def audit(
    sym_fns: list[SymFunction],
    sym_globals: list[SymGlobal],
    src_fns: list[SourceFunction],
    file_decls: dict[str, list[dict]],
    target: Path,
) -> str:
    target_names = {p.name.lower() for p in target.glob("*.cpp")} | {
        p.name.lower() for p in target.glob("*.c")
    }
    selected = [f for f in sym_fns if source_basename(f.source_file) in target_names]
    lines = [
        "# SYM-to-source declaration audit",
        "",
        f"Target: `{target}`",
        f"Trusted SYM: `{DEFAULT_SYM}`",
        "",
        "This is a review queue, not an auto-fix list. Missing retail names are",
        "strong evidence; extra source names can be matching carriers or decompiler",
        "temporaries and must be tested against the function oracle before removal.",
        "GCC-v2-mangled function/EXT names are used only as linkage keys; source",
        "functions are mapped to their demangled C++ names and class scopes.",
        "",
    ]
    mapped = 0
    exact = 0
    linkage_spelled = 0
    abi_carrier_total = 0
    cross_tu_owner_total = 0
    missing_total = 0
    extra_total = 0
    type_total = 0
    type_equivalent_total = 0
    type_equivalent_reasons: collections.Counter[str] = collections.Counter()
    function_storage_total = 0
    implicit_generated_total = 0
    implicit_generated_rows: list[SymFunction] = []
    clean = 0
    documented_total = 0
    documented_rows: list[tuple[SymFunction, set[str]]] = []
    inline_local_total = 0
    inline_local_rows: list[tuple[SymFunction, dict[str, str]]] = []
    macro_local_total = 0
    macro_local_rows: list[tuple[SymFunction, dict[str, str]]] = []
    codegen_total = 0
    codegen_rows: list[tuple[SymFunction, set[str]]] = []
    function_type_override_total = 0
    function_type_override_rows: list[tuple[SymFunction, set[str]]] = []
    findings: list[tuple[SymFunction, SourceFunction | None, str, list[str], list[str], list[str]]] = []

    for sf in selected:
        src, quality = map_function(sf, src_fns)
        if src is None:
            if sf.name in {"__11tAllScreens", "_._11tAllScreens"}:
                implicit_generated_total += 1
                implicit_generated_rows.append(sf)
                continue
            findings.append((sf, None, quality, [], [], []))
            continue
        mapped += 1
        exact += quality in ("exact", "exact-signature")
        linkage_spelled += quality == "linkage-spelled"
        abi_carrier_total += quality == "abi-carrier"
        cross_tu_owner_total += quality == "cross-tu-owner"
        sym_decls = [d for d in sf.decls if d.cls in ("REGPARM", "ARG", "REG", "AUTO", "STAT")]
        ignored_names = {"this", "__in_chrg", "__vtt_parm"}
        sym_names = {d.name for d in sym_decls if d.name not in ignored_names}
        src_decls = list(src.decls)
        inline_decls, inline_owners = documented_inline_locals(
            target, src, src_fns
        )
        src_decls.extend(inline_decls)
        if inline_owners:
            inline_local_total += len(inline_owners)
            inline_local_rows.append((sf, inline_owners))
        macro_decls, macro_owners = documented_macro_locals(target, src)
        src_decls.extend(macro_decls)
        if macro_owners:
            macro_local_total += len(macro_owners)
            macro_local_rows.append((sf, macro_owners))
        stat_names = {d.name for d in sym_decls if d.cls == "STAT"}
        src_decls.extend(
            d for d in file_decls.get(source_basename(sf.source_file), []) if d["name"] in stat_names
        )
        src_names = {d["name"] for d in src_decls}
        documented = documented_sym_names(target, src) & sym_names
        if documented:
            documented_total += len(documented)
            documented_rows.append((sf, documented))
        # A hard-register annotation is a reconstruction carrier only when its
        # base name is absent from SYM.  SYM-owned names such as DesiredSlice
        # remain ordinary matched declarations even though their allocation is
        # constrained explicitly in the reconstruction.
        asm_codegen = {
            d["name"]
            for d in src.decls
            if d.get("asm_register") and d["name"] not in sym_names
        }
        codegen = documented_codegen_names(target, src) | asm_codegen
        if codegen:
            codegen_total += len(codegen)
            codegen_rows.append((sf, codegen))
        function_type_overrides = documented_function_type_overrides(target, src)
        missing = sorted(sym_names - src_names - documented)
        # Universal Ctags synthesizes unstable __anon... identifiers for
        # intentionally unnamed C++ parameters.  They are not source names and
        # therefore cannot be SYM declaration mismatches.
        source_ignored_names = {"__volatile__"}
        if quality == "abi-carrier":
            # The explicit receiver and deleting-destructor control parameter
            # represent SYM's implicit `this`/`__in_chrg`, not source locals.
            source_ignored_names.update({"pThis", "__in_chrg"})
        source_local_names = {
            d["name"]
            for d in src.decls
            if not d["name"].startswith("__anon") and d["name"] not in source_ignored_names
        }
        extra = sorted(source_local_names - sym_names - codegen)
        type_mismatch: list[str] = []
        source_linkage = "STAT" if src.file_scope else "EXT"
        if sf.linkage_cls and sf.linkage_cls != source_linkage:
            function_storage_total += 1
            type_mismatch.append(
                f"[storage] SYM {sf.linkage_cls} vs source {source_linkage}"
            )
        is_ctor_or_dtor = bool(src.scope) and src.name in {
            src.scope,
            "~" + src.scope,
        }
        if (
            not is_ctor_or_dtor
            and not compatible_return_types(sf.return_type, src.typeref)
        ):
            type_mismatch.append(
                f"[return] SYM {norm_type(sf.return_type)} vs source "
                f"{norm_type(src.typeref)}"
            )
        sym_by_name: dict[str, list[Decl]] = collections.defaultdict(list)
        src_by_name: dict[str, list[dict]] = collections.defaultdict(list)
        for d in sym_decls:
            if d.name not in ignored_names:
                sym_by_name[d.name].append(d)
        for d in src_decls:
            src_by_name[d["name"]].append(d)
        for name in sorted(sym_by_name.keys() & src_by_name.keys()):
            sym_types = {norm_type(d.display_type) for d in sym_by_name[name]}
            src_types = {source_record_type(d) for d in src_by_name[name]}
            compatible, reason = compatible_decl_types(sym_by_name[name], src_by_name[name])
            if compatible:
                if reason != "exact":
                    type_equivalent_total += 1
                    type_equivalent_reasons[reason] += 1
            elif name in function_type_overrides:
                function_type_override_total += 1
                function_type_override_rows.append((sf, {name}))
            else:
                type_mismatch.append(
                    f"{name}: SYM {sorted(sym_types)} vs source {sorted(src_types)}"
                )
        if not missing and not extra and not type_mismatch:
            clean += 1
        missing_total += len(missing)
        extra_total += len(extra)
        type_total += len(type_mismatch)
        if missing or extra or type_mismatch or quality == "linkage-spelled":
            findings.append((sf, src, quality, missing, extra, type_mismatch))

    source_by_stem = {
        p.stem.lower(): p.name.lower() for p in [*target.glob("*.cpp"), *target.glob("*.c")]
    }
    selected_globals = [
        g for g in sym_globals if Path(g.obj).stem.lower() in source_by_stem
    ]
    globals_by_file: dict[str, list[SymGlobal]] = collections.defaultdict(list)
    for glob in selected_globals:
        globals_by_file[source_by_stem[Path(glob.obj).stem.lower()]].append(glob)

    global_findings: list[str] = []
    global_mapped = 0
    global_missing = 0
    global_extra = 0
    global_storage = 0
    global_storage_overrides = 0
    global_types = 0
    global_carriers = 0
    global_type_overrides = 0
    global_type_equivalent = 0
    global_type_equivalent_reasons: collections.Counter[str] = collections.Counter()
    blob_labels = asm_data_labels()
    global_blob_backed = 0
    blob_backed_rows: list[tuple[str, list[str]]] = []
    for file_name in sorted(source_by_stem.values()):
        (
            documented_carriers,
            documented_overrides,
            documented_storage_overrides,
        ) = documented_global_types(target, file_name)
        sym_rows = globals_by_file.get(file_name, [])
        sym_by_name = {g.decl.name: g for g in sym_rows}
        source_defs = {
            d["name"]: d
            for d in file_decls.get(file_name, [])
            if d.get("kind") == "variable"
        }
        unresolved_names = sym_by_name.keys() - source_defs.keys()
        blob_backed = sorted(unresolved_names & blob_labels)
        split_aggregate_carriers: set[str] = set()
        split_carrier_components: set[str] = set()
        for name in documented_carriers & unresolved_names:
            components = {
                source_name
                for source_name in source_defs
                if source_name.startswith(name + "_")
            }
            if components:
                split_aggregate_carriers.add(name)
                split_carrier_components.update(components)
        missing = sorted(
            unresolved_names - blob_labels - split_aggregate_carriers
        )
        extra = sorted(
            source_defs.keys() - sym_by_name.keys() - split_carrier_components
        )
        global_mapped += len(split_aggregate_carriers)
        global_carriers += len(split_aggregate_carriers)
        global_blob_backed += len(blob_backed)
        if blob_backed:
            blob_backed_rows.append((file_name, blob_backed))
        global_missing += len(missing)
        global_extra += len(extra)
        if missing:
            global_findings.append(
                f"- `{file_name}` missing definitions: "
                + ", ".join(f"`{name}`" for name in missing)
            )
        if extra:
            global_findings.append(
                f"- `{file_name}` extra definitions: "
                + ", ".join(f"`{name}`" for name in extra)
            )
        for name in sorted(sym_by_name.keys() & source_defs.keys()):
            global_mapped += 1
            sg = sym_by_name[name]
            src = source_defs[name]
            source_class = "STAT" if src.get("file") else "EXT"
            details: list[str] = []
            if source_class != sg.decl.cls:
                if name in documented_storage_overrides:
                    global_storage_overrides += 1
                else:
                    global_storage += 1
                    details.append(f"storage SYM {sg.decl.cls} vs source {source_class}")
            sym_type = norm_type(sg.decl.display_type)
            source_type = source_global_type(src)
            if sym_type != source_type:
                sym_tokens = sg.decl.typ.split()
                if (
                    "PTR" in sym_tokens
                    and "FCN" in sym_tokens
                    and (
                        re.fullmatch(r"fn_[A-Za-z_]\w*\*", source_type)
                        or re.search(r"\(\*\)\([^)]*\)$", source_type)
                    )
                ):
                    # PsyQ retains only PTR/FCN/return-type for these data
                    # records.  Ctags exposes either a named function typedef
                    # pointer or the direct `R(*)(args)` declarator; both are
                    # function-pointer objects, not void-data pointers.
                    global_type_equivalent += 1
                    global_type_equivalent_reasons["generic-function-pointer"] += 1
                elif (
                    name in documented_carriers
                    and compatible_split_array_carrier(sym_type, source_type)
                ):
                    global_carriers += 1
                elif name in documented_overrides:
                    global_type_overrides += 1
                else:
                    equivalent, reason = compatible_global_types(sym_type, source_type)
                    if equivalent:
                        global_type_equivalent += 1
                        global_type_equivalent_reasons[reason] += 1
                    else:
                        global_types += 1
                        details.append(f"type SYM `{sym_type}` vs source `{source_type}`")
            if details:
                global_findings.append(
                    f"- `{file_name}:{src.get('line', '?')}` `{name}` @ {sg.va}: "
                    + "; ".join(details)
                )

    lines.extend(
        [
            "## Summary",
            "",
            f"- SYM functions in target TUs: {len(selected)}",
            f"- Mapped to reconstructed definitions: {mapped} ({exact} demangled class/name maps)",
            f"- Source definitions still using mangled linkage identifiers: {linkage_spelled}",
            f"- Explicit deleting-destructor ABI carriers: {abi_carrier_total}",
            f"- Explicit cross-TU ownership closures: {cross_tu_owner_total}",
            f"- Declaration-clean mapped functions: {clean}",
            f"- Missing SYM names: {missing_total}",
            f"- Extra source-local names: {extra_total}",
            f"- Type-comparison findings: {type_total}",
            f"- Recognized ABI/debug-equivalent type encodings: {type_equivalent_total}",
            "  (" + ", ".join(
                f"{reason}={count}" for reason, count in sorted(type_equivalent_reasons.items())
            ) + ")",
            f"- Function storage-class findings: {function_storage_total}",
            f"- Implicit aggregate special members (source body correctly absent): {implicit_generated_total}",
        f"- Explicit oracle-receipted carrier mappings: {documented_total}",
        f"- Explicit restored inline-local mappings: {inline_local_total}",
        f"- Explicit restored macro-local mappings: {macro_local_total}",
        f"- Explicit source-only codegen carriers: {codegen_total}",
        f"- Explicit oracle-proven function type overrides: {function_type_override_total}",
            f"- Functions needing mapping review: {len(selected) - mapped - implicit_generated_total}",
            f"- SYM object-owned data records in target TUs: {len(selected_globals)}",
            f"- Mapped source global definitions: {global_mapped}",
            f"- Blob-backed object globals: {global_blob_backed}",
            f"- Missing/extra global definitions: {global_missing}/{global_extra}",
            f"- Global storage-class findings: {global_storage}",
            f"- Explicit oracle-proven global storage overrides: {global_storage_overrides}",
            f"- Global type findings: {global_types}",
            f"- Recognized global debug-equivalent types: {global_type_equivalent}",
            "  (" + ", ".join(
                f"{reason}={count}"
                for reason, count in sorted(global_type_equivalent_reasons.items())
            ) + ")" if global_type_equivalent else "  (none)",
            f"- Explicit measured global array carriers: {global_carriers}",
            f"- Explicit oracle-proven global type overrides: {global_type_overrides}",
            "",
            "## Review queue",
            "",
        ]
    )
    for sf, src, quality, missing, extra, mismatches in findings:
        location = f"{source_basename(sf.source_file)}:{src.line}" if src else source_basename(sf.source_file)
        lines.append(f"### `{sf.name}` ({sf.va}, {location}, map={quality})")
        lines.append("")
        if src is None:
            lines.append("- Mapping: unresolved; inspect constructor/operator/overload spelling.")
        else:
            if quality == "linkage-spelled":
                lines.append(
                    "- Naming: source identifier is still the GCC-v2 linkage spelling; "
                    "restore the demangled C/C++ name and preserve linkage with the true "
                    "signature or a measured asm-label alias."
                )
            elif quality == "abi-carrier":
                lines.append(
                    "- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; "
                    "the source function's `pThis`/`__in_chrg` parameters represent the "
                    "retail member destructor's implicit ABI parameters."
                )
            if missing:
                lines.append("- Missing SYM names: " + ", ".join(f"`{n}`" for n in missing))
            if extra:
                lines.append("- Extra source locals: " + ", ".join(f"`{n}`" for n in extra))
            for item in mismatches:
                if item.startswith("[storage] "):
                    lines.append("- Storage: " + item.removeprefix("[storage] "))
                else:
                    lines.append("- Type: " + item)
        lines.append("")
    lines.extend(["## Implicit aggregate special members", ""])
    for sf in implicit_generated_rows:
        role = "constructor" if sf.name == "__11tAllScreens" else "destructor"
        lines.append(
            f"- `{sf.name}` ({sf.va}, `{source_basename(sf.source_file)}`): implicit "
            f"`tAllScreens` {role}; emitted from the aggregate member graph at the "
            "recorded declaration line, so an explicit source body would be incorrect."
        )
    lines.extend(["## Explicit SYM carrier/optimization mappings", ""])
    for sf, names in documented_rows:
        lines.append(f"- `{sf.name}`: " + ", ".join(f"`{n}`" for n in sorted(names)))
    lines.extend(["", "## Explicit restored inline-local mappings", ""])
    for sf, owners in inline_local_rows:
        entries = [
            f"`{name}` from `{helper}`" for name, helper in sorted(owners.items())
        ]
        lines.append(f"- `{sf.name}`: " + ", ".join(entries))
    lines.extend(["", "## Explicit restored macro-local mappings", ""])
    for sf, owners in macro_local_rows:
        entries = [
            f"`{name}` from `{macro}`" for name, macro in sorted(owners.items())
        ]
        lines.append(f"- `{sf.name}`: " + ", ".join(entries))
    lines.extend(["", "## Explicit source-only codegen carriers", ""])
    for sf, names in codegen_rows:
        lines.append(f"- `{sf.name}`: " + ", ".join(f"`{n}`" for n in sorted(names)))
    lines.extend(["", "## Explicit oracle-proven function type overrides", ""])
    for sf, names in function_type_override_rows:
        lines.append(f"- `{sf.name}`: " + ", ".join(f"`{n}`" for n in sorted(names)))
    lines.extend(["", "## Object-owned global/storage review", ""])
    for file_name, names in blob_backed_rows:
        lines.append(
            f"- `{file_name}` blob-backed definitions: "
            + ", ".join(f"`{name}`" for name in names)
        )
    if global_findings:
        lines.extend(global_findings)
    else:
        lines.append("- No ownership, storage-class, or type findings.")
    lines.append("")
    return "\n".join(lines)


def main() -> None:
    global DEFAULT_SYM, STRICT_NATIVE_BOOL
    parser = argparse.ArgumentParser()
    parser.add_argument("target", nargs="?", default="recon/frontend/common")
    parser.add_argument("--sym", type=Path, default=DEFAULT_SYM)
    parser.add_argument("--output", type=Path)
    parser.add_argument(
        "--strict-native-bool",
        action="store_true",
        help="report native C++ bool separately from four-byte BOOL",
    )
    args = parser.parse_args()
    # Keep the report provenance exact when a caller selects a non-default SYM.
    DEFAULT_SYM = args.sym
    STRICT_NATIVE_BOOL = args.strict_native_bool
    target = (ROOT / args.target).resolve() if not Path(args.target).is_absolute() else Path(args.target)
    sources = sorted([*target.glob("*.cpp"), *target.glob("*.c")])
    if target == (ROOT / "recon/frontend/psx").resolve():
        sources.append(ROOT / "recon/frontend/common/mcrd.cpp")
    headers = sorted(target.glob("*.h"))
    src_fns, file_decls = source_functions(ctags_records(sources))
    add_register_asm_locals(sources, src_fns)
    add_included_header_definitions(sources, headers, ctags_records(headers), file_decls)
    add_asm_label_definitions(sources, file_decls)
    report = audit(parse_sym(args.sym), parse_sym_globals(args.sym), src_fns, file_decls, target)
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        # Keep generated ledgers stable and git-diff-clean even when audit()
        # already returns a report terminated by a newline.
        args.output.write_text(report.rstrip("\n") + "\n", encoding="utf-8")
    print(report)


if __name__ == "__main__":
    main()
