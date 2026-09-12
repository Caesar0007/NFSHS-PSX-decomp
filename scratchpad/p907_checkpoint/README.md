# P907: native GameSetup storage and ordinary AudioCmn literals

Verified local checkpoint, 2026-09-12. P904-P907 are not committed/pushed;
the last published checkpoint remains `7aef1e7c`.

## Results

- Removed ten synthetic string-carrier declarations from AudioCmn. Ordinary
  literals plus the native LanguageName definition placement reproduce the
  exact pool; no compiler flags, assembly or volatile were added.
- Restored direct SYM-backed commMode, reverseTrack and userSetting.language
  accesses in nfs3, AIState and HUD. All nine affected instruction words and
  eight retained AIDataRecord compatibility-reference words match retail.
- Source owns GameSetup's full 3024 bytes and Audio's full 2416-byte .data;
  the 44-byte TrackGenBank readonly window is also native-exact. Audio's
  existing 248-byte .sdata remains exact, including its genuine LOCAL statics.
- Retired **5484 duplicate raw bytes**, retaining every oracle byte in
  src/expected. Raw-blob duplicate count: **780 -> 757**. No REAL duplicate,
  phantom symbol or referenced unresolved symbol was introduced.
- **175/175 function gates and 1441 branch comparisons pass.** The five normal
  objects and debug twins have identical allocated payloads. Audio's 48
  local/static/scope/SLD contracts remain preserved, not newly declared exact.
- All 2381 GP targets, 3826 previously native public records, 86 native
  LOCAL/FILE records and previously correct reference encodings are preserved.
  Nineteen additional public storage records now have native placement.

## Safety boundary and remaining work

The source code still contains AIDataRecord's existing D_80113228 alias. The
native field is known (GameSetup_gData.track), but original TU/header/accessor
context is not. The successful private full-type probe was not landed. A
nonallocating source-relative linker binding is explicitly compatibility debt,
not an invented original declaration. AIDataRecord's three source/header files
are unchanged. Original inherited GameSetup visibility in nfs3/AIState is also
not fully established by these field-access checks.

The new strict same-TU pointer-owner mode validates the real LOCAL section
symbol against an exact ordinary owner in the same object. It never rewrites
compiler outputs. All 40 controls pass; FEI's separate GLOBAL/UNDEF boundary
remains unchanged (51/51 controls). All 31 ordinary rows still reject injected
relocations. 225 visibility controls cover 75 explicitly contracted storage
symbols in 14 ordinary rows plus FEI; 17 legacy payload-only rows still need
full symbol contracts. The peer report's original "15 ordinary" label is a
counting-label error, not an extra validated owner.

There are 33 top-level initialized owners and six zero owners, not 34 plus
six: TrackGenBank is a nested 44-byte window in already-selected .rodata.
Its four original following zero bytes remain a separate native raw leaf.
The later SoundCar table still has the known four-byte packing discrepancy.

The complete reconstructed image remains incomplete: **1277 wrong GP targets**,
three unknown GP expectations and inherited output overlaps remain. All old
GP targets and overlap-area/multiplicity are preserved, but callback's native
buffer now overlaps the repacked raw o21 input (8014773C..80147B44, 1032 bytes).
The scoped relink GREEN result is not a clean/full runnable-image link.
Allocated section bytes fall 5440, distinct from the 5484 raw bytes retired;
neither is a final executable size result.

The full expected/recon builds passed with NFS4_STRICT and no skipped TUs.
However, NFS4_SOURCE_ONLY is interpreted by verify_asm, not by build.py.
An ordinary full build reinstates legacy per-function SDK options in six
objects (FIRST, cdread, INTR, LIBMCRD, PADCMD and PADSEQD). The frozen linked
checkpoint used their strict-verifier profile. Recompiling with the exact
existing verifier policy reproduces all six frozen objects literally, without
source/tool changes or output patching. The original report and a fresh relink
then reproduce the reviewed hashes. The ordinary full-build report is retained
as a separate diagnostic, not equated with the strict-profile result.
Of 699 frozen inputs, 693 remain identical; changes are exactly the four scoped
C++ objects and the two raw split objects. Making these two report profiles
explicit is a future tooling task, not a silent configuration change here.

## Receipts

- `final_receipts.json`: consolidated final hashes, results and qualifications.
- `final_gates.json`: 175 detailed gates, 1441 exact branch distances, normal/
  debug equality. No debug-label transformation is used.
- `policy_build_closure.json`: strict expected/recon builds, policy/vtable
  audits, five COMMON regression tests, old-input closure and report hash.
- `build_profile_restored.json`: all six existing strict SDK objects reproduced
  by compilation after the ordinary full-build test; neither profile is hidden.
- `../p907_build_hash_diag/README.md`: independent six-object default/strict
  reproduction and exact configuration causes, not a label/hash exemption.
- `final_gp_audit.json`, `audio_relink.json`: actual final image and both lanes.
- `raw_audio_split.json`: every original raw byte/relocation/symbol survives,
  except the explicit synthetic-label extent correction from 48 to 44.
- `../p907_gmesetup_owner/final_audio/README.md`: final native 3024-byte owner,
  all 17 reference words, unchanged AIDataRecord source and generic/FEI guards.
  Its `VISIBILITY_COUNT_ERRATUM.md` corrects the generic-versus-ordinary row label.
- `../p907_audio_literals/integration/landed_20260912/peer_final_review.json`:
  independent actual-source, linked-reference, guard and full-image preservation.
- `publication_manifest.json`: exact cumulative P904-P907 file closure; this
  list is preparation only, never blanket authority to stage the worktree.

Final linked ELF:
`8ecfcdd06de59e1138efb5c946b5c2dc59f6df1bc5ddcef86b44e3f2b0d8a521`.
Map: `6b5d838af99302b3c64158f17f8c90080dc4db93f71a78963093a7c76e19ac23`.
Objdiff report: `2f64da5ebcadf1b920d8668e8a02ffed87abf40a1621fd45bfa97b3805ab19c3`.

Backups are in `backups/`; independent probes/failed alternatives are frozen
in their separate scratch namespaces. User edits are preserved. This is a
source-restoration checkpoint, not completion of the full SYM/SLD goal.
