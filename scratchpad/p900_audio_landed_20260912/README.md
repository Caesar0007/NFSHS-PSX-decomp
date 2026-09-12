# P900 independent combined actual-path validation

Completed 2026-09-12 after root's explicit landed notice. No production files,
normal build outputs, shared tools, or prior receipts were modified here.

Actual source SHA-256:
`abe4b13ef1e6e0fb8647e93bd54323c01a81561cf77cfd0fdc43a73af3afa1da`.
Actual isolated normal object:
`d57d2dcfda69e37d673af8256b7b2823778956967d09a72db500a3d0e6036bb2`.

## Accepted result

- **6/6 detailed PASS**, all **159 branch checks** exact.
- Entire actual-path normal object literally equals the frozen P899 **and**
  P897 production-path objects. Against each private candidate, the only
  difference is its one exact C++ STT_FILE pathname; every other ordered symbol,
  section payload/storage/header/schema and relocation entity remains exact.
- **1,004/1,004 raw instruction words** (4,016 bytes), including **112 relocation
  words** resolved in verifier memory only. No objects or labels are rewritten.
- Every actual function independently matches its own accepted reference's
  local definitions/types/register homes, lexical spans/depths/ownership,
  instruction/source partitions and full debug instruction/label graph.
- Actual preprocessing uses the complete nine-file production closure, with
  no scratch headers. All hashes are recorded and rechecked.
- `source_identity_receipt.json` additionally checks complete accepted function
  text and comments, plus the final accepted file-header comment/preamble.
  It compares line-ending representations without rewriting source files.

| Function | Accepted reference | Raw words | Native SLD merges/splits |
|---|---|---:|---|
| Reset | P899 actual baseline | 56 | 0/0 |
| StartUp | p900_audio_lifecycle/candidate | 23 | 0/0 |
| AddCustomObject | p900_audio_addcustom/candidate, final SHA64fb3714... | 413 | 0/0 |
| SoundTrack | p900_soundtrack_sld/candidate | 358 | 22/16 |
| PreLoad | P899 actual baseline | 116 | 2/5 |
| CleanUp | p900_audio_lifecycle/candidate | 38 | 0/0 |

AddCustomObject retains all 31 native scopes and 18 local owners; its final
formatted/commented candidate is the reference, not ambdist_consumer. Its six
emitted synthetic label records are gone. **No source-label-PC exemption** is
used: each actual graph matches its corresponding accepted function graph.
SoundTrack retains its 25 owners and 19-block projection; its two empty native
blocks remain honestly unrepresented. Lifecycle functions each have four exact
native scopes, with their i locals in the correct depth-3 owners. Reset's seven
emitted scopes and both i owners remain unchanged.

## Receipts and boundaries

`combined_verification.json` is the strict combined code/metadata/debug/SLD/raw
receipt. `source_identity_receipt.json` anchors the four reference source
snapshots and all six actual bodies. `landed.json` records ordinary compilation
and gates. `debug_labels_receipt.json` records the existing metadata-only GAS-L
diagnostic and proves unchanged compiler assembly and text/data. Six
`landed_*_raw_target_receipt.json` files enumerate every resolved reference.

Code/scopes/partitions verified here do not prove unique original tokens or
physical source line numbers. Remaining SLD and original-source questions stay
open, including Reset's explicitly documented se identity. Primary per-function
proofs remain in their original P899/P900 directories; publication is root-owned.
