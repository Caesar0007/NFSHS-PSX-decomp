# P896 owner-validator independent negative controls

2026-09-09. Final result: **50/50 controls pass**, plus **21/21 existing-owner
compatibility checks**. No remaining failure in the tested contract matrix.
All malformed ELF variants exist **only in memory**; no production object/tool,
source, normal build output, or linker input was edited by this subtask.

Tested object: `scratchpad/p896_ai_statements/landed/objects/recon/game/common/ai.cpp.o`.
The harness reads the actual production validator implementations and supplies a
virtual read-only object for their normal validation calls. It only restricts
the row list inside its own Python process; no production module/file is changed.

## Positive and negative matrix

Six positive controls pass:

- Current actual AI object under initialized-owner and zero-owner validation.
- Unchanged in-memory serialization of that object under both validators.
- Alternate numeric UID spellings `firstTime.98765` and `spos.12345` under both,
  retaining all real section/offset/type/binding/payload contracts.

All44 negative controls are rejected:

- Duplicate, wrong, or nonnumeric local stems.
- GLOBAL/WEAK instead of LOCAL; incorrect symbol section, offset, size or type.
- Extra NOTYPE storage, FUNCTION or TLS symbols defined in an exact owner.
- Relocations targeting the initialized/BSS owner.
- Duplicate `.sdata` or `.bss` section names.
- Missing ALLOC/WRITE or added EXEC section flags; these mutations toggle only
  the specified flag bit and preserve unrelated MIPS section flags.
- Wrong firstTime byte or its compiler alignment bytes; shrunk/expanded `.sdata`.
- Wrong AI_time name/binding/offset/size.
- Wrong BSS extent and initialized PROGBITS instead of NOBITS.

No acceptance rule was weakened to make the matrix pass. The fixture serializer
has independent accepted controls, so malformed variants are not merely failing
because every serialized object is unusable.

## Gaps discovered and closed by root

The initial production implementation scored **40/50**, accepting ten bad cases:

| Initial gap | Cases |
|---|---:|
| Extra FUNCTION/TLS symbols ignored by the NOTYPE/OBJECT-only count |4 |
| Duplicate owner section ignored by `labels.index()` |2 |
| Missing ALLOC/WRITE and added EXEC accepted for AI `.sdata` |3 |
| Added EXEC accepted for AI `.bss` |1 |

The initial reports are preserved in `initial_results.json` and
`single_bit_flags_results.json`. The second confirms the same ten gaps with
single-bit flag mutations that preserve unrelated section attributes. Root then
hardened the production checks: reject duplicate section names before indexing;
require allocated/writable/non-executable ownership; examine all non-SECTION
defined symbols in the exact owner and reject types other than NOTYPE/OBJECT.
The final rerun is `hardened_results.json`: all50 expectations hold.

## Existing-owner compatibility

An independent read-only review compared the exact pre-P896 backups with current
tools. All18 old data rows and3 old zero rows remain identical ordered prefixes.
The18 prior oracle exclusions are preserved; exactly r00 and o00 are added.
Existing payload/hash, initialized/NOBITS extent, REL/RELA rejection and
FeCredits global/static offset/binding/uniqueness checks remain intact. Old zero
owners additionally reject non-data symbol types and executable storage; those
are strengthened checks, not removed checks.

`old_owner_compat.py` also snapshot-read all21 existing normal owner objects,
checking each read was stable before handing its bytes to the validators through
the in-memory file interface. **18 initialized +3 zero owners all pass.** It did
not build, link, edit, or wait on those outputs. Root owns the full-build gates.

## Artifacts and repeatability

- `test_owners.py NEW_STAGE`: production validators, in-memory matrix; refuses
  to overwrite any previous stage's report. It exits1 if any expectation fails.
- `initial_test_owners.py`: frozen first harness for provenance, not the current
  rerun entry point. Do not run it over historical output.
- `initial_tools/`, `hardened_tools/`: read-only snapshots of both tested tool
  implementations. Each result also records the exact tool and input hashes.
- `initial_results.json`: first40/50 receipt.
- `single_bit_flags_results.json`: refined flag cases, same40/50 result.
- `hardened_results.json`: final50/50 receipt, zero gaps.
- `old_owner_compat_results.json`: all21 old-owner positive snapshots/hashes.

No mutated object was written to disk. Only scratch test code, JSON receipts and
tool backups were created. Production tools were strengthened by root, not by
this subtask. These tests cover the requested ownership contract; they are not
a claim that arbitrary malformed ELF parsing or the whole native link layout
has been fully audited. Actual linked GP/global binding verification is a
separate post-fullbuild task.
