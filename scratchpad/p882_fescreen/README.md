# P882 fescreen scalar-view cleanup

Removed CPP-local A_Draw_gPlayer1View, A_screenheight and A__7tScreen_fSuppressLoadingText unsized-array asm-label declarations/macros. Existing scalar externs now provide those names. The one explicit array-base use became `playerViewIndex = &Draw_gPlayer1View`; every other body/initializer character is unchanged apart from line endings. No new names, helpers, asm/volatile, header/tool edits or postcompiler rewrite.

## Storage/type evidence

- Native31f8e0 declares Draw_gPlayer1View as EXT INT at8013d3cc; render.cpp:34 owns an int, and fescreen_externs.h already declares the same scalar.
- Native019109 names screenheight at8013dc8c without a type. Its single4-byte zero-initialized slot lies between screenwidth and screenbpp; eacpsxz/vars.c:20 owns it as int. The earlier NFS2 beta SYM13cd8d independently records `_screenheight` as EXT INT. No actual array was scalarized.
- Native023fef names `_7tScreen.fSuppressLoadingText` at800517c8 without a type. Retail reads/stores one word; data has one zero word followed by gCurrentShapes at+4. The existing normalized int bridge is preserved. **Its true C++ static-member declaration and exact original type remain unresolved**; removing the fabricated array view is not a claim of fully restoring that class data member.

## Verification

Before/after whole TU: **27/27 PASS**, **branch0**. Entire actual object remains byte-identical with SHA256 `7228f949f9999f27c5fd1395036b6cf88d71fd1307c21e8fffd279728e59f0c0`.

DisplayLoadingText:80/80 PASS; GoNonInterlaced:52/52 PASS; both exact -g twins. Old-source and final -g builds preserve all3640 text bytes and every text relocation record. Both affected functions' generated local records and source-statement partitions are unchanged, so no new SLD merge/split is introduced.

All132 oracle-comment words across those functions equal raw nfs4-f.exe. All16 compiled relocation sites to the three repaired globals were independently linked in memory and equal the corresponding raw instructions. Other references/data retain exact whole-object identity. This is not a new complete final-link claim.

DisplayLoadingText retains its native oldIsBg INT/REG18 and i SHORT/REG16. Existing source-only GoNonInterlaced carriers/private foreign CodegenViews remain unchanged. Full-SYM/source/SLD exactness is not claimed.

## Artifacts / handoff

receipt.json summarizes scope, native records, checks and limitations. raw_debug_receipt.json contains the exact local lists and16 native reference receipts. fescreen.cpp.before is the full untouched backup; before.i is the frozen baseline preprocessor input. verify_receipt.py compiles its old -g snapshot only inside this scratch directory and reads final production objects. Compiler intermediates are not recommended commit content.

Source is frozen; all production object writes are finished. No failed probes or commits/pushes. Parent consolidates the checkpoint.
