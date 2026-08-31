# Canonical PsyQ callback typedef restoration

Date: 2026-08-31

## Evidence join

Retail SLD/SYM retains five owner-visible callback typedef records:

- `audiomus.obj`: `CdlCB`, `PTR FCN VOID`;
- `fememcard.obj`: `MemCB`, `PTR FCN VOID`;
- `movie.obj`: `CdlCB`, `PTR FCN VOID`;
- `psxfront.obj`: `CdlCB`, `PTR FCN VOID`;
- `memcard.obj`: `MemCB`, `PTR FCN VOID`.

The SLD encoding proves the typedef name, pointer/function construction, and
`void` result but does not encode the function parameter list.  Canonical PsyQ
4.3 headers close exactly that missing surface:

```c
typedef void (*CdlCB)(u_char, u_char *);       /* libcd.h */
typedef void (*DslCB)(u_char, u_char *);       /* libds.h */
typedef void (*MemCB)(long cmds, long rslt);    /* libmcrd.h */
```

This is an evidence join, not an inference from call-site behavior.

## Source corrections

The canonical signatures replace unprototyped or false `(void)` callback
copies in:

- `recon/nfs4_types.h` (`CdlCB`, `MemCB`);
- `frontend/psx/psxfront_types.h` (`CdlCB`);
- `frontend/psx/movie_types.h` (`CdlCB`);
- `game/common/audiomus_types.h` (`CdlCB`);
- `frontend/common/fememcard_types.h` (`MemCB`);
- `frontend/psx/memcard.c` (`MemCB`).

The emitted libcd BIOS driver carried a stronger decompiler error:
`typedef int (*CdlCB)(int, unsigned char *)`.  It now uses the canonical
`void` result and byte interrupt argument.  All callback invocations already
ignored the nonexistent result.

The internal libmcrd `MemCardCallback(int)` carrier is not converted in this
round.  Its saved-callback state and call sites span the explicitly parked
`MemCardGetDirentry` and `MemCardFormat` bodies.  Canonical conversion remains
a precise future item: use `MemCB` for `McState.callback`, `_mc_save_cb`,
`MemCardCallback`, and the non-parked consumers, then re-open the two parked
functions together.  The gap is explicit rather than hidden behind the now
correct owner typedef records.

## Matching and type proof

Whole-owner detailed gates after the correction:

- `psxfront.cpp`: 25/25 PASS;
- `movie.cpp`: 17/17 PASS;
- `audiomus.cpp`: 23/23 PASS;
- `fememcard.cpp`: 18/18 PASS;
- `memcard.c`: 21/21 PASS;
- libcd callback consumers `CD_sync`, `CD_ready`, `CD_cw`, and `CD_datasync`:
  PASS at 160, 178, 259, and 90 instructions.

Owner-local full-debug comparisons remain exact:

- psxfront: 107/107 named, 2/2 anonymous;
- movie: 83/83 named, 2/2 anonymous;
- audiomus: 87/87 named, 2/2 anonymous;
- fememcard: 131/131 named, 2/2 anonymous;
- memcard: 24/24 named and all 48/48 typedef semantics covered.

The vendor `libcd/BIOS.obj` owner is correctly classified `SYM_UNTYPED`: its
FILE boundary survives but it carries no canonical type graph in retail SYM.

## Whole-tree regression proof

- full build completed and linked;
- both relink lanes GREEN with zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined-call audit: 15,781 call relocations, zero undefined;
- TU-order audit: 521 objects, zero inversions;
- call-target audit: 466 units, zero proven wrong targets;
- phantom audit: 518/518 TUs compile, all 3,491 oracle names exactly owned,
  zero hidden phantoms and zero ownership gaps.

Durable receipts are the six `*_callback_type_p428_20260831.tsv` ledgers and
`canonical_callback_typedef_relink_p428_20260831.json`.
