# W86-B8 receipt — regional row sealing (all rows R-USA)

Gate: `python regiondiff/tools/verify_region.py USA <cand> <fns> --lane-as=recon/<unit>.<ext>`
Oracle for the constant deltas: `regiondiff/AUDIT_LO16.txt` (NFS4-R-USA section).

## Row status

| row | fn | words | before | after |
|---|---|---|---|---|
| 8 | `nfs2eacinit__Fv` (game/psx/platform) | 18 | FAIL 2 | **REGION-PASS** |
| 7 | `Object_InitCustomObjects__Fv` (game/common/object) | 33 | FAIL 8 | **REGION-PASS** |
| 4 | `GetHelpText__23tScreenControllerConfig` (frontend/common/screencontroller) | 24 | FAIL 6 | **REGION-PASS** |
| 5 | `SetCurrentController__23tScreenControllerConfigb` (same TU) | 222 | FAIL 6 | **REGION-PASS** |
| 1 | `DrawBackground__11tScreenMain` (frontend/common/screenmain) | 822 | FAIL 2 | **REGION-PASS** |
| 3 | `Initialize__15tScreenUserName` (frontend/common/screenusername) | 48 | TODO | **REGION-PASS** |
| 2 | `DrawBackground__15tScreenUserName` (same TU) | 394 | TODO | **REGION-PASS** |
| 6 | `DisplayLoadingText__7tScreen` (frontend/common/fescreen) | 80 | TODO | **REGION-PASS** |

**ALL 8 ASSIGNED ROWS SEALED (REGION-PASS).** Plus one recovered pre-existing regression
(`Platform_SysStartUp__Fv`, see below). Final consolidated re-gate = 12/12 REGION-PASS:
nfs2eacinit 18, Platform_SysStartUp 58, Object_InitCustomObjects 33, Object_KillStatus 28,
GetHelpText 24, SetCurrentController 222, DrawBackground__11tScreenMain 822,
Initialize__11tScreenMain 221, PreLoad__11tScreenMain 39, Initialize__15tScreenUserName 48,
DrawBackground__15tScreenUserName 394, DisplayLoadingText 80.

Candidates touched (all edited in place; the two new ones seeded with `cp -n` so an existing
candidate could not be clobbered):
- `regiondiff/recon/NFS4-R-USA/game/psx/platform.cpp` (existing)
- `regiondiff/recon/NFS4-R-USA/game/common/object.cpp` (existing)
- `regiondiff/recon/NFS4-R-USA/frontend/common/screencontroller.cpp` (existing)
- `regiondiff/recon/NFS4-R-USA/frontend/common/screenmain.cpp` (existing)
- `regiondiff/recon/NFS4-R-USA/frontend/common/screenusername.cpp` (**new**, seeded from
  `recon/frontend/common/screenusername.cpp`)
- `regiondiff/recon/NFS4-R-USA/frontend/common/fescreen.cpp` (**new**, seeded from
  `recon/frontend/common/fescreen.cpp`)

No git ops, no `tools/`/`regiondiff/tools/` edits, no board/MANIFEST/memory edits
(`update_region_progress.py` deliberately NOT run — it rewrites the board).

## Per-row detail

### nfs2eacinit__Fv — `regiondiff/recon/NFS4-R-USA/game/psx/platform.cpp`
Not a text-id shift: a retail TUNING constant. `FILE_init(10,800,0x30)` -> `FILE_init(10,710,0x30)`
(AUDIT_LO16 insn 11: `240502c6`). Single use of the literal in the fn — no CSE-shared `li`.
Sibling re-gate: `Platform_SysStartUp__Fv` was **FAIL 3 (ours 59 / oracle 58) BEFORE my edit**
(measured on the untouched candidate first) although the board lists it SEALED — a pre-existing
regression caused by base-TU drift, not by this row. Diagnosed and repaired; see
"Recovered regression" below. Final state REGION-PASS 58.

### Object_InitCustomObjects__Fv — `regiondiff/recon/NFS4-R-USA/game/common/object.cpp`
Not a text-id shift either: four re-tuned pool sizes.
`reservememadr("Custom Objects",0x400)` -> 1372; `reservememadr("Custom SimObjects",0x400)` -> 764;
`blockfill(...,0x3fc)` -> 760 (= pool-4, tracks the 764); third `reservememadr(...,0x400)` -> 612.
(AUDIT_LO16 insn 3/11/17/23.) The three base `0x400`s already emit three separate `li $a1` (each is a
call argument, `$a1` clobbered between) — no CSE-shared constant, and the regional values are all
distinct anyway. Sibling re-gate: `Object_KillStatus__Fv` REGION-PASS (unchanged).

### GetHelpText__23tScreenControllerConfig — `.../frontend/common/screencontroller.cpp`
+1 retail string-table shift: switch arms `0x218/0x219/0x21a` -> `0x219/0x21a/0x21b`
(AUDIT_LO16 insn 16/18/20). Three distinct literals, one use each (grep-verified over the fn) —
32B-5 CSE-shared trap does not apply. The `default: -1` funnel and the balance_case_nodes tree shape
are untouched, so the 24-insn dispatch is byte-stable.

### SetCurrentController__23tScreenControllerConfigb — same TU
+1 shift on the negcon dialog ids: `TextSys_Word(0x20b)` -> `0x20c`, `yesnowords[0] 0x20c` -> `0x20d`,
`yesnowords[1] 0x20d` -> `0x20e` (AUDIT_LO16 insn 7/15/17). 32B-5 check: grepped the whole 358-line
function body for `0x20?`/`52x`/`53x` — exactly the three sites, all distinct values before AND after
the shift, and the oracle carries three separate `li` (524/525/526), so no shared-constant co-patch is
needed. Both fns of this TU gated together: REGION-PASS 24 / 222.

### DrawBackground__11tScreenMain — `.../frontend/common/screenmain.cpp`
+1 shift on the single `TextSys_Word(0x272)` -> `0x273` in the memcard-warning block
(AUDIT_LO16 insn 325). Only `TextSys_Word` literal in the 822-insn function — no CSE risk.
Siblings re-gated: `Initialize__11tScreenMain` 221 and `PreLoad__11tScreenMain` 39 both REGION-PASS.

### Initialize__15tScreenUserName + DrawBackground__15tScreenUserName — NEW candidate
`regiondiff/recon/NFS4-R-USA/frontend/common/screenusername.cpp`, seeded verbatim from the base TU
(which the user had just re-landed at 22:28 — the seed carries their SYM work).
Measure-first on the untouched seed: Initialize FAIL 2, DrawBackground FAIL 12.
- Initialize: the row-label loop base `TextSys_Word(i + 0x1fb)` -> `i + 0x1fc`. The audit word is an
  `addiu $a0,$s0,508` (not a `li`) because the loop index lives in `$s0` and the id is base+index;
  editing the source constant reproduces it without disturbing the induction chain.
- DrawBackground: SIX sites, three distinct ids each spelled twice (different switch arms, so retail
  emits six separate `li $a0`): `0x205`x2 -> `0x206`, `0x206`x2 -> `0x207`, `0x207`x2 -> `0x208`.
  🔴 ORDERING HAZARD (a +1 shift over a CONTIGUOUS id run): a naive ascending textual replace would
  re-hit the sites it had just written (0x205->0x206 then 0x206->0x207 promotes them twice). Applied
  strictly DESCENDING (0x207 -> 0x208 first, then 0x206, then 0x205); verified 6/6 landed by gate.

### DisplayLoadingText__7tScreen — NEW candidate
`regiondiff/recon/NFS4-R-USA/frontend/common/fescreen.cpp`, seeded verbatim from the base TU.
Measure-first: FAIL 4 (two diff pairs). `0x27d` -> `0x27e` at BOTH source sites inside the 2-iteration
render loop (`FETextRender_MenuTextPositionedJustify` arg and the `TextSys_Word` inside
`textpixels(...)`). 32B-5 relevance: the same literal twice in one cse window is exactly the shape
that CAN collapse to one `li` — here it does NOT (the intervening call clobbers `$a0`), which both the
audit (insn 30 AND insn 40) and the gate's two diff pairs confirm, so both sites move together.

## Recovered regression (outside my rows, same candidate)

`Platform_SysStartUp__Fv` (game/psx/platform, board = SEALED) was **already FAIL 3 (ours 59 / oracle
58) on the untouched candidate** when I measured it. Root cause found: the BASE TU
`recon/game/psx/platform.cpp` had been re-landed (22:14) changing the `.sdata` device for the
`setdirectory("cdrom:")` literal — the old NAMED `.sdata` array carrier (`char D_8013DAA0[]
__attribute__((section(".sdata")))` + the six trailing globals hoisted ABOVE the function) had gone
stale against the current tree and cost the `jal`+`addiu`-in-delay-slot shape (our extra `jal`+`nop`).
Fix = re-sync the regional candidate to the base's landed shape: plain `setdirectory("cdrom:")`,
`D_8013DAA0` array removed, `disablecard`/`gDctXtraMem`/`gLowMemory`/`gHighMemory`/`gCurrentMemory`/
`gTotalMemory` moved back BELOW `Platform_SysStartUp`. The regional-only delta
(`RDAT_8013F044 = func_800DCEAC;`) is preserved. Result: REGION-PASS 58/58.
**Lesson for the fleet: a regional candidate is a FROZEN COPY of its base TU — when the base TU's
codegen devices are re-landed, every regional candidate seeded from the older shape silently rots.
Measure the untouched seed/candidate first, always, and diff it against the current base TU before
assuming your own row caused a sibling failure.**

## Class summary (what these rows actually were)

6 of 8 rows are the retail **+1 string-table shift** (one entry inserted ahead of these id blocks):
GetHelpText (3 ids), SetCurrentController (3), DrawBackground__11tScreenMain (1),
DisplayLoadingText (1 id x 2 sites), Initialize__15tScreenUserName (1 loop base),
DrawBackground__15tScreenUserName (3 ids x 2 sites).
2 of 8 are NOT text ids but real retail retunes: `nfs2eacinit` FILE_init 800 -> 710, and
`Object_InitCustomObjects` custom-object pool sizes 1024/1024/1024 -> 1372/764/612 (+ the blockfill
span 1020 -> 760 tracking the 764 pool). Both were found by reading the AUDIT_LO16 words rather than
assuming the +1 class — worth keeping as the counterexample to "the audit rows are all text ids".
