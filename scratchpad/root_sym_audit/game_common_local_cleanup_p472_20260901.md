# Game/common SYM-local cleanup (P472, 2026-09-01)

## Result

- `AIHigh_BTC_Wingman::HighExecute()` is declaration-clean and remains an
  exact 675/675-instruction PASS.
- `recon/game/common` improves from 703 to **704** declaration-clean mapped
  functions. Generic extra-source-local findings fall from 1783 to **1772**;
  missing SYM locals remain zero.
- The complete `aih_btccop.cpp` translation unit remains **40/40 PASS**.

## Restored source shape

- Every active state transition now calls the recovered inline
  `AIHigh_Base::SetState(newState, stateType)`. This removes the unrecorded
  `oldState` declarations and repeated decompiler-expanded destructor/store
  bodies while compiling byte-exactly.
- Raw MobileSpeaker vtable calls use the proven semantic `Purge()` and
  `Lose()` bridges. Temporary `speaker`, `targetCar`, `offset`,
  `currentRole`, and `newRole` aliases are gone.
- The speed-release test uses `perpTarget_->GetCarObj()` at both SLD inline
  sites. The prior volatile object view is gone.

## Measured compiler carriers

- `minTimeInZone`, `minLatMetersDistance`, and `minLongMetersDistance` retain
  retail's constant allocation. Folding them into literal tests keeps 675
  instructions but causes 24 diffs.
- `murder` preserves the retail zero in `a0` and the comparison in `v0`;
  both nested and compound direct tests keep 675 instructions but cause eight
  diffs.
- `speed` preserves the retail load-delay `nop` and `bgtz`/`lui` schedule. A
  direct absolute-value expression with the boundary fence gives 674
  instructions/15 diffs.
- A permitted empty-template, zero-instruction memory fence at the SLD
  line-188/189 boundary makes GCC re-derive the complete target/car/speed
  chain before `fixeddiv`, as retail does. Removing it gives 671
  instructions/12 diffs.

## Overlay invariant

`front.bin` remains a separately compiled overlay spanning
`[0x80010000, 0x80054548)`, with `_front_size = 0x44548`. `bigbuf.obj`
reserves the window and `address.obj` owns/describes `_front_obj`,
`_front_objend`, `_front_org`, and `_front_orgend`; frontend function object
ownership is unchanged.

## Gates

- Detailed HighExecute verifier: PASS 675/675.
- `aih_btccop.cpp`: 40/40 PASS.
- Strict declaration audit: 1193/1193 mapped; 704 clean; zero missing locals,
  type/storage findings, missing globals, or vtable findings; 115/115 vtables.
- Both relink lanes GREEN: real duplicates 0, hidden phantoms 0,
  relocation-referenced unresolved 0.
- Undefined calls: recon 15,781/0; source 15,779/0.
- Data-only payload audit: 11/11 byte-identical, including `vars.obj`.
- `git diff --check`: clean apart from line-ending notices.

Durable receipts:

- `game_common_strict_p472_20260901.md`
- `game_common_local_cleanup_relink_p472_20260901.json`
- `game_common_local_cleanup_undef_recon_p472_20260901.json`
- `game_common_local_cleanup_undef_src_p472_20260901.json`
