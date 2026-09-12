# P915 actual DrawW integration — independent transfer PASS

Actual ELF:
`a1a26c7c05be70d50e12f2c2646b9a311772d685b659fd98d47429ca77265195`.
Actual map:
`9be26f7a1a26bc2301f8b04490d3e22efd572b8656027ce4cf273b41b552ef23`.

The actual DrawW object and complete linked image match the frozen private
proof in header, program headers, section order, payload/storage metadata,
ordered symbols and ordered relocations. The **only permitted metadata
difference** is one exact private-to-actual DrawW FILE record. No arbitrary
symbol, address, local UID or other metadata normalization is used.

All **5,253 mapped input/section placements** agree after the exact DrawW
object and retained raw-prefix path mappings. Both new raw objects are
literally equal across private, build and expected; the small-data raw object
remains unchanged. All other **693 original objects** remain byte-identical.
The actual 41-owner registry and predicate AST match the reviewed proposal.

This exact transfer preserves the independent proof of **265 native reference
words** (70 own and 195 foreign), all 14 native storage objects / 1,812 bytes,
3,896 previously native public records, 109 FILE-qualified LOCAL records and
3,238 native functions. The 34 GP fixes and all 1,372 prior correct GP sites,
all 1,280 existing-relocation changes and no-new-overlap/no-code-movement proof
also transfer unchanged. This is an exact transfer of the primary-backed
reference proof, not a separate re-execution of its per-reference decoder.

All watched inputs rehash unchanged. No build, link, production edit or normal
output write was performed. Original Night caller-bound spelling and historical
flag spelling remain unproved; existing unrelated source/SLD/layout debt is
not declared complete.

Receipt: transfer.json. Checker: ../check_actual_transfer.py.
