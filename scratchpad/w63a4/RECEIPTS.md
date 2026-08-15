# W63-A4 — LIBMCRD belt (+ 2mbyte/stup0) — receipts

Repo HEAD at start: `10e1a01b`. All numbers below were RE-GATED by me
(`python tools/verify_asm.py` / `tools/tugate.py`), never taken from the board.
Vendor syslib ⇒ gate-parity only (no psyqproof runs).

## 0. BASELINE (re-gated first, per the brief)

| fn | board row | RE-GATED baseline | verdict |
|---|---|---|---|
| MemCardExist_cb | 98.10 | **FAIL 4** (117/117) | real |
| MemCardGetDirentry | 93.87 | **FAIL 36** (150/152) | real |
| MemCardCreateFile | 87.40 | **FAIL 30** (134/130) | real |
| MemCardDeleteFile | 89.61 | **FAIL 23** (114/111) | real |
| MemCardWriteData_cb | 99.94 | **PASS (79 insns)** | **STALE ROW — already sealed** |
| 2mbyte.c stup0 | 42.86 | **PASS (7 insns)** | **STALE ROW — genuinely PASS** |

Whole-TU baseline: `recon/syslib/psx/libmcrd/LIBMCRD.c: 22/26 PASS`.

`stup0` is NOT the W61 "stale-PASS once" artifact: the W52 verify_asm
alabel-data `.word`→`dword` symmetry fix (see catalog W52 GATE/PROCESS row, which
names stup0 42.86%→PASS explicitly) is what sealed it; it re-gates PASS on a fresh
build today. No sotn/silent-hill twin hunt was needed.

## 1. SEALED — MemCardExist_cb 4 → PASS 117/117 (spec, not a source edit)

Deliverable: `scratchpad/w63a4/text_moves_spec.json` (orchestrator-owned wiring;
build.py NOT touched). Probe file used: `scratchpad/w63a4/tm_exist.json`.

**Why W62-A8's row was inert (root cause, not a guess):** its anchors were written
with ABI register NAMES (`addu\s+\$a0,\$v0,\$zero`, `li\s+\$v0,1`). cc1 emits
NUMERIC registers in the `.s` (`addu $4,$2,$0`, `li $2,0x00000001`), so BOTH the
site-1 row and the blind site-2 row matched nothing at all — the "INERT site-2"
observation was the whole table never firing. The `#APP` reading was a red herring;
the empty launder block emits no bytes and is only a textual neighbour.

**The residual, derived from the retail alignment (tools/sbs.py):** exactly TWO
sites, each ONE `li $v0,1` that retail emits one line EARLIER. Instruction multiset
and count already identical (117/117).

| | ours | retail |
|---|---|---|
| iodone tail (`return 1` const) | `addu a0,v0,zero` / `addiu v1,s0,-0xC` / **`li v0,1`** | `addu a0,v0,zero` / **`li v0,1`** / `addiu v1,s0,-0xC` |
| common tail (`1 << *pc` mask) | `addiu s0,s0,%lo` / `lw v1,0(s0)` / **`li v0,1`** | `addiu s0,s0,%lo` / **`li v0,1`** / `lw v1,0(s0)` |

Disambiguation (the fn carries FIVE `li $2,0x00000001` lines, one of them already
correct and in the SAME `#NO_APP` context): site-1 take is pinned by LOOKAHEAD on
its own tail (`j $L..; sw $4,4($3)`); site-2 take by lookahead on `lw $4,_mc_exrslt`;
the site-2 anchor `la $16,mc+12` occurs twice and is pinned by lookahead on the
following fence + `lw $3,0($16)`. All anchors label-agnostic (12F). Verified
offline: every `take`/`after` matches EXACTLY ONCE in the fn region.

**Probe proof (2×, plus control, plus whole-TU):**
```
W60_TEXT_MOVES_FILE=scratchpad/w63a4/tm_exist.json python tools/vprobe.py \
    recon/syslib/psx/libmcrd/LIBMCRD.c MemCardExist_cb
run1: PASS (117 insns)      run2: PASS (117 insns)
control (same session, no moves): FAIL 4 diffs (117/117)
```
Whole-TU in the MOVED build (all 26 `.ent` symbols gated through vprobe):
23 PASS; only GetDirentry 36 / CreateFile 30 / DeleteFile 23 remain, i.e. their own
pre-existing baselines — **0 PASS→FAIL**. (`tugate.py` has no env hook, so the
whole-TU check was run as a 26-name vprobe list.)

## 2. NEW NAMED ANGLE — the inlined-MemCardSync anchor class (worth ~15 in EACH of
   CreateFile and DeleteFile) is now HALF SOLVED: **retail's `mc` accesses in
   MemCardSync are VOLATILE.**

Device measured: in `MemCardSync`, `int *base` → `volatile int *base`, keeping the
existing opacity fence:
```c
volatile int *base = (volatile int *)&mc.cmd;
__asm__ __volatile__("" : "=r"(base) : "0"(base));
```
Whole-TU: Sync stays **PASS**, DeleteFile 23→25, CreateFile 30→32, GetDirentry
unchanged. **REVERTED** (gate got worse), but the STRUCTURE moved decisively:

* The TWO DEAD SNAPSHOT LOADS retail carries in both inlined copies
  (`lw $v0,0($s0)` / `lw $v0,4($s0)` with results unused) **appear at exactly
  retail's positions** for the first time. Nothing else in five waves has produced
  them — a plain read of an unused value is DCE'd; a volatile one is not. This is
  positive evidence for volatile, independent of the diff count.
* With the fence KEPT, the offsets stay REGISTER-BASED (`lw $v0,4($v1)`,
  `lw $v0,8($v1)`) = retail's shape. Without the fence (volatile alone) every access
  degrades to the 2-insn `lui;lw` macro (measured: Sync 0→3, Delete 28, Create 35) —
  so **volatile and the opacity fence are a PAIR**, neither half works alone.
* After the pair, the whole class reduces to ONE unsolved fact: our inlined body
  materialises its OWN anchor (`lui $v1; addiu $v1`, +2) and later re-materialises it
  for `done = 0` (+2), where retail reuses the CALLER's `$s0`. Everything else in the
  region — dead loads, spin-pointer form, store shapes — then lines up.
  Note the coupling that falls out for free once the anchor merges: retail
  materialises a FRESH `lui;addiu` for the spin pointer precisely BECAUSE `$s0` must
  survive for `sw $zero,8($s0)`; our rebase-in-place (`addiu $v1,$v1,8`) is the
  correct codegen for a base that is dead — same source, two contexts. So the
  anchor merge is expected to fix the spin-pointer diff too, not add one.

**Why the anchor cannot merge today (mechanism, re-confirmed):** cc1 2.7.2 folds a
LOAD through a known-constant pointer into the `lw $r,sym+off` macro, so the inlined
base must stay opaque (the fence) — and an opaque pseudo can never be cse-equated
with the caller's. The 12C same-source-line trick cannot help across the EBB
boundary (w61 receipt). The reachable route, unchanged: get the inlined anchor into
the loop PREHEADER so cse2-after-loop can merge it with the caller's; `scan_loop`
declines the asm because `maybe_never` is set. **Next experiment = a `-dL`/`-dS`
dump of MemCardDeleteFile, not another spelling sweep.**

## 3. FALSIFICATIONS THIS BASIN (04Z re-tests, all whole-TU gated)

| fn | device | result |
|---|---|---|
| MemCardSync | `volatile int *base`, NO fence | Sync 0→3, Delete 23→28, Create 30→35 |
| MemCardSync | `volatile int *base` + existing fence | Sync PASS, Delete 23→**25**, Create 30→**32** (structure right, count wrong) |
| MemCardGetDirentry | function-scope **fenced** anchor `int *b` for guard/stores/`b[3]` chan read (replacing the W62 block-local `pc`) | 36→**97** |
| MemCardGetDirentry | same, **unfenced** | 36→**91** |
| MemCardGetDirentry | `stored = 0;` moved to the last statement before the `ofs+max>0` guard (to let reorg steal it into the `blez` slot, which is where retail's `addu $s5,$0,$0` sits) | 36→**56** |

The two GetDirentry anchor rows re-confirm w53-a7/w59-a8 in the NEW (36) basin: the
band rotation cost is basin-independent here. The `stored` row is a new
falsification (it is NOT the w62 "moved inside the guard" row, which measured 42/68).

## 4. STILL OPEN (re-gated, unchanged from baseline)

* **MemCardGetDirentry 36** — decomposition confirmed against the oracle by
  side-by-side: (a) retail HOISTS the movstrsi end pointer out of the OUTER loop
  (`addiu $t0,$sp,80; sw $t0,0x60($sp)` in the outer preheader) and RELOADS it every
  iteration (`lw $t0,0x60($sp); nop`), which is also why retail's `files` parm spills
  to 0x5C($sp) and ours to 0x60($sp) — the extra spill slot is retail's, and 13A says
  slot order is declaration order, so this is a MISSING TEMP, not a coloring tie
  (~8 diffs incl. the 3-site 0x5C/0x60 cascade); (b) the `$t0/$t1` swap on the `max`
  reload + `li $v0,2` vs `li $t0,2` (~6, a consequence of (a)); (c) the chan
  READ/WRITE asymmetry — retail reads chan off the cse base (`lw $a0,0xC($s3)`) but
  WRITES it with the `$at` macro; ours needs a copy (`addu $v0,$s3,$zero`) for the
  read and writes base-relative. Mechanism now named: our writes go base-relative
  because gcc's OWN cse base is TRANSPARENT (`la $19,mc`), so cse rewrites
  `mc.chan = chan` to `$19+12`; DeleteFile gets retail's macro for free because its
  base is a SOURCE pointer that cse cannot prove equal to `&mc`. Any fix must make
  the base opaque WITHOUT paying the band rotation — the two rows in §3 show the
  naive form costs 55-61 diffs.
* **MemCardCreateFile 30 / MemCardDeleteFile 23** — 15 each is the §2 anchor class;
  the rest is receipted in-source (p[3] fold 2, `_mc_save_cb` schedule 8 on Create,
  tail scheduling).

## 5. CORPUS LEAD (mid-wave, orchestrator) — psyz libmcrd: **DEAD END, cite it once**

`C:\Temp\psyz` @ `6d47e5e`: `decomp/src/libmcrd/libmcrd.c` is **45 `INCLUDE_ASM`
lines and ZERO matched C** (`grep -vc 'INCLUDE_\|^#include\|^$'` = 0); `userfunc.c`
is 4 INCLUDE_ASM lines. Every function of my belt (`_card_exist_back`,
`MemCardGetDirentry`, `MemCardCreateFile`, `MemCardDeleteFile`, `_card_write_data`)
is unmatched there. Their `asm/` tree is splat-generated and NOT in the repo, so
there is not even a cross-version (PsyQ 4.0) oracle to diff without running their
splat. No source shape was portable. (This matches the W52 04V triangle note, which
already listed libmcrd as absent from psyz's matched set.)

## 6. HYGIENE

* `recon/syslib/psx/libmcrd/LIBMCRD.c` is byte-identical to HEAD (verified: absent
  from `git diff --stat`); backup at
  `scratchpad/w63a4/LIBMCRD.c.base_20260815.bak`.
* Whole-TU re-gated after every revert: 22/26 PASS with the four baseline rows.
* No `tools/*.py`, no `build.py`, no memory-dir writes. No commits.
* Hazards encountered: none new. (File is pure CRLF, 2098/2098 — scripted edits done
  with explicit `\r\n` anchors and byte-mode read/write.)
