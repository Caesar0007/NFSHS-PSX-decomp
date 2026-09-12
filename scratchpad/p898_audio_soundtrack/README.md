# P898 AudioTrk_SoundTrack: remove the unrecorded curBack local

Isolated proposal only. Production remains the published P897 source; the
parent is independently investigating PreLoad. No normal build output, shared
header/tool, production source or repository index was changed by this task.

## Proposed change

Replace the curBack declaration and its explanatory/carrier comments with:

```cpp
fade = fadeOut - (long long)(cur - 128);
```

The cast keeps the existing grouped int subtraction distinct while permitting
ordinary int assignment. It removes an unsupported source name; it does NOT
establish the original cast spelling. Native SYM records all involved values
as INT. The old comment's claim that curBack is optimized away is false: the
baseline debug assembly contains `.def curBack; .val 2; .scl 4; .type 0x4`.

## Native evidence and arithmetic

- Function record1beff5..1bf3f4: AudioTrk_SoundTrack,8007CDC4..8007D35C,
  frame120, maskC0FF0000, original source lines310..473.
- Native cur is AUTO-64 (record1bf1ba); fade is REG19/s3 (1bf2dd), fadeIn
  REG3/v1 (1bf301), fadeOut REG4/a0 (1bf315). There is no curBack record.
- Native fadeOut load/shift is SLD427, nonzero test429, upper cutoff431,
  zero assignment432, lower test433 and fade assignment434.
- Retail8007D118 computes cur-128 in the conditional branch's delay slot;
  8007D11C subtracts that result from fadeOut. This proves machine grouping,
  not an extra original source local, macro, helper, or cast.
- On the assignment arm, fadeOut=(unsigned char)randomDelay<<3 and nonzero,
  so8<=fadeOut<=2040. The preceding comparisons prove
  fadeOut<cur<=fadeOut+128. Thus cur is9..2168, cur-128 is-119..2040, and the
  final difference is0..127. The int subtraction, long-long promotion,
  widened outer subtraction and narrowing assignment all have exact defined
  mathematical results on this arm. No overflow behavior is changed.

The updated m2c body `C:/Temp/nfs4-clean/Binaries/NFS4-B-USA/c/func_8007CDC4.c`
and split Ghidra body
`C:/Temp/nfs4-psx/nfs4-psx-Ghidra/functions/FUN_8007cdc4.c` independently show
the nested subtraction without a separate source temporary. IDA folds this
body to return0; JEB has a decompilation error. The NFS4 PC/NFS3/NFS2 ambient
algorithms examined have different proportional/inverse-distance fades and
do not establish a transferable original helper or local name.

## Verification

- Baseline and widened candidate:6/6 functions PASS,1004 total instructions.
- All159 whole-TU branch-distance entries unchanged and clean.
- Entire normal object literally byte-identical:
  `899e721b9a1c006da6e4d0119c265102119cc63241b97d46059f2d36db946c5d`.
  This includes all section/storage bytes, symbols and relocation entries.
- Both exact-g objects have identical `.text` to their normal objects.
  All six instruction-to-source-line equivalence partitions are unchanged;
  all five neighbors preserve their complete local/scope/instruction graph.
- All25 native SoundTrack local definitions are retained with unchanged
  types/homes/order and emitted owning block spans/depths. Only curBack is
  removed. Its six induced scope records disappear: emitted blocks29->23,
  native21. None of this proves complete original scope recovery: all25
  named owner tuples retain existing differences from native (including
  nesting-depth differences).
- SoundTrack native SLD disagreement remains115 merged pairs/132 split
  pairs, with ZERO new merges or splits. All neighbor disagreement counts
  are unchanged. Native433 keeps8007D114/118 together;434 remains8007D11C.
- Complete SoundTrack358/358 words (1432bytes) resolve to the raw ROM,
  including26 relocation words. SHA256 of native body:
  `1e289ec5680cce46e7cee1807be8088403fe498ae0fe731030e13210e869ddd8`.
  Verification evaluates relocations in memory; it never writes an altered
  object, instruction file or linked image.
- Debug LM/LBB/LBE names were asserted unique before assembly (317 each).
  Separate GAS-L diagnostics retain existing lexical labels without changing
  compiler output; original assembly hashes and all code/data bytes are
  checked unchanged. No labels were injected, renamed or rewritten.

## Frozen experiments

| Source expression/state | SoundTrack result | Other5 |
|---|---|---|
| Original curBack | PASS358 | PASS |
| Direct fadeOut-(cur-128) |20diff/358 | PASS |
| fade=cur-128; fade=fadeOut-fade |45diff/359 | PASS |
| cur-=128; fade=fadeOut-cur |1diff/359 | PASS |
|128-(cur-fadeOut) |5diff/359 | PASS |
| fadeOut-(long)(cur-128) |20diff/358 | PASS |
| fadeOut-(unsigned int)(cur-128) |20diff/358 | PASS |
| fadeOut-(long long)(cur-128) |PASS358; identical object | PASS |

Direct arithmetic reassociates to (fadeOut+128)-cur, reuses the guard's
sum, and changes the local register web; the delay slot becomes nop.
Mutating native cur preserves the intended register web but emits one extra
store to its address-taken stack cell. The widening retains the int inner
group until later compiler lowering without requiring that storage write.
Failed stages and their exact source copies remain frozen; no failed form
was applied to production.

## Receipts and proposal safety

`before.json`, `widen_group.json`, `verification.json`,
`raw_target_receipt.json`, `debug_labels_receipt.json` contain the detailed
normal/debug/local/scope/SLD/raw evidence. `proposed.patch` is the minimal
production hunk. `proposal.json` records source/header/artifact hashes;
`check_proposal.py` is read-only and rejects any changed baseline input.

These are local historical receipts with dependencies on existing scratch
ELF/debug parsers. They are not claimed standalone without those dependencies
and the local ROM/compiler inputs. Parent must combine its separate PreLoad
proposal and independently validate the actual production file afterward.
