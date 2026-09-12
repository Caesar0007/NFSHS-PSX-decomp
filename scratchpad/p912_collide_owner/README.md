# P912 Collide registry — verified isolated owner proposal

The existing source `BO_tNewtonObj *Collide_gRegistry[16]` is the complete
64-byte array at native 80110C30..80110C70. SYM 21e793 gives public EXT,
array-of-pointer shape and 16 elements. Pointee size 576 is not array storage:
the 16 pointers occupy 64 bytes.

Source `.data`, raw r07, ROM, CPE and the private linked owner agree for all
64 bytes. It is CPE-loaded PROGBITS, flags 3, alignment 4, not inferred BSS.
No new storage, aliases, padding, C body/header/flag changes or instruction
rewrites were introduced. The source's historical `bss(zero)` comment remains
misleading; this proposal does not use it as authority.

## Verified checks

- All 14 functions PASS; all 716 branch checks agree. An isolated actual-path
  recompilation produces the normal object literally; exact-g `.text` is equal.
- All 4 registry references (2 HI16 / 2 LO16) resolve to native targets and
  reproduce the four raw instruction words. No outside consumer or alias exists.
- Strict owner controls: 100/100, comprising 4 valid cases and 96 malformed
  cases rejected. All 36 candidate rows and all 35 old rows validate; helper
  predicates and every other registry row remain unchanged.
- All 698 original object hashes remain unchanged. The private link retains
  697 inputs and excludes only `data_8010CCD4_r07.data.s.o`; src keeps that
  intact oracle. Both standing relink lanes pass in isolated output directories.
- All 466 executable input sections / 249,505 words are checked. The 1,067
  changed words are exact existing relocations: 1,065 LO16 and 2 HI16. Both
  old and new symbol/addend encodings are independently calculated. No branch,
  opcode, register or non-relocation instruction bits change.
- All 2,381 GP targets/statuses remain unchanged: 1,372 correct, 1,006 wrong,
  3 unknown; zero overflow, unresolved, encoding mismatch or native/raw conflict.
- All 3,874 previously native public records, 104 native FILE-qualified LOCAL
  records and 3,238 native function records remain unchanged.
- No unanchored code input moves; initialized legacy orphan data following
  the shrinking `.data` output shifts by 64 bytes, recorded explicitly.
  Allocated bytes fall by 64 with no new overlap area or multiplicity.

Baseline `Collide_gRegistry` was already the source NOTYPE / size 0 symbol at
the wrong 8013E648. It stays NOTYPE / size 0 / GLOBAL / default-visible and
moves to native 80110C30. The raw input's NOTYPE / size 64 is different input
metadata, **not** an actual linked size-64-to-0 change. Native SYM/source
declarations and complete payload independently prove the 64-byte extent.

## Three-file handoff

`proposed.patch` / `apply_manifest.json` contain only:

1. An appended strict row in `tools/source_data_owners.py`; appending preserves
   all existing generated `source_data_N` output identities.
2. The raw-to-source selector in the persistent reconstruction data fragment.
3. A comment-only correction to the retained raw oracle header.

The ordinary generator validates the owner and fragment, omits the obsolete
extra-data source copy, asserts the native global, and excludes the exact raw
input only in recon. Src/oracle keeps the raw selector. No generated linker,
auto-symbol file or generator code change is required. The earlier row-first
diagnostic copy is frozen; final proposal appends the row to avoid renumbering
other output sections.

Private ELF: `026637d23ec9a81c144f48a05955a5e84507f321ca99bcaf539231d0a0708697`.
Private map: `f83efc56283a0b99c2ce032ddf97b62a86b752e805807d91b70bf5443d8e8e39`.

Evidence: gate.json, guard_controls.json, preservation.json, both GP audits,
relink_private.json, references_inventory and references_proof. Full source
restoration and a fully native image are not claimed; existing unrelated
layout/overlap/name debts remain. No production or normal-output write,
staging, commit or push was performed by this subtask.
