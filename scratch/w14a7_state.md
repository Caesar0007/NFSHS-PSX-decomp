# w14-a7 worker state (hud.cpp only; memory dir is READ-ONLY for me)

Baseline (start): 4100 total diffs, 36 PASS. Gate: python tools/verify_asm.py recon/game/psx/hud.cpp <MANGLED>
End of session: 4132 total diffs, 36 PASS (0 regressions). Net diff count went UP by 32 on
Hud_BuildCdPlayer despite fixing 3 real bugs -- see below, this is expected/documented, not an error.

## Done: Hud_BuildCdPlayer 401->433 diffs (commit ca47813)
Predecessor (w13-a10) diagnosed the `bVar2`/degenerate-gate block as structurally wrong vs the m2c
PAD_state `||` chain, and left SYM reg-map notes in this file's prior revision. This session:

1. **Gate rewrite**: replaced the flattened `bVar2 || (...)` boolean with the oracle's actual nested
   if/goto shape (gPadinfo.buf[0] check falls through to buf[4] on failure; a BeTheCop!=0 && splitscreen==0
   combo ALSO falls through instead of short-circuiting). Verified this is semantically identical to the
   old flattened form (traced both by hand) -- but **codegen was IDENTICAL either way** (401 diffs before
   and after, byte-for-byte same diff). Conclusion: gcc -O2 canonicalizes short-circuit boolean exprs and
   equivalent nested-if/goto to the SAME CFG when there's no other structural difference. The "flattened
   bool vs goto" framing in the predecessor's diagnosis was NOT itself the lever -- something else was.
2. **3 real bugs found via raw cross-check** (asm/nonmatchings/main/Hud_BuildCdPlayer__Fii.s):
   - `Font_TextXY(strindex,x,y)` should be `Font_TextXY(strindex,x,y-2)` (oracle: `addiu a2,fp,-2`).
   - Second `Hud_BuildString(...,y+5,...)` should be `y+3` (oracle: `addiu a2,fp,3`).
   - Time-string `Font_TextXY(strtime,...,y+0xe)` should be `y+0xc` (oracle: `addiu a2,fp,0xc`).
3. **2 dead-store bugs removed**: `iVar3 = 0x12;` and `iVar3 = 0x1c;` were extra assignments into the
   y-register with NO oracle counterpart (oracle only ever writes the box-height literal to the STACK slot
   for the Hud_FBuildF4 arg, never to fp/y). Removing them dropped instruction count from 484->475
   (EXACT match to oracle's 475 -- was 9 too many before). Introduced `box_w/box_y/box_h` as fresh
   temps (not SYM-tracked; distinct role from x/y/dx/index) for the shared Hud_FBuildF4 tail-call funnel.
4. title/artist now built via genuine if/else (oracle 2-arm branch with `j`-skip), not
   assign-then-null-override; both char* throughout (SYM: title=$s1, artist=$s0), eliminating the
   u_char* s_00/s_01 duplicates. index=$s4, time=$s5, dx=$s3, tx=$a1, w=$v1, sec=$v0(new var, was
   inlined), s=$a2 (scroll-copy cursor) -- all SYM-verified via `sym_v3.all_locals('0x800D63DC')` and the
   raw `8c Function start` block (nfs4-f-v3.txt:207027).
5. **x/y fused directly**: SYM's `x`(REG $s7)/`y`(REG $fp) locals ALREADY hold `g1Player[0xf].x/y + 2`
   directly -- there is NO separate raw-x/-y SYM local, so `sVar1`(short raw-x)/`iVar13`/`iVar3` collapsed
   into 2 variables `x`/`y`.
6. Fixed a self-inflicted bug mid-session: after renaming `pAVar4`->`currentSong` for the `.remaining`/
   `.index`/`.info.title`/`.info.artist` reads, I left a stray unused `pAVar4` declaration and 5 call
   sites still reading through it (reading an UNINITIALIZED pointer) -- caught before commit via a
   diff-count sanity check (fixing it, correctly, made the diff count go 362->433; the buggy
   uninitialized-pointer version had coincidentally produced FEWER instruction-text diffs, which is not
   a legitimate basis to keep it. Correctness > diff-count when they conflict this directly).

**Residual (433 diffs) = a register-coloring CASCADE, not a structural issue.** Instruction count is
exact (474 ours / 475 oracle -- 1 short, see "return value" note below). SYM's 9 REG-class locals for
this fn (type,x,y,index,time,title,artist,dx,currentSong) pack ALL of s0-s7+fp on the oracle side with
ZERO spare registers (type=s6,x=s7,y=fp,index=s4,time=s5,title=s1,artist=s0,dx=s3,currentSong=s2 --
a perfect 1:1). Ours allocates the SAME 8 s-regs+fp (confirmed: both prologues save all of s0-s7) but
assigns DIFFERENT variables to DIFFERENT specific registers (type->s4 not s6, x->s6 not s7, y->s7 not fp,
currentSong->s1 not s2, dx->s2 not s3 -- a apparent uniform "-1/-2 slot" shift). Tried and DID NOT
converge: (a) reverting the x/y fusion back to a separate `short sVar1` raw-x holder (435, worse); (b)
3 different declaration orderings top-of-function (362/433/435 -- inline C++ declaration-at-point-of-use
made ZERO difference, confirming gcc-2.x's allocator works off RTL/statement EXECUTION order not lexical
declaration position). Whatever the real anchor is, it wasn't found this session. NEXT: try the
§3.12 "find the ABI-forced anchor" ladder properly -- diff the FULL function side-by-side
(`tools/side_by_side.py`) and look for the first `jal` whose arg-register the oracle's variable-of-choice
also occupies immediately after, per the CdPlayer/GameSetup_StartUp precedent lever #1's "second effect".
I did not have budget left to run that full ladder.

**Return-value note (NOT fixed, low priority)**: `Hud_FBuildF4`/`Hud_BuildF4o` are declared `void` in the
recon, but the raw shows `Hud_BuildCdPlayer`'s `jr ra` executes with ZERO instructions setting `$v0`
after the final `jal Hud_FBuildF4` -- meaning `$v0` at return is whatever `Hud_FBuildF4` (transitively
`Hud_BuildF4o`, whose own last op is ALSO a bare `jal` with no `$v0` write before ITS `jr ra`) left there.
Classic §3.2 Ghidra void-return-bug candidate, but chasing it means re-typing `Hud_FBuildF4`/`Hud_BuildF4o`
to `int` (they're called as bare statements from MANY other sites across the file, which stays legal in
C++ either way, but is a wider blast radius I did not want to take mid-session). Kept `return box_h;`
(preserves prior, at-least-plausible behavior) as a placeholder. This costs at most ~2-3 instructions of
the residual.

## Investigated, no changes made (time-budget exhausted before finishing)

- **Hud_BuildTach (219 diffs)**: predecessor's flagged bare-VA bug (`tachNeedle_p` disguised negative
  offsets) is ALREADY FIXED (see the comment at hud.cpp:1127-1128, `&HudPmx_gShapes[0x83]`/`[0x81]`).
  Manually transcribed the raw oracle's addPrim/palette-link block (asm/nonmatchings/main/Hud_BuildTach__Fi.s
  lines ~140-208, the `t3=&Render_gPacketPtr`/`t1=Render_gPalettePtr`-value 4-store sequence) against the
  current C -- **the C source ALREADY matches the oracle's logical store order exactly** (verified by hand,
  statement-by-statement). The diff there is pure instruction SCHEDULING, driven by the SAME kind of
  early register-coloring divergence as CdPlayer (the very first `tachShape_p` (day/night needle table
  pointer) lands in oracle's `a1` vs ours `a0`, cascading through `needle_x`/`needle_y` ending up in
  s4/s7 vs oracle's s7/s4, etc.). Root cause not isolated; no edit made (reverting would be a no-op, the
  file is unchanged from the w13-a10 handoff for this function).
- **Hud_CreateHudViews (96 diffs)**: ours allocates ONE EXTRA callee-saved register (`sw s3,52(sp)`,
  frame -64 vs oracle's -56) that oracle doesn't need. Source has just one local (`int i`, the carClass
  loop counter, no calls inside that loop so it shouldn't need a callee-saved slot at all -- and indeed
  oracle keeps it in `v1`/caller-saved). Suspect gcc is CSE-hoisting `HudMapOffsetY` (read repeatedly
  across 2+ `Draw_SetView` calls in the commMode==1 branch) into an extra callee-saved reg on our build
  but not oracle's; not confirmed, no edit made.

## Order of remaining targets (unchanged from w13-a10 handoff, none reached this session)
BuildTach (219, analyzed above) / BuildReplay (177) / MapMarkers (161) / WingmanInterface (195) /
RenderHudView residual (99) / RenderMapView (94) / BuildString (244 -- s4-vs-s2 param floor, CHECK FIRST,
not verified this session) / Draw321Num 116 (§3.15 floor -- SKIP per standing instruction) /
BustedOverlayOn 114 / CreateHudViews 96 (analyzed above) / TacView 83.

KEEP: 36 PASSes + BuildRadar@46 + all banked numbers from w13-a10 (BuildRadar 46 = prologue s6-pair
sched + cop-loop a2/a1/a0 shift + gFlip-load-above-pal-store; RenderHudView 99 = stack-slot permutation;
MapMarkers 161 = 0x1F800004-const hoist steals fp from mapy).

SYM regs: `python -c "import sys;sys.path.insert(0,r'C:\Temp\claud');import sym_v3; print(sym_v3.all_locals('0x<va>'))"`
(run from C:\Temp\claud). Raw SYM block w/ $regnums: `grep -n '\$<va> 8c' C:\Temp\claud\dumpsym_clean\dumpsym_src\nfs4-f-v3.txt`.
m2c: C:\Temp\nfs4-split\m2c\main\<Mangled>_<VA>.c. side_by_side tool: `python tools/side_by_side.py recon/game/psx/hud.cpp <MANGLED>`.
Commit incrementally, NO push/merge. Full-TU sweep after each landing (36 PASS must stay).

## Meta-lesson for the next worker
Register-coloring cascades in this file are now the DOMINANT residual class across every function
examined this session (CdPlayer, BuildTach, CreateHudViews all show the same signature: instruction
COUNT close/exact, but WHICH physical s-register holds WHICH SYM-named local differs, cascading from
one early divergence point). This is expensive to chase by hand (each attempt is a full recompile +
side-by-side re-read cycle) and the §3.12 lever catalog's cheap tricks (decl order, index-vs-pointer
form, x/y fusion) did NOT converge for CdPlayer despite 4 different tries. Recommend the next session
budget MORE time per function on isolating the exact ABI-forced anchor (the first `jal` argument that
pins a register) rather than trying multiple whole-function reshapes blind.
