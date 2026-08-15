# W64-A2 RECEIPTS — draww belt + device lab

Repo HEAD at start: `fbc974f7`.  Every number below was re-gated by me with
`tools/verify_asm.py` (VA_MAX=400) on the tree at the time of measurement.
Predecessor receipts: `scratchpad/w63a2/RECEIPTS.md`.

## 0. RE-GATED BASELINE (`tools/tugate.py recon/game/psx/draww.cpp`) — 26/35 PASS

| fn | board % | w63 close | MY re-gated baseline |
|---|---|---|---|
| DrawW_BuildObjectFacets | 98.86 | 6 | **6** (189/189 count-exact) |
| DrawW_BuildChunkObjectFacets | 96.46 | 8 | **8** (434 count-exact) |
| DrawW_SubdividFacet | 98.94 | 35 | **35** (ours 587 / oracle 588, ONE SHORT) |
| DrawW_DoObjects | 92.79 | 30 | **30** (222 count-exact) |
| DrawW_BuildSpikeBelt | 95.13 | 66 | **66** (268/268 count-exact) |
| DrawW_DoTrough | 92.15 | 86 | **86** |
| DrawW_OnyxLinePrim | 98.36 | 101 | **101** (506/507, one short) |
| DrawW_BuildCustomObjectFacets | 81.76 | 105 | **105** (189/200, ELEVEN short) |
| Draw_kCtrlSkidmark | 91.07 | 303 | **303** |

No stale rows this time — every briefed number reproduced exactly.

---

# 1. 🏆 LANDED — DrawW_SubdividFacet **35 @587 (one SHORT) → 8 @588 COUNT-EXACT**

Two commits, `54a3eb83` (35→26) and `1dc25d1c` (26→8).  Zero PASS→FAIL on either;
`tugate` 26/35 unchanged; `tu_order_audit` 0; `psyqproof` (psq43 cc1 + ASPSX 2.77) improved in step: **REAL=21 -> 13**,
RELOP=0 both sides (HEAD control run via `scratchpad/w64a2/pq_ctl_sub.py`; the
35->26 step was production-NEUTRAL at 21, the 26->8 step took it to 13).

## 1A. The 12D DEAD-PSEUDO STAGING LAW, executed as briefed (35 → 26)

The SYM gives **BOTH** `v4` (the subdivide arm) **and** the leaf `prim` (the else
arm) as `REG $s3`.  They live in mutually exclusive arms, so retail carried them
in ONE pseudo — `v4` **is** the carrier the leaf prim is staged through.  The edit
is: lift `Draw_SVertex *v4;` to function scope, delete the leaf's own
`POLY_GT4 *prim;`, assign `v4 = (Draw_SVertex *)(sd->head).cprim.PrimPtr;` and cast
at the two leaf uses (the OT-link asm operand and the GT4 call).

Result: p90 + p187 merge into **p91**, the leaf shape becomes retail's
(`lw s3,4(s2)` … `addu a0,s3,zero`), the function is **COUNT-EXACT 588/588**, and
the entire residual collapses to a **pure `$s2` ↔ `$s3` swap** (120 diffs, every
single one a two-register rename).  Decl position of the fn-scope carrier is
inert (before or after `r_div`: identical).

## 1B. PREDICT-BEFORE-PROBE: the swap priced, then bought (26)

Read off the real CC1PLPSX `-dl`/`-dg` dump (`scratchpad/w64a2/pic.py`, which adds
the mandatory `-fno-exceptions -fno-rtti` that `tools/fast.py`'s `picture()` omits):

| pseudo | refs | live | pri = flr2(r)·r/live | got | retail wants |
|---|---|---|---|---|---|
| p91 (merged v4+prim) | 14 | 265 | **.1585** | `$s2` | `$s3` |
| p80 (`sd`)           | 25 | 752 | **.1330** | `$s3` | `$s2` |
| p187 (next rival)    | 10 | 260 | .1154 | — | — |

`sd` must sort ABOVE p91 and p91 must stay above p187.  A multi-operand read-only
fence on `sd` buys **+1 `REG_N_REFS` per operand at ONE barrier and ZERO bytes**
(06B/05C operand-count law).  With N operands: sd = (100+4N)/(752+N), p91 =
42/(265+N).  The crossing is at **N = 5** (N=4: .1534 vs .1561 — still wrong;
N=5: .1585 vs .1556 — flip).

**Measured, all count-exact 588/588: N=1,2,3,4 → 120 diffs; N=5,6,7,8 → 26.**
Predicted minimum == measured minimum.  Landed N=5.

Open angle that would retire the device: retail simply reads `sd` five more times
than our CSE'd body does — a natural-source `sd` re-read at the right positions is
the pin-free replacement.

## 1C. 🏆 THE BLOCK-LOCAL QTY **SET** IS THE DIAL, NOT ITS REFS/LIVE (26 → 8)

Residual 26 was one cluster: the v5..v8 index chain.  Retail keeps the chain base
in `$a3` and mutates it in place (`addiu a3,a3,3`); ours kept it in `$v1`.

Mechanism (13A): `find_free_reg` is a plain ascending scan.  With all four indices
derived straight off `n`, the three derived temps are **pairwise disjoint**, so
local-alloc collapses them all onto `$v0` and the chain base gets the next free
register, `$v1`.  Retail's `$a3` needs **both** `$v0` **and** `$v1` blocked over
the base's window — i.e. retail's block had one more *simultaneously live* qty.

Ladder (all count-exact 588/588, all measured by me):

| block shape | gate |
|---|---|
| base — all four indices off `n` | 26 |
| `short q = n + 2;` (v7/v8 off q) | 24 |
| `short q = n + 2;` **and** `short p = n + 3;` | 22 |
| `short q = n + 2;` mutated for v8 | 24 |
| retail's own pipelined `i1`/`i2` overlapping-live shape, 3 spellings | 26 / 26 / 28 |
| **`short q = n + 1;` (v6/v7/v8 off q)** | **8** |
| `short n1 = n + 1;` + `n = n1 + 4;` early, 2 spellings | 147 @**587** (one SHORT) |
| foreign-operand fences (1/2/3) inside the chain | 32 @**590** |

At 8 the chain's **registers are exact** (`$a3`, `$t8`, `$v0` all match).

**Residual 8 = FOUR insns at different POSITIONS with identical opcodes AND
identical registers** (`addiu a3,s4,1`, `addiu t8,a3,4`, `addiu v0,a3,2`,
`addiu a3,a3,3`) — a pure sched2 emission-order residual, no longer an allocation
one.  Falsified against it from the 8-diff basin: `v4 = &r_div->v[n++];` (8,
inert), a saved index temp `{short i0 = n; n = n+1; v4 = &v[i0];}` (8, inert), a
pipelined `q1` temp (26), both together (26).

---

# 2. 🏆 THE DEVICE FOLLOW-UP — REG_EQUIV LIVE-LENGTH DOUBLING **WITNESSED**, and its real gate found

Assignment: find the first witness for the second device
(`local-alloc.c:1149-53`, `REG_LIVE_LENGTH (regno) *= 2;`).
Lab: `scratchpad/w64a2/equiv_lab{,2,3}.cpp`, compiled with the real CC1PLPSX
(`-O2 -G4 -fno-exceptions -fno-rtti -dl`), read off `Register N used R times
across L insns`.  The `-dl` dump is emitted AFTER `local_alloc()`
(`toplev.c:3446-3457`), i.e. after `update_equiv_regs()`, so the doubled value is
visible there.

## 2A. FIRST WITNESS (probeL / probeO vs probeN)

| probe | `k`'s source | refs | live | raw span | verdict |
|---|---|---|---|---|---|
| **L** | `loc[3]` — an **sp-relative** local array element | 5 | **10** | 5 | **DOUBLED** |
| **O** | same, one more use of `k` | 6 | **12** | 6 | **DOUBLED** (scales) |
| N | L + `*h = a;` (unknown-alias store inside k's life) | 5 | 7 | 7 | not doubled — control |
| M | `k = a + 3` (arithmetic, no MEM) | 5 | 6 | 6 | not doubled — control |

Exactly 2× in both firing cases, and it tracks one extra use — the note is real.

## 2B. 🔴 THE GATE THE w63 WRITE-UP MISSED — `validate_equiv_mem` REFUSES ANY ADDRESS REGISTER THAT DIES

`validate_equiv_mem` (local-alloc.c) returns 0 as soon as it sees a `REG_DEAD`
note for **any register mentioned in the MEM** inside the scan.  Consequences,
all measured:

* **`extern` globals are STRUCTURALLY EXCLUDED under split-addresses**: `k = g[3]`
  builds the address as `%hi` into a pseudo that **dies ON the load** →
  `reg_overlap_mentioned_p` hits → no note.  probeF (`k = g[3]`, block-local,
  no stores at all) shows live 6 = raw 6, **not** doubled.
* **A long-lived pointer deref does not reliably fire either** (probeJ `k = p->d`
  with `p` used later: live 6, raw ~5-6): sched1 runs BEFORE local-alloc and can
  move `p`'s last use above `k`'s death, killing the note.
* The reachable trigger is therefore an **sp/fp-relative MEM** (local array /
  struct member) — hard regs carry no `REG_DEAD` notes.
* Any intervening call (unless `RTX_UNCHANGING_P`) or aliasing store kills it
  (probeN).

## 2C. 🔴 THE CONSTANT ROUTE IS EFFECTIVELY UNREACHABLE FROM C

`local-alloc.c:1116` promotes a `REG_EQUAL` note whose source is `CONSTANT_P`.
But a plain `int k = 0x12345678;` on this target is emitted as a single
`(set (reg) (const_int))` — `SET_SRC` *is* the constant, so there is **no
REG_EQUAL note to promote** — and a LICM-hoisted literal is the same shape.
Measured: probeP (loop-invariant `& 0x12345678`, hoisted) live 11 vs probeQ (the
same mask arriving from memory) live 11 — **identical, no doubling**.
Also falsified: a big constant split across `lui`+`ori` would set the pseudo
TWICE (`REG_N_SETS != 1`, the :1101 gate).

## 2D. WHY IT IS NARROW — the two gates fight each other

The MEM route requires `REG_BASIC_BLOCK (regno) >= 0`, i.e. a **block-local**
pseudo — and `QTY_CMP_PRI` (local-alloc.c:1727) is
`floor_log2(qty_n_refs)*qty_n_refs*qty_size / (qty_death - qty_birth)`, computed
from **qty birth/death, not `REG_LIVE_LENGTH`** (gcc's own comment at :1150 says
so).  So the doubling can only bite when the block-local qty **fails** local
allocation and falls through to `global_alloc`, whose `allocno_compare` *does*
read `REG_LIVE_LENGTH`.

**The usable side effect is the bigger one:** the note also sets
`reg_equiv_replacement[regno]`, so a pseudo that loses allocation has its uses
**replaced by the MEM** — which is exactly retail's `lw aN,off(sp)`-at-every-use
shape in the ARG-spill class (BuildCustomObjectFacets).  That is the named angle
this device should be aimed at next, not at priority dialling.

---

# 3. THE REST OF THE BELT — measured, not moved

## 3A. DrawW_BuildCustomObjectFacets (105 @189/200, ELEVEN SHORT) — 🔴 the briefed cure FALSIFIED, two NEW structural facts banked

**FALSIFIED — the imported tenchu "fence-free param-copy" cure** (tenchu-decomp
`src/main.exe/FUN_80057b80.c`: rename the formals, declare ordinary locals, copy
them in a chosen order, use the locals throughout).  All four forms leave the
**insn count at 189** — the copies are copy-propagated away — and only rotate the
coloring: `{Vi,sd,simObjs}` copied in order 1/2/3 = **209**, 3/2/1 = **209**,
2/3/1 = **209**, `sd` alone = **107** (base 105).  In tenchu the device was a
save-ORDER dial; it changes *which* pseudo wins a register and cannot make a
param **lose** one, which is what this function needs.

**NEW FACT (1) — the fixedmult row shape is 3-CALLS-THEN-3-STORES.**  Retail runs
all three multiplies of a row keeping TWO results in callee-saved regs
(`addu s5,v0,zero` … `addu s3,v0,zero`) and only then stores
(`sw s5,32(sp); sw s3,44(sp)`, with the third store riding the NEXT call's delay
slot).  Ours stores m[0]/m[3] around the third call and needs only ONE saved reg.
Rewriting all three rows: **205 @193** (+4 insns toward the oracle).

**NEW FACT (2) — `objMat_p = (int)simObjs` in the comma slot is a Ghidra
fiction.**  Retail's insn in that `Object_GetAnim` delay slot is
`addu s2,s4,zero` = the SYM's `objCollideBoomInstance` SECOND WALKER being born.
Routing the quat copy (+0x14) and the blend reads (+0x1c/+0x1e/+0x20) through it:
**189 @191** (+2).  COMPONENT_REF and cast-int spellings of those reads are
byte-identical (the alias class is not a dial here).

Both together: **247 @197** — only THREE short vs eleven today, but the frame
grows 128→136 and `sd` STILL takes a saved reg (`$s7`) while totalCount and
objDef spill.  So the w46-a6 reading stands: the two new allocnos land on the
wrong rivals, and the route remains the WHOLE rule-8 rewrite — with (1) and (2)
now quantified as two of its pieces.  Receipted in-source.

## 3B. DrawW_BuildObjectFacets (6 @189/189) — 5 more falsifications, class (B) unchanged

Residual is the `goffsets[]` ADDRESS qty (`lui t0` ours vs `lui v1` oracle, and
our `lui` hoisted one slot above the index `lbu`).  Five spellings measured, ALL
identical at **11 @188 (one SHORT)**: index-term-first cast, named index temp,
base-first cast, `goffsets + idx` pointer add, and a named index + a copy temp
(the copy folds).  This reproduces and extends the w50-a2 in-source list — the
address-qty *spelling* axis is now strongly closed.  The live dial is unreachable
because the qty's whole range sits inside one expression (w63 finding, confirmed).

## 3C. DrawW_BuildSpikeBelt (66 @268/268) — the qty-SET lever does NOT transfer

posdiff: first-use register order is **oracle-IDENTICAL**, count exact, structural
residual 32 ⇒ pure emission order + three 2-way local-alloc handouts (w53/w61
clusters a/b/c).  New falsifications from this basin:
in-place `t >>= 1` before the assignment (one temp) **204 @266**; three temps with
in-place shift **76**; loads-first-then-shifts **76**; the oracle's own
interleave **76**; and the §1C qty-SET lever applied here — a SECOND distinct
block temp in the fx/fy/fz block — **72 / 78 / 72** (all three placements).
The base (ONE reused temp, SLD order) remains the best.

## 3D. DrawW_DoObjects (30 @222/222) — characterized only, as briefed

Re-gated 30, count-exact.  Unchanged class: six 1-3-slot transpositions (all
ours-EARLIER = the sched2 drain class) + the range-chain rematerialization.  The
standing named angle is a real `$a0` CLOBBER between the two track-guard chains
that is not an extra insn — **hard-register clobber fences are the USER-sign-off
class** (AGENT_GUIDE §4.4), so this row cannot be closed by any instrument an
agent is allowed to use.  It belongs on the user-decision list next to
`CalcUsedPrice`.

## 3E. Not worked this pass (budget): DoTrough 86, OnyxLinePrim 101,
Draw_kCtrlSkidmark 303, BuildChunkObjectFacets 8.
For OnyxLinePrim I ran posdiff: **506 vs 507 (one short)** with a five-way saved-reg
rotation (ours `fp s5 … s7 … s3` vs oracle `s3 s6 … fp … s5`) — the SYM 8c block
already names every one of those homes (geomVertices=$s3, lineQuad=$s6, sd=$s1,
prim=$s0, lineQuadCount=$fp, pmx=$s4, save_pre_otz=$s7), so this is a whole-fn
REGPARM/allocno-order job of the same family as §1B, and the priced-dial recipe
(allocsim/reqdelta → fence operand count) is the direct next step.

---

# 4. TOOLS / FILES

* `scratchpad/w64a2/pic.py` — allocno picture with the mandatory `-fno-exceptions
  -fno-rtti` lab flags (fast.py's `picture()` omits them; 12H fidelity).
  Prints `pri = floor_log2(refs)*refs/live` per pseudo.  **Promote-worthy.**
* `scratchpad/w64a2/apply_probe.py` — patch a TU from a probe module's `VARIANTS`,
  run any command, restore in `finally` (used to drive side_by_side/posdiff/pic
  under a variant).
* `scratchpad/w64a2/p_{bcof,bcof2,sub,sub2,sub3,sub4,sub5,sub6,belt,belt2,bof}.py`
  — the probe modules behind every table above.
* `scratchpad/w64a2/pq_ctl_sub.py` — psyqproof HEAD-control run.
* `scratchpad/w64a2/equiv_lab{,2,3}.cpp` — the REG_EQUIV device lab.
* Backups: `draww.cpp.after_subdivid_26.bak`, `draww.cpp.after_subdivid_8.bak`.

## HAZARDS HIT
* `tools/fast.py`'s anchor-ending fix is per-anchor; an anchor that is unique
  *inside* the target function can still be non-unique in the TU (three fns in
  draww.cpp share the OT-link asm operand line) — the miss showed up as
  `'v4' undeclared` 4000 lines away.  Anchor on a multi-line block and assert
  `count == 1` (my `apply_probe.py` does).
* `sed`/`cat -A` reported the goffsets region as LF-only when the file bytes are
  CRLF — read endings from the raw bytes, never from a line tool.
