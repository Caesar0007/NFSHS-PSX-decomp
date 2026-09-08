# P885 verified continuation (uncommitted)

The original-source/SYM/SLD goal remains active. This round restores three
native scalar-pointer declaration graphs, removes two source-only receiver
carriers, and repairs three initialized-data owners. It neither invents
original identifiers nor claims full source or final-image exactness.

## Native pointer graphs

| Native global | Consumer TUs | False outer [0] accesses removed | Native record |
|---|---:|---:|---|
| FEApp |6|191|4b4f01 PTR STRUCT at800514C0|
| screenMain |7|126|605a62 PTR STRUCT at80051E58|
| gCurrentShapes |10|22|56d925 PTR STRUCT at800517CC|

All339 accesses use the existing scalar pointers; actual pointed-to arrays,
member indices, constructor arguments and source statement order are retained.
Every normal base object is byte-identical. Regional full objects or complete
code/data/symbol/relocation fingerprints and full gate outputs are unchanged.
The17 regional TUs collectively preserve51 selected PASSes,112 existing misses
and3 NOT IN OBJECT cases. Those failures remain real backlog, not new matches.

Confirm's unrecorded feApp/displayDialog receivers are removed in base and
three regional twins: eight source instances, two base carrier names. Only
feApp previously had an emitted debug record; displayDialog was optimized out.
All other debug names/types/homes remain, with zero new merged native SLD-line
pairs across the61 FEApp base functions. No new helper, asm, volatile, register
pin, compiler identity or output instruction rewriting is introduced. P884's
already-qualified scalar volatile ticks is preserved unchanged.

Reference checks:66 FEApp words and15 gCurrentShapes words match raw when
resolved to their native cells. All252 screenMain pointer-target fields agree;
24 complete words in four already-missing PAL constructors retain their old
register/opcode differences. The base menu constructor's3205/3207 debug-only
divergence is independently reproduced before the edit; normal66/66 remains
PASS and all seven normal menu objects are identical. No full-debug-exact or
regional-clean claim is made where the evidence does not support it.

## Three data owners, seven public bindings

TABLE's69632-byte payload, SNDEF's8 bytes and atantbl's257 bytes now belong to
their typed native source sections. Oracle-only leaves preserve all original
bytes/labels and atantbl's three padding zeros. Three strict isolated lanes
match79312/79312 bytes and preserve76 raw labels plus five external bindings.
All seven public source bindings are native; all16 affected actual linked
relocation words are restored. The prior P884 four bindings and34 raw words
also remain correct. The registry now validates15 source-owned windows.

## Final checks and limits

All three full builds complete without failed/skipped TUs. All518 live source
objects reproduce byte-for-byte. All421 functions across the16 protected base
TUs PASS with zero branch discrepancies. The fifteen owner windows, isolated
raw seams, actual table reference words, standing relink, vtable/source-policy
checks and CI-style objdiff report generation pass.

GP: all2381 relocations resolve and fit, with zero encoding errors or native
target regressions;1462 wrong-but-in-range targets remain. New table gains are
HI16/LO16 reference fixes, not misreported GP fixes. Known raw/source duplicate
symbols decrease905->898; REAL duplicates, phantoms and referenced unresolveds
remain zero in the standing gate. The broader diagnostic link is NOT clean:
125 overlap pairs remain, versus119 before orphan repacking; their pairwise
byte total decreases110375->72019. This is not a unique-byte/image metric.
overlap_delta.json records exact movements; the main data overrun and sbss
warning still need restoration.

Fresh audits show frontend/common781 declaration-clean mapped functions,
missing names0, extra locals46, type/storage findings9/9, mapping review3 and
448 source-only carriers (450 before this round). Frontend/psx has85 mapped
declaration-clean functions but still54 source-only carriers and18 blob-backed
globals. These counts do not prove all extern declarations, macro bodies,
optimized-away source or SLD scopes are recovered.

Evidence: full_validation_receipts.json, final_receipts.json, the two strict
audit reports and overlap_delta.json here; detailed native/consumer/reference
receipts in ../p885_feapp_scalar, ../p885_screenmain, ../p885_gcurr and
../p885_owners. Historical reports are preserved rather than overwritten.
P884 and P885 are uncommitted on main; no new push was authorized or performed.
The user's unrelated w85/o2.txt remains untouched.

Next source angles include the separate plain gHelpShapes pointer graph and
remaining scalar ticks declarations, always with complete consumer/regional
checks and the native type/SLD evidence. Do not blindly change genuine arrays
or remove polling qualification. Remaining legacy data, including ISO9660 and
vars/new/simqueue/replay copies, requires its own ownership/reference proof.
