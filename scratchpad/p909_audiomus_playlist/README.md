# P909 AudioMus_BuildPlayList: verified native loop/scope recovery

Proposal only; production source, headers, flags, tools and normal build outputs
were not changed by this subtask. Parent's landed SwitchSong is preserved.

The candidate replaces the hoisted `i` plus manually rotated do/while with an
ordinary `for (int i = 0; i < numplaylistsongs; i++, playlist++)` inside the
existing nonnull guard. The body and its evaluation order remain unchanged.
Removing the redundant final void return then restores the final SLD group.
No names, helpers, macros, qualifiers, asm, volatile or pins are introduced;
compiler output was not rewritten.

## Native evidence

- SYM19fa05..19fae7: function8007AED8..8007AF60,34 words (0x88), no frame or
  saved registers. Parameters are numplaylistsongs:INT/a0 and playlist:PTR INT/a1.
- Four native blocks, all ending8007AF58:
  - depth0 starts8007AED8 (`19fa90`);
  - depth1 starts8007AED8 (`19fa99`);
  - depth2 starts8007AEE8 (`19faa2`);
  - depth3 starts8007AEE8 (`19faab`), containing only i:INT/register7/a3 (`19fab4`).
- Native SLD849 groups all four loop-tail words with the two-word epilogue.
  A final explicit `return;` separates these groups in compiler debug output;
  implicit function exit restores the native grouping without changing code.
- Raw and independent M2C confirm a bounded increasing counter, per-iteration
  pointer advance, nonnegative/in-range input filtering, and the same two stores.

## Frozen results

| Stage | TU gates | Branch checks | Target SLD merges/splits | Native scopes |
|---|---|---:|---|---|
| before |23 PASS|206|0/11|one root; i hoisted|
| natural for-loop |23 PASS|206|0/8|four exact|
| implicit_return — retain |23 PASS|206|0/0|four exact|

The entire normal object preserves code/data payloads, symbols/binding/offsets,
relocations and metadata except the exact checked scratch STT_FILE pathname.
All22 neighbors retain complete local, lexical scope, SLD and compiler-label
graphs, including SwitchSong0/0, PlaySong0/0, Threshold0/0 and Server39/29.
All34 target words equal the raw executable after resolving its three GP words
to primary native AudioMus_g8013C720. Both parameter homes and i's native INT/a3
home are exact. The complete preprocessor header stream is unchanged.

Receipts: `final_receipt.json`, `implicit_return_inspection.json`, all stage
sources/objects/debug twins and corresponding JSON. No failed source angle or
compiler-floor assertion is needed for this bounded result.

## Exact proposal

- Production input SHA256:
  `3526722bf1f236d38fd01b55f42cc1473b63a4364a121e4cec62d0b26aee24de`.
- Final `inputs/implicit_return.cpp` SHA256:
  `bdf67aef416c90ed4a0ee015ddffb2264667812fabf7dbbc6d08defa80042b73`.
- Apply-ready `proposed.patch` targets the absolute production path.
- Native34-word SHA256:
  `ca2eac6d5e294c0f0557a85fc8f2b907bbdbef70c84cd523da1c2d2f35f2128e`.

Parent must validate the landed actual paths before publication. This establishes
the native observable statement partition and lexical/local contract for this
function, not exact original physical whitespace or all surrounding source/header
identity.
