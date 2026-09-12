# P908 three native small-data owner contracts — private proposal

This subtask did not modify production files, source TUs, normal objects, link
outputs or Git state. This directory holds a private source_data_owners.py proposal, exact
input backups, an apply-ready patch and verification artifacts.

## Scope

Strengthen only the existing `.sdata` rows for r3dcar, copspeak and nfs3 by
adding `alignment`, exact `symbols` tuples and `assert_native_symbols`.
All original row values are retained, including full payload hashes,
addresses, sizes, oracle leaves and CopSpeak's `oracle_size`.
Every validator function AST, the FEI pointer contract, Audio local/auxiliary
contracts and the complete oracle-exclusion set remain unchanged.

| Owner | Named globals | Named storage | Existing source section | Retained raw tail |
|---|---:|---:|---:|---:|
| r3dcar | 15 | 62 bytes | 156 bytes | 0 |
| copspeak | 16 | 55 bytes | 126 bytes | 2 zero bytes |
| nfs3 | 16 | 49 bytes | 88 bytes | 0 |
| Total | 47 | 166 bytes | 370 bytes | 2 bytes |

The other204 source-section bytes are existing literal/alignment spans, not
invented variables. Their complete hashes remain protected. No section is
resized, split, newly excluded or allocated by this metadata-only proposal.

## Native evidence and unchanged inputs

`proposal_verification.json` rechecks every exact native SYM line, MAP address,
current object record, current linked global and per-cell CPE bytes.
All47 names are native typed EXT declarations, GLOBAL/default-visible in the
actual object and already bound to native addresses.

Pointer records with `size36`/`size12` describe pointee types; the pointer
cells correctly have four-byte contracts. BOOL remains the existing four-byte
PSX C++ representation. ARY/STRUCT sizes describe their aggregate storage.
CopSpeak's signed-char source spelling is not uniquely established by the
native CHAR record; the two-byte array extent is established and unchanged.

The actual three sources and objects are hash-pinned and unchanged. The linked
image reviewed is
`8ecfcdd06de59e1138efb5c946b5c2dc59f6df1bc5ddcef86b44e3f2b0d8a521`.
All370 source bytes have complete matching CPE-load coverage and agree with
ROM/current linked storage. The two-byte CopSpeak tail is **not CPE-loaded**;
it is the preserved raw/linked alignment zero at8013D0FA..8013D0FC, outside
the126-byte source section. The proposal does not invent source storage for it.

These checks establish native name/offset/storage/binding evidence. Runtime
ELF symbol contracts do not by themselves distinguish every same-width C
type, prove original signedness/token spelling, or seal functions/locals/SLD.
Other sections and the other14 remaining payload-only owner rows are outside
this bounded contract change.

## Positive and adversarial controls

`negative_controls.json`: **509 controls pass**, six valid cases accepted and
503 invalid cases rejected. Every one of47 globals is individually tested for
wrong offset, size, name, LOCAL/WEAK binding, function retyping, three invalid
visibility modes and missing storage. Each section is additionally tested for
extra/duplicate storage, bad alignment/type/flags/size, named and unnamed-byte
payload changes, and unexpected data relocations.

Positive cases preserve historical NOTYPE/size0 symbols and also accept
OBJECT/native-size metadata. The latter reflects equivalent assembler metadata,
not a change to any actual object. All33 complete candidate owner rows validate.
Mutations exist only in verifier memory; no real object is edited.

## Apply-ready artifact

`proposed.patch` targets only `tools/source_data_owners.py` and passes
`git apply --check`. Parent owns any actual landing and final linker assertion
generation. Do not copy the whole private module over a concurrently edited
registry: apply the three bounded row additions after checking the base hash.

- Baseline tool SHA256:
  `05a22ea1b6ff44da8f3eb2f0f7ffefd082a1f073f8fc3c3ab5ef45ae4348413e`
- Private candidate SHA256:
  `63519cda0f827494a17ea789a4cbd9cfd0d8c0ba66361e2f3d45f25f04dc0098`

## Independent linked-reference closure and parent landing

`references/reference_proof.json` checks all462 actual reference records from
20 consumer objects:226 r3dcar,174 copspeak and62 nfs3. All target/addend and
encoding checks pass:222 GPREL16,115 HI16,124 LO16 and one R_MIPS_32. They are
not name-only checks. All47 linked globals retain their native addresses.

Strict positional raw-byte confirmation applies to259 references:258 in
whole-function raw-exact bodies plus FEI's pointer word. Another195 are in
linked functions that are not wholly byte-identical, and eight lack a unique
native oracle name. Those203 references have verified linked target/addend
encodings, but **no positional raw-byte equivalence is claimed** for them.

The image retains an existing `.data`/`.sdata` VMA overlap. Readers therefore
use the owning linked symbol's exact section and each input-map/output-section
identity; an ambiguous address-only lookup is not accepted. This guard
improvement does not resolve the whole-image overlap or all other bindings.

Parent applied the exact63519cda candidate. The linked ELF remains literally
unchanged. Current map SHA256 is
`ecc5bd9dace8ac2e376020066e21e7f5b313cb002fa9d23bdf5bc7d39e50e9ad`;
comparison with frozen6b5d838a proves its only changes are47 new successful
native-symbol ASSERT lines. Every placement and every other map line remains
literal-identical. Earlier private proof/input hashes remain preserved.

The bounded contract proposal and reference verification are complete. No
function PASS count, original local/SLD seal, or new source spelling is claimed.
