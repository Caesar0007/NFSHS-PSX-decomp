# P894: AI native fields and ScreenPost's true local set

Completed 2026-09-08. The preceding P893 Camera graph remains intact. This
checkpoint adds exactly four production-file edits: ai.cpp/ai_externs.h and
base/USA screenpost.cpp. No production tools, shared headers, compiler flags,
data owners, volatile or executable asm are added or changed.

## Retained source recovery

AI now uses the actual BWorldSm_slices pointer and native laneCount,
pavedProfile and center fields at ten accesses in five functions. The
AI_BWorldSmSlices asm alias and both offset macros are removed. The existing
ai_types.h definition already supplied the native type; it is unchanged.
Native local names/scopes are preserved at this checkpoint, with remaining
scope recovery explicitly separate from field recovery.

All40 actual-production AI functions remain PASS with identical branch
counts/offsets, line partitions and ordered local/parameter/storage records.
Complete compiler debug function bodies are unchanged after excluding only
absolute .loc lines; lexical block markers and relative block lines are
retained in that comparison. All36 pointer-reference words match raw retail.
See ../p893_slice_alias_audit/README.md and landed_verification.json.

ScreenPost Initialize now assigns the native flag separately and computes
fCountSpeed using one nested compiler maximum expression. The invented
SCREENPOST_SET_COUNT_SPEED macro, max_money and max_damage are removed from
both base and USA. No replacement local/helper/macro name is introduced.
The native source tokens for the maximum operation remain unknown; `>?` is
not advertised as a recovered original spelling.

The old macro comment attributed the operation to line118. Actual SLD places
the flag store at113 and the max/max/divide group at115;118 belongs to the
else path. This correction removes21 false merge pairs in Initialize:
29->8, with splits29 unchanged and no new bad pairs. Both before/after
Initializes keep99 exact words. All198 raw words, including16 relocated
words, match the actual base/USA images. The only debug declarations after
removal are native this/r16 and tInfo/68-byte AUTO-88. Empty/nested native
block topology remains unrecovered (current compiler directives8->2).

Actual base13/13 and67 branch checks pass; USA's three available manifest
targets pass. All26 function instances have local/line-partition receipts;
the24 neighboring instances are unchanged. USA native-relative pair counts
are a base-SYM projection, not independent regional SLD. Debug label uniqueness
is asserted before assembly:234 base/239 USA; zero instruction or label rewrites.
See ../p894_screenpost/README.md and verification.json.

## Full coordinated proof

All three full build lanes completed without skipped/failed translation units.
The expanded protected regression is **705/705 functions in32 base TUs**, with
branch divergence0 and source-receipt hash drift0. Vtable/source policy,
linker checks, both standing relink lanes and strict declaration audits pass.

Of518 normal source objects, **517 are literally identical to P893**. The only
different object is AI:

- Before: `e720de2b3f03579db90da0865ad7521565067803ee0d7a918590fe12eabe2e4d`.
- After: `9189b0c2946f70621dc418f3738dce998bc67f1c96c0980a9e43e1a5d8772677`.

The hardened metadata check proves identical code/data/storage, semantic ELF
headers/schemas, complete symbol multiset (including FILE/local identities)
and ordered relocation entities. Only symbol/string ordering and corresponding
numeric relocation indices change. There are no UID renames and no normalized
away source/reference defects. Both actual ScreenPost objects remain literally
identical to their prior production-path hashes.

The diagnostic linked ELF is **literally unchanged**, SHA256
`bf66bf489f36b0c7236bbcff855ed2480f36f1fe4a889c20b22bb3e033e0592e`.
All prior native-reference fixes and prior layout/GP debts are preserved.
Standing851 blob duplicates, zero REAL duplicates, phantoms and referenced
unresolveds remain unchanged. The permissive link is not a final-image seal.

Strict frontend/common remains780clean,48extra,438source-only carriers,
0missing,9type/9storage findings and3mapping reviews. Game/common remains
1228clean,6extra,478carriers,0missing,28type/28storage and0mapping review.
These declaration counters did not count the macro-private max locals as
ordinary function-body locals. Their unchanged totals do not negate the
actual source/debug-local and SLD correction, or prove the remaining carriers
are original. The exhaustive source/SYM/SLD objective is still incomplete.

CI-style build/p894_report.binpb was generated successfully. The user's
scratchpad/w85/o2.txt retains SHA256
`d433425b806fc8abd1fa60c9f72a09f4c022bfd64a7fecf4df496931169e9546`.
All earlier receipts and unrelated edits remain preserved. No commit or push
was performed. Primary receipts are final_receipts.json, metadata_receipts.json,
source_receipts.json, validation_commands.json, relink.json and both strict
reports. The next isolated AI scope/NewBestLap proposals are not part of this
P894 full-build snapshot until independently landed and revalidated.
