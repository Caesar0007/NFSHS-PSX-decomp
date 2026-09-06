# P867: CPE-derived data-map reference

The user supplied `C:\Temp\nfs4-clean\nfs4_data.txt` on 2026-09-06.
Use it as a byte-range and address index, **not** as an exact source-object,
type, or declaration-size oracle. The reference and its generator were not
modified. This note records verified uses and defects so future restoration
does not regress correct source declarations.

## Verified transport ranges

Run the read-only receipt from the repository root:

```
python scratchpad/root_sym_audit/probe_cpe_data_map_p867.py
```

It parses raw `NFS4.CPE`, obtains the executable load base from the PS-X EXE
header, and checks every numbered `NNNN-CPE` row. Result on 2026-09-06:

- 3,478 CPE load records; valid EOF, no unknown commands.
- All 1,328 listed data ranges have exact CPE address/length counterparts:
  267 `.rdata`, 479 `.data`, 582 `.sdata`.
- All **211,949 payload bytes** match `rom/nfs4-f.exe`; zero mismatches.
- This covers the listed resident data chunks, not every byte of the image,
  not the reconstructed linked image, and not declaration/source exactness.

Input SHA-256 receipts:

```
NFS4.CPE     9614b53e157ccc263e833d239e0e6ab2bb5632106faf03d0bd1c4219f4f0387c
nfs4_data.txt e2650ac6ee41188e8a38f000e523ed3622537fb58276f1c85e7ef7297d25dda5
nfs4-f.exe   5da87a73caeec568ed60806f23e1e5276e3e3c699627442a519b2915789ec49b
```

## Important limitations and demonstrated errors

1. **CPE load chunks are not necessarily source-object boundaries.** The
   heading at map line 299 overstates the evidence. Chunk 1314 (line 2558)
   spans `[8013dc54,8013dd04)`, 176 bytes. It includes library/disablecd/
   currentfilesystem/availablefilesystems, then the distinct `vars.obj`
   40-integer block `[8013dc64,8013dd04)`, 160 bytes. The generator
   `C:\Temp\nfs4-clean\gen_data.py` never processes SYM FILE/module
   ownership; its `owned` dictionary records address containment only.
   Establish TU ownership using native SYM object records, not this heading.

2. **A nonzero PTR STRUCT debug size is not pointer storage size.** Map
   lines 95/100 report FEApp=896 and speechfileHeader=16. Native SYM
   records `4b4f01` and `4bfac2` describe pointers to structures of those
   sizes. Each pointer cell occupies 4 bytes. The generator only converts
   PTR to size 4 when the original size is zero (lines 93-99), leaving
   these nonzero pointee sizes mislabeled as declaration extents.
   Do not resize FEApp or speechfileHeader from those rows.

3. **Same-name MOS fallback is not evidence about a global.** Generator
   `declared_size`/`declared_type` falls back to structure members by bare
   name (lines 134/140). It therefore labels `vars.obj` centerx/centery
   as SHORT/2 (map lines 2596/2597), borrowing unrelated shapetbl MOS
   records `0258db`/`0258f0`. The current `vars.c` correctly keeps integer
   cells at 8013dce8/8013dcec. NFS2's vars.asm-derived SYM records
   `13d091`/`13d0a7` explicitly corroborate EXT INT, and the NFS4 block's
   addresses and four-byte initializers agree. Do not apply the map's
   member-derived short types to these globals.

4. **The CPE frontend reservation is not initialized frontend content.**
   The first load record is 282,000 zero bytes at
   `[80010000,80054d90)`. MAP's actual frontend range is
   `[80010000,80054548)`, leaving 0x848 reserved bytes beyond its end.
   The merged `nfs4-f.exe` supplies frontend content; this CPE record
   supplies the resident reservation. Neither containment nor bigBuf's
   base address gives bigBuf source ownership of frontend globals,
   strings, vtables, or code. Frontend/BSS map rows are SYM-derived,
   not independent CPE declarations or CPE sub-boundaries.

5. **Anonymous chunk heuristics and trailing bytes need review.**
   `str`/`ptr`/`scalars`/`binary` are generator classifications, not types
   or original names. asintbl's 512-byte chunk 0723 and sintbl's 1028-byte
   chunk 0725 agree with the existing data-only definitions. The next
   two-byte zero chunk after asintbl has unresolved original ownership;
   do not append it to the table merely because it is adjacent.
   intarcsin explicitly special-cases index 511, loading asintbl[511]
   and using constant 0x100 instead of reading element 512
   (`800ead34..800ead68`). fatantbl's 1032-byte CPE chunk versus its
   existing 1028-byte table is another reason to distinguish payload,
   padding, and unknown trailing storage. Their original spelling and
   ownership are not established by chunk sizes alone.

The older `C:\Temp\nfs4-clean\fullaudit2.py` consumes this map's sizes
and substitutes zero bytes beyond extracted sections. Its per-object
results require independent extent checks; do not treat them as proof of
complete source-data restoration.

## Application to the current source-restoration round

- currentSpeechViv[40] at 80051510 (map line 101) is explicitly sized by
  native SYM record `4bfaec`; the P867 StartLoadPatch filename correction
  uses this existing global. Source reference identity was established
  from raw instructions and generated relocations, not just normalized PASS.
- UserPermFileName[20] at 800529b8 and WaitingString[50] at 80052c58
  support the previous P866 buffer corrections; their real native SYM
  records and caller references remain the authority.
- The frontend audio string pool is outside the numbered resident-data
  coverage. It was checked separately against merged retail: **117/117
  emitted .rodata bytes match beginning at 80010104**.
- No source definition was enlarged, renamed, reassigned to a TU, or
  retyped based only on this derived map. Full SYM/SLD/source exactness
  remains open; the byte inventory adds evidence, not a completion claim.
