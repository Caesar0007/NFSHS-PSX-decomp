# P909 HUD whole small-data owner — verified isolated proposal

Ready patch: `proposed.patch`; exact source/destination hashes:
`apply_manifest.json`. Patch check passes against the current working files.
Parent owns application and actual-image verification. No production or
normal outputs were changed by this subtask.

## Result

The ordinary private full link places existing HUD `.sdata` at native
8013D89C..8013D98C. It corrects the entire240-byte owner, not one bool alias:

- SwitchSong is now **62/62 actual linked words raw-exact**, formerly60/62.
  Both wrong LO16 words now address native Hud_kTurnSongOffNext8013D940.
- **250/250 HUD references** have correct native targets/addends/encodings:
  198 public references and52 LOCAL-section references. All33 identities
  are preserved:28 GLOBAL, one exact file-static and four native UID statics.
- GP wrong targets **1277 ->1124**:153 newly correct references, all HUD.
  Every1,101 previously correct GP reference remains correct, with no new
  overflow, encoding disagreement or native/raw conflict.

Private ELF:
`60e7dc44e406330e5c613d9237449878b7b5ef45f6a5f0c4fa1fdcf6d5246619`.
Private map:
`86491f6d3121732705cf6d9f7b730f213f25f954ad1bd5eba7f17e7167530d51`.

## Exact source and raw ownership

Only HUD's incorrect seven-line140-byte/-fconserve-space comment changes.
Its replacement retains the same line count; isolated compilation preserves
all code, data, storage, ordered non-FILE symbols and relocations. The sole
metadata identity difference is the exact private source FILE path. No source
body, compiler flag, initializer, alias or type is changed.

The source240 bytes already match ROM and complete CPE loads, SHA256:
`405c4c7605bf8fbe0ac36e35c5b066b50547750df6a49592b1311752e1232a81`.
All33 contracts derive from actual native records, including keepup423264,
oldCountdown423d18, lastsec423e8c, lastsectick423ea1 and file-static
BTC_playedsoundalready4250b0. Only the four function statics allow numeric UID
suffixes, with LOCAL binding retained.

Mixed raw r20 is split into pre36 / HUD240 / post380. All656 bytes,133 raw
symbols, full section flags0x10000003, alignment4 and zero relocation sets are
preserved. The middle oracle leaf remains in the source/oracle lane and is
excluded only from reconstruction after owner validation. Native pre/post
addresses stay fixed. All21 removed-range synthetic-only aliases have zero
live references; no replacement alias is invented.

## Guard and regression evidence

The initial generic guard accepted two high-flag mutations; its553/555 receipt
is preserved. Parent approved an optional exact `section_flags` assertion,
enabled only for the new HUD row. The hardened suite passes **555/555**:
39 positive cases accepted,516 invalid cases rejected. Every previous33 row
remains unchanged; the bounded guarded assertion is the only validation-code
change. This supersedes, not hides, the initial flag-check gap.

Full-link preservation verifies3,845 prior native-correct public records and
77 literal-name LOCAL records unchanged. Parent's supplementary
`p909_checkpoint/private_scoped_local_preservation.json` proves all86 prior
file-qualified native LOCAL records unchanged, including its established UID
correspondences.

Allocated bytes decrease exactly240. The new `.sdata` payload is the old
payload with the duplicate source block at8013E018 removed; the subsequent
unplaced-source suffix naturally shifts240 bytes earlier. Native r20 pre/post
do not move. All other allocated section geometry is unchanged, so no overlap
is added or increased. Existing broader image overlap remains unresolved.

All533 changed linked code words are at existing relocation sites (118 LO16,
415 GPREL16); opcode/register bits and code geometry remain unchanged. All560
code-bearing input objects match the frozen input hashes. Of these address
changes,153 correct HUD GP targets; later unplaced-source addresses move with
their own unchanged bytes. No previously native-correct GP/public/local
binding is sacrificed to this cleanup.

## Apply only the six core files

The patch contains the owner registry/optional flag check, HUD comment, raw
r20 split and new oracle leaf, source linker selectors and recon small-data
fragment. **Do not copy private linkers/nfs4_recon.ld or any object/ELF/map to
production.** Parent regenerates the actual linker script after applying the
core patch, then performs its actual85-function/250-reference/full-GP checks.

Receipts: `switchsong_proof.json`, `preservation.json`,
`code_relocation_preservation.json`, `comment_verification.json`,
`raw_split/verification.json`, `raw_split/native_contract.json`,
`guard_controls_hardened/results.json`, and `references_proof/results.json`.

HUD's separate `.sbss`76, `.data`668 and `.bss`1226 ownership is out of scope.
This is not a complete original local/SLD/header-source seal or whole-image
runtime-correctness claim.
