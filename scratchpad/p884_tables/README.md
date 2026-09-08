# P884: four typed table owners separated from their raw oracle copies

Baseline checkpoint: **acbe34775f4e**. Both owned production inputs were clean
before work and backed up exactly in `backups/`.

Production changes are limited to:

* `asm/data/data_8010CCD4_r18.data.s`: replace only the four table sections
  with comments pointing to their separate oracle files.
* Four new `asm/data/data_{asintbl,sintbl,fatantbl,cstbl}_legacy.data.s` files,
  each retaining the original raw table/labels in plain `.data`.
* `linkers/nfs4.ld`: swap only the corresponding four raw selectors.

No function, typed source, header, production tool, owner registry or recon
fragment was edited. No object/instruction/relocation rewrite was performed.
Root owns registry exclusion and actual production validation. No full build,
commit or push was run by this subtask.

## Exact native owner metadata

| Source object | Native symbol | Address | .data bytes |
|---|---|---|---:|
| eacpsxz/asintbl.c | asintbl | 80137260 | 512 |
| eacpsxz/sintbl.c | sintbl | 80137464 | 1,028 |
| eacpsxz/fatantbl.c | fatantbl | 80137868 | 1,028 |
| libgte/CSTBL.c | rcossin_tbl | 80137d20 | 16,384 |

Every old raw section, new oracle `.data` and unchanged compiled typed `.data`
is exactly equal to the corresponding retail bytes. All four sections have
**zero data relocations**, with their native global symbol at offset0.
Payload SHA256 values:

```text
asintbl  fff107aee0cc92ff9a79d1acb10342cae29db4449b41bdfc1a4a082e9d541e0c
sintbl   c3b03a2581960f9b22f2f29fb52f30bf36eb87c3896c8e4f62c708b3c247f880
fatantbl a3ab1c0b30ea38a25c2d7f7c7b13969a0e3448547b839c92b1ae5789c3942b64
cstbl    b40c47b014ca8650c539760fd4c519cabce6f091628566ca0dd22318bb2c5b7a
```

Source/oracle sizes are identical; no padding was absorbed. The four raw
owner files contain **18,952 total payload bytes**, distinct from the larger
enclosing link window. Individual sizes and hashes are also recorded in JSON.

## Bytes, labels, gaps and neighbors preserved

The existing CTYPE seam remains unchanged:129-byte table, three linker
alignment bytes at80137251 and12 explicit gap bytes at80137254. The four-byte
gap after asintbl at80137460 remains in r18. The word at80137c6c and all other
post-fatantbl bytes remain outside the1,028-byte table. CSTBL's following
240-byte section at8013bd20 likewise remains untouched.

`verify.py` assembles backups/current raw inputs only into `isolated/` and
uses ordinary strict GNU ld—no permissive duplicate/overlap flags. It proves:

* Original baseline raw, new src raw and recon using all five typed tables
  (the four new owners plus existing CTYPE) each match **20,496/20,496 bytes**
  over **[80136e00,8013be10)**.
* All five table symbols retain their native addresses in all three lanes.
* **55/55 original raw global labels** have unchanged src addresses.
* All **54 shared recon labels** have unchanged addresses.
* Every nonowned r18 section's bytes, size and symbols remain unchanged.
* The typed input objects remain byte-identical throughout the checks.

The one source-only raw interior label is **D_8013745F**, at asintbl+511. It
is preserved verbatim in the new asintbl oracle file, including its nested
end label. The src intarcsin oracle references it. The inspected current
recon and retained raw-data sources have no D_8013745F reference requiring a
new alias; the actual root link gate must still confirm this after exclusion.

Full evidence: `receipts.json`, the reproducible `verify.py`, and strict
baseline/src/recon `.ld`/`.map`/`.elf` outputs in `isolated/`.
`git diff --check` reported no errors, only normal LF-to-CRLF information.

## Validation handoff

The historical P883 CTYPE-only verifier expects the old raw asintbl section
to remain in r18; its saved receipts remain valid for that checkpoint, but
that script is superseded by this full-window test for the new split. Do not
overwrite or reinterpret old receipts as current. Root's production checker
also needs the expanded twelve-owner registry rather than the previous
eight-owner assertion.

Files have been released to root for coordinated production assembly,
oracle-copy exclusion and actual generated-link/reference checks. These
isolated proofs do not claim the remaining whole-project layout/ownership
backlog is closed.

## Root integration and final regression

The source-data registry now has twelve validated owners. The four typed table
sections were already selected by the main data fragment; excluding only their
separate raw oracle inputs now also makes all four PUBLIC symbols bind to those
typed native cells. No generated linker-text change or source table rewrite is
needed. The old orphan table sections disappear from the reconstructed ELF.
Source/oracle inputs retain every original label, including D_8013745F; recon
has no unresolved reference requiring that synthetic interior label.

The complete source-object census found six consumers and34 table relocations.
All34 actual linked words differed from raw before the ownership correction;
all34 are now raw-exact, with every consumer object unchanged. The complete
input function's non-relocation bits establish each instruction position.
RotMatrix/RotMatrixZ oracles include1/2 trailing zero alignment words beyond
their compiled jr-ra/delay-slot terminators; that bounded, verified padding is
recorded, not mistaken for a shifted body. baseline_full_consumer_receipts.json
uses the frozen pre-P884 ELF/map and unchanged source objects; final consumer
receipts check the new actual link. No instruction or relocation was patched.

All three full builds pass, all518 live source objects reproduce byte-for-byte,
the twelve earlier checkpoint TUs remain358/358 PASS, and fememcard18/18 gives
376/376 checked base functions with zero branch discrepancies. All12 data
owners, the20,496-byte isolated seam, Hud's34 legacy pointer aliases, source
policy and vtable checks pass. CI-style objdiff report generation succeeds.
The exhaustive2381-site GP audit remains unchanged: zero unresolved/overflow/
encoding errors or regressed native targets, with1462 wrong-but-in-range
targets still open. Standing relink has905 known blob/source duplicates (four
fewer), zero REAL duplicates, hidden phantoms and referenced unresolveds.

This does not solve the broader final link:28348 bytes of appended main data
and119 allocated output-overlap pairs remain, as does the sbss type warning.
The P883 asintbl duplicate-binding backlog is now genuinely resolved; other
ownership/reference debt is not waived. P884 remains uncommitted.

Fresh source-audit evidence is frontend_strict.md:781 declaration-clean mapped
functions, missing names0, extra locals46, type findings9, storage findings9,
mapping review3 and450 explicitly open source-only carriers (one fewer).
The separate lexical asm-array inventory is62 sites/28 files after removing25
in this round; it covers only that syntax family and includes genuine arrays.
It must not be used to claim that plain array-shaped declarations or all other
source ambiguities have been audited away.

The P883 source-gate runner writes its output to its historical directory. Its
fresh P884 result was copied here as checkpoint_source_receipts.json, and the
previous historical receipt was restored exactly. Full local execution history
is in full_validation_receipts.json/final_receipts.json; old-round receipts are
not relabelled as evidence for new source. No commit/push was performed.
