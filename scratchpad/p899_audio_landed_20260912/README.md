# P899 independent actual combined AudioTrk validation

The parent landed its Reset loop/source-order recovery together with the
accepted SoundTrack scope and distance-expression changes. This independent
validation compiled ACTUAL recon/game/common/audiotrk.cpp against ACTUAL
production headers into this isolated namespace. No production source, header,
tool or normal build output was written by this verification.

Actual source SHA256:
`7fff98cd7b07e474d4e75d92e78fa7ed1125a67f97f2e8a658aee8bc402f3dda`.

Normal object SHA256:
`d57d2dcfda69e37d673af8256b7b2823778956967d09a72db500a3d0e6036bb2`.
The complete normal object is literally byte-identical to frozen actual P897.

## Verified results

- 6/6 functions PASS; all159 branch-distance checks exact; debug text exact.
- Reset matches p899_audio_reset/candidate and candidate_verification:
  native SLD0 merges/0 splits; both native i owners and all seven emitted
  nonempty native scopes exact. Two native empty blocks remain unproved;
  the existing unrecorded se source spelling remains explicitly open.
- SoundTrack matches p899_soundtrack_expressions/candidate: all25 native
  local owners and exact19-block projection retained, native SLD22/76.
  Its two zero-width CE40 records remain absent and uninvented.
- PreLoad matches its accepted P898 candidate: native SLD2/5 and all five
  recovered se/i/x/z/d owners exact. Original inline identity remains open.
- Other three function bodies, local/type/home/order records, real scopes,
  complete debug instruction/local-label graphs and SLD partitions are
  unchanged. Only physical line counters are ignored for comment changes;
  no actual scope or declaration movement is excused.
- All530 raw words are exact: Reset56, SoundTrack358, PreLoad116, including
 58 relocation words. Evaluation is read-only; no object/assembly/image
  instructions are rewritten.
- Actual normal/debug include census contains no staged scratch headers.
  Every resolved source/header is hashed in combined_verification.json.

## Compiler labels are not address exemptions

Reset's changed source loops renumber later compiler labels. The checker
resolves each SCL6 source-label record to its actual `.text` symbol address
before comparing, verifies it lies inside its owning function, and checks
that the original source label still denotes the same native instruction PC.

| Existing AddCustomObject source label | Reference compiler ID | Actual ID | Unchanged PC |
|---|---|---|---|
| AudioTrk_cleanup |L29 |L31 |8007C7D8 |
| AudioTrk_valid |L31 |L33 |8007C828 |
| AudioTrk_find_channel |L35 |L37 |8007C84C |
| AudioTrk_channel_found |L36 |L38 |8007C8F0 |
| AudioTrk_near_volume |L76 |L78 |8007CC10 |
| AudioTrk_fade_volume |L78 |L80 |8007CC94 |

These are the six emitted source-label declarations. The empty existing
AudioTrk_volume_done label has no SCL6 record; no record is synthesized for
it. This preserves the current labels' PC identities, not a claim that their
spellings were recovered from native SYM. Whole normal object equality and
the complete debug label-reference graph provide separate checks.

Unique debug labels are asserted before assembly. GAS-L diagnostics only
retain existing local symbols; source assembly hashes and all code/data
payloads are checked unchanged. No injected or renamed labels are used.

Primary receipt: combined_verification.json. Detailed raw receipts are
raw_reset_receipt.json, raw_soundtrack_receipt.json and
raw_preload_receipt.json. Gate/label records are landed.json and
debug_labels_receipt.json. All prior P898/P899 proposals and histories remain
untouched. Full original source or SLD exactness is NOT claimed; the existing
unknown Reset se, empty inline records and P898 cast spelling remain open.
