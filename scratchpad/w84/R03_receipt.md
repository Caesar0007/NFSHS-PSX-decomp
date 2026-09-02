# W84-R03 receipt — regional-variant matching (regiondiff)

Assignment: `scratchpad/w84/R03_rows.tsv` — 1 row.

| function | class | region | unit | candidate | status |
|---|---|---|---|---|---|
| `iSNDsin` | CHANGED | USA (variant shared by all 6) | `eaclib/psx/sndpsxz/ssine` | `regiondiff/recon/NFS4-R-USA/eaclib/psx/sndpsxz/ssine.c` | **CODE-EXACT — 37/37 instructions match; residual 1 "diff" is an ORACLE-SLICE ARTIFACT (a data word), not code** |

## Gate commands used

```
python regiondiff/tools/verify_region.py USA \
    regiondiff/recon/NFS4-R-USA/eaclib/psx/sndpsxz/ssine.c iSNDsin \
    --lane-as=recon/eaclib/psx/sndpsxz/ssine.c
  iSNDsin: FAIL 1 diffs (ours 37 / oracle 38) [NFS4-R-USA]
      + nop
```
Cross-checked against every other region with the same candidate (AU, FR-DE, JPN,
UK-ES-IT, UK-SW): **identical result, 1 diff, `+ nop`, ours 37 / oracle 38.**
Zero instruction-level diffs in any region — the alignment is exact over all 37
instructions and every non-reloc immediate.

## Regional delta (one line)

**None.** The retail slice `func_8010D89C` is the *same* 37-instruction stream as
the base `iSNDsin @0x8010CC40`; the only byte difference is the `%hi/%lo` pair for
`sndsintbl` (base `0x8013C348`, R-USA `0x8013D638`, PAL `0x8013D664`, JPN
`0x8013D424`) — pure relocation, masked by the regional gate. The CHANGED
classification comes entirely from that address move. Candidate = verbatim copy of
the base TU + a documenting header comment (comment only; zero codegen effect,
re-gated after the edit, same result).

## The residual `+ nop` is a slicer artifact — PROVEN, not accepted as a floor

1. `iSNDsin` is the **last function in .text of every regional image**
   (`NFS4-R-USA.EXE.funcs.txt` ends at `func_8010D89C = 0x8010D89C`, line 3525 of
   3525). regionrecon's slicer therefore had no next-function boundary to trim
   against and kept one trailing word; `0x00000000` disassembles as `nop`.
2. That word is **data, not padding and not code.** Base `configs/symbol_addrs.txt`:
   `__data_obj = 0x8010CCD4` — i.e. the data area starts at exactly base fn start
   + 0x94 = the word right after instruction 37.
3. Byte dump confirms base and region are identical there:
   base `@8010CCC4` and region `@8010D920` both read
   `21186200 00006294 0800e003 23100200 | 00000000 0a000000 0f000000 19000000 ...`
   — the run `0, 10, 15, 25, …` is the start of the data table, whose first element
   happens to be 0.
4. The base project's own oracle sizes the function at **0x94 = 37 words**
   (`asm/nonmatchings/main/iSNDsin.s`: `nonmatching iSNDsin, 0x94`), and the base
   gate passes it at 37/37. 37 is the authoritative function length.

⇒ Reproducing the 38th word would mean emitting a data word as code. Not done, on
purpose: it would be a byte-match hack against a mis-bounded slice, exactly the
class the wave rules forbid (no seals / no fabricated instructions).

## Falsified angles (with numbers)

- **Alignment-padding hypothesis** (the nop is inter-object 8-byte padding the
  retail linker inserted): FALSIFIED. Region fn end `0x8010D930` is already
  8-aligned, and the word after it lands on `0x8010D934` (4 mod 8) — no alignment
  rule explains it. And the identical zero word exists in the BASE image too, where
  the base tooling correctly excludes it.
- **"Force the toolchain to pad" probe**: appended a second dummy function to a
  scratch copy of the TU to see whether the assembler pads iSNDsin's block to an
  8-byte boundary. Result unchanged — `ours 37 / oracle 38, + nop`. The lane's
  assembler emits **no** inter-function padding, so even the hack route does not
  produce the word. Probe file deleted; the candidate was never touched by it.
- No source-level lever was needed or applicable: there is no coloring, schedule,
  count or immediate divergence anywhere in the 37 instructions.

## Files touched

- `regiondiff/recon/NFS4-R-USA/eaclib/psx/sndpsxz/ssine.c` (created: seeded verbatim
  from `recon/eaclib/psx/sndpsxz/ssine.c`, plus a header comment recording the above).
- `scratchpad/w84/R03_receipt.md` (this file).

No base-tree, tool, manifest, progress-board, git or memory-dir changes.

## Recommendation for the orchestrator

`iSNDsin` should be boarded as REGION-PASS-equivalent for all six regions, or the
row excluded, once the slicer's last-function boundary is fixed (trim the
`__data_obj` word: regional fn length 0x94, matching the base oracle). The fix
belongs in `regionrecon.py` / the oracle corpus, which regional agents may not edit.
