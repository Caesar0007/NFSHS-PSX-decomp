# P892 source/SLD result: initializer improves; other consumers preserved

Native Initialize block `710365` / `80048A2C` records only this/register16, no caller local. It also contains two zero-length nested block pairs at entry, whose original inline identity is not recovered. The old reconstruction's semantic helper added a named `tick` local and another named `this` record; those names are not present in that native block.

The retained direct field initialization captures the entry tick before the state writes. All49 instruction words remain exact. The source gives the four state stores individual statements instead of attributing them through the unproved inline helper.

## Before versus retained final initializer

Pair definitions: a merge is two instruction indices from different native lines that current debug groups on one source line; a split is two indices from one native line assigned to different current lines. They are attribution pairs, not byte diffs.

| Measure | Before | Final | New bad pairs |
|---|---:|---:|---:|
|Native-line merge pairs|24|0|0|
|Native-line split pairs|33|32|0|

The improvement separates native389/390/392/393 state stores from the entry/prologue grouping and puts the native390 constant/store pair together. All24 old merge pairs and one split pair are removed; no previously-correct pair becomes wrong. Complete indices, source/native line tuples and declaration records are in `after_init_sld.json`.

The compiler no longer reports the helper's REG `tick` or inlined REG `this`; only the real receiver and the pre-existing manual `vtbl` carrier remain. The `vtbl` issue was not changed by this round.

**Remaining qualification:** the native two empty inline block pairs are now absent from the flat field body. Their original identity is still an explicit recovery question; deleting an invented helper does not recover that missing source information. The32 remaining split pairs also prevent a full emitted-SLD-exact claim. We did not invent an empty macro, block wrapper or replacement helper to manufacture those records.

## Restored DrawBackground and ProcessInput paths

The scalar ticks experiment and spinTicks removal were reverted because they changed retail code. Their final native/current partition equivalence classes are unchanged:

| Method | Merge pairs before → after | Split pairs before → after | New merges/splits |
|---|---:|---:|---:|
|DrawBackground|140 → 140|201 → 201|0/0|
|ProcessInput|0 → 0|40 → 40|0/0|

Their parameter/local records are unchanged after ignoring only the compiler-generated numeric suffix of the same static `carRotate` symbol. `spinTicks` remains an unrecorded source carrier; no claim that it is original was added. Exact comparisons are in `other_sld_receipts.json`.

Only base NFS4 native SLD is used here. USA/JPN verification uses their own raw code/reference maps and exact debug-code twins, not a nonexistent independent regional native-SLD record set.

Reproduce read-only with `compare_init_sld.py after` and `compare_other_sld.py`, using the preserved isolated before/final objects. No production objects or instruction output are rewritten.
