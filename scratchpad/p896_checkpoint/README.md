# P896: native AI state/scopes and Newton interface restoration

Completed 2026-09-09. All three full build lanes and **737/737 protected
functions in33 base TUs** pass, with zero branch divergence and source-hash
drift. This is further original-source recovery, not a completed project seal.

## AI_AddCollidableObjects

The source previously declared static CHAR firstTime without an initializer.
Native raw/CPE data stores1 at its actual GP+0 cell,8013C54C. The old linked
source read a separate zero-initialized SBSS cell at8013EDDC instead. The source
now initializes firstTime to1 and owns its true storage. Static spos likewise
now occupies native8013DEE0..8013DF64 as a132-byte NOBITS BWorldSm_Pos, rather
than the old unrelated catch-all address8013F7A0.

The source also restores Group::GetData's real inline receiver, a for-local
objectIndex, loop-local pt, and the five inner guard locals. All **11 native
local/inline records** have the correct name/type/storage/home; all **seven
native lexical block address spans/depths** match. Vector subtraction and the
radius load/scale are grouped source expressions without invented macro names.
The existing native radius variable remains visible in debug output; an otherwise
byte-identical single multiplied initializer that erased it was rejected.

Native target SLD improves **36 merges/92 splits ->30 merges/0 splits** without
new bad pairs. The remaining30 pairs are the unresolved call-result versus
range-test statement boundary; original macro tokens/physical line spacing also
remain unsealed. All39 neighboring AI functions preserve their complete debug
scope/instruction contracts. No new asm, volatile, helper, flag or name is added.

Most importantly, the actual production **linked** function now compares
**127/127 words** directly to rom/nfs4-f.exe, not only to normalized unlinked
assembly. Both firstTime references and all six spos HI/LO words are raw-exact.
See ../p896_ai_statements and ../p896_production_storage for full receipts.

## Storage ownership and linker changes

AI's ordinary source initializer naturally emits one16-byte .sdata run:
firstTime+0 (CHAR1 plus compiler alignment), AI_time+4, AI_elapsedTime+8,
AI_iTime+12. Complete bytes equal native:
01000000 00000000 00000000 00000000. Whole linked .sdata bytes are unchanged:
source storage replaces the previously raw prefix rather than adding a copy.

The owner registry now has19 initialized and4 zero-storage owners. It excludes
exactly two additional raw inputs from the reconstructed lane: r00's4 bytes and
o00's12 bytes. **Both raw files remain intact in the oracle lane.** No filesystem
deletion or blanket exclusion is used. __sdata_org is now correctly a generated
linker boundary, not a raw four-byte variable. The native spos NOLOAD region uses
the existing saved/restored catch-all cursor; no fake padding fills its old site.

The tool changes have comments and pre-edit backups in backups/. New exact
symbol contracts check offsets, binding, storage type and unique numeric-UID
stems for the actual firstTime/spos source identifiers, rather than forcing
retail compiler suffixes into C. Duplicate sections or extra defined storage
are not silently ignored.

## Newton base and USA

Both actual Newton TUs now use native slice members instead of byte aliases and
offset macros:76 accesses. USA additionally repairs21 stale spike-belt,
GameSetup and simGlobal interface accesses, fixing its current-header build
failure. The projection is confined to newton_externs.h; reusable newton_types.h
and AIH-BTCCop are unchanged. Original foreign-header visibility remains open.

Actual base32/32 and USA's available492-instruction regional target pass.
All64 normal/debug function instances preserve their code, local records,
source partitions and scope contracts.30 actual-header layout assertions pass;
all108 raw reference words match their own images. The USA simGlobal map row
was an interior gameTicks+4 address, so its true aggregate base was derived
before member relocation, avoiding a silent double+4 bug. No existing regional
constant, local name, signed-byte behavior or whole-struct copy was changed.
See ../p896_newton_slices/README.md and landed receipts.

## Full validation and data nonregression

- All three full build lanes completed without failed/skipped TUs.
- 737/737 detailed gates in33 base TUs and every branch check pass.
- Of518 normal objects,517 are literally unchanged. AI alone changes its
  initialized-storage/section-symbol contract; **all normal instruction bytes**
  remain identical. Its .data/.rodata/BSS extent and unrelated symbols are
  unchanged. Actual new AI object:
  `fc4c0ccb670846f42b8a01047c0b8b5f5d66b5bdb07f7df56ba94a0836432084`.
- Actual GP audit covers2381 resolved/encoded sites, no overflow or encoding
  errors. Of2378 native-known targets, confirmed wrong targets fall
  **1430->1428**;3 remain native-unknown. Do not treat historical aggregate1433
  as an additional three fixes from this round.
- All948 previously correct GP rows and3779 uniquely mapped native global
  bindings are preserved. The950 correct rows after the first probe also remain
  correct in the complete owner/production link.
- Standing recon duplicates851->848, all known blob-class; REAL duplicates,
  phantoms and referenced unresolveds remain0. Src lane duplicates remain0.
- Owner negative controls:50/50, comprising6 valid cases and44 rejected unsafe
  variants. Initial40/50 failures were preserved and closed by root.21/21 old
  owners still validate; old rows/exclusions remain compatible. No mutated ELF
  fixture is ever written to disk.
- Vtable/source-policy checks and CI-style report generation pass.

Actual final ELF SHA256:
`52800553415581618c04766bca85e3d943de8343f60b78c62ff7c62af9e32ae0`.
Its allocated memory and non-FILE symbols match the independently frozen full
owner probe after the explicitly named .ai_spos_bss->.ai_spos section mapping.
This is not byte identity to the old wrongly bound linked image.

## Remaining limits and explicit next work

The native spos region exposes three more overlaps with already oversized
.data/.sdata/.tail_data outputs: output overlap pairs130->133. Generic SBSS/BSS
packing and orphan data move when the obsolete source cells/raw duplicate are
removed; all previously correct native bindings were checked, but the moved
wrong/native-unknown bindings are not claimed repaired. The diagnostic still
uses permissive overlap/duplicate flags and retains the old SBSS PROGBITS
warning. It is **not a fully valid native memory map or finished image**.

Strict frontend/common remains780clean/48extra/438source-only carriers;
game/common1228clean/6extra/478carriers,0missing in both. Type/storage/mapping
queues remain. Declaration-clean coverage alone would have missed the wrong
initializer, private storage addresses, and lexical ownership fixed here.

ScreenPost Tournament DrawBackground's five bounded removal trials failed and
were not landed. Exact code/PC/m2c/SLD evidence narrows its next angle to the
post-loop text-style register web and original cached-count source shape;
see ../p896_post_draw. The existing carriers are not declared necessary or
renamed just for readability. Further AI source groups, native data layout,
AIPhysic/AIState/AudioTrk field graphs and the full carrier queue remain active.

CI report build/p896_report.binpb is321195 bytes, SHA256
`2f64da5ebcadf1b920d8668e8a02ffed87abf40a1621fd45bfa97b3805ab19c3`.
The user scratchpad/w85/o2.txt remains
`d433425b806fc8abd1fa60c9f72a09f4c022bfd64a7fecf4df496931169e9546`.
No commit or push was performed; all unrelated edits remain preserved.

Primary receipts: final_receipts.json, build_summary.json, full_build_receipts.json,
object_receipts.json, source_receipts.json, relink.json and strict reports.
Independent receipts: ../p896_production_storage, ../p896_owner_validator_tests,
../p896_ai_storage and the source-family directories above. Full goal remains
active and incomplete.
