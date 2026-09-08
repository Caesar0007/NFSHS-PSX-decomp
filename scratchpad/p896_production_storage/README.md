# P896 final actual-production storage proof

2026-09-09. Read-only audit after root's completed full build. This uses the
**actual** `build/recon/game/common/ai.cpp.o` and
`build/gen_ld/recon_multdef-ok.{elf,map}`, compared with the frozen pre-P896
baseline and full-owner scratch probe. No compilation, linking, production edit,
instruction/label rewrite, or historical report overwrite was performed here.

## Actual linked code and native storage

**AI_AddCollidableObjects is127/127 raw words exact** at8005972C..80059928.
This comparison reads the final linked section bytes against `rom/nfs4-f.exe`:
no branch, relocation, register, or call-target normalization is used.

That includes all eight corrected local-static reference words:

- firstTime GP references at8005972C and8005975C target8013C54C.
- spos HI/LO references at80059764,8005976C,80059774,800597A8,800597B4,
  and800598E4 target8013DEE0.

Native storage is validated independently:

- `.sdata` first16 bytes are exactly
  `01000000000000000000000000000000`, hash
  `4cbbd8ca5215b8d161aec181a74b694f4e24b001d5b081dc0030ed797a8973e0`.
  LOCAL CHAR firstTime.53 occupies offset0; AI_time/AI_elapsedTime/AI_iTime
  retain offsets4/8/12 and native addresses8013C550/554/558.
- LOCAL spos.52 is the132-byte native BWorldSm_Pos reservation at8013DEE0,
  output `.ai_spos`, true NOBITS/NOLOAD, ending8013DF64.
- `_gp` and `__sdata_org` both equal8013C54C.
- Both canonical raw inputs r00 and o00 are excluded from the recon response
  file; their source/oracle files remain intact.
- All **19 initialized owners and4 zero owners** pass the current production
  validators on the actual build objects.

Input/output hashes:

- Actual AI object:
  `fc4c0ccb670846f42b8a01047c0b8b5f5d66b5bdb07f7df56ba94a0836432084`.
- Actual generated ELF:
  `52800553415581618c04766bca85e3d943de8343f60b78c62ff7c62af9e32ae0`.
- Actual generated map:
  `abd155f7d3502b1ebd10a307bfc5e87905ee0caa609179af0de3014edbde2c32`.

## Complete GP and native-global nonregression

The current audit scans518 live sources /78 GP-using objects:

- **2381/2381 GP relocations** resolved and encoding-checked.
- **0** overflow, unresolved target, or in-range encoding mismatch.
- 2378 native/raw-known targets; **3 remain unknown**.
- Wrong-target count **1430 ->1428**, exactly the two firstTime references fixed.
  This is the frozen current baseline, not the older1433 historical count.
- Four pre-existing native/raw disagreements remain explicitly reported.
- All **948 baseline-correct GP rows** and **3779 previously correct uniquely
  mapped native global bindings** remain correct. All950 correct rows from the
  intermediate probe are preserved too. No correct-binding regression is hidden
  behind the aggregate improvement.

The JSON retains every changed GP target and global binding, including movements
among already-unresolved/wrong catch-all addresses.

## Comparison with the proven full-owner probe

After the explicitly allowed `.ai_spos_bss -> .ai_spos` output-section rename:

- Every allocated section has identical address, type, flags, extent, alignment,
  entry size, and initialized payload (or NOBITS reservation).
- Every non-FILE symbol matches by its complete name/value/size/binding/type/
  normalized owning-section tuple; duplicates are preserved as a multiset.
- All **14 program headers** retain identical ordered type, virtual/physical
  address, initialized/memory extent, flags and alignment. ELF machine/entry/
  semantic flags also agree. Physical metadata/file offsets are not instructions.
- Exactly one FILE symbol differs: the scratch AI source path becomes the actual
  `recon/game/common/ai.cpp` path. Both exact paths and unchanged FILE attributes
  are checked; other FILE changes are not broadly ignored.

Thus the actual generated link reproduces the tested storage semantics, not only
the isolated candidate's normalized code gate.

## Remaining layout qualification

This is **not a fully native or overlap-free project link**. The measured owner
fix leaves the existing oversized `.data`, `.sdata`, and `.tail_data` overlapping
all132 bytes of native spos storage. Overlap pairs are130 before versus133 after,
the same qualified result as the full-owner probe. No initialized bytes are
invented or read from the NOBITS file offset.

Actual catch-all changes agree with the probe: cursor remains8013ECEA;
`.sbss` at8013ECEC shrinks1C8->1C4; generic `.bss` starts8013EEB4->8013EEB0 and
shrinks44A8->4424; `.data_rest` starts8014335C->801432D4 and shrinksEC74->EC68.
These previously unresolved placements remain explicit debt, not padded away.

## Receipts

- `production_gp_audit.json`: exhaustive actual linked GP/raw audit.
- `production_storage_receipt.json`: all127 raw words, eight static references,
  storage contracts, binding comparisons, complete probe-semantic comparison,
  overlaps and catch-all shifts.
- `gp_audit.py`: current read-only audit cloned with only its output redirected.
- `verify.py`: consumes actual production inputs plus frozen probe receipts and
  writes only this directory's storage receipt.

All required checks completed. No next source or layout probe was started.
