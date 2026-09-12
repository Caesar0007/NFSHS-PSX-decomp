# P910 HUD76 zero owner — verified isolated proposal

No C body/header/source/flags were changed. No normal object, linker output or
production tool/raw file was written by this subtask. Parent separately owns
the adjacent HUD initialized-data proposal and final combined landing.

## Whole native owner, not raw-zero initialization

Existing HUD `.sbss` is NOBITS76, input alignment8, flags0x10000003. It belongs
at native8013DE00..8013DE4C and has14 LOCAL symbols: countdownTick at+0 in
Hud_Render321Go (STAT423d32, compact019633) and13 native file STAT records
42516f..425304. They occupy69 bytes plus7 actual alignment bytes. All pointer
cells are4 bytes regardless of pointee sizes; BOOL is the existing4-byte ABI.

No CPE load intersects this76-byte span. Merged-EXE zeros are a transport
representation, not a CPE-loaded initializer. Source NOBITS type/extent/native
declarations establish the reservation; **no NOBITS file-offset payload is
read or hashed**.

Only the76-byte middle of tail.data.s's148-byte `.data.tail_after_simqueue`
is replaced in recon. Native prefix44 atDDD4..DE00 and suffix28 atDE4C..DE68
are preserved. The original76 bytes/15 raw labels remain in a source/oracle
leaf. The complete604-byte tail tree,73 symbols and zero relocation sets are
preserved, including all other tail/simqueue/primate sections.

## Reference and storage-class result

The zero-only private link verifies **140/140 native reference encodings**:
118 GPREL16,11 HI16,11 LO16. All14 LOCAL source identities now reside at their
native addresses. All1,254 previously correct GP references remain correct;
118 HUD GP targets improve, changing confirmed wrong targets1124 ->1006.

The15 retired raw labels have no live references, no foreign references to
these local names, and no tail-section-symbol references. Eight raw GLOBAL
exports used native STAT spellings; they are explicitly removed in favor of
the actual native LOCAL symbols, not treated as legitimate public regressions.
The remaining3,865 previously native-address-correct public records and78
literal-name LOCAL records are preserved. Parent's file-qualified LOCAL
comparison is part of the final combined-image audit.

No replacement aliases or globals are invented. All698 link inputs are
accounted for;697 retained objects remain unchanged and only the proven raw
tail split replaces an input.

## Exact metadata and alignment

The optional zero-owner `section_flags` and `symbol_visibility` checks apply
only to the new HUD row. Existing six rows retain their prior behavior.
The268-case independent suite passes:32 positive cases,236 rejected negatives,
covering all14 symbols, UID scope, metadata, NOBITS and relocation checks.
A positive beyond-EOF NOBITS sh_offset case proves no fabricated data payload
is used.

The generator now uses each zero owner's explicit alignment, default4. All
six older output alignments remain4; HUD is8 in both input/output at native
DE00. The earlier valid-address but output-alignment4 diagnostic remains
frozen under `link_source_order` and `references_proof`. The final alignment8
variant has identical code/data bytes, symbol values and geometry; its140
reference proof transfers explicitly through `alignment_reference_transfer.json`.

Final zero-only inputs:

- `link_align8/hud_sbss.ld`
- `link_align8/hud_sbss.rsp`
- ELF `5897de9f0242658f692117b7dbfbcb25ef1bd8dcea7d8198f4b9091f3aa33533`
- Map `58969e8865e18af63cbe416428e5a90b9bbd840bfb0852665d5f406e69a85d1f`

Allocated bytes fall by76; coverage is nowhere added and no overlap is added
or increased. The raw native span is replaced by proper NOBITS storage while
the old displaced source reservation disappears from the generic catch-all.
Existing broad image overlaps and other unmatched bindings remain qualified.

## Handoff

`proposed.patch` and `apply_manifest.json` contain five core files only:
source_zero_owners.py, gen_ld.py, source/oracle linker selectors, split tail
source and the new oracle leaf. Parent must merge the adjacent data proposal's
changes into the shared source linker, regenerate actual nfs4_recon.ld and
audit the final combined image. Do not copy private objects/ELFs/maps or the
private generated linker script into production.

Evidence: `raw_inventory`, `raw_split`, `guard_controls`, `references_proof`,
`preservation_align8.json`, and `alignment_reference_transfer.json`.
