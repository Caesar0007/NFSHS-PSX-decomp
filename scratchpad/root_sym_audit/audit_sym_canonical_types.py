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
    if name.startswith("._"):
        return "<anonymous>"
    return name


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


def filter_sdk_macro_carriers(
    type_blocks: list[TypeBlock], typedefs: list[Definition]
) -> tuple[list[TypeBlock], list[Definition]]:
    """Remove exact SDK-only debug carriers that retail game objects filter.

    PsyQ's canonical LIBGPU.H implements setaddr/getaddr/addPrim through P_TAG.
    Full-debug CC1PLUS emits its anonymous body and typedef when the macros are
    reconstructed in an owner header, whereas the retail game-object SYM keeps
    the concrete primitive-variable types but filters this cast-only SDK type.
    The guard deliberately checks the header owner, complete 8-byte layout and
    typedef/tag link; a source-defined P_TAG or any layout drift remains visible.
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
            and item.tag.startswith("._")
            and _is_prim_macro_header(item.owner)
        )

    def exact_block(block: TypeBlock) -> bool:
        return (
            block.kind == "STRTAG"
            and block.size == 8
            and block.rows == expected_rows
            and _is_prim_macro_header(block.owner)
        )

    eligible_tags = {item.tag for item in typedefs if exact_typedef(item)}
    removable_tags = {
        block.name for block in type_blocks
        if block.name in eligible_tags and exact_block(block)
    }
    return (
        [
            block for block in type_blocks
            if not (
                block.name in removable_tags
                and exact_block(block)
            )
        ],
        [
            item for item in typedefs
            if not (
                item.tag in removable_tags
                and exact_typedef(item)
            )
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
    draww_eligible = {
        name for name in draww_views
        if any(exact_draww_view(block) and block.name == name for block in type_blocks)
        and any(exact_draww_view_typedef(item) and item.name == name for item in typedefs)
    }

    return (
        [
            block for block in type_blocks
            if not (night_eligible and exact_night_camera(block))
            and not (block.name in hud_eligible and exact_hud_view(block))
            and not (block.name in drawc_eligible and exact_drawc_view(block))
            and not (block.name in feinput_eligible and exact_feinput_view(block))
            and not (block.name in fescreen_eligible and exact_fescreen_view(block))
            and not (block.name in fecars_eligible and exact_fecars_view(block))
            and not (block.name in draww_eligible and exact_draww_view(block))
        ],
        [
            item for item in typedefs
            if not (night_eligible and exact_night_camera_typedef(item))
            and not (item.name in hud_eligible and exact_hud_view_typedef(item))
            and not (item.name in drawc_eligible and exact_drawc_view_typedef(item))
            and not (item.name in feinput_eligible and exact_feinput_view_typedef(item))
            and not (item.name in fescreen_eligible and exact_fescreen_view_typedef(item))
            and not (item.name in fecars_eligible and exact_fecars_view_typedef(item))
            and not (item.name in draww_eligible and exact_draww_view_typedef(item))
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
    source_blocks, source_typedefs = filter_exact_symbol_codegen_carriers(
        source_blocks, source_typedefs
    )

    # Anonymous compiler tags are numbered by emission order.  Their enum or
    # typedef identity is recovered through the surrounding typedef records in
    # a later pass; named tags can be compared directly and safely now.
    named_retail = [item for item in retail_blocks if not item.name.startswith("._")]
    named_source = [item for item in source_blocks if not item.name.startswith("._")]
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
