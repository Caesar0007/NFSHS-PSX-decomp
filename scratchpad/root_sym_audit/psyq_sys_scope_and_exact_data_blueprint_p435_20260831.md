# PsyQ `SYS.obj` public scope restoration and exact data blueprint

Date: 2026-08-31

## Exact cross-version data proof

Canonical PsyQ 4.3 `LIBGPU/obj/SYS.obj` has a 416-byte `.data` section.
Removing its leading eight-byte archive-member library-information record
leaves 408 bytes. Those bytes align exactly with NFS4 retail
`0x80123654..0x801237EC`:

- every non-relocation byte is identical;
- all 72 differing bytes are canonical object relocation fields;
- applying the retail relocation targets explains the function-table and
  `printf` pointer values exactly.

This is a complete, non-speculative blueprint for the NFS4 SYS data owner. It
also proves that `GPU_printf` initially points to `printf`, rather than null.

## Source corrections landed in this round

Retail SYM and canonical SYS.obj both export `GPU_printf`, `GEnv`, `_qin`,
`_qout`, and `_que`. Their definitions now have external linkage. `_que` is a
real BSS definition rather than COMMON, and `GPU_printf` has its proven
`printf` initializer.

The private `D_8013EAD8`/`_gp1_shadow` storage is now emitted with local scope
from ordinary C storage definitions; neither spelling is exported by the
canonical member or retained by retail SYM. All 44 SYS function gates remain
PASS.

The stronger subsection-aware layout probe now places 301 data sections and
measures 98.43% in-place text bytes. This round improves the linked text count
by another 50 bytes while retaining all exact function bodies.

## Explicit remaining layout work

The current SYS source object still emits only 28 bytes of `.data`, while the
proven NFS4 owner is 408 bytes. Several zero-initialized low-address SYS state
objects are still emitted in BSS, and the high-BSS `_blit_buf`, GP1 shadow,
alignment tail, and `_que` need consolidation into their exact retail order.

This is not an underdetermined target: the canonical-minus-eight byte stream,
relocation table, retail addresses, and current semantic uses together provide
the exact data blueprint. It remains active source-restoration backlog and must
not be mistaken for a completed SYS layout claim.

Durable probe receipt: `psyq_sys_public_scope_probe_p435_20260831.json`.
