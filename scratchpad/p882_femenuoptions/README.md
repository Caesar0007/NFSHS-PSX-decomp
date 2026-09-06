# P882 FeMenuOptions native-source cleanup

Retained only inside tUserNameMenuItem::TransitionOn in femenuoptions.cpp:

- Remove FEAppA[] asm-label view; use existing scalar FEApp declaration.
- Remove menu_kUserNameRowsA[] asm-label view; use existing scalar SHORT.
- Remove the unrecorded dst pointer; assign menu_kUserNameRows directly.
- Restore genuine NumberOfRows[6] to function scope without moving when its
  initializer executes: declaration remains after the sprintf loop.

Native SYM distinguishes all three storage shapes. FEApp is an EXT pointer at
4b4f01; menu_kUserNameRows is EXT SHORT at736bfa, not an array. NumberOfRows is
AUTO ARY SHORT at5152c0,dim6,size12,slot-0x28 in the first function block. The
only other native local is short i. Its genuine array dimensions and values are
preserved; no invented declarations replace removed names.

## Strong proof

- Whole TU92/92 PASS; zero branch-distance/count differences.
- TransitionOn141/141, exact debug twin.
- Actual same-source-path37180-byte ELF is byte-identical before/after:
  1eb642e6b40eb40eeb8c6e198d711f468fc51731a1997c822c5ed1ecd3a2cbf6.
- Every symbol, data byte and relocation therefore remains unchanged.
- All141 oracle words checked directly against rom/nfs4-f.exe.
- Raw NumberOfRows at80010A00 is exactly {7,9,9,9,8,9}; the global SHORT
  menu_kUserNameRows cell at800529B0 is zero in the image.

The new debug assembly places NumberOfRows immediately alongside i in the
function's first block, AUTO val-40,dim6,size12,type0x33(ARY SHORT), exactly
matching native scope/type/slot. The initializer remains after the sprintf
loop, respecting retail SLD1989; the following row-count store stays1990.

The stale earlier scope rejection moved the initialization itself to function
entry. Removing only the artificial inner braces corrects scope without changing
execution order or bytes. That failed interpretation/comment was removed.

All individual probes and their combined form pass92/92. No unrelated carriers,
headers, production tools, or other source files were edited. No new names,
asm/volatile, fake arrays, or postcompiler rewrites. Parent handles commits.
Source backup baseline.cpp; object backup build/p882/original_femenuoptions.cpp.o.
receipts.json records compiler commands, target results, and exact evidence.
