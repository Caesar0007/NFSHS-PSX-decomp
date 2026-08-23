# psxcontroller.obj full-debug scope audit (2026-08-23)

Authoritative retail records are from `C:\Temp\nfs4-clean\nfs4-f-v3.txt` at the `psxcontroller.obj` 8c blocks. Reconstructed records were produced with the TU's PsyQ C++ compiler, `-O2 -g`, through `run_sym_type_graph_sweep.compile_debug`.

## Exact function scopes

- `InGame_ResetPSXController__Fii`: REGPARM `player` `$s2`, REGPARM `config` `$s6`; one function block containing only `type` `$s3` and `h` `$s4`. Code PASS 305/305.
- `InGame_GetDevice__Fi`: REGPARM `control` `$a0`; one empty function block. Code PASS 2/2.

## Remaining GetPSXPadValue delta

- Retail: REGPARM `value` `$a0`, REGPARM `player` `$s1`; one function block in declaration order `c` `$s0`, `newControl` `$v0`, `type` `$v1`.
- Reconstruction: the same parameters, single block, names, types, scopes, and declaration order, but `newControl` currently occupies `$a0`. No source-label record or nested `acc` block remains.
- Code gate: 76 diffs, 235/233 instructions. The 21-diff W78 improvement uses anonymous zero-instruction reference fences and adds no debug local or block record.
- Therefore this function is not claimed local-register exact. The open source task is to reproduce retail's shared-tail allocation so `newControl` receives `$v0` while preserving the exact scope record set.

## Remaining SetRamp delta

- Retail `InGame_SetRamp__Fv`: function block `h` `$s4`; nested loop blocks with `i` `$s3`; no other named locals. Code PASS 98/98.
- Reconstruction now removes the former `ctrl` and `hp` records byte-neutrally. One extra block-local remains: `hb` in `$v0`, used by the zero-instruction identity launder that prevents gcc-2.8.1 loop.c from hoisting `&hoff` and introducing `$s6`.
- Removing `hb` and exposing the full address only as an unnamed asm input yields exact reliable names but regresses SetRamp to 17 diffs / 99 instructions because `&hoff` is hoisted. A general memory barrier rematerializes `hoff` but duplicates the Cars-list base and reaches 16 diffs / 100 instructions. The open source task is therefore specifically an unnamed, movable-existence-killing base launder that preserves the Cars base CSE.
- The Parasite Eve 2 inline-identity idiom was tested both as a base-only helper and with the complete index-first address constructed inside the helper. Both remove `hb`, emit no useful retail-equivalent caller shape, rotate the loop's saved-register topology, and regress to 57 diffs / 107 instructions. Both were reverted.

TU type-graph gate remains OK: 86/86 named and 2/2 anonymous records, with no source-extra named or anonymous types. Current proof: `type_graph_psxcontroller_w78_current_20260823.tsv`.
