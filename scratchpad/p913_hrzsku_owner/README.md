# P913 HrzSku native data owner — verified private proposal

The survey found 67 extra `.data` inputs, totaling 22,487 source bytes plus
5 alignment bytes beyond the native initialized-data end. Larger entries
include composite vtables, reordered/relocated ScreenController data and
DrawW's mixed data/small-data storage. HrzSku is the largest immediately
coherent relocation-free whole owner: nine native objects, 1,580 bytes.
Survey: `../p913_data_inventory/survey.json`.

## Native storage and source fidelity

SYM 40f50b..40f65d gives nine GLOBAL arrays/structs at 801202F8..80120924.
The current source already has exact order, types, dimensions and offsets.
Its `.data` section is PROGBITS, flags 3, alignment 4; all 1,580 bytes equal
ROM and complete CPE loads. The relevant active header layouts, including
`tHrz_LightningFork` and `tHrz_Lightning`, match native field/dimension records.
No C body, declaration, header, compiler flag or alignment was changed.

Whole-TU gates: **22 PASS / 170 branch checks**. An isolated actual-path
recompile is literally the normal object, and exact-g `.text` is equal.
The old source header describes the wrong module and its `bss(zero)` comments
misclassify CPE-loaded data; those comments are not used as source authority.

The appended strict owner row validates all nine exact symbol contracts,
payload, flags, visibility, alignment and absence of data relocations. All
1,765 controls pass: 19 valid cases accepted, 1,746 malformed cases rejected,
including a mutation of every payload byte. All 38 old rows and all helper
predicates remain unchanged; the new registry has 39 rows. The initial test
adapter assumed every member was an array; it was corrected to honor the
native scalar `tHrz_Lightning` record, not by changing a validator predicate.

## Exact raw split and references

Only `.data.r15_pre` is retired from reconstruction. It becomes the new
`data_hrzsku_legacy.data.s` oracle leaf. The 1,040-byte `.data.r15_post`
stays in r15, at the same native address, with all seven symbols and all six
R_MIPS_32 language-string pointers unchanged. Every byte, symbol and
relocation from the original 2,620-byte two-section input is preserved.
The earlier 668-byte HUD oracle remains separate and untouched.

All **50 native reference words** match raw ROM: 25 HI16 and 25 LO16.
No foreign owner reference exists. The three unused raw aliases
`D_80120664`, `D_801207F8`, `D_80120838` disappear only from reconstruction;
src/oracle retains them. The suffix's six pointer words and full linked
1,040-byte payload remain equal to baseline and ROM.

## Full private preservation

Private ELF:
`df44e37f2f9e30341f86e9ce30be5d3596ee7a5b6683988b150745574f0628f5`.
Map:
`31686be69613afe2c383866f76d7363591b9842c710bbba908e33625940729dc`.

All 695 original objects remain unchanged; 694 are retained literally and
the raw r15 object is replaced by the proven suffix object. Across all 466
executable input sections / 249,505 words, the 751 changed words are exact
existing relocations: 726 LO16 and 25 HI16. Both old/new encodings are
calculated from their actual symbols/addends; no other instruction bits change.

All 3,887 previously native public records, 109 FILE-qualified LOCAL records,
3,238 native function records and all 2,381 GP targets/statuses are preserved.
Nine HrzSku addresses become native without altering their other symbol
metadata. Allocated size falls by 1,580 bytes, with no new overlap or code
movement. Later unanchored legacy data moves backward by 1,580 bytes; exact
section changes are recorded. Existing unrelated layout/source/SLD debt remains.

Both private standing relink lanes are green. The first private-path run
classified three inherited Night/raw duplicates as REAL because the proven
raw suffix lived under scratchpad rather than `build/asm`. It remains frozen
in `relink_initial.py` / `relink/`. The final adapter maps only that exact,
hash-verified raw input's classifier spelling to its intended production path;
link inputs, symbol records and duplicate rows are unchanged. No duplicate,
target or geometry exemption is used, and no production tool was modified.

## Handoff

`proposed.patch` / `apply_manifest.json` contain five files: the strict owner
row, recon fragment, src linker selector, retained r15 suffix and new oracle
leaf. Normal `gen_ld` uses the persistent fragment and owner registry; src
uses its explicit preserved raw selector. As with the prior P910 raw split,
the committed split/selector metadata must be retained when regenerating raw
splat output; this is not a claim that unmodified splat recreates custom splits.

Parent must assemble the actual raw paths and regenerate/recheck the real
image before integration. No private object, linker or image is copied back.
No production, normal-output, source/header or Git write was performed here.

Receipts: gate.json, guard_controls.json, raw_proof.json, references_inventory,
references_proof/results.json, both GP audits, preservation.json and
relink_private.json. Source-name/SLD debt outside these exact data contracts
is not declared complete.
