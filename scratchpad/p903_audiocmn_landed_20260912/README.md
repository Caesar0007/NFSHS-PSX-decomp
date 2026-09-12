# P903 combined actual AudioCmn validation

Fresh isolated compilation of **actual production source and headers** after
root combined SoundCar and TrafficSFX. No production or normal build output
was written by this reviewer. Actual source SHA256:
`9b5e9dafeba7302ba7dd6744637dc31c188f24356e18e8ffb23cbede476c7539`.

## Verified

- **48/48 PASS**, all **513 branches** exact/clean.
- Actual normal object is **literally identical** to the P902 actual-path
  object: `71ddb86db9e91f16ed317d1fc7f327931b6deed22543f03c5aa7a9f86f12b993`.
- Comparing each private accepted object also preserves all code/data/storage,
  semantic ELF/program headers, section order, complete ordered symbols and
  relocations. The only allowed difference is the exact checked STT_FILE
  scratch-path to actual-path replacement; no blanket metadata exemption.
- Every actual function's **complete source body and comments**, compiler
  instruction/local-label/scope graph, declaration records and SLD partitions
  match its own accepted reference: SoundCar3269d086..., Traffic868fd27b...,
  and P902ea914b6e... for all46 others. Whole `-g` text equals normal text.
- SoundCar: **530 raw words / 70 reference words**, native18 ordinary local
  owners plus static `cobbleCount` owner/type/zero byte exact; `gas` depth1.
  SLD remains37/261, with three extra scopes honestly retained.
- TrafficSFX: **163 raw words / 20 reference words**, all15 ordered native
  parameter/register-copy/local records and its single root block exact.
  SLD remains0/10. Original widening-cast tokens remain unproved.
- P902 LoadAsync: SLD0/9 and both existing scopes/debt unchanged.
- All12 switch targets, `cobbleCount` native initial byte and three GP refs,
  eight-byte PlayersRampedGasLevel NOBITS storage and **129 Xfade bytes** verified.

Total fresh raw instruction proof: **693 words / 90 relocation words**.
All actual preprocessor inputs are hashed, and a staged scratch include is
rejected. Debug labels were already unique; assembler `-L` retained existing
anchors from unmodified, hash-checked compiler output.

## Qualification kept explicit

The raw proof resolves each authoritative fragment to its native destination;
it is **not a full linked-image proof**. SoundCar's table at source
`.rodata+0x68` requires a base four bytes different from LoadAsync's literal
fragment. This existing packing debt is unchanged, not fixed or hidden by
this round. SoundCar still contains six unproved locals and three old fences;
LoadAsync still contains `s` and an extra empty scope. No complete source
restoration claim is made.

Receipts: `combined_verification.json`, `landed.json`,
`landed_raw_soundcar_receipt.json`, `landed_raw_traffic_receipt.json`,
`debug_labels_receipt.json`.

```
python scratchpad/p903_audiocmn_landed_20260912/raw_soundcar.py landed
python scratchpad/p903_audiocmn_landed_20260912/raw_traffic.py landed
python scratchpad/p903_audiocmn_landed_20260912/verify_combined.py
```

No further source experiments were performed after landing.
