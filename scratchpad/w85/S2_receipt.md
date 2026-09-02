# W85-S2 receipt — device purity, keeping every PASS

Agent: W85-S2. Scope: `recon/game/common/` — stats.cpp, audiomus.cpp, speech.cpp
(+ speech_types.h), audiocmn.cpp, audioclc.cpp, audioeng.cpp, audiotrk.cpp.

Gate: `python tools/verify_asm.py <file> <fn>` (authoritative);
whole-file state via `python tools/tugate.py <file>`.

## BASELINE (recorded before any edit, 2026-09-02)

| TU | gate |
|---|---|
| recon/game/common/stats.cpp    | **7/7 PASS** |
| recon/game/common/audiomus.cpp | **23/23 PASS** |
| recon/game/common/audiotrk.cpp | **6/6 PASS** |
| recon/game/common/audioeng.cpp | **9/9 PASS** |
| recon/game/common/audioclc.cpp | **18/18 PASS** |
| recon/game/common/audiocmn.cpp | **48/48 PASS** |
| recon/game/common/speech.cpp   | **102/102 PASS** |

Every TU in scope starts fully PASS ⇒ the iron rule reduces to: **end each file
at the same PASS count with strictly fewer devices, or restore verbatim.**

## DEVICE CENSUS (code only; `asm("symbolname")` declaration renames excluded —
they are C++ mangled-symbol bindings, not codegen devices)

(filled in per file below)

---

# 1. recon/game/common/stats.cpp — 7/7 PASS -> 7/7 PASS, **-1 device**

## Device census (code only)
| # | line (orig) | device | fn | verdict |
|---|---|---|---|---|
| 1 | 446 | read-only fence `__asm__("" : : "r"(position),"r"(position))` | Stats_ExtrapolateOpponentTimes | **REMOVED — replaced by pure C** |
| 2 | 828 | **PIN** `register int PlayerPosition asm("$21")` | Stats_TrackEndGame | KEEP (see §1.2) |
| 3 | 859 | **PIN** `register int raceIndex asm("$22")` | Stats_TrackEndGame | KEEP (see §1.2) |
| 4 | 895 | **hand-asm template** (8 real insns: lw/nop/lw/nop/slt/bnez/addu/addu) | Stats_TrackEndGame | KEEP (see §1.2) |
| 5 | 902 | identity fence `("" : "+r"(raceIndex) : "m"(...))` | Stats_TrackEndGame | KEEP |
| 6 | 914 | read-only fence `("" : : "r"(raceIndex))` | Stats_TrackEndGame | KEEP |
| 7 | 930 | read-only fence `("" : : "r"(DesiredSlice))` | Stats_TrackEndGame | KEEP |

**`volatile` audit — all 31 hits are COMMENT text.** `perl -0777 -pe 's{/\*.*?\*/}{}gs; s{//.*}{}g'`
over the file leaves **zero** `volatile` tokens: every one lives inside a
W59/W71/W72/W74 MATCH-receipt block. Nothing to classify, nothing to remove.

## 1.1 DEVICE 1 CLEARED — `Stats_ExtrapolateOpponentTimes__Fi` (493 insns, PASS)

Deleting the fence: **FAIL 12 @493/493** — a uniform `$a2`<->`$a3` swap
(`position` and the y-walk giv trade homes), count already exact.

The fence existed to buy `position` refs 10 -> 16 (the `floor_log2` 3->4 step that
outranks the giv, `global.c` `allocno_compare`). The SAME +6 refs are available in
plain C via the catalog's *deliberate-arm-duplication* ref-step: writing the
comparison as its natural two arms

```c
if (A > B)                    { position++; }
else if ((A == B) && (y < x)) { position++; }
```

counts `position` FOUR times at loop depth 3 instead of two (10 -> 16 refs), and gcc's
FINAL `jump_optimize` cross-jump pass merges the two identical `addiu a2,a2,1`
back into the ONE increment retail has. **Zero instructions, zero devices.**

| form | gate |
|---|---|
| `\|\|` one-arm + read-only fence (shipped W-earlier) | PASS 493 |
| `\|\|` one-arm, fence deleted | FAIL 12 @493 (pure a2<->a3) |
| **two-arm `if / else if`, no device** | **PASS 493/493** ✅ LANDED |

Whole-file re-gate after landing: **7/7 PASS**.

## 1.2 `Stats_TrackEndGame__Fv` (232 insns) — every one of its 6 devices is
load-bearing; parked with a NEW named angle, file left PASS.

Deletion price, each device alone (authoritative gate, all restored):

| removal | gate |
|---|---|
| PIN `PlayerPosition asm("$21")` | FAIL 40 @232 |
| PIN `raceIndex asm("$22")` | FAIL 80 @232 |
| both pins | FAIL 86 @232 |
| read-only fence on `DesiredSlice` | FAIL 75 @**233** |
| read-only fence on `raceIndex` | FAIL 4 @232 |
| both read-only fences | FAIL 79 @233 |

### The hand-asm block: replaced by pure C, then re-priced (04Z basin law)
The block is retail's second `min`. Replacing it with C and re-pricing the OTHER
devices from that new basin found a **much better pure-C basin than any receipted
before** (W74's best pure-C-ish was 12 @232 and still carried a `volatile` view
plus an `'m'`-fence):

| min spelling (asm block deleted) | with all other devices | `-pin1` | `-DS fence` | `-pin1 -DS` |
|---|---|---|---|---|
| direct ternary `t < X ? t : X` | 48 @232 | 48 @232 | **10 @232** | **10 @232** |
| `sliceTotal` temp + ternary | 48 @232 | — | **10 @232** | — |
| default=`sliceTotal` override | 48 @232 | — | — | — |
| default=`trackSlices` override | 66 @**230** | 74 @230 | 62 @230 | 64 @230 |
| if/else, both arms | 114 @236 | — | — | — |
| temp + if/else | 126 @234 | — | 122 @234 | — |
| W72 `volatile`-view ternary | 126 @236 | — | — | — |
| alt-address arm / alt-address compare | — | — | 114 @236 | — |
| `^ zero` runtime-zero xor (pure C) | — | — | 114 @236 | — |
| `!(X <= t)` double-negation | — | — | 114 @236 | — |

⇒ **BEST PURE-C STATE = 10 diffs, COUNT-EXACT 232/232, with the hand-asm block,
the `PlayerPosition` pin AND the `DesiredSlice` fence all DELETED.**
(`PlayerPosition`'s pin is *exactly inert* in that basin — 48 @232 both with and
without it — so it is a free deletion the moment the block goes.)

### THE RESIDUAL, characterised exactly (the new named angle)
```
ours    lw   s7,848(v0)   nop   slt v0,a1,s7   beqz v0,L   nop            addu s7,a1,zero
retail  lw   v1,848(v0)   nop   slt v0,a1,v1   bnez v0,L   addu s7,a1,zero  addu s7,v1,zero
```
Same instruction COUNT; two independent facts:
1. ours folds the false arm's LOAD straight into the target (`lw s7,...`), retail
   loads into a caller-saved temp `$v1` and keeps the copy `addu s7,v1,zero`;
2. ours leaves the branch delay slot EMPTY, retail fills it with the *default*
   store `addu s7,a1,zero` (i.e. retail is the `default=trackSlices` override).

Writing the override in C reproduces (2) but LOSES 2 instructions (230, every
spelling): our `sched2` hoists `addu s7,a1,zero` up into a **load**-delay slot,
so `dbr` never gets it for the branch slot, and both retail `nop`s disappear.
**⇒ the angle is a sched2-vs-dbr OWNERSHIP question of one copy, not a coloring
cell** — the same family as methodology §3.25-3b (delayed-branch-filling identity)
and §3.25-3d (per-obj `-fschedule-insns` identity). Instruments that would settle
it: a per-TU `-fno-schedule-insns2` identity measurement for `stats.obj`, or the
06E `qtytrace`/local-alloc lane on the 10-diff dump. Both are orchestrator-owned.

FALSIFIED this wave (do not retry on this site): all 5 override spellings
(`>=` / `<=` / `!(<)` / via-temp / reversed ternary) — 62-74 @230, and dropping
`raceIndex`'s pin from any of them spills `trackSlices` to `20(sp)`
(153 @229); `^ zero`, alt-address spellings, double-negation — all 114 @236.

**DISPOSITION: restored verbatim, file byte-identical to its PASS state, 7/7 PASS.**

---

# 2. recon/game/common/audiotrk.cpp — 6/6 PASS -> 6/6 PASS, **ZERO DEVICES LEFT** ✅

Both devices lived in `AudioTrk_AddCustomObject` (413 insns), not `SoundTrack`.

| device | price alone | disposition |
|---|---|---|
| `'m'`-fence `__asm__("" : "+m"(se->type))` in the `type == 3` arm | **PASS 413/413** (exactly inert) | **DELETED** |
| identity fence `__asm__("" : "=r"(c) : "0"(c))` after `c = chan+i` | FAIL 2 @413 (`sw s4,0(s2)` vs `0(v1)`) | **DELETED — re-cracked in pure C** |

**The pure-C crack (new lever):** retail stores `se` through the ORIGINAL `&chan[i]`
address pseudo `$v1` (the one the `se == 0` test built) and keeps `c` as the surviving
COPY `$s2`. Assigning **`n = i` FIRST and spelling `c` off `n`** makes c's address
expression cse-DISTINCT from the `chan[i]` the test and store share, so gcc keeps both
pseudos and stores through `$v1`:
```c
n = i;
c = AudioTrk_g->chan + n;
AudioTrk_g->chan[i].se = se;
c->slice = -1;
```
FALSIFIED (all 2 @413): store-first-then-`c`; `&chan[i]` form; store-then-`&chan[i]`;
`(chan+i)->se` ptr-form store; both stores via `chan[i]`; both via `c`; slice-store
first; `chan[n]` store with `n=i` placed after. A `slot` local is 5 @414.

Final: `perl`-stripped source contains **no `asm`, no `volatile`** — 6/6 PASS.

---

# 3. recon/game/common/audiomus.cpp — 23/23 PASS -> 23/23 PASS, **ZERO DEVICES LEFT** ✅

Both devices lived in `AudioMus_GetCurrentSong` (47 insns).

| device | price alone | disposition |
|---|---|---|
| `volatile`-view read of the `AudioMus_g` pointer at the switch | FAIL 26 @45/47 | **DELETED** |
| w54-a11 identity launder `__asm__("" : "=r"(curr) : "0"(curr))` | FAIL 5 @46/47 | **DELETED** |
| both | FAIL 8 @45/47 | — |

**ONE source change retires BOTH: spell the `? :` as an `if / else` STATEMENT.**
```c
if (AudioMus_g->errorcode == 0) { curr->index = AudioMus_g->requestsong + 1; }
else                            { curr->index = AudioMus_g->errorcode; }
```
MECHANISM: gcc-2.8's cse works per BASIC BLOCK. Retail re-issues the gp-rel
`lw AudioMus_g` after the index store (oracle 8007A06C) precisely because that store
sits at a JOIN, so the cached load is not available to the next block. The COND_EXPR
is expanded/merged early enough that our build kept ONE live pseudo for `AudioMus_g`
across the whole body (45 insns, 2 short, plus an `a0`/`v1` swap on every row). The
statement form reproduces retail's block split, the reload, AND the `a0`=curr /
`v1`=g register split — and with the shape right `curr + 12` stays curr-based on its
own, so the launder is unnecessary too.

| variant | gate |
|---|---|
| volatile dropped alone | 26 @45/47 |
| volatile dropped + `curr` through a `char *` cast | 26 @45/47 |
| **if/else + volatile dropped** | **PASS 47/47** |
| **if/else + volatile AND launder dropped** | **PASS 47/47** ✅ LANDED |
| if/else + both dropped + `info` as a char*-bump | PASS 47/47 (so `&curr->info` is free) |

---

# 4. recon/game/common/audioclc.cpp — 18/18 PASS, **ALREADY DEVICE-CLEAN**

Comment-stripped source has zero `asm`/`volatile`/`&&label`. The line-670 hit in the
raw grep is a FALSIFIED-lever note inside a receipt comment. Nothing to do.

---

# 5. recon/game/common/audioeng.cpp — 9/9 PASS -> 9/9 PASS, **-4 volatile accesses**

| # | device | fn | price alone | disposition |
|---|---|---|---|---|
| 1 | read-only fence `("" : : "r"(shiftedEsp))` | AudioEng_Set | FAIL 2 @159 | KEEP (§5.2) |
| 2 | void-tail fence `("" : : "i"(0))` | AudioEng_Set | FAIL 2 @159 | KEEP (§5.2) |
| 3 | loop-head `'m'`-fence (5 operands on `vol[n]`/`delay[n]`) | AudioEng_Update | FAIL 26 @366 | KEEP |
| 4 | `*(volatile char*)&g->left[n].vol` + `*(volatile int*)&g->left[n].handle` | AudioEng_Update | FAIL 10 @366 | **DELETED** |
| 5 | same pair for `g->right[n]` | AudioEng_Update | FAIL 10 @366 | **DELETED** |
| — | 4+5 together | | FAIL 20 @366 | — |
| — | 3+4+5 together | | FAIL 46 @366 | — |

## 5.1 THE VOLATILE CRACK (4 accesses gone) — store-at-the-tail-of-each-arm
Retail STORES the ramped byte then RE-LOADS it sign-extended for the call argument:
```
sb v1,476(s0) / lb a1,476(s0) / jal SNDvol
```
A single trailing store lets gcc forward the value and sign-extend in registers
(`sll/sra`, 10 diffs @366 — count-exact both ways). Moving the store to the **tail of
each clamp arm** (it cross-jumps back to retail's single `sb`) leaves the call in a
LATER basic block, where the store-forwarding equivalence is gone and gcc emits the
`lb` reload. Same cse-per-basic-block mechanism as §3. Landed on BOTH voices; whole
file re-gated 9/9 PASS.
Control: the plain single-store form measures 10 @366; a guarded call is 72 @368.

## 5.2 `AudioEng_Set`'s two fences — 2 diffs each, pure delay-slot OWNERSHIP
Both residuals are ONE instruction changing position, count-exact 159/159:
* fence 1: retail puts `sra v0,a2,2` (esp>>2) in the `bne` delay slot, ours puts
  `li a0,49152` there;
* fence 2: retail/ours disagree on where `sra v1,s3,6` (gas>>6) is issued.

SYM `8c` for `AudioEng_Set__Fiiiiiiii` lists **only `g`, `a`, `s`** (plus REG copies of
cam/dop/azi/dir) — no esp temporaries — so retail computed the arm straight into the
call argument. That rewrite was tried and is 1 instruction SHORT:

| spelling | gate |
|---|---|
| ternary in the `fixedmult` argument (`(esp>>2)+0xc000` / `esp+0x3333`) | 7 @**158** |
| same, constant first | 7 @158 |
| if/else with the fused arm `adjustedEsp = (esp>>2)+0xc000` | 7 @158 |
| fused arm + drop fence 2 as well | 9 @158 |
| split `adjustedEsp = 0xc000; adjustedEsp += shiftedEsp;` (shipped shape), fence gone | 2 @159 |
| `adjustedEsp = shiftedEsp; adjustedEsp += 0xc000;` | 6 @159 |
| gas clamp: named temp / ternary-dup / override | 4 / 4 / 8 @159 |

⇒ retail's 3-insn arm (`sra`, `li 49152`, `addu`) REQUIRES the constant materialised
separately, which the shipped split form already gives; only reorg's choice of which
of the two independent insns to steal for the `bne` slot differs. **Same
sched2-vs-dbr ownership family as stats §1.2** — an orchestrator-owned per-TU
scheduling-identity question, not a source shape. KEPT with this receipt.

---

# 6. recon/game/common/audiocmn.cpp — 48/48 PASS -> 48/48 PASS, **-3 devices**

🔴 **PROCESS FINDING (cost one bad landing, worth banking): a per-FUNCTION gate is
not enough for a device sweep.** A first pass gated only the 4 functions a naive
line->function map attributed the fences to; 12 of 14 devices read as "inert" and the
batch landed — the WHOLE-TU gate then showed **46/48** (`AudioCmn_SoundCar` and
`AudioCmn_SFX` broken). Re-priced with `tools/tugate.py` per removal, only **3** are
truly inert. Reverted and re-landed correctly. **Always price a device on the TU gate.**

| # | device | fn | whole-TU price | disposition |
|---|---|---|---|---|
| 1 | identity fence on `setup` | AudioCmn_Init | 5 @95/94 | KEEP |
| 2 | `*(volatile int *)&audioBackwardsDirection` on the TEST read | AudioCmn_Init | 4 @92/94 | KEEP |
| 3 | 10-operand ref fence on `tweakedForce` | AudioCmn_SFX | 96 diffs | KEEP |
| 4 | 4-operand ref fence on `tweakedForce` | AudioCmn_SFX | 76 diffs | KEEP |
| 5 | 10-operand fence on `sndPlayer-0x12`/`iSFXnumber` | AudioCmn_SFX | 32 diffs | KEEP |
| 6 | 9-operand fence on `iSFXnumber`/`amplitude` | AudioCmn_SFX | 28 diffs | KEEP |
| 7 | ref fence on `slot` | AudioCmn_PlaySFX | 80 diffs | KEEP |
| 8 | ref fence on `attenuation` | (inert) | **48/48 PASS** | **DELETED** |
| 9 | ref fence on `rampedGas` | AudioCmn_SoundCar | 56 diffs | KEEP |
| 10 | identity launder on `gasDelta` | AudioCmn_SoundCar | 8 diffs | KEEP (see 6.1) |
| 11 | ref fence on `tunnelFlag` | AudioCmn_SoundCar | 3 diffs @**531**/530 | KEEP |
| 12 | ref fence on `roadProduct` | AudioCmn_SoundCar | 4 diffs @530 | KEEP |
| 13 | ref fence on `freq * doppler` | AudioCmn_SoundCar | 8 diffs @**526**/530 | KEEP (see 6.2) |
| 14 | 5-operand fence on `pitchmult` | (inert) | **48/48 PASS** | **DELETED** |
| 15 | void-tail fence | (inert) | **48/48 PASS** | **DELETED** |

The three deletions were verified inert ALONE and JOINTLY (48/48 both ways).

## 6.1 gasDelta — a hand-expanded signed /8; best pure-C is 6 diffs
Retail: `subu v0,v1,a0 / bgez v0,L / addu v1,v0,zero [ds] / addiu v1,v0,7 / L: sra v1,v1,3`
= gcc own `x / 8` idiom with a DISTINCT destination. Writing the plain divide is the
right instinct (the sibling `/128` comment in this very function says so) and gets
closest, but gcc then steals the `sra` for the delay slot and duplicates it instead of
emitting retail copy:

| spelling | gate |
|---|---|
| `currentGas = gasDelta / 8;` | **6** @530 |
| `currentGas = (currentGas - previousGas) / 8;` (no local) | **6** @530 |
| two locals gasDelta + gasStep, /8 | 10 @530 |
| copy-then-divide | 10 @530 |
| hand-expanded, fence deleted | 8 @530 |
| hand-expanded, non-compound `>>` | 8 @530 |
| hand-expanded, arms swapped (`0 <= gasDelta` first) | 8 @530 |
| default-copy + override | 8 @530 |
| `rounded` temp then `currentGas = rounded >> 3` | 6 @530 |
| **shipped identity launder** | **PASS 530/530** |

Residual = which of {the arm copy, the join `sra`} reorg steals for the `bgez`
delay slot. Same dbr-ownership family as stats 1.2 / audioeng 5.2.

## 6.2 freq * doppler fence guards a genuinely DEAD retail computation
Without it our build is **526 vs 530** — gcc DCEs a `mult s6,t0 / mflo t0` pair that
retail computes and discards (plus an s6/s7 rename). That is the catalog
"dead value the original weak optimizer never eliminated" class; a source-level
carrier would have to make the value live, which changes the program. KEPT.

---

# 7. recon/game/common/speech.cpp (+ speech_types.h) — 102/102 PASS -> 102/102, **-2 devices**

## 7.1 speech_types.h and the asm("...") hits — ALL SANCTIONED, none are devices
All 87 flagged lines in `speech_types.h` and the ~90 in `speech.cpp` are
`asm("<mangled-symbol>")` **assembler-name bindings on declarations** (method decls,
the three vtables, `Speech_fgSpeech` / `Speech_fgUndefined`) — the established
"non-builtin alias" class the AGENT_GUIDE marks allowed, not codegen devices.
`speech_types.h` comment-stripped contains **zero** `volatile`, zero `__asm__`,
zero `&&label`. **There is NO `&&label` V2 device anywhere in speech.cpp either**
(`grep '&&[A-Za-z_]'` = 0 hits) — that item of the brief is a false alarm.

## 7.2 The 11 real codegen devices, priced on the whole-TU gate
| line | device | fn | price | disposition |
|---|---|---|---|---|
| 726 | 4-output tied launder + `"$2"` clobber | LoadBankHeaders | 9 | KEEP |
| 753 | ref fence on hsize | LoadBankHeaders | 16 | KEEP |
| 797 | 2-operand ref fence on extension | LoadBankHeaders | 20 | KEEP |
| 1050 | identity launder on offset | SubmitRequest | 7 @60/**61** | KEEP (7.4) |
| 1064 | void-tail fence | SubmitRequest | **102/102** | **DELETED** |
| 1585 | identity launder + **`"$7"` clobber** on wing | DispatchSpeaker::StatusReply | 5 @268/**269** | KEEP (7.4) |
| 2067 | identity launder + **`"$2"` clobber** on branchVoice | MobileSpeaker::Status | 2 @358 | KEEP (7.3) |
| 2092 | identity launder + **`"$2"` clobber** on branchVoice | MobileSpeaker::Status | 2 @358 | KEEP (7.3) |
| 2283 | void-tail fence | DispatchSpeaker::Report | **102/102** alone | KEEP (7.5) |
| 3086 | identity launder on voiceArg | MobileSpeaker::Lose | **102/102** | **DELETED** |
| 3394 | 4-operand tied launder on confirmVoice | MobileSpeaker::Roger | 48 | KEEP |

## 7.3 THE TWO "$2" CLOBBERS (the pin-adjacent ones) — exactly characterised
Both sites, identical 2-diff:
```
ours    addu  a1,s1,v0        oracle  addiu a1,s1,8
```
`&Speaker::fColour` is at offset **8**, and the guard right above is `uVar8 != 8`, so
`$v0` already holds the constant 8; our build substitutes that register for the
address addend, retail materialises the addend. The `"$2"` clobber exists solely to
end the known-constant range of `$v0`. This is a **post-reload constant re-use**
(`reload_cse_regs` family, catalog 23B), not an address SPELLING:

FALSIFIED at site 1 (all 2 @358, count-exact): `(char *)&_base_Speaker + 8`;
`&fColour + 0`; plain (no device); Yoda compare `8 != uVar8`; hoisting `colourArg`
above the `if`; assigning `colourArg` before `branchVoice`; hoisting `colourArg`
above the `fUpdate.flags` load (that one is 4 @358).
⇒ **NEW NAMED ANGLE:** deny the constant post-reload availability without an asm —
either a compare spelling that never parks 8 in a register (`xori` + `bnez` costs an
insn) or the 06E / reload_cse instrument lane. Orchestrator-owned.
⚠️ These are hard-register clobbers; the in-source comment records them as
"user-authorized last-resort". They remain the highest-value removal target in this TU.

## 7.4 @1050 and @1585 are ONE class: retail loads to a scratch and COPIES
```
@1050  ours lw s0,0(v0)     oracle lw v0,0(v0) ; addu s0,v0,zero        (ours 60 / oracle 61)
@1585  ours lw a3,8(s0)     oracle lw v1,8(s0) ; ... ; addu a3,v1,zero  (ours 268 / oracle 269)
```
In both, **ours is one instruction SHORTER** because gcc loads straight into the final
home; retail keeps a caller-saved carrier and pays a copy. Per the catalog
"ours-1-shorter" discriminator this is the redundant-addu-from-reg-reuse sub-case =
**permuter multi-basin territory, NOT a floor**. Not attempted here (fleet rule caps
permuter jobs); filed as a named angle with the exact target shapes above.

## 7.5 A REAL CROSS-FUNCTION COUPLING between two void-tail fences (reproducible x3)
`@1064` (SubmitRequest) and `@2283` (Report) are each INERT alone (102/102), and the
pairs {1064,3086} and {2283,3086} are both 102/102 — but **{1064,2283} together break
`DispatchSpeaker::Report`**: authoritative `verify_asm` FAIL 5 diffs, ours **103 /
oracle 104** (a missing `nop` plus a `sw s0,24(sp)` / `addu s0,zero,zero` prologue
reorder). Verified deterministic over three independent runs, and confirmed on
`verify_asm` (not a `tugate` artifact). Landed the safe pair {1064, 3086}; `@2283`
kept, which is at least self-consistent (it sits inside the function it protects).
**This is a genuine falsifier for "zero-insn fences are independent" — price device
COMBINATIONS, not just singles.**

---

# SUMMARY

| TU | fns | gate before | gate after | devices before | removed | left |
|---|---|---|---|---|---|---|
| stats.cpp | 7 | 7/7 PASS | **7/7 PASS** | 7 | **1** | 6 |
| audiomus.cpp | 23 | 23/23 PASS | **23/23 PASS** | 2 | **2** | **0** |
| audiotrk.cpp | 6 | 6/6 PASS | **6/6 PASS** | 2 | **2** | **0** |
| audioeng.cpp | 9 | 9/9 PASS | **9/9 PASS** | 7 | **4** | 3 |
| audioclc.cpp | 18 | 18/18 PASS | **18/18 PASS** | 0 | 0 | **0** |
| audiocmn.cpp | 48 | 48/48 PASS | **48/48 PASS** | 15 | **3** | 12 |
| speech.cpp | 102 | 102/102 PASS | **102/102 PASS** | 11 | **2** | 9 |
| speech_types.h | — | — | — | 0 (all sanctioned) | 0 | 0 |
| **TOTAL** | **213** | **213/213** | **213/213** | **44** | **14** | **30** |

**Zero PASS->FAIL anywhere. Zero devices added. Three TUs are now fully device-free.**

## Reusable levers proven this wave (catalog candidates)
1. **Arm duplication IS the zero-insn REF-STEP in plain C** — `if (A) x++; else if (B) x++;`
   doubles the REG_N_REFS of `x` at loop depth and the FINAL cross-jump pass merges the
   two increments back. Retired a read-only fence outright (stats, a2/a3 swap, 12 -> PASS).
2. **A `? :` spelled as an `if / else` STATEMENT reproduces the retail cse BASIC-BLOCK
   SPLIT** — the pure-C substitute for a volatile-view "force the re-read" device AND for
   an identity launder compensating for the same missing split (audiomus, two devices
   retired by one edit).
3. **Store at the TAIL OF EACH ARM (not after the join) defeats store-forwarding** —
   the call in the next block emits the retail `lb` reload instead of a register
   sign-extend, retiring `*(volatile T *)` store/read views (audioeng, 4 accesses).
4. **Break a cse address equivalence by spelling the pointer off a DIFFERENT pseudo** —
   `n = i; c = base + n;` keeps `c` distinct from the `base[i]` the test and store share,
   so the store goes through the original address register (audiotrk, identity fence gone).
5. **PROCESS: price devices on the WHOLE-TU gate and in COMBINATION.** Both failure
   modes fired for real this wave (audiocmn section 6 header; speech 7.5).
