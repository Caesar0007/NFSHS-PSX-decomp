# Ordinary-C PSX matching variants

This lane pursues retail **instruction-byte identity**, separately from the
endian-independent C ports. It contains no ASM, register pins, opcode bodies,
compiler fences, or instruction rewriting. The production PSX build is untouched.

## Accepted entries

| Retail body | VA | Exact words | C source |
|---|---|---|---|
| `shapecount` | `0x800F0AAC` | 3/3 | `shapecount.c` |
| Shared NULLFUNC body (`setclipwindow` and co-equal release aliases) | `0x800F6114` | 2/2 | `null_result.c` |

The first routine uses an aligned native-little-endian word view. This is a
PSX-specific contract; it does not replace the general byte-endian reader in
`ports/eaclib/shape_sine_port.c`. The null function proves the shared body,
not invented host prototypes for all release aliases.

The matching gate uses the original PsyQ 4.3 compiler and normal maspsx/GNU-as
pipeline, then **actually links each function at its retail VA**. It compares
all function text bytes with both the ASM oracle and `rom/nfs4-f.exe`.
There is no relocation-name/branch-target normalization in this gate.
Debug/ELF metadata outside function text is not claimed to match.

`../verification/exact_matches.json` contains the linked ELF, source/text/ROM,
and native/runtime hashes plus **331 live DuckStation/native comparisons**.
Every GPR except the declared result was checked for unexpected changes, the
two routines were checked for memory writes, and full emulator state was restored.

Run from the repository root with NFS4's dedicated test VM on port2350:

```powershell
powershell -ExecutionPolicy Bypass -File tools/duckstation/launch.ps1 -FastBoot
python ports/tools/verify_exact_matches.py
```

The optional host CMake target is separate too:

```powershell
cmake -S ports -B ports/build/cmake -G Ninja -DCMAKE_C_COMPILER=gcc -DNFS4_BUILD_PSX_MATCH=ON
cmake --build ports/build/cmake
```

## Work still open

Only **2 of the 24 whole routine bodies** have accepted ordinary-C byte-matching
variants here. The other 22 are not marked done or impossible.

The bounded source search in `tools/search_psx_match.py` tried 68 counter/body
forms for `divu64` and 92 product/carry forms and scheduling settings for
`fixedmult`. Its current best results reach retail instruction counts
(16/16 and 11/11) but differ in actual instruction words. They remain scratch
inputs, not accepted C implementations. The union/carry multiply reaches the
same overall operation structure without assembly; its homes/order still differ.
`../verification/source_search.json` records every measured candidate.

The word-edit metric only helps select a next source-shape basin; it is not
a semantic gate or proof of impossibility. Full exact text is required to land.
The search is limited to those two routines and the accepted small entries,
not a completed matching search for all 24.

Seven general-port bodies intentionally expose a different ABI/state contract
(fixeddiv exception result, make64 status, RNG state, and GP contexts). They
need separately specified original-ABI variants before an honest byte match
can be attempted. None of those host-facing APIs was weakened to improve a score.

### Reader/seed round

`../verification/reader_search.json` records 45 successful probes across retail
PsyQ 4.0, 4.3, and 4.4 C compilers: packed-reader expressions, byte-count
types, explicit `getm` branch layouts, aligned directory views, and an
original-ABI unrolled `seedrandom` against the real global-state address.
PsyQ 4.0's first launch failed due to its legacy temporary-file path; assigning
a task-local temporary directory fixed that infrastructure failure, and the
successful rung was then measured. The failed launch is not a compiler verdict.

Best current reader results are still **not exact**: `geti` reaches 8/8 words
but retains register/order differences; explicit `getm` layout reaches 26/26
and improves the word-edit distance from 25 to 21. The original-ABI seeder is
27/28, and the direct directory-pointer variants still differ too.
Unmasked C shift probes have a narrower count1..4 source domain and were not
promoted as general replacements; the accepted portable reader keeps defined
masked-shift behavior for all uint32 counts.

`../verification/modern_reader_search.json` records another 42 defined-C
reader/optimizer probes under MIPS GCC14. No fixed-register flags were used.
The best remains 8/8 instructions with six differing positions, not PASS.
These bounded searches do not close the source-shape work or establish floors.
Accepted exact coverage therefore remains **2/24**.
