# P902 AudioCmn async loader — bounded source restoration

Proposal only; production and normal build outputs were not edited by this
agent. `proposed.patch` changes only `AudioCmn_LoadAsyncSfx` in
`recon/game/common/audiocmn.cpp`. All source experiments are frozen here.

## Verified retained result

- Whole TU: **48/48 PASS**, all **513** checked branches unchanged/clean.
- The entire normal object is literally identical before/after:
  `220d7b225206f77d069d3b6c37b6abb1fab754e5c7329ee727a60f8b74e963d3`.
  This includes all code, data/storage, symbols, relocation records and addends.
- Whole `-g` text remains identical to normal text. All 47 neighboring
  functions retain full instruction/local-label/scope graphs, native local
  records, owner spans and source-line partitions. Compiler label IDs are
  compared consistently; source-label declarations also require identical
  real assembled PCs, not a blanket name exemption.
- All **105 raw target words**, including **23 resolved relocation words**,
  equal `rom/nfs4-f.exe`; three referenced string payloads/offsets are checked.
  Resolution is in-memory verification only, never an edited object/image.
- Native SLD pair discrepancy: **0 merges / 58 splits -> 0 / 9**, with no
  newly bad pairs. `slot` and `check` retain their exact native root owner,
  storage/type/register records. The unsupported emitted `FAIL_HANDLE`
  declaration disappears; `FAIL_PATCH` previously had no emitted declaration.

Source before SHA256:
`3f20375df9cab015bf1d7551a2c1a531302c700525c40a4cacee9548e73a85b9`

Comment-bearing candidate SHA256:
`ea914b6e9f5a712cf7f176385268e890fb9651f38396a062f4c5a3a4316cd629`

## What was restored, and what remains unknown

Native records `191a14..191aed` describe one root scope, four parameters,
`slot` INT REG3 and `check` INT AUTO-48. They do **not** name `s` or either
failure label. Native SLD572 includes the entire check==7, header allocation
and null test. A single genuine `&&` condition restores that expression
boundary. Natural in-loop failure cleanup and return replace both synthetic
failure labels and the `do/while(0)` ref-weight wrapper. The real outer loop
remains `do/while`; placing its increment in the condition restores native598.

**The source-only `s` alias is NOT removed or proved original.** It has no
emitted `.def`, but still causes an extra empty lexical scope at
`800767AC..800768C4`, depth1. Native has one block; candidate still has two.
The old comment falsely placed the slot pointer in s4: retail's slot GIV is
**s0**, while **s4** holds the first diagnostic string's high address. The
candidate corrects that claim without claiming any necessity proof.

The remaining nine SLD splits are five pairs within native538 (slot init vs
loop-invariant setup) and four within native576 (ticks assignment vs explicit
return). No line-number directives, same-line semicolon tricks, cast-return
spelling, assembler-label changes, or metric exemptions were introduced.
Exact original token spelling and complete source restoration remain open.

## Frozen experiments

Counts below are generated instruction counts and **unified diff lines**,
not an invented percentage. All non-target 47 PASSes survived every compiled
probe. Failed candidates were never applied to production.

| Stage | Target instructions / diff lines | Disposition |
|---|---:|---|
| before | 105 / 0 | Fresh baseline, not inherited board status |
| natural | 107 / 62 | Direct indices, `for`, duplicate natural failure cleanup |
| natural_do | 107 / 62 | Same direct form with outer `do` |
| natural_preinc | 107 / 62 | Counter increment moved into `while` condition |
| search_then_load | 134 / 101 | IDA-like search/break followed by loading; rejected |
| natural_alias_ready | 105 / 0 | Retained natural cleanup, `s` still explicit; SLD0/9 |
| index_first | 107 / 62 | Ordinary index-first pointer addition; rejected |
| alias_for | 107 / 8 | Natural bounded `for` adds entry/branch code; rejected |
| alias_forever | 105 / 0 | SLD0/4 but adds an extra unsupported scope; rejected |
| direct_forever | 107 / 62 | Alias-free unbounded `for`; rejected |
| structured_outcome | 108 / 3 | Genuine success/failure arms add separate zero-size cleanup; rejected |
| candidate | 105 / 0 | Retained `natural_alias_ready`, corrected concise comments |

The initial `natural_alias.cpp` snapshot missed its declaration because a
scratch script assumed CRLF while tool output used LF. The compile failed
with `s` undeclared; it is preserved, and `natural_alias_ready` is a separate
corrected stage. No failed object was reused. The initial diagnostic filename
`inspect.py` shadowed Python's standard `inspect`; it was renamed to `verify.py`
before final raw checks. No production or compiler output was changed.

## Remaining next angle, not a floor

The direct-source body makes GCC replace native REG3 `slot` with an end-pointer
comparison and introduce a separate handle-address induction value. This is
observed in the emitted code, not yet a traced claim about a particular RTL
pass. Splitting the search loop kept the counter alive but altered block order
and rematerialized addresses (134 instructions), so that route is not ready.
Future work can inspect the loop optimizer's actual induction decisions and
recover the source form that preserves the native counter without inventing
a pointer local, helper, qualifier or macro. Current experiments are not a
necessity proof for `s`.

The independent reference survey in `reference/source_helpers.md` found NFS2
bank/header-loading idioms but no original sibling async-slot body. Neighboring
`AudioCmn_GetAsyncSfx` has a genuine native `s`; it must not be transferred here.

## Reproduce isolated checks

`gate.py` uses current production compiler identity and its actual whole-TU
`-G8` profile, on a frozen CPP plus private headers. It points every output at
this directory and executes the production verifier's comparison logic on
prebuilt objects. It does not invoke a normal build.

Existing stages are immutable; do not rerun `gate.py` under a used stage name.
For the final existing stage, read-only checks are:

```
python scratchpad/p902_audiocmn_async/verify.py candidate
python scratchpad/p902_audiocmn_async/raw_target.py candidate
python scratchpad/p902_audiocmn_async/check_proposal.py
```

`keep_debug_labels.py` reassembles the **unchanged** compiler assembly with
assembler `-L` only to retain existing anchors; it verifies the assembly hash,
code/data bytes and unique LM/LBB/LBE names. No debug label is injected or
rewritten. Final receipts: `candidate.json`, `candidate_inspection.json`,
`candidate_raw_target_receipt.json`, `debug_labels_receipt.json`,
`proposal.json`, and `input_hashes.json`.
