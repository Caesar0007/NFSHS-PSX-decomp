# P878 CopSpeak_Flush scope restoration

**Retained only the native for-scope of `i`.** All attempts to remove the unrecorded `request` pointer were restored. No carrier-count reduction is claimed.

Native SYM26bcc8/26bcd1/26bcda places `int i` (REG3) in the nested loop scope at8009a944–8009a98c. The source now declares it in the `for` initializer. Generated debug preserves i's type/register and restores that scope; the pre-existing `request` remains REG2/PTR CopSpeak_tRequest in function scope.

Verification: target **PASS20/20**, exact code twin; whole TU **27/27 PASS**, branch0; raw oracle **20/20 words** verified. Entire production object SHA remains **70fc97ebe71e9feeb970a4af6af67f16969a2171d4a82bfc1a35834376f9807e**, identical to P877 and the independently recorded P875 object. A normalized source comparison confirms every character outside Flush is unchanged since the stable P877 snapshot.

The failed probes expose two distinct source issues:

- Direct plain bank assignment preserves the object-base anchor and sb30, but produces li255 under the current plain-char context rather than retail li-1.
- Signed pointer/reference/row views preserve li-1 but hoist the bank-adjusted base and use sb0 rather than sb30. Natural pointer addition, widened/integer address forms, and the signed row view were all count-exact2diffs.
- Compound self-subtraction and GNU scalar lvalue casts still produce li255. Neither is retained.

`receipt.json` lists all9 failed variants. No asm, volatile, invented identifier, shared type edit or production tool change was added. Shared bank signedness/context is a future type-audit angle, not a declared compiler floor. Native-only local coverage and full SLD expression grouping remain open because request still exists and the pointer assignment/bank store are separate source statements.

Focused before/after snapshots are included. Generated debug/object evidence is in the normal build tree; the baseline Flush debug body is also preserved in the P877 whole-TU snapshot. Do not commit compiler intermediates.
