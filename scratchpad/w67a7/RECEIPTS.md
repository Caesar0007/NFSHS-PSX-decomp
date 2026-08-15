# W67-A7 — GAME BOARD BELT — RECEIPTS (2026-08-15)

Repo @77c09895 base. All numbers re-gated by me (verify_asm; worklist/brief numbers
confirmed stale in both directions as usual). Strategy: seals > drops — worked the
small-diff tail of the target list; every heavy left untouched keeps its receipts.

## LEDGER (re-gated baseline -> final)

| fn | base | final | lever |
|---|---|---|---|
| Hud_Init__Fv (hud.cpp) | 8 (624/624) | **PASS 624/624** (pending wiring) | 3 PER_FN_TEXT_MOVES pure-slide rows — spec `tm_hudinit_v3.json`, probe-verified 3x |
| DrawW_BuildChunkObjectFacets (draww.cpp) | 8 (434/434) | **PASS 434/434 + branch words 15/15 byte-exact** (pending wiring) | 4 TEXT_MOVES rows (one `copy:true` slot fill) + 1 COUPLED BRANCH_RETARGET row — specs `tm_bcof.json` + `br_bcof.json`, probe-verified 2x |
| Physics_CalculateTireForces (physics.cpp) | "verify" task | **PASS 346** (already sealed; brief row stale) | none needed |
| Weather_DoWeather (weather.cpp) | 4 (197/197) | 4 — one probe falsified, angle sharpened | receipt in-source |
| Hud_RenderTacView (hud.cpp) | 13 (72/71) | 13 — one probe falsified, mechanism sharpened | receipt in-source |
| Physics_Real (physics.cpp) | 4 (1272/1272) | 4 — characterized (below), no probe spent | — |
| DrawW_BuildObjectFacets (draww.cpp) | 6 (189/189) | 6 — receipts already exhaust source axis (w62-a2: needs faithful instrument / 13A hand triage) | not touched |

## ORCHESTRATOR ACTIONS (wiring specs, all probe-verified)

1. **Hud_Init**: wire `scratchpad/w67a7/tm_hudinit_v3.json` into `PER_FN_TEXT_MOVES`
   verbatim. 3 rows, all pure single-insn schedule slides, disjoint def/use vs hopped
   lines, no labels/branches/slots touched (no brdist exposure). Probe: PASS 624/624
   x3 runs; siblings under the rows unchanged (Init0/InitTables/InitMap/InitCdPlayer
   PASS; BuildTach 20 / RenderTacView 13 / BuildTimeSprites 21 = baselines).
2. **DrawW_BuildChunkObjectFacets**: wire `scratchpad/w67a7/tm_bcof.json` into
   `PER_FN_TEXT_MOVES` **and** `scratchpad/w67a7/br_bcof.json` into
   `PER_FN_BRANCH_RETARGET` as ONE unit (18A coupling). Probe: PASS 434/434 x2 +
   branch-word census 15/15 == retail (census script inline in the receipts commit).
   Probe harness: `scratchpad/w67a7/vprobe_br.py` (tools/vprobe.py copy + `W67_BR_FILE`
   env hook; ROOT hardcoded — the parents[] promotion bug fired again on the copy).

## CATALOG-ROW CANDIDATES

- **COPY-INTO-SLOT ROWS NEED A COUPLED BR ROW (F/17C sharpening).** A `copy:true`
  TEXT_MOVES row that duplicates a value-staging insn into a branch delay slot makes
  the gate read PASS while the branch WORD is one insn short of retail's: retail's
  taken edge lands PAST the original copy (the slot already staged it; executing both
  is value-identical => gate AND board blind — the HeliCam class, 4th firing, caught
  pre-landing this time by the mandatory branch-word census). Rule: brdist-pair every
  slot-touching row; expect a BR row whenever the moved/copied insn is return staging.
- **`.extern`-DIRECTIVE KILLS +offset ASM-LABEL VIEWS (E).** A scalar view
  `extern int X __asm__("SYM+12")` is un-assemblable on the cc1plus lane: cc1 emits
  `.extern SYM+12,4` and GNU-as rejects the expression. The 15E storage-menu macro
  form is therefore unreachable for a struct FIELD at nonzero offset (only real
  symbols at the exact address can carry it). (Weather_DoWeather cluster A.)
- **cse FOLDS A DIFFERENT-OFFSET TAIL SET BACK THROUGH THE INDEX (A/E).** Attempting
  the "share the (high), keep distinct lo_sums" device by re-anchoring a 2-set pointer
  at `sym+28` with a compensating `[-7]` index: cse folds +28 against -28 back to a
  direct sym+0 load — bit-identical object. Sharpened mechanism (RenderTacView, in
  source): the entry/tail self-temp folds are DOWNSTREAM of the missing high-share;
  availability of `(high sym)` dies when the self-temp load overwrites its register,
  so the body lo_sum cannot derive; view-alias kills the share, real-symbol spelling
  triggers full value-merge + hoist. Wanted: a device keeping the entry high live into
  the body lo_sum without value-equating the lo_sums.

## FALSIFICATIONS (with basins)

- Hud_Init (8-basin): `w2 = 0x3c;` statement hoisted to block top = 58; hoisted to
  just-above-sprite8-call = 58 (w1/w2 s3<->s4 band rotation — the w61-a1 "take exactly
  one" warning holds in this basin). The three slides are sched-only.
- Hud_Init row-3 anchor: `addu $16,$16,$19` + li/move/addu7/lw44 lookahead matches
  THREE sibling BuildF4 groups — first-match moved the WRONG sibling (4 diffs,
  symmetric li-pair LCS artifact). Site-unique pin = the F4 pointer line
  `addu $4,$9,72` deep in the lookahead. (15D anchor law, another confirmation.)
- Weather_DoWeather (4-basin): +offset asm-label scalar view — assembler reject (above).
- Hud_RenderTacView (13-basin): tail set at `&showhud[0]` (sym+28) + `dh[-7]` exit —
  bit-identical 13@72 (cse fold, above).

## PHYSICS_REAL CHARACTERIZATION (no probe spent, window read off side_by_side)

The $6-vs-$2 seat: both builds emit the ratio copy `addu s0,v0,zero` BEFORE the four
loads, and the final schedules are IDENTICAL except the seat of the frontWheel.finalAcc.z
temp (ours $v0, retail $a2). Since $v0 is architecturally free in both final streams at
that window, the divergence is a local-alloc-time window question (the copy's RTL/sched1
position relative to the loads decides whether hard reg $2's lifetime blocks the qty), 
i.e. the 06E instrument gap — route to qty272/qtytrace with the w64a11 TEXT_MOVES row
(order half) already wired; do not spell-sweep (receipts already exhaust the shapes).

## HAZARDS FIRED

- **Write-truncation via encode error (16F class, firing #7+):** an in-place
  `open(p,'w').write()` receipt landing with a non-ASCII rocket emoji truncated
  draww.cpp to 0 bytes under cp1251 default encoding. Restored from HEAD (no prior
  local changes existed — verified); re-landed byte-mode with temp+size-assert+
  os.replace, ASCII-only. The rule "Write tool or byte-mode with asserts, ASCII-only"
  is absolute; I violated it once and paid.
- parents[] ROOT bug on the vprobe copy (fixed by hardcoding ROOT).

## FILES TOUCHED
- recon/game/psx/hud.cpp — receipt blocks only (Hud_Init seal receipt, RenderTacView
  falsification+mechanism). Source code unchanged; TU 55/62 = baseline.
- recon/game/psx/draww.cpp — receipt block only (BuildChunkObjectFacets). TU 26/35 = baseline.
- recon/game/psx/weather.cpp — receipt block only. TU 24/25 = baseline.
- scratchpad/w67a7/: tm_hudinit_v3.json, tm_bcof.json, br_bcof.json, vprobe_br.py,
  sbs dumps, TU baselines, backups (hud.cpp.base/.postinit, weather.cpp.base).

## BOARD DELTA (after orchestrator wires the two specs)
hud.cpp 55/62 -> 56/62; draww.cpp 26/35 -> 27/35. +2 gate seals, both with
branch-word proofs; zero PASS->FAIL anywhere (tugate re-run on all four touched TUs).
