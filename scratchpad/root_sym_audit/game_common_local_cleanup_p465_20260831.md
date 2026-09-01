# Game/common SYM-local cleanup (P465, 2026-08-31)

## Result

- `recon/game/common` remains 1193/1193 function-mapped.
- Declaration-clean functions improved from 682 at P464 to **685**.
- Generic unclassified extra-source-local findings fell from 1857 to
  **1851**. Six decompiler locals were removed; one unavoidable optimized
  comparison carrier was closed with a measured oracle receipt.
- Missing SYM locals remain **zero**. Type/storage findings,
  missing/extra globals, and vtable findings remain zero; vtables remain
  115/115 mapped.
- `aih_basiccop.cpp` remains 9/9 PASS.

## Exact source restorations

- `AIHigh_BasicCop::CheckSpikeBelt()` now calls
  `AILife_IsSliceInAnyVisibleArea(...)` directly at both sites. The generic
  `pCVar1` carrier is gone while the retail 50-instruction body remains exact.
- `Blockade_AddRoadFlare()` now uses the SYM-recorded `Trk_SFX *sfxInstance`.
  The SYM-recorded inline `Group::this` operation is represented by the real
  `GetData()` and `GetNumElements()` methods. Generic `pGVar1`, `pGVar2`, and
  `iVar3` are gone; the natural `Trk_SFX` field stores and group count increment
  remain a 21-instruction PASS.
- `AIHigh_BasicCop::HandleBlockadeSpeech()` now uses the canonical Speaker
  virtual order through `Lose`: `Report`, `Status`, `Deny`, `Grant`, `Ready`,
  `Engage`, `Lose`. This replaces raw `_vf + 0x38/0x3c` arithmetic and
  `pSVar4` with `Speech_Mobile(this->carObj_)->Lose()`, retaining the exact
  73-instruction body.

## Explicit measured carrier

- `CheckSpikeBelt::freshenElapsed`: SYM retains only the block-scoped
  `timeNow` value. Using that value directly preserves the 50-instruction
  count but produces 18 diffs: GCC removes the zero initialization and
  `sltiu`, changes the branch form and global-base lifetime, and drops one
  saved register. The explicit comparison-result carrier recreates all those
  retail allocation/control-flow decisions. It is documented as a
  source-only code-generation carrier, not asserted as a retail declaration.

## Overlay ownership invariant

`front.bin` remains treated as the independently linked payload for
`[0x80010000, 0x80054548)`, with `_front_size = 0x44548`; `bigbuf.obj`
reserves the window and `address.obj` supplies its bounds. No resident TU
ownership is inferred merely from a symbol's runtime address in that range.

## Gates

- `aih_basiccop.cpp`: 9/9 PASS; the changed bodies are 50/50, 21/21, and
  73/73 instructions.
- Both relink lanes GREEN: real duplicates 0, hidden phantoms 0,
  relocation-referenced unresolved 0.
- Undefined calls: recon 15,781/0; source 15,779/0.
- Data-only payload audit: 11/11 byte-identical.
- `git diff --check`: clean apart from line-ending notices.

Detailed declaration ledger: `game_common_strict_p465_20260831.md`.

Durable gate receipts:

- `game_common_local_cleanup_relink_p465_20260831.json`
- `game_common_local_cleanup_undef_recon_p465_20260831.json`
- `game_common_local_cleanup_undef_src_p465_20260831.json`

## Next review target

The next bounded source-restoration round is the leading `aih_btccop.cpp`
group: `GetCheckChasePosition`, `StartArrest`, `FinishArrest`, and the
`AIHigh_BTC_HumanCop` constructor. These contain six remaining generic locals
and are smaller, more independently measurable targets than the later large
state-machine bodies.
