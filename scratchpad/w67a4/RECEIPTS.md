# W67-A4 RECEIPTS — THE -G8 LITERAL BELT (region-1 E3 → OWN)

Repo `C:\Temp\nfs4-decomp`, base `77c09895`. Memory dir READ-ONLY, untouched.
`tools/*.py`, maspsx, user-live TUs: untouched. All numbers below measured in
this run; every gate 2×; zero PASS→FAIL tree-wide.

## 0. MANDATORY READS (done, in order)
memory: reference_mips_isa_asm.md (full) · reference_psx_cpp_reconstruction_methodology.md
(full, in pages) · reference_asm_pattern_catalog.md (heading census + the whole
law tail incl. 16A–16F, 17A–17C, 18A–18E in full). Then AGENT_GUIDE.md, w67/BRIEF.md,
w66a5/RECEIPTS.md, w66a6/ACCEPTANCE.md, gaptell_sdata.txt.

## 1. HEADLINE

**Region 1 (`sdata_8013C54C`): 41 → 51 OWN windows, 900 → 1888 bytes owned
(+988 B, +110%).** 10 of the 12 -G8-literal TUs converted to OWN in-tree, with
NO build.py change:

| TU | window | size | device | gate (2×) |
|---|---|---|---|---|
| `audiocmn.cpp` | 0x8013c628 | **248 B OWN** | named-array pool (10 literals) + 2 file-scope statics | 47/48 == base (CheckState 4) |
| `night.cpp` | 0x8013d9e0 | **188 B OWN** | =0 batch reorder + u_short cell dual-model | 17/19 == base |
| `r3dcar.cpp` | 0x8013d324 | **156 B OWN** | `R3DCar_InMenu = 0` (one lever) | 26/27 == base |
| `copspeak.cpp` | 0x8013d07c | **126 B OWN+** | `cdsectorreseek/gHandleCount = 0` | 27/27 == base |
| `nfs3.cpp` | 0x8013d270 | **88 B OWN** | trio → TENTATIVE (=0 removed) | 10/11 == base |
| `cario.cpp` | 0x8013d71c | **60 B OWN** | `carPixMap = 0` + header first-decl reorder | 9/11 == base |
| `sim.cpp` | 0x8013d40c | **40 B OWN** | `InBetween = 0` + 3 named arrays | 8/8 == base |
| `platform.cpp` | 0x8013da9c | **36 B OWN** | full run rebuilt =0 + "cdrom:" array + disablecard/gDctXtraMem placed | 8/8 == base |
| `fileroot.c` | 0x8013dd2c | **26 B OWN+** | fsprefix1/2 INITIALISED + literal arrays (C lane) | 9/9 == base |
| `loading.cpp` | 0x8013d9d0 | **16 B OWN** | `smallShapeFile = 0` + "back" array | 3/3 == base |

Acceptance (all fresh):
* `build.py --no-link` 508 objects, 0 failures (run ~8×).
* `tu_order_audit` 508 / **0 inversions**.
* `relink --lane recon` **GATE GREEN**: DUP 818 all blob-class, **REAL=0**,
  **HIDDEN PHANTOMS=0** (the new global `D_` array symbols dup only against
  their blob copies = the expected blob class).
* `probe_link` **84.36%** text (777 774 identical; w66a6 close 82.97%/765 016 —
  climbed), DATA leg 94.14%, exact data sections 170/218.
* Regions 2/3 no regression: data_8010CCD4 35 win/35 476 B (== w66a6);
  front_data 15 win/640 B (> w66a6's 12/476).
* ownmap failure histogram region 1: E3 20→10, E5 27→18.

## 2. THE MECHANISM MAP (what actually places a literal / a cell)

Established by direct cc1plus experiment + per-TU layout dumps (`lit.py`):

1. **≤ G bytes STRING LITERALS go to .sdata even at -G4** (both lanes) — that is
   why every ≤4-byte literal ("eng","Gen","\\","",…) is already in .sdata and only
   the 5–8-byte ones need -G8 (the w66a5 census's "-G8 tell" is really a
   ">G4,≤8B tell").
2. **Emission chronology** = parse order: initialised file-scope objects emit at
   their DEFINITION position; string literals emit when the USING function (or
   table initialiser) is compiled; fn-local statics emit at their fn's position;
   TENTATIVE cells emit at finish_file, AFTER everything, in FIRST-DECLARATION
   order (17B). Retail's interleaves [init cells][literals][statics][tentative]
   are reproduced by choosing =0-vs-tentative and definition positions — the 16E
   =0 discriminator applies in BOTH directions (nfs3's trio had to be
   UN-initialised).
3. **`__attribute__((section(".sdata")))` suppresses gp-encoding at EVERY size**
   (cc1plus probe: 1-, 4-, 7-byte arrays all emit absolute) — so a named .sdata
   array can stand in for a pooled literal of any size… BUT
4. 🔴 **the named array is `la`-addressed while a real literal's address is
   SPLIT (lui/%hi + addiu/%lo, schedulable into delay slots)**. When the oracle
   has the addiu in a jal delay slot, the array device loses it (bworld
   BWorld_Init 0→3, REVERTED). When the reference is from a DATA initialiser
   (fileroot, audiocmn tables) or the site has no split-slot fill (sim, loading,
   platform, audiocmn's 3 code sites — all gated ==base), the device is
   byte-neutral. **Rule: array-device per code site is gate-verified, never
   assumed.**
5. **cc1plus does NOT pool duplicate literals across separate uses in CODE**
   (hud has "::'''." twice) but DOES share them across DATA-initialiser elements
   ("eng" ×6 → one copy). Retail's single pool copy for a repeated code literal
   means the retail source referenced a NAMED array (hud: HudminChar) — a
   faithfulness signal, not a compiler knob.
6. **DATA_ALIGNMENT word-aligns char arrays**, so a 2-aligned 2-byte retail cell
   can NOT have been `u_char[2]` — model the storage as `u_short` under an
   `asm` label + a sized byte-array VIEW (night ColorIdx; the established
   dual-model device). Arrays are not gp-encoded by cc1plus, so the view keeps
   the oracle's absolute form.
7. **GPREL16/LO16 addends are verify-normalized** (verify_asm line ~173), so
   moving statics between .sbss/.sdata is gate-invisible.

## 3. REAL DATA DEFECT (9th of the zeroinit class)

**`audiocmn.cpp lastImpactSample` = retail `0x63` (99), ours was 0.**
ROM bytes `63 00 00 00` @0x8013c6ac — `gaptell` misread them as STRING "c"
(printable-prefix classifier). SYM: `STAT lastImpactSample INT` at obj-relative
+0x84. The never-written static gates the double-impact-sample suppression
(`iSFXnum == lastImpactSample && iSFXnum != 0x21`); comparing against 0 instead
of 99 changes behavior at sample 0. Fixed as a file-scope
`static int lastImpactSample = 0x63;` at its retail position.
Sibling: `cobbleCount` (SYM STAT CHAR) = 0 @0x8013c6b0, same treatment.
🔴 **gaptell classifier lesson: an all-ASCII-prefix little-endian INT reads as a
"string" — cross-check any 1–3-char "literal" against the SYM STAT map before
believing it.** (Also mis-reads: `SgameSFXvol=40` as "(", night's `0100` cells.)

## 4. ORCHESTRATOR ACTIONS REQUESTED

1. **PER_TU_FLAGS wiring: `"recon/game/common/bworld.cpp": {"g_value": "8"}`.**
   Whole-TU -G8 gates **20/21 == baseline, 2× (probed via vprobe env hook,
   `W60_TU_FLAGS`)**, and the probed object's .sdata is byte-for-byte retail's
   100-B run (SceneLoaded/cop_angle/gBWMemTotal + 5 grp literals + "" + tail;
   receipts §5). The source-side ordering edits are ALREADY LANDED and are
   -G4-neutral (gate == base both ways). bworld's row converts to OWN the
   moment this is wired. ⚠️ Do NOT also wire -G8 for sim/loading/platform/
   audiocmn — their pools are named arrays now; -G8 would double the literals.
2. **Catalog rows** (memory dir is read-only for me): §2's mechanism map
   (items 1, 3–6 are new law-grade facts: ≤G4-literals-at-G4, attribute
   suppresses gp at every size, la-vs-split limit of the array device,
   no-code-pooling/data-pooling asymmetry, DATA_ALIGNMENT char-array bound),
   §3's gaptell classifier trap.
3. **hud.cpp — the named next angle** (biggest unconverted window, 320 B vs
   retail 240): full map in §6.
4. `zeroinit`/`gaptell` hardening: classify 1–4-byte "strings" against the SYM
   STAT map (this run's defect was invisible to zeroinit because the cell was
   filed as a literal).

## 5. PROOFS / FILES

* Per-TU layout proofs: `lit.py` output in this file's §1 rows — each landed TU
  shows ONE implied base and a byte-exact retail run (audiocmn 248/248,
  night 188/188, nfs3 88/88, cario 60/60, sim 40/40, platform 36/36,
  fileroot 26/28-with-2B-zero-pad, loading 16/16, r3dcar 156/156,
  copspeak 126/128-with-2B-zero-pad).
* bworld -G8 probe: `tugate_probe.py` (tugate pointed at vprobe so W60_TU_FLAGS
  applies) 20/21 ×2; probed layout dump in session log; stock -G4 rebuild
  restored afterwards (gate re-run == base).
* Backups: `scratchpad/w67a4/*.bak` (r3dcar, copspeak, sim, loading, platform,
  bworld, fileroot, nfs3, night, cario, cario_externs.h, audiocmn).
* Tools left in scratchpad: `lit.py` (retail-vs-ours .sdata layout differ,
  literal-aware — promote-worthy), `tugate_probe.py`.

## 6. hud.cpp — NAMED ANGLE (not landed; full archaeology done)

Retail run 0x8013d89c..0x8013d98c (240 B): `HudminChar`/`HudsecChar` (named
initialised char arrays, FIRST) · D_8013D8AC zero4 · Wingman trio (=0 batch) ·
`Hud_gDebugInfo=1` · pool d8c4..d928 (SLC %d, HUD1, HUD2, ::'''., .:""",, 0/0,
0M00S00, 0.000, [D_8013D900 zero4], %s, %02d, - -, [D_8013D914 template
0400010203], [D_8013D91C/1D = countdownTick 1B + oldCountdown 0xff as CHARS],
['2' = BigBTCTime_state1 char[2]], [D_8013D924 = state2]) · tentative tail
d928..d98c with D_8013D954/5C/64 statics interspersed.
Our deltas: (a) HudminChar/HudsecChar defined below the BigBTC fns → move defs
to top; (b) Wingman trio must be =0, tail tentative; (c) our third "::'''."
after '- -' is a literal re-use where retail referenced HudminChar (mechanism
§2.5) — replace that ONE use with HudminChar; (d) countdownTick_216/oldCountdown
are int statics at top, retail = 1-byte chars inside the pool (=0 / =-1,
fn-static chronology); (e) D_8013D900/D_8013D954/5C/64 statics need placement;
(f) 0M00S00 content already correct (earlier 9-byte suspicion was a misread).
Everything is the §2 mechanism map applied fn-by-fn; no new device needed.

## 7. HAZARDS ENCOUNTERED

* 🔴 **vprobe/tugate_probe leaves the PROBED object in `build/`** (build.py's
  mtime cache then keeps it if the source is untouched). A -G8-probed bworld
  object sat in build/ until the next source edit forced a stock recompile.
  Rule: after any env-hook probe, touch/rebuild the TU (or re-run tugate) before
  reading build/ artifacts.
* The w66a5 heredoc/CRLF hazards fired again (audiocmn/bworld are CRLF; one
  multi-line replace missed on \n-vs-\r\n and aborted pre-write — by design,
  no partial state; redone byte-mode with NL detection).
* `git status` shows heavy peer traffic in `scratchpad/` and root artifacts
  (`-G0`, `a.out`, `cta*`, `pbuild/`) — untouched; staging explicit files only.
