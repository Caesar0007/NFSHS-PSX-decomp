# P877 Night whole-TU retail compiler identity receipt

Independent diagnostic: unchanged `recon/game/psx/night.cpp`, copied outside
production with only include paths anchored. No production source/tool edit was
made by this agent. The candidate used the strict source-only policy.

| Compiler input configuration | Detailed gate | Branch discrepancies |
| --- | --- | --- |
| Historical mixed: 2.8.0, CreateNightTableElement-only 2.8.1 splice | 19/19 PASS | 0 |
| Strict whole 2.8.0 | 18/19 PASS | 0 |
| Strict whole retail 2.8.1 SN, no per-function splice | 19/19 PASS | 0 |

All cases retain the established `-G8` TU identity. The default compiler's only
miss is Night_CreateNightTableElement:56 differences at113/113 instructions.
This is a whole19-function check, not inference from that one improvement.

The entire isolated ELF object from historical mixed and strict whole2.8.1 is
byte-identical, including code, all data sections, relocation names/addends,
symbol visibility and metadata:

`b5edf90d202d47e7d4a55ff72258c65f5b53476c0f39bc852e34c9c804d068f9`

The source-only2.8.0 isolated object differs:

`cf2c9e59b55986529b80968a4318f125323aa85801399d58f12085111d35ee59`

Both compiler binaries are explicitly SHA-256 asserted by the diagnostic:

- Retail2.8.0: `C:/Temp/psq43/COMPILER/CC1PLPSX.EXE`,
  `61781c2f67b8486281720fdabb1fd7b549cce7f92918cb7b505db1fce54742b7`.
- Retail2.8.1 SN: `C:/Temp/psq44/pssn/bin/CC1PLPSX.EXE`,
  `70319c94de27924f5720af361afd2aa7e6de051a7718e0c1a7f07b57fa92109c`.

## Native/raw corroboration

All19 exported function identities exist in native SYM EXT FCN records
43b827..43bb73. All19 oracle slices were independently checked against the raw
`rom/nfs4-f.exe`: **1,000 instruction words, zero discrepancies**. The full-object
identity also proves that the compiler selection introduces no new call target,
global reference, relocation addend or data-layout change relative to the freshly
built historical mixed baseline. This preserves existing references; it does not
claim that unrelated source-level alias/type restoration debt is solved.

The initially observed production .o was a strict2.8.0 build, not a valid normal
mixed baseline. Its sections/relocations/symbols matched that isolated strict2.8.0
case after excluding only the compiler's source-file record. It was not used to
claim a regression or normal-lane identity.

After receiving these results, root independently built old mixed and whole2.8.1
at the real production source path and reported identical whole-object SHA-256:

`b818c9cff41a8dfb429466fc1dd62719ef38541900ddc888cc77618651071dab`

The live production artifact's hash and its sections/relocations/symbols were
independently re-read and agreed with the whole2.8.1 result. The difference from
the isolated ELF hash is the source-file identity of the scratch compilation.
Root also reported live source-only19/19 PASS, branch0, and an exact113-instruction
debug twin for CreateNightTableElement. Root owns production integration.

## Reproduction

Run `python scratchpad/p877_night/identity_probe.py`. The runner now freezes the
pre-P877 `g_value=8` configuration and its one compiler-version splice explicitly
in diagnostic memory; it does not inherit the newly corrected production whole-TU
selection and silently relabel that as the old baseline. The frozen runner was
rerun after production integration and reproduced the same19/18/19 PASS matrix
and exact mixed/whole object identity.

`identity_results.json` contains complete per-function outcomes, branch maps,
compiler paths/hashes and object hashes. The three .o files are generated scratch
artifacts. No compiler instruction stream was manually rewritten; the historical
splice is present only in the comparison baseline, not the candidate.
