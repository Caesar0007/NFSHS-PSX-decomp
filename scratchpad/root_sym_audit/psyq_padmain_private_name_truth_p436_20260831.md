# PADMAIN private-name truth and generic-queue closure

Date: 2026-08-31

The three NFS4-version words after canonical PADMAIN.obj's public data run have
proven retail addresses, types, initial values, and cross-TU behavior, but
neither retail SYM nor canonical PsyQ 4.3 retains their private source
spellings. The earlier emitted names `_padIntRegs`, `_padSioRegs`, and
`_padVbExec` were semantic reconstruction names, not recovered originals.

The owner now emits the exact retail-address labels:

- `D_80137CD8`: interrupt-register base pointer, initialized to `0x1F801070`;
- `D_80137CDC`: SIO-register base pointer, initialized to `0x1F801040`;
- `D_80137CE0`: VSync-execution state word, initialized to zero.

The semantic names remain local preprocessor aliases, so the C bodies stay
readable without misrepresenting those names as SYM evidence. PADMAIN remains
11/11 PASS, PADIF 5/5 PASS, and PADPORTD 8/8 PASS.

The refreshed canonical data-name audit has no generic review disposition:

- 66/69 emitted syslib data names are exact same-member PsyQ names;
- the remaining three are explicitly classified
  `ADDRESS_PLACEHOLDER_PRIVATE_NAME_UNRECOVERED` with the evidence boundary
  recorded above;
- zero object-read failures and zero speculative renames.

Durable receipt: `psyq43_data_name_validation_p436_20260831.tsv`.
