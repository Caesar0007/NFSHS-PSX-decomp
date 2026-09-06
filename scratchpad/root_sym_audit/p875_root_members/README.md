# P875 independent object/track member proof

**PASS: 9/9 native member/constructor references remain available after removing nine false free-function declarations.** No production file was edited by this independent proof.

`object_members.cpp` includes the repaired `object.h`; `track_members.cpp` includes the repaired `track.h`. Six typed member-function pointers select the actual members. Three placement-new caller functions force real constructor references, since C++ does not permit taking a constructor address. The scratch placement-new overload is inlined; neither probe emits any unexpected external reference.

Both probes compile using real CPP and CC1PLPSX with ordinary C++ and no asm. Both retain the pre-existing `game_common_min_types.h:60` anonymous-class warning; there are no compiler errors. All9 exact emitted native symbols are global function exports in the existing objects, and the objects' SHA256 values equal the root's unchanged before/after receipts.

| Public header | Real member API | Native SYM record | Retail VA |
| --- | --- | --- | --- |
| object.h | `ObjectFinishedMultiAnim::Draw` | 2d90e0 | 800a61f8 |
| object.h | `ObjectMultiAnim::ObjectMultiAnim` | 2d912c | 800a6200 |
| object.h | `ObjectMultiAnim::Draw` | 2d91c2 | 800a62f8 |
| object.h | `ObjectFinishedSignAnim::Draw` | 2d9206 | 800a671c |
| object.h | `ObjectSignAnim::ObjectSignAnim` | 2d9251 | 800a6764 |
| object.h | `ObjectSignAnim::Draw` | 2d92e7 | 800a6a38 |
| track.h | `SaveSurface::Save` | 36d7a9 | 800baf0c |
| track.h | `SaveSurface::SaveSurface` | 36d7db | 800baf70 |
| track.h | `SaveSurface::RestoreAll` | 36d825 | 800baffc |

The private class declarations remain in unchanged `object_types.h` and `track_types.h`. The public headers include those type surfaces; removing the duplicate encoded-name free declarations therefore does not remove the C++ member APIs. Existing destructor/raw C bridges and Newton asm-linkage aliases were not changed or reclassified by this proof.

Reproduce from `C:/Temp/nfs4-decomp`:

```powershell
python scratchpad/root_sym_audit/p875_root_members/verify_members.py
```

`receipt.json` contains exact removed declarations, native FCN records, emitted symbols, actual object symbol-table rows, compiler commands/diagnostics, and source/object hashes. Compiler `.i`/`.s` intermediates are not source deliverables.
