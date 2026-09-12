# P910 actual zero-owner verification — PASS

The landed production validator passes all **268 controls**: 32 positive
cases accepted and 236 negative cases rejected. All seven actual zero-owner
objects validate. The six older row contracts and behavior are unchanged;
HUD alone opts into exact section flags and symbol visibility.

`test.py` reuses the frozen private test suite against actual
`tools/source_zero_owners.py`. Its hash is exactly
`dcf88012e11c1e6eaeabb05cd7c71addf2f7a4ceb668b4a360b129b7942b9e4c`.
Only the two approved optional checks differ from the old helper AST.
Every case outcome and substantive rejection message matches the private
receipt. The first literal report comparison exposed Python fixture-object
process addresses in diagnostic strings; `transfer.py` excludes only that
exact `__main__.Memory` repr address. No ELF/source/relocation value or test
expectation is normalized.

## Actual linked storage and references

The actual `.hud_sbss` is NOBITS76 at8013DE00, flags0x10000003, alignment8;
the source input also has alignment8. All six old zero-owner output sections
retain alignment4 and their exact native addresses/extents. The generated
link script agrees with every row. Actual gen_ld.py b096a3a7... differs from
the proposed9d26ec1d... only in CRLF/LF bytes.

The independent actual reference receipt verifies **140/140 encoded words**:
118 GPREL16, 11 HI16, 11 LO16. All14 native LOCAL identities are correct.
Eight unreferenced raw GLOBAL exports were native STAT objects and are now
represented by their actual LOCAL storage; seven unreferenced synthetic raw
aliases are retired. No new aliases were introduced.

No NOBITS file payload was read or hashed. The positive beyond-EOF NOBITS
file-offset test still passes, distinguishing storage metadata from bytes
which do not exist in that section. CPE has no load covering the reservation.

## Exact transfer and qualifications

Actual ELF is literally the reviewed final combined private image:
`69a16b3e8b61fd915369ab7ac44701a66bf484e0556ec7f5cf87ea7950a75570`.
Actual map:
`03555ee72bfaa24e0a8cde24fbd5c50505e807c1f11abfd1ca4e0c130f865714`.

All **5,284 input/section placements** compare exactly after only the two
documented private-to-normal raw-object path substitutions. Both actual raw
objects equal their frozen private objects. This transfers the complete
combined-image preservation proof without any symbol/metadata waiver.
The separate actual parent check preserves91 established file-qualified
LOCAL contracts, including the five previously restored HUD small-data
locals. Private and actual reference receipts remain separate and frozen.

The adjacent initialized HUD.data668 owner belongs to the coordinated parent
change. Existing broad image overlaps, the callback overlap and movement of
four unanchored spill-code inputs plus inert SN-LNK bytes remain explicitly
recorded in `p910_hud_data/combined_peer/combined_review.json`; this is not a
claim of fully native image layout or complete original-source restoration.

No build, source/production edit, normal-output write or publication was
performed. Only this scratch receipt namespace was added. All watched inputs
rehash unchanged, including the user's w85/o2.txt.

Machine receipts: `results.json`, `transfer.json`, and the independent
`../actual_references/results.json` (SHA256
`f5e9bd56dcb0776752ba9b942a1763e3bf49cd61eca2c9f77b4b347ed5e4a17f`).
