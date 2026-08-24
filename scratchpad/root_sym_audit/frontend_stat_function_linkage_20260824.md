# Frontend `STAT` function linkage closure (2026-08-24)

Retail SYM records these three `femenudefs.cpp` callbacks with internal
translation-unit linkage:

- `MenuExtended_GoToDealer(tMenuCommand &)`: `STAT`, 26 instructions;
- `MenuExtended_GoToSeller(tMenuCommand &)`: `STAT`, 26 instructions;
- `MenuExtended_GoToUpgrades(tMenuCommand &)`: `STAT`, 16 instructions.

Their only source references are later in the same translation unit, where they
are installed as menu callbacks. Adding `static` restores the recorded linkage.
The rebuilt object now marks all three symbols local (`l F .text`) at the same
text offsets and sizes, and detailed oracle verification remains PASS for all
three.

Fresh strict frontend/common audit results:

- all 779 selected SYM functions map to reconstructed definitions;
- missing SYM local names: 0;
- function storage-class findings: 0 (previously 3);
- missing/extra global definitions: 0/0;
- global storage-class findings: 0.

The full frontend/common gate remains 835/838 PASS with no compile failures. Its
two 2-diff functions and the existing `tGlobalMenuDefs` constructor residual are
unchanged. Recon relink remains green with zero real duplicates and zero genuine
unresolved references; the vtable indexing audit passes all 926 files.

Only the three `static` tokens belong to this change in the pre-existing dirty
`femenudefs.cpp`; the other worktree edits in that file remain unstaged.
