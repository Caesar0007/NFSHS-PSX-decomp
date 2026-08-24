# Full-link jump-table/vtable/reference backlog closure — 2026-08-24

## Root cause

`tools/build.py::link_and_verify()` invoked GNU `ld` with linker scripts but no
source object inputs. The `*/src/...` entries in `linkers/nfs4.ld` are section
placement selectors; GNU `ld` does not use those wildcards to discover files.
Consequently the raw data objects were loaded while almost every code owner was
absent, producing 1,835 undefined-reference diagnostics across 960 unique
names, including jump-table `.L<VA>` targets, vtable functions, and SDK calls.

## Corrections

- `tools/build.py` now writes an ld response file from the 461 live `src/**/*.c`
  paths and passes those objects explicitly. The manifest is source-derived,
  so stale build/probe objects cannot enter the retail link.
- `linkers/retail_data_symbols.ld` supplies 63 MAP/SYM-authoritative named
  aliases for storage already owned by raw data/BSS sections. `PROVIDE` avoids
  duplicate allocation and yields when a future reconstructed vars/data TU
  supplies a real definition.
- `nfs3_externs.h` now gives `Speaker_vtable` its retail GCC linkage spelling,
  `_vt_Q26Speech7Speaker`; `Nfs2_SystemNLibStartUp__Fv` remains 25/25 PASS.
- `tools/relink.py` derives both lanes from live source paths instead of stale
  `build/**/*.o` scans and separates final-link-provided symbols from genuine
  unresolved object references.

## Receipts

Fresh `python tools/build.py`:

- all C and C++ TUs rebuilt;
- final GNU ld completed with zero undefined references;
- the produced image remains non-identical for the independent legacy linker
  layout backlog: 21.14% byte match, first difference `0x878`, size delta
  `-32`. This is not an unresolved-reference failure.

`python tools/relink.py --lane both -v`:

- recon: REAL duplicates 0, hidden phantoms 0, genuine unresolved relocations
  0; six relocations explicitly classified as final-link supplied;
- src: REAL duplicates 0, hidden phantoms 0, genuine unresolved relocations 0;
  200 relocations explicitly classified as final-link supplied;
- gate GREEN. The recon lane's 962 raw-blob ownership duplicates remain its
  separately tracked shrinking data-materialization class.

Additional guards:

- `python tools/audit_vtable_indexing.py`: PASS, 926 files;
- `python tools/verify_asm.py recon/game/common/nfs3.cpp
  Nfs2_SystemNLibStartUp__Fv`: PASS, 25 instructions;
- `git diff --check` on the touched files: clean apart from existing line-ending
  normalization notices.
