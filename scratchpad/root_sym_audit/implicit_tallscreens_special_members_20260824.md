# Implicit `tAllScreens` special-member proof (2026-08-24)

Frontend/common SYM contains two functions that intentionally have no explicit
source body:

- `__11tAllScreens` at `0x8002baf4`;
- `_._11tAllScreens` at `0x8002bf0c` (object symbol `___11tAllScreens`).

Both records point to line 226 of `FRONT.CPP`, the `new tAllScreens` expression,
rather than to separate user-written constructor/destructor definition lines.
The reconstructed `tAllScreens` is a 15,320-byte aggregate with 24 class-type
members and no declared special members. `Front_ConstructAll` uses
`new tAllScreens`; `Front_DeleteAll` uses `delete`. GCC therefore synthesizes the
aggregate constructor/destructor from the member graph, exactly as indicated by
SYM's nested same-line `this` blocks.

Authoritative verification:

- implicit constructor: PASS, 262/262 instructions;
- implicit destructor: PASS, 116/116 instructions;
- rebuilt object symbols are local functions, matching SYM `STAT` linkage;
- frontend/common audit has zero functions needing mapping review.

Adding explicit source bodies would be less source-exact and would change GCC's
inline/member teardown decisions. The tracked audit now lists both records by
name, VA, source file, and role instead of hiding them behind a generic count.
