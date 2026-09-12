# P908: SwitchSong source recovery and exact native data-symbol checks

2026-09-12, verified local work. The last published commit remains7aef1e7c.
P904-P908 are not committed/pushed; unrelated user edits are preserved.

## Source improvement

AudioMus_SwitchSong's ordinary short-circuit if/else removes three synthetic
SONG_* labels, restores native `info` to its depth2 work scope and reproduces
all three original blocks. Omitting the redundant final void return restores
the final native statement group. **SLD0/24 ->0/0**, with **23 PASS and206
branch comparisons** preserved. All22 neighboring debug/local/SLD graphs and
the actual whole normal object are unchanged. No new names, asm, volatile,
macros, flags or compiler-output rewrites were introduced.

This is source/SLD progress, not proof of a wholly exact linked function:
the current image has a pre-existing two-word address error. At8007A188 and
8007A1B4, Hud_kTurnSongOffNext is reached at8013E0BC instead of8013D940.
The isolated native-resolved62-word proof must not be confused with the actual
image's60/62 words. The complete ELF is unchanged from P907, so no regression
is introduced. The next repair is evidence-backed full HUD .sdata ownership,
not a one-symbol address alias.

## Data contracts

47 globals across r3dcar/copspeak/nfs3 now have exact native name, offset,
storage-width, binding and visibility contracts. **509 controls pass** on the
landed registry. Existing370-byte source payloads and the separate two-byte
CopSpeak raw tail are unchanged; the tail is not CPE-loaded. All prior guard
function ASTs, FEI/Audio constraints and oracle exclusion sets are unchanged.
Payload-only owner rows fall **17 ->14**; total owners remain33 plus6zero.

All462 linked reference target/addend/word encodings are verified across20
consumers. Only259 additionally have strict raw-word evidence; the remaining
195 nonexact-function and8 nonunique-function-name cases remain qualified.
The linker map differs only by47 successful native-symbol ASSERTs. The ELF
is literally unchanged; existing .data/.sdata overlaps remain visible.

## Verification and remaining work

- `actual_source_receipt.json` and `actual_music/implicit_return_inspection.json`:
  actual source-path code/SLD/local proof and explicit two-word link debt.
- `negative_controls.json`:509 tests on the actual owner registry.
- `../p908_owner_contracts/references/reference_proof.json`:462 exact relocation
  encodings and precise raw/symbol/layout qualifications.
- `oracle_src_restored.json`: all467 oracle scaffolds recompiled and identical
  to expected/src; reconstructed objects were untouched. This repairs the
  empty build/src cache left by the previous --skip-asm diagnostic.
- `relink.json`: both scoped lanes GREEN;757 known raw duplicates remain.
- `final_receipts.json`, `publication_manifest.json`: consolidated hashes and
  explicit cumulative file selection. No staging/publication is performed.

SoundCar's four-byte readonly gap is still open. Original ASPSX and compiler
fixtures ruled out a simple padding discrepancy and exposed an unused-inline
literal-emission mechanism. The preceding native SimpleMem string could explain
the relative alignment, but the original uncalled header body is not recovered.
The mobile raw constructor twin confirms tag-first/size-second and an allocator
third-zero argument omitted by IDA; it does not justify a dummy constructor.
See `../p908_soundcar_rodata/README.md` and `../p908_simplemem_context/README.md`.

ELF:8ecfcdd06de59e1138efb5c946b5c2dc59f6df1bc5ddcef86b44e3f2b0d8a521.
Map:ecc5bd9dace8ac2e376020066e21e7f5b313cb002fa9d23bdf5bc7d39e50e9ad.
The1277 wrong GP targets, remaining native binding/layout gaps and original
source/header questions keep the full goal incomplete and active.
