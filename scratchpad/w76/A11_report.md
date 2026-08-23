# W76-A11 report — game-misc belt (nfs3 / bworld / cario)

Repo `C:\Temp\nfs4-decomp`. No commits, no staging. `tools/build.py` untouched.
Memory dir read-only, unmodified. Session was cut by the orchestrator mid-belt
(budget); per the resume order, target 2 was finished and landed, targets 1 and 3
were NOT started (baseline-only) — their W75 named angles remain the live routes.

## Baseline → final (whole-TU gates run twice at each end, identical both times)

| fn | TU | baseline | final |
|---|---|---|---|
| `NFS3_CheckForFileOperations__Fv` | game/common/nfs3 | FAIL 2 @21/21 | **PASS 21/21 — PIN-SEALED** |
| `SetupChunkBuildList__FP13DRender_tView` | game/common/bworld | FAIL 4 @203/203 | FAIL 4 @203/203 (untouched) |
| `CarIO_ReadInCarTextureData__FPcP8Car_tObjii` | game/psx/cario | FAIL 19 @492/491 | FAIL 19 @492/491 (untouched) |

TU gates: `nfs3 10/11 → 11/11 PASS` (×2 before, ×2 after receipt landing);
`bworld 20/21 PASS` (×2); `cario 10/11 PASS` (×2). **ZERO PASS→FAIL tree-wide.**
Only file changed: `recon/game/common/nfs3.cpp`.

## PIN-SEALED items (counted separately per policy)

* **`NFS3_CheckForFileOperations__Fv` — PASS 21/21, wordcmp REAL=0 (2 reloc-only
  words, expected unlinked), `tools/slotcheck.py` bad=0 (run on the final object,
  after the receipt landing).** Uses three `register … __asm__("$N")` pins + one
  zero-insn opacity launder; full falsification field in the in-TU receipt block.

## Target 2 — nfs3 (2 @21/21 → PASS): what happened, in order

### (a) The W75 named angle was walked FIRST and falsified (policy order)

"A source shape in which the guard bound is never a pseudo — the guard test
carrying the MEM directly, the loop bound a separate pseudo." Real gate runs:

* bound read in head block, guard carries a MEM re-read, fence on `e` … **8 @21/21**
* the same without the fence ……………………………………………… **8 @21/21**
* anonymous guard temp (guard reads MEM first), `e` re-read in the
  preheader, fence on `e` ………………………………………………… **3 @22/21**

Mechanism: cse folds a second read of the SAME MEM into the earlier pseudo in
every ordering, so the guard bound always keeps ≥2 same-block refs and stays
allocated. Additionally read off `local-alloc.c:1169-1173` (2.8.1 source): the
`reg_equiv_replace` arm needs `REG_N_REFS==2 && REG_BASIC_BLOCK<0` — a guard
compare's set and use share a block by construction, so the "never a pseudo"
demotion is unreachable from C for a guard bound, period. This completes the
W75 certificate (flow.c −1 = setjmp-only was verified against the source too;
`update_equiv_regs`' REG_EQUIV note alone only does `REG_LIVE_LENGTH *= 2` —
a priority nudge, never a demotion). ⇒ pin lane legitimately reached.

### (b) The construction that sealed it (three pins, one launder, no fence)

```c
{
  register int *g __asm__("$4") = (int *)gFileMgr.handlearray;  /* lw a0,0x1C(v0) */
  if (p < g) {
    e = g;                                  /* addu a1,a0,zero — beqz slot */
    do {
      if (*p != 0) {
        register int z0 __asm__("$6");
        register int z1 __asm__("$4");
        z0 = 0;                             /* addu a2,zero,zero — inner beqz slot */
        __asm__("" : "=r"(z0) : "0"(z0));   /* zero-insn opacity launder */
        z1 = z0;                            /* addu a0,a2,zero — retail's word */
        __asm__ __volatile__("break 0x666\n\tnop" : : "r"(z0), "r"(z1));
      }
      p = p + 1;
    } while (p < e);
  }
}
```

All three retail registers are taken BY CONSTRUCTION and no reload is left in
the function — the entire spill-pool/cursor question (W75's validated model)
dissolves. The W74 read-only fence was REMOVED after a 23B-3 device-removal
retest (still PASS): z1's `$4` is **scope-live** through g's block, so the arm
pin now supplies the G/L conflict that keeps the preheader copy real.

### (c) Falsified on the way (each a real gate run; mechanism dump-verified)

* z-pins with plain inits, g **unpinned** + W74 fence ……… 8 @21/21 — the fence
  extends pseudo-G through the arm → G conflicts the arm pins → G displaced to
  `$a1`, L to `$a3`. (Fence-extended pseudo + arm pins are mutually exclusive.)
* g pinned, z inits `= 0` (decl order z0,z1 AND z1,z0) …… 5 @22/21
* g pinned, separate statements `z0 = 0; z1 = 0;` ………… 5 @22/21
* g pinned, `z1 = z0` WITHOUT the launder …………………… 5 @22/21 (cse
  const-props it back to `(set $4 0)`)
* **Mechanism (fresh `-dS` sched1 dump, not guessed):** `$4` is scope-live
  through g's block, so `(set $4 0)` carries the longer dependence chain and
  sched1 places it BEFORE `(set $6 0)` regardless of statement/decl order;
  reload_cse then rewrites the *second* zero as a copy from the *first* —
  mirror of retail. The launder makes z0's value opaque so `z1 = z0` keeps a
  true dependence: order forced, z0's set lands in the inner beqz slot (gcc's
  own dbr fill), and z1's set IS retail's `addu a0,a2,zero`.

### (d) Also banked in passing — STALE-DUMP TRAP (process)

`tools/rtl_dump.py` only regenerates the dumps named by the flags you pass;
`scratch/rtl/nfs3.i.{greg,combine,jump,…}` from a W74 run sat next to my fresh
`-dS` output and nearly sold a false "pins dissolve at combine" story (the
stale greg showed the pre-W74 fence-less state). Check dump mtimes before
reading any `scratch/rtl/` file, or delete the directory first.

## Targets 1 & 3 — NOT started (orchestrator budget cut; no probes run)

* **bworld `SetupChunkBuildList` 4 @203/203** — untouched, gated 2× at baseline.
  Live angle (W75/W76 brief): give the `%hi/%lo(BWorld_gChunkBuildList)` pair an
  in-block DATA PREDECESSOR chain of depth ≥3 from source (§24D-7); corpus-mine
  chunk-list builders; last resort = an asm insertion that creates the chain.
* **cario `CarIO_ReadInCarTextureData` 19 @492/491** — untouched, gated 2× at
  baseline. Live angle (W75): a head-block spelling where the gp-loaded value
  and the memory-homed local have OVERLAPPING live ranges (22C-7) so cse cannot
  collapse the temp into pseudo 88; §24E-3 target-only read fence is the named
  instrument; success predicts the landed `r`-fence (and its +1 insn) becomes
  unnecessary → 491 count-exact.

## Catalog-worthy items for the orchestrator

1. **GUARD-BOUND DEMOTION IS CLOSED AT SOURCE LEVEL (cited):** the only
   unallocated-with-REG_EQUIV path a free-register function has is
   `reg_equiv_replace` (`local-alloc.c:1169`, needs REG_N_REFS==2 &&
   REG_BASIC_BLOCK<0); a guard compare's bound can never satisfy BB<0. Any
   future "make the bound a pure reload" ask on a guard test is dead on arrival.
2. **REGISTER-PIN SCOPE-LIVENESS LAW (new, dump-verified):** a local
   `register T x asm("$N")` keeps `$N` live throughout its enclosing SCOPE
   (not just set→use), visible as `Registers live: N` in every covered block.
   Consequences measured: (i) it conflicts with every allocno spanning the
   scope (this is a usable conflict GENERATOR — it replaced the W74 fence);
   (ii) a set of a scope-live hard reg carries a longer sched1 chain and is
   hoisted above its neighbours — statement order is NOT a dial there; force
   order with a true dependence through an opacity launder.
3. **PIN + reload_cse COMPOSITION:** when two constants must materialize as
   `li rA,K; move rB,rA` (retail's reload_cse copy), spell it as two pinned
   vars with `z1 = z0` through a launder — the copy is then retail's word by
   construction and survives every pass. (The plain `z1 = z0` is const-propped;
   the launder is load-bearing.)
4. **STALE-DUMP TRAP** (see (d) above) — rtl_dump leaves older-flag dumps in
   place; mtime-check before quoting any dump.

## Gate log (every edit was followed by a gate; probes restored before the next)

nfs3 per-fn: baseline 2 → P1 8 → P1b 8 → P2 3@22 → P5 8 → P6 5@22 → P7 5@22 →
P8 5@22 → P9 5@22 → P10 5@22 → P11 5@22 → P12 **PASS** → restructure (host-branch
brace balance + guarded pins) **PASS** → fence removal **PASS** → receipt landed
**PASS**; TU 11/11 ×2; slotcheck bad=0; wordcmp REAL=0.
