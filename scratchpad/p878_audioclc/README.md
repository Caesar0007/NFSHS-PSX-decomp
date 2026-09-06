# P878 AudioClc whole-TU identity proof

The current source-only baseline is **17/18 PASS**. SoundPlayersCar has
4 differences at 461/461 instructions and one branch-distance mismatch
(14 versus retail 12). Native SYM places channel in s0 and c in s3; the
default jump-threading pass skips the repeated channel test and blocks its
retail delay-slot fill.

| Whole-TU compiler input | PASS | Branch divergences |
| --- | --- | --- |
| Current 2.8.0, -G4 | 17/18 | 1 |
| Current 2.8.0, -G4 -fno-thread-jumps | 18/18 | 0 |
| Retail 2.8.1, -G4 | 17/18 | 1 |
| Retail 2.8.1, -G4 -fno-thread-jumps | 18/18 | 0 |

The old normal per-function splice and the new single whole-TU compilation,
both using the **same original source path**, emit **byte-identical 14,896-byte
ELF objects**. SHA256 for both:

`b8d20ef0cff1416894e8fe988c4fae015651e6cc496ef0024bcf44748266da89`

This preserves every text/data byte, symbol and relocation, not merely normalized
instructions. The old route invokes CC1 twice; the whole-TU route invokes it
once. All 18 raw oracle slices were checked against rom/nfs4-f.exe:
**1,852/1,852 words**, zero mismatches.

Current checked-out tools specify global G_VALUE4 and no per-TU AudioClc override.
There is no G8 setting to preserve in this baseline. The diagnostic keeps -G4.

## Handoff

Recommend retaining the current 2.8.0 compiler, adding the ordinary whole-TU
no-thread-jumps input (including the debug-twin mirror), and retiring the
per-function splice. The old sibling-regression note is obsolete for today's
source. This is a compatible object-wide identity inference, not proof of the
lost original command line.

No production source, header or tool changes were made by this agent.
`receipts.json` records every function and actual compiler command. `probe.py`
loads the authoritative verifier and branch helpers, changing compiler inputs
only in the diagnostic process. It does not rewrite emitted instructions.
