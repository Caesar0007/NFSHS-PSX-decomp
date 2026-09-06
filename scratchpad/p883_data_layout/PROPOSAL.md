# P883 read-only data-layout proposal

No implementation, rebuild, generator run, linker run, object modification or
generated-file modification was performed. This uses the existing
build/gen_ld/recon_multdef-ok.map (2026-09-07 00:18:07 local), its current
generator/fragments, native NFS4.MAP/SYM, existing objects and rom/nfs4-f.exe.
inventory.json records the map SHA256, all contributors and byte proofs.

## Why .data overlaps .sdata

Native MAP line11 gives .data8010CCD4..8013C54B, size0x2F878 (194680 bytes).
Native .sdata begins8013C54C. Current output .data instead has size0x3678C
(223116 bytes), ending80143460 exclusive: **28436 bytes (0x6F14) too large**.

This decomposes exactly into two separate defects:

1. Ordered .data fragment currently ends8013C4C8:132 bytes SHORT because its
   CTYPE0 selector is stale (below).
2. gen_ld.py392-399 appends74 unplaced source .data sections to extra_data,
   then emits them immediately after the native-ordered fragment at478-481.
   Their payload is28560 bytes plus8 alignment bytes. Consequently
   -132 +28568 =28436 bytes of overflow.

| Appended source group | Sections | Payload bytes |
| --- | ---: | ---: |
| Other game TUs |15|11772|
| Vtable TUs |10|8432|
| Frontend TUs |34|5435|
| PsyQ/syslib |12|1745|
| EA libraries |3|1176|

Largest individual appends: vtables_tmenu2520; audiocmn2416;
screencontroller2040; draww1792; vtables_tscreen1720; hrzsku1580;
camera1404; genericpmx1304. The full74-entry ledger is in inventory.json.
The first append is sclcptch's512-byte sndcents at8013C4C8; it immediately
crosses the fixed .sdata boundary. Other native frontend windows are also
incorrectly appended here: FETextRender's88 bytes at8013CD08 instead of800515B8.

This is not evidence that the original game's data was too large. The fallback
is mixing unplaced source owners into the native main data run. gen_ld.py364
explicitly does NOT consume the frontend data fragment, explaining many of those
appends. Activating that entire old fragment blindly is not a bounded fix: some
of its other source sizes/layouts require fresh validation.

## First bounded correction: CTYPE0 section-ownership seam

linkers/nfs4_recon.data_8010CCD4.ldfrag105 still selects
build/recon/syslib/psx/libc/CTYPE0.c.o(.rodata). Actual canonical source is mutable
char _ctype_[129], emitted into .data, not .rodata. Existing object's129 data
bytes have ZERO relocations and equal BOTH raw ROM at801371D0 and the retained
raw .data.ctype_blob payload. SHA256:

d3ca4007e97054deeb66d809e73c7b766c1156c598fb7b92d403aa7b71fbbb0a

Native anchors: SYM016504 _ctype_801371D0; NFS4.MAP3409/8582 same address;
SYM780d05/780d39 identifies libc.lib(CTYPE0.obj). Canonical char source must
remain unchanged; making it const again merely to satisfy stale placement would
reverse a valid source/type restoration.

Native arithmetic:129-byte table ends80137251; SUBALIGN(4) supplies3 zero bytes
to80137254; existing12-byte .data.r18_gap_after_ctype then reaches asintbl at
80137260. Current map11177 skips the nonexistent .rodata, starts that gap at
801371D0, and places asintbl at801371DC. The -0x84 drift persists through
snddata and the final ordered raw piece. Current source _ctype_ payload is
instead appended at80142DA4; its raw duplicate is orphaned at8015BF0C.

Proposed next implementation, after backups and fresh gates:

- Correct the fragment selector .rodata -> .data, preserving the canonical
  source object and its129 bytes. The existing SUBALIGN/gap supplies the proper
  native padding; do not add dummy source data.
- Make ONLY data_8010CCD4_r18.data.s.o(.data.ctype_blob) oracle-only in the recon
  lane, with exact payload/native-address validation. Do NOT exclude the whole
  r18 object: it still supplies required unrelated residual sections.
- Gate strict symbol ownership, _ctype_ references and all downstream native
  anchors; current strict log331-332 proves the raw duplicate currently wins
  first-definition resolution. A selector-only fix does not close that issue.

This corrects the native ordered run, but by itself does NOT eliminate the
28436-byte overflow: it moves an existing132-byte aligned contribution from
extra_data back to its proper slot. The separate appends must still be placed
at their own native windows and paired raw copies made oracle-only.

## Small immediately-proven next owner: FETextRender

The existing source .data section is88 bytes, no relocations, exactly equal to
raw800515B8..8005160F and standalone front_data_o00.data.s.o(.data). Native
SYM52293b is84-byte textDefinitions[14][6], followed by BOOL gSemiTransText at
522963/8005160C. NFS4.MAP5653-5654 confirms both. Payload SHA256:

82a7158d55efa9688e94d835ee9d71f3780c8a4d17881e69f4ce1edb5a605053

This fits the existing source_data_owners mechanism WITHOUT schema expansion:
register fetextrender.cpp(.data) at800515B8,size88,payload hash, and the standalone
front_data_o00.data.s as its oracle-only object. It removes88 bytes from main
extra_data, places the source at its actual frontend VA, and removes the second
raw backing copy currently stranded at8014FE0C. Parent already has P88117/17
and whole-object identity receipts. Unlike the CTYPE seam, this raw copy occupies
an entire standalone object, so excluding it does not discard unrelated data.

## Additional raw-copy backlog is separate from SIZEOF(.data)

The link input enumeration includes every extant asm/data object except the
explicit owner exclusions. Named legacy/blob subsections are NOT matched by the
final exact .data/.sdata catch-all, so GNU ld places them as orphan output
sections. Current map contains23 such sections totalling120313 payload bytes
after main .data: TABLE blob69632; replay legacy28628; CSTBL blob16384 dominate.
These do not contribute to the .data size above, but are additional duplicate
storage/reference and overlap hazards. The raw front_data_oNN fillers likewise
remain in .data_rest while source data is elsewhere. Remove each recon-lane raw
copy only with per-owner proof; retain raw sources for the expected/oracle lane.

gen_ld.py's diagnostic link uses --no-check-sections and --noinhibit-exec;
the resulting map/ELF is therefore evidence of these overlaps, not proof that
the linked image is layout-correct. No section or source bytes were altered
during this diagnosis.
