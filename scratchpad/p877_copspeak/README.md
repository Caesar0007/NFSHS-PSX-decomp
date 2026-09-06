# P877 CopSpeak_PlayNextRequest source restoration

**Retained: one synthetic source local removed; target PASS71/71, exact code twin, whole TU27/27 PASS, branch0.** No new name, asm, volatile, header, build-tool or postcompiler mechanism was added. Only this function in copspeak.cpp was changed; pre-existing edits elsewhere in the file were preserved.

The existing P842 cross-recovered `next` now carries the queue-index-to-wrap-output value chain. The in-place if/else mutation was8diffs at71/71; a conditional expression restores the retail separate input/output register pattern. The initial queue capture/index is one compound expression; the final conditional result and global store are one assignment chain.

## Debug/SYM qualification

Native target SYM26bc32/26bc55 records only `r` (REG16, PTR CopSpeak_tRequest32) and `handle` (REG5, INT). These homes/types are unchanged and their declaration order is restored. Frame24, mask80010000/-4 remain exact.

| Source local | Before emitted record | After emitted record | Authority |
| --- | --- | --- | --- |
| r | REG16 pointer | REG16 pointer | Native target SYM |
| handle | REG5 INT | REG5 INT | Native target SYM |
| iVar3 | REG4 INT | Removed | Rejected decompiler placeholder |
| next | REG3 INT | REG4 INT | Existing same-object P842 recovery; target SYM omits it |

`next` is not a newly introduced record or type/class, but its debug home changes3→4. Its native-target home is unproven. The recovery is grounded in the same queue-wrap role in CopSpeak_DirectRequest, CopSpeak_GenericBankRequest and CopSpeak_Request; it is not evidence of a surviving next record in this target.

**Neither native-only locals nor full SLD/source exactness is claimed.** Retail1192 now maps to one source expression rather than two. Retail1237 spans two source groups rather than four: the post-call reload remains separate from the conditional/store expression. Existing splits at1221 and1222 remain. No distinct known retail statements were newly merged.

## Independent object and raw proofs

The live entire production object SHA256 is **70fc97ebe71e9feeb970a4af6af67f16969a2171d4a82bfc1a35834376f9807e**, exactly the pre-edit production SHA independently recorded at line117 of `scratchpad/root_sym_audit/p875_common2_public_header_receipts_20260906.md`.

The frozen whole-TU baseline uses an isolated scratch filename, so its ELF file/container metadata has a different full SHA (56663d2187675e85484b4689ee4050df9aa81ba7551ce8ab8eab8d9555ce0258). Its complete code/data, non-file symbol records, and resolved relocation identities match the live object exactly (fingerprint ba22a87d4759acbc01f3c7a05dda900fefcf466fb82d960fbcdd542eb8aab15c). This comparison reads objects without rewriting them. Both full .text debug twins are byte-identical to their respective normal objects.

All71 oracle words were cross-checked against rom/nfs4-f.exe; zero mismatches. Queue/global/callee identities are preserved and enumerated in receipt.json. The complete owning TU remains27/27 PASS, with zero branch-count/offset differences.

## Files and reproduction

`before.cpp` and `after.cpp` are focused function snapshots. `before_whole.cpp` freezes the baseline translation unit for the isolated debug/object check; its include paths and logical source line directive are preprocessor inputs, not compiled-object changes. `analyze.py` reads the built evidence and prints fresh JSON.

Normal checks:

```powershell
$env:NFS4_SOURCE_ONLY='1'
python tools/tugate.py recon/game/common/copspeak.cpp
python tools/brdist.py recon/game/common/copspeak.cpp
python tools/diffsrc.py recon/game/common/copspeak.cpp CopSpeak_PlayNextRequest__Fv
python scratchpad/p877_copspeak/analyze.py
```

The isolated baseline was preprocessed with the normal C++ CPP flags, compiled by CC1PLPSX `-quiet -O2 -G8` (and `-g` for its twin), and assembled with the unmodified maspsx pipeline (`--expand-div`, configured ASPSX version). Generated `.i`, `.s`, and `.o` files are disposable evidence intermediates, not production source changes.
