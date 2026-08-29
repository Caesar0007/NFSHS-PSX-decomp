"""Compare retail SYM canonical type definitions with PSYQ full-debug output.

The reconstruction is compiled with the original CC1/CC1PL `-g` mode before
using this tool.  The resulting `.def` stream is the compiler's own view of
the source type graph, which is substantially stronger evidence than parsing
C/C++ declarations with regular expressions.
"""

from __future__ import annotations

from collections import Counter, defaultdict
from dataclasses import dataclass
from pathlib import Path
import argparse
import csv
import re


ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / "scratchpad/root_sym_audit"
RETAIL_LEDGER = OUT / "full_record_definition_ledger_20260821.tsv"

CANON_CLASSES = {
    "STRTAG", "UNTAG", "ENTAG", "MOS", "MOU", "FIELD", "MOE", "TPDEF", "EOS"
}
TAG_CLASSES = {"STRTAG", "UNTAG", "ENTAG"}
SCL = {
    8: "MOS",
    10: "STRTAG",
    11: "MOU",
    12: "UNTAG",
    13: "TPDEF",
    15: "ENTAG",
    16: "MOE",
    18: "FIELD",
    102: "EOS",
}
BASE_TYPES = {
    0: "NULL",
    1: "VOID",
    2: "CHAR",
    3: "SHORT",
    4: "INT",
    5: "LONG",
    6: "FLOAT",
    7: "DOUBLE",
    8: "STRUCT",
    9: "UNION",
    10: "ENUM",
    11: "MOE",
    12: "UCHAR",
    13: "USHORT",
    14: "UINT",
    15: "ULONG",
}
ASM_DEF = re.compile(r"^\s*\.def\s+([^;]+);(.*)\.endef\s*$")
ASM_FIELD = re.compile(r"\.(val|scl|type|size|tag|dim)\s+([^;]+);")
ASM_FILE = re.compile(r'^\s*\.file\s+\d+\s+"(.*)"\s*$')


@dataclass(frozen=True)
class Definition:
    cls: str
    typ: str
    size: int
    name: str
    value: int
    dims: tuple[int, ...]
    tag: str
    owner: str

    def semantic(self) -> tuple:
        name = ".vf" if self.cls == "MOS" and self.name == "_vf" else self.name
        # The reconstruction expresses some old-ABI C++ bases as explicit
        # carrier members so modern-host parsing cannot alter their layout.
        # PsyQ's source compiler spells those carriers `_base_X`; the retail
        # SYM records the same base subobject as `X` with tag `X`.
        if self.cls == "MOS" and name == f"_base_{normalize_tag(self.tag)}":
            name = normalize_tag(self.tag)
        return (
            self.cls, self.typ, self.size, name, self.value, self.dims,
            normalize_tag(self.tag),
        )


@dataclass(frozen=True)
class TypeBlock:
    kind: str
    name: str
    size: int
    rows: tuple[tuple, ...]
    owner: str

    def semantic(self) -> tuple:
        return (self.kind, normalize_tag(self.name), self.size, self.rows)


def normalize_tag(name: str) -> str:
    if name == "__nfs4_vtbl_ptr_t":
        return "__vtbl_ptr_type"
    # Both spellings are compiler-generated anonymous tags.  CC1PL uses
    # ``._N`` while the MIPS SDB backend's SDB_GENERATE_FAKE hook emits
    # ``.Nfake``.  The number is a process-local debug-emission counter, not a
    # recoverable source identifier (gcc-2.8.1 sdbout.c: gen_fake_label).
    # Compare their complete layouts and uses, never the incidental counter.
    # Pre-change backup: Git commit dcb11301.
    if is_anonymous_tag(name):
        return "<anonymous>"
    return name


def is_anonymous_tag(name: str) -> bool:
    return name.startswith("._") or re.fullmatch(r"\.\d+fake", name) is not None


def parse_int(text: str, default: int = 0) -> int:
    text = text.strip()
    try:
        return int(text, 0)
    except ValueError:
        return default


def decode_type(value: int, cls: str) -> str:
    derived = []
    while value & 0xFFF0:
        code = (value >> 4) & 3
        derived.append({1: "PTR", 2: "FCN", 3: "ARY"}.get(code, "?"))
        value = ((value >> 2) & 0xFFF0) + (value & 0xF)
    base = BASE_TYPES.get(value, f"?{value}?")
    if base == "NULL" and cls not in {"MOE", "EOS"}:
        base = "BOOL"
    return " ".join([*derived, base])


def parse_retail(path: Path) -> list[Definition]:
    rows = []
    with path.open("r", encoding="utf-8", newline="") as stream:
        for row in csv.DictReader(stream, delimiter="\t"):
            if row["class"] not in CANON_CLASSES:
                continue
            extra = row["extra"]
            dims: tuple[int, ...] = ()
            tag = ""
            match = re.search(r"\bdims\s+(\d+)(.*?)(?:\s+tag(?:\s+(.*))?)?$", extra)
            if match:
                dim_count = int(match.group(1))
                numbers = [int(x) for x in re.findall(r"-?\d+", match.group(2))]
                dims = tuple(numbers[:dim_count])
                tag = (match.group(3) or "").strip()
            rows.append(
                Definition(
                    row["class"], row["type"], int(row["size"]), row["name"],
                    int(row["value"], 16), dims, tag, row["owner_context"]
                )
            )
    return rows


def parse_asm(path: Path) -> list[Definition]:
    rows = []
    owner = path.name
    for line in path.read_text(encoding="utf-8", errors="replace").splitlines():
        file_match = ASM_FILE.match(line)
        if file_match:
            owner = file_match.group(1)
            continue
        match = ASM_DEF.match(line)
        if not match:
            continue
        name = match.group(1).strip()
        fields = {key: value.strip() for key, value in ASM_FIELD.findall(match.group(2))}
        scl = parse_int(fields.get("scl", "-999"), -999)
        cls = SCL.get(scl)
        if cls not in CANON_CLASSES:
            continue
        type_value = parse_int(fields.get("type", "0"))
        dims = tuple(parse_int(x) for x in fields.get("dim", "").split(",") if x.strip())
        rows.append(
            Definition(
                cls,
                decode_type(type_value, cls),
                parse_int(fields.get("size", "0")),
                name,
                parse_int(fields.get("val", "0")) & 0xFFFFFFFF,
                dims,
                fields.get("tag", ""),
                owner,
            )
        )
    return rows


def blocks(definitions: list[Definition]) -> tuple[list[TypeBlock], list[Definition], list[str]]:
    result = []
    typedefs = []
    issues = []
    current: list[Definition] | None = None
    for row in definitions:
        if row.cls in TAG_CLASSES:
            if current is not None:
                issues.append(f"nested/unclosed {current[0].name} before {row.name} ({row.owner})")
            current = [row]
        elif current is not None:
            current.append(row)
            if row.cls == "EOS":
                start = current[0]
                member_rows = tuple(item.semantic() for item in current[1:-1])
                result.append(TypeBlock(start.cls, start.name, start.size, member_rows, start.owner))
                current = None
        elif row.cls == "TPDEF":
            typedefs.append(row)
        elif row.cls != "EOS":
            issues.append(f"orphan {row.cls} {row.name} ({row.owner})")
    if current is not None:
        issues.append(f"unterminated {current[0].name} ({current[0].owner})")
    return result, typedefs, issues


def _is_prim_macro_header(owner: str) -> bool:
    """Recognize only the reconstruction's canonical LIBGPU macro carrier."""
    return owner.replace("\\", "/").casefold().endswith("/psyq_prim_macros.h")


def _is_canonical_ptag_owner(owner: str) -> bool:
    """Recognize exact PsyQ P_TAG emission sites, never the name alone."""
    normalized = owner.replace("\\", "/").casefold()
    return _is_prim_macro_header(owner) or (
        normalized.endswith(("/p06.c", "/p34.c"))
        and "/libgpu/" in normalized
    )


def filter_sdk_macro_carriers(
    type_blocks: list[TypeBlock], typedefs: list[Definition]
) -> tuple[list[TypeBlock], list[Definition]]:
    """Remove exact SDK-only debug carriers that retail objects filter.

    PsyQ's canonical LIBGPU.H implements setaddr/getaddr/addPrim through P_TAG.
    Full-debug CC1PLUS emits its anonymous body and typedef when the macros are
    reconstructed in an owner header, whereas the retail game-object SYM keeps
    the concrete primitive-variable types but filters this cast-only SDK type.
    The guard deliberately checks the header owner, complete 8-byte layout and
    typedef/tag link; a source-defined P_TAG or any layout drift remains visible.
    P06.c is PsyQ's AddPrim implementation itself, and P34.c uses the same macro
    in SetDrawMove.  Their reconstructed types use the full canonical 8-byte
    PsyQ 4.3 P_TAG rather than a four-byte prefix; accept that same exact pair
    only in those SDK owners.  Pre-change backup for the P06 extension: Git
    commit 49c32f8e; P34/EXT extension: Git commit 2fcfdbeb.

    VLC.c is PsyQ's hand-written LIBPRESS decoder and uses the canonical
    SYS/TYPES.H aliases u_int, u_long, and u_short.  Its linked archive member
    omits header type records; accept only those three exact fundamental aliases
    in that precise SDK owner.  The same backup commit applies.

    The linked EA graphics-library members likewise omit the canonical PsyQ
    4.3 ``RECT`` and ``u_long`` header records even though their prototypes and
    locals require those SDK spellings.  The PsyQ 4.3 LIBGPU.H source fixes
    RECT as four consecutive shorts and declares SetDrawMove with RECT*.  Keep
    the exception owner-local and pair-lock the anonymous body to its typedef;
    accept u_long only as the exact unsigned-long alias.  Pre-change backup:
    Git commit d4558d8f.
    """
    expected_rows = (
        ("FIELD", "UINT", 24, "addr", 0, (), ""),
        ("FIELD", "UINT", 8, "len", 24, (), ""),
        ("MOS", "UCHAR", 0, "r0", 4, (), ""),
        ("MOS", "UCHAR", 0, "g0", 5, (), ""),
        ("MOS", "UCHAR", 0, "b0", 6, (), ""),
        ("MOS", "UCHAR", 0, "code", 7, (), ""),
    )

    def exact_typedef(item: Definition) -> bool:
        return (
            item.cls == "TPDEF"
            and item.name == "P_TAG"
            and item.typ == "STRUCT"
            and item.size == 8
            and is_anonymous_tag(item.tag)
            and _is_canonical_ptag_owner(item.owner)
        )

    def exact_block(block: TypeBlock) -> bool:
        return (
            block.kind == "STRTAG"
            and block.size == 8
            and block.rows == expected_rows
            and _is_canonical_ptag_owner(block.owner)
        )

    rect_owners = ("/fastmovf.c", "/movf.c", "/vramfxya.c", "/p34.c")
    rect_rows = (
        ("MOS", "SHORT", 0, "x", 0, (), ""),
        ("MOS", "SHORT", 0, "y", 2, (), ""),
        ("MOS", "SHORT", 0, "w", 4, (), ""),
        ("MOS", "SHORT", 0, "h", 6, (), ""),
    )

    def canonical_rect_owner(owner: str) -> str | None:
        normalized = owner.replace("\\", "/").casefold()
        return normalized if normalized.endswith(rect_owners) else None

    def exact_rect_typedef(item: Definition) -> bool:
        return (
            item.cls == "TPDEF"
            and item.name == "RECT"
            and item.typ == "STRUCT"
            and item.size == 8
            and is_anonymous_tag(item.tag)
            and canonical_rect_owner(item.owner) is not None
        )

    def exact_rect_block(block: TypeBlock) -> bool:
        return (
            block.kind == "STRTAG"
            and block.size == 8
            and block.rows == rect_rows
            and is_anonymous_tag(block.name)
            and canonical_rect_owner(block.owner) is not None
        )

    def exact_u_long_typedef(item: Definition) -> bool:
        return (
            item.cls == "TPDEF"
            and item.name == "u_long"
            and item.typ == "ULONG"
            and canonical_rect_owner(item.owner) is not None
        )

    def exact_vlc_sdk_typedef(item: Definition) -> bool:
        normalized = item.owner.replace("\\", "/").casefold()
        expected = {
            "u_int": "UINT",
            "u_long": "ULONG",
            "u_short": "USHORT",
        }.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == expected
            and normalized.endswith("/vlc.c")
            and "/libpress/" in normalized
        )

    def exact_libgpu_sdk_typedef(item: Definition) -> bool:
        normalized = item.owner.replace("\\", "/").casefold()
        expected_by_owner = {
            "/ext.c": {
                "u_char": "UCHAR",
                "u_short": "USHORT",
                "u_long": "ULONG",
            },
            "/p34.c": {
                "u_char": "UCHAR",
                "u_long": "ULONG",
            },
        }
        for suffix, aliases in expected_by_owner.items():
            if normalized.endswith(suffix) and "/libgpu/" in normalized:
                return item.typ == aliases.get(item.name)
        return False

    # Exact canonical PsyQ 4.3 LIBGPU.H aggregate pairs retained by linked SDK
    # sources whose archive-member SYM omits the header graph.  The nested tags
    # are compiler-generated, so the complete typedef/tag/layout link is the
    # stable identity.  Pre-change backup: Git commit 2fcfdbeb.
    sdk_struct_layouts = {
        "/ext.c": {
            "RECT": (8, rect_rows),
            "DR_ENV": (64, (
                ("MOS", "ULONG", 0, "tag", 0, (), ""),
                ("MOS", "ARY ULONG", 60, "code", 4, (15,), ""),
            )),
            "DRAWENV": (92, (
                ("MOS", "STRUCT", 8, "clip", 0, (), "<anonymous>"),
                ("MOS", "ARY SHORT", 4, "ofs", 8, (2,), ""),
                ("MOS", "STRUCT", 8, "tw", 12, (), "<anonymous>"),
                ("MOS", "USHORT", 0, "tpage", 20, (), ""),
                ("MOS", "UCHAR", 0, "dtd", 22, (), ""),
                ("MOS", "UCHAR", 0, "dfe", 23, (), ""),
                ("MOS", "UCHAR", 0, "isbg", 24, (), ""),
                ("MOS", "UCHAR", 0, "r0", 25, (), ""),
                ("MOS", "UCHAR", 0, "g0", 26, (), ""),
                ("MOS", "UCHAR", 0, "b0", 27, (), ""),
                ("MOS", "STRUCT", 64, "dr_env", 28, (), "<anonymous>"),
            )),
            "DISPENV": (20, (
                ("MOS", "STRUCT", 8, "disp", 0, (), "<anonymous>"),
                ("MOS", "STRUCT", 8, "screen", 8, (), "<anonymous>"),
                ("MOS", "UCHAR", 0, "isinter", 16, (), ""),
                ("MOS", "UCHAR", 0, "isrgb24", 17, (), ""),
                ("MOS", "UCHAR", 0, "pad0", 18, (), ""),
                ("MOS", "UCHAR", 0, "pad1", 19, (), ""),
            )),
        },
        "/p34.c": {
            "DR_MOVE": (24, (
                ("MOS", "ULONG", 0, "tag", 0, (), ""),
                ("MOS", "ARY ULONG", 20, "code", 4, (5,), ""),
            )),
        },
    }

    def sdk_struct_owner(owner: str) -> str | None:
        normalized = owner.replace("\\", "/").casefold()
        if "/libgpu/" not in normalized:
            return None
        return next(
            (suffix for suffix in sdk_struct_layouts if normalized.endswith(suffix)),
            None,
        )

    def exact_sdk_struct_typedef(item: Definition) -> bool:
        owner_key = sdk_struct_owner(item.owner)
        spec = sdk_struct_layouts.get(owner_key, {}).get(item.name)
        return (
            spec is not None
            and item.cls == "TPDEF"
            and item.typ == "STRUCT"
            and item.size == spec[0]
            and is_anonymous_tag(item.tag)
        )

    sdk_struct_names = {
        (sdk_struct_owner(item.owner), item.tag): item.name
        for item in typedefs if exact_sdk_struct_typedef(item)
    }

    def exact_sdk_struct_block(block: TypeBlock) -> bool:
        owner_key = sdk_struct_owner(block.owner)
        name = sdk_struct_names.get((owner_key, block.name))
        spec = sdk_struct_layouts.get(owner_key, {}).get(name)
        return (
            spec is not None
            and block.kind == "STRTAG"
            and block.size == spec[0]
            and block.rows == spec[1]
            and is_anonymous_tag(block.name)
        )

    removable_sdk_struct_pairs = {
        (sdk_struct_owner(block.owner), block.name)
        for block in type_blocks if exact_sdk_struct_block(block)
    }

    eligible_tags = {item.tag for item in typedefs if exact_typedef(item)}
    removable_tags = {
        block.name for block in type_blocks
        if block.name in eligible_tags and exact_block(block)
    }
    rect_pairs = {
        (canonical_rect_owner(item.owner), item.tag)
        for item in typedefs if exact_rect_typedef(item)
    }
    removable_rect_pairs = {
        (canonical_rect_owner(block.owner), block.name)
        for block in type_blocks
        if (canonical_rect_owner(block.owner), block.name) in rect_pairs
        and exact_rect_block(block)
    }
    return (
        [
            block for block in type_blocks
            if not (
                block.name in removable_tags
                and exact_block(block)
            )
            and not (
                (canonical_rect_owner(block.owner), block.name)
                in removable_rect_pairs
                and exact_rect_block(block)
            )
            and not (
                (sdk_struct_owner(block.owner), block.name)
                in removable_sdk_struct_pairs
                and exact_sdk_struct_block(block)
            )
        ],
        [
            item for item in typedefs
            if not (
                item.tag in removable_tags
                and exact_typedef(item)
            )
            and not (
                (canonical_rect_owner(item.owner), item.tag)
                in removable_rect_pairs
                and exact_rect_typedef(item)
            )
            and not (
                (sdk_struct_owner(item.owner), item.tag)
                in removable_sdk_struct_pairs
                and exact_sdk_struct_typedef(item)
            )
            and not exact_u_long_typedef(item)
            and not exact_vlc_sdk_typedef(item)
            and not exact_libgpu_sdk_typedef(item)
        ],
    )


def filter_stripped_libmath_carriers(
    type_blocks: list[TypeBlock], typedefs: list[Definition]
) -> tuple[list[TypeBlock], list[Definition]]:
    """Remove only complete canonical carrier graphs from stripped LIBMATH.

    Sony's prebuilt LIBMATH archive members retain no type records in the NFS4
    SYM, but the byte-matched sources require GCC's real ``double_long`` union
    shape and the library's two-word mantissa carrier.  GCC 2.8.1 floatlib.c is
    the source evidence for ``double_long``.  Accept a member only when its
    entire anonymous block/typedef multiset is exact; a changed name, owner,
    kind, size, member, dimension, tag anonymity, or count leaves the complete
    graph visible.  Pre-change backup: Git commit b73d0a38.
    """
    eligible = {
        "adddf3.c": (2, True, True),
        "divdf3.c": (2, True, False),
        "gtdf2.c": (1, False, False),
        "ltdf2.c": (1, False, False),
        "muldf3.c": (2, True, False),
        "trudfsf2.c": (1, False, False),
    }
    word_rows = (
        ("MOS", "UINT", 0, "lo", 0, (), ""),
        ("MOS", "INT", 0, "hi", 4, (), ""),
    )
    double_union_rows = (
        ("MOU", "DOUBLE", 0, "d", 0, (), ""),
        ("MOU", "STRUCT", 8, "w", 0, (), "<anonymous>"),
    )
    local_union_rows = (
        ("MOU", "DOUBLE", 0, "d", 0, (), ""),
        ("MOU", "ARY INT", 8, "w", 0, (2,), ""),
    )

    def owner_key(owner: str) -> tuple[str, str] | None:
        normalized = owner.replace("\\", "/").casefold()
        basename = normalized.rsplit("/", 1)[-1]
        if "/libmath/" not in normalized or basename not in eligible:
            return None
        return normalized, basename

    owners = {
        key[0] for item in [*type_blocks, *typedefs]
        if (key := owner_key(item.owner)) is not None
    }
    exact_owners = set()
    for owner in owners:
        basename = owner.rsplit("/", 1)[-1]
        word_count, has_mant_pair, has_local_union = eligible[basename]
        expected_blocks = Counter({
            ("STRTAG", 8, word_rows): word_count,
            ("UNTAG", 8, double_union_rows): 1,
        })
        if has_local_union:
            expected_blocks[("UNTAG", 8, local_union_rows)] += 1
        actual_blocks = Counter(
            (item.kind, item.size, item.rows)
            for item in type_blocks
            if item.owner.replace("\\", "/").casefold() == owner
        )
        expected_typedefs = Counter({
            ("double_long", "UNION", 8, True): 1,
        })
        if has_mant_pair:
            expected_typedefs[("mant_pair", "STRUCT", 8, True)] += 1
        actual_typedefs = Counter(
            (item.name, item.typ, item.size, is_anonymous_tag(item.tag))
            for item in typedefs
            if item.owner.replace("\\", "/").casefold() == owner
        )
        if actual_blocks == expected_blocks and actual_typedefs == expected_typedefs:
            exact_owners.add(owner)

    return (
        [
            item for item in type_blocks
            if item.owner.replace("\\", "/").casefold() not in exact_owners
        ],
        [
            item for item in typedefs
            if item.owner.replace("\\", "/").casefold() not in exact_owners
        ],
    )


def filter_exact_symbol_codegen_carriers(
    type_blocks: list[TypeBlock], typedefs: list[Definition]
) -> tuple[list[TypeBlock], list[Definition]]:
    """Remove only proven, layout-locked foreign-symbol codegen views.

    night.obj's retail instructions require Camera_gInfo rows of 272 bytes and
    a BWorldSm_Pos component at +140, but its SYM deliberately retains no
    camera_info tag.  A raw-byte reconstruction folds +140 into the relocation
    and breaks two previously exact functions.  The private view in
    night_externs.h restores the component MEM shape while this exact guard
    prevents that explicitly synthetic tag from being counted as restored
    source.  Any owner, name, size, member, or offset drift remains visible.
    """
    # PsyQ's linked SPRINTF.OBJ is stripped, so NFS4.SYM deliberately retains
    # none of its owner-local type graph.  The extracted PsyQ 4.3 object is a
    # relocation-masked byte match for retail, while the canonical matched
    # source fixes the complete graph below.  Accept the graph only as one
    # whole-owner fingerprint: all three blocks and all three typedefs must be
    # present with exact kinds, rows, sizes, and tags.  A partial edit remains
    # visible instead of being normalized piecemeal.  The anonymous union is
    # the allocation carrier needed by the current count-exact reconstruction.
    # Pre-change source/tool backup: Git commit 964ae078.
    stripped_vendor_owner_graphs = {
        "sprintf.c": (
            Counter({
                ("ENTAG", "<anonymous>", 4, (
                    ("MOE", "MOE", 0, "false", 0, (), ""),
                    ("MOE", "MOE", 0, "true", 1, (), ""),
                )): 1,
                ("STRTAG", "printf_info", 12, (
                    ("FIELD", "ENUM", 1, "leftJustified", 0, (),
                     "<anonymous>"),
                    ("FIELD", "ENUM", 1, "prependPlus", 1, (),
                     "<anonymous>"),
                    ("FIELD", "ENUM", 1, "alternativeForm", 2, (),
                     "<anonymous>"),
                    ("FIELD", "ENUM", 1, "leadingZeros", 3, (),
                     "<anonymous>"),
                    ("FIELD", "ENUM", 1, "usePrecision", 4, (),
                     "<anonymous>"),
                    ("FIELD", "ENUM", 1, "isHalf", 5, (),
                     "<anonymous>"),
                    ("FIELD", "ENUM", 1, "isLong", 6, (),
                     "<anonymous>"),
                    ("FIELD", "ENUM", 1, "isLongLong", 7, (),
                     "<anonymous>"),
                    ("MOS", "CHAR", 0, "leadingChar", 1, (), ""),
                    ("MOS", "INT", 0, "width", 4, (), ""),
                    ("MOS", "INT", 0, "precision", 8, (), ""),
                )): 1,
                ("UNTAG", "<anonymous>", 12, (
                    ("MOU", "STRUCT", 12, "s", 0, (), "printf_info"),
                    ("MOU", "ARY INT", 12, "w", 0, (3,), ""),
                )): 1,
            }),
            Counter({
                ("bool", "ENUM", 4, "<anonymous>"): 1,
                ("va_list", "PTR CHAR", 0, ""): 1,
                ("printf_info", "STRUCT", 12, "printf_info"): 1,
            }),
        ),
    }
    stripped_vendor_eligible = set()
    for basename, (expected_blocks, expected_typedefs) in (
        stripped_vendor_owner_graphs.items()
    ):
        actual_blocks = Counter(
            block.semantic()
            for block in type_blocks
            if block.owner.replace("\\", "/").casefold().rsplit("/", 1)[-1]
            == basename
        )
        actual_typedefs = Counter(
            (
                item.name, item.typ, item.size,
                normalize_tag(item.tag) if item.tag else "",
            )
            for item in typedefs
            if item.owner.replace("\\", "/").casefold().rsplit("/", 1)[-1]
            == basename
        )
        if actual_blocks == expected_blocks and actual_typedefs == expected_typedefs:
            stripped_vendor_eligible.add(basename)

    def exact_stripped_vendor_owner(owner: str) -> bool:
        basename = owner.replace("\\", "/").casefold().rsplit("/", 1)[-1]
        return basename in stripped_vendor_eligible

    # FONT.OBJ is another stripped PsyQ 4.3 vendor owner.  Unlike SPRINTF,
    # two used standard typedefs retain their GCC debug owner as stdarg.h and
    # stddef.h, so lock this compilation's entire emitted graph atomically.
    # PsyQ 4.3 libgpu.h proves TILE/DR_MODE/SPRT_8; the fully matched PsyQ font
    # source proves Sony's private `struct Font` names and member graph.  The
    # current NFS4 FntPrint is exact and FntFlush is instruction-count exact.
    # Any extra, missing, renamed, or reshaped block/typedef disables the whole
    # classification. Pre-change source/tool backup: Git commit 93adfbcd.
    font_vendor_blocks = Counter({
        ("STRTAG", "<anonymous>", 16, (
            ("MOS", "ULONG", 0, "tag", 0, (), ""),
            ("MOS", "UCHAR", 0, "r0", 4, (), ""),
            ("MOS", "UCHAR", 0, "g0", 5, (), ""),
            ("MOS", "UCHAR", 0, "b0", 6, (), ""),
            ("MOS", "UCHAR", 0, "code", 7, (), ""),
            ("MOS", "SHORT", 0, "x0", 8, (), ""),
            ("MOS", "SHORT", 0, "y0", 10, (), ""),
            ("MOS", "SHORT", 0, "w", 12, (), ""),
            ("MOS", "SHORT", 0, "h", 14, (), ""),
        )): 1,
        ("STRTAG", "<anonymous>", 12, (
            ("MOS", "ULONG", 0, "tag", 0, (), ""),
            ("MOS", "ARY ULONG", 8, "code", 4, (2,), ""),
        )): 1,
        ("STRTAG", "<anonymous>", 16, (
            ("MOS", "ULONG", 0, "tag", 0, (), ""),
            ("MOS", "UCHAR", 0, "r0", 4, (), ""),
            ("MOS", "UCHAR", 0, "g0", 5, (), ""),
            ("MOS", "UCHAR", 0, "b0", 6, (), ""),
            ("MOS", "UCHAR", 0, "code", 7, (), ""),
            ("MOS", "SHORT", 0, "x0", 8, (), ""),
            ("MOS", "SHORT", 0, "y0", 10, (), ""),
            ("MOS", "UCHAR", 0, "u0", 12, (), ""),
            ("MOS", "UCHAR", 0, "v0", 13, (), ""),
            ("MOS", "USHORT", 0, "clut", 14, (), ""),
        )): 1,
        ("STRTAG", "Font", 48, (
            ("MOS", "STRUCT", 16, "tile", 0, (), "<anonymous>"),
            ("MOS", "STRUCT", 12, "draw_mode", 16, (), "<anonymous>"),
            ("MOS", "INT", 0, "capacity", 28, (), ""),
            ("MOS", "PTR STRUCT", 16, "sprites", 32, (),
             "<anonymous>"),
            ("MOS", "PTR CHAR", 0, "buffer", 36, (), ""),
            ("MOS", "INT", 0, "written", 40, (), ""),
            ("MOS", "INT", 0, "unwrap", 44, (), ""),
        )): 1,
    })
    font_vendor_typedefs = Counter({
        ("u_long", "ULONG", 0, ""): 1,
        ("u_char", "UCHAR", 0, ""): 1,
        ("u_short", "USHORT", 0, ""): 1,
        ("va_list", "PTR VOID", 0, ""): 1,
        ("size_t", "UINT", 0, ""): 1,
        ("TILE", "STRUCT", 16, "<anonymous>"): 1,
        ("DR_MODE", "STRUCT", 12, "<anonymous>"): 1,
        ("SPRT_8", "STRUCT", 16, "<anonymous>"): 1,
    })
    font_vendor_eligible = (
        any(
            block.name == "Font"
            and block.owner.replace("\\", "/").casefold().endswith("font.c")
            for block in type_blocks
        )
        and Counter(block.semantic() for block in type_blocks)
        == font_vendor_blocks
        and Counter(
            (
                item.name, item.typ, item.size,
                normalize_tag(item.tag) if item.tag else "",
            )
            for item in typedefs
        ) == font_vendor_typedefs
    )

    expected_rows = (
        ("MOS", "ARY UCHAR", 4, "anchorBytes", 0, (4,), ""),
        ("MOS", "PTR STRUCT", 576, "target", 4, (), "BO_tNewtonObj"),
        ("MOS", "ARY UCHAR", 132, "prefix", 8, (132,), ""),
        ("MOS", "STRUCT", 132, "slicePos", 140, (), "BWorldSm_Pos"),
    )

    # hud.obj has the same compiler-boundary problem for several foreign
    # objects: retail preserves member-shaped instructions while omitting the
    # owning aggregate tags.  These private views are accepted only with their
    # complete owner/name/size/member graph.  This is intentionally verbose:
    # changing even padding spelling, a leaf tag, or one offset must surface as
    # a type-graph regression instead of being silently normalized.
    hud_views = {
        "Hud_CViewCodegenView": (140, (
            ("MOS", "INT", 0, "id", 0, (), ""),
            ("MOS", "INT", 0, "player", 4, (), ""),
            ("MOS", "ARY UCHAR", 132, "cviewBytes", 8, (132,), ""),
        )),
        "Hud_GameSetupCodegenView": (2600, (
            ("MOS", "INT", 0, "raceType", 0, (), ""),
            ("MOS", "INT", 0, "numLaps", 4, (), ""),
            ("MOS", "INT", 0, "skill", 8, (), ""),
            ("MOS", "INT", 0, "commMode", 12, (), ""),
            ("MOS", "ARY INT", 28, "setup04_10", 16, (7,), ""),
            ("MOS", "INT", 0, "mirrorTrack", 44, (), ""),
            ("MOS", "INT", 0, "reverseTrack", 48, (), ""),
            ("MOS", "INT", 0, "measurement", 52, (), ""),
            ("MOS", "INT", 0, "sgge", 56, (), ""),
            ("MOS", "INT", 0, "track", 60, (), ""),
            ("MOS", "INT", 0, "trackSegment", 64, (), ""),
            ("MOS", "INT", 0, "song", 68, (), ""),
            ("MOS", "INT", 0, "Weather", 72, (), ""),
            ("MOS", "INT", 0, "Fog", 76, (), ""),
            ("MOS", "INT", 0, "Damage", 80, (), ""),
            ("MOS", "INT", 0, "Time", 84, (), ""),
            ("MOS", "INT", 0, "randSeed", 88, (), ""),
            ("MOS", "INT", 0, "easter", 92, (), ""),
            ("MOS", "ARY INT", 88, "controllerWords", 96, (22,), ""),
            ("MOS", "INT", 0, "pinkSlipsForfeit", 184, (), ""),
            ("MOS", "INT", 0, "checkpointType", 188, (), ""),
            ("MOS", "ARY INT", 8, "checkpointHUD", 192, (2,), ""),
            ("MOS", "INT", 0, "dispatchSpeech", 200, (), ""),
            ("MOS", "INT", 0, "reverseCallSpeech", 204, (), ""),
            ("MOS", "INT", 0, "languageSpeech", 208, (), ""),
            ("MOS", "INT", 0, "SceneNumber", 212, (), ""),
            ("MOS", "INT", 0, "SceneStartLap", 216, (), ""),
            ("MOS", "INT", 0, "SceneEndLap", 220, (), ""),
            ("MOS", "STRUCT", 204, "userSetting", 224, (), "GameSetup_tUserSetting"),
            ("MOS", "INT", 0, "numPerps", 428, (), ""),
            ("MOS", "INT", 0, "stageOffset", 432, (), ""),
            ("MOS", "INT", 0, "perpArrests", 436, (), ""),
            ("MOS", "INT", 0, "finalPerpArrests", 440, (), ""),
            ("MOS", "ARY STRUCT", 520, "perpInfo", 444, (10,), "GameSetup_tPerpData"),
            ("MOS", "INT", 0, "numCars", 964, (), ""),
            ("MOS", "INT", 0, "numPlayerRaceCars", 968, (), ""),
            ("MOS", "INT", 0, "numOpponentRaceCars", 972, (), ""),
            ("MOS", "INT", 0, "opponentCarType", 976, (), ""),
            ("MOS", "ARY STRUCT", 1620, "carInfo", 980, (9,), "GameSetup_tCarData"),
        )),
        "Hud_SimGlobalCodegenView": (24, (
            ("MOS", "INT", 0, "gameStarted", 0, (), ""),
            ("MOS", "INT", 0, "gameTicks", 4, (), ""),
            ("MOS", "INT", 0, "time32Hz", 8, (), ""),
            ("MOS", "PTR VOID", 0, "schedule64Hz", 12, (), ""),
            ("MOS", "PTR VOID", 0, "schedule32Hz", 16, (), ""),
            ("MOS", "PTR VOID", 0, "schedule32Hz2", 20, (), ""),
        )),
        "Hud_CameraCodegenView": (272, (
            ("MOS", "PTR STRUCT", 576, "anchor", 0, (), "BO_tNewtonObj"),
            ("MOS", "PTR STRUCT", 576, "target", 4, (), "BO_tNewtonObj"),
            ("MOS", "ARY UCHAR", 264, "remaining", 8, (264,), ""),
        )),
        "Hud_DashCodegenView": (108, (
            ("MOS", "INT", 0, "splitscreen", 0, (), ""),
            ("MOS", "ARY CHAR", 9, "name", 4, (9,), ""),
            ("MOS", "ARY CHAR", 3, "align13_15", 13, (3,), ""),
            ("MOS", "INT", 0, "conversion", 16, (), ""),
            ("MOS", "INT", 0, "flashtime", 20, (), ""),
            ("MOS", "INT", 0, "flashlap", 24, (), ""),
            ("MOS", "ARY INT", 8, "showhud", 28, (2,), ""),
            ("MOS", "ARY INT", 8, "showmap", 36, (2,), ""),
            ("MOS", "ARY INT", 8, "wrongway", 44, (2,), ""),
            ("MOS", "INT", 0, "laptime", 52, (), ""),
            ("MOS", "INT", 0, "lap", 56, (), ""),
            ("MOS", "INT", 0, "maxlaps", 60, (), ""),
            ("MOS", "INT", 0, "rpm", 64, (), ""),
            ("MOS", "INT", 0, "redline", 68, (), ""),
            ("MOS", "INT", 0, "gear", 72, (), ""),
            ("MOS", "INT", 0, "speed", 76, (), ""),
            ("MOS", "INT", 0, "topspeed", 80, (), ""),
            ("MOS", "INT", 0, "position", 84, (), ""),
            ("MOS", "INT", 0, "opponents", 88, (), ""),
            ("MOS", "INT", 0, "record", 92, (), ""),
            ("MOS", "INT", 0, "tutor", 96, (), ""),
            ("MOS", "ARY INT", 8, "warning", 100, (2,), ""),
        )),
        "Hud_PadCodegenView": (84, (
            ("MOS", "INT", 0, "initialized", 0, (), ""),
            ("MOS", "ARY STRUCT", 64, "buf", 4, (8,), "PAD_COMMON"),
            ("MOS", "ARY UCHAR", 16, "stateBytes", 68, (16,), ""),
        )),
        "Hud_ReplayCodegenView": (32, (
            ("MOS", "INT", 0, "pause", 0, (), ""),
            ("MOS", "INT", 0, "speed", 4, (), ""),
            ("MOS", "INT", 0, "end", 8, (), ""),
            ("MOS", "INT", 0, "camera", 12, (), ""),
            ("MOS", "INT", 0, "selection", 16, (), ""),
            ("MOS", "INT", 0, "depressed", 20, (), ""),
            ("MOS", "INT", 0, "changeCamera", 24, (), ""),
            ("MOS", "INT", 0, "statsScreen", 28, (), ""),
        )),
        "Hud_SimVarCodegenView": (28, (
            ("MOS", "INT", 0, "restartGame", 0, (), ""),
            ("MOS", "INT", 0, "endSimGame", 4, (), ""),
            ("MOS", "INT", 0, "pauseSim", 8, (), ""),
            ("MOS", "INT", 0, "keyRelease", 12, (), ""),
            ("MOS", "INT", 0, "quickPauseSim", 16, (), ""),
            ("MOS", "INT", 0, "goalClockTicks", 20, (), ""),
            ("MOS", "INT", 0, "currentClockTicks", 24, (), ""),
        )),
    }
    drawc_views = {
        "DrawC_CViewCodegenView": hud_views["Hud_CViewCodegenView"],
        "DrawC_GameSetupCodegenView": hud_views["Hud_GameSetupCodegenView"],
    }
    # bworldSm.obj dereferences five fields of chunk.obj's Track_chunkList,
    # but its retail debug graph deliberately omits the complete Chunk tag.
    # Pair-lock the exact 112-byte foreign-symbol view used to retain those
    # member-shaped instructions.  Pre-change backup: Git commit 5163e832.
    bworldsm_views = {
        "BWorldSm_ChunkCodegenView": (112, (
            ("MOS", "ARY CHAR", 56, "_beforeStripBuf", 0, (56,), ""),
            ("MOS", "PTR STRUCT", 4, "stripBuf", 56, (), "Group"),
            ("MOS", "ARY CHAR", 12, "_beforeSimSliceBuf", 60, (12,), ""),
            ("MOS", "PTR STRUCT", 4, "simSliceBuf", 72, (), "Group"),
            ("MOS", "PTR STRUCT", 4, "simQuadBuf", 76, (), "Group"),
            ("MOS", "ARY CHAR", 24, "_beforeFirstSimSliceInd", 80,
             (24,), ""),
            ("MOS", "SHORT", 0, "firstSimSliceInd", 104, (), ""),
            ("MOS", "ARY CHAR", 2, "_beforeVertexBuf", 106, (2,), ""),
            ("MOS", "PTR STRUCT", 4, "vertexBuf", 108, (), "Group"),
        )),
    }
    # These linked EA library members retain no type graph, while their retail
    # instructions prove aggregate-copy, by-value ABI, or foreign-storage
    # member shapes.  Accept only the exact source carrier for each object:
    # owner basename, tag, size, every member, offset, leaf type, and array
    # bound are locked.  Any drift remains an audit failure.  Pre-change
    # backup: Git commit 0fc6b97a; canonical PsyQ device_table extension: Git
    # commit 065be180.
    untyped_library_codegen_views = {
        # CDFS's packed one-word view is the source-level device that makes
        # GCC emit the oracle's unaligned lwl/lwr pair. It has no typedef and
        # the stripped owner retains no private tag. Pre-change backup: Git
        # commit 8f87889d.
        ("cdfs.c", "rd_le32_unaligned"): (4, (
            ("MOS", "INT", 0, "v", 0, (), ""),
        )),
        # sdpacket's voice-table view flattens byte-exactly, but the packet
        # pointer array requires this split +0x4f8 aggregate MEM shape. Both
        # direct-byte and int-array spellings regress iSNDpacketpurgeframes by
        # four instructions. Lock the lone retained carrier completely for
        # this stripped owner. Pre-change backup: Git commit 3c5f9a77.
        ("sdpacket.c", "SNDPDPacketPtrView"): (1276, (
            ("MOS", "ARY UCHAR", 1272, "pad", 0, (1272,), ""),
            ("MOS", "ARY INT", 4, "ptr", 1272, (1,), ""),
        )),
        # sbremove's bank-entry view can be flattened byte-exactly, but its
        # sndgs accesses require this aggregate MEM shape to retain 3/3 PASS.
        # Lock the complete private carrier for the stripped owner; a raw-byte
        # probe regressed cSNDbankremove by five instructions. Pre-change
        # source/tool backup: Git commit 1ec26a06.
        ("sbremove.c", "SNDGlobals"): (156, (
            ("MOS", "ARY CHAR", 12, "pad0", 0, (12,), ""),
            ("MOS", "USHORT", 0, "bank_count", 12, (), ""),
            ("MOS", "ARY CHAR", 3, "pad0e", 14, (3,), ""),
            ("MOS", "UCHAR", 0, "channel_count", 17, (), ""),
            ("MOS", "ARY CHAR", 42, "pad12", 18, (42,), ""),
            ("MOS", "CHAR", 0, "initialized", 60, (), ""),
            ("MOS", "ARY CHAR", 87, "pad3d", 61, (87,), ""),
            ("MOS", "INT", 0, "play_records", 148, (), ""),
            ("MOS", "INT", 0, "bank_table", 152, (), ""),
        )),
        ("first.c", "device_table"): (80, (
            ("MOS", "PTR CHAR", 0, "dt_string", 0, (), ""),
            ("MOS", "INT", 0, "dt_type", 4, (), ""),
            ("MOS", "INT", 0, "dt_bsize", 8, (), ""),
            ("MOS", "PTR CHAR", 0, "dt_desc", 12, (), ""),
            ("MOS", "PTR FCN INT", 0, "dt_init", 16, (), ""),
            ("MOS", "PTR FCN INT", 0, "dt_open", 20, (), ""),
            ("MOS", "PTR FCN INT", 0, "dt_strategy", 24, (), ""),
            ("MOS", "PTR FCN INT", 0, "dt_close", 28, (), ""),
            ("MOS", "PTR FCN INT", 0, "dt_ioctl", 32, (), ""),
            ("MOS", "PTR FCN INT", 0, "dt_read", 36, (), ""),
            ("MOS", "PTR FCN INT", 0, "dt_write", 40, (), ""),
            ("MOS", "PTR FCN INT", 0, "dt_delete", 44, (), ""),
            ("MOS", "PTR FCN INT", 0, "dt_undelete", 48, (), ""),
            ("MOS", "PTR FCN INT", 0, "dt_firstfile", 52, (), ""),
            ("MOS", "PTR FCN INT", 0, "dt_nextfile", 56, (), ""),
            ("MOS", "PTR FCN INT", 0, "dt_format", 60, (), ""),
            ("MOS", "PTR FCN INT", 0, "dt_cd", 64, (), ""),
            ("MOS", "PTR FCN INT", 0, "dt_rename", 68, (), ""),
            ("MOS", "PTR FCN INT", 0, "dt_remove", 72, (), ""),
            ("MOS", "PTR FCN INT", 0, "dt_else", 76, (), ""),
        )),
        ("slimits.c", "LimitsBlock"): (20, (
            ("MOS", "ARY INT", 20, "value", 0, (5,), ""),
        )),
        ("smath64.c", "SNDu64Value"): (8, (
            ("MOS", "UINT", 0, "lo", 0, (), ""),
            ("MOS", "UINT", 0, "hi", 4, (), ""),
        )),
        ("smasterv.c", "SNDMasterState"): (152, (
            ("MOS", "ARY UCHAR", 17, "pad0", 0, (17,), ""),
            ("MOS", "UCHAR", 0, "channel_count", 17, (), ""),
            ("MOS", "ARY UCHAR", 130, "pad1", 18, (130,), ""),
            ("MOS", "INT", 0, "play_records", 148, (), ""),
        )),
        ("sfxlevel.c", "SNDfxBusView"): (164, (
            ("MOS", "ARY UCHAR", 160, "pad", 0, (160,), ""),
            ("MOS", "INT", 0, "master", 160, (), ""),
        )),
        ("sdresolv.c", "SNDResolveEntry"): (8, (
            ("MOS", "INT", 0, "offset", 0, (), ""),
            ("MOS", "INT", 0, "spu", 4, (), ""),
        )),
        ("sdmemman.c", "PackedAllocSlot"): (1316, (
            ("MOS", "ARY UCHAR", 1312, "pad", 0, (1312,), ""),
            ("MOS", "INT", 0, "word", 1312, (), ""),
        )),
        ("sdma.c", "SNDDmaEntry"): (20, (
            ("MOS", "INT", 0, "handle", 0, (), ""),
            ("MOS", "INT", 0, "dstSpu", 4, (), ""),
            ("MOS", "USHORT", 0, "srcHi", 8, (), ""),
            ("MOS", "UCHAR", 0, "len64", 10, (), ""),
            ("MOS", "UCHAR", 0, "priority", 11, (), ""),
            ("MOS", "UCHAR", 0, "flag", 12, (), ""),
            ("MOS", "ARY UCHAR", 3, "pad", 13, (3,), ""),
            ("MOS", "INT", 0, "deadline", 16, (), ""),
        )),
        ("systask.c", "SysTaskSlot"): (16, (
            ("MOS", "INT", 0, "fn", 0, (), ""),
            ("MOS", "INT", 0, "period", 4, (), ""),
            ("MOS", "INT", 0, "deadline", 8, (), ""),
            ("MOS", "INT", 0, "busy", 12, (), ""),
        )),
        ("sbhdrcpy.c", "SNDGlobals"): (156, (
            ("MOS", "ARY CHAR", 60, "pad0", 0, (60,), ""),
            ("MOS", "CHAR", 0, "initialized", 60, (), ""),
            ("MOS", "ARY CHAR", 91, "pad3d", 61, (91,), ""),
            ("MOS", "INT", 0, "bank_table", 152, (), ""),
        )),
    }
    # Linked EA members can omit necessary local aggregate records.  Exact
    # retail code generation requires structure assignment in the math owners:
    # matrix.c's 36-byte movstrsi copies and trnsfrm.c's final 12-byte result
    # copy both regress when expressed as scalar/array source.  Accept only the
    # complete anonymous body + typedef pair in its exact owner.  spchevnt's
    # VoxSlot is likewise an exact typed view of the aliased gVoxEvents queue;
    # every recovered field/offset is used by its PASS bodies.  Pre-change
    # backup: Git commit c1385fa4; VoxSlot extension: Git commit 49c32f8e.
    untyped_library_anonymous_views = {
        # Canonical PsyQ 4.3 LIBCD.H declares CdlLOC as this anonymous
        # four-byte aggregate typedef (not `struct CdlLOC`). CDFS.OBJ is
        # stripped, so accept only the exact SDK body+typedef pair here.
        # Pre-change backup: Git commit 8f87889d.
        ("cdfs.c", "CdlLOC"): (4, (
            ("MOS", "UCHAR", 0, "minute", 0, (), ""),
            ("MOS", "UCHAR", 0, "second", 1, (), ""),
            ("MOS", "UCHAR", 0, "sector", 2, (), ""),
            ("MOS", "UCHAR", 0, "track", 3, (), ""),
        )),
        ("matrix.c", "mtx"): (36, (
            ("MOS", "ARY INT", 36, "m", 0, (9,), ""),
        )),
        ("spchevnt.c", "VoxSlot"): (60, (
            ("MOS", "INT", 0, "_ovl0", 0, (), ""),
            ("MOS", "INT", 0, "_ovl4", 4, (), ""),
            ("MOS", "USHORT", 0, "enabled", 8, (), ""),
            ("MOS", "USHORT", 0, "subTick", 10, (), ""),
            ("MOS", "INT", 0, "tick", 12, (), ""),
            ("MOS", "INT", 0, "event", 16, (), ""),
            ("MOS", "ARY INT", 40, "args", 20, (10,), ""),
        )),
        ("trnsfrm.c", "TransformResult"): (12, (
            ("MOS", "INT", 0, "x", 0, (), ""),
            ("MOS", "INT", 0, "y", 4, (), ""),
            ("MOS", "INT", 0, "z", 8, (), ""),
        )),
    }
    # lib/snd.h is the sole shared definition of the PSX sound runtime's
    # private state graph. SPAN/SSTSETPR/SVOL are stripped archive members, so
    # their SYM owners omit these header types even though their PASS bodies
    # dereference the graph. Keep one immutable complete specification and
    # pair-lock it only in those three exact owners. The instruction/field
    # sweep proves every size and offset; private tag/placeholder spellings
    # remain unprovable. Pre-change tool backup: Git commit 1cef9e31.
    shared_snd_runtime_views = {
        "SndVoice": (100, (
            ("MOS", "INT", 0, "handle", 0, (), ""),
            ("MOS", "INT", 0, "f04", 4, (), ""),
            ("MOS", "ARY CHAR", 2, "_g08", 8, (2,), ""),
            ("MOS", "CHAR", 0, "bank", 10, (), ""),
            ("MOS", "CHAR", 0, "f0B", 11, (), ""),
            ("MOS", "UCHAR", 0, "f0C", 12, (), ""),
            ("MOS", "ARY CHAR", 3, "_g0D", 13, (3,), ""),
            ("MOS", "INT", 0, "f10", 16, (), ""),
            ("MOS", "INT", 0, "f14", 20, (), ""),
            ("MOS", "INT", 0, "f18", 24, (), ""),
            ("MOS", "INT", 0, "f1C", 28, (), ""),
            ("MOS", "INT", 0, "f20", 32, (), ""),
            ("MOS", "INT", 0, "f24", 36, (), ""),
            ("MOS", "INT", 0, "f28", 40, (), ""),
            ("MOS", "CHAR", 0, "f2C", 44, (), ""),
            ("MOS", "CHAR", 0, "vol_l", 45, (), ""),
            ("MOS", "CHAR", 0, "pan", 46, (), ""),
            ("MOS", "CHAR", 0, "f2F", 47, (), ""),
            ("MOS", "CHAR", 0, "f30", 48, (), ""),
            ("MOS", "UCHAR", 0, "f31", 49, (), ""),
            ("MOS", "CHAR", 0, "f32", 50, (), ""),
            ("MOS", "CHAR", 0, "f33", 51, (), ""),
            ("MOS", "CHAR", 0, "f34", 52, (), ""),
            ("MOS", "CHAR", 0, "f35", 53, (), ""),
            ("MOS", "CHAR", 0, "f36", 54, (), ""),
            ("MOS", "UCHAR", 0, "f37", 55, (), ""),
            ("MOS", "UCHAR", 0, "f38", 56, (), ""),
            ("MOS", "UCHAR", 0, "f39", 57, (), ""),
            ("MOS", "UCHAR", 0, "f3A", 58, (), ""),
            ("MOS", "UCHAR", 0, "f3B", 59, (), ""),
            ("MOS", "CHAR", 0, "f3C", 60, (), ""),
            ("MOS", "CHAR", 0, "pan_cur", 61, (), ""),
            ("MOS", "ARY CHAR", 2, "_g3E", 62, (2,), ""),
            ("MOS", "INT", 0, "f40", 64, (), ""),
            ("MOS", "INT", 0, "f44", 68, (), ""),
            ("MOS", "INT", 0, "pancurve", 72, (), ""),
            ("MOS", "INT", 0, "f4C", 76, (), ""),
            ("MOS", "INT", 0, "f50", 80, (), ""),
            ("MOS", "INT", 0, "f54", 84, (), ""),
            ("MOS", "ARY CHAR", 2, "_g58", 88, (2,), ""),
            ("MOS", "SHORT", 0, "f5A", 90, (), ""),
            ("MOS", "SHORT", 0, "f5C", 92, (), ""),
            ("MOS", "SHORT", 0, "f5E", 94, (), ""),
            ("MOS", "USHORT", 0, "f60", 96, (), ""),
            ("MOS", "USHORT", 0, "f62", 98, (), ""),
        )),
        "SndBank": (12, (
            ("MOS", "PTR VOID", 0, "datablk", 0, (), ""),
            ("MOS", "PTR VOID", 0, "platblk", 4, (), ""),
            ("MOS", "UCHAR", 0, "f08", 8, (), ""),
            ("MOS", "UCHAR", 0, "inuse", 9, (), ""),
            ("MOS", "CHAR", 0, "f0A", 10, (), ""),
            ("MOS", "CHAR", 0, "f0B", 11, (), ""),
        )),
        "SndFxBus": (16, (
            ("MOS", "INT", 0, "type", 0, (), ""),
            ("MOS", "INT", 0, "master", 4, (), ""),
            ("MOS", "INT", 0, "depth", 8, (), ""),
            ("MOS", "INT", 0, "delay", 12, (), ""),
        )),
        "SndPlayDef": (20, (
            ("MOS", "INT", 0, "handle", 0, (), ""),
            ("MOS", "CHAR", 0, "f04", 4, (), ""),
            ("MOS", "CHAR", 0, "decay", 5, (), ""),
            ("MOS", "CHAR", 0, "vol0", 6, (), ""),
            ("MOS", "CHAR", 0, "pan0", 7, (), ""),
            ("MOS", "CHAR", 0, "vol1", 8, (), ""),
            ("MOS", "CHAR", 0, "pan1", 9, (), ""),
            ("MOS", "CHAR", 0, "vol2", 10, (), ""),
            ("MOS", "CHAR", 0, "f0B", 11, (), ""),
            ("MOS", "SHORT", 0, "pitch0", 12, (), ""),
            ("MOS", "SHORT", 0, "pitch1", 14, (), ""),
            ("MOS", "SHORT", 0, "f10", 16, (), ""),
            ("MOS", "SHORT", 0, "f12", 18, (), ""),
        )),
        "SndState": (188, (
            ("MOS", "ARY CHAR", 2, "_g00", 0, (2,), ""),
            ("MOS", "SHORT", 0, "f02", 2, (), ""),
            ("MOS", "CHAR", 0, "f04", 4, (), ""),
            ("MOS", "CHAR", 0, "f05", 5, (), ""),
            ("MOS", "CHAR", 0, "f06", 6, (), ""),
            ("MOS", "CHAR", 0, "f07", 7, (), ""),
            ("MOS", "CHAR", 0, "f08", 8, (), ""),
            ("MOS", "CHAR", 0, "f09", 9, (), ""),
            ("MOS", "ARY CHAR", 2, "_g0A", 10, (2,), ""),
            ("MOS", "USHORT", 0, "bankcount", 12, (), ""),
            ("MOS", "SHORT", 0, "f0E", 14, (), ""),
            ("MOS", "CHAR", 0, "f10", 16, (), ""),
            ("MOS", "UCHAR", 0, "patchcount", 17, (), ""),
            ("MOS", "CHAR", 0, "f12", 18, (), ""),
            ("MOS", "CHAR", 0, "f13", 19, (), ""),
            ("MOS", "CHAR", 0, "f14", 20, (), ""),
            ("MOS", "ARY CHAR", 39, "_g15", 21, (39,), ""),
            ("MOS", "CHAR", 0, "enabled", 60, (), ""),
            ("MOS", "CHAR", 0, "f3D", 61, (), ""),
            ("MOS", "UCHAR", 0, "f3E", 62, (), ""),
            ("MOS", "UCHAR", 0, "f3F", 63, (), ""),
            ("MOS", "UCHAR", 0, "f40", 64, (), ""),
            ("MOS", "UCHAR", 0, "f41", 65, (), ""),
            ("MOS", "ARY CHAR", 2, "_g42", 66, (2,), ""),
            ("MOS", "INT", 0, "f44", 68, (), ""),
            ("MOS", "INT", 0, "f48", 72, (), ""),
            ("MOS", "INT", 0, "f4C", 76, (), ""),
            ("MOS", "ARY CHAR", 44, "_g50", 80, (44,), ""),
            ("MOS", "INT", 0, "f7C", 124, (), ""),
            ("MOS", "INT", 0, "f80", 128, (), ""),
            ("MOS", "INT", 0, "f84", 132, (), ""),
            ("MOS", "INT", 0, "f88", 136, (), ""),
            ("MOS", "INT", 0, "f8C", 140, (), ""),
            ("MOS", "INT", 0, "f90", 144, (), ""),
            ("MOS", "PTR STRUCT", 100, "voices", 148, (), "SndVoice"),
            ("MOS", "PTR STRUCT", 12, "banks", 152, (), "SndBank"),
            ("MOS", "ARY STRUCT", 32, "fxbus", 156, (2,), "SndFxBus"),
        )),
    }
    # Several linked library members omit necessary owner-local/common graphs.
    # fileroot owns the exact deferred-read command and its BSS object; syncfile
    # owns the exact async-transfer control block; nsync's atomic-dispatch
    # wrappers require the exact LoadArgs stack record;
    # stream's tag classifier walks an exact StreamFilter array; and trnspos /
    # xform consume the shared NFS4 ``matrixtdef`` also recovered in
    # nfs4_types.h.  PsyQ PADENTRY/PADMAIN similarly retain member-shaped code
    # for their exact private controller and interrupt-path records while the
    # archive SYM omits their type records. Pair-lock each named tag and typedef
    # in its precise owner.
    # Pre-change backup for the first pair: Git commit cdba8752. Pre-change
    # backup for the LoadArgs/StreamFilter extension: Git commit dee8eb82;
    # PAD extension: Git commit 49c32f8e; ReadCmd/SyncCtrl extensions: Git
    # commit c0950c17.
    untyped_library_named_pair_views = {
        **{
            ("snd.h", name): layout
            for name, layout in shared_snd_runtime_views.items()
        },
        # CDFS.OBJ is stripped. Fourteen PASS bodies fix the 0x83c-byte CD
        # context plus the shared 16-byte read-state and 312-byte callback
        # stack record. Canonical PsyQ proves only their CdlLOC leaf, not these
        # private EA spellings. Pair-lock the exact recovered graph and retain
        # the naming limit in the durable receipt. Pre-change backup: Git
        # commit 8f87889d.
        ("cdfs.c", "CD_ctx_t"): (2108, (
            ("MOS", "INT", 0, "info", 0, (), ""),
            ("MOS", "INT", 0, "maxOpen", 4, (), ""),
            ("MOS", "INT", 0, "dirEntryCount", 8, (), ""),
            ("MOS", "INT", 0, "cachedSector", 12, (), ""),
            ("MOS", "INT", 0, "lastSector", 16, (), ""),
            ("MOS", "INT", 0, "curSector", 20, (), ""),
            ("MOS", "INT", 0, "timeout", 24, (), ""),
            ("MOS", "INT", 0, "ringIdx", 28, (), ""),
            ("MOS", "INT", 0, "curLen", 32, (), ""),
            ("MOS", "INT", 0, "remLen", 36, (), ""),
            ("MOS", "INT", 0, "curOff", 40, (), ""),
            ("MOS", "PTR VOID", 0, "curDst", 44, (), ""),
            ("MOS", "PTR FCN VOID", 0, "completionCallback", 48, (), ""),
            ("MOS", "PTR PTR VOID", 0, "handleTable", 52, (), ""),
            ("MOS", "PTR VOID", 0, "dirEntryArray", 56, (), ""),
            ("MOS", "ARY UCHAR", 2048, "sectorCache", 60,
             (2048,), ""),
        )),
        ("cdfs.c", "CDReadState"): (16, (
            ("MOS", "INT", 0, "curLen", 0, (), ""),
            ("MOS", "INT", 0, "remLen", 4, (), ""),
            ("MOS", "INT", 0, "curOff", 8, (), ""),
            ("MOS", "PTR VOID", 0, "curDst", 12, (), ""),
        )),
        ("cdfs.c", "CDReadyScratch"): (312, (
            ("MOS", "ARY STRUCT", 12, "hdr", 0, (3,), "<anonymous>"),
            ("MOS", "ARY UCHAR", 284, "sub", 12, (284,), ""),
            ("MOS", "ARY UCHAR", 8, "pos", 296, (8,), ""),
            ("MOS", "ARY INT", 8, "gpctx", 304, (2,), ""),
        )),
        # NFILE.OBJ is stripped. Its twenty-seven bodies fix the 0x30-byte
        # operation slots, 0x4c-byte handles, and 0x30-byte singleton graph;
        # no retained owner or compatible earlier FILE implementation proves
        # the private PSX spellings. Lock the exact recovered graph while
        # preserving that naming limit in the durable receipt. Pre-change
        # backup: Git commit 75b712a9.
        ("nfile.h", "FileOp"): (48, (
            ("MOS", "UINT", 0, "id", 0, (), ""),
            ("MOS", "INT", 0, "cancelreq", 4, (), ""),
            ("MOS", "INT", 0, "status", 8, (), ""),
            ("MOS", "INT", 0, "error", 12, (), ""),
            ("MOS", "INT", 0, "prio", 16, (), ""),
            ("MOS", "INT", 0, "param", 20, (), ""),
            ("MOS", "INT", 0, "result18", 24, (), ""),
            ("MOS", "INT", 0, "result1C", 28, (), ""),
            ("MOS", "ARY UCHAR", 4, "_g20", 32, (4,), ""),
            ("MOS", "INT", 0, "result24", 36, (), ""),
            ("MOS", "PTR FCN VOID", 0, "callback", 40, (), ""),
            ("MOS", "PTR STRUCT", 48, "qnext", 44, (), "FileOp"),
        )),
        ("nfile.h", "FileHandle"): (76, (
            ("MOS", "INT", 0, "inuse", 0, (), ""),
            ("MOS", "INT", 0, "size", 4, (), ""),
            ("MOS", "INT", 0, "flags", 8, (), ""),
            ("MOS", "ARY CHAR", 64, "name", 12, (64,), ""),
        )),
        ("nfile.h", "FileMgr"): (48, (
            ("MOS", "INT", 0, "opcount", 0, (), ""),
            ("MOS", "INT", 0, "handlecount", 4, (), ""),
            ("MOS", "INT", 0, "idmask", 8, (), ""),
            ("MOS", "INT", 0, "state", 12, (), ""),
            ("MOS", "INT", 0, "cbpending", 16, (), ""),
            ("MOS", "PTR STRUCT", 48, "curop", 20, (), "FileOp"),
            ("MOS", "PTR STRUCT", 48, "oparray", 24, (), "FileOp"),
            ("MOS", "PTR STRUCT", 76, "handlearray", 28, (),
             "FileHandle"),
            ("MOS", "PTR STRUCT", 48, "queuehead", 32, (), "FileOp"),
            ("MOS", "PTR VOID", 0, "devicelist", 36, (), ""),
            ("MOS", "ARY UCHAR", 8, "_g28", 40, (8,), ""),
        )),
        # NASYNC.OBJ is stripped. Its twenty-three PASS bodies jointly fix the
        # complete request/FIFO graph; the NFS2 PC twin confirms EA's async
        # request/queue vocabulary but uses a different layout and does not
        # retain the PSX private spellings in SYM. Lock the exact recovered
        # graph while keeping that naming limit explicit in the durable
        # receipt. Pre-change backup: Git commit 62734041.
        ("nasync.h", "AsyncReq"): (44, (
            ("MOS", "INT", 0, "id", 0, (), ""),
            ("MOS", "PTR STRUCT", 44, "next", 4, (), "AsyncReq"),
            ("MOS", "INT", 0, "bytesread", 8, (), ""),
            ("MOS", "INT", 0, "status", 12, (), ""),
            ("MOS", "INT", 0, "buffer", 16, (), ""),
            ("MOS", "INT", 0, "callback", 20, (), ""),
            ("MOS", "INT", 0, "fileop", 24, (), ""),
            ("MOS", "INT", 0, "handle", 28, (), ""),
            ("MOS", "INT", 0, "offset", 32, (), ""),
            ("MOS", "INT", 0, "arg24", 36, (), ""),
            ("MOS", "INT", 0, "dest", 40, (), ""),
        )),
        ("nasync.h", "AsyncQueue"): (8, (
            ("MOS", "PTR STRUCT", 44, "head", 0, (), "AsyncReq"),
            ("MOS", "PTR STRUCT", 44, "tail", 4, (), "AsyncReq"),
        )),
        # MEMSTD.OBJ is stripped. Its thirteen PASS bodies jointly fix the
        # complete block/class graph, including the nested free-list sentinel;
        # NFS2 PC's matched EA allocator independently confirms the block/class
        # vocabulary, but not these PSX tag spellings. Lock the exact recovered
        # private graph while keeping that naming limit explicit in the durable
        # receipt. Pre-change backup: Git commit 7561d4f3.
        ("memstd.c", "MemBlock"): (24, (
            ("MOS", "USHORT", 0, "magic", 0, (), ""),
            ("MOS", "USHORT", 0, "flags", 2, (), ""),
            ("MOS", "INT", 0, "size", 4, (), ""),
            ("MOS", "PTR STRUCT", 24, "physnext", 8, (), "MemBlock"),
            ("MOS", "PTR STRUCT", 24, "physprev", 12, (), "MemBlock"),
            ("MOS", "PTR STRUCT", 24, "freenext", 16, (), "MemBlock"),
            ("MOS", "PTR STRUCT", 24, "freeprev", 20, (), "MemBlock"),
        )),
        ("memstd.c", "MemClass"): (64, (
            ("MOS", "ARY CHAR", 8, "name", 0, (8,), ""),
            ("MOS", "PTR STRUCT", 24, "phys_first", 8, (), "MemBlock"),
            ("MOS", "PTR STRUCT", 24, "phys_last", 12, (), "MemBlock"),
            ("MOS", "STRUCT", 24, "freehead", 16, (), "MemBlock"),
            ("MOS", "INT", 0, "granularity", 40, (), ""),
            ("MOS", "INT", 0, "alignment", 44, (), ""),
            ("MOS", "INT", 0, "infosize", 48, (), ""),
            ("MOS", "INT", 0, "flags", 52, (), ""),
            ("MOS", "PTR VOID", 0, "mutex", 56, (), ""),
            ("MOS", "INT", 0, "field3c", 60, (), ""),
        )),
        # SSYSINIT.OBJ is stripped, but the linked game owners repeatedly
        # retain the public sound header's complete SNDSYSOPTS graph.  The
        # canonical 12+44+4 composition also replaces two synthetic aggregate
        # copy carriers while preserving 4/4 PASS.  Pair-lock every public tag
        # and typedef in this exact owner. Pre-change backup: Git b48a475f.
        ("ssysinit.c", "SNDSYSCAP"): (12, (
            ("MOS", "USHORT", 0, "outputratemin", 0, (), ""),
            ("MOS", "USHORT", 0, "outputratemax", 2, (), ""),
            ("MOS", "UCHAR", 0, "outputchannelsmin", 4, (), ""),
            ("MOS", "UCHAR", 0, "outputchannelsmax", 5, (), ""),
            ("MOS", "UCHAR", 0, "inputvoicesmax", 6, (), ""),
            ("MOS", "UCHAR", 0, "input3dvoicesmax", 7, (), ""),
            ("MOS", "UCHAR", 0, "eax", 8, (), ""),
            ("MOS", "UCHAR", 0, "voicemanager", 9, (), ""),
            ("MOS", "ARY CHAR", 2, "pad", 10, (2,), ""),
        )),
        ("ssysinit.c", "SNDSYSSET"): (44, (
            ("MOS", "USHORT", 0, "maxbanks", 0, (), ""),
            ("MOS", "USHORT", 0, "outputrate", 2, (), ""),
            ("MOS", "UCHAR", 0, "outputchannels", 4, (), ""),
            ("MOS", "UCHAR", 0, "inputvoices", 5, (), ""),
            ("MOS", "UCHAR", 0, "useeax", 6, (), ""),
            ("MOS", "UCHAR", 0, "use3dacceleration", 7, (), ""),
            ("MOS", "UCHAR", 0, "use3dmixing", 8, (), ""),
            ("MOS", "CHAR", 0, "pad", 9, (), ""),
            ("MOS", "USHORT", 0, "emulationsubtype", 10, (), ""),
            ("MOS", "ARY ARY USHORT", 32, "spkrcfg3d", 12,
             (4, 4), ""),
        )),
        ("ssysinit.c", "SNDSYSVEC"): (4, (
            ("MOS", "PTR FCN INT", 0, "issurfacelocked", 0, (), ""),
        )),
        ("ssysinit.c", "SNDSYSOPTS"): (60, (
            ("MOS", "STRUCT", 12, "cap", 0, (), "SNDSYSCAP"),
            ("MOS", "STRUCT", 44, "set", 12, (), "SNDSYSSET"),
            ("MOS", "STRUCT", 4, "vec", 56, (), "SNDSYSVEC"),
        )),
        # SST.OBJ is stripped, but retained NFS4.SYM records in linked game
        # owners fix the complete public SNDSAMPLEFORMAT and SNDPLAYOPTS
        # graphs. The two types replace three synthetic aggregate-copy tags
        # while preserving 16/16 PASS. The matching NFS3/NFS4-PC streamer and
        # the PSX instructions jointly fix the private 0x2c SndStreamReq
        # offsets and roles; only that private tag's spelling remains
        # unprovable. Pair-lock all three exact source graphs in this owner.
        # Pre-change source/tool backup: Git commit 82858a01.
        ("sst.c", "SNDSAMPLEFORMAT"): (4, (
            ("MOS", "USHORT", 0, "samplerate", 0, (), ""),
            ("MOS", "UCHAR", 0, "channels", 2, (), ""),
            ("MOS", "UCHAR", 0, "samplerep", 3, (), ""),
        )),
        ("sst.c", "SNDPLAYOPTS"): (20, (
            ("MOS", "INT", 0, "patnum", 0, (), ""),
            ("MOS", "CHAR", 0, "bhandle", 4, (), ""),
            ("MOS", "CHAR", 0, "keynum", 5, (), ""),
            ("MOS", "CHAR", 0, "velocity", 6, (), ""),
            ("MOS", "CHAR", 0, "pan", 7, (), ""),
            ("MOS", "CHAR", 0, "vol", 8, (), ""),
            ("MOS", "CHAR", 0, "bend", 9, (), ""),
            ("MOS", "CHAR", 0, "fxlevel0", 10, (), ""),
            ("MOS", "CHAR", 0, "use3dpos", 11, (), ""),
            ("MOS", "USHORT", 0, "pitchmult", 12, (), ""),
            ("MOS", "USHORT", 0, "timemult", 14, (), ""),
            ("MOS", "USHORT", 0, "azimuth", 16, (), ""),
            ("MOS", "SHORT", 0, "elevation", 18, (), ""),
        )),
        ("sst.c", "SndStreamReq"): (44, (
            ("MOS", "PTR VOID", 0, "source", 0, (), ""),
            ("MOS", "INT", 0, "request_tag", 4, (), ""),
            ("MOS", "INT", 0, "firstqid", 8, (), ""),
            ("MOS", "INT", 0, "qid", 12, (), ""),
            ("MOS", "INT", 0, "rate", 16, (), ""),
            ("MOS", "INT", 0, "played", 20, (), ""),
            ("MOS", "INT", 0, "hdr", 24, (), ""),
            ("MOS", "INT", 0, "total", 28, (), ""),
            ("MOS", "INT", 0, "count", 32, (), ""),
            ("MOS", "INT", 0, "expected", 36, (), ""),
            ("MOS", "SHORT", 0, "underrun", 40, (), ""),
            ("MOS", "SHORT", 0, "pad2a", 42, (), ""),
        )),
        # SPKTPLAY.OBJ is stripped. Retained game-owner SYM records prove the
        # public packed SNDSAMPLEFORMAT graph; thirteen PASS bodies prove the
        # 0x18-byte packet-frame layout. Purge's two semantic prefix/tail views
        # preserve the retail two-batch copy and allocno without opaque word
        # arrays. Pair-lock every graph completely; private view spellings
        # remain unprovable. Pre-change source/tool backup: Git 206f78eb.
        ("spktplay.c", "SNDSAMPLEFORMAT"): (4, (
            ("MOS", "USHORT", 0, "samplerate", 0, (), ""),
            ("MOS", "UCHAR", 0, "channels", 2, (), ""),
            ("MOS", "UCHAR", 0, "samplerep", 3, (), ""),
        )),
        ("spktplay.c", "PacketFrame"): (24, (
            ("MOS", "INT", 0, "reserved", 0, (), ""),
            ("MOS", "INT", 0, "size", 4, (), ""),
            ("MOS", "ARY INT", 16, "channel", 8, (4,), ""),
        )),
        ("spktplay.c", "PacketFramePrefix"): (16, (
            ("MOS", "INT", 0, "reserved", 0, (), ""),
            ("MOS", "INT", 0, "size", 4, (), ""),
            ("MOS", "ARY INT", 8, "channel", 8, (2,), ""),
        )),
        ("spktplay.c", "PacketFrameTail"): (8, (
            ("MOS", "ARY INT", 8, "channel", 0, (2,), ""),
        )),
        # SMEMMAN.OBJ is stripped. Its four PASS bodies and the sndmm BSS
        # extent fix the complete 0x20c-byte allocator state; the insertion
        # loop proves that +0xc is an array of 128 four-byte {block,size}
        # records rather than a flat halfword array. Pair-lock both exact
        # private graphs while retaining the naming limit in the receipt.
        # Pre-change source/tool backup: Git commit 0e579de8.
        ("smemman.c", "SndMemEnt"): (4, (
            ("MOS", "USHORT", 0, "blk", 0, (), ""),
            ("MOS", "USHORT", 0, "sz", 2, (), ""),
        )),
        ("smemman.c", "SNDMemState"): (524, (
            ("MOS", "INT", 0, "base", 0, (), ""),
            ("MOS", "USHORT", 0, "count", 4, (), ""),
            ("MOS", "USHORT", 0, "poolWords", 6, (), ""),
            ("MOS", "INT", 0, "highWater", 8, (), ""),
            ("MOS", "ARY STRUCT", 512, "entries", 12, (128,),
             "SndMemEnt"),
        )),
        # CDREAD.OBJ is stripped, but PsyQ 4.3 libcd.h fixes CdlLOC and CdlCB,
        # while retail instructions fix every byte of the private _cdr state.
        # Keep both named aggregates pair-locked to this owner. Pre-change
        # source/tool backup: Git commit 59233e9b.
        ("cdread.c", "CdlLOC"): (4, (
            ("MOS", "UCHAR", 0, "minute", 0, (), ""),
            ("MOS", "UCHAR", 0, "second", 1, (), ""),
            ("MOS", "UCHAR", 0, "sector", 2, (), ""),
            ("MOS", "UCHAR", 0, "track", 3, (), ""),
        )),
        ("cdread.c", "CdrEnv"): (56, (
            ("MOS", "INT", 0, "w00", 0, (), ""),
            ("MOS", "PTR UCHAR", 0, "w04", 4, (), ""),
            ("MOS", "PTR UCHAR", 0, "w08", 8, (), ""),
            ("MOS", "INT", 0, "w0c", 12, (), ""),
            ("MOS", "INT", 0, "w10", 16, (), ""),
            ("MOS", "INT", 0, "w14", 20, (), ""),
            ("MOS", "INT", 0, "w18", 24, (), ""),
            ("MOS", "INT", 0, "w1c", 28, (), ""),
            ("MOS", "INT", 0, "w20", 32, (), ""),
            ("MOS", "INT", 0, "w24", 36, (), ""),
            ("MOS", "PTR FCN VOID", 0, "w28", 40, (), ""),
            ("MOS", "PTR FCN VOID", 0, "w2c", 44, (), ""),
            ("MOS", "PTR FCN VOID", 0, "w30", 48, (), ""),
            ("MOS", "PTR UCHAR", 0, "w34", 52, (), ""),
        )),
        ("fileroot.c", "ReadCmd"): (20, (
            ("MOS", "INT", 0, "pending", 0, (), ""),
            ("MOS", "INT", 0, "handle", 4, (), ""),
            ("MOS", "INT", 0, "dest", 8, (), ""),
            ("MOS", "INT", 0, "offset", 12, (), ""),
            ("MOS", "INT", 0, "len", 16, (), ""),
        )),
        ("nsync.c", "LoadArgs"): (16, (
            ("MOS", "PTR CHAR", 0, "name", 0, (), ""),
            ("MOS", "INT", 0, "dest", 4, (), ""),
            ("MOS", "INT", 0, "memclass", 8, (), ""),
            ("MOS", "INT", 0, "abortval", 12, (), ""),
        )),
        ("stream.c", "StreamFilter"): (12, (
            ("MOS", "UINT", 0, "mask", 0, (), ""),
            ("MOS", "UINT", 0, "value", 4, (), ""),
            ("MOS", "UINT", 0, "consumer", 8, (), ""),
        )),
        ("syncfile.c", "SyncCtrl"): (36, (
            ("MOS", "INT", 0, "cbarg", 0, (), ""),
            ("MOS", "INT", 0, "fd", 4, (), ""),
            ("MOS", "INT", 0, "buf", 8, (), ""),
            ("MOS", "INT", 0, "remain", 12, (), ""),
            ("MOS", "INT", 0, "done", 16, (), ""),
            ("MOS", "INT", 0, "chunk", 20, (), ""),
            ("MOS", "INT", 0, "offset", 24, (), ""),
            ("MOS", "PTR FCN INT", 0, "iofn", 28, (), ""),
            ("MOS", "INT", 0, "op", 32, (), ""),
        )),
        ("padentry.c", "_PadDev"): (236, (
            ("MOS", "PTR USHORT", 0, "mode_tbl", 0, (), ""),
            ("MOS", "PTR UCHAR", 0, "act_tbl", 4, (), ""),
            ("MOS", "ARY CHAR", 8, "_pad08", 8, (8,), ""),
            ("MOS", "PTR STRUCT", 236, "self", 16, (), "_PadDev"),
            ("MOS", "ARY CHAR", 28, "_pad14", 20, (28,), ""),
            ("MOS", "PTR CHAR", 0, "flag_ptr", 48, (), ""),
            ("MOS", "UINT", 0, "status", 52, (), ""),
            ("MOS", "UCHAR", 0, "connected", 56, (), ""),
            ("MOS", "ARY CHAR", 2, "_pad39", 57, (2,), ""),
            ("MOS", "ARY CHAR", 14, "_pad3b", 59, (14,), ""),
            ("MOS", "UCHAR", 0, "state", 73, (), ""),
            ("MOS", "ARY CHAR", 2, "_pad4a", 74, (2,), ""),
            ("MOS", "INT", 0, "term100", 76, (), ""),
            ("MOS", "ARY CHAR", 147, "_pad50", 80, (147,), ""),
            ("MOS", "UCHAR", 0, "nmode", 227, (), ""),
            ("MOS", "UCHAR", 0, "mode3", 228, (), ""),
            ("MOS", "ARY CHAR", 1, "_pade5", 229, (1,), ""),
            ("MOS", "USHORT", 0, "modeword", 230, (), ""),
            ("MOS", "UCHAR", 0, "mode1", 232, (), ""),
            ("MOS", "UCHAR", 0, "nact", 233, (), ""),
        )),
        ("padmain.c", "_PadIntRP"): (16, (
            ("MOS", "PTR STRUCT", 16, "next", 0, (), "_PadIntRP"),
            ("MOS", "PTR FCN VOID", 0, "handler", 4, (), ""),
            ("MOS", "PTR FCN INT", 0, "verifier", 8, (), ""),
            ("MOS", "INT", 0, "_pad0c", 12, (), ""),
        )),
        ("trnspos.c", "matrixtdef"): (36, (
            ("MOS", "ARY INT", 36, "m", 0, (9,), ""),
        )),
        ("xform.c", "matrixtdef"): (36, (
            ("MOS", "ARY INT", 36, "m", 0, (9,), ""),
        )),
    }
    # Exact header aliases required by the stripped CDREAD member. Aggregate
    # typedefs are handled by the stricter pair locks above; these are the
    # three standalone canonical aliases only. Pre-change backup: 59233e9b.
    untyped_library_exact_typedefs = {
        ("cdread.c", "CdlCB"): ("PTR FCN VOID", 0, ""),
        ("cdread.c", "u_char"): ("UCHAR", 0, ""),
        ("cdread.c", "u_long"): ("ULONG", 0, ""),
    }
    feinput_views = {
        # FEInput.obj references pad.obj's anonymous 84-byte gPadinfo object.
        # Retail retains PAD_COMMON but deliberately omits the owning aggregate
        # tag; nevertheless, the exact instructions require buf at symbol+4.
        # Filter only this fully priced foreign-symbol view in its owning header.
        "FEInput_PadCodegenView": (84, (
            ("MOS", "INT", 0, "initialized", 0, (), ""),
            ("MOS", "ARY STRUCT", 64, "buf", 4, (8,), "PAD_COMMON"),
            ("MOS", "ARY UCHAR", 16, "stateBytes", 68, (16,), ""),
        )),
    }
    fescreen_views = {
        # FEScreen.obj directly manipulates two foreign render globals whose
        # owning tags are absent from its retail graph.  Their member-shaped
        # instructions require these exact layouts; suppress only the complete
        # struct/typedef pairs emitted from fescreen_externs.h.
        "FEScreen_DFlipCodegenView": (24, (
            ("MOS", "STRUCT", 20, "disp", 0, (), "DISPENV"),
            ("MOS", "PTR CHAR", 0, "server", 20, (), ""),
        )),
        "FEScreen_DrawViewCodegenView": (200, (
            ("MOS", "INT", 0, "otsize", 0, (), ""),
            ("MOS", "INT", 0, "membudget", 4, (), ""),
            ("MOS", "ARY STRUCT", 184, "drawenv", 8, (2,), "DRAWENV"),
            ("MOS", "ARY PTR ULONG", 8, "ot", 192, (2,), ""),
        )),
    }
    fecars_views = {
        # FECars needs the shared manager field layout before declaring the
        # real owner class with its complete method surface.  The macro-bound
        # first spelling is a compiler-boundary carrier only; accept it solely
        # with the complete 908-byte retail layout emitted by fe_core_types.h.
        "FECars_CoreCarManagerCodegenView": (908, (
            ("MOS", "ULONG", 0, "fNumCars", 0, (), ""),
            ("MOS", "PTR STRUCT", 204, "fCars", 4, (), "tCarInfo"),
            ("MOS", "ARY ARY STRUCT", 256, "fCarGarage", 8, (2, 32), "tOwnedCarInfo"),
            ("MOS", "ARY ARY STRUCT", 256, "fPinkSlipsCars", 264, (2, 32), "tOwnedCarInfo"),
            ("MOS", "ARY UCHAR", 48, "fAvailableCars", 520, (48,), ""),
            ("MOS", "ARY UCHAR", 48, "fViewableCars", 568, (48,), ""),
            ("MOS", "ARY ARY UCHAR", 96, "fPinkSlipsAvailableCars", 616, (2, 48), ""),
            ("MOS", "ARY ARY UCHAR", 96, "fPinkSlipsViewableCars", 712, (2, 48), ""),
            ("MOS", "ARY SHORT", 98, "fCarTextList", 808, (49,), ""),
        )),
    }
    fetourn_views = {
        "FETourn_CoreCarManagerCodegenView": (
            fecars_views["FECars_CoreCarManagerCodegenView"][0],
            fecars_views["FECars_CoreCarManagerCodegenView"][1],
            "fe_core_types.h",
        ),
        # The linked owner retains tSaveRecords[187] but attributes the already
        # seen tRecordBuffer tag body elsewhere.  CC1PL needs this exact body to
        # form the array typedef; suppress only the complete local tag/typedef
        # pair and keep the public tSaveRecords row visible to the comparison.
        # Fecntl.obj retains the same public tSaveRecords typedef while the
        # linked SYM attributes its element body elsewhere.  Both owner headers
        # therefore require the identical pair-locked compiler carrier.
        "tRecordBuffer": (20, (
            ("MOS", "ARY CHAR", 8, "sName", 0, (8,), ""),
            ("MOS", "INT", 0, "nCar", 8, (), ""),
            ("MOS", "INT", 0, "nTime", 12, (), ""),
            ("MOS", "INT", 0, "nBestLap", 16, (), ""),
        ), ("fetourn_types.h", "fecntl_types.h", "fecheats_types.h",
            "femenuextended_types.h", "screenpinkslips_types.h",
            "screenpost_types.h", "femenuoptions_types.h")),
    }
    # FECheats dereferences FEApp's embedded MemCardDialog.  CC1PL therefore
    # needs the complete application layout even though the linked owner keeps
    # that foreign class definition with FEApp.obj.  Require the exact 896-byte
    # tag/typedef pair from the one owner header.  Pre-change backup: Git commit
    # 1880cf75.
    fecheats_views = {
        "tFEApplication": (896, (
            ("MOS", "UINT", 0, "fCurrentMusic", 0, (), ""),
            ("MOS", "ARY PTR STRUCT", 8, "fCurrentMenu", 4, (2,), "tMenu"),
            ("MOS", "ARY PTR STRUCT", 8, "fCurrentScreen", 12, (2,), "tScreen"),
            ("MOS", "ARY PTR STRUCT", 8, "fTransitionToMenu", 20, (2,), "tMenu"),
            ("MOS", "ARY PTR STRUCT", 8, "fTransitionToScreen", 28, (2,), "tScreen"),
            ("MOS", "ARY PTR STRUCT", 8, "fParentMenu", 36, (2,), "tMenu"),
            ("MOS", "STRUCT", 152, "messagePopup", 44, (), "tDialogMessageString"),
            ("MOS", "ARY ARY PTR STRUCT", 128, "backList", 196, (2, 16), "tMenu"),
            ("MOS", "ARY INT", 8, "backDepth", 324, (2,), ""),
            ("MOS", "ARY ENUM", 8, "fLastKeyPressed", 332, (2,), "tInputKeyType"),
            ("MOS", "SHORT", 0, "fYOffset", 340, (), ""),
            ("MOS", "STRUCT", 212, "helpPopup", 344, (), "tDialogHelp"),
            ("MOS", "CHAR", 0, "fPlayer", 556, (), ""),
            ("MOS", "CHAR", 0, "fInputPlayer", 557, (), ""),
            ("MOS", "ARY BOOL", 8, "waitingForOtherPlayer", 560, (2,), ""),
            ("MOS", "STRUCT", 152, "MemCardDialog", 568, (),
             "tDialogMessageStringWithTimeout"),
            ("MOS", "STRUCT", 152, "NoInputMemCardDialog", 720, (),
             "tDialogNoInputMessage"),
            ("MOS", "ARY BOOL", 8, "gotName", 872, (2,), ""),
            ("MOS", "ARY BOOL", 8, "needName", 880, (2,), ""),
            ("MOS", "ARY INT", 8, "speechToPlay", 888, (2,), ""),
        ), "fecheats_types.h"),
    }
    # FEMemCard.obj directly dereferences three foreign globals whose owning
    # aggregate tags are not retained in its linked type graph.  The exact
    # field offsets are nevertheless required for the retail instructions.
    # Suppress only complete tag/typedef pairs with every member, size, leaf
    # tag, and owner path priced here.  Pre-change backup: Git commit 5f4a3318.
    fememcard_views = {
        "FEMemcard_PadCodegenView": (84, (
            ("MOS", "INT", 0, "initialized", 0, (), ""),
            ("MOS", "ARY STRUCT", 64, "buf", 4, (8,), "PAD_COMMON"),
            ("MOS", "ARY CHAR", 16, "stateBytes", 68, (16,), ""),
        ), "fememcard_types.h"),
        "FEMemcard_MemCardInfoCodegenView": (56, (
            ("MOS", "ARY CHAR", 52, "_beforeReady", 0, (52,), ""),
            ("MOS", "INT", 0, "bReady", 52, (), ""),
        ), "fememcard_types.h"),
        "FEMemcard_ScreenMemcardCodegenView": (1444, (
            ("MOS", "ARY CHAR", 1440, "_beforeGetNewIcons", 0, (1440,), ""),
            ("MOS", "BOOL", 0, "fGetNewIcons", 1440, (), ""),
        ), "fememcard_types.h"),
    }
    # ScreenMemcard.obj uses two fields from foreign frontend aggregates and
    # a named bitfield carrier for PsyQ primitive linkage.  None of these
    # completed tags is retained by the retail owner.  Suppress only exact,
    # origin-checked tag/typedef pairs.  Pre-change backup: Git commit bbbe104b.
    screenmemcard_views = {
        "ScreenMemcard_FEApplicationCodegenView": (558, (
            ("MOS", "ARY CHAR", 557, "_beforeInputPlayer", 0, (557,), ""),
            ("MOS", "CHAR", 0, "fInputPlayer", 557, (), ""),
        ), "screenmemcard_types.h"),
        "ScreenMemcard_GlobalMenuDefsCodegenView": (12460, (
            ("MOS", "ARY CHAR", 12372, "_beforeItemSaveGame", 0,
             (12372,), ""),
            ("MOS", "STRUCT", 44, "itemSaveGame", 12372, (),
             "tMemoryCardMenuItem"),
            ("MOS", "STRUCT", 44, "itemLoadGame", 12416, (),
             "tMemoryCardMenuItem"),
        ), "screenmemcard_types.h"),
        "ScreenMemcard_PrimTagCodegenCarrier": (4, (
            ("FIELD", "UINT", 24, "addr", 0, (), ""),
            ("FIELD", "UINT", 8, "len", 24, (), ""),
        ), "screenmemcard_types.h"),
    }
    # FEDialog.obj reads pad.obj's anonymous gPadinfo storage at the canonical
    # PAD_COMMON buf offsets, but its linked type graph does not retain the
    # owning aggregate tag.  Suppress only the complete, owner-local tag and
    # typedef pair with all 84 bytes priced here.  Pre-change backup: Git
    # commit 2198f1eb.
    fedialog_views = {
        "FEDialog_PadCodegenView": (84, (
            ("MOS", "INT", 0, "initialized", 0, (), ""),
            ("MOS", "ARY STRUCT", 64, "buf", 4, (8,), "PAD_COMMON"),
            ("MOS", "ARY CHAR", 16, "stateBytes", 68, (16,), ""),
        ), "fedialog_types.h"),
    }
    # ScreenCarSelect.obj dereferences three foreign singleton aggregates and
    # uses one named PsyQ primitive-link cast without retaining any of their
    # completed tags.  Suppress only exact tag/typedef pairs with every member,
    # bit width, offset, leaf tag, size, and owner priced below.  Its anonymous
    # tCarInfo/signed-byte stack alias is likewise accepted only as the exact
    # 204-byte owner-local union proved necessary by the 59/59 oracle.  Any
    # drift remains visible.  Pre-change backup: Git commit fc30a9cd.
    screencarselect_views = {
        "ScreenCarSelect_GameSetupCodegenView": (64, (
            ("MOS", "ARY INT", 60, "_beforeTrack", 0, (15,), ""),
            ("MOS", "INT", 0, "track", 60, (), ""),
        ), "screencarselect_types.h"),
        "ScreenCarSelect_PadCodegenView": (68, (
            ("MOS", "INT", 0, "initialized", 0, (), ""),
            ("MOS", "ARY STRUCT", 64, "buf", 4, (8,), "PAD_COMMON"),
        ), "screencarselect_types.h"),
        "ScreenCarSelect_GlobalMenuDefsCodegenView": (8408, (
            ("MOS", "ARY CHAR", 4460, "_beforeIteratorCar1", 0, (4460,), ""),
            ("MOS", "STRUCT", 28, "iteratorCar1", 4460, (), "tListIteratorCar"),
            ("MOS", "ARY CHAR", 76, "_beforeItemCar", 4488, (76,), ""),
            ("MOS", "STRUCT", 40, "itemCar", 4564, (), "tMenuItemNFS4LeftRightChoice"),
            ("MOS", "STRUCT", 40, "itemColor", 4604, (), "tMenuItemNFS4LeftRightChoice"),
            ("MOS", "STRUCT", 44, "itemShowcase", 4644, (), "tMenuItemGoToMenuNFS4Button"),
            ("MOS", "ARY CHAR", 124, "_beforeIteratorGarageCar", 4688, (124,), ""),
            ("MOS", "STRUCT", 28, "iteratorGarageCar", 4812, (), "tListIteratorCar"),
            ("MOS", "STRUCT", 40, "itemGarageCar", 4840, (), "tMenuItemNFS4LeftRightChoice"),
            ("MOS", "STRUCT", 44, "itemCarDealer", 4880, (), "tMenuItemGoToMenuNFS4Button"),
            ("MOS", "STRUCT", 44, "itemUpgradeCar", 4924, (), "tMenuItemGoToMenuNFS4Button"),
            ("MOS", "ARY CHAR", 248, "_beforeIteratorOpponentCar", 4968, (248,), ""),
            ("MOS", "STRUCT", 28, "iteratorOpponentCar", 5216, (), "tListIteratorCar"),
            ("MOS", "ARY CHAR", 540, "_beforeItemColorP1", 5244, (540,), ""),
            ("MOS", "STRUCT", 40, "itemColorP1", 5784, (), "tMenuItemNFS4LeftRightChoice"),
            ("MOS", "ARY CHAR", 208, "_beforeItemColorP2", 5824, (208,), ""),
            ("MOS", "STRUCT", 40, "itemColorP2", 6032, (), "tMenuItemNFS4LeftRightChoice"),
            ("MOS", "ARY CHAR", 540, "_beforeIteratorPinkSlipsCar", 6072, (540,), ""),
            ("MOS", "STRUCT", 28, "iteratorPinkSlipsCar", 6612, (), "tListIteratorCar"),
            ("MOS", "ARY CHAR", 688, "_beforeItemDealerCar", 6640, (688,), ""),
            ("MOS", "STRUCT", 40, "itemDealerCar", 7328, (), "tMenuItemNFS4LeftRightChoice"),
            ("MOS", "ARY CHAR", 280, "_beforeItemSellerCar", 7368, (280,), ""),
            ("MOS", "STRUCT", 40, "itemSellerCar", 7648, (), "tMenuItemNFS4LeftRightChoice"),
            ("MOS", "STRUCT", 44, "itemSellCar", 7688, (), "tMenuItemGoToMenuNFS4Button"),
            ("MOS", "ARY CHAR", 256, "_beforeMenuCarUpgrades", 7732, (256,), ""),
            ("MOS", "STRUCT", 124, "menuCarUpgrades", 7988, (), "tMenuNFS4"),
            ("MOS", "ARY CHAR", 72, "_beforeItemTransmission", 8112, (72,), ""),
            ("MOS", "STRUCT", 32, "itemTransmission", 8184, (), "tMenuItemOptionsLeftRightChoice"),
            ("MOS", "STRUCT", 32, "itemABS", 8216, (), "tMenuItemOptionsLeftRightChoice"),
            ("MOS", "STRUCT", 32, "itemDamage", 8248, (), "tMenuItemOptionsLeftRightChoice"),
            ("MOS", "STRUCT", 32, "itemTransmission2", 8280, (), "tMenuItemOptionsLeftRightChoice"),
            ("MOS", "STRUCT", 32, "itemABS2", 8312, (), "tMenuItemOptionsLeftRightChoice"),
            ("MOS", "STRUCT", 32, "itemDamage2", 8344, (), "tMenuItemOptionsLeftRightChoice"),
            ("MOS", "STRUCT", 32, "itemOpponentUpgrades", 8376, (), "tMenuItemOptionsLeftRightChoice"),
        ), "screencarselect_types.h"),
        "tPsyQPrimTag": (4, (
            ("FIELD", "UINT", 24, "addr", 0, (), ""),
            ("FIELD", "UINT", 8, "len", 24, (), ""),
        ), "screencarselect.cpp"),
    }
    screencarselect_union_rows = (
        ("MOU", "STRUCT", 204, "carInfo", 0, (), "tCarInfo"),
        ("MOU", "CHAR", 0, "signedCarID", 0, (), ""),
    )
    # FEApp.obj reads three foreign singleton aggregates and uses two
    # component-reference packet carriers without retaining their source tags.
    # Suppress only complete tag/typedef pairs with every byte, field, leaf
    # type, bit width, offset, and source origin locked below.  Pre-change
    # backup: Git commit a1bda045.
    feapp_views = {
        "FeApp_GameSetupCodegenView": (40, (
            ("MOS", "ARY INT", 36, "_beforeReplayMode", 0, (9,), ""),
            ("MOS", "INT", 0, "replayMode", 36, (), ""),
        ), "feapp_types.h"),
        "FeApp_PadCodegenView": (84, (
            ("MOS", "INT", 0, "initialized", 0, (), ""),
            ("MOS", "ARY STRUCT", 64, "buf", 4, (8,), "PAD_COMMON"),
            ("MOS", "ARY CHAR", 16, "stateBytes", 68, (16,), ""),
        ), "feapp_types.h"),
        "FeApp_GlobalMenuDefsCodegenView": (14288, (
            ("MOS", "STRUCT", 44, "itemMainOnePlayerRace", 0, (),
             "tMenuItemGoToMenuNFS4Button"),
            ("MOS", "STRUCT", 44, "itemMainTwoPlayerRace", 44, (),
             "tMenuItemGoToMenuNFS4Button"),
            ("MOS", "ARY CHAR", 88, "_beforeMenuMain", 88, (88,), ""),
            ("MOS", "STRUCT", 124, "menuMain", 176, (), "tMenuNFS4"),
            ("MOS", "ARY CHAR", 12428, "_beforeUserName1", 300,
             (12428,), ""),
            ("MOS", "STRUCT", 140, "menuItemUserName1", 12728, (),
             "tUserNameMenuItem"),
            ("MOS", "STRUCT", 140, "menuItemUserName2", 12868, (),
             "tUserNameMenuItem"),
            ("MOS", "ARY CHAR", 1024, "_beforePostGameNames", 13008,
             (1024,), ""),
            ("MOS", "STRUCT", 128, "menuPostGamePlayer1Name", 14032, (),
             "tOptionsMenu"),
            ("MOS", "STRUCT", 128, "menuPostGamePlayer2Name", 14160, (),
             "tOptionsMenu"),
        ), "feapp_types.h"),
        "tPsyQPrimTag": (4, (
            ("FIELD", "UINT", 24, "addr", 0, (), ""),
            ("FIELD", "UINT", 8, "len", 24, (), ""),
        ), "feapp.cpp"),
    }
    feapp_packet_rows = (
        ("MOS", "PTR UCHAR", 0, "pkt", 0, (), ""),
    )
    # ScreenTournSelect.obj reads two iterator members from the foreign
    # FEMenuDefs singleton without retaining its completed aggregate tag.
    # Pair-lock the exact 0x7a0-byte view and its source origin.  Pre-change
    # backup: Git commit 00adb5e4.
    screentournselect_views = {
        "ScreenTournSelect_GlobalMenuDefsCodegenView": (1952, (
            ("MOS", "ARY CHAR", 1704, "_beforeIteratorTournament", 0,
             (1704,), ""),
            ("MOS", "STRUCT", 20, "iteratorTournament", 1704, (),
             "tListIteratorTournament"),
            ("MOS", "ARY CHAR", 208, "_beforeIteratorSpecialEvent", 1724,
             (208,), ""),
            ("MOS", "STRUCT", 20, "iteratorSpecialEvent", 1932, (),
             "tListIteratorTournament"),
        ), "screentournselect_types.h"),
    }
    # ScreenController.obj uses three foreign singletons without retaining
    # their completed source tags.  These are accepted only as exact, complete
    # tag/typedef pairs from the owner header.  Pre-change backup: c27378c9.
    screencontroller_views = {
        "ScreenController_FEApplicationCodegenView": (558, (
            ("MOS", "ARY CHAR", 557, "_beforeInputPlayer", 0, (557,), ""),
            ("MOS", "CHAR", 0, "fInputPlayer", 557, (), ""),
        ), "screencontroller_types.h"),
        "ScreenController_PadCodegenView": (84, (
            ("MOS", "INT", 0, "initialized", 0, (), ""),
            ("MOS", "ARY STRUCT", 64, "buf", 4, (8,), "PAD_COMMON"),
            ("MOS", "ARY CHAR", 16, "stateBytes", 68, (16,), ""),
        ), "screencontroller_types.h"),
        "ScreenController_GlobalMenuDefsCodegenView": (12372, (
            ("MOS", "ARY CHAR", 11048, "_beforeItemControllerSettings", 0,
             (11048,), ""),
            ("MOS", "STRUCT", 68, "itemControllerSettings", 11048, (),
             "tMenuItemSlidingMenu"),
            ("MOS", "STRUCT", 128, "menuControllerConfig", 11116, (),
             "tOptionsMenu"),
            ("MOS", "ARY CHAR", 140, "_beforeItemControllerSteeringRange1",
             11244, (140,), ""),
            ("MOS", "STRUCT", 48, "itemControllerSteeringRange1", 11384,
             (), "tInsideBoxTwoWaySlider"),
            ("MOS", "ARY CHAR", 20, "_beforeItemControllerDeadSpot1",
             11432, (20,), ""),
            ("MOS", "STRUCT", 48, "itemControllerDeadSpot1", 11452, (),
             "tInsideBoxTwoWaySlider"),
            ("MOS", "ARY CHAR", 20, "_beforeItemControllerSteeringRange2",
             11500, (20,), ""),
            ("MOS", "STRUCT", 48, "itemControllerSteeringRange2", 11520,
             (), "tInsideBoxTwoWaySlider"),
            ("MOS", "ARY CHAR", 20, "_beforeItemControllerDeadSpot2",
             11568, (20,), ""),
            ("MOS", "STRUCT", 48, "itemControllerDeadSpot2", 11588, (),
             "tInsideBoxTwoWaySlider"),
            ("MOS", "ARY CHAR", 20, "_beforeItemControllerJoyRange", 11636,
             (20,), ""),
            ("MOS", "STRUCT", 48, "itemControllerJoyRange", 11656, (),
             "tInsideBoxTwoWaySlider"),
            ("MOS", "ARY CHAR", 20, "_beforeItemControllerCenterPoint",
             11704, (20,), ""),
            ("MOS", "STRUCT", 48, "itemControllerCenterPoint", 11724, (),
             "tInsideBoxTwoWaySlider"),
            ("MOS", "ARY CHAR", 136, "_beforeControllerMenus", 11772,
             (136,), ""),
            ("MOS", "STRUCT", 116, "menuControllerDualShock", 11908, (),
             "tInsideBoxMenu"),
            ("MOS", "STRUCT", 116, "menuControllerAnalog", 12024, (),
             "tInsideBoxMenu"),
            ("MOS", "STRUCT", 116, "menuControllerDualShockAnalog", 12140,
             (), "tInsideBoxMenu"),
            ("MOS", "STRUCT", 116, "menuControllerNegcon", 12256, (),
             "tInsideBoxMenu"),
        ), "screencontroller_types.h"),
    }
    # ScreenTrophyRoom.obj reads one foreign menu and the pad singleton without
    # retaining either completed source tag.  Pre-change backup: 1463fe30.
    screentrophyroom_views = {
        "ScreenTrophyRoom_GlobalMenuDefsCodegenView": (636, (
            ("MOS", "ARY CHAR", 512, "_beforeMenuTrophyInfo", 0,
             (512,), ""),
            ("MOS", "STRUCT", 124, "menuTrophyInfo", 512, (),
             "tMenuBlank"),
        ), "screentrophyroom_types.h"),
        "ScreenTrophyRoom_PadCodegenView": (84, (
            ("MOS", "INT", 0, "initialized", 0, (), ""),
            ("MOS", "ARY STRUCT", 64, "buf", 4, (8,), "PAD_COMMON"),
            ("MOS", "ARY CHAR", 16, "stateBytes", 68, (16,), ""),
        ), "screentrophyroom_types.h"),
    }
    # ScreenAudio.obj needs two foreign global layouts plus a contiguous slice
    # of FEMenuDefs for code generation, but its linked SYM retains none of the
    # three completed tags.  Pre-change backup: 4ea6b112.
    screenaudio_views = {
        "SndBnk_t": (12, (
            ("MOS", "INT", 0, "bnkID", 0, (), ""),
            ("MOS", "PTR CHAR", 0, "phdr", 4, (), ""),
            ("MOS", "PTR CHAR", 0, "pdata", 8, (), ""),
        ), "screenaudio_types.h"),
        "SPEECHINFO": (36, (
            ("MOS", "ARY CHAR", 4, "name", 0, (4,), ""),
            ("MOS", "INT", 0, "multiplay", 4, (), ""),
            ("MOS", "INT", 0, "nHandle", 8, (), ""),
            ("MOS", "INT", 0, "nSoundHandle", 12, (), ""),
            ("MOS", "CHAR", 0, "areLoading", 16, (), ""),
            ("MOS", "CHAR", 0, "soundIsPlaying", 17, (), ""),
            ("MOS", "CHAR", 0, "playNextOne", 18, (), ""),
            ("MOS", "PTR CHAR", 0, "pBankHeader", 20, (), ""),
            ("MOS", "PTR CHAR", 0, "sSpeechData", 24, (), ""),
            ("MOS", "PTR CHAR", 0, "lastSpeechData", 28, (), ""),
            ("MOS", "INT", 0, "vivHandle", 32, (), ""),
        ), "screenaudio_types.h"),
        "ScreenAudio_GlobalMenuDefsCodegenView": (10336, (
            ("MOS", "ARY CHAR", 9676, "_beforeItemMusicVolume", 0,
             (9676,), ""),
            ("MOS", "STRUCT", 56, "itemMusicVolume", 9676, (),
             "tMenuItemLeftRightAudioSlider"),
            ("MOS", "STRUCT", 56, "itemSoundEffectsVolume", 9732, (),
             "tMenuItemLeftRightAudioSlider"),
            ("MOS", "STRUCT", 56, "itemEngineVolume", 9788, (),
             "tMenuItemLeftRightAudioSlider"),
            ("MOS", "STRUCT", 56, "itemSpeechVolume", 9844, (),
             "tMenuItemLeftRightAudioSlider"),
            ("MOS", "STRUCT", 56, "itemAmbientVolume", 9900, (),
             "tMenuItemLeftRightAudioSlider"),
            ("MOS", "STRUCT", 44, "itemAudioMode", 9956, (),
             "tMenuItemDisplayLeftRightChoice"),
            ("MOS", "STRUCT", 72, "itemSlidingPlayList", 10000, (),
             "tMenuItemSlidingActivated"),
            ("MOS", "STRUCT", 136, "menuPlayListMenu", 10072, (),
             "tInsideBoxSongMenu"),
            ("MOS", "STRUCT", 128, "menuAudio", 10208, (),
             "tOptionsMenu"),
        ), "screenaudio_types.h"),
    }
    # ScreenPinkSlips.obj retains the member leaf types but not the complete
    # FEMenuDefs aggregate used to address them.  Pre-change backup: df189daa.
    screenpinkslips_views = {
        "ScreenPinkSlips_GlobalMenuDefsCodegenView": (3988, (
            ("MOS", "ARY CHAR", 3208, "_beforeIteratorTrack", 0,
             (3208,), ""),
            ("MOS", "STRUCT", 24, "iteratorTrack", 3208, (),
             "tListIteratorTrack"),
            ("MOS", "ARY CHAR", 684, "_beforeItemTraffic", 3232,
             (684,), ""),
            ("MOS", "STRUCT", 36, "itemTraffic", 3916, (),
             "tMenuItemOptionsTwoItemChoice"),
            ("MOS", "STRUCT", 36, "itemLocalSpeech", 3952, (),
             "tMenuItemOptionsTwoItemChoice"),
        ), "screenpinkslips_types.h"),
    }
    # ScreenTracks.obj uses the same menu slice plus a source-level PsyQ
    # primitive tag without retaining either completed tag.  Backup: edf2befc.
    screentracks_views = {
        "ScreenTracks_GlobalMenuDefsCodegenView": (3988, (
            ("MOS", "ARY CHAR", 3208, "_beforeIteratorTrack", 0,
             (3208,), ""),
            ("MOS", "STRUCT", 24, "iteratorTrack", 3208, (),
             "tListIteratorTrack"),
            ("MOS", "ARY CHAR", 684, "_beforeItemTraffic", 3232,
             (684,), ""),
            ("MOS", "STRUCT", 36, "itemTraffic", 3916, (),
             "tMenuItemOptionsTwoItemChoice"),
            ("MOS", "STRUCT", 36, "itemLocalSpeech", 3952, (),
             "tMenuItemOptionsTwoItemChoice"),
        ), "screentracks_types.h"),
        "tTrackSelectPrimTag": (4, (
            ("FIELD", "UINT", 24, "addr", 0, (), ""),
            ("FIELD", "UINT", 8, "len", 24, (), ""),
        ), "screentracks.cpp"),
    }
    # GCC's built-in C++ vtable entry is not available as a source type in the
    # reconstruction lane.  ScreenPost therefore needs this exact eight-byte
    # ABI carrier even though retail debug omits its completed private tag.
    # Pair-lock the complete tag and typedef so any field, type, size, or
    # ownership drift remains visible.  Pre-change backup: b49bf64f.
    screenpost_views = {
        "__nfs4_vtbl_ptr_t": (8, (
            ("MOS", "SHORT", 0, "delta", 0, (), ""),
            ("MOS", "SHORT", 0, "index", 2, (), ""),
            ("MOS", "PTR FCN INT", 0, "pfn", 4, (), ""),
        ), "fe_core_types.h"),
    }
    # FeMenuOptions dereferences one foreign audio object, one FEMenuDefs menu
    # slice, and uses a source-level PsyQ packet tag.  None of those completed
    # tags is retained by the linked owner.  Pair-lock each exact carrier.
    # Pre-change backup: 55686f9c.
    femenuoptions_views = {
        "FeMenuOptions_ScreenAudioCodegenView": (124, (
            ("MOS", "ARY CHAR", 116, "_beforeSelectedSong", 0,
             (116,), ""),
            ("MOS", "SHORT", 0, "fSelectedSong", 116, (), ""),
            ("MOS", "ARY CHAR", 2, "_beforeSongList", 118, (2,), ""),
            ("MOS", "PTR STRUCT", 8, "songlist", 120, (),
             "AudioMus_tSongList"),
        ), "femenuoptions_types.h"),
        "FeMenuOptions_GlobalMenuDefsCodegenView": (10208, (
            ("MOS", "ARY CHAR", 10072, "_beforeMenuPlayList", 0,
             (10072,), ""),
            ("MOS", "STRUCT", 136, "menuPlayListMenu", 10072, (),
             "tInsideBoxSongMenu"),
        ), "femenuoptions_types.h"),
        "tPsyQPrimTag": (4, (
            ("FIELD", "UINT", 24, "addr", 0, (), ""),
            ("FIELD", "UINT", 8, "len", 24, (), ""),
        ), "femenuoptions.cpp"),
    }
    # FEMenuDefs.obj owns the complete frontend menu graph but dereferences
    # four foreign singletons whose completed tags are not retained by that
    # owner.  Pair-lock the exact source-only member slices; any name, size,
    # field, offset, leaf tag, or source-owner drift remains an audit failure.
    # Pre-change backup: Git commit 7f5a66dd.
    femenudefs_views = {
        "FEMenuDefs_ScreenMainCodegenView": (1, (),
                                               "femenudefs_types.h"),
        "FEMenuDefs_ScreenTrophyRoomCodegenView": (344, (
            ("MOS", "ARY CHAR", 204, "_beforeThisIsUseless", 0,
             (204,), ""),
            ("MOS", "CHAR", 0, "thisisuseless", 204, (), ""),
            ("MOS", "ARY CHAR", 11, "_beforeTrophyList", 205,
             (11,), ""),
            ("MOS", "ARY SHORT", 128, "fTrophyList", 216,
             (64,), ""),
        ), "femenudefs_types.h"),
        "FEMenuDefs_PadCodegenView": (68, (
            ("MOS", "INT", 0, "initialized", 0, (), ""),
            ("MOS", "ARY STRUCT", 64, "buf", 4, (8,), "PAD_COMMON"),
        ), "femenudefs_types.h"),
        "FEMenuDefs_GameSetupCodegenView": (444, (
            ("MOS", "ARY CHAR", 428, "_beforeNumPerps", 0,
             (428,), ""),
            ("MOS", "INT", 0, "numPerps", 428, (), ""),
            ("MOS", "INT", 0, "stageOffset", 432, (), ""),
            ("MOS", "INT", 0, "perpArrests", 436, (), ""),
            ("MOS", "INT", 0, "finalPerpArrests", 440, (), ""),
        ), "femenudefs_types.h"),
    }
    # Front.obj must allocate/call four foreign class owners and address the
    # full game-setup object even though their completed tags are absent from
    # this linked owner. Accept these only as exact structure+typedef pairs in
    # the owner header. Pre-change backup: Git commit 80143f87.
    front_views = {
        "tFEApplication": (896, (
            ("MOS", "ARY CHAR", 896, "_storage", 0, (896,), ""),
        ), "front_types.h"),
        "tGlobalMenuDefs": (15128, (
            ("MOS", "ARY CHAR", 15128, "_storage", 0, (15128,), ""),
        ), "front_types.h"),
        "Front_MissionManagerCodegenView": (8, (
            ("MOS", "ARY CHAR", 8, "_storage", 0, (8,), ""),
        ), "front_types.h"),
        "Front_GameSetupCodegenView": (2600, (
            ("MOS", "ARY INT", 36, "_beforeReplayMode", 0, (9,), ""),
            ("MOS", "INT", 0, "replayMode", 36, (), ""),
            ("MOS", "ARY INT", 56, "_beforeControllerData", 40,
             (14,), ""),
            ("MOS", "STRUCT", 88, "controllerData", 96, (),
             "GameSetup_tControllerData"),
            ("MOS", "INT", 0, "pinkSlipsForfeit", 184, (), ""),
            ("MOS", "ARY CHAR", 2412, "_tail", 188, (2412,), ""),
        ), "front_types.h"),
        "tCreditManager": (56, (
            ("MOS", "ARY CHAR", 56, "_storage", 0, (56,), ""),
        ), "front_types.h"),
    }
    # ScreenDisplay.obj dereferences only the menuDisplayOptions member of the
    # foreign tGlobalMenuDefs singleton.  Its linked SYM retains the complete
    # tOptionsMenu leaf but attributes the owning aggregate to FEMenuDefs.obj.
    # CC1PL still needs the exact +0x2a68 member offset to reproduce the retail
    # load.  Suppress only this complete, owner-local tag/typedef pair; any
    # size, member, offset, leaf-tag, or source-file drift stays visible.
    # Pre-change backup: Git commit 604f472d.
    screendisplay_views = {
        "ScreenDisplay_GlobalMenuDefsCodegenView": (10984, (
            ("MOS", "ARY CHAR", 10856, "_beforeMenuDisplayOptions", 0,
             (10856,), ""),
            ("MOS", "STRUCT", 128, "menuDisplayOptions", 10856, (),
             "tOptionsMenu"),
        ), "screendisplay_types.h"),
    }
    # ScreenUserName's retail body contains the bytewise expansion of
    # strcpy(output, " "), but the reconstructed literal receives alignment
    # two and GCC 2.8 otherwise lowers it as lhu/sh.  This explicit alignment-
    # one, two-byte assignment carrier is source-only codegen evidence.  Keep
    # it invisible to the retail graph only as an exact tag/typedef pair from
    # this one TU; any spelling, size, member, or origin drift must reappear.
    # Pre-change backup: Git commit 1d20af1e.
    screenusername_views = {
        "ScreenUserName_Align1Copy2CodegenCarrier": (2, (
            ("MOS", "ARY CHAR", 2, "b", 0, (2,), ""),
        ), "screenusername.cpp"),
    }
    # ScreenMain dereferences FECredits' manager and three fields from
    # FEMenuDefs' aggregate.  Neither completed foreign tag is retained by
    # ScreenMain.obj, but their exact layouts are required for member-shaped
    # retail instructions.  Suppress only the complete owner-local pairs;
    # every member, offset, leaf tag, size, and origin remains priced.
    # Pre-change backup: Git commit a4a33894.
    screenmain_views = {
        "tCreditManager": (56, (
            ("MOS", "PTR STRUCT", 324, "CreditBuffer", 0, (), "tCredit"),
            ("MOS", "INT", 0, "fTVFade", 4, (), ""),
            ("MOS", "INT", 0, "fTextFade", 8, (), ""),
            ("MOS", "INT", 0, "fTextFadeDir", 12, (), ""),
            ("MOS", "BOOL", 0, "fCreditsInitialized", 16, (), ""),
            ("MOS", "BOOL", 0, "fRequestDeInit", 20, (), ""),
            ("MOS", "INT", 0, "fNumCredits", 24, (), ""),
            ("MOS", "INT", 0, "fShowCreditNum", 28, (), ""),
            ("MOS", "INT", 0, "fCurrCredit", 32, (), ""),
            ("MOS", "BOOL", 0, "StartedTransition", 36, (), ""),
            ("MOS", "BOOL", 0, "StartedLines", 40, (), ""),
            ("MOS", "BOOL", 0, "StartedTextFade", 44, (), ""),
            ("MOS", "INT", 0, "fLineTicks", 48, (), ""),
            ("MOS", "INT", 0, "fStartTicks", 52, (), ""),
        ), "screenmain_types.h"),
        "ScreenMain_GlobalMenuDefsCodegenView": (14956, (
            ("MOS", "ARY CHAR", 2292, "_beforeItemTwoPlayerPinkSlips", 0,
             (2292,), ""),
            ("MOS", "STRUCT", 44, "itemTwoPlayerPinkSlips", 2292, (),
             "tMenuItemGoToMenuNFS4Button"),
            ("MOS", "ARY CHAR", 256, "_beforeMenuPinkSlipSelect", 2336,
             (256,), ""),
            ("MOS", "STRUCT", 124, "menuPinkSlipSelect", 2592, (),
             "tMenuNFS4"),
            ("MOS", "ARY CHAR", 12116, "_beforeMenuCredits", 2716,
             (12116,), ""),
            ("MOS", "STRUCT", 124, "menuCredits", 14832, (),
             "tMenuBlank"),
        ), "screenmain_types.h"),
    }
    # FECredits dereferences the foreign ScreenMain singleton, so CC1PL must
    # see its complete field layout even though the linked SYM attributes that
    # completed tag to ScreenMain.obj.  Suppression below is pair-locked to the
    # exact 1,464-byte carrier and its owner header.  Pre-change backup: Git
    # commit 62fb562f.
    fecredits_views = {
        "tScreenMain": (1464, (
            ("MOS", "STRUCT", 100, "tScreen", 0, (), "tScreen"),
            ("MOS", "INT", 0, "hVideo", 100, (), ""),
            ("MOS", "INT", 0, "fFrame", 104, (), ""),
            ("MOS", "ULONG", 0, "fStartTicks", 108, (), ""),
            ("MOS", "ULONG", 0, "fAnimTicks", 112, (), ""),
            ("MOS", "SHORT", 0, "fAnimLocation", 116, (), ""),
            ("MOS", "ENUM", 4, "fState", 120, (), "tScreenMainState"),
            ("MOS", "ARY STRUCT", 768, "tvConfigs", 124, (16,), "tTVConfig"),
            ("MOS", "ARY ENUM", 64, "tvStates", 892, (16,), "tScreenMainState"),
            ("MOS", "ARY STRUCT", 384, "tvTransitions", 956, (16,), "tVideoTransition"),
            ("MOS", "BOOL", 0, "fTVsInitialized", 1340, (), ""),
            ("MOS", "CHAR", 0, "fTransitionDirection", 1344, (), ""),
            ("MOS", "BOOL", 0, "fAnimationUploaded", 1348, (), ""),
            ("MOS", "SHORT", 0, "fPreviousAnim", 1352, (), ""),
            ("MOS", "SHORT", 0, "fWarningFade", 1354, (), ""),
            ("MOS", "SHORT", 0, "fPreviousMovie", 1356, (), ""),
            ("MOS", "SHORT", 0, "fCurrentMovie", 1358, (), ""),
            ("MOS", "BOOL", 0, "bVideoAborted", 1360, (), ""),
            ("MOS", "ULONG", 0, "fMovieTicks", 1364, (), ""),
            ("MOS", "ARY STRUCT", 80, "fVideoShapes", 1368, (2,), "tShapeInformation"),
            ("MOS", "INT", 0, "fCurrentSlot", 1448, (), ""),
            ("MOS", "ARY INT", 8, "fCurrentBG", 1452, (2,), ""),
            ("MOS", "INT", 0, "fNumTVsInTransition", 1460, (), ""),
        ), "fecredits_types.h"),
    }
    # Canonical PsyQ 4.3 LIBGPU P_TAG carrier used by addPrim in FEMenu.  The
    # linked game SYM attributes/filters this SDK-owned anonymous type outside
    # FEMenu.obj, but CC1PL must complete it to expand the macro.  Suppression
    # below requires the exact anonymous block and typedef pair from the owner
    # header.  Pre-change backup: Git commit 3762862e.
    femenu_ptag_rows = (
        ("FIELD", "UINT", 24, "addr", 0, (), ""),
        ("FIELD", "UINT", 8, "len", 24, (), ""),
        ("MOS", "UCHAR", 0, "r0", 4, (), ""),
        ("MOS", "UCHAR", 0, "g0", 5, (), ""),
        ("MOS", "UCHAR", 0, "b0", 6, (), ""),
        ("MOS", "UCHAR", 0, "code", 7, (), ""),
    )
    draww_views = {
        "DrawW_SliceCodegenView": (32, (
            ("MOS", "ARY INT", 12, "center", 0, (3,), ""),
            ("MOS", "ARY CHAR", 3, "normal", 12, (3,), ""),
            ("MOS", "ARY CHAR", 3, "forward", 15, (3,), ""),
            ("MOS", "ARY CHAR", 3, "right", 18, (3,), ""),
            ("MOS", "UCHAR", 0, "acousticType", 21, (), ""),
            ("MOS", "SHORT", 0, "pavedProfile", 22, (), ""),
            ("MOS", "SHORT", 0, "leftDrive", 24, (), ""),
            ("MOS", "SHORT", 0, "rightDrive", 26, (), ""),
            ("MOS", "UCHAR", 0, "chunkIndex", 28, (), ""),
            ("MOS", "UCHAR", 0, "laneCount", 29, (), ""),
            ("MOS", "UCHAR", 0, "avgPavedWidthLf", 30, (), ""),
            ("MOS", "UCHAR", 0, "avgPavedWidthRt", 31, (), ""),
        ), "draww_externs.h"),
        "DrawW_CameraCodegenView": (272, hud_views["Hud_CameraCodegenView"][1],
                                      "draww_externs.h"),
        "DrawW_GameSetupCodegenView": (2600, hud_views["Hud_GameSetupCodegenView"][1],
                                         "draww_externs.h"),
        "DrawW_SimGlobalCodegenView": (24, hud_views["Hud_SimGlobalCodegenView"][1],
                                        "draww_externs.h"),
        "DrawW_TrackSpecCodegenView": (264, (
            ("MOS", "SHORT", 0, "fogstate", 0, (), ""),
            ("MOS", "SHORT", 0, "weatherstate", 2, (), ""),
            ("MOS", "SHORT", 0, "horizonstate", 4, (), ""),
            ("MOS", "SHORT", 0, "skystate", 6, (), ""),
            ("MOS", "SHORT", 0, "nightstate", 8, (), ""),
            ("MOS", "SHORT", 0, "depthcuestate", 10, (), ""),
            ("MOS", "SHORT", 0, "worldcolorstate", 12, (), ""),
            ("MOS", "SHORT", 0, "pad0", 14, (), ""),
            ("MOS", "STRUCT", 16, "fogspec", 16, (), "CFogSpec"),
            ("MOS", "STRUCT", 8, "weatherspec", 32, (), "CWeatherSpec"),
            ("MOS", "STRUCT", 48, "horizonspec", 40, (), "CHorizonSpec"),
            ("MOS", "STRUCT", 148, "skyspec", 88, (), "CSkySpec"),
            ("MOS", "STRUCT", 4, "nightspec", 236, (), "CNightSpec"),
            ("MOS", "STRUCT", 8, "depthcuespec", 240, (), "CDepthCueSpec"),
            ("MOS", "STRUCT", 16, "worldcolorspec", 248, (), "CWorldColor"),
        ), "draww_externs.h"),
        "DrawW_Pack8CodegenView": (8, (
            ("MOS", "ARY CHAR", 8, "b", 0, (8,), ""),
        ), "draww.cpp"),
    }

    def exact_night_camera(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        return (
            block.kind == "STRTAG"
            and block.name == "Night_CameraCodegenView"
            and block.size == 272
            and block.rows == expected_rows
            and owner.endswith("night_externs.h")
        )

    def exact_night_camera_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        return (
            item.cls == "TPDEF"
            and item.name == "Night_CameraCodegenView"
            and item.typ == "STRUCT"
            and item.size == 272
            and item.tag == "Night_CameraCodegenView"
            and owner.endswith("night_externs.h")
        )

    def exact_hud_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = hud_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith("hud_externs.h")
        )

    def exact_hud_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = hud_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            and owner.endswith("hud_externs.h")
        )

    def exact_drawc_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = drawc_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith("drawc_externs.h")
        )

    def exact_drawc_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = drawc_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            and owner.endswith("drawc_externs.h")
        )

    def exact_bworldsm_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = bworldsm_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith("bworldsm_externs.h")
        )

    def exact_bworldsm_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = bworldsm_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            and owner.endswith("bworldsm_externs.h")
        )

    def exact_untyped_library_codegen_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        basename = owner.rsplit("/", 1)[-1]
        expected = untyped_library_codegen_views.get((basename, block.name))
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
        )

    def exact_untyped_library_anonymous_pair(
        block: TypeBlock, item: Definition
    ) -> bool:
        block_owner = block.owner.replace("\\", "/").casefold()
        item_owner = item.owner.replace("\\", "/").casefold()
        basename = item_owner.rsplit("/", 1)[-1]
        expected = untyped_library_anonymous_views.get((basename, item.name))
        return (
            expected is not None
            and block_owner == item_owner
            and block.kind == "STRTAG"
            and is_anonymous_tag(block.name)
            and block.name == item.tag
            and block.size == expected[0]
            and block.rows == expected[1]
            and item.cls == "TPDEF"
            and item.typ == "STRUCT"
            and item.size == expected[0]
        )

    def exact_untyped_library_named_pair(
        block: TypeBlock, item: Definition
    ) -> bool:
        block_owner = block.owner.replace("\\", "/").casefold()
        item_owner = item.owner.replace("\\", "/").casefold()
        basename = item_owner.rsplit("/", 1)[-1]
        expected = untyped_library_named_pair_views.get((basename, item.name))
        return (
            expected is not None
            and block_owner == item_owner
            and block.kind == "STRTAG"
            and block.name == item.name
            and item.tag == block.name
            and block.size == expected[0]
            and block.rows == expected[1]
            and item.cls == "TPDEF"
            and item.typ == "STRUCT"
            and item.size == expected[0]
        )

    def exact_untyped_library_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        basename = owner.rsplit("/", 1)[-1]
        expected = untyped_library_exact_typedefs.get((basename, item.name))
        return (
            item.cls == "TPDEF"
            and expected is not None
            and (item.typ, item.size, item.tag) == expected
        )

    def exact_feinput_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = feinput_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith("feinput_externs.h")
        )

    def exact_feinput_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = feinput_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            and owner.endswith("feinput_externs.h")
        )

    def exact_fescreen_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = fescreen_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith("fescreen_externs.h")
        )

    def exact_fescreen_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = fescreen_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            # Macro aliases make CC1PL repeat the already pair-locked typedef
            # at local declaration sites in fescreen.cpp.  Accept only those
            # exact same-name/size/tag repeats from this one consumer TU.
            and owner.endswith(("fescreen_externs.h", "fescreen.cpp"))
        )

    def exact_fecars_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = fecars_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith("fe_core_types.h")
        )

    def exact_fecars_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = fecars_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            and owner.endswith("fe_core_types.h")
        )

    def exact_fetourn_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = fetourn_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith(expected[2])
        )

    def exact_fetourn_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = fetourn_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            and owner.endswith(expected[2])
        )

    def exact_draww_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = draww_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith(expected[2])
        )

    def exact_draww_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = draww_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            and owner.endswith(expected[2])
        )

    def exact_fecredits_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = fecredits_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith(expected[2])
        )

    def exact_fecredits_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = fecredits_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            # The local typed-pointer declarations repeat this already
            # pair-locked typedef in fecredits.cpp; the completed tag remains
            # restricted to the owner header above.
            and owner.endswith((expected[2], "fecredits.cpp"))
        )

    def exact_fecheats_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = fecheats_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith(expected[2])
        )

    def exact_fecheats_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = fecheats_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            # The local FEApp pointer view repeats this already pair-locked
            # typedef in fecheats.cpp; the completed tag remains restricted to
            # the owner header above.
            and owner.endswith((expected[2], "fecheats.cpp", "fememcard.cpp"))
        )

    def exact_fememcard_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = fememcard_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith(expected[2])
        )

    def exact_fememcard_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = fememcard_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            # Macro aliases repeat these already pair-locked typedefs at local
            # declarations; completed tags remain restricted to the header.
            and owner.endswith((expected[2], "fememcard.cpp"))
        )

    def exact_screenmemcard_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = screenmemcard_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith(expected[2])
        )

    def exact_screenmemcard_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = screenmemcard_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            and owner.endswith((expected[2], "screenmemcard.cpp"))
        )

    def exact_fedialog_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = fedialog_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith(expected[2])
        )

    def exact_fedialog_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = fedialog_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            and owner.endswith((expected[2], "fedialog.cpp"))
        )

    def exact_screencarselect_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = screencarselect_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith(expected[2])
        )

    def exact_screencarselect_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = screencarselect_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            and owner.endswith(expected[2])
        )

    def exact_screencarselect_union(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        return (
            block.kind == "UNTAG"
            and normalize_tag(block.name) == "<anonymous>"
            and block.size == 204
            and block.rows == screencarselect_union_rows
            and owner.endswith("screencarselect.cpp")
        )

    def exact_feapp_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = feapp_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith(expected[2])
        )

    def exact_feapp_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = feapp_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            and owner.endswith((expected[2], "feapp.cpp"))
        )

    def exact_feapp_packet(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        return (
            block.kind == "STRTAG"
            and normalize_tag(block.name) == "<anonymous>"
            and block.size == 4
            and block.rows == feapp_packet_rows
            and owner.endswith("feapp.cpp")
        )

    def exact_feapp_packet_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        return (
            item.cls == "TPDEF"
            and item.name == "tPacketCellView"
            and item.typ == "STRUCT"
            and item.size == 4
            and normalize_tag(item.tag) == "<anonymous>"
            and owner.endswith("feapp.cpp")
        )

    def exact_screentournselect_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = screentournselect_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith(expected[2])
        )

    def exact_screentournselect_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = screentournselect_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            and owner.endswith((expected[2], "screentournselect.cpp"))
        )

    def exact_screencontroller_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = screencontroller_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith(expected[2])
        )

    def exact_screencontroller_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = screencontroller_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            and owner.endswith((expected[2], "screencontroller.cpp",
                                "femenuoptions.cpp"))
        )

    def exact_screentrophyroom_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = screentrophyroom_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith(expected[2])
        )

    def exact_screentrophyroom_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = screentrophyroom_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            and owner.endswith((expected[2], "screentrophyroom.cpp"))
        )

    def exact_screenaudio_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = screenaudio_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith(expected[2])
        )

    def exact_screenaudio_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = screenaudio_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            and owner.endswith((expected[2], "screenaudio.cpp"))
        )

    def exact_screenpinkslips_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = screenpinkslips_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith(expected[2])
        )

    def exact_screenpinkslips_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = screenpinkslips_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            and owner.endswith((expected[2], "screenpinkslips.cpp"))
        )

    def exact_screentracks_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = screentracks_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith(expected[2])
        )

    def exact_screentracks_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = screentracks_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            and owner.endswith((expected[2], "screentracks.cpp"))
        )

    def exact_screenpost_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = screenpost_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith(expected[2])
        )

    def exact_screenpost_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = screenpost_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            and owner.endswith(expected[2])
        )

    def exact_femenuoptions_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = femenuoptions_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith(expected[2])
        )

    def exact_femenuoptions_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = femenuoptions_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            and owner.endswith(expected[2])
        )

    def exact_femenudefs_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = femenudefs_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith(expected[2])
        )

    def exact_femenudefs_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = femenudefs_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            and owner.endswith(expected[2])
        )

    def exact_front_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = front_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith(expected[2])
        )

    def exact_front_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = front_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            and owner.endswith(expected[2])
        )

    def exact_screendisplay_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = screendisplay_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith(expected[2])
        )

    def exact_screendisplay_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = screendisplay_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            # The local typed-pointer declaration repeats the pair-locked
            # typedef; the completed tag remains restricted to the header.
            and owner.endswith((expected[2], "screendisplay.cpp"))
        )

    def exact_screenusername_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = screenusername_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith(expected[2])
        )

    def exact_screenusername_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = screenusername_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            and owner.endswith(expected[2])
        )

    def exact_screenmain_view(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        expected = screenmain_views.get(block.name)
        return (
            block.kind == "STRTAG"
            and expected is not None
            and block.size == expected[0]
            and block.rows == expected[1]
            and owner.endswith(expected[2])
        )

    def exact_screenmain_view_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        expected = screenmain_views.get(item.name)
        return (
            item.cls == "TPDEF"
            and expected is not None
            and item.typ == "STRUCT"
            and item.size == expected[0]
            and item.tag == item.name
            # Macro aliases can repeat the view typedef at the consumer's
            # local declarations; the completed tags stay header-owned.
            and owner.endswith((expected[2], "screenmain.cpp"))
        )

    def exact_femenu_ptag(block: TypeBlock) -> bool:
        owner = block.owner.replace("\\", "/").casefold()
        return (
            block.kind == "STRTAG"
            and normalize_tag(block.name) == "<anonymous>"
            and block.size == 8
            and block.rows == femenu_ptag_rows
            and owner.endswith("femenu_types.h")
        )

    def exact_femenu_ptag_typedef(item: Definition) -> bool:
        owner = item.owner.replace("\\", "/").casefold()
        return (
            item.cls == "TPDEF"
            and item.name == "P_TAG"
            and item.typ == "STRUCT"
            and item.size == 8
            and normalize_tag(item.tag) == "<anonymous>"
            and owner.endswith("femenu_types.h")
        )

    # Suppression is pair-locked: a matching struct without its typedef (or a
    # matching typedef without its struct) is evidence drift, not an eligible
    # codegen carrier.  Keep both rows visible unless the complete pair agrees.
    night_eligible = (
        any(exact_night_camera(block) for block in type_blocks)
        and any(exact_night_camera_typedef(item) for item in typedefs)
    )
    hud_eligible = {
        name for name in hud_views
        if any(exact_hud_view(block) and block.name == name for block in type_blocks)
        and any(exact_hud_view_typedef(item) and item.name == name for item in typedefs)
    }
    drawc_eligible = {
        name for name in drawc_views
        if any(exact_drawc_view(block) and block.name == name for block in type_blocks)
        and any(exact_drawc_view_typedef(item) and item.name == name for item in typedefs)
    }
    feinput_eligible = {
        name for name in feinput_views
        if any(exact_feinput_view(block) and block.name == name for block in type_blocks)
        and any(exact_feinput_view_typedef(item) and item.name == name for item in typedefs)
    }
    fescreen_eligible = {
        name for name in fescreen_views
        if any(exact_fescreen_view(block) and block.name == name for block in type_blocks)
        and any(exact_fescreen_view_typedef(item) and item.name == name for item in typedefs)
    }
    fecars_eligible = {
        name for name in fecars_views
        if any(exact_fecars_view(block) and block.name == name for block in type_blocks)
        and any(exact_fecars_view_typedef(item) and item.name == name for item in typedefs)
    }
    fetourn_eligible = {
        name for name in fetourn_views
        if any(exact_fetourn_view(block) and block.name == name for block in type_blocks)
        and any(exact_fetourn_view_typedef(item) and item.name == name for item in typedefs)
    }
    draww_eligible = {
        name for name in draww_views
        if any(exact_draww_view(block) and block.name == name for block in type_blocks)
        and any(exact_draww_view_typedef(item) and item.name == name for item in typedefs)
    }
    fecredits_eligible = {
        name for name in fecredits_views
        if any(exact_fecredits_view(block) and block.name == name for block in type_blocks)
        and any(exact_fecredits_view_typedef(item) and item.name == name for item in typedefs)
    }
    fecheats_eligible = {
        name for name in fecheats_views
        if any(exact_fecheats_view(block) and block.name == name for block in type_blocks)
        and any(exact_fecheats_view_typedef(item) and item.name == name for item in typedefs)
    }
    screendisplay_eligible = {
        name for name in screendisplay_views
        if any(exact_screendisplay_view(block) and block.name == name
               for block in type_blocks)
        and any(exact_screendisplay_view_typedef(item) and item.name == name
                for item in typedefs)
    }
    bworldsm_eligible = {
        name for name in bworldsm_views
        if any(exact_bworldsm_view(block) and block.name == name
               for block in type_blocks)
        and any(exact_bworldsm_view_typedef(item) and item.name == name
                for item in typedefs)
    }
    fememcard_eligible = {
        name for name in fememcard_views
        if any(exact_fememcard_view(block) and block.name == name
               for block in type_blocks)
        and any(exact_fememcard_view_typedef(item) and item.name == name
                for item in typedefs)
    }
    screenmemcard_eligible = {
        name for name in screenmemcard_views
        if any(exact_screenmemcard_view(block) and block.name == name
               for block in type_blocks)
        and any(exact_screenmemcard_view_typedef(item) and item.name == name
                for item in typedefs)
    }
    fedialog_eligible = {
        name for name in fedialog_views
        if any(exact_fedialog_view(block) and block.name == name
               for block in type_blocks)
        and any(exact_fedialog_view_typedef(item) and item.name == name
                for item in typedefs)
    }
    screencarselect_eligible = {
        name for name in screencarselect_views
        if any(exact_screencarselect_view(block) and block.name == name
               for block in type_blocks)
        and any(exact_screencarselect_view_typedef(item) and item.name == name
                for item in typedefs)
    }
    feapp_eligible = {
        name for name in feapp_views
        if any(exact_feapp_view(block) and block.name == name
               for block in type_blocks)
        and any(exact_feapp_view_typedef(item) and item.name == name
                for item in typedefs)
    }
    feapp_packet_eligible = any(
        exact_feapp_packet(block)
        and exact_feapp_packet_typedef(item)
        and normalize_tag(block.name) == normalize_tag(item.tag)
        for block in type_blocks
        for item in typedefs
    )
    screentournselect_eligible = {
        name for name in screentournselect_views
        if any(exact_screentournselect_view(block) and block.name == name
               for block in type_blocks)
        and any(exact_screentournselect_view_typedef(item) and item.name == name
                for item in typedefs)
    }
    screencontroller_eligible = {
        name for name in screencontroller_views
        if any(exact_screencontroller_view(block) and block.name == name
               for block in type_blocks)
        and any(exact_screencontroller_view_typedef(item) and item.name == name
                for item in typedefs)
    }
    screentrophyroom_eligible = {
        name for name in screentrophyroom_views
        if any(exact_screentrophyroom_view(block) and block.name == name
               for block in type_blocks)
        and any(exact_screentrophyroom_view_typedef(item) and item.name == name
                for item in typedefs)
    }
    screenaudio_eligible = {
        name for name in screenaudio_views
        if any(exact_screenaudio_view(block) and block.name == name
               for block in type_blocks)
        and any(exact_screenaudio_view_typedef(item) and item.name == name
                for item in typedefs)
    }
    screenpinkslips_eligible = {
        name for name in screenpinkslips_views
        if any(exact_screenpinkslips_view(block) and block.name == name
               for block in type_blocks)
        and any(exact_screenpinkslips_view_typedef(item) and item.name == name
                for item in typedefs)
    }
    screentracks_eligible = {
        name for name in screentracks_views
        if any(exact_screentracks_view(block) and block.name == name
               for block in type_blocks)
        and any(exact_screentracks_view_typedef(item) and item.name == name
                for item in typedefs)
    }
    screenpost_eligible = {
        name for name in screenpost_views
        if any(exact_screenpost_view(block) and block.name == name
               for block in type_blocks)
        and any(exact_screenpost_view_typedef(item) and item.name == name
                for item in typedefs)
    }
    femenuoptions_eligible = {
        name for name in femenuoptions_views
        if any(exact_femenuoptions_view(block) and block.name == name
               for block in type_blocks)
        and any(exact_femenuoptions_view_typedef(item) and item.name == name
                for item in typedefs)
    }
    femenudefs_eligible = {
        name for name in femenudefs_views
        if any(exact_femenudefs_view(block) and block.name == name
               for block in type_blocks)
        and any(exact_femenudefs_view_typedef(item) and item.name == name
                for item in typedefs)
    }
    front_eligible = {
        name for name in front_views
        if any(exact_front_view(block) and block.name == name
               for block in type_blocks)
        and any(exact_front_view_typedef(item) and item.name == name
                for item in typedefs)
    }
    screenusername_eligible = {
        name for name in screenusername_views
        if any(exact_screenusername_view(block) and block.name == name
               for block in type_blocks)
        and any(exact_screenusername_view_typedef(item) and item.name == name
                for item in typedefs)
    }
    screenmain_eligible = {
        name for name in screenmain_views
        if any(exact_screenmain_view(block) and block.name == name
               for block in type_blocks)
        and any(exact_screenmain_view_typedef(item) and item.name == name
                for item in typedefs)
    }
    femenu_ptag_eligible = any(
        exact_femenu_ptag(block)
        and exact_femenu_ptag_typedef(item)
        and block.name == item.tag
        for block in type_blocks
        for item in typedefs
    )
    untyped_library_anonymous_eligible = {
        (block.owner.replace("\\", "/").casefold(), block.name)
        for block in type_blocks
        for item in typedefs
        if exact_untyped_library_anonymous_pair(block, item)
    }
    untyped_library_named_pair_eligible = {
        (block.owner.replace("\\", "/").casefold(), block.name)
        for block in type_blocks
        for item in typedefs
        if exact_untyped_library_named_pair(block, item)
    }

    return (
        [
            block for block in type_blocks
            if not font_vendor_eligible
            and not exact_stripped_vendor_owner(block.owner)
            and not (night_eligible and exact_night_camera(block))
            and not (block.name in hud_eligible and exact_hud_view(block))
            and not (block.name in drawc_eligible and exact_drawc_view(block))
            and not (block.name in bworldsm_eligible
                     and exact_bworldsm_view(block))
            and not exact_untyped_library_codegen_view(block)
            and not (
                (block.owner.replace("\\", "/").casefold(), block.name)
                in untyped_library_anonymous_eligible
            )
            and not (
                (block.owner.replace("\\", "/").casefold(), block.name)
                in untyped_library_named_pair_eligible
            )
            and not (block.name in feinput_eligible and exact_feinput_view(block))
            and not (block.name in fescreen_eligible and exact_fescreen_view(block))
            and not (block.name in fecars_eligible and exact_fecars_view(block))
            and not (block.name in fetourn_eligible and exact_fetourn_view(block))
            and not (block.name in draww_eligible and exact_draww_view(block))
            and not (block.name in fecredits_eligible and exact_fecredits_view(block))
            and not (block.name in fecheats_eligible and exact_fecheats_view(block))
            and not (block.name in fememcard_eligible
                     and exact_fememcard_view(block))
            and not (block.name in screenmemcard_eligible
                     and exact_screenmemcard_view(block))
            and not (block.name in fedialog_eligible
                     and exact_fedialog_view(block))
            and not (block.name in screencarselect_eligible
                     and exact_screencarselect_view(block))
            and not exact_screencarselect_union(block)
            and not (block.name in feapp_eligible and exact_feapp_view(block))
            and not (feapp_packet_eligible and exact_feapp_packet(block))
            and not (block.name in screentournselect_eligible
                     and exact_screentournselect_view(block))
            and not (block.name in screencontroller_eligible
                     and exact_screencontroller_view(block))
            and not (block.name in screentrophyroom_eligible
                     and exact_screentrophyroom_view(block))
            and not (block.name in screenaudio_eligible
                     and exact_screenaudio_view(block))
            and not (block.name in screenpinkslips_eligible
                     and exact_screenpinkslips_view(block))
            and not (block.name in screentracks_eligible
                     and exact_screentracks_view(block))
            and not (block.name in screenpost_eligible
                     and exact_screenpost_view(block))
            and not (block.name in femenuoptions_eligible
                     and exact_femenuoptions_view(block))
            and not (block.name in femenudefs_eligible
                     and exact_femenudefs_view(block))
            and not (block.name in front_eligible
                     and exact_front_view(block))
            and not (block.name in screendisplay_eligible
                     and exact_screendisplay_view(block))
            and not (block.name in screenusername_eligible
                     and exact_screenusername_view(block))
            and not (block.name in screenmain_eligible
                     and exact_screenmain_view(block))
            and not (femenu_ptag_eligible and exact_femenu_ptag(block))
        ],
        [
            item for item in typedefs
            if not font_vendor_eligible
            and not exact_stripped_vendor_owner(item.owner)
            and not (night_eligible and exact_night_camera_typedef(item))
            and not (item.name in hud_eligible and exact_hud_view_typedef(item))
            and not (item.name in drawc_eligible and exact_drawc_view_typedef(item))
            and not (item.name in bworldsm_eligible
                     and exact_bworldsm_view_typedef(item))
            and not (item.name in feinput_eligible and exact_feinput_view_typedef(item))
            and not (item.name in fescreen_eligible and exact_fescreen_view_typedef(item))
            and not (item.name in fecars_eligible and exact_fecars_view_typedef(item))
            and not (item.name in fetourn_eligible and exact_fetourn_view_typedef(item))
            and not (item.name in draww_eligible and exact_draww_view_typedef(item))
            and not (item.name in fecredits_eligible and exact_fecredits_view_typedef(item))
            and not (item.name in fecheats_eligible and exact_fecheats_view_typedef(item))
            and not (item.name in fememcard_eligible
                     and exact_fememcard_view_typedef(item))
            and not (item.name in screenmemcard_eligible
                     and exact_screenmemcard_view_typedef(item))
            and not (item.name in fedialog_eligible
                     and exact_fedialog_view_typedef(item))
            and not (item.name in screencarselect_eligible
                     and exact_screencarselect_view_typedef(item))
            and not (item.name in feapp_eligible
                     and exact_feapp_view_typedef(item))
            and not (feapp_packet_eligible
                     and exact_feapp_packet_typedef(item))
            and not (item.name in screentournselect_eligible
                     and exact_screentournselect_view_typedef(item))
            and not (item.name in screencontroller_eligible
                     and exact_screencontroller_view_typedef(item))
            and not (item.name in screentrophyroom_eligible
                     and exact_screentrophyroom_view_typedef(item))
            and not (item.name in screenaudio_eligible
                     and exact_screenaudio_view_typedef(item))
            and not (item.name in screenpinkslips_eligible
                     and exact_screenpinkslips_view_typedef(item))
            and not (item.name in screentracks_eligible
                     and exact_screentracks_view_typedef(item))
            and not (item.name in screenpost_eligible
                     and exact_screenpost_view_typedef(item))
            and not (item.name in femenuoptions_eligible
                     and exact_femenuoptions_view_typedef(item))
            and not (item.name in femenudefs_eligible
                     and exact_femenudefs_view_typedef(item))
            and not (item.name in front_eligible
                     and exact_front_view_typedef(item))
            and not (item.name in screendisplay_eligible
                     and exact_screendisplay_view_typedef(item))
            and not (item.name in screenusername_eligible
                     and exact_screenusername_view_typedef(item))
            and not (item.name in screenmain_eligible
                     and exact_screenmain_view_typedef(item))
            and not (femenu_ptag_eligible and exact_femenu_ptag_typedef(item))
            and not (
                (item.owner.replace("\\", "/").casefold(), item.tag)
                in untyped_library_anonymous_eligible
            )
            and not (
                (item.owner.replace("\\", "/").casefold(), item.tag)
                in untyped_library_named_pair_eligible
            )
            and not exact_untyped_library_typedef(item)
        ],
    )


def variants(items, key):
    result = defaultdict(lambda: defaultdict(list))
    for item in items:
        result[key(item)][item.semantic()].append(item.owner)
    return result


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("source_asm", type=Path, nargs="+", help="CC1/CC1PL -g assembly")
    parser.add_argument("--output", type=Path)
    parser.add_argument(
        "--retail-owner", action="append", default=[],
        help="limit retail definitions to an exact object owner (repeatable)",
    )
    args = parser.parse_args()

    retail_defs = parse_retail(RETAIL_LEDGER)
    if args.retail_owner:
        requested_owners = {owner.casefold() for owner in args.retail_owner}
        retail_defs = [
            item for item in retail_defs
            if item.owner.casefold() in requested_owners
        ]
    source_defs = []
    for path in args.source_asm:
        source_defs.extend(parse_asm(path))
    retail_blocks, retail_typedefs, retail_issues = blocks(retail_defs)
    source_blocks, source_typedefs, source_issues = blocks(source_defs)
    source_blocks, source_typedefs = filter_sdk_macro_carriers(
        source_blocks, source_typedefs
    )
    source_blocks, source_typedefs = filter_stripped_libmath_carriers(
        source_blocks, source_typedefs
    )
    source_blocks, source_typedefs = filter_exact_symbol_codegen_carriers(
        source_blocks, source_typedefs
    )

    # Anonymous compiler tags are numbered by emission order.  Their enum or
    # typedef identity is recovered through the surrounding typedef records in
    # a later pass; named tags can be compared directly and safely now.
    named_retail = [item for item in retail_blocks if not is_anonymous_tag(item.name)]
    named_source = [item for item in source_blocks if not is_anonymous_tag(item.name)]
    retail_by_name = variants(
        named_retail, lambda item: (item.kind, normalize_tag(item.name))
    )
    source_by_name = variants(
        named_source, lambda item: (item.kind, normalize_tag(item.name))
    )

    exact = 0
    missing = []
    mismatch = []
    for name, retail_variants in sorted(retail_by_name.items()):
        source_variants = source_by_name.get(name)
        if not source_variants:
            missing.append((name, retail_variants))
            continue
        if set(retail_variants) == set(source_variants):
            exact += 1
        else:
            mismatch.append((name, retail_variants, source_variants))
    extra = sorted(set(source_by_name) - set(retail_by_name))

    retail_conflicts = {name: vals for name, vals in retail_by_name.items() if len(vals) > 1}
    source_conflicts = {name: vals for name, vals in source_by_name.items() if len(vals) > 1}
    enum_member_fixes = set()
    for name, retail_variants, source_variants in mismatch:
        retail_members = [
            member
            for semantic in retail_variants
            for member in semantic[3]
        ]
        source_members = [
            member
            for semantic in source_variants
            for member in semantic[3]
        ]
        for source_member in source_members:
            for retail_member in retail_members:
                same_slot = (
                    source_member[3] == retail_member[3]
                    and source_member[4] == retail_member[4]
                    and source_member[5] == retail_member[5]
                )
                enum_pair = (
                    (source_member[1], retail_member[1])
                    in {("INT", "ENUM"), ("ARY INT", "ARY ENUM")}
                )
                if same_slot and enum_pair:
                    enum_member_fixes.add(
                        (name[1], source_member[3], source_member[1],
                         retail_member[1], retail_member[6])
                    )
    lines = [
        "# PSYQ full-debug canonical type comparison",
        "",
        f"- Retail owner filter: {', '.join(args.retail_owner) if args.retail_owner else '<all objects>'}",
        f"- Retail canonical definition rows: {len(retail_defs)}",
        f"- Source full-debug definition rows: {len(source_defs)}",
        f"- Retail type blocks: {len(retail_blocks)} ({len(named_retail)} named)",
        f"- Source type blocks: {len(source_blocks)} ({len(named_source)} named)",
        f"- Retail typedef rows: {len(retail_typedefs)}",
        f"- Source typedef rows: {len(source_typedefs)}",
        f"- Named type keys exact: {exact}",
        f"- Named type keys missing from source emission: {len(missing)}",
        f"- Named type keys with layout/member mismatch: {len(mismatch)}",
        f"- Named type keys extra in source emission: {len(extra)}",
        f"- Retail named keys with TU-specific variants: {len(retail_conflicts)}",
        f"- Source named keys with TU-specific variants: {len(source_conflicts)}",
        f"- Retail/source structural parse issues: {len(retail_issues)}/{len(source_issues)}",
        f"- Direct enum-member correction candidates: {len(enum_member_fixes)}",
        "",
        "## Direct enum-member correction candidates",
        "",
        *[
            f"- `{owner}.{member}`: source `{source_type}` -> retail `{retail_type}`"
            f" tag `{tag}`"
            for owner, member, source_type, retail_type, tag
            in sorted(enum_member_fixes)
        ],
        "",
        "## Layout/member mismatches",
        "",
    ]
    for name, retail_variants, source_variants in mismatch:
        lines.append(f"- `{name[0]} {name[1]}`: retail variants={len(retail_variants)}, source variants={len(source_variants)}")
        for semantic, owners in retail_variants.items():
            lines.append(f"  - retail {semantic!r}; owners={len(owners)} ({', '.join(sorted(set(owners))[:5])})")
        for semantic, owners in source_variants.items():
            lines.append(f"  - source {semantic!r}; owners={len(owners)} ({', '.join(sorted(set(owners))[:5])})")
    lines.extend(["", "## Missing named source types", ""])
    for name, vals in missing:
        lines.append(f"- `{name[0]} {name[1]}`: {len(vals)} retail variant(s)")
    lines.extend(["", "## Extra named source types", ""])
    for name in extra:
        lines.append(f"- `{name[0]} {name[1]}`")
    if retail_issues or source_issues:
        lines.extend(["", "## Structural parse issues", ""])
        lines.extend(f"- retail: {x}" for x in retail_issues)
        lines.extend(f"- source: {x}" for x in source_issues)

    report = "\n".join(lines) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(report, encoding="utf-8")
    print(report, end="")


if __name__ == "__main__":
    main()
