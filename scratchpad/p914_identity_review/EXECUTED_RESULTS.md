# P914 executed independent strict-identity tests

GREEN against actual auditor `674e1852...` and backup `02e6a1c2...`.

`test_private.py` executed **33 assertions** using real Universal Ctags records
from an explicitly synthetic, never-compiled fixture. All six matching-only
suppression paths reopen the correct findings. Inverse and unsized array cases,
incomplete split-prefix detection, marker typos, ABI-local misuse, and preserved
optimized/canonical/compact/inline/macro/host/common/type/storage/vtable categories
are covered. The hard-register case injects the existing parser's `asm_register`
record field; it tests the policy union without adding assembly code.

| Summary | Legacy/default | Strict |
|---|---:|---:|
| Declaration-clean functions | 12 | 9 |
| Missing native locals | 0 | 1 |
| Extra source locals | 2 | 4 |
| Missing/extra globals | 0 / 1 | 2 / 5 |
| Global type findings | 0 | 3 |
| Mapped source globals | 8 | 6 |

Both missing split aggregates stop counting as mapped. Default output is
byte-identical to the backup. Default -> strict -> default in one loaded module
also reproduces the first default output exactly, including cached owner helpers.
The old module's `__file__` was set to the actual canonical auditor path so its
ROOT/provenance did not drift. Only the unchanged raw-label input census was
snapshotted once for both versions; no policy/comparison helper was replaced.

`test_real.py` independently exercised four frozen-source cases with real Ctags
and native function records:

| Case | Marker | Actual declaration | Default extra | Strict extra |
|---|---|---|---|---|
| Historical GenericPMX | Matching carrier | pmx_height | None | pmx_height |
| Current GenericPMX | Unresolved identity | pmx_height | pmx_height | pmx_height |
| Historical Horizon | Matching carrier | pv | None | pv |
| Current Horizon | Absent | Absent | None | None |

Thus annotation removal alone is not counted as source recovery, and actual
variable removal is not reported as an invented leftover. The selected function
queue is the scope of these single-file real tests; missing global SYM inputs
are not used to certify their data identities. Current tool/source/normal object
hashes were checked unchanged after the runs.

No implementation defect was found within this bounded policy change. Root owns
the complete-directory report comparisons and command-line run. These fixtures
do not independently certify the primary evidence behind preserved categories,
nor make the flat declaration auditor a lexical/SLD or full-source validator.

Receipts: `fixture_results.json`, `real_case_results.json`, and frozen complete
legacy/default/strict fixture reports. No compilation, actual auditor edit,
reconstructed source edit, normal-output write, or publication was performed.
