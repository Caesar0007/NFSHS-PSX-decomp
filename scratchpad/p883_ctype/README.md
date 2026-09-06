# P883: CTYPE0 raw/source data seam

Only these production files changed in this subtask:

* `asm/data/data_8010CCD4_r18.data.s`: removed only the129-byte
  `.data.ctype_blob` contents and added a handoff comment.
* New `asm/data/data_ctype_legacy.data.s`: retains those original bytes and
  `_ctype_` label in a plain `.data` section for the oracle/src lane.
* `linkers/nfs4.ld`: replaces only the raw CTYPE selector with that new file.

Exact raw/linker backups are in `backups/`. No production source, header,
tool, reconstructed fragment, object or instruction was changed. Root owns
the registry exclusion and stale CTYPE0 `.rodata` -> `.data` selector repair.
No full production build, commit or push was performed here.

## Exact boundaries

```text
801371d0..80137251  _ctype_[129]       129 bytes
80137251..80137254  linker alignment    3 zero bytes
80137254..80137260  existing raw gap   12 zero bytes
80137260..80137460  asintbl           512 bytes
```

Only the table moved. The existing12-byte `.data.r18_gap_after_ctype` section,
the subsequent asintbl/sintbl/fatantbl/CSTBL tables and every other r18 section
and label remain intact. The new oracle table does not absorb any of the15
gap bytes. Native MAP confirms `_ctype_` at801371d0 and asintbl at80137260.
The CPE transport chunk is144 bytes; that is not mistaken for a144-element
source table.

The old raw table, new raw table and unchanged typed CTYPE0.c.o `.data` all
have exactly129 bytes, no data relocations, and SHA256:

`d3ca4007e97054deeb66d809e73c7b766c1156c598fb7b92d403aa7b71fbbb0a`.

The typed input object itself remains unchanged, SHA256:
`daedead9c8792627233dd7fd85dac3e1cfeb7d4d2e1f1759516445ff3852b467`.

## Isolated verification

Run `python scratchpad/p883_ctype/verify_window.py` to reproduce ordinary
GAS and strict GNU ld tests in `isolated/`. It never invokes a project build
or rewrites input objects/instructions/relocations.

Baseline raw, newly split src raw, and typed CTYPE plus typed asintbl recon
links all produce **1,632/1,632 exact retail bytes** over
[80136e00,80137460), including the unchanged976-byte prefix. The requested
CTYPE+gap+asintbl subset is **656/656 exact bytes**. Every map independently
proves `_ctype_=801371d0`, the3-byte fill at80137251, the12-byte explicit gap
at80137254 and `asintbl=80137260`. All three strict links complete with empty
stderr. `receipts.json` retains section/payload/hash/address receipts.

All non-CTYPE input section payloads/sizes and symbols were also compared
before/after and are unchanged, including the complete16,384-byte CSTBL and
the two1,028-byte following trigonometric tables. `git diff --check` reported
no errors, only normal LF-to-CRLF informational warnings.

### Explicit unrelated negative control

Linking the entire r18 object beside typed asintbl reproduces an existing
duplicate `asintbl` symbol, even when that raw section is unselected and
remaining sections are discarded. That is not a CTYPE regression and was
not hidden with `--allow-multiple-definition` or by dropping r18 wholesale.
For the bounded strict recon test, the unchanged prefix and gap were copied
as isolated **source before assembly**, omitting unrelated raw table owners;
the real typed asintbl input then supplies the512-byte neighbor. Production
r18 retains all those unrelated sections for root's separate ownership work.

Files are ready for root's coordinated production assembly, source-owner
validation, actual fragment repair and final link/regression checks. The
isolated proofs do not claim that unrelated full-project layout or duplicate
ownership debt is solved.
