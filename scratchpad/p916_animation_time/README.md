# P916 — original `DrawW_GetAnimationTime` locals and scopes

The native source needs only `track` and an else-local `maxTick`. The former
`result` and `tick` were matching carriers, not names in SYM. A single expanded
minimum expression reproduces the compiler's own unnamed load/result values:

```cpp
return ((maxTick > animation_timer[animInst->objectIndex - 1])
    ? animation_timer[animInst->objectIndex - 1] : maxTick);
```

The candidate keeps that expression on one source line, matching the native
SLD statement. It uses no new local, helper, alias, asm, volatile or padding.
The comparison has the same operand order as the reconstructed NFS2
`match/nfs2.h` MIN macro. `match/ealib.h` contains a different equivalent
macro; neither identifies the original NFS4 macro tokens uniquely. This is
supporting sibling evidence, not an assertion that an original NFS4 header
has been recovered.

## Native evidence

SYM `3e3a12..3e3af8`, VA800C7644..800C76C8:

- `animInst`: REGPARM a0, pointer to the12-byte Trk_AnimateInst.
- `track`: root INT in a1, beginning800C7644.
- `maxTick`: INT in a1 in the else block800C7678..800C76C0.
- Exactly three block records, depths0/1/2; all end800C76C0.
- SLD1705 reads track,1711 tests guards,1712 returns gameTicks,
  1715 computes maxTick, and1716 covers the complete minimum/return.

The primary raw code loads UCHAR objectIndex at+3, SHORT count at+8 and
SHORT interval at+10. Native track is GameSetup+60; gameTicks is simGlobal+4.
IDA's body incorrectly folds track guards and returns zero; M2C/raw preserve
the actual gates and gameTicks load, so the folded IDA version is not copied.

`final_verification.json` proves **33 instructions, 35/35 whole-TU PASS,
361 branches, three exact native scopes/local homes, SLD0/73->0/0**.
The whole normal object is identical except its exact private FILE pathname;
all native owner data and ordered relocations therefore remain unchanged.
All34 neighbors preserve full debug scopes, declaration homes, line partitions
and the complete consistent branch/label graph. Later compiler code-label IDs
shift, but every C LABEL record is independently resolved to its unchanged
actual PC. No output or debug record is rewritten or broadly ignored.

## Retained experiments

| Candidate | Instructions / diffs | Disposition |
|---|---:|---|
| Before |33 /0|PASS, but two extra locals and wrong scopes/SLD|
| `scoped_min`, `scoped_minreverse` |32 /27;33 /38|Invalid macro-context probes: MIN is absent from DrawW's private type surface, so these called an undefined function. Not evidence against minimum expressions.|
| `expanded_min` |31 /34|Opposite operand order; private failure|
| `gnu_min` |31 /10|GNU `<?` diagnostic; private failure|
| `expanded_reverse` |33 /0|Code PASS but an extra explicit scope; not native-scope-valid|
| `native_min` / final comments |33 /0|Only native locals, all three scopes and SLD exact|

Frozen sources, objects, actual compiler debug outputs and per-stage gates are
kept here. Production integration is recorded separately in `../p916_checkpoint`.
Other DrawW functions still contain unresolved source information; this is not
a whole-TU original-source completion claim.
