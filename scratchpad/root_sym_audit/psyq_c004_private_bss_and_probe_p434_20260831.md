# Canonical PsyQ `C_004.obj` private BSS and layout-probe restoration

Date: 2026-08-31

## Member truth

Canonical PsyQ 4.3
`C:\Temp\nfs4-clean\psyq43\extracted\LIBCD\obj\C_004.obj` contains a
16-byte `.bss`. Its code relocations address only the section base and base+4;
the final eight bytes have no retained name. The public XDEFs are only
`data_ready_callback` and `StGetBackloc`.

The reconstructed NFS4 owner already had the two used words at retail
`0x801489D0` and `0x801489D4`, with file-local scope. SotN independently
preserves the first original spelling, `fp_2`; the second spelling is not
recoverable and remains an explicit address placeholder. The owner previously
emitted only eight bytes, however. It now retains the complete canonical
16-byte member extent without inventing names for the eight-byte tail.

`data_ready_callback` remains detailed PASS at 35 instructions. NFS4 does not
link the member's `StGetBackloc` XDEF, so no absent retail function was added.

## Layout-probe coverage repair

`tools/probe_link.py` claimed all data-section coverage but considered only
the exact names `.data`, `.sdata`, `.sbss`, and `.bss`. Deliberately named
owner subsections such as `.bss.ds_801489D0` were therefore swept to scratch.
The probe now treats those roots and their dot-subsections uniformly. A
byte-identical pre-change backup is retained as
`probe_link_before_subsection_support_p434_20260831.py`.

The refreshed implied-base map proves:

```text
.d0295 0x801489d0 0x10
  build/recon/syslib/psx/libcd/C_004.c.o(.bss.ds_801489D0)
```

The widened coverage places 300 data sections rather than 280 and improves
the linked in-place probe from 98.35% to 98.42% text bytes and from 98.16% to
98.47% initialized-data bytes. This is a measurement correction caused by
resolving data references at their evidenced addresses, not a post-compiler
rewrite.

Durable receipts:
`psyq_c004_private_bss_relink_p434_20260831.json` and
`psyq_c004_private_bss_probe_p434_20260831.json`.
