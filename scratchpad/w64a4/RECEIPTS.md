# W64-A4 — LIBMCRD belt (vendor gate-parity) — receipts

Repo HEAD at start `fbc974f7`. Every number below was RE-GATED by me with
`tools/verify_asm.py` / `tools/tugate.py`. Syslib = Sony vendor ⇒ gate-parity only
(no psyqproof runs, per the brief).

## 0. BASELINE (re-gated first)

| fn | briefed | RE-GATED baseline | verdict |
|---|---|---|---|
| MemCardGetDirentry | 93.87 / 36 | **FAIL 36** (150/152) | real |
| MemCardCreateFile  | 87.40 / 30 | **FAIL 30** (134/130) | real |
| MemCardDeleteFile  | 89.61 / 23 | **FAIL 23** (114/111) | real |
| MemCardWriteData_cb| 99.94      | **PASS (79 insns)**   | **STALE ROW** (already sealed) |
| 2mbyte.c stup0     | 42.86      | **PASS (7 insns)**    | **STALE ROW** (W52 verify_asm alabel `.word`→`dword` fix) |

Whole-TU baseline `LIBMCRD.c: 23/26 PASS` (w63-a4's Exist_cb TEXT_MOVES row is wired and
holds: MemCardExist_cb PASS 117/117).

## 1. LANDED — the inlined-MemCardSync anchor class SOLVED (the belt's headline)

| fn | before | after | count |
|---|---|---|---|
| MemCardCreateFile | 30 | **12** | 130/130 **EXACT** |
| MemCardDeleteFile | 23 | **5**  | 110/111 |
| MemCardSync | PASS | **PASS** | 71/71 |

−36 diffs, **0 PASS→FAIL**. TU 23/26 (gated 2×, plus BIOS 17/17 and USERFUNC 4/4 unchanged;
`tu_order_audit` 0 inversions; `nm` shows no new/phantom symbols — `MemCardSyncAt` is
`static __inline__` and is fully inlined away).

### The mechanism (gcc-cited, from the `-dL` dump the brief asked for — not a spelling sweep)

Five waves treated this as "the inlined anchor cannot merge with the caller's". The `-dL`
dump of `MemCardDeleteFile` shows the inlined `int *base = &mc.cmd;` **never enters loop.c's
movable list at all** — with *or* without the opacity fence (the movable list is
byte-identical either way: `Insn 120 regno 88 savings 2 moved` + `Insn 275 regno 119 done
move-insn matches 120`, nothing else). So:

* **w63-a4's "scan_loop declines the volatile asm because `maybe_never` is set" is REFUTED.**
* Without a fence, cse folds every access through the known-constant pointer into the
  `lw/sw $r,sym+off` assembler macro ⇒ there is no pseudo to hoist.
* With the fence there *is* a pseudo, but it is opaque ⇒ `rtx_equal_for_loop_p` can never
  match it against the caller's anchor, so `combine_movables` (loop.c:1342 — the `m->match`
  merge that *does* fire for the two `li 2` movables in the very same loop) cannot merge them.

A pincer: **no source spelling of a function-local anchor can reach retail's shared register.**

**THE CURE — the anchor is a PARAMETER.** `static __inline__ long MemCardSyncAt(long mode,
int *cmds, int *result, int *base)`; the callers pass their own `p`. The inliner then
substitutes the caller's pointer pseudo and retail's single shared `$s0` (caller field stores
*and* the whole inlined sync body) falls out with **no dial at all**.

### Coupled follow-ups (both predicted by w63-a4's own receipt)

1. **`done` store through the shared base** (`base[2] = 0;` instead of a fresh re-anchor) keeps
   `base` live past the spin loop — which is precisely why retail materialises a *fresh*
   `lui;addiu` spin pointer instead of rebasing in place. Delete 15→6, Create 22→13.
2. **plain `return 1`** in the helper (the callers discard the result, so the cross-jump
   launder's `li $v0,1` is pure excess there). 13/6 → 12/5.

### Why the standalone MemCardSync keeps its OWN body

The two instantiations need **opposite** spellings of the spin-pointer / done-store pair. Full
2×2 matrix (all whole-TU gated), which is itself the evidence for the split:

| spelling | Sync | Create | Delete |
|---|---|---|---|
| pdone=`&base[2]`, store=fresh re-anchor | **PASS** | 22 | 15 |
| pdone=`&mc.done`, store=`base[2]=0`     | 9 | **13** | **6** |
| pdone=`&base[2]`, store=`base[2]=0`     | 8 | 17 | 10 |
| pdone=`&mc.done`, store=fresh re-anchor | 3 | 18 | 11 |

No cell serves all three ⇒ helper takes row 2, standalone keeps row 1.
`MemCardGetDirentry / MemCardFormat / MemCardUnformat` still call the standalone and are
unchanged (36 / PASS / PASS, re-gated).

### FALSIFIED in this basin (04Z re-probes, whole-TU gated)

| device | result (Create / Delete) |
|---|---|
| volatile snapshot reads (to keep retail's 2 dead `lw 0/4($s0)`) | 14 / 7 |
| read-only fence on `cmd`,`rslt` | 18 / 11 |
| read-only fence on `cmd` only | 16 / 9 |
| block-local fenced `pc` for the `p[3]` chan read (the GetDirentry device) | 12 / **29** — re-confirms w62-a8's per-function verdict in the NEW basin |
| named `oflag = 1;` before/after `_mc_present` (to move retail's early `li $a1,1`) | inert 12/5; **fenced** 22/5 |
| dropping MemCardSync's base fence entirely (old receipt said 42) | Sync 3, Create 35, Delete 28 |

### Residual, all named, no floors

* **Delete 5** = the `p[3]` load-fold (2: cse folds a *load* at a non-zero offset through a
  known-constant pointer into the macro; *stores* don't fold) + retail's two dead snapshot
  loads (2).
* **Create 12** = the same 4 + the `li $a1,1` open()-arg position (2) + the
  `p[0]`-load-hoisted-above-the-`_mc_save_cb`-store schedule that CreateFile's *opaque* base
  costs (DeleteFile's plain base is free of it).

## 2. MemCardGetDirentry 36 — classes (a)+(b) FULLY DIAGNOSED AND REACHABLE, blocked by ONE lane property

The brief's classes (a) (hoisted+spilled movstrsi end pointer, ~8) and (b) (the `$t0/$t1`
swap, ~6) are **one defect with a gcc-cited cause and a measured cure**. Not landed — see §2.3.

**2.1 The razor** (cc1-2.7.2 `-dL`, this fn):

```
Loop from 100 to 343: 67 real insns.
Insn 371: regno 97 (life 58) move-insn savings 1 halved since already moved  moved to 373
Insn 312: regno 120 (life 5),            savings 1  not desirable      <-- &ent+32, the end ptr
```

loop.c:1640 moves iff `threshold*savings*lifetime >= insn_count`. threshold solves to **27**
(`(loop_has_call?1:2)*(1+n_non_fixed_regs)`, decaying 3 per move → 24 here) and `insn_count`
is **stateful across the movable list** (loop.c:1618-24 `insn_count *= 2` when
`moved_once[regno]`). regno 97 (the `mc` cse base) was **already hoisted out of the inner
`while (1)` retry loop**, so its outer-loop movable doubles insn_count 67 → 134 and the end
pointer prices `24*1*5 = 120 < 134` → declined. (Solved from the four printed lines: threshold
27 is the unique value consistent with both loops' verdicts.)

**2.2 The cure, MEASURED.** Write the retry loop as a **LABEL+goto loop**. No
`NOTE_INSN_LOOP_BEG` ⇒ loop.c never passes over it ⇒ `moved_once[97]` stays 0 ⇒ insn_count
stays 67 ⇒ `120 >= 67` ⇒ the end pointer **is** hoisted into the outer preheader and reload
spills it, exactly like retail:

```
+addiu $t0,$sp,80  +sw $t0,<slot>($sp)     in the preheader
+lw   $t0,<slot>($sp)  +nop                in the copy loop
```

and class (b) evaporates with it (the whole `$t1`→`$t0` swap on the `max` reload).
**sp-displacement-blind diff 22 → 19.**

**2.3 Why it is NOT landed — the lane certificate.** Our reload spill slots are **8-aligned and
8-wide**; retail's are **4/4**. Proven, not assumed: a probe local declared after `err` takes
`92($sp)` (so expand-time locals *are* 4-aligned and 92 *is* reachable) while `files` still
lands at 96 and the new end-pointer slot at 104. The second spill therefore costs **+8 of
frame** (144→152), shifting all 24 saved-reg/local displacements: gate 36 → 85 despite the
better structure. Per HARD RULE 9 the branch was **unwound cleanly** (`LIBMCRD.c` byte-verified
against HEAD before the §1 work began).

*This same property is the long-standing 1-diff `sw $a3,96($sp)` vs retail `92($sp)`.*

**2.4 Ladder (04U), both source variants:**

| rung | baseline source | goto-loop source |
|---|---|---|
| 2.6.3 | 50 | 95 |
| 2.7.2-970404 | 134 | 134 |
| **2.7.2 (wired)** | **36** | 85 |
| 2.8.0 | 174 | 167 |
| 2.8.1 | 174 | 167 |

**2.8.0/2.8.1 pack spill slots 4-aligned and reproduce retail's exact slot map** (88/92/96,
frame **144**) but cost ~130 elsewhere; 2.6.3 and both 2.7.2 rungs 8-align. ⇒ **NEXT STEP:** a
4-aligned-spill mechanism (or a per-fn rung/flag that packs like retail) turns the goto-loop
lever from −49 into roughly −17 in one step. Do **not** re-derive the LICM razor; it is settled.

**2.5 Also falsified here (my probes):** the `stored = 0` / init-order rows were not re-run
(w63-a4 covers them); the two GetDirentry anchor rows stand.

## 3. CORPUS — the coordinator's mid-wave sweep: mgs MISSES, but **PE2 is a HIT**

* **mgs_reversing: NO PsyQ SDK source.** `source/memcard/memcard.c` is Konami's own game-level
  card manager (`MEM_CARD gMemCards[2]`, 8 KB blocks) calling `firstfile/nextfile/_card_read`
  as externs; `source/lib{dg,fs,gcl,gv,hzd,sio}` are KCEJ libraries, not renamed PsyQ. Nothing
  in the repo mentions `MemCardGetDirentry` / `_card_write_data`. **Coordinator's correction
  confirmed independently.**
* **TOMB5 `EMULATOR/LIBMCRD.C`** is a hand-written PC shim (`UNIMPLEMENTED()` stubs for
  Create/Delete/Format) — no value. KAIN2 `MCARDX.C`, VandalHearts/vh `card.c`, tenchu = all
  game-level.
* 🏆 **CORRECTION TO THE CORPUS-MISS VERDICT — a real matched twin exists:**
  `C:\Temp\ps1-decomp-refs\parasite-eve-2-decomp\lib\libmcrd\{libmcrd,bios,low,init,userfunc}.o`
  are **genuine prebuilt PsyQ libmcrd objects, ELF, NOT STRIPPED, with symbols** — 17 named
  `MemCard*` text symbols. This is a **second independent Sony build of the same source**, i.e.
  a byte-level oracle the name-grep sweeps kept missing (the miss verdict was "no *source*",
  which is true; the *object* is there).
  PE2's `MemCardGetDirentry` (0x11a8, **151 insns** vs our oracle's 152) carries retail's shape
  verbatim — `sw $a3,92($sp)`; `move $s2,$zero` *before* `move $s1,$zero`; `lw $t0,164($sp)`;
  `move $s5,$zero` in the `blez` delay slot; **`addiu $t0,$sp,80` + `sw $t0,96($sp)` in the
  preheader and `lw $t0,96($sp); nop` in the copy loop**; identical epilogue. Two independent
  Sony builds agree ⇒ §2's hoist+spill is **structural, not noise**, and §2.3's frame map is
  retail's true layout. (Its only extra insn is `move $s3,$s0`, the base copy NFS4's build
  merges away.) `MemCardCreateFile` there is 63 insns — that PsyQ version does **not** inline
  MemCardSync, which is why §1's split is the right model for NFS4.
  **Recommend adding PE2's `lib/libmcrd/*.o` to the corpus index as a byte oracle** (and
  sweeping the other repos for prebuilt `lib*/*.o` generally — the corpus greps have only ever
  looked for `.c`).

## 4. HYGIENE

* Files touched: `recon/syslib/psx/libmcrd/LIBMCRD.c` only. No `tools/*.py`, no `build.py`, no
  memory-dir writes, no user-live TUs.
* Backups: `scratchpad/w64a4/LIBMCRD.c.base_20260815.bak` (HEAD), `.goto1` (the unwound
  GetDirentry branch, kept for the next agent), `.syncat`, `.split_ok`, `.step3`.
* File is pure CRLF throughout (2267/2267), zero control bytes — checked after every scripted
  edit; all byte-mode read/write with explicit `\r\n` anchors.
* Helpers written this run: `scratchpad/w64a4/w64a4_blind.py` (sp-displacement-blind structural
  diff — the honest metric when a frame-size change makes the LCS non-monotone; promote-worthy),
  `probe_ab.py` / `probe2.py` / `probe3.py` / `probe4.py` (matrix probes, restore-safe).
* Gated 2×: LIBMCRD 23/26 both runs; BIOS 17/17; USERFUNC 4/4; stup0 PASS; tu_order_audit 0.
