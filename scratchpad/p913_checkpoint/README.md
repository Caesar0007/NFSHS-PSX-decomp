# P913: complete GenericPMX scope topology and HrzSku native data

Verified local checkpoint; not committed or pushed.

- GenericPMX now has all **48 native SYM scopes** and all **34 recorded local
  names, types, homes and owners**, with unchanged normal code: 593 instructions
  PASS and 18 branches. Two inner blocks and the final three-call GNU statement
  expression restore real missing scopes without invented identifiers or dummy
  expressions. The ordinary final-brace attempt was correctly rejected as inert.
- HrzSku's nine native data objects now own **1,580 bytes** at 801202F8. All 50
  references are native-exact. Its source body/data declarations are unchanged;
  only a wrong module caption and nine BSS comments are corrected.
- **23 PASS functions / 188 branch checks**, unchanged full matching report,
  **1,765/1,765 actual guard tests**, both scoped relink lanes and source-policy/
  vtable checks green. Raw duplicates decrease **707 to 698**.

The raw prefix remains in a new oracle-only leaf. The 1,040-byte suffix, seven
symbols and six language pointers remain native; all 2,620 original bytes and
19 raw symbols are preserved. The actual ELF is literally the reviewed private
image. Existing correct public/local/function/GP bindings are preserved, with
no increased overlaps or code movement. All 751 changed instruction words are
existing HI/LO relocations with both old and new encodings checked.

## Not completed or disguised

GenericPMX's 1,377 SLD splits remain. The misleading existing `pmx_height` name
is explicitly unresolved; it feeds callee `ry`, not height. Production-compiler
traces explain current rematerialization but do not prove original variable
identity. Carrier removal on the restored scope shape still fails at 579/593
instructions. Failed literal, expression, initializer and fabricated-helper
probes remain private. No invented replacement name or macro was landed.

The source scopes are verified, not original macro token spelling. HrzSku's
other local carriers/SLD, remaining wrong GP targets (1,006), broader overlaps
and the rejected HUD BSS placement remain on the main goal. No whole-project
source/SLD or runnable-image completion is claimed.

## Evidence

- `integration.json`, `actual_controls.json`, `relink.json`, `final_receipts.json`
- `../p913_genericpmx/actual_verification.json`
- `../p913_genericpmx_native/FINAL_PROPOSAL.md` and native inventory
- `../p913_genericpmx/probe_receipt.json` and byte-faithful RTL trace receipts
- `../p913_hrz_comments/verification_actual.json`
- `../p913_hrzsku_owner/raw_proof.json`, `preservation.json`, `actual/`

The full actual link uses ordinary production paths, without the private
classifier projection required only by a scratch-path diagnostic. All code
objects remain literal; only the raw donor object is replaced by its assembled
suffix. New data assembly is oracle transport, not hand-reconstructed code.

`publication_manifest.json` lists only scoped production/backlog and compact
documentation candidates, excluding generated outputs, backups and unrelated
user edits. Protected changes have backups and comments. No Git mutation was
performed; the active reconstruction goal remains unfinished.
