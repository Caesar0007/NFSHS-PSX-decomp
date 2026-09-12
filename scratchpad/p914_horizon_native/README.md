# P914 Horizon native source analysis

Read-only review of actual hrzsku.cpp `8e901f0e...` and object `dd530c8d...`.
The target's existing 320 bytes already equal all 80 raw retail words literally,
with no relocations. The source identity issue is real despite this byte match.

## Native contract

Function record **40db8c..40dd07**:
`Horizon_InterpolateLineSCoords__FP7DVECTORN20Piii`, 800CF574..800CF6B4,
VOID return, frame 0, mask 0; HRZSKU.CPP:128..156.
Native SLD records: **40bf29..40bfc7**.

| Parameter | Native location record |
|---|---|
| `sc`, PTR DVECTOR | 40dbf3, t1/register9; copied from incoming a0 |
| `s0`, PTR DVECTOR | 40dc0d, a1/register5 |
| `s1`, PTR DVECTOR | 40dc27, a2/register6 |
| `percentage`, PTR INT | 40dc41, a3/register7 |
| `n`, INT | 40dc59 ARG stack+16; 40dc86 REG t3/register11 |
| `bPercentageArray`, INT | 40dc68 ARG stack+20; 40dc95 REG v0/register2 |

These are six source parameters with eight location records, not eight source
parameters. The only ordinary locals are **`i` and `p`**:

| Scope record | Depth | Native span | Native declaration |
|---|---:|---|---|
| 40dcb3 | 0 | 800CF574..800CF6AC | `int i`, register8/t0, record40dcbc |
| 40dccb | 1 | 800CF574..800CF6AC | Empty |
| 40dcd4 | 2 | 800CF61C..800CF6AC | `int p`, register4/a0, record40dcdd |

`pv` does not exist in the native function record. Most importantly, **native
`p` is the scalar percentage captured in the else arm, not an arithmetic product**.
The raw `lw a0,0(a3)` at CF61C loads it once, before the nonpositive-count guard.
It remains in a0 throughout both scalar-arm coordinate calculations. The products
are anonymous v0 temporaries, not SYM named locals.

## Strong source-shape helper

`C:/Temp/nfs2-clean/pc-beta/match/Horizon/Horizon_InterpolateLineSCoords.c`
is a direct matched-source content twin. It contains exactly:

- One root `int i`.
- Two ordinary `for (i = 0; i < n; i++)` loops.
- Two direct coordinate assignments per loop, using signed 32-bit product
  divided by 65536, with no explicit bias temporary or conditional.
- The array branch reads `*percentage` independently for each coordinate,
  then performs `percentage++`, `s0++`, `s1++`, `sc++`.
- The scalar branch declares `int p = *percentage` before its loop, then uses
  `p` for both coordinates and advances only `s0`, `s1`, and `sc`.

Only platform fields change from SCOORD.x/y to native DVECTOR.vx/vy. This helper
is source evidence, not a substitute for PSX byte/SLD gates. A good first parent
candidate is that complete shape, preserving all actual native names and types.
Do not carry over `pv`, the product-as-p assignments, the absorption identity,
or historical fence commentary. No replacement local is needed.

## Exact native statement groups

| Native line | Instruction indices | Source operation |
|---:|---|---|
| 128 | 0..1 | Stack argument loads |
| 131 | 2..3 | Array/scalar selection; sc copied to t1 in delay slot |
| 133 | 4..6 | First for-loop count guard, i=0, signed-division mask |
| 135 | 7..19 | Complete array-arm vx assignment |
| 136 | 20..32 | Complete array-arm vy assignment |
| 138 | 33 | percentage++ |
| 139 | 34 | s0++ |
| 140 | 35 | s1++ |
| 142 | 36..41 | i++, loop comparison/backedge, sc++ in delay slot, first return |
| 146 | 42 | Else-local p = *percentage |
| 148 | 43..45 | Second for-loop count guard, i=0, division mask |
| 150 | 46..58 | Complete scalar-arm vx assignment |
| 151 | 59..71 | Complete scalar-arm vy assignment |
| 153 | 72 | s0++ |
| 154 | 73 | s1++ |
| 156 | 74..79 | i++, loop comparison/backedge, sc++ in delay slot, final return |

Each arithmetic group includes signed halfword delta loads, 32-bit `mult/mflo`,
negative-product +65535 bias, arithmetic right shift16, base-coordinate addition,
and halfword store. This is the compiler expansion of signed `/65536` truncating
toward zero. A plain signed shift does not have the same negative rounding;
64-bit multiplication would also change the operation. The lhu base reload is
compatible with the final halfword truncation, not proof of an unsigned source
DVECTOR field.

## Preserve these semantic distinctions

The array arm reloads the coefficient before vy, after writing vx. Do not hoist
or share those two reads: the raw preserves their ordering. The scalar arm
captures `p` even when n is zero/negative; moving that dereference inside its
loop would remove an executed read. The first arm advances the coefficient
pointer by **four bytes / one int**, and the DVECTOR pointers by **four bytes /
one DVECTOR**. Updated M2C prints `var_a3 += 4` despite typing var_a3 as int*;
transcribing that typed increment would incorrectly advance sixteen bytes.
IDA's `_WORD* +=2` rendering has the correct four-byte stride but not the native
DVECTOR type. Its BOOL return is also an inference from stale v0 branch results;
native SYM declares VOID.

There is no asm or volatile token in the current target body after removing
comments. Its claims about an active fence/ASPSX register syntax are stale.
The remaining `i | (i & 3)` assignment is a real source token but an artificial
identity, not native statement evidence. Other hrzsku functions are out of scope.

`inventory.json` contains the complete native records, per-word raw proof,
parameter/local scopes, helper hashes and statement memberships. Parent owns
candidate compilation and full-TU/debug neighbor checks. This analysis makes no
unverified PASS claim for the proposed source rewrite.
