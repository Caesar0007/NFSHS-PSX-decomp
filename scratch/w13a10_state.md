# w13-a10 worker state (hud.cpp only; memory dir is READ-ONLY for me)

Baseline (start): 5835 total diffs, 36 PASS (+2 NOT IN OBJECT pre-existing: Hud_BTCStats__Fsb, Hud_RenderStatsView__Fv).
Gate: python tools/verify_asm.py recon/game/psx/hud.cpp <MANGLED>; uncapped: python scratch/va_full.py ...; side-by-side: python tools/side_by_side.py ...

## Done
- Hud_BuildRadar__Fi 712 -> 46 (commit 45e93e5). Techniques: SYM-shape (car=BO_tNewtonObj*, named m00/m01/m10/m11 = orientMat.m[0]/[6]/[2]/[8]>>8, mapx=22/mapz=24 named consts, guards -mapx<x && x<mapx), index-form loops (walkers = givs), plain for for transform/scale loops (rotated), while(true){if(n<=i)break;...i++} for draw loops (top-test+j), block-local SPRT *sprt + u_char *pal per draw block, cop-loop addPrim = pkt-link; tag=*(u_int*)pal; bump(sprt+0x14); pal-store(tag-split); race-loop = pkt-link; pal-link; bump; explicit `& 0xffff` masks NOT (u_short) casts (cast => lhu narrowing!); color select = if((gFlip==0)&&(qp==0)) c=0xff0000; else c=0xff; (funnel in v0 + gp store + reload); scr[i + Cars_gNumRaceCars] operand order (i first); race draw = duplicated Hud_BuildSprite calls in if/else arms (gcc tail-merges); marker color *(u_long*)&Hud_gMarkerColor[i] both arms.
  Residual 46 = prologue s6-pair scheduling seam + cop-loop a2/a1/a0 reg-shift + gFlip-load-above-pal-store scheduling (load-vs-store alias hoist we can't reproduce; tried init orders B-E, decl orders P1-P5, color shapes OR/TER/TER2 - all >= 46).

## Order of remaining targets (w12-a6 handoff)
2. Hud_RenderHudView 523 (viewOff/tpageOff -> index-form rewrite)
3. Hud_BuildMapMarkers 491
4. Hud_BuildCdPlayer 402
5. Hud_BuildTach 364 (note: bare-VA tachNeedle_p = -0x7feee92c at ~line 1132 = 0x801116D4 -> day_needle/night_needle? fix w/ symbol)
6. Hud_BuildReplay 286
7. Hud_BuildWingmanInterface 220
8. Hud_RenderMapView 129 - KEEP explicit walkers (index-form REGRESSES); fix disguised bare-VA `current_tile_idx + -0x7fec1c04` = &gTPage1[j][1] with real symbol ref
9. Draw321Num(116, param-spill floor class)/BustedOverlayOn(114)/CreateHudViews(96)/RenderTacView(83) tail
KEEP/banked: BuildNumbers0@230, BuildNumbers@705, Hud_Init@640, retail carInfo read, HudF4/HudG4 refs.
SYM regs: python -c "import sys;sys.path.insert(0,r'C:\Temp\claud');import sym_v3; print(sym_v3.all_locals('0x<va>'))" (run from C:\Temp\claud). Raw SYM block w/ $regnums: grep '\$<va> 8c' in C:\Temp\claud\dumpsym_clean\dumpsym_src\nfs4-f-v3.txt.
m2c: C:\Temp\nfs4-split\m2c\main\<Mangled>_<VA>.c
Commit incrementally, NO push/merge. Full-TU sweep after each landing (36 PASS must stay).

## Session end state (w13-a10 final)
TU total: 5835 -> ~4100 (final sweep pending below), 36 PASS kept all session, 0 regressions.
Landed: BuildRadar 712->46 (45e93e5), RenderHudView 523->99 (54d658b), MapMarkers 491->161 (2c36b22),
RenderMapView 129->94 + bare-VA + HudMap real-bug fix (2794a78), BuildTach 364->219 + 2 bare-VAs (cbb1a25),
BuildReplay 286->177 (0150be3), Wingman 220->195 (6f9ad73), CdPlayer 402->401 (keepup static bool + y+2 only; NOT deeply reworked).
CdPlayer next steps for successor: SYM x=s7=gx+2, y=fp=gy+2, index=s4, time=s5, title=s1, artist=s0,
keepup= fn-local STAT BOOL (done), strtest[1]=0 byte-init early (oracle sb zero,153(sp)), the Ghidra
bVar2/li-1-bnez degenerate gate block needs the m2c PAD_state || chain shape; colors 0xBEBE vs 0x808080
differ per branch vs recon - verify per m2c. m2c: C:\Temp
fs4-split\m2c\main\Hud_BuildCdPlayer__Fii_800D63DC.c.
Residual classes elsewhere: BuildRadar 46 = prologue s6-pair sched + cop-loop a2/a1/a0 shift + gFlip-load-above-pal-store;
RenderHudView 99 = stack-slot permutation (source-var walkers get early-pseudo slots vs retail loop-opt giv slots) + 159/160 fold;
MapMarkers 161 = 0x1F800004-const hoist steals fp from mapy (LIM/priority; volatile+pktcell levers did NOT move it).
