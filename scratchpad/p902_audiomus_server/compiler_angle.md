# P902 AudioMus_Server: anonymous constant reuse angle

Read-only compiler/reference review, 2026-09-12. No compilation, object changes,
production edits, or verification-tool changes were performed by this reviewer.
The only reviewer-created file is this receipt. All match scores below come
from the root agent's saved receipts, not an independent re-gate.

## Evidence and limits

Target: `AudioMus_Server__Fii`, retail `8007A3D0..8007A87F` (300 words).
`C:/Temp/nfs4-clean/nfs4-f-v3.txt` record `19f34b` gives frame 40,
mask `800f0000`, native lines 407..542. Its complete local/block record set is:

- `19f39a`: `mode`, INT, REGPARM 4.
- `19f3ac`: `ticks`, INT, REGPARM 5.
- `19f3bf`: root block starts `8007A3D0`, relative line 1.
- `19f3c8`: root block ends `8007A864`, relative line 136.
- `19f3d1`: function ends `8007A880`.

There is no ordinary local declaration corresponding to `switchMode`.
Reusing either parameter merely to carry the constant would not establish
original source identity: the native parameter homes are a0/a1, not s0.
The absence of a named local does not prohibit an anonymous compiler pseudo.

The raw oracle `asm/nonmatchings/main/AudioMus_Server__Fii.s` shows:

- `8007A5BC`: load `switchsong` into v0.
- `8007A5C4`: branch on zero; its always-executed slot at `8007A5C8`
  loads s0 with 2.
- `8007A5CC`: compare v0 against s0; non-equal reaches the default arm.
- `8007A6E8`: call `AudioMus_QueueRequestedSong`; `8007A6F8` stores s0
  into the freshly reloaded `AudioMus_g->switchsong`.

Native SLD `19e008` assigns `8007A5B4..8007A5CB` to line 480;
`19e00e` starts line 482 at `8007A5CC`. `19e09a/19e09f` assign
`8007A6F0..8007A6FB` to line 520. These are distinct tests followed later
by the state assignment, not evidence for one switch statement or a named
constant declaration.

`before.json` records all 23 TU functions exact, Server 300 words/58 branches.
`native_switch.json` records 16 instruction-line differences at the same
300 words/58 branches: the comparison uses a temporary constant, and the
post-call store rematerializes 2. The reviewer read both receipts.

Root subsequently removed `randomRange` and `randomMusic` together and restored
structured control flow in `duplicate_time_tail_source.cpp`. Its frozen SHA256
is `0ab03e4251c673b3f841248d78a7dbd29845e5581d12bacabd4404da6853afdb`.
Root reports all 23 functions/206 branches unchanged and SLD 39 merges/29
splits. These newer results supersede the old one-at-a-time random-expression
comments, but do not solve `switchMode`.

## Concrete GCC mechanism

Paths in this section are relative to
`C:/Temp/gcc-2.8.1-src/extracted/`. This is explanatory compiler-source
evidence; the source version is not asserted to be a byte oracle for CC1PLPSX.

1. `config/mips/mips.c:2203`, `gen_conditional_branch`, handles a nonzero
   integer EQ/NE comparison by `force_reg(mode, cmp1)` at lines 2233..2237.
   Therefore an ordinary literal comparison itself creates an anonymous
   constant pseudo. It does not need a declared C local.
2. `cse.c:1756`, `invalidate_for_call`, removes call-clobbered **hard**
   registers. Its loop stops at `FIRST_PSEUDO_REGISTER`. At lines 7406..7415,
   non-constant calls invalidate memory separately, then call this routine.
   A surviving pseudo holding 2 is not inherently invalidated by a call.
3. `cse.c:8189`, `cse_end_of_basic_block`, limits equivalence propagation by
   the pre-allocation control-flow graph. At lines 8272 onward, following a
   conditional target requires one label use and a preceding barrier, or a
   permitted label-free skipped block. `cse_basic_block:8614` calls
   `new_basic_block()`; a new region resets the available equivalences.
   Equal final branch words therefore do not establish equal CSE regions.
4. `config/mips/mips.h:2896` prices CONST_INT at zero, while `cse.c:488`
   prices ordinary pseudos at one. `cse.c:6873..7022` tries cheaper equivalents
   but requires a valid instruction. This makes context important: a constant
   can remain a literal at a register definition, while a nonzero memory
   store needs a register form. Do not infer reuse merely from equal values.
5. If constant reuse actually extends a pseudo across calls,
   `global.c:920..923` excludes `call_used_reg_set` for a call-crossing
   allocation (ordinary allocation path). This explains a possible route to
   s0, not proof that this target takes that route in its current RTL.

## Source-supported path and measured result

The updated independent M2C body is
`C:/Temp/nfs4-clean/Binaries/NFS4-B-USA/c/func_8007A3D0.c`.
It has a nonzero outer state test, then a state-equals-2 test, then a default
arm positively guarded by outstanding requests being zero **or** stream
volume being zero. IDA at
`C:/Temp/nfs4-clean/nfs4-psx-IDA.c:65289` presents the same positive default
guard. IDA's folded `MEMORY[...]` bases and decompiler local names are not
original declarations. The PC map `pcmap/map_a5.txt:196` marks AudioMus_Server
not found / PSX-only; no matching NFS2 beta `AudioMus_Server` or `switchsong`
source was found in the bounded name search.

The reviewer proposed this ordinary-source shape from root's structured
checkpoint; root then tested it successfully:

```cpp
if (AudioMus_g->switchsong != 0) {
  if (AudioMus_g->switchsong == 2) {
    /* Existing state-2 body, unchanged. */
  } else if (AudioMus_g->streamstatus.outstandingrequests == 0 ||
             SNDSTRM_getvol(AudioMus_g->streamhandle) == 0) {
    /* Existing purge/songname/fadetime/queue/default body, unchanged. */
    /* Its state assignment uses the literal 2. */
  }
} else {
  /* Existing zero-state body, unchanged. */
}
```

This is specifically a positive work guard instead of the current default
arm's negative early-return guard. It preserves short-circuit call behavior,
adds no identifiers, and is independently supported as a control-flow shape.
The compiler reason to test it was its different pre-CSE continuation/label
structure. Preserve the fresh
global reload after QueueRequestedSong; no field value from before that call
can simply substitute for the required constant.

Root's saved `positive_default.json` now records:

- Source snapshot `positive_default_source.cpp`, SHA256
  `9aedda55f3a8bcd30a0f4192562ec06af6374b9f40cc27e42c6e76faa9f7a10a`.
- All 23 TU functions at zero differences; Server 300 instructions and
  58 branches, all 206 TU branch offsets unchanged.
- Normal object SHA256
  `f0337aeec96d8b0793110b63e483981d0d3aefa8fcb73aa5f3b1bbab2e2da836`,
  identical to the original `before.json` object; empty per-TU flag map.
- Debug twin text exact; whole normal object identical to before.

The reviewer read the saved gate and the Server entry of
`positive_default_inspection.json`. That entry records SLD 39 merges/170
splits before, 39/29 after, with no new merge/split pairs. The sole remaining
source declaration in the root block is `done` (SCL 6 label); there are no
ordinary local declarations. Root reports native parameters remain intact.
Thus all three synthetic carriers are removed in this successful isolated
candidate. The original `li s0,2` and post-call `sw s0` are preserved without
`switchMode`; the literal-only and ordinary-switch negative results did not
close the source-shape path.

This is a measured source-level result, not a complete instrumented CSE trace:
the exact RTL path decisions have not been dumped by this reviewer. It does
not prove every spelling/token was the original source, and the remaining SLD
pairs plus the `done` label must not be called fully SYM/SLD-exact. Production
landing and final regression remain root's responsibility. This review found
no original-source local or macro that licenses keeping/renaming `switchMode`,
and establishes no necessity or floor.
