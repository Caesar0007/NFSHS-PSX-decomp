# EACLIB data-only archive-member closure (P447)

## Scope

This round audits NFS4 SYM archive members that carry data without a function
body, with `eacpsxz.lib(vars.obj)` as the primary target.  PsyQ represents
these members with duplicate `FILE` boundary rows and compact top-level type-2
name/address records rather than ordinary object-owned 94/96 DEF rows.

## `vars.obj`

- SYM member boundary: `eacpsxz.lib(vars.obj)` at trusted SYM lines
  358071-358072.
- Retail span: `0x8013DC64..0x8013DD03` (`0xA0` bytes).
- Reconstructed owner: `recon/eaclib/psx/eacpsxz/vars.c`.
- Object shape: one `.sdata` section, exactly 40 consecutive four-byte `D`
  symbols at offsets `0x00..0x9C`.
- `NFS4.MAP`, `configs/symbol_addrs.txt`, linker placement, reconstructed `nm`
  order, and all 40 compact SYM name/address rows agree.
- The retail payload and freshly compiled `.sdata` compare byte-for-byte:
  `0/160` differing bytes.
- The earlier EA EACLIB `vars.asm` block in the NFS2 PC beta SYM corroborates
  class `EXT`, type `INT`, and the shared-variable source family.

The shared block includes the screen/input state, `ticks`/`libticks`, VBL and
page-flip state, `timerhz`, allocation/error state, viewport center/origin and
fixed-point scale/aspect globals.  These are not anonymous linker padding and
must remain owned by `vars.obj` even when consumers live in frontend, game, or
other eaclib modules.

One source mismatch was corrected: `joystkn.c` declared `numjoy` as
`unsigned int`; the recovered EA symbol type is `INT`, so the declaration is
now `extern int numjoy`.  `initjoy` remains byte-exact PASS (15 instructions).
Stale comments claiming that raw asm blobs own `ticks` or `sintbl` were also
corrected to the actual data-only object owners.

## Other proven data-only EACPSXZ members

| archive member | symbol | retail VA | payload bytes | differing bytes |
|---|---|---:|---:|---:|
| `atantbl.obj` | `atantbl` | `0x80136CE8` | `0x101` | 0 |
| `asintbl.obj` | `asintbl` | `0x80137260` | `0x200` | 0 |
| `sintbl.obj` | `sintbl` | `0x80137464` | `0x404` | 0 |
| `fatantbl.obj` | `fatantbl` | `0x80137868` | `0x404` | 0 |
| `isqrttbl.obj` | `isqrttbl` | `0x8013BE10` | `0x100` | 0 |
| `vars.obj` | 40 named integers | `0x8013DC64` | `0x0A0` | 0 |

Each source definition now carries an explicit retail VA receipt.  This makes
the no-code archive members auditable without inventing a function owner.

## Audit-tool correction

`scratchpad/root_sym_audit/audit_sym_source.py` now parses compact non-vtable
type-2 records.  A compact record is accepted only when a real source global
has both the same name and an exact `@0xVA` receipt.  Compact records do not
claim type or storage-class evidence because those fields are absent from this
SYM encoding.

The eacpsxz audit moved from 0 recognized object globals / 112 apparent extras
to 47 exact compact address mappings / 65 remaining review entries.  All six
data-only objects above are now recognized.  The remaining 65 entries are a
backlog of mixed code+data/private-carrier objects and must not be deleted from
the apparent-extra list without object, address, and oracle evidence.

## Regression proof

- `initjoy`: PASS, 15 instructions.
- `gettick`: PASS, 4 instructions.
- `elapsedticks`: PASS, 12 instructions.
- `resettick`: PASS, 9 instructions.
- `timedwait`: PASS, 19 instructions.
- `intsincos`: PASS, 71 instructions.
- Freshly compiled data payloads: zero differing retail bytes for all six
  objects.
- Relink both lanes: GREEN; real duplicates 0, hidden phantoms 0, unresolved
  relocations 0.
- Undefined-call audit: recon 15,781 calls / source 15,779 calls, undefined 0.
- Game/common strict regression: 1193/1193 functions mapped, 569 declaration
  clean, missing locals 0, type findings 0, globals 547/547, vtables 115/115,
  missing/extra globals 0/0.
- `git diff --check`: clean.

Receipts:

- `eacpsxz_strict_data_objects_p447_20260831.md`
- `eaclib_data_objects_relink_p447_20260831.json`
- `eaclib_data_objects_undef_recon_p447_20260831.json`
- `eaclib_data_objects_undef_src_p447_20260831.json`
- `game_common_strict_p447_20260831.md`
