# P912: three native data owners, no PASS regressions

Verified local integration; not committed or pushed.

- Camera: repairs **102 initializer bytes** using SYM-defined nested coordinates
  and six bitfields. Its full 1,404-byte source data block now has native values,
  ordering, names, bindings and placement. Original macro/brace spelling is not
  claimed recovered.
- GenericPMX: restores seven native array declarations, correcting five offsets
  that an all-zero payload comparison could not detect. Its existing body,
  local/SLD contracts and mixed-EOL tail remain unchanged.
- Collide: places the existing 16-pointer registry at its native address.

Together these remove **2,772 duplicate bytes** from reconstruction while
retaining the exact raw oracle inputs. All 318 owner-reference instruction words
are native-exact. There are 38 strict initialized-owner entries, seven zero
owners, 36 exact oracle exclusions and 707 remaining raw duplicates.

## Verification

- Actual source paths: **53 PASS functions, 1,116 branch checks**.
- Actual guards: **3,161/3,161 controls** (40 valid, 3,121 rejected malformed).
- Actual ELF matches the reviewed private image in all allocated payloads,
  geometry and full symbol/relocation entities; only two precise FILE paths
  differ between scratch and real compilation.
- All 1,356 linked instruction changes are existing HI/LO relocations with both
  old/new encodings checked. No code input moves or new overlap is introduced.
- Existing native public/local/function bindings and all GP targets/statuses
  are preserved. Wrong GP targets remain 1,006; three expectations are unknown.
- Both scoped relink lanes, source-policy and vtable audits pass. The freshly
  generated full before/after objdiff reports are literally identical.

The three reconstructed data sources use known native names and types. No new
asm, volatile, register pin, padding object, invented identifier or postcompile
instruction/object rewrite was introduced. The metadata registry only appends
three rows; old rows and all validator predicates are unchanged.

## Explicit remaining work

This is not a fully native or runnable link seal. Other overlap/layout debt
persists, including the rejected HUD BSS placement. GenericPMX's unproved
`pmx_height` and 1,377 SLD split pairs remain on the source-recovery backlog;
data ordering does not seal the function body. Other Camera BSS/external
references and exact original initializer/macro spelling remain separate work.

## Receipts and boundaries

`integration.json`, `actual_controls.json`, `relink.json`, `final_receipts.json`
and `publication_manifest.json` consolidate actual results. Source proofs:
`../p912_camera_data/actual_verification.json` and
`actual_generic/final_receipt.json`. Independent private proofs and primary
record inventories are in `../p912_combined_owners`, `../p912_camera_data/peer`
and `../p912_genericpmx_order/link_review`.

Independent actual-image rechecks are in
`../p912_combined_owners/actual/review.json` and
`../p912_camera_peer/actual/results.json`: all 318 reference words are re-read,
all 5,262 current input placements agree with the reviewed private map, and
Camera separately passes all 268 references and ten typed cells.

The GenericPMX actual adapter compiles the normal object before invoking the
read-only comparison. The embedded comparison receipt's no-write/future-link
qualification describes that comparison step; `integration.json` records the
subsequent actual link. It must not be mistaken for a claim that the enclosing
actual-path build performed no normal writes.

The old 698 input files remain on disk; only two source-produced objects change.
The new link includes 695 inputs, omitting the three exact raw leaves. Backups,
images, objects and generated reports are not publication candidates. No Git
mutation occurred. Publication of this newer checkpoint is not inferred from
the already-consumed P898-P903 approval.
