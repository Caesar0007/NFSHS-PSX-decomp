# P903 SoundCar: dead product and ordinary-source next angle

Read-only compiler/raw/reference review, 2026-09-12. No objects were built and
no production files were edited by this reviewer. Only this receipt was added.

## Raw bytes and liveness

Target `AudioCmn_SoundCar__FP8Car_tObjiiiiiii` is native `800788BC`.
A read directly from `rom/nfs4-f.exe` at file offset `0x69684` returned:

```text
80078E84: 8FA80064  lw t0,100(sp)
80078E88: 00000000  nop
80078E8C: 02C80018  mult s6,t0
80078E90: 00004012  mflo t0
```

These bytes agree with
`asm/nonmatchings/main/AudioCmn_SoundCar__FP8Car_tObjiiiiiii.s`.
They compute the low 32 bits of `freq * doppler`.

The result is not read along either continuation before a mandatory call:

- Road-noise nonzero path overwrites t0 at `80078ED8` with azimuth, then
  calls `AudioCmn_PlaySFX` at `80078EE0`.
- Road-noise zero path reaches `freeVoiceChannel` at `80078F04`, with no
  use of t0 in its argument setup. That call is an ABI clobber boundary.
- All subsequent explicit HI/LO consumers follow their own mult/div.

Thus the product is dead as an ordinary C value under the project ABI. It is
not a missing seventh argument: t0 is overwritten on the PlaySFX path and
the real six-argument setup is visible. No source field store consumes it.

## Native debug ownership

`C:/Temp/nfs4-clean/nfs4-f-v3.txt` function record `192e19` gives frame 88,
mask `c0ff0000`, source lines 1908..2190. `freq` is INT REG22/s6 at
`192f5d`; `doppler` is INT ARG12 at `192ebb`. The complete local list has
no ordinary local for this product.

SLD `1903d1` assigns `80078E84..80078E93` to native line 2141. The following
statement starts at `80078E94`, line 2145 (`1903d7`). This supports one
distinct source expression at 2141, but does not reveal its exact spelling.

## Why a plain dead assignment is deleted

Compiler source under `C:/Temp/gcc-2.8.1-src/extracted/`:

- `flow.c:1405..1420` computes `insn_is_dead` with `insn_dead_p` and rejects
  deletion only for `INSN_VOLATILE`; the final pass turns dead instructions
  into deleted notes.
- `flow.c:1619..1704`, `insn_dead_p`, checks register liveness and special
  fixed/global hard registers. It does not exempt a named C local or consult
  debug information. In a PARALLEL, CLOBBER and USE parts do not independently
  make a dead SET worth retaining.
- The only `REG_USERVAR_P` occurrence found in flow.c is at line 1177 in a
  disabled setjmp-related block, unrelated to this deletion decision.
- Complete GCC source
  `C:/Temp/nfs4-decomp/scratch/gccsrc/gcc-2.8.1/config/mips/mips.md:1024`
  defines ordinary `mulsi3`; its `mulsi3_internal` at 1057 is a pure MULT SET
  plus scratch clobbers, not a volatile operation.

Therefore `freq *= doppler;` does not gain preservation simply from the
native variable name. Root's `native_freq_assignment.json` independently
measured 526 instructions/8 differing lines from a 530-word PASS baseline.
Its diff deletes exactly the four-word sequence above and exchanges s6/s7
for the later wet-noise-frequency value. Source SHA256:
`1fee0aa0bde3b87fe153d839c082f674bf1128dab5fb3b24c286415a6499635f`.
This reviewer read the saved receipt, but did not re-run the gate.

## A bounded late-deletion source hypothesis

The compiler sources expose a more useful angle than synonyms for plain
`freq *= doppler`: a product that is live during flow because it feeds a
conditional, whose now-empty conditional is removed only later.

- `toplev.c:3375` runs flow before combine, allocation/reload and sched2.
- `toplev.c:3541..3548` explicitly runs final jump optimization to remove
  jumps-to-next left by dead-store elimination.
- `expr.c:6519..6593` expands MIN/MAX through conditional branches if no
  target min/max instruction is available; no such MIPS pattern was found.
- `jump.c:3443..3559` deletes a redundant jump and recursively deletes
  computations using REG_DEAD notes. That backward search only crosses
  preceding INSNs; labels/calls or a SEQUENCE stop it. Certain SET checks use
  exact RTX destination identity. These are concrete opportunities for a
  late leftover, not proof this retail site used one.

A bounded ordinary-source hypothesis is a discarded final pitch clamp, for
example `freq = MIN((freq * doppler) / 0x10000, 127);`, using only native
`freq`/`doppler` and the already-existing MIN macro. The specific limit and
spelling are NOT recovered source facts. Test against the direct assignment,
then inspect whether the product survives late jump cleanup and whether its
four native words return. Do not keep a nonmatching or unsupported clamp
merely because it creates dead work.

An ABS builtin is a different route: MIPS `abssi2` is one pure RTL SET
(`mips.md:1800`) whose printed branch is internal to its instruction template;
the ordinary dead SET test can delete it wholesale. It is not evidence for
the same pre-flow conditional mechanism.

## Corpus checks and unresolved identity

- NFS2 beta matched
  `C:/Temp/nfs2-clean/pc-beta/match/audiocmn/AudioCmn_SoundCar.c:46..50`
  clamps native freq to 0..100, and later uses it in real SNDpitchbend calls.
  This is a related pitch-clamping idiom, not the original NFS4 line 2141;
  that function has no doppler parameter.
- NFS4 PC mapped SoundCar is `sub_42D2E0` at
  `C:/Temp/nfs4-clean/nfs4-pc.c:49653`; its later engine path differs and
  does not expose the PSX dead-product statement.
- Updated M2C
  `C:/Temp/nfs4-clean/Binaries/NFS4-B-USA/c/func_800788BC.c` omits the dead
  product; it cannot explain its original source form. Split JEB is an error
  stub.
- Bounded searches of the NFS2 matched tree, four sound-helper trees, and
  canonical PsyQ extracted headers found no exact `freq*doppler` source
  line or fixedmult macro matching this two-instruction dead result.

No authentic EA expander/macro has been identified here. A hypothetical late
call expansion must not be recorded as fact or reconstructed with a new asm
helper. The late-deletion/clamp route remains a source-level investigation,
not a necessity/floor conclusion. Other SoundCar carriers were not expanded
into this bounded review.

## Follow-up: successful diagnostic, insufficient original-source provenance

Root tested `freq = MIN((freq * doppler) >> 16,127);` in
`native_freq_shift_clamp_source.cpp`, SHA256
`4efb513ce867902a3423d6f8080b45887efa427a5a9ccad37a524dc557d0b4c8`.
Its `native_freq_shift_clamp.json` records target 530 words/zero differences,
all 48 TU functions and 513 branches unchanged, and normal object SHA256
`1617d9ddfe2c11f870e207bcb3e299d6a878541a1db6289e9372f1f72d095102`,
identical to before. Root reports the signed `/65536` variant instead kept
a rounding prefix (534 words/6 differences). These are root's measured
results, not reviewer builds.

The reviewer additionally checked the actual saved compiler debug stage:

- `native_freq_shift_clamp/debug/diffsrc/scratchpad/p903_audiocmn_soundcar/inputs/base/audiocmn.cpp.g.s`
  line 10059 gives `.def freq; .val 22; .scl 4; .type 0x4` in the native root
  block. Frame88/maskc0ff0000 and the argument records are retained.
- At line11145, `.loc 1 1905`, LM902 emits just the doppler load, #nop,
  `mult $22,$8`, and `mflo $8`, followed by the next source line1907.
- `native_freq_shift_clamp_inspection.json` maps native2141 exactly to source
  line1905 and indices370..373. SLD counts remain37 merges/319 splits, with
  no new pairs; the native freq owner is exact.

Further source-corpus evidence supports the **general semantic plausibility**:
NFS2 beta `match/audioclc/AudioClc_SoundCloseCar.c` and
`AudioClc_SoundPlayersCar.c` multiply frequency by a Q16 Doppler factor and
divide by65536. `match/audiocmn/AudioCmn_PlaySFX.c:13..14` bounds its input
frequency to0..127. But NFS2 SoundCar itself bounds freq to0..100; the NFS4
reconstruction's earlier native-shaped bound is0..150. No exact final
SoundCar clamp127 or arithmetic-shift spelling was recovered.

**Recommendation: retain this as a diagnostic receipt, not a production
source-restoration fix.** It proves an ordinary-source compiler path can emit
the retail unused product without an asm input. It does not prove the removed
shift, comparator, bound127, or final assignment existed in the original.
Those operations have no surviving machine effect, so neither byte PASS nor
the four-word SLD group can identify them. Landing the proposed expression
without stronger provenance would substitute another unproved codegen
carrier for the old one. No further source probes were performed by the
reviewer; root chose to freeze this route rather than claim original intent.
