#!/usr/bin/env python3
"""CTOR_ALIAS fix: rename invented tClass_ctor/_dtor names to the REAL mangled
ctor/dtor symbols via extern "C" variadic decls (promotions unchanged -> codegen
byte-identical; only the reloc name changes, which is the bug being fixed).
Binary-safe byte replacements."""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

# alias -> real mangled symbol
REN = {
    "tAllScreens_ctor": "__11tAllScreens",
    "tAllScreens_dtor": "___11tAllScreens",
    "tFEApplication_ctor": "__14tFEApplication",
    "tFEApplication_dtor": "___14tFEApplication",
    "tGlobalMenuDefs_ctor": "__15tGlobalMenuDefs",
    "tGlobalMenuDefs_dtor": "___15tGlobalMenuDefs",
    "tInsideBoxLeftRightSlider_ctor": "__25tInsideBoxLeftRightSliderUiP13tListIterator",
    "tListIteratorCarColor_ctor": "__21tListIteratorCarColorPcN21iP11tCarManager",
    "tListIteratorCar_ctor": "__16tListIteratorCarPcP11tCarManager",
    "tListIteratorIndexed_ctor": "__20tListIteratorIndexedPsPcT2",
    "tListIteratorRangeIndexed_ctor": "__25tListIteratorRangeIndexedccPcT3",
    "tListIteratorRange_ctor": "__18tListIteratorRangeccPc",
    "tListIteratorTournament_ctor": "__23tListIteratorTournamentPcP18tTournamentManager",
    "tListIteratorTrack_ctor": "__18tListIteratorTrackPcT1P13tTrackManager",
    "tListIterator_ctor": "__13tListIteratorPsPc",
}

# header decl rewrites: alias decl -> extern "C" mangled variadic decl
HDR = {
    "recon/frontend/common/front_externs.h": [
        (b'tAllScreens *tAllScreens_ctor(...);',
         b'extern "C" tAllScreens *__11tAllScreens(...);        /* real ctor symbol (was tAllScreens_ctor phantom) */'),
        (b'tAllScreens *tAllScreens_dtor(...);',
         b'extern "C" tAllScreens *___11tAllScreens(...);       /* real dtor symbol */'),
        (b'tFEApplication *tFEApplication_ctor(...);',
         b'extern "C" tFEApplication *__14tFEApplication(...);  /* real ctor symbol */'),
        (b'tFEApplication *tFEApplication_dtor(...);',
         b'extern "C" tFEApplication *___14tFEApplication(...); /* real dtor symbol */'),
        (b'tGlobalMenuDefs *tGlobalMenuDefs_ctor(...);',
         b'extern "C" tGlobalMenuDefs *__15tGlobalMenuDefs(...);  /* real ctor symbol */'),
        (b'tGlobalMenuDefs *tGlobalMenuDefs_dtor(...);',
         b'extern "C" tGlobalMenuDefs *___15tGlobalMenuDefs(...); /* real dtor symbol */'),
    ],
    "recon/frontend/common/femenudefs_externs.h": [
        (b'tInsideBoxLeftRightSlider *tInsideBoxLeftRightSlider_ctor(...);',
         b'extern "C" tInsideBoxLeftRightSlider *__25tInsideBoxLeftRightSliderUiP13tListIterator(...);  /* real ctor symbol */'),
        (b'tListIteratorCarColor *tListIteratorCarColor_ctor(...);',
         b'extern "C" tListIteratorCarColor *__21tListIteratorCarColorPcN21iP11tCarManager(...);  /* real ctor symbol */'),
        (b'tListIteratorCar *tListIteratorCar_ctor(...);',
         b'extern "C" tListIteratorCar *__16tListIteratorCarPcP11tCarManager(...);  /* real ctor symbol */'),
        (b'tListIteratorIndexed *tListIteratorIndexed_ctor(...);',
         b'extern "C" tListIteratorIndexed *__20tListIteratorIndexedPsPcT2(...);  /* real ctor symbol */'),
        (b'tListIteratorRangeIndexed *tListIteratorRangeIndexed_ctor(...);',
         b'extern "C" tListIteratorRangeIndexed *__25tListIteratorRangeIndexedccPcT3(...);  /* real ctor symbol */'),
        (b'tListIteratorRange *tListIteratorRange_ctor(...);',
         b'extern "C" tListIteratorRange *__18tListIteratorRangeccPc(...);  /* real ctor symbol */'),
        (b'tListIteratorTournament *tListIteratorTournament_ctor(...);',
         b'extern "C" tListIteratorTournament *__23tListIteratorTournamentPcP18tTournamentManager(...);  /* real ctor symbol */'),
        (b'tListIteratorTrack *tListIteratorTrack_ctor(...);',
         b'extern "C" tListIteratorTrack *__18tListIteratorTrackPcT1P13tTrackManager(...);  /* real ctor symbol */'),
        (b'tListIterator *tListIterator_ctor(...);',
         b'extern "C" tListIterator *__13tListIteratorPsPc(...);  /* real ctor symbol */'),
    ],
}

for rel, edits in HDR.items():
    p = ROOT / rel
    data = p.read_bytes()
    for old, new in edits:
        n = data.count(old)
        assert n == 1, f"{rel}: {old!r} count={n}"
        data = data.replace(old, new)
    p.write_bytes(data)
    print(f"HDR  {rel}: {len(edits)} decls")

# call-site renames: alias( -> mangled(   (longest names first to avoid
# tListIterator_ctor( matching inside tListIteratorCar_ctor( etc.)
for rel in ("recon/frontend/common/front.cpp",
            "recon/frontend/common/femenudefs.cpp"):
    p = ROOT / rel
    data = p.read_bytes()
    total = 0
    for alias in sorted(REN, key=len, reverse=True):
        old = alias.encode() + b"("
        new = REN[alias].encode() + b"("
        n = data.count(old)
        data = data.replace(old, new)
        total += n
    p.write_bytes(data)
    print(f"CPP  {rel}: {total} call sites renamed")

# nothing may remain
for rel in list(HDR) + ["recon/frontend/common/front.cpp",
                        "recon/frontend/common/femenudefs.cpp"]:
    data = (ROOT / rel).read_bytes()
    for alias in REN:
        assert alias.encode() not in data, f"{rel} still has {alias}"
print("residual check: clean")
