# PsyQ SYS exact data/BSS owner proof (P437, 2026-08-31)

## Canonical data owner

Canonical PsyQ 4.3 `LIBGPU/obj/SYS.obj` has a 0x1A0-byte initialized-data
member.  Removing its eight-byte library-information prefix produces the exact
NFS4 retail SYS data interval `0x80123654..0x801237EC` (0x198 bytes): every
non-relocation byte agrees, and all 72 remaining fields are canonical
relocations.  `recon/syslib/psx/libgpu/SYS.c` now emits that owner as one
0x198-byte `.data` section in the canonical declaration order.

Key object offsets are:

- `_gpu_tbl` 0x000 and `GEnv_drv` 0x040;
- `GPU_printf` 0x044 (initialized to `printf`) and `GEnv` 0x048;
- `_move_prim` 0x0E0, `_otc_term` 0x0F4, `_otc_link` 0x108;
- display tables at 0x118 and 0x140;
- hardware-register pointers at 0x14C..0x16C;
- `_qin` 0x170, `_qout` 0x174, queue state through 0x197.

The object relocation table has the expected 16 driver-table relocations plus
`GEnv_drv -> .data` and `GPU_printf -> printf`.

## Exact high-BSS owner

One guide-permitted file-scope storage block now represents the continuous
retail high-BSS owner:

- `_blit_buf` at section +0x000, 72 bytes total;
- `D_8013EAD8` at +0x028, the interior `_blit_buf + 10` view;
- `_gp1_shadow` at +0x048, 256 bytes;
- unnamed eight-byte alignment tail;
- public `_que` at +0x150, 0x1800 bytes.

The emitted `.bss.sys_8013EAB0` section is exactly 0x1950 bytes.  Therefore a
retail start of `0x8013EAB0` places `_que` at `0x8013EC00` and ends at
`0x80140400`, immediately before `readcmd`.  `_blit_buf`, its interior view,
and `_gp1_shadow` are local; `_que` is the canonical public definition.

## Matching and project gates

- `tools/tugate.py recon/syslib/psx/libgpu/SYS.c`: 44/44 PASS.
- All other changed owner TUs: PATCH 4/4, END 1/1, C_004 1/1, drv 14/14,
  PADMAIN 11/11, PADIF 5/5, PADPORTD 8/8 PASS.
- `tools/relink.py --lane both`: GREEN; real duplicates 0, hidden phantoms 0,
  relocation-referenced unresolved symbols 0 in both lanes.
- undefined-call audit: recon 15,781 and src 15,779 call relocations, zero
  undefined targets.
- vtable audit: 1,017 files, zero unsafe row indexing.
- TU-order audit: 521 objects, zero inversions.
- call-target audit: 466 units, zero proven wrong targets.
- text-move audit: PASS; no post-compiler rewrites.
- phantom audit: 518/518 TUs compile, 3,491/3,491 oracle functions exact-owned,
  zero hidden and zero unmatched.
- data-name audit: 69 names, 66 canonical same-member names and three explicit
  address placeholders whose private spelling is unrecovered; zero read
  failures and no generic/unclassified disposition.

Machine receipts are the sibling P437 JSON/TSV files.
