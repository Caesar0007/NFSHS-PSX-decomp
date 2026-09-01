# EACPSXZ source-global closure (P451, 2026-08-31)

## Result

The strict EACPSXZ source-global queue is closed without treating stripped or
host-only identifiers as recovered SYM names:

- 89 compact opcode-2/opcode-6 names map by exact lexical name and VA;
- 14 source-only data/layout carriers have explicit object, raw-oracle, or
  independently matched-source receipts;
- 2 `fixdsqrt.c` names are explicitly host-only fallback tables and are absent
  from the retail MIPS object;
- 4 `unref.c` definitions are explicitly linker-folded common symbols shared
  with `unbtree.c`;
- missing/extra source-global findings: **0/0**.

The durable strict receipt is
`eacpsxz_strict_closed_p451_20260831.md`.

## Exact-name restorations in this round

- `nfile.c`: the manager aggregate is now the retail SYM/MAP symbol
  `gFileDevice @0x8013EA88`; `gFileMgr` remains only a header compatibility
  alias for already matched field expressions.  `nfile.c` is 27/27 PASS and
  the game-side `nfs3.cpp` consumer is 11/11 PASS.
- Earlier P451 restorations retained here include `tmrsub`, `tickset`,
  `tickval`, `Cdinfo`, `biglen`, `memclass`, `systemtasklock`, and
  `lastsystemtasktick`.

## front.bin / bigbuf.obj / address.obj ownership

The front overlay is a separately compiled and linked image whose exact SYM
records are:

```
_front_obj     = 0x80010000
_front_objend  = 0x80054548
_front_org     = 0x80010000
_front_orgend  = 0x80054548
_front_size    = 0x00044548
```

Therefore `bigbuf.obj` is the reservation mechanism for the outer overlay load
window, frontend translation units own the compiled contents of `front.bin`,
and `address.obj` owns the exported start/end metadata.  The interval is
exclusive at its end: `[0x80010000, 0x80054548)`.

## Regression receipts

- Every newly classified TU remains fully PASS:
  `exit` 1/1, `fixdsqrt` 1/1, `matrix` 4/4, `memstd` 13/13,
  `primate` 3/3, `systask` 3/3, `unref` 2/2.
- Relink both lanes: GREEN; real duplicates 0, hidden phantoms 0,
  relocation-referenced unresolved 0.
- Undefined-call audit: recon 15,781/0; source 15,779/0.
- Data-only payload audit: 11/11 members byte-identical, 0 differing bytes.

Durable link receipts:

- `eacpsxz_sym_closed_relink_p451_20260831.json`
- `eacpsxz_sym_closed_undef_recon_p451_20260831.json`
- `eacpsxz_sym_closed_undef_src_p451_20260831.json`
