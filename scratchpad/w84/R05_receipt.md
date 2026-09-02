# W84-R05 receipt (regional variants)

Gate = `python regiondiff/tools/verify_region.py <REGION> <candidate> <fn> --lane-as=recon/<unit>.<ext>`
(run from `C:\Temp\nfs4-decomp`). All commands below were executed verbatim.

## Row status

| # | fn | class | region | words | status |
|---|---|---|---|---|---|
| 1 | HighExecute__10AIHigh_Cop | CHANGED | USA | 1464 | **REGION-PASS** (sealed this session) |
| 2 | MenuNFS4_DrawTextBox__FiR4RECTissbT5 | CHANGED | AU | 302 | REGION-PASS |
| 3 | Camera_GetViewInfo__FiP17DRender_tCalcViewi | CHANGED | AU | 206 | REGION-PASS |
| 4 | NFS4_LoadPerps__Fv | CHANGED | USA | 172 | REGION-PASS |
| 5 | FeTools_DrawPSXButton__FUcUsii | CHANGED | USA | 126 | REGION-PASS |
| 6 | Audio_InitDriver__Fii | CHANGED | USA | 61 | REGION-PASS |
| 7 | DrawForeground__18tScreenTournSelect | CHANGED | USA | 42 | REGION-PASS |
| 8 | func_800A77C0 | REGION-ONLY | USA | 9 | REGION-PASS |
| 9 | func_800A7848 | REGION-ONLY | AU | 8 | REGION-PASS |

## Verified gate lines (2026-09-02, this session)

```
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/regiononly/func_800A77C0.cpp func_800A77C0
  func_800A77C0: REGION-PASS (9 insns) [NFS4-R-USA]
python regiondiff/tools/verify_region.py AU regiondiff/recon/NFS4-R-AU/regiononly/func_800A7848.cpp func_800A7848
  func_800A7848: REGION-PASS (8 insns) [NFS4-R-AU]
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/frontend/common/screentournselect.cpp DrawForeground__18tScreenTournSelect --lane-as=recon/frontend/common/screentournselect.cpp
  DrawForeground__18tScreenTournSelect: REGION-PASS (42 insns) [NFS4-R-USA]
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/psx/audio.cpp Audio_InitDriver__Fii --lane-as=recon/game/psx/audio.cpp
  Audio_InitDriver__Fii: REGION-PASS (61 insns) [NFS4-R-USA]
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/frontend/common/fetools.cpp FeTools_DrawPSXButton__FUcUsii --lane-as=recon/frontend/common/fetools.cpp
  FeTools_DrawPSXButton__FUcUsii: REGION-PASS (126 insns) [NFS4-R-USA]
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/common/nfs3.cpp NFS4_LoadPerps__Fv --lane-as=recon/game/common/nfs3.cpp
  NFS4_LoadPerps__Fv: REGION-PASS (172 insns) [NFS4-R-USA]
python regiondiff/tools/verify_region.py AU regiondiff/recon/NFS4-R-AU/game/common/camera.cpp Camera_GetViewInfo__FiP17DRender_tCalcViewi --lane-as=recon/game/common/camera.cpp
  Camera_GetViewInfo__FiP17DRender_tCalcViewi: REGION-PASS (206 insns) [NFS4-R-AU]
python regiondiff/tools/verify_region.py AU regiondiff/recon/NFS4-R-AU/frontend/common/femenuextended.cpp MenuNFS4_DrawTextBox__FiR4RECTissbT5 --lane-as=recon/frontend/common/femenuextended.cpp
  MenuNFS4_DrawTextBox__FiR4RECTissbT5: REGION-PASS (302 insns) [NFS4-R-AU]
```

Rows 2-9 were already seeded/sealed by earlier work in this pipeline; this session
re-measured every one of them against the live gate (no candidate edits needed, no
regression). Row 1 was the only TODO on `regiondiff/REGION_PROGRESS.txt`.

## Row 1 — HighExecute__10AIHigh_Cop (USA, 1464 words) — SEALED

Candidate: `regiondiff/recon/NFS4-R-USA/game/common/aih_cop.cpp`
(seed = verbatim copy of `recon/game/common/aih_cop.cpp`; base fn is 100% in the
main tree, so the seed diff IS the retail delta and nothing else).

Gate:
```
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/common/aih_cop.cpp HighExecute__10AIHigh_Cop --lane-as=recon/game/common/aih_cop.cpp
```

### MEASURE FIRST — unedited seed

```
  HighExecute__10AIHigh_Cop: FAIL 12 diffs (ours 1460 / oracle 1464) [NFS4-R-USA]
      - lw v1,0(s1)      + lw v0,0(s1)
      - lw v0,1392(v1)   + lw v1,1392(v0)
      - ori v0,v0,2      + ori v1,v1,2
      - sw v0,1392(v1)   + sw v1,1392(v0)
                         + lw v0,88(s1)
                         + nop
                         + beqz v0,T
                         + li a2,1
```
i.e. **exactly one insertion of 4 instructions** (+ the $v0/$v1 swap it drags
through the immediately preceding `AIFlags |= 2` triple). Every other
instruction of 1460 already aligned — the base body needed no rewriting.

### The regional delta (one line)

Retail adds a **null-perp guard at the head of the `case 4` (chase) arm**: if the
cop has no `perpTarget_`, bail out of the whole chase body straight into the
drive-away tail. Base has nothing at that point.

Oracle, region @`80064C30` (base @`80064440`), immediately after the
`carObj->AIFlags |= 2` triple and the `s2 = this->state_` load:
```
/* 80064C48 */  lw    $v0,88($s1)        <- AIHigh_Cop::perpTarget_ (+0x58)
/* 80064C4C */  nop
/* 80064C50 */  beqz  $v0,.L80065208     <- the drive-away block (base .L80064A08)
/* 80064C54 */  li    $a2,1              <- delay slot = the target's `direction = 1`
```

Identification chain (no base-layout symbol lookup was used — regional VAs are
the region's own layout, per the pipeline rule):
* offset `+0x58` on `$s1` (= `this`) → `AIHigh_Cop::perpTarget_`, read off
  `recon/nfs4_types.h:2207` (`+0x54` = `AIHigh_BasicCop::driveAway_`, `+0x58` =
  `perpTarget_`) — *not* from `configs/symbol_addrs.txt`.
* branch target `.L80065208` is the region's copy of base `.L80064A08`, the
  `lui %hi(GameSetup_gData)` head of the drive-away block that the base source
  already labels `LAB_80064a0c:` (recon line 1251) and already `goto`s into from
  the `case 4` tail (recon line 1147). Confirmed by aligning both oracles around
  the `sw $a2,1360($v1)` (`desiredDirection`) / `sw $s2,1776($v0)`
  (`driveDirection`) / `AssignToPlayer` / `AIState_Normal` tail, which is
  byte-for-byte identical in base and region.

### The fix (source-level, one statement)

Inserted between the `AIFlags |= 2` block and the `if (0xa0 < chaseState->barrierTicks32_)`
test in `case 4`:

```c
if (this->perpTarget_ == (AIHigh_Player *)0x0) goto LAB_80064a0c;
```

`LAB_80064a0c` is the label the base tree already carries, so no new structure
was introduced. The `li $a2,1` delay slot is **not written in C** — gcc's reorg
fills it from the target block's `direction = 1`, exactly as it already does for
the two base-tree edges into the same label (the `j .L80064A0C` at base
`800648D0` takes the `lui` in its slot; the `beqz` at base `800649F8` takes the
`li $a2,1`). The $v0/$v1 swap in the preceding triple fell out for free — no
coloring lever was needed.

Result, first edit, no iterations:
```
  HighExecute__10AIHigh_Cop: REGION-PASS (1464 insns) [NFS4-R-USA]
```

### Falsified angles

None — no lever hunting was required. The measure-first diff was a clean
4-instruction insertion at a single site with an already-labelled branch target,
so the guard went in on the first attempt (12 diffs → 0, 1460 → 1464 insns,
count-exact). No `volatile`, no `__asm__`, no pins, no post-compile moves.

## Hygiene

* Only files written this session:
  `regiondiff/recon/NFS4-R-USA/game/common/aih_cop.cpp` (new candidate) and this
  receipt. `diff recon/game/common/aih_cop.cpp <candidate>` = the 9-line insert
  above and nothing else.
* Base tree (`recon/**`, `src/**`, `asm/**`, `configs/**`, `include/**`),
  `tools/*.py`, `regiondiff/tools/*.py`, `MANIFEST.tsv`, `REGION_PROGRESS.txt`
  untouched. The two `git status` entries (`recon/syslib/psx/libgpu/FONT.c`,
  `recon/syslib/psx/libmcrd/LIBMCRD.c`) are the user's pre-existing live probes,
  not mine.
* No git operations; `update_region_progress.py` deliberately NOT run.
* `regiondiff/REGION_PROGRESS.txt` currently still lists row 1 as TODO — it is
  stale for this row; the orchestrator's regen will pick it up.
