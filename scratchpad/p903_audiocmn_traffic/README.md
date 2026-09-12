# P903 TrafficSFX — remove the non-SYM fade pointer

Isolated, target-only proposal for `AudioCmn_TrafficSFX__Fiiiiiiii` at
`80079104`. Production files and normal outputs were not edited by this agent.
Root's independent SoundCar work in the same TU is outside this proposal.

## Result

- **48/48 PASS**, all **513** branch diagnostics exact/clean.
- Entire normal object literally identical to the freshly rebuilt baseline:
  `ed64e014b7631f897017264894068e480bb7bdd5dd1d6af284a2eefb18947e5a`.
  Thus all code/data/storage, ordered symbols and relocations are unchanged.
- Entire `-g` text matches normal text. All 47 neighbors preserve full
  instruction/local-label/scope graphs, declarations and native SLD partitions.
  P902 LoadAsync remains **0 merges / 9 splits**, with its existing explicitly
  unresolved `s`/empty-scope debt preserved, not recertified as original.
- Target **163 raw words / 20 relocation words** exact. Native `Xfade[129]`
  at `8010E68C` is also byte-exact; its definition/initializer is untouched.
- Removed the unsupported `fade` source local **and its emitted REG19 PTR
  UCHAR debug declaration**. Emitted scopes **3 -> 1**, exactly the single
  native `80079104..80079360` root block.
- All 15 ordered native parameter, register-copy and local records now agree.
  Local order/homes are `iAmpIn` REG20, `player` REG4, `pitchmult` REG16.
- SLD **49 merges / 46 splits -> 0 / 10**, no new bad pairs.

Before source SHA256:
`ea914b6e9f5a712cf7f176385268e890fb9651f38396a062f4c5a3a4316cd629`

Comment-bearing candidate SHA256:
`868fd27b13e641bb0508dd6f16de30156ebd1ebd964902a6e0174eddbd6f8849`

## Source and compiler evidence

The complete native function record `19311c..1932ab` names only the three
locals above. `193f5d` declares genuine EXT ARY CHAR `Xfade[129]`. The alias
was not native and need not survive as a new semantic/helper name.

Both engine-patch lookups are separate native statements: SLD2226/2229,
followed by PlaySFX argument/call groups2227/2230. Staging the second lookup
through the existing native `player` corrects the prior nested-call boundary.
An ordinary early `return` after the three channel-freeing calls gives the
native2220 exit its own source boundary, separate from call2219. Reordering
the three uninitialized declarations restores native declaration order.

The retained index expressions use direct array accesses, with the grouped
subtraction evaluated through a wider type and then converted back to int:

```
Xfade[(int)((long long)((dir >> 12) + 64) - (dir >> 10))]
Xfade[(int)((long long)(dir >> 10) - ((dir >> 12) - 64))]
```

This is the same source expression-boundary technique used in P898 SoundTrack.
It does **not** claim that these exact cast tokens occurred in EA's source.
There are no new names, macros, qualifiers, asm, volatile accesses, flags,
fences or post-compiler rewrites. All historical fence comments are removed
from this target; the fences themselves had already been removed before P903.

On the target's signed 32-bit arithmetic-shift semantics, `dir >> 12` is in
[-524288,524287] and `dir >> 10` in [-2097152,2097151]. Every addition and
subtraction shown is safely in int range (even the independent conservative
bounds are under three million). Widening and converting back therefore
preserves the computed index for every int `dir`. This does not assert that
every arbitrary `dir` is a valid table index: array-defined inputs remain
the same, and caller/domain recovery is not bypassed by a mask or clamp.

### Why source shape matters here

Read-only GCC2.8.1 source evidence:

- `cp/typeck.c:2129` `build_array_ref` builds **ARRAY_REF** for direct arrays.
  Its pointer path at2250 instead builds an indirect reference over PLUS_EXPR.
- `expr.c:4402..4440` subsequently expands an ARRAY_REF's index via element
  size and size-type offset arithmetic.
- `fold-const.c:983..994` `split_tree` strips conversions **only if the
  machine mode is unchanged**. Its association path around4281..4382 extracts
  constant terms and rearranges grouped addition/subtraction. A DI/SI boundary
  is therefore materially different from redundant int/signedness casts.

Observed stock compiler output agrees with that mechanism: ordinary direct
indices reassociate the first `(dir12+64)-dir10` into
`dir12-(dir10-64)`, and the second into `(dir10+64)-dir12`, changing destructive
updates, register allocation and the earlier branch-delay sentinel placement.
The widened grouped expressions restore retail's exact chains. This is
compiler-source reasoning plus exact output evidence, **not a claimed captured
tree/RTL trace** and not proof of unique original token spelling.

The independent `reference/body_evidence.md` additionally records split M2C,
Ghidra, IDA and NFS2 matched-source evidence. The NFS2 unsigned-char Xfade
accesses corroborate direct table use, but are not this PSX TrafficSFX body.

## Frozen probes

The second figure below is unified diff-line count, not an inferred percent.
Every compiled probe retained the other 47 normalized PASS functions.

| Stage | Instructions / diff lines | Observation |
|---|---:|---|
| before | 163 / 0 | Fresh baseline |
| direct | 164 / 51 | Remove fade only; reassociated destructive shifts |
| direct_staged | 164 / 51 | Stage second lookup; code neutral by itself |
| unsigned_value | 164 / 51 | Sibling-style unsigned-char result casts; neutral |
| wide_indices | 163 / 0 | Both grouped subtractions widened; scopes3->1, SLD4/10 |
| first_wide | 164 / 51 | Only first cast; rejected |
| second_wide | 163 / 4 | Only second cast; two instruction substitutions; rejected |
| native_decl_order | 163 / 0 | All three local declarations native ordered |
| explicit_return | 163 / 0 | Native2220 exit restored; SLD0/10 |
| candidate | 163 / 0 | Frozen result with concise truthful comments |

The ten remaining splits are the initial commMode guard versus assignment to
`player`, both belonging to native2204. They remain reported. No same-line
statement packing or exotic side-effect conditional was added merely to erase
that metric. No full source/SLD completion is claimed.

A diagnostic-script generation attempt accidentally interpreted JavaScript's
replacement-string `$'` sequence while copying a regex; it failed to parse
before any verification ran. The failed text is preserved as
`verify_generation_failure.txt`; final checks use `verify_candidate.py` with
the corrected literal callback. No source or compiler output was affected.

## Artifacts and reproducibility

`proposed.patch` changes only TrafficSFX; `proposal.json` records hashes.
`candidate.json`, `candidate_inspection.json`, `candidate_raw_target_receipt.json`
and `debug_labels_receipt.json` contain machine-readable verification.
`input_hashes.json` freezes the actual compilation/oracle/compiler-source inputs.

```
python scratchpad/p903_audiocmn_traffic/verify_candidate.py candidate
python scratchpad/p903_audiocmn_traffic/raw_target.py candidate
python scratchpad/p903_audiocmn_traffic/check_proposal.py
```

Do not reuse a frozen stage name for a new compile. The isolated gate uses the
actual whole-TU `-G8` profile and production comparison functions on prebuilt
objects. Debug labels must already be unique. Assembler `-L` only retains
existing anchors from hash-checked unchanged compiler assembly; nothing is
injected, renumbered or patched after compilation.
