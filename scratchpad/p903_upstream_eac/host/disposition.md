# P903 corrected host paths: independent validation

Completed 2026-09-12. This is a new disposition receipt; the original incoming
audit and every before/after object receipt remain frozen.

The actual restored `blkfill.c`, `sinfunc.c`, `fixddiv.c`, `fixdinv.c`,
`fixdmult.c` and data-only `sintbl.c` were compiled directly from production
paths with native Windows GCC 15.2.0 (`x86_64-w64-mingw32`). Build outputs and test
executables exist only in this private `host` directory. No PSX normal output,
source, shared header or production tool was modified by the reviewer.

## Results

The frozen b36 sources and actual restored sources each pass at both `-O0` and
`-O2`: **1,066,499 assertions per executable**, four independent builds/runs.

| Test family | Cases per executable |
| --- | ---: |
| Guarded blockfill/blockclear, offsets 0..7, lengths -7..257, six fill values | 14,840 |
| Sine/cosine and both aliases across 256 complete signed periods plus extreme safe angles | 262,147 |
| Signed fixed multiply plus alias | 784 |
| Signed fixed divide, including zero divisor, plus alias | 723 |
| Signed rounded inverse plus alias | 26 |
| Alias function-address identity | 5 |

All five aliases (`rdiv`, `rinverse`, `rmult`, `fastintcos`, `fastintsin`) have
the exact address and tested return values of their respective owning function.
The block tests compare the entire guarded buffer, including every byte outside
the requested write range. Arithmetic expectations use independent 64-bit
formulas; sine expectations use a modulo/quadrant table projection.

## Source and raw preservation

- For all five code TUs, the entire non-MIPS arm has identical tokens to b36
  after removing comments and the irrelevant `extern` on function definitions.
  This includes the restored two bodies and all five alias definitions.
- Their entire MIPS arms have identical tokens to b36; no assembly opcode,
  immediate, label or operand changed in these restoration files.
- `sintbl`'s 257 words are unchanged from b36 and exactly equal the raw executable
  bytes at `80137464`.
- The actual `crossproduct` body again has the exact b36 expression/local tokens,
  including only the existing `t`; `tmp0`, `tmp1` and `tmp2` are absent.
- Forty-one actual source/header inputs, including native system headers, are
  hashed in `host_disposition.json`; all six tested production source hashes
  remained stable through completion.

Primary artifacts: `host_receipt.json`, `host_disposition.json`, `check_host.c`,
`run_host.py`, `finalize_host.py`, and four `*_iquote/runtime.json` reports.

## Honest limits and harness diagnostic

The original fallback has signed `abs(INT_MIN)` / negation-overflow expressions;
those divide/inverse cases were not silently counted as portable PASS. The
multiply cases include `INT_MIN`, and sine/cosine include extreme angles only
where `a + 256` cannot overflow. `fixedinverse(0)` is outside its retained host
domain (division by zero), so it was not executed. These are pre-existing source
limitations, not new regressions or changes made by this validation.

The first host harness used `-I recon`, which selected the project's PSX
32-bit `stddef.h` over Win64's system header and failed on `size_t`. Its compiler
diagnostic is frozen in `before_O0/compile_stderr.txt`. Changing only the test
harness search option to `-iquote recon` made actual quoted owner headers visible
without replacing native system headers. All four corrected builds were clean.

The seven host fallback regressions identified in the incoming audit are now
resolved by independently verified restoration. Primate and callback's final
PSX object/link disposition remains parent/other-reviewer-owned; these host
tests do not claim a full PSX link, original-source identity, or native BSS
placement proof.
