# P883 Front scalar memcard-state cleanup

Retained in front.cpp only: remove MEMCARDFRONTENDISINITTED_words[] and its
asm-label binding, using the existing scalar bool with two false assignments
and one true assignment. The obsolete view-necessity comment was removed.

Native SYM2c74e8 is EXT BOOL MEMCARDFRONTENDISINITTED at8013D284. The shared
public declaration and owning nfs3.cpp definition already use bool, four bytes
under this target compiler. Raw cell bytes are00000000. No type or ownership
change was needed outside this consumer CPP.

## Verification

- Whole TU43/43 PASS; zero branch-distance/count divergences.
- InitialMemCardCheck19 and SecondaryMemCardCheck50 have exact debug twins.
- All69 oracle comment words equal raw ROM.
- Actual same-path39004-byte ELF objects are byte-identical before/after:
  aa730506c2578190bce89be3559cef70c4494582b1af0d37a37497f5a4c8c5fb.

Every code/data byte, symbol and relocation is therefore preserved. Native
initial-check block595777 has no locals; secondary-check block5957eb retains
outer j and nested i unchanged, as does its SLD/control-flow ordering. No other
carriers, constructors, naming work, shared headers/tools/data/link files changed.
No new names, asm, volatile, helpers, or output rewrites. No commits by agent.

Source backup baseline.cpp; binary backup build/p883/original_front.cpp.o.
receipts.json records the native records, exact hashes and whole-TU probe results.
