# P879: CopSpeak_Flush carrier removed through bank type repair

Retained a direct `CopSpeak_gQueue[i].bank = -1` store and removed the unrecorded `request` pointer. Only `CopSpeak_tRequest.bank` changed in the two authorized headers; the other fields and every function outside Flush are unchanged. No invented production identifier, asm, volatile, global compiler flag, or postcompiler instruction rewrite was added.

## What is proved

Native SYM `261dde` declares the 32-byte request; `261eba` declares bank at byte30 as CHAR. Flush `26bc7b` has only `i` (`26bcda`: INT, REG3), in the nested loop scope at8009a944-8009a98c, frame0/mask0. The final generated debug emits precisely that single local and the same machine-address block boundaries. Both actual headers compile the target-size assertions: request32, bank offset30, bank width1; their generated bank debug record remains T_CHAR/0x2.

Retail bank loads throughout CopSpeak are `lb +30`, not `lbu`; Flush stores `li -1; sb +30`. The real PsyQ CC1PLPSX defaults plain char to unsigned. A diagnostic with plain char, signed char, and unsigned char confirms that **both plain and signed char emit T_CHAR**, whereas unsigned char emits T_UCHAR. Original GCC2.8.1 `sdbout.c` explicitly maps the two former spellings to T_CHAR. Consequently this repair proves the **signed bank access contract**, not the original keyword/macro/compiler-flag spelling. That original spelling remains unproved.

The M2C body at `C:/Temp/nfs4-clean/Binaries/NFS4-B-USA/c/func_8009A944.c` independently confirms the queue index, 32-byte stride, bank+30 invalid store, wrap-at63, and head comparison. Named data and GP base are corroborated by native SYM/MAP; the map gives `__SN_GP_BASE = 8013C54C`.

## Gates and exact identity

- Flush: PASS20/20; all20 linked analysis words equal raw `rom/nfs4-f.exe`. All20 oracle-comment words independently equal the same raw bytes. Five relocation sites reach the native queue/head/play addresses.
- CopSpeak:27/27 PASS, branch0. Final normal/debug text is byte-identical across all6880 text bytes, and all text relocation records are identical.
- Entire actual production CopSpeak object remains SHA256 `70fc97ebe71e9feeb970a4af6af67f16969a2171d4a82bfc1a35834376f9807e`, equal to P875/P877/P878 and the new final isolated real-source build.
- Actual CPP dependency census:698 sources,47 header consumers,0 preprocess failures.
- All40 base consumer objects are full-file byte-identical before/after. The four code TUs are audiocmn48/48, cars33/33, copspeak27/27, nfs3 11/11:119/119 PASS with branch0. The other36 objects are data-only/empty, not additional function matches.
- Five built regional consumers retain identical executable/data payloads, non-file symbols and resolved relocations. Their region-specific gates retain21/21 selected oracle PASSes. Some raw hashes differ only because the regional harness uses PID-named temporary sources. Regional branches are preserved by whole executable payload/relocation identity; a separate regional brdist run is not claimed.
- Two regional nfs3 sources fail both BEFORE and AFTER: AU and USA retain undeclared `_6Speech_fgUndefined` / `Speaker_vtable` in `Nfs2_SystemNLibStartUp`. Their diagnostics match after temporary-PID normalization. No objects exist, so all corresponding object/branch/gate equality fields are **null/unavailable**, not a vacuous success. These are pre-existing, out-of-scope blockers.

## Falsified basins

| Input | TU PASS | Flush |
| --- | ---: | --- |
| Old source/default unsigned plain char |27/27|20PASS|
| Old source/whole `-fsigned-char` |19/27|20PASS|
| Direct bank/default old field |26/27|2diff,20insns|
| Direct bank/whole `-fsigned-char` |19/27|20PASS|
| Old source/bank-only signed type |27/27|20PASS|
| Direct bank/bank-only signed type |27/27|20PASS|

The whole signed-char flag damages sfx+29/noise+31/string byte reads in eight functions; all have unchanged counts and branches, but wrong signed loads. It is rejected. The bank-only type change fixes the direct store without that collateral effect. `whole_flag_matrix.json` preserves every function's counts/diffs and compiler commands.

## SLD limits (do not overclaim)

The local list/register/machine scope is now native-only for Flush. Exact original source text and complete SLD are **not** proved. Native setup line1258 covers offsets0-28; line1259 covers28-80. Generated source still subdivides that latter group into the store, loop step, and exit. The removed pointer assignment no longer creates a source-only object/statement; no new merge across native groups is introduced. Whitespace/comment line numbers and original one-line/macro spelling remain open.

## Artifacts / handoff

`receipt.json` summarizes the round. `final_debug_receipt.json` records actual commands, native SLD records, generated local/block records, layouts, raw references and exact twins. `consumer_objects_{before,after}.json`, `consumer_comparisons.json` and `consumers_before.json` contain the complete consumer coverage and explicit failures. `Flush.before.cpp`/`Flush.after.cpp` are focused source snapshots. The two requested header backups are in `headers_before/`.

The matrix was recorded BEFORE production header changes. Its historical `whole_before.cpp`/`whole_direct.cpp` include the live headers; do not rerun `whole_flag_probe.py` after a header edit and relabel the output an old-type baseline. Use the saved original `.i` inputs or the backed-up header context to reproduce historical basins. `final_debug_probe.py` safely recompiles only the current source into this scratch directory.

Production edits are frozen; all consumer object writes finished and were released to root for both mandatory full-build lanes. No commit/push was made by this agent. Compiler `.i/.s/.o` intermediates are diagnostic artifacts, not recommended commit content.
