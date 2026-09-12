# P900: AudioTrk lifecycle source recovery

Verified proposal only, 2026-09-12. No production, normal build, shared-header,
tooling or publication writes. Both mandatory references and repo guides were
fully reread before work. Root owns independent AddCustomObject/SoundTrack work;
the full P899 source/include closure is frozen privately here.

## Result

- StartUp: **23 words PASS**, native SLD **0 merges / 3 splits to 0/0**;
  all four native blocks and its native `i` owner restored.
- CleanUp: **38 words PASS**, native SLD **0/9 to 0/0**;
  all four native blocks and its native `i` owner restored.
- Whole TU: **6/6 PASS**, **159 branch comparisons**, entire normal object
  literally byte-identical before/after.
- All four non-target local/type/home, source-label PC, lexical scope and debug
  instruction contracts unchanged. Reset remains 0/0; SoundTrack retains its
  25 owners and 19-block projection; PreLoad/AddCustomObject are untouched.
- **61/61 raw instructions** equal `rom/nfs4-f.exe`, including 14 resolved
  relocation words. Resolution is in verifier memory only; outputs are not
  rewritten. Existing diagnostic GAS `-L` retains original debug anchors without
  editing assembly; normal compiler/codegen flags remain unchanged.

Run `python scratchpad/p900_audio_lifecycle/propose.py` for the exact two-hunk,
hash-checked patch. It validates the nine source/header inputs and final receipts
and only prints the proposal. `proposal_verified.json` is the combined receipt.

## Source forms and native evidence

StartUp now declares `int i` in its `for` initializer, removing the hoisted
function-scope declaration. Its sole assignment is the loop body without a
redundant compound wrapper. This puts body and loop-back instructions in native
line 93's one statement group (indices 13..16) and restores `i` at depth 3.

CleanUp uses `for (int i = 0; i < 0x10; i++)` instead of hoisted initialization
plus do/while and explicit increment. It removes the redundant final `return;`.
Native line 546 then owns indices 24..27 together, while native line 548 owns
the final null store and epilogue (31..37). Calls, stores and iteration order
remain byte-exact.

Native SYM source:
`C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt`.

| Function / native block record | Half-open native span | Depth |
|---|---|---:|
| StartUp 1beab4 | 8007C6F4..8007C738 | 0 |
| StartUp 1beabd | 8007C6F4..8007C738 | 1 |
| StartUp 1beac6 | 8007C704..8007C738 | 2 |
| StartUp 1beacf, owns i at 1bead8 | 8007C704..8007C738 | 3 |
| CleanUp 1bf5f6 | 8007D52C..8007D5AC | 0 |
| CleanUp 1bf5ff | 8007D52C..8007D5AC | 1 |
| CleanUp 1bf608 | 8007D554..8007D5AC | 2 |
| CleanUp 1bf611, owns i at 1bf61a | 8007D554..8007D59C | 3 |

StartUp `i` remains REG INT $3/v1, frame24/mask80000000,-8.
CleanUp `i` remains REG INT $10/s0, frame32/mask80070000,-4.
Their full native SLD/current-source partitions and before/after scopes are in
`candidate_verification.json`. No macro, helper, identifier, qualifier or asm was
introduced. Original token spelling and physical source-line counts remain
unsealed; zero partition conflicts do not by themselves prove original text.

Raw M2C cross-checks were read from
`C:/Temp/nfs4-clean/Binaries/NFS4-B-USA/c/func_8007C6F4.c` and
`func_8007D52C.c`. They agree on calls, loop stores/bounds and cleanup ordering.
StartUp M2C's extra arg0 and forwarded Reset argument are stale-register artifacts;
SYM and raw code retain the existing zero-argument signatures unchanged.

## Frozen stages and hashes

`before`: actual P899, StartUp0/3 and CleanUp0/9, hoisted i declarations.
`startup_for`: StartUp0/0 with four exact blocks; CleanUp still0/9.
`cleanup_for`: both0/0 with eight exact blocks.
`candidate`: fresh whole-TU/debug/raw revalidation of the paired result.
Each named intermediate source/output receipt is preserved. No failed source
experiment was retained. A first raw-report filename attempt reused a numeric
address variable; this reporting-only error was corrected and rerun, without
changing source or compiler output.

Production baseline SHA-256:
`7fff98cd7b07e474d4e75d92e78fa7ed1125a67f97f2e8a658aee8bc402f3dda`.
Candidate SHA-256:
`09f1b846cb86420d2d8f2b57115938d98979529766d5731d8b8ca72094a2e28f`.
Normal object before/after:
`def2efe62c38185fd6b70583798d21e912b910c3bb9f06a6708aaa53d2b5525d`.
StartUp raw SHA:
`3570e19d4c020cf8f0098e10c9faaf86906ca4ca18a1d2ce650b5f9c4f6086ec`.
CleanUp raw SHA:
`f689fd1064b1b6e819cfb8b51691ead5478cd760e4bf68c2f225826419787d34`.
