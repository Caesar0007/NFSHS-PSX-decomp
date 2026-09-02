# R04 detail — rows 1 and 2, `game/common/r3dcar` @ NFS4-R-USA (appendix to R04_receipt.md)

Candidate `regiondiff/recon/NFS4-R-USA/game/common/r3dcar.cpp`, seeded as a verbatim copy
of `recon/game/common/r3dcar.cpp`. Both rows share this one file.

Seed measurement (`-` ours / `+` USA oracle):
```
R3DCar_InsertCarFacetII__FP8Car_tObj                 FAIL 13 diffs (ours  379 / oracle  382)
R3DCar_InsertCarFacet__FP8Car_tObjP13DRender_tView   FAIL 71 diffs (ours 1144 / oracle 1159)
```

## Row 1 — `R3DCar_InsertCarFacetII__FP8Car_tObj` — REGION-PASS (382 insns)

**Regional delta, one line: the retail detail-3 branch sets envmap bit `0x4` instead of
`0x20`, and nudges two INDIVIDUAL part indices (`0x24` by `+0x14`, `0x25` by `+8`)
instead of the base's `i - 0x27U < 2` pair-range nudge of `-0x10`.**

Seed diff read: ours `addiu v0,s0,-39; sltiu v0,v0,2; beqz` + `ori a0,a0,32` +
`addiu t0,t0,-16`; oracle `li v0,36; bne s0,v0` … `li v0,37; bne s0,v0` +
`ori a0,a0,4` + `addiu t0,t0,20` / `addiu t0,t0,8`. Confirmed against
`regiondiff/m2c/NFS4-R-USA/R3DCar_InsertCarFacetII__FP8Car_tObj.c`
(`var_a0 |= 4; var_t0 = -var_t0; if (var_s0 == 0x24) var_t0 += 0x14;
if (var_s0 == 0x25) var_t0 += 8;`) and against the oracle at 800B3294-800B32B4.

Fix (one edit, first try):
```c
if ((carObj->render).detail == 3) {
  envmap = envmap | 4;
  offset = -offset;
  if (i == 0x24) { offset = offset + 0x14; }
  if (i == 0x25) { offset = offset + 8; }
}
```
Two separate `if`s (not an `||` or a range test) reproduce the oracle's two `bne`s; the
`negu` stays in the first `bne`'s delay slot on its own.

```
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/common/r3dcar.cpp R3DCar_InsertCarFacetII__FP8Car_tObj --lane-as=recon/game/common/r3dcar.cpp
  R3DCar_InsertCarFacetII__FP8Car_tObj: REGION-PASS (382 insns) [NFS4-R-USA]
```

## Row 2 — `R3DCar_InsertCarFacet__FP8Car_tObjP13DRender_tView` — FAIL 6 (oracle artifact)

**Regional delta, one line: at detail level 3 the retail link shifts the X of parts
`0x27`/`0x28` by `+/-0xccc` before the part translation is made parent-relative.**

Oracle 800B1520-800B1544:
```
lh   $v1,2242($s5)          ; carObj->render.detail  (+0x8C2)
lw   $a0,4($a2)             ; obj->translation.x
bne  $v1,$v0,.L800B1548     ; $v0 == 3 on every incoming path
li   $v0,39
bne  $s4,$v0,.L800B153C
li   $v0,40
addiu $a0,$a0,3276
.L800B153C:
bne  $s4,$v0,.L800B1548
nop
addiu $a0,$a0,-3276
```

Fix — one new block-local (`int partX;`, declared right after `suspensionOffset`) plus:
```c
partX = (obj->translation).x;
if ((carObj->render).detail == 3) {
  if (i == 0x27) { partX = partX + 0xccc; }
  if (i == 0x28) { partX = partX - 0xccc; }
}
tmp.x = partX - parent.x;
```
That single edit took the function 71 -> 6 diffs and 1144 -> 1153 instructions; it also
cleared the whole `a1`/`a2` and `a0`/`a1` rename cascade in the diff (the extra live value
re-colours `obj` to `$a2` and `suspensionOffset` to `$a1`, exactly as the oracle has them).

### The residual 6 diffs are ORACLE-GENERATOR ARTIFACTS, not code differences — PROVEN

```
+ lui t0,0 / + addiu t0,t0,0
+ lui a3,0 / + addiu a3,a3,0
+ lui v0,0 / + addiu v0,v0,0
```
`regionrecon`'s jump-table resolver injects a synthetic `lui/addiu %hi/%lo(jtbl_…)` pair
immediately before each `jr $v0` dispatch so the m2c-dialect slice assembles. Those lines
are the ONLY lines in the slice with no `/* VA word */` prefix:
```
grep -vn "^/\*\|^\.L\|^glabel\|^\.set\|^$" regiondiff/oracles/NFS4-R-USA/R3DCar_InsertCarFacet__FP8Car_tObjP13DRender_tView.s
  576:  lui   $t0,%hi(jtbl_80056BCC)      732:  lui   $a3,%hi(jtbl_80056C24)     1048:  lui   $v0,%hi(jtbl_80056C3C)
  577:  addiu $t0,$t0,%lo(jtbl_80056BCC)  733:  addiu $a3,$a3,%lo(jtbl_80056C24) 1049:  addiu $v0,$v0,%lo(jtbl_80056C3C)
```
The three real materializations are already in the stream at 800B1028/102C,
800B1038/103C and 800B16D8/16DC, and our object matches all of them (they never appear
in the diff). Decisive count:
```
grep -c "^/\* 800B" regiondiff/oracles/NFS4-R-USA/R3DCar_InsertCarFacet__FP8Car_tObjP13DRender_tView.s
  1153
```
1153 real oracle instructions == our 1153 instructions, and the 6 unmatched lines are
exactly the 3 synthetic pairs. **The reconstruction matches the regional build's real
instruction stream in full.**

⚠️ GENERAL CONSEQUENCE FOR THE PIPELINE: any regional row whose function contains a
`jr`-dispatched switch carries a **2-diff-per-jump-table floor** in `verify_region.py`
that no source change can clear. Tool edits are out of scope for wave agents, but the
gate could mask lines that lack a VA prefix (or the manifest could carry an expected-
artifact count per row). Three jump tables here = a 6-diff floor.

```
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/common/r3dcar.cpp R3DCar_InsertCarFacetII__FP8Car_tObj,R3DCar_InsertCarFacet__FP8Car_tObjP13DRender_tView --lane-as=recon/game/common/r3dcar.cpp
  R3DCar_InsertCarFacetII__FP8Car_tObj: REGION-PASS (382 insns) [NFS4-R-USA]
  R3DCar_InsertCarFacet__FP8Car_tObjP13DRender_tView: FAIL 6 diffs (ours 1153 / oracle 1159) [NFS4-R-USA]
```
