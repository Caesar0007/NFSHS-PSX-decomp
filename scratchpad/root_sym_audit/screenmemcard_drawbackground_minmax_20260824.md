# `tScreenMemcard::DrawBackground` SYM/source restoration receipt

Date: 2026-08-24

Retail owner: `ScreenMemcard.obj`

Source TU: `recon/frontend/common/screenmemcard.cpp`

Reliable SYM locals for the function are `x`, `y`, `gray`, `fade`, `fadebox`,
`gridpos`, `fTextFade`, `ColText`, `rr`, outer `i`, nested `i`, and nested `k`.
Their retail homes are `$s0`, `$s0`, `$s6`, `$a1`, stack `-56`, stack `-48`,
`$s0`, `$s0`, stack `-64`, `$fp`, `$v1`, and `$s0` respectively; `this` is the
`$s7` register parameter.

SLD assigns the `fadebox`, `gridpos`, and `fTextFade` clamps to single retail
source lines 577, 579, and 581.  The matched NFS2 PC beta header preserves EA's
operand-order-sensitive definitions:

```c
#define MIN(a,b) (((a) > (b)) ? (b) : (a))
#define MAX(a,b) (((a) > (b)) ? (a) : (b))
```

Using `fTextFade = MAX(MIN(0x80,fade * 2),0);` reproduces NFS4's retail code
exactly and removes `value`.  The completed clamp reconstruction also reuses
retail's existing `short x`:

```c
fade = (ushort)this->fScreenFadeVal * 2;
x = (ushort)this->fScreenFadeVal * 2 - 0x80;
fadebox = (x = MAX(MIN(0x80,x),0));
gridpos = MAX(MIN(0x80,fade >> 1),0);
fTextFade = MAX(MIN(0x80,fade * 2),0);
```

The chained assignment is codegen-significant: routing the first result through
the SYM register local `x` reproduces retail's single `$a0` funnel and final
stack store.  The former `fadeCalc` local and empty compiler fence are absent.
Other operand orders, direct assignment to `fadebox`, and hand-written clamp
forms produced 8–26 authoritative differences.

SLD lines 673-674 identify an in-place adjustment of the existing `y`, followed
by the final `DrawHorizontalLine` call.  The source now expresses those two
statements directly inside the lexical block that owns nested `int k`; the
former `finalDir`, `finalStartX`, `finalGouraudX`, `finalMessageH`, `finalX`, and
`finalY` aliases are all removed without changing the object code.

## Remaining evidence-backed ambiguity

A fresh `CC1PLPSX -O2 -G0 -g` compile emits the complete retail local set above
plus exactly six source-only geometry definitions:

| source carrier | fresh debug home |
|---|---|
| `gouraudX` | `$a2` |
| `gouraudY` | `$v1` |
| `extraY` | `$a3` |
| `startX` | `$s3` |
| `startY` | `$s2` |
| `width` | `$s1` |

These six names are absent from retail SYM.  Replacing all six with direct
`ushort` expressions is FAIL 33 at 413 reconstructed versus 410 retail
instructions.  Removing only the coalesced `startX`/`startY`/`width` aliases is
count-exact FAIL 6.  The PASS form is retained with an in-source
`SYM-CODEGEN-CARRIER` receipt pending discovery of the original expression or
macro shape.  In contrast, explicit source locals `w` and `h` emit no `.def`
records in this fresh debug build, proving that absence from retail SYM alone
does not establish that those optimized-away source declarations were absent.

Verification:

- focused `verify_asm.py`: PASS, 410 instructions
- complete `screenmemcard.cpp` TU: 15/15 PASS
- full frontend bulk gate: 836/838, zero compile failures; the bulk renderer
  alone still presents the known two-instruction unresolved-relocation pair for
  this body
- both relink lanes: GREEN, with zero real duplicates, hidden phantoms, or
  genuine relocation-referenced unresolved names
- vtable indexing audit: PASS in 930 files

The only remaining function-local source-restoration backlog is the six measured
geometry carriers above.  The owner type graph's monolithic-header provenance
issue remains separate and is not represented here as closed.
