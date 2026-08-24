# `tScreenMemcard::DrawBackground` MIN/MAX restoration receipt

Date: 2026-08-24

Retail owner: `ScreenMemcard.obj`

Source TU: `recon/frontend/common/screenmemcard.cpp`

Reliable SYM locals for the function are `x`, `y`, `gray`, `fade`, `fadebox`,
`gridpos`, `fTextFade`, `ColText`, `rr`, outer `i`, nested `i`, and nested `k`.
The former reconstruction also declared an explicit `int value` solely to
carry the `fade * 2` clamp.

SLD assigns the `fadebox`, `gridpos`, and `fTextFade` clamps to single retail
source lines 577, 579, and 581.  The matched NFS2 PC beta header preserves EA's
operand-order-sensitive definitions:

```c
#define MIN(a,b) (((a) > (b)) ? (b) : (a))
#define MAX(a,b) (((a) > (b)) ? (a) : (b))
```

Using `fTextFade = MAX(MIN(0x80,fade * 2),0);` reproduces NFS4's retail code
exactly and removes `value`.  Other operand orders and hand-written clamp forms
produced 16–26 authoritative differences.

Verification:

- focused `verify_asm.py`: PASS, 410 instructions
- complete `screenmemcard.cpp` TU: 15/15 PASS
- full frontend bulk gate: unchanged at 836/838; the bulk renderer alone still
  presents the known two-instruction unresolved-relocation pair for this body
- both relink lanes: GREEN
- vtable indexing audit: PASS in 930 files

Remaining source-restoration backlog: explicit geometry and final-message
temporaries still appear in C++ but not in the reliable SYM local list.  The
owner type graph also remains a strict DIFF because it still includes the
monolithic project type header.  Neither issue is represented here as closed.
