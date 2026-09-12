# P912 actual image — independent verification PASS

All **318 actual native data-reference words** are exact: Collide 4,
Camera 268 and GenericPMX 46. GenericPMX's current consumer objects and raw
ROM encodings were rechecked directly; Camera/Collide words were re-read
against their frozen primary-backed reference proofs.

Actual ELF: `415cde9ff28286ae6d4bab1c0b05eb3f51aa3cc118d29158242e2fbf826f7f8c`.
Actual map: `3b5b518f59b1273737539ee51f7a241155be6e43a0b2fba2be93613c7f1863a3`.

Complete ELF header, program headers, section order, payloads/storage metadata,
ordered symbols and ordered relocation records match the reviewed private
image, allowing only the two exact Camera/GenericPMX FILE path substitutions.
All **5,262 input/section placements** agree under the corresponding two
precise object-path mappings. Both actual candidate objects likewise differ
only in their exact FILE records; all other 696 original object hashes remain
unchanged. The current 38-owner guard and full helper AST match the proposal.

This transfers the proven preservation of 3,874 native public records,
104 FILE-qualified LOCAL records, 3,238 native function records and all
2,381 GP target/status records, with no new overlap or code movement.
No broad symbol, address or metadata normalization is used.

All watched inputs rehash unchanged. No build, source edit, normal-output write
or publication was performed. Existing unrelated layout/source/SLD debt remains,
including the rejected HUD BSS placement and GenericPMX's unproved carrier.

Machine receipt: review.json; implementation: ../actual_review.py.
The initial diagnostic import lacked the tools directory for the existing
source_section_owners helper; adding that diagnostic import path resolved it.
No production code or predicate was changed.
