# W75-A1 — `__15tGlobalMenuDefs` (frontend/common/femenudefs) — REPORT

**Result: 1238 → 1138 diffs (−100, −8.1%), instruction count UNCHANGED (3215 vs oracle 3207).
TU 65/66 PASS on both gate runs. ZERO PASS→FAIL anywhere. Nothing sealed.**

| metric | baseline | final |
|---|---|---|
| `verify_asm` diffs | 1238 | **1138** |
| ours / oracle insns | 3215 / 3207 | 3215 / 3207 |
| reg-blind LCS (structure) | 256 | **200** |
| reg+spill-blind LCS | 196 | **144** |
| t0↔t1 phase-flipped insns | 386 | 382 |
| TU gate | 65/66 PASS | 65/66 PASS (×2) |

Baseline established before any edit (`tugate.py`), re-gated after every edit, whole TU
gated twice at the end, plus `build.py --skip-asm` green twice.

---

## 1. THE LANDED LEVER — **THE VPTR-STORE ALIAS DIAL** (new, cited)

**Files changed:** `recon/nfs4_types.h` (10 lines + one documenting comment) and
`recon/frontend/common/femenudefs.cpp` (receipt comment only — **no code change in the TU**).

**Law (gcc-2.8.1 `sched.c` `true_dependence()`, lines 846–875).** A read/store MEM pair
is declared **non-conflicting** only when

```
MEM_IN_STRUCT_P(store) && rtx_addr_varies_p(store) && GET_MODE(store) != QImode
  && GET_CODE(XEXP(store,0)) != AND
  && !MEM_IN_STRUCT_P(read) && !rtx_addr_varies_p(read)
```
(or the symmetric clause with the roles swapped).

Ten inline ctors in `nfs4_types.h` wrote the manual vtable pointer as
`*(void **)&_vf = (void *)&X_vtable;`. That is an `INDIRECT_REF` through a cast, so
**`MEM_IN_STRUCT_P` is CLEAR on the store** → the suppression clause cannot fire → every
following `lui vN; lw aN,%lo(global)(vN)` **argument load of the next member ctor is pinned
below the previous member's vptr store**. Retail hoists those loads above the store.

**Fix:** spell the store as the plain member assignment
`_vf = (__typeof__(_vf))&X_vtable;` — a `COMPONENT_REF`, so `MEM_IN_STRUCT_P` is set and the
scheduler reproduces retail's order. Semantically identical (the same address is stored);
the cast was a reconstruction artifact.

**Staged measurement** (each a separate gate run):

| edit | gate |
|---|---|
| baseline | 1238 |
| 1 site (`tBlankMenuItemGoToMenuNFS4Button`) | 1190 |
| all 9 `*(void **)&_vf` sites | 1148 |
| + the 10th (`_base_tInsideBoxLeftRightSlider._vf`) | **1138** |

**Blast radius fully gated.** Members of these 10 classes are declared in exactly one
container (`tGlobalMenuDefs`), and the class names appear in exactly six recon TUs. All six
gate clean *after* the change:

```
femenudefs.cpp        65/66 PASS   (target 1238 -> 1138)
femenuoptions.cpp     92/92 PASS
femenuextended.cpp    57/57 PASS
screencarselect.cpp   59/59 PASS
fememcard.cpp         18/18 PASS
vtables_tmenu.cpp      0/0  PASS
vtables_tpausemenu.cpp 0/0  PASS
```
`python tools/build.py --skip-asm` → rc 0 (gotcha #0 satisfied). CRLF/LF preserved
(`nfs4_types.h` 5995 CRLF / 286 LF before and after; femenudefs.cpp LF-only).

**REUSABLE, tree-wide:** ~90 more `*(void **)&…->_vf = (void *)&X_vtable;` sites exist
across `recon/**/*.cpp`. Each is a candidate wherever a near-miss shows an argument/global
load ordered *after* a vptr store. They were **not** converted here because they sit inside
already-PASSing functions and each needs its own gate.

---

## 2. MECHANISM CORRECTION — the 640-insn t0/t1 phase is **NOT** a reload scratch pick

W74-A6 item 1 diagnosed the dominant residual (≈770 of the 1138 units) as
`reload1.c:5031 allocate_reload_reg` round-robin. **That is wrong.** The chain, measured
end-to-end on the real CC1PLPSX RTL dumps:

**NEW CITED LAW — gcc's CSE 1000-insn hash-table flush kludge, `cse.c:8626-8644`
(`cse_basic_block`):**
```c
      /* If we have processed 1,000 insns, flush the hash table to avoid
         extreme quadratic behavior.  ??? This is a real kludge ... */
      if (num_insns++ > 1000)
        { for every table elt: REG -> invalidate(), else remove_from_table();
          num_insns = 0; }
```
`num_insns` is **per basic block** (`cse.c:8590`) and the loop increments it for **every
rtx in the chain — insns AND notes**. This ctor is ONE basic block
(`;; Processing block from 2 to 0, 3610 sets.`), so cse's constant table is wiped every
1001 chain objects.

**Corroboration (measured on the `-dj` dump = cse's input):** the function contains exactly
**four** surviving `(set (reg) (const_int -1))` defs, at chain ordinals **131 / 986 / 2019 /
3008** — one per 1001-object run. Every other `-1` in the function is cse-forwarded to its
run's first one and its def is deleted.

**The consequence chain for our residual:**
1. Pre-cse the `itemGoToDuelBuyCar` `-1` is a **fresh short pseudo**
   (`(insn 2573 (set (reg 703) (const_int -1)))`, used one insn later at 2575).
2. cse rewrites 2575's source to **reg 570** (defined at ordinal 986, ~320 objects back,
   same flush run) and deletes 2573.
3. `.lreg`: `Register 570 used 2 times across 100 insns … crosses 5 calls`. It can take
   neither a caller-saved reg (it crosses calls) nor a callee-saved one
   (priority `floor_log2(2)*2/100`), so it gets **no hard register**.
4. reload rematerializes it into a **spill** register. **This function's spill pool is
   exactly `{$t0,$t1}`** — a census of the `.greg` dump finds **443 reload-created register
   sets: 228 `$t0` + 215 `$t1`, nothing else.** Round-robin hands the `-1` `$t0`, the
   following `10` gets `$t1`.
5. From insn 1227 the whole t0/t1 quantity phase is inverted for ~382 instructions.
6. **Retail's `-1` is in `$v0`** — a register that cannot be in any spill pool here — so
   retail's pseudo was *allocated*, i.e. *short*, i.e. **retail's cse flush boundary fell
   between the previous `-1` def and this site.**

⇒ The dial is the **RTL-object count of everything before this point**, not any allocator
device. Requirement derived from the ordinals: a flush boundary must land in the open window
between chain ordinal ~1011 and ~1307 — i.e. ±35…±680 RTL objects away from where ours
falls. Not reachable from source (see §3), and **not a build.py rewrite question either**
(a text move cannot rename 382 registers).

---

## 3. FALSIFIED THIS WAVE (all gate-measured — do NOT retry)

1. **Reload-pool cursor rotation via a far-away zero-insn hard-reg clobber**
   (catalog 22D#2 / A20's ±1 law). `__asm__("" : : "i"(0) : "$N")` at the ctor body tail:
   * `$v1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9` → **all gate-INERT (1238)** — those registers are
     not in the pool at all;
   * `$s1,$s2,$s3,$s4,$s5,$s6,$s7` → 3046…3419 (catastrophic).
   The pool has **two** members and both are already `reload_reg_used_at_all`, so no
   rotation can ever produce retail's `$v0`. (W72 already falsified `$8`/`$9`.)
2. **cse-boundary shifting by a head pad.** `__asm__("" : : "i"(0))` × K in the first
   mem-initializer: K=1,2,3 → 1254; K=4 → 1253; K=6..12 → 2675; K=16..320 → 1982…4224
   (each asm is a sched1 barrier, so large K measures barriers, not boundaries).
   **Non-barrier variant** (K dead stores to one local — 1 cse object each, 0 machine insns,
   cse never deletes a dead set): K=1 → **1238 and byte-identical** (validity check passes),
   K=2 → 2659, K=4..1000 → 2650…4469. The baseline sits in a good local optimum; the
   boundary is not reachable by padding.
3. **PER-TU COMPILER FLAGS — axis now CLOSED, the control (`-O2 -G0`) is optimal:**
   `-g1` 1256 · `-g`/`-g2` 2075 · `-mno-split-addresses` 3672 · `-fno-schedule-insns` 4883 ·
   `-fno-schedule-insns2` 4133 · `-fno-delayed-branch` 1875 · `-fno-strength-reduce` INERT.
   ⚠️ **`-g1`/`-g` DO change codegen on the real CC1PLPSX** (3155 → 3155 insns/150 diff units
   and 3160 insns/1041 units vs the no-debug build) — retail's debug-note count *is* a real
   RTL-object dial, exactly as the cse law predicts; it just moves this function the wrong way.
   Harness: `scratchpad/w75/A1_dbg.py` (injects a flag into the REAL `compile_cpp` and strips
   the COFF debug directives, **without touching `tools/`**).
4. **Slider-block (insn 2500-2700) dials.** Third `"m"(FEApp)` fence per site 1138
   (saturated/inert); an added / leading / only / doubled `"m"(frontEnd)` fence
   2648 / 2648 / 1614 / 1470; a **non-barrier identity launder** on the FEApp pointer 1698;
   the launder on top of the two m-fences 1270. The first-two-argument literal **spelling** is
   completely inert (`'\0','\x7f'` vs `0,127` vs `(char)` casts vs hex — all 1138).
5. **The READ side of the alias dial.** Rewriting the ten `screenMain[0]` and eight
   `screenCarSelect[0]` argument reads as `*screenMain` / `*screenCarSelect`
   (`INDIRECT_REF` instead of `ARRAY_REF`, which should clear `MEM_IN_STRUCT_P`) is
   **inert (1138)** at every site and in combination.

---

## 4. THE NAMED `[reload_pick]` INSTRUMENT ASK — answered NEGATIVELY, twice over

**(a) Lab fidelity is ZERO for this function.** The instrumented FSF cc1plus
(`C:\Temp\nfs4-instr-cc1\cc1plus-ecoff.exe`, `-O2 -G0 -fno-exceptions -fno-rtti`, fed the
**real pipeline `.i`**) emits **2957 insns vs CC1PLPSX's 3155**, **3490 LCS diff units**, and
the **common prefix is ZERO instructions** — the very first insn differs
(`subu $sp,$sp,600` vs `subu $sp,$sp,640`; the FSF lane spills 10 fewer slots). No trace from
that lane is a receipt in this basin. *(Reaching an ICE-free compile at all needs two `.i`
edits: drop the brace-elided `gCarActivation[6][5]` initialiser and cast the two
`command.type = cmdType` int→enum assignments. Both ICE FSF 2.8.1 cc1plus; PsyQ's does not.)*

**(b) Even a perfect lab would answer the wrong question.** Our `$t0` **is** the correct
round-robin answer from a 2-member pool; retail's `$v0` is not a pool member at all, so the
divergence is upstream of `allocate_reload_reg` entirely (see §2).

---

## 5. RE-PRICED IN THE NEW BASIN (catalog 04Z basin-relativity)

Every W72/W74 device still in the source was re-measured **after** the alias-dial landing and
all remain optimal:

| device | new-basin gate |
|---|---|
| landed baseline | **1138** |
| remove the `menuPostCarGarage` read-only fence | 1239 (+101) |
| one `"m"(FEApp)` fence per site instead of two | 1142 (+4) |
| three per site | 1138 (saturated) |
| read-only fence on the duel `-1` | 1663 |
| identity launder on the duel `-1` | 1152 |

---

## 6. BUILD.PY / POLICY

**No `build.py` rows added, removed or edited.** The uncommitted foreign edit is intact
(`git status` still shows ` M tools/build.py`, untouched by this belt). No
`PER_FN_TEXT_MOVES` / `RA_SINK` / `SLOT_UNFILL`-class ask arises from this belt — the
remaining residual is a register-renaming phase, which a post-recompile text rewrite cannot
express. Nothing committed, nothing staged.

## 7. TOOLS (untracked, `scratchpad/w75/`)

* `A1_probe.py` + `A1_variants.py` — variant harness; always restores from `A1_base.cpp`.
  Reports gate / insns / raw / reg-blind / reg+spill-blind per variant.
* `A1_dbg.py` — runs the real `compile_cpp` with an extra cc1plus flag injected (global
  `subprocess.run` interception) and strips COFF debug; never touches `tools/`.
* `A1_receipt.py` — writes the in-source receipt.
* `rtl_base/` — protected copies of the `-dj -ds -dl -dg -dR -dS` dumps of the landed TU.
  ⚠️ `tools/rtl_dump.py` writes a FIXED path — copy before re-dumping.
* `lab/` — the FSF-cc1plus fidelity experiment (`fsf.s`, patched `femenudefs.i`, `-g*` runs).
* `A1_types_base.h`, `A1_base.cpp` — pre-edit snapshots.

## 8. NEXT (named, in value order)

1. **The cse-flush boundary is the whole remaining prize (~770 of 1138).** It is a
   *whole-function RTL-object-count* identity, not a local lever. The one axis that provably
   moves it and that we have not matched is retail's **debug-note count** (`-g*` changes
   codegen but in the wrong direction here) — a PsyQ-driver-level `-g` variant, or any change
   that shifts our chain length by −35…−680 objects before ordinal ~1011, would land it.
2. **Tree-wide vptr-store alias dial** (§1, ~90 sites) — hand every near-miss belt the
   `_vf = (__typeof__(_vf))&X_vtable;` respelling as a first-line check.
3. The slider block (insn 2500-2700, ~40 of the 200 reg-blind units) still needs a
   **non-barrier ref dial** for the `%hi(FEApp)`-in-`$s0` hoist; both non-barrier forms tried
   here (identity launder, `frontEnd` m-fence) are falsified.
