# P881 fecheats native global-view cleanup

Removed the four CPP-local A_ asm-label views/macros. FEApp now uses its genuine scalar pointer declaration; gFECheats/gFEBonus use genuine scalar declarations; Stats_gTrackRecords uses its existing **187-element array**, not a scalar. No function body or initializer changed.

With root's explicit expanded permission, corrected only the two cheat/bonus declarations in fecheats_externs.h from unsigned int to **unsigned long** and added a native-record comment. Native SYM2c74a1/2c74b8 says ULONG at8013d278/8013d27c. The owning nfs3.cpp:26-27 already defines u_long, so this removes real U_INT/ULONG declaration drift without a cast, alias, new definition or layout change.

## Native types / typed probe

- FEApp4b4f01: EXT PTR STRUCT tFEApplication, VA800514c0, target size896.
- Stats_gTrackRecords2c7346: ARY187 tRecordBuffer, VA80114d94, row20, total3740. Existing header declaration and actual row structure agree.
- The actual-header compiler probe types.cpp passes 4-byte mask,20-byte row,3740-byte records and896-byte application assertions. Its emitted signature is `p881_types__FPUlT0PA187_13tRecordBufferP14tFEApplication`; debug parameters confirm PTR ULONG (0x1f) for both masks, PTR ARY187 tRecordBuffer (0xd8), and PTR tFEApplication size896 (0x18). Probe identifiers exist only in scratch, never reconstructed code.

## Verification

Base before/after: **10/10 PASS**, **branch0**, entire actual object byte-identical, SHA256 `247787507f828f0aff103d87ccf932e9458066ddf39f2f2b1dbfe69c67e6bc41`.

Old and final -g compiles preserve all1624 text bytes and text relocation records. All10 generated local-definition lists are unchanged. Their old/new source-statement maps are bijective, proving **no new source-group merge or split**. This is preservation, not a claim the existing SLD/source backlog is closed.

All406 oracle-comment instruction words were checked against raw nfs4-f.exe. All26 compiled relocation sites referencing the four repaired globals were independently linked in memory to their native addresses and equal the corresponding raw words. Other function/table/call references retain exact whole-object identity; a new complete final-link proof is not claimed.

Actual CPP dependency census: **698 sources,2 consumers,0 failures**. The only additional consumer is regional USA fecheats.cpp. It remains **4/4 region-specific PASS**, with unchanged source and identical executable/data payloads, non-file symbols and resolved relocation identities (fingerprint `aa87abd1c9f8fc2e1f84c43da2fefa7e4656cc269a7f10216d9c50843ce9933e`). PID-dependent source metadata changes the regional full-file hash, not program content. Region branch preservation follows executable/relocation identity; no separate region brdist claim.

## Limits / handoff

The regional CPP still has its old A_ aliases; it was not in the authorized edit scope. Its canonical extern declarations are corrected through the shared header. Existing base-body carriers and num/i scope issues are untouched. The Stats header comment saying the base CPP still carries an alias is now stale; only root-authorized mask declarations/comments were edited, so root can remove that outdated clause separately.

No failed basins, new asm/volatile, invented production names, postcompiler rewrites, or production tool edits. Backups: fecheats.cpp.before and fecheats_externs.h.before. JSON receipts include the complete census, before/after regional checks, native types, debug locals and all changed references. verify_receipt.py compiles its frozen pre-edit .i only into scratch; it reads existing normal/final-debug objects and never changes production code. Compiler .i/.s/.o intermediates are not recommended commit content.

Production is frozen and all writes to production objects are finished. Root handles any full-build lanes and commit/push; this agent made no commit.
