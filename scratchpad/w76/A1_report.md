# W76-A1 — `__15tGlobalMenuDefs` (frontend/common/femenudefs) — REPORT

**Result: 1138 → 932 diffs (−206, −18.1%), reg-blind LCS 200 → 134, reg+spill-blind
144 → 132, instruction count UNCHANGED (3215 vs oracle 3207).
TU 65/66 PASS on both gate runs (identical outputs). ZERO PASS→FAIL. Nothing sealed.
No pins, no asm insertions, no build.py rows — the landing is 5 plain
statement-expression wrappers (zero machine insns) + receipt comments.**

| metric | baseline (W75) | final |
|---|---|---|
| `verify_asm` diffs | 1138 | **932** |
| ours / oracle insns | 3215 / 3207 | 3215 / 3207 |
| reg-blind LCS (structure) | 200 | **134** |
| reg+spill-blind LCS | 144 | **132** |
| TU gate | 65/66 PASS | 65/66 PASS (×2, identical) |

All probing done on a PRIVATE sibling TU (`femenudefs__w76p.cpp` from a byte-exact
`git show HEAD:` snapshot, deleted after every batch — fleet rule held; a concurrent
belt (w76-A20) landed 2 vptr-store alias-dial hunks in OTHER fns of this TU mid-wave
and both hunks were preserved intact through my landing).

---

## 1. THE LANDED LEVER — **THE CSE-FLUSH NOTE DIAL** (new instrument + a measured cell)

**Edit (femenudefs.cpp only, mem-init list):** wrap FIVE existing address arguments in
depth-1 GNU statement-expressions —
`itemWeather(..., (tListIterator *)({ &iteratorWeather; }))`, same on `itemTraffic`,
`itemLocalSpeech`, and on `menuTrackOptions`' `({ &itemTrackDirection; })` +
`({ &itemTrackMirrored; })`.

**Measured mechanics (dump-verified, `late90` variant + base .jump comparison):**
one nest level of `({ E; })` around a mem-init argument emits **4 NOTE_INSN_BLOCK
notes** (stmt-expr block + inner brace scope, BEG+END each) **+ 1 value-copy insn per
wrapped site** that cse deletes — i.e. **5 RTL chain objects, 0 machine insns**.
Final insn count is byte-count-identical (3215). `cse.c:8620-8645` (verified in
gcc-2.8.1-src) increments its per-1001-object flush counter for EVERY chain rtx —
insns AND notes — so these 25 objects at chain ordinals ~1002-1063 move the flush
boundaries relative to everything downstream.

**Effect:** the `itemGoToDuelBuyCar` `-1` (uid 2573, W75's headline residual) now
survives as a FRESH def (`li t0,-1` appears at ours-insn 1227; pre-fix it was
cse-forwarded to menuTrackOptions' `-1` ~330 objects earlier and rematerialized from
the {t0,t1} reload pool). The t0/t1 phase region's structure largely aligns
(reg-blind 200→134); gate −206.

**Cell shape (40+ gate-measured variants — COUNT, SITES and DEPTH all load-bearing):**
- winning cell = the 3 item-init sites + **exactly 2** menuTrackOptions args, depth 1
  = 25 objects. Any 2 MTO args work: {TrackDirection,TrackMirrored} /
  {TD,TimeOfDay} / {TM,TimeOfDay} / {TD,LocalSpeech} all = **932** exactly.
- every single site alone: inert (1138×9).
- same 5 sites at depth 2 (45 obj): 2800; depth 3: 2450 — notes are NOT inert,
  it is genuinely the count dial, not the value copies.
- 3 sites (15 obj) = 2331; 4 sites (20 obj) = 2251; 6-7 sites (30-35 obj) = 2790/2800;
  sites 4-8 instead of 0-4 (same 25 obj, later position) = 1497 — position matters.
- one site × depth 6 (25 obj at ONE position) = 2790 ×3 positions — distribution
  across 5 positions is required, not just the total.
- stacking a 2nd round on top of 932: downstream (duel region) +1..+5 sites =
  1582/1598×4; upstream (iteratorLaps region, before flush #1) = 2790/2800×2 —
  the basin rejects all further padding. **DO NOT EXTEND.**

## 2. THE FLUSH-BOUNDARY MAP (corrected census + retail-side bound)

- 🔴 **W75's chain ordinals were /i-BLIND.** The census regex missed the 342
  `insn/i`/`note/i`/`call_insn/i` inline-expansion objects (the 33 inline-expanded
  wrapper ctors). True chain = **3830 objects** (2871 insn + 396 note + 221 call +
  231 insn/i + 78 note/i + 33 call_insn/i). W75's "986/2019/3008" = true
  **1057/2165/3311**. With the correction the model finally closes: flush #1 (count
  ~1001) lands BEFORE the menuTrackOptions `-1` defs at 1057/1058 → they and the duel
  def (true ordinal 1390/1391) shared run 2 → forwarding. One `-1` def cluster per
  1001-object run: 129/130, 1057/1058, 2165/2166 (+2271 forwarded), 3311/3312
  (+3348... forwarded) — all verified on the .jump dump.
- Retail-side bound from the SYM SLD: the whole 3207-insn ctor carries only **15
  line-change records** (1315→1353 at entry, 2163 at +0x8DE4, 2168-2172 + 2200 in the
  body tail). Retail's `-g` build therefore had only ~15 line notes here — retail's
  chain length ≈ ours ± tens of objects, NOT thousands. The boundary mismatch vs
  retail is a small upstream Δ (~60-390 objects ≈ 1-5 per mem-init of pre-cse
  expansion economy), which no measured axis reproduces wholesale — hence the
  resonance-hunting approach instead of geometry matching.

## 3. FALSIFIED THIS WAVE (all gate-measured — do NOT retry)

1. **Whole-region boundary re-aiming by bulk note-padding.** The run-preserving
   window was computed exactly (K ∈ (842,923) added objects at ordinals 1002-1078
   keeps every non-duel `-1` run relationship while pulling flush #2 into the open
   window (duel-use, 2165)): K = 845/865/885/905/921 → 4084..5641, insn count swings
   ±115. Below-window K = 609/709/809/949/1009 → 4053..5636. Moving a boundary
   through 1000+ objects of content re-randomizes the freshness of EVERY constant
   (the 10s, 0s, addresses — not just the -1s); the run-analysis of one literal does
   not predict the gate. **The dial is real but only small-K resonances are usable.**
2. **The "slack-region is inert" model.** T25 (109 obj) = 3441, T50 (209 obj) = 5453
   even though fire2 stays inside (duel-use, 2165) — the naive -1-only run model does
   not extend to the full constant population. (T5's 932 was found BECAUSE this
   falsification run included small K.)
3. **Single-site depth stacking:** d2/d3/d6 anywhere = 2450..2800. The +1 copy insn
   per site is once-per-site regardless of depth (dump-verified at depth 45).
4. **Angle (2) — more alias-dial sites in this fn's executed paths: NONE remain.**
   All 10 wrapper-class inline ctors already carry the W75 COMPONENT_REF spelling;
   the ctor body's stores are plain member assigns / launder-guarded pointer stores
   (checked nfs4_types.h + body). (Other belts are converting the ~90 tree-wide
   sites in OTHER fns — w76-A20 landed 2 in this TU's callbacks, preserved here.)
5. **Angle (3) — sibling-corpus menu-ctor idioms:** not reached (budget cut by
   orchestrator RESUME order); nothing suggests a corpus precedent for a
   3800-object single-BB ctor — the flush kludge is compiler-internal, not an idiom.

## 4. RESIDUAL PROFILE IN THE 932 BASIN (named next angles)

Raw-diff density per 200-insn bucket (ours coords): bucket 5-8 (insns 1000-1800)
≈ 360 — the surviving part of the t0/t1 phase; buckets 12-13 (insns 2400-2800)
≈ 110 — the slider block; buckets 15-16 ≈ 19 — the body tail.

1. **Duel `-1` coloring:** ours now `li t0,-1` vs retail `li v0,-1` — fresh but
   t0-colored (reg 708 fully substituted out of .greg; whether it is still
   reload-remat or local-alloc'd to t0 is the open question — the .lreg record
   format defeated my quick grep). If it is a reload, the {t0,t1} pool argument
   (W75 §3) still applies and v0 stays unreachable by rotation; if allocated,
   a source-level preference lever (24E family, no pins) may reach v0 and flip
   the remaining phase. **Read reg 708's .lreg/.greg record first.**
2. **Slider block (~110):** unchanged residual class — retail reads FEApp through
   `lw v0,0(s0)` + `addiu v0,v0,557` chains; ours materializes iterator addresses
   via `lui/addiu %hi`. W75's falsified forms still stand; the named ask is a
   non-barrier ref dial for the `%hi(FEApp)`-in-`$s0` hoist.
3. **Further resonance hunting is closed** in this basin (item 1 falsifications) —
   any new dial must come from a different mechanism (e.g. the -g/SLD line-note
   identity, §2: re-lining our source to retail's 15-line-note geometry under a
   stripped `-g` lane is the one untried axis that matches retail's actual chain).

## 5. PROCESS / TOOLS (untracked, scratchpad/w76/)

- `A1_probe.py` — variant harness on the PRIVATE sibling TU (auto-delete, build-
  artifact cleanup); `A1_census.py`/`A1_census2.py` (/i-corrected chain census);
  `A1_inline_census.py` (254-call + vtable census); `A1_dumpcheck.py` (note-delta
  verifier); `A1_sld.py` (retail SLD extractor); `A1_resid.py` (residual profiler);
  `A1_t5diag.py`; `A1_land.py` (the byte-mode landing script); `A1_head.cpp`
  (byte-exact HEAD snapshot); run logs `A1_run1..12.txt`, `A1_resid_T5.txt`,
  gate receipts `A1_gate1/2.txt`.
- probe dumps live in `scratch/rtl/femenudefs__w76p.*` (separate stem — W75's
  protected `scratchpad/w75/rtl_base/` untouched).
- The probe-TU tugate shows 58/66 vs the real TU's 65/66 (7 fns' oracle mapping is
  TU-path-dependent); the ctor gate number is path-independent (base probe = 1138
  = real-TU baseline exactly; landed real-TU = 932 = probe T5 exactly).
- Landing preserved the concurrent w76-A20 hunks (fresh read → targeted byte-write;
  the fleet shared-TU rule worked as designed).
- No git add/commit/stage. No memory-dir writes. tools/build.py untouched.
