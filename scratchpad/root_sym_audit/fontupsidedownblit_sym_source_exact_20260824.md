# `FontUpsideDownBlit` SYM-source cleanup — 2026-08-24

Owner: `PSXFront.obj`

Function: `FontUpsideDownBlit__FiiPviiP12charactertbli`

Retail VA: `0x8004efb4`
Source: `recon/frontend/psx/psxfront.cpp`

## Landed source reconstruction

- The mangled signature proves seven ABI arguments, but retail emits no debug
  declaration for the final `int`.  The definition and header therefore retain
  the slot without inventing a parameter name.
- The packet-head expansion no longer declares `pal`; it expresses both
  `addPrim` link operations directly through `Render_gPalettePtr`.
- The geometry expansion no longer declares `bottom` or `right`; the shared
  sums are expressed at their packet stores.
- The reconstruction-only zero-instruction geometry fence was removed.  The
  function now contains neither `asm` nor `volatile`.
- The only source locals are the four retail names: `prim`, `width`, `height`,
  and `dv`.

## Full-debug receipt

A fresh `CC1PLPSX.EXE -O2 -G4 -g` compile emits the same semantic declaration
set and single lexical block as retail:

| name | retail/source class and type | retail register | reconstructed register |
| --- | --- | ---: | ---: |
| `x` | REGPARM `int` | `$a0` | `$a0` |
| `y` | REGPARM `int` | `$t8` | `$a1` |
| `src` | REGPARM `void *` | `$a2` | `$a2` |
| `u` | REGPARM `int` | `$a3` | `$a3` |
| `v` | ARG then REG `int` | stack `+16`, `$s0` | stack `+16`, `$s0` |
| `ch` | ARG then REG `charactertbl *` | stack `+20`, `$v0` | stack `+20`, `$v0` |
| `prim` | REG `POLY_FT4 *` | `$t1` | `$t1` |
| `width` | REG `int` | `$t7` | `$t7` |
| `height` | REG `int` | `$t6` | `$t6` |
| `dv` | REG `int` | `$t0` | `$t0` |

Thus all recoverable source names, types, storage roles, and block ownership are
restored without a source-only carrier.  The remaining `y` register location is
compiler allocation evidence, not a missing source declaration, and remains
visible in the binary residual rather than being hidden by invented source.

## Matching receipt

- Authoritative focused gate: 82 reconstructed / 82 retail instructions,
  52 diffs after the existing per-function scheduling receipt.
- `psxfront.cpp`: 24/25 PASS; no previously matching neighbor regressed.
- The earlier 20-diff body was rejected for SYM restoration because it depended
  on four absent source devices: named `arg6`, `pal`, `bottom`, `right`, plus an
  assembly fence.
- A static-inline `+5` helper reached 26 diffs and assigned `y` to retail `$t8`,
  but full-debug compilation emitted two extra nested block pairs.  It was
  rejected rather than reporting a false SYM-exact result.

The remaining residual is confined to the `y` allocation and the resulting
addPrim/font-tint/tpage scheduling echoes.  Future work must preserve this
declaration and block receipt and must not use `asm` or `volatile`.
