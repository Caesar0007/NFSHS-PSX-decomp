/* game/psx/night.cpp -- RECONSTRUCTED (NFS4 PSX night-driving lighting/colour system; C++ TU)
 *   19 fns: colour-table build (FindClosestColor / CreateNightTable[Element] / GenerateAll),
 *   headlight + cop-strobe + weather colour setup, lightning effects (Generate/Pause/Do),
 *   Init/Kill/Restart night driving, SetEnviroment, AdditiveNightCalc. No GTE.
 */
#include "night_types.h"
#include "night_externs.h"

/* ---- Night.obj-OWNED globals -- DEFINED here (self-contained; SYM-typed via gen_owned_defs:
   .data = real NFS4.EXE bytes, .bss = zero; extern-vs-SYM disagreements resolved to SYM) ---- */
/* W67-A4: night.obj's retail .sdata run 0x8013d9e0..0x8013da28 is reproduced in
   DEFINITION ORDER (16E: initialised objects emit in .cpp definition order;
   everything before the -G8 literal pool @0x8013da00 is therefore initialised,
   everything after it stays tentative).  DO NOT RE-SORT, DO NOT strip the =0. */
char         Night_gDrawLightning = 0;   /* @0x8013d9e0 */
/* W67-A4: the 2-byte cell @0x8013d9e2 is 2-ALIGNED in retail; a u_char[2] def
   gets word-aligned by DATA_ALIGNMENT (+2B pad, breaks the whole run).  Define
   the STORAGE as a u_short under the asm label and keep BYTE-indexed refs via
   the sized array VIEW (established dual-model device, cf. WeatherLightingTable
   below; arrays are not gp-encoded by cc1plus, so the view keeps the oracle's
   absolute %hi/%lo form). */
u_short      Night_gCopCarTypeColorIdx_cell asm("Night_gCopCarTypeColorIdx") = 0;   /* @0x8013d9e2 */
extern u_char Night_gCopCarTypeColorIdx[2];   /* byte view of the cell */
char         Night_gCopCountryLightTbl[2][5][2] = { 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 1, 0, 1 };   /* @0x80120d18 */
int          Night_gLightningPauseAreas[16][2];   /* @0x80120d2c  (bss(zero)) */
CVECTOR      Night_gAdditiveHeadlightColor[16];   /* @0x80120dbc  (bss(zero)) */
u_char       (*Night_gPlayerLightingTable)[256][16] = 0;   /* @0x8013d9e4 */
u_char       (*Night_gCopLightingTableRed)[256][8] = 0;   /* @0x8013d9e8 */
u_char       (*Night_gCopLightingTableBlue)[256][8] = 0;   /* @0x8013d9ec */
/* Retail SYM records a real two-element pointer array.  night.obj's proven
   -G8 identity preserves both constant-index small-data accesses and runtime
   base walks without split element symbols or assembler-label views. */
u_char       (*Night_gWeatherLightingTable[2])[256] = { 0, 0 };   /* @0x8013d9f0 */
char         CopCarTypeLights[6] = { 0, 0, 1, 0, 1, 1 };   /* @0x8013d9f8 */
bool         gNight_renderNight;   /* @0x8013da28  (bss(zero)); SYM BOOL */
int          Night_gXDist;   /* @0x8013da2c  (bss(zero)) */
int          Night_gZNear;   /* @0x8013da30  (bss(zero)) */
int          Night_gZDist;   /* @0x8013da34  (bss(zero)) */
int          Night_gXDistShift;   /* @0x8013da38  (bss(zero)) */
int          Night_gZDistShift;   /* @0x8013da3c  (bss(zero)) */
char         *Night_gNightTbl;   /* @0x8013da40  (bss(zero)) */
int          Night_gLightningType;   /* @0x8013da44  (bss(zero)) */
u_char       (*Night_gCurrentNightColor)[256][16];   /* @0x8013da48  (bss(zero)) */
u_char       (*Night_gCopColor[2])[256][8];   /* @0x8013da4c */
CVECTOR      Night_gNightAmbientColor;   /* @0x8013da54  (bss(zero)) */
CVECTOR      Night_gColor[2];   /* @0x8013da58  (bss(zero)) */
int          Night_gTotalLights;   /* @0x8013da60  (bss(zero)) */
int          Night_gLightning;   /* @0x8013da64  (bss(zero)) */
int          Night_gNextLightning;   /* @0x8013da68  (bss(zero)) */
int          Night_gEndNextLightning;   /* @0x8013da6c  (bss(zero)) */
int          Night_gNextFlicker;   /* @0x8013da70  (bss(zero)) */
int          Night_gFlashAzimuth;   /* @0x8013da74  (bss(zero)) */
char         Night_gShowForks;   /* @0x8013da78  (bss(zero)) */
int          Night_gFlashIntensity;   /* @0x8013da7c  (bss(zero)) */
long         Night_gPlayerHeadLightColor[2];   /* @0x8013da80  (bss(zero)) */
long         Night_gWeatherColor[2];   /* @0x8013da88 */
tNightInitCache *gNightInitCache;   /* @0x8013da90  (bss(zero)) */
tCompRGB     *gTableCache;   /* @0x8013da94  (bss(zero)) */
char         *nightfile;   /* @0x8013da98  (bss(zero)) */


/* ---- Night_FindClosestColor__FG7CVECTORPi  [NIGHT.CPP:134-175] SLD-VERIFIED ----
 * SEALED 50/50 PASS (w38-a10; was an 82-diff far-miss at ours 52 / oracle 50).
 * FIVE stacked levers, all SYM/oracle-derived (SYM block @43bbac):
 *  (1) the search cursor is NOT a walking `tCompRGB *p` -- the oracle re-loads
 *      %gp_rel(gTableCache) INSIDE the loop and adds a *3 offset giv
 *      (`addiu t1,t1,3`), i.e. the source indexes the GLOBAL: gTableCache[search].
 *      (gcc must reload the pointer because the `*bestIndex` store may alias it.)
 *  (2) the zero-trip guard compares the VARIABLE, `if (search < maxLights)`
 *      (oracle `slt v0,a3,v1; beqz`), not the literal `1 < maxLights`
 *      (which folds to `slti v0,v1,2; bnez`).
 *  (3) diffSum is a term-by-term ACCUMULATION (3 statements), not one sum
 *      expression -- makes diffSum's own pseudo hold the running sum from the
 *      first product (oracle `mflo a0 ... addu a0,a0,a2 ... addu a0,a0,t9`);
 *      the single expression built the sum in a fresh temp (+1 insn).
 *  (4) `bestDiff = 0x2fa03;` is the FIRST statement -- its long live range
 *      LOWERS its allocno priority so it lands on $t0 and `search` wins $a3
 *      (SYM: bestDiff $8 = t0, search $7 = a3). Initialising it just before the
 *      guard inverted the pair (28 diffs, count already exact).
 *  (5) inside the if-body `bestDiff = diffSum;` precedes `*bestIndex = ...`.
 * `search` sits in its own nested SYM block (2nd `Block start line = 1`).
 * Prototype re-checked vs raw oracle: struct-by-value ARG colorMatch (spilled to
 * 0(sp) and re-read as 3 lbu), REGPARM $a1 bestIndex, INT return in $v0. */
int Night_FindClosestColor(CVECTOR colorMatch,int *bestIndex)

{
  int bestDiff;
  int diffR;
  int diffG;
  int diffB;
  int colorMatchr;
  int colorMatchg;
  int colorMatchb;
  int searchColorr;
  int searchColorg;
  int searchColorb;
  int diffSum;
  int maxLights;

  bestDiff = 0x2fa03;
  colorMatchr = colorMatch.r;
  colorMatchg = colorMatch.g;
  colorMatchb = colorMatch.b;
  {
  int search;

  search = 1;
  maxLights = Night_gTotalLights + 1;
  searchColorr = (u_char)gTableCache->r;
  searchColorg = (u_char)gTableCache->g;
  searchColorb = (u_char)gTableCache->b;
  if (search < maxLights) {
    do {
      diffR = colorMatchr - searchColorr;
      diffG = colorMatchg - searchColorg;
      diffB = colorMatchb - searchColorb;
      searchColorr = (u_char)gTableCache[search].r;
      searchColorg = (u_char)gTableCache[search].g;
      searchColorb = (u_char)gTableCache[search].b;
      diffSum = diffR * diffR;
      diffSum = diffSum + diffG * diffG;
      diffSum = diffSum + diffB * diffB;
      if (diffSum < bestDiff) {
        bestDiff = diffSum;
        *bestIndex = search + -1;
        if (diffSum < 0x40) {
          return diffSum;
        }
      }
      search = search + 1;
    } while (search < maxLights);
  }
  }
  return bestDiff;
}

/* ---- Night_CreateNightTableElement__FiliPUc  [NIGHT.CPP:181-231] SLD-VERIFIED ----
 * NEAR-MISS 56 diffs, COUNT-EXACT 113/113 (w40-a9; was 85 with 110/113).
 * Residual is a pure allocno swap against the SYM register map (sourceR $4/a0,
 * sourceG $5/a1, sourceB $3/v1, chr $3, chg $8/t0, chb $9/t1, b15 $7/a3, newR $6/a2,
 * newG $5/a1, newB $4/a0): ours puts b15 in $a1 and sourceG in $a3 (the SYM has them
 * the other way round) and swaps newG/newB between $a0 and $a1.  Priority estimate
 * says it is a razor edge -- b15 has 4 refs (floor_log2=2 -> weight 8) over ~40 insns,
 * sourceG 2 refs (weight 2) over ~8, so the b15-loses condition is len_b15 > 4*len_g,
 * i.e. right at the boundary.  FALSIFIED (all re-gate to 56 or worse): sources-before-
 * component-bytes (70), b15 computed after the bytes, b15 after the sources, fully
 * interleaved source/new pairs (84), b15 declared first, newG/newB decl swap,
 * sourceG/sourceB decl swap.  The prologue also copies $a3 into $s1 (colorval) after
 * $a0 into $s0 where retail does it first -- the same emission-order tie.
 * PROTOTYPE RE-CHECKED: 4 args (colorIndex REGPARM $10, colorH ARG stack, bright
 * REGPARM $6, colorval REGPARM $11), void return -- matches the SYM exactly.
 * w41-a7 -dg/-dl RECEIPT (dumped, not guessed -- CC1PLPSX takes -dg/-dl/-dL via a manual
 * cpp->cc1pl run; helper kept in the report).  Allocation is fully explained:
 *   pseudos 84=sourceR(block-local,$a0 via local-alloc) 85=sourceG 86=sourceB 87=chr
 *   88=chg 89=chb 90=b15 91=newR 92=newG 93=newB, i.e. FIRST-USE order, NOT decl order
 *   (swapping the b15/newR declarations is provably a no-op: re-dumped, identical).
 *   priority = floor_log2(refs)*refs/live_length gives the printed order
 *   93(4/12=.67) 92(4/15=.53) 90(4/24=.33) 91(4/24=.33) 85(2/7=.29) 88(2/7=.29)
 *   86(2/12) 89(2/12), and find_reg then yields ours exactly, including the
 *   `regs_someone_prefers` skip that pushes sourceG off $v1 (86 prefers $v1).
 *   RETAIL falls out of the SAME model from ONE changed fact: retail's newB does NOT
 *   conflict with hard $a0.  Then 93->$a0, 92->$a1, 91->$a2, 90(b15)->$a3, 85(sourceG)
 *   ->$a1 (shares with newG, disjoint ranges), 88->$t0, 86->$v1, 89->$t1 -- the SYM map
 *   byte for byte.  OUR hard-$a0 conflict comes from insn 180, the cse-created reload of
 *   the just-stored newColor.g byte (`lbu`->reload_cse->`andi $a0,$v0,255`), which
 *   local-alloc parks in $a0 and which stays live across newB's last use.  Retail puts
 *   that reload in $v0 because retail ALSO store-forwards the .b byte (`andi $v1,$v1,255`
 *   where we emit `lbu $v0,18(sp)`), which re-orders the whole by-value CVECTOR argument
 *   assembly.  That assembly is generated by gcc for the `Night_FindClosestColor(newColor,
 *   ...)` by-value struct arg -- there is no source handle on it, and the dependency is
 *   circular (the reload's register decides newB's conflict, newB's register decides the
 *   assembly's schedule).
 * FALSIFIED this wave (all re-gated, on top of the 7 earlier spellings): storing each
 * component right after its clamp (67, 114 insns), storing only .r early (60), ternary
 * self-clamp on newR to add a ref (74, 115 insns), in-place `newX = newX & ~7` on all
 * three (68) and on newR only (58), declaring newR before b15 (56, provable no-op),
 * per-component BLOCK SCOPES for newR/newG/newB (67 -- the w41 block-local-vs-global
 * scope lever does NOT fire here: all three are multi-block by construction because the
 * clamp branches, in both builds), and computing B/G/R in reverse order (74).
 * STRONG FLOOR under the current bar: prototype audited vs SYM, mechanism named and
 * quantified from the RTL dumps, -G8 already adopted for this TU. */
/* ===== w60-a6: THE W59-11D WHOLE-BLOCK SLD RE-LAY IS EXECUTED -- and it FALSIFIES the
 * "the shipped basin is anti-SLD papering" reading.  26 STAYS. =====
 * The suspicion was well-founded and worth executing: tools/sldall.py shows retail's pack
 * block is plainly NATURAL r,g,b --
 *     SLD:206  and v0,a2,v1 ; sb v0,16(sp)      <- newColor.r
 *     SLD:207  and v0,a1,v1 ; sb v0,17(sp)      <- newColor.g
 *     SLD:208  and v1,a0,v1 ; sb v1,18(sp)      <- newColor.b
 *     SLD:212  andi/sll/lbu/or ... jal          <- the by-value CVECTOR arg build
 * and retail FORWARDS the last two stored bytes (.g in $v0 via `andi v0,v0,255`, .b in $v1)
 * while RELOADING the first (`lbu a0,16(sp)`) and .cd (`lbu v0,19(sp)`) -- i.e. the shipped
 * reverse-order + read-back devices are the MIRROR IMAGE of that, which is what made them
 * look like papering.  MEASURED, all count-exact 113/113:
 *   natural r,g,b, read-back REMOVED, sourceB fence kept ............. 56
 *   ... with the sourceB fence re-laddered 0 / 1 / 3 / 4 operands ..... 56 / 58 / 56 / 56
 *   ... + a parm-spill pin (void fence / "r"(colorval) first stmt) .... 60 / 60
 *   ... + a 1/2/3-operand ref fence on sourceG (the model-derived dial
 *       for the b15<->sourceG swap the re-lay exposes) ............... 88 / 88 / 88
 * WHY THE RE-LAY LOSES, and this is the useful part: removing the reverse order does NOT
 * just move the pack block -- it rotates the whole UPSTREAM clamp region (b15 lands $a1
 * and sourceG $a3, retail has them the other way round; the prologue parm spill
 * `sw s1,36(sp); addu s1,a3,zero` slides from index 1-2 to 10-11).  So the reverse store
 * order is NOT paying for the pack block at all -- it is paying for the b15/sourceG global
 * allocno order, and the pack-block mirror is the PRICE, not the purpose.  That is a
 * genuine correction to this receipt stack: the residual 26 is the COST of a lever that
 * buys ~30 elsewhere, not an unexplained floor.
 * 11D CAVEAT LEARNED HERE (catalog candidate): an SLD-contradicting source shape is not
 * automatically a papering device.  When the SLD-faithful re-lay measures WORSE, check
 * whether the anti-SLD device is compensating a SEPARATE allocno decision UPSTREAM before
 * concluding the basin is fake -- 11D's own instruction is to judge the re-lay on the
 * WHOLE block, and here the whole block includes the clamps, not just the stores.
 * REMAINING TARGET (unchanged, now better framed): find a dial for the b15/sourceG order
 * that does NOT require the reverse store order; then the SLD-natural pack block is free. */
/* ===== w63-a13: 26 STAYS (re-gated, count-exact 113/113).  The w60 reframing is CONFIRMED
 * from a new direction: the SLD-natural r,g,b pack block costs +30 NO MATTER WHICH BYTES
 * ARE FORWARDED, so the store order is definitely paying for the upstream allocno order
 * and not for the pack block's own forwarding pattern.  MEASURED (all count-exact
 * 113/113, on top of the w60 table which removed the read-back entirely):
 *   r,g,b + read-back of BOTH .g and .b (retail's own forwarding pair)  56
 *   r,g,b + read-back of .b only                                       56
 *   r,g,b + read-back of .g only                                       56
 *   shipped b,g,r + an EXTRA read-back of .g                           26 (bit-identical)
 *   g,b,r (r last, g/b in retail order) + read-back of .r              26 (bit-identical)
 * ⇒ the pack-block half is saturated in BOTH directions: nothing in the store/forward
 * table moves the gate off 26/56.  The only live target remains the b15 <-> sourceG
 * global-allocno order.  🔴 NOTE FOR THAT WORK: the w49-a5 "-SIZE" numerator quoted in
 * the AdditiveNightCalc block below is WRONG (see the w63-a13 law correction there);
 * gcc-2.8.1 uses floor_log2(refs)*refs*SIZE/live.  Every pseudo here is a 4-byte int, so
 * the *4 is a common factor and the w41-a7/W55-A16 ORDERINGS and the reqdelta receipt are
 * all unaffected -- but re-derive any NEW dial from the multiplicative form. */
void Night_CreateNightTableElement(int colorIndex,long colorH,int bright,u_char *colorval)

{
  int sourceR;
  int sourceG;
  int sourceB;
  int chr;
  int chg;
  int chb;
  CVECTOR newColor;
  int b15;
  int newR;
  int newG;
  int newB;
  int bestIndex;

  b15 = bright * 0x111;
  /* colorH's THREE COMPONENT BYTES are read with lbu out of its ARG HOME on the stack
     (oracle `sw $a1,0x34($sp)` then `lbu 0x34($sp)` / `addiu $v1,$sp,0x34; lbu 1($v1);
     lbu 2($v1)`), which is also why the SYM classes colorH as ARG (stack) rather than
     REGPARM -- taking its address forces the spill.  The shift/mask spelling
     (`colorH & 0xff`, `>>8 & 0xff`, `>>16 & 0xff`) compiles to srl/andi and has no
     lbu at all. */
  chr = ((u_char *)&colorH)[0];
  chg = ((u_char *)&colorH)[1];
  chb = ((u_char *)&colorH)[2];
  sourceR = gTableCache[colorIndex].r;
  sourceG = gTableCache[colorIndex].g;
  sourceB = gTableCache[colorIndex].b;
  newR = sourceR + ((int)(chr * b15) >> 0xc);
  if (0xff < newR) newR = 0xff;
  newG = sourceG + ((int)(chg * b15) >> 0xc);
  if (0xff < newG) newG = 0xff;
  newB = sourceB + ((int)(chb * b15) >> 0xc);
  /* MATCH (W55-A16, 38 -> 26 diffs, count still EXACT 113/113) -- REQDELTA RECEIPT.
     The chg / sourceG / sourceB three-way register rotation (ours a1/v1/t0 vs oracle
     t0/a1/v1) was a GLOBAL-ALLOCNO PRIORITY tie, not a coloring coin-flip.
     allocsim replicates this fn 15/15 EXACTLY, and reqdelta's minimal single-dial
     answer for the retail handout {p86=v1, p85=a1, p88=t0} is
        p86 (sourceB)  refs 2 -> 4   (the floor_log2 REF-STEP: pri 0.1666 -> 0.667,
                                      lifting sourceB ABOVE the p85/p88 pair at 0.2857)
        p86 (sourceB)  live 12 -> 6  (the alternative dial)
     A two-operand read-only fence is exactly +2 refs and zero insns, so it buys the
     REF-STEP directly.  MEASURED, all four placements, this fn:
        1 operand  (refs 3, pri 0.25 -- BELOW the 0.2857 pair)  -> 41, rotation BACK
        2 operands before `newB =`                              -> 29 but 114 insns
                              (the implicit-volatile barrier blocks the chb `mult`
                               from filling a load-delay slot -> a stray nop)
        2 operands AFTER `newB =`                               -> 26, 113/113  <== kept
        sinking the `sourceB =` load to its use (the live dial) -> 48
     Re-laddered the store-order x read-back table AFTER this landing (04Z: rung
     tables are basin-relative): bgr/gbr/brg + read-back-of-r all stay 26, rgb 56,
     grb 58 -- the w50-a5 ranking is unchanged, so both halves below still hold.
     Residual 26 = the newColor byte-store/pack block only (see the diffsrc SLD map:
     retail stores .r at 16(sp) FIRST, SLD 206, and .b at 18(sp) SLD 208). */
  /* w61-a14: the w60-a6 'reframed target -- a dial for the b15/sourceG order that does NOT
     need the reverse store order' was attacked with the zero-insn identity launder (the
     device that cracked Weather_DoSplats and Weather_DoWeather this same wave) and is
     FALSIFIED: from the SLD-natural r,g,b pack basin (56) a launder on `b15` = 65 @114,
     on `sourceG` = 90, both = 84; from the SHIPPED basin a launder on `b15` = 55 @114 and
     on `sourceG` = 84.  The shipped 26 stands; the reverse-store-order price is still the
     cheapest way to buy that allocno order. */
  /* ---- w64-a13 (2026-08-15): 26 STAYS @113/113.  NEW BOUNDING FACT -- the W55 reqdelta
     TARGET IS ALREADY MET, so the residual is provably NOT an allocno question any more.
     Re-dumped this basin (`tools/rtl_dump.py recon/game/psx/night.cpp -dg -dl`) and ran
     tools/allocsim.py: **MATCH 15/15 (order-vs-dump: IDENTICAL)** and the handout is
     exactly W55's retail target -- p86 (sourceB) = $v1, p85 = $a1, p88 = $t0, bought by
     the two-operand read-only fence below.  Every long-lived pseudo in the table is on its
     retail register; what is left (p137 refs=10 live=7 pri 4.29 -> $v1, p157 -> $v1,
     p93 refs=4 live=8 -> $a0) are the SHORT block-local pack temps, i.e. the residual lives
     entirely in the by-value CVECTOR assembly and its store/forward choice, not in the
     priority table.  Concretely (side_by_side): retail reloads bytes 16(sp) and 19(sp) and
     forwards .g/.b, ours reloads 18(sp)/19(sp) and forwards .r/.g, and retail's OR-tree
     accumulates into ONE register in ascending byte order (`or a0,a0,v0` x3) where ours
     builds a different tree.  Since the w50/w63 store-order x read-back table is saturated
     in both directions (every combination is 26 or 54-58) and the allocno side is now
     closed, the only remaining axis is which bytes cse chooses to forward -- a cse/expand
     question for the instrumented lane, not a spelling sweep. */
  /* W76-orchestrator (2026-08-23): fence retuned per the A13_c4.spec PASS recipe --
     1-op "r"(newR) form; the old 2-op sourceB fence belongs to the 2.8.0-lane 26
     basin.  Live ONLY together with the SLD-natural store order below and the
     retail-2.8.1 per-fn cc1plus splice row (PER_FN_CC1PLUS_VER_SPLICE, psq44
     CC1PLPSX "2.8.1 SN32 BUILD 4.0.0010" -- a RETAIL SN binary, per the user's
     retail-PsyQ-only ruling).  Mechanism: the 2.8.0 orphan (use reg) note from
     try_combine's NULL-elim distribute_notes call (fixed Feb-6-1998) -- see the
     A13 receipt below. */
  /* ---- W71-A5 (2026-08-21): 26 STAYS @113/113.  The residual is now BOUNDED to a
     single mechanical fact and the bound is worth writing down, because the same wave
     cracked its TWIN (Night_AdditiveNightCalc, 59 -> PASS) with exactly the analogous
     move and it does NOT transfer here.
     THE FACT: ours and retail's pack blocks are STRUCTURALLY IDENTICAL, instruction for
     instruction, and differ ONLY in WHICH component byte is reloaded.  Both build
     [store X] [store g] [store Y] then forward g and Y with `andi ..,255` and RELOAD X
     with `lbu`.  Retail has X=.r (stored FIRST) / Y=.b; ours has X=.b / Y=.r.  The
     reloaded one is always the FIRST-stored, because its value register is clobbered by
     the SECOND store's `and` -- so the reload identity is a pure function of the STORE
     ORDER, and store order r-first is the 56-diff basin (it rotates b15/sourceG and the
     prologue parm spill upstream).  The two halves are therefore COUPLED and the coupling
     is the whole 26.
     RE-MEASURED THIS WAVE (all count-exact 113/113 unless noted, all from the shipped
     basin, extending the w50/w63 tables to the FULL cross-product):
       . store order x read-back, ALL 6 orders x ALL 8 read-back subsets (48 cells):
         every order that stores .r LAST plus a read-back of .r = 26; everything else
         46 / 54 / 56 / 58 / 66.  SATURATED in both directions, third confirmation.
       . VOLATILE-STORE forwarding dial (the 05E/14D device, aimed straight at "make .r
         reload"): `*(volatile u_char *)&newColor.r/.g/.b` x 3 orders x 5 read-back sets
         (75 cells) -- volatile on .b is BIT-IDENTICAL to none, volatile on .r or .g
         costs +2, and none of them changes which byte cse forwards.
       . early read-back of the FIRST-stored byte (so its register survives the second
         store) -- `newB = newColor.b;` between the .b and .g stores, with and without a
         ref fence on newB, and the `int mb = newB & ~7;` named-temp form: 55/59/61/78
         and +3 REAL INSNS (116/113) in every shape that actually keeps the value live.
       . declaration order of newR/newG/newB, all 6 permutations, both basins: provable
         no-op (bit-identical) -- pseudos here are numbered by FIRST USE, re-confirming
         the w41-a7 receipt against the w64-16A "decl order = pseudo number" law (that
         law's PRE-GATE does not hold here).
       . the rgb basin attacked with the ref-step dial that sealed AdditiveNightCalc:
         read-only fences of 1/2/3/4/6/8 operands on b15, sourceG, sourceR and chg
         (24 cells) -- 56 -> 58/62/64/66/68/78, i.e. every operand count moves it AWAY.
     🔴 WHY THE AdditiveNightCalc CURE DOES NOT TRANSFER, stated precisely (this is the
     useful part): there the blocker was the same SHAPE -- a block-local qty parked in the
     wanted hard register poisoning a long-lived pseudo's conflict set -- and the cure was
     to fold the offending BYTE LOAD into an existing global pseudo (`newR = color->r;`),
     which deleted the local qty outright.  Here the offending local qty is NOT a source
     read: it is the cse-created reload inside gcc's BY-VALUE CVECTOR argument assembly
     for `Night_FindClosestColor(newColor, ...)`.  There is no C handle on it -- a source
     read-back cannot merge with it (measured above, it costs a separate insn) -- so the
     fold is unavailable.  reqdelta on the rgb-basin dump confirms the arithmetic side is
     closed too: the wanted handout {p85=a1,p90=a3,p92=a1,p93=a0} has NO single-dial and
     NO same-pseudo two-dial solution within +-40 on refs/live/calls, because p93 (newB)
     carries a HARD conflict with $a0 in that basin (`;; 93 conflicts: ... 2 3 4 29`) --
     one of the pack block's own local qtys owns $a0 there, so no priority dial can ever
     reach it.
     ⇒ NAMED ANGLE (unchanged in kind, now quantified): this is a local-alloc QTY handout
     inside compiler-generated argument assembly = the AGENT_GUIDE 4.6 / catalog 06E
     instrument gap.  It needs tools/qtytrace.py against the instrumented cc1 ("which
     source change moves the arg-assembly reload off $a0 / makes cse forward .b instead of
     .r"), NOT another spelling sweep -- the spelling axis is now saturated three ways. */
  /* ---- W72-A14 (2026-08-22): 26 STAYS @113/113, but the class is RE-CLASSIFIED and the
     W71 "needs qtytrace/local-alloc QTY" verdict is REFUTED.  The residual is NOT an
     allocator question at all -- it is a **gcc VERSION identity** question (catalog 3.25
     / AGENT_GUIDE 3), and the evidence is now direct rather than inferential.
     THE INSTRUMENT: C:\Temp\nfs4-instr-cc1\cc1plus-ecoff.exe (the FSF gcc-2.8.1 cc1plus
     built for the trace lane).  Run it on this TU's own build/.../night.cpp.i with
     `-quiet -O2 -G8 -funsigned-char` (the -funsigned-char is MANDATORY: PsyQ's CC1PLPSX
     defines __CHAR_UNSIGNED__, the FSF build does not, and without it every `char` field
     read comes out `lb` instead of `lbu` and swamps the comparison).
     FINDING 1 -- THE RESIDUAL IS EXACTLY THE VERSION-SENSITIVE REGION.  With that flag,
     gcc-2.8.1 and PsyQ CC1PLPSX (2.8.0) emit this 117-cc1-insn function **IDENTICALLY**
     except for 20 lines, and those 20 lines ARE the by-value CVECTOR argument assembly.
     Nothing else in the function differs -- not one register, not one schedule slot.
     FINDING 2 -- 2.8.1 PRODUCES RETAIL'S PACK BLOCK, THE FIRST BUILD EVER TO DO SO.
     In the NATURAL r,g,b store order gcc-2.8.1 emits, register for register:
        li $3,-8 / li $4,255 / and $2,$7,$3 / sb $2,16(sp) / and $2,$5,$3 / sb $2,17(sp)
        andi $2,$2,0xff / and $3,$4,$3 / sll $2,$2,8 / sb $3,18(sp) / andi $3,$3,0xff
        sll $3,$3,16 / lbu $4,16(sp) / addu $5,$sp,24 / or $4,$4,$2 / lbu $2,19(sp)
        or $4,$4,$3 / sll $2,$2,24 / jal / or $4,$4,$2
     which is retail's block verbatim apart from ONE upstream register ($7 vs retail's $6
     for newR -- the known b15/sourceG rotation).  gcc-2.8.0 instead builds an
     intermediate accumulator in $v1 and RELOADS a second byte:
        ... andi $4,$2,0xff / and $3,$5,$3 / sll $4,$4,8 / addu $5,$sp,24 / sb $3,18(sp)
        lbu $3,16(sp) / **lbu $2,18(sp)** / or $3,$3,$4 / sll $2,$2,16 / lbu $4,19(sp)
        or $3,$3,$2 / sll $4,$4,24 / jal / **or $4,$3,$4**
     i.e. 2.8.0 does NOT store-forward the LAST byte store, and its OR-tree therefore
     cannot start from the arg register.  That is the whole 26.
     FINDING 3 -- THE TWO HALVES WANT OPPOSITE STORE ORDERS, WHICH IS WHY 26 IS THE 2.8.0
     MINIMUM.  Region A (the clamps + the prologue parm spill + the b15/sourceG rotation)
     is retail ONLY in the shipped b,g,r + read-back-of-.r basin; region B (the pack
     block) is retail ONLY in the r,g,b basin AND only under 2.8.1.  Under 2.8.0 no store
     order can fix B: the 2.8.0 lane never forwards the last store.  MEASURED THIS WAVE:
        shipped source, 2.8.0 lane ............................. 26 @113
        shipped source, 2.8.1 SPLICE .......................... 26 @113 (inert -- 2.8.1's
             better OR-tree still reloads 18(sp)/19(sp), because the reload IDENTITY is a
             function of the STORE ORDER, exactly as the W71 receipt says)
        r,g,b (read-back removed), 2.8.0 ...................... 56 @113
        r,g,b, 2.8.1 SPLICE .................................. 56 @113 (region B becomes
             retail, region A's ~50 lines dominate -- the count is a coincidence)
        r,g,b + `newB = newColor.b;` read-back, 2.8.0 ......... 56, pack block
             BIT-IDENTICAL to the plain r,g,b one => the last-store forwarding is
             unreachable from source on 2.8.0, a clean negative control.
        r,g,b + 1/2/3-operand read-only fence on newR ......... 56 / 68 / 68
        r,g,b + a 1-operand newR fence placed between the .r and .g stores .. 56
        r,g,b + that fence, 2.8.1 SPLICE ..................... 56
     FINDING 4 -- THE CORPUS ROUTE IS CLOSED (the briefed "the matched C spelling may
     exist"): a by-value CVECTOR/SVECTOR/DVECTOR parameter does not occur ANYWHERE in the
     34-repo C:\Temp\ps1-decomp-refs corpus, nor in rage-racer-decomp, nor in psyz
     (`grep -rnE "\((CVECTOR|SVECTOR|DVECTOR)[ ]+[a-z][A-Za-z0-9_]*[,)]" --include=*.c`
     = zero hits in all three).  There is no matched sibling spelling to copy; EA's
     `Night_FindClosestColor(CVECTOR, int *)` by-value prototype is unique to this tree.
     => NAMED NEXT ANGLE, and it is now a ONE-VARIABLE problem: under a 2.8.1 cc1plus the
     pack block is FREE in the r,g,b basin, so the entire function reduces to "dial region
     A (b15 <-> sourceG <-> newR + the prologue parm spill slide) in the r,g,b basin".
     Two orchestrator-level prerequisites, both outside an agent's scope:
       (a) a per-fn or per-TU **cc1PLUS version splice** for the C++ lane -- build.py's
           `_apply_cc1_ver_splice` exists but is called only from compile_c, and
           `_resolve_cc1_alt` resolves the windows-gcc-psx **cc1** (C) rungs; the C++ lane
           has no ladder.  A probe harness that does the splice is kept at
           scratchpad/W72_A14/cc1pl_splice_probe.py (monkey-patches compile_cpp, runs the
           full maspsx+as route, gates with verify_asm's own normalizers).
       (b) a DECISION on whether an FSF-built 2.8.1 cc1plus may stand in for a vendor one
           at all -- the instrumented binary needs -funsigned-char to match PsyQ's char
           default, so it is a lab instrument, not a shippable toolchain rung.
     Until (a)+(b), the shipped b,g,r basin remains the right ship: it buys region A,
     which is 30 diffs, at the cost of region B, which is 26. */
  /* ===== W74-A12 (2026-08-22/23): 26 STAYS @113/113 -- and THE SOURCE AXIS IS NOW
     CLOSED WITH A MECHANISM, not with an exhaustion argument.  The assignment was to
     find a 2.8.0-reachable spelling the 123-cell store-order x read-back x
     volatile-store cross-product (w50/w63/w71) missed.  FOUR axes it never touched
     were swept (37 new cells, every one re-gated); none lands, and the third one
     REFUTES the model everybody has been working from, which is the useful part.
     WHAT THE BLOCK ACTUALLY IS (expr.c reading, the assignment's third instrument):
     `Night_FindClosestColor(newColor, ...)` passes a 4-byte align-1 BLKmode aggregate
     wholly in $a0, so expand_call reaches expr.c:2859 `move_block_to_reg` ->
     `operand_subword_force (x, 0, BLKmode)` (expr.c:1734); with alignment below a word
     that falls through to expmed.c's `extract_split_bit_field`, whose little-endian
     loop emits exactly the shipped shape -- four byte reads at 16..19(sp), each shifted
     by 8*i and OR-ed into a running accumulator in ASCENDING byte order.  The tree is
     therefore FIXED by the loop, not by the source; the only things that can differ are
     (i) which of the four byte reads cse replaces with a still-recorded store value
     (`andi rN,rN,255` instead of `lbu`), and (ii) where the accumulator lives.
     🔴 THE REFUTATION (round 3, the cse MEMORY-INVALIDATION dial -- a `"memory"` clobber
     between the pack stores and the call).  It does exactly what it should: every
     recorded store dies, all FOUR bytes become fresh `lbu`s, and the count does not move
     (113, forwards traded 1:1 for reloads).  Retail's block starts `lbu a0,16(sp)` and
     then accumulates IN $a0 (`or a0,a0,v0` x3).  Under this clobber gcc-2.8.0 DOES emit
     `lbu a0,16(sp)` -- and still writes the accumulator into a scratch (`or v0,a0,v0`),
     with only the final `or` reaching $a0.  ⇒ the accumulator's home is NOT a function
     of whether the first term is a fresh load or a forwarded register.  Every receipt in
     this stack from w50 onward has treated "which byte is forwarded" as the question;
     it is not.  gcc-2.8.0 builds this OR-tree in a scratch unconditionally, gcc-2.8.1
     (W72-A14's dump) builds it in the destination.  That is the whole 26, it is a
     one-line codegen-identity difference, and NO byte-availability spelling can reach it.
     (The clobber also costs upstream: it is a sched1 barrier, so it re-rotates the
     clamps -- 68 diffs.  mem-clobber placed BEFORE the last store is bit-identical to
     none, as expected: only the last store's record is at stake.)
     THE OTHER THREE AXES, all inert or worse (full ladder):
       (1) MEM_IN_STRUCT_P ALIAS DIAL (catalog 22C-3) -- the three pack stores respelled
           as `*(u_char *)((char *)&newColor + N) = ...` cast stores, which clear /s and
           alias-chain to everything: all three, .r only, .g+.b, .b only, .g only =
           26 BIT-IDENTICALLY in every cell.  Aliasing controls cse INVALIDATION, not
           cse RECORDING, so a cast store is recorded exactly like a COMPONENT_REF;
           the dial cannot reach this block at all.  (Dropping the read-back from the
           cast form still measures 46, i.e. the read-back is doing its documented job.)
       (2) TIED MULTI-OUTPUT LAUNDER (catalog 22B-3) on the clamped locals:
           (newG,newB) 29 @114 . (newR,newB) 43 @114 . (newR,newG,newB) 29 @114 .
           (newG,newB) placed between the .b and .g stores 26 (bit-identical).
           Every form that is not inert costs its own copy insn -- the same cross-block
           boundary the W71 front.cpp receipt records for this device.
           Read-only ref fences on newR / newB (1 and 2 operands, before and after the
           pack block): 55 / 59 / 67 / 59 @116 -- all +3 real insns.
       (3) THE ARGUMENT-EXPRESSION AXIS (how expand_call is handed the aggregate):
           `*(CVECTOR *)&newColor` 26 (bit-identical) . through a `CVECTOR *` local 26
           (bit-identical) . through a copy `CVECTOR nc2 = newColor;` 97 @118 (a real
           movstrsi block copy appears) . read-back carrier respelled as a fresh
           block-local 46 . as `*(u_char *)&newColor` 26 . extra read-backs of .g / .b /
           both 26 (all bit-identical) . a read-back of .cd 62.
     ⇒ VERDICT: the source axis for region B is CLOSED, and closed by a named mechanism
     (extract_split_bit_field's accumulator home is a 2.8.0-vs-2.8.1 identity, not a
     byte-availability or aliasing or liveness question).  The remaining route is
     unchanged and is the ORCHESTRATOR-level one W72-A14 specified: a per-fn cc1PLUS
     VERSION splice for the C++ lane (build.py's `_apply_cc1_ver_splice` is wired only
     from compile_c) plus a decision on whether an FSF-built 2.8.1 cc1plus may stand in
     for a vendor one.  With that splice the pack block is free in the r,g,b basin and
     the whole function reduces to dialling region A (the b15 <-> sourceG order + the
     prologue parm spill) in that basin.  Nothing further should be spent on spellings
     here. */
  /* ===== W75-A13 (2026-08-23): 26 STAYS @113/113 -- and the W72/W74 verdict
     ("the accumulator's home is a 2.8.0-vs-2.8.1 CODEGEN identity inside
     extract_split_bit_field") is REFUTED.  The two compilers' RTL for this
     function is IDENTICAL; the divergence is a LOCAL-ALLOC ELIGIBILITY GATE,
     and it is now cited rather than inferred.
     THE MEASUREMENT (same .i fed to CC1PLPSX 2.8.0 and to
     C:/Temp/nfs4-instr-cc1/cc1plus-ecoff.exe 2.8.1 with -funsigned-char, both
     -O2 -G8, dumps -dc/-dl; copies under scratchpad/w75/A13/):
       . the .s bodies differ in EXACTLY the accumulator register -- 2.8.0 runs
         the OR-tree in $v1 and ORs into $a0 only at the last term, 2.8.1 runs it
         in $a0 throughout (= retail).  Same insn COUNT, same everything else.
       . the combine dumps are insn-for-insn identical, SAME PSEUDO NUMBERS,
         except 2.8.0 carries ONE extra insn:
             (insn 320 139 141 (use (reg:SI 137)) -1 (nil)
                 (expr_list:REG_DEAD (reg:SI 137) (nil)))
         parked immediately after (code_label 139) = the join label of the newB
         clamp = the head of the pack block's basic block.  reg 137 IS the
         ior accumulator (set at insns 196/202, consumed by
         (set (reg a0) (ior 137 150)) at insn 205).
     WHERE THAT INSN COMES FROM: combine.c distribute_notes, REG_DEAD case --
     the backward walk `for (tem = prev_nonnote_insn (i3); place == 0 && tem &&
     (INSN || CALL_INSN); tem = prev_nonnote_insn (tem))` (2.8.1 combine.c:11298)
     finds no home, stops on the CODE_LABEL, and then combine.c:11396 does
     `place = emit_insn_after (gen_rtx (USE, VOIDmode, XEXP (note, 0)), tem)`
     and hangs the death note on it.  The ONLY 2.8.0->2.8.1 ChangeLog entries
     touching this code are `combine.c (distribute_notes, case REG_DEAD): ... use
     reg_bitfield_target_p` (Sat Feb 14 1998) and `combine.c (distribute_notes):
     Completely check for note operand being only partially set on potential note
     target` (Thu Feb 12 1998).  There is NO expmed.c entry in the 2.8.0..2.8.1
     window at all -- extract_split_bit_field is the same code in both, exactly as
     the dumps show.  (ChangeLog extracted to scratchpad/w75/A13/gcc-2.8.1/.)
     WHY IT COSTS THE REGISTER: the extra USE makes REG_N_DEATHS(137) == 2
     (.lreg: 2.8.0 "Register 137 used 10 times across 7 insns in block 6; dies in
     2 places" vs 2.8.1 "... across 6 insns in block 6").  local-alloc.c:472 lets
     a pseudo into LOCAL allocation only when
        REG_BASIC_BLOCK (i) >= 0 && REG_N_DEATHS (i) == 1
     so 2.8.0 sets reg_qty[137] = -1 and SKIPS it.  The handouts prove it: the
     2.8.1 .lreg prints `;; Register 137 in 4.` ($a0 = retail) and the 2.8.0 .lreg
     prints no line for 137 at all.  What follows is forced -- local-alloc hands
     the block-local byte temps their registers first (reg 139 -> $v1, and reg 150,
     the `lbu 19(sp)` byte, -> $a0 INSIDE 137's live range), and global_alloc, which
     DOES record a hard_reg_preference of $a0 for 137 (global.c:1351 mark_reg_store
     -> :1538 set_preference, the 'e'-format branch off the ior, copy=0), finds $a0
     occupied over the whole range and prunes it (global.c:1033).  137 -> $v1.
     THE BOUND (why no 2.8.0 spelling reaches it):
       (a) the orphan is invariant under the shape.  Death-count instrument run on
           the SHIPPED basin (2), the SLD-natural r,g,b basin (2), and a BRANCHLESS
           newB clamp that DELETES the clamp-join CODE_LABEL outright (2 -- the walk
           just stops at the next label up, 63 diffs @114).  combine.c:11396 fires
           whenever `tem != 0`, i.e. anywhere but the first insn of a function.
       (b) $a0 cannot be freed for 137 by the 20B family: reg 150 is born AND dies
           strictly inside 137's live range, so any zero-insn clobber that denies
           $a0 to 150 denies it to 137 too (22B-1 clobber-live-range placement law).
     NEW AXES SWEPT AND FALSIFIED THIS WAVE (on top of the 123-cell w50/w63/w71
     cross-product and W74's four): the 23A-3 STATEMENT-COUNT LIFETIME DIAL -- the
     three pack stores merged into ONE comma statement, in both basins and with/
     without the read-back: 56 / 56 / 26 / 26, the last two BIT-IDENTICAL (the
     three stores are already one basic block, so no luid moves); the branchless
     clamp above; and `newColor.cd = 0` (which does make cse forward all four bytes)
     -- 20 diffs but @111, THREE INSNS SHORT and unfaithful, since retail's oracle
     reloads 0x13(sp) with no preceding store.  23A-1 (scratch write-through) and
     23A-2 (reload_cse donor) re-checked against this basin and neither applies:
     there is no movstrsi block move here, and the residual carries no
     `addu rD,rS,zero`-for-a-constant tell.
     => NAMED ANGLE (replaces "wire a 2.8.1 cc1plus for the pack block"): the wanted
     effect is REG_N_DEATHS(accumulator) == 1, i.e. keep combine from orphaning that
     one death note.  The instrument that would settle it is a [distribute_notes]
     trace on the instrumented cc1plus naming the (i3, from_insn) pair whose
     REG_DEAD(reg 137) goes homeless -- the same class of named instrument ask as
     23D-1's [reload_pick].  A whole-function cc1plus version splice would of course
     also fix it, but it is no longer the only description of the problem. */
  /* ===== W76-A13 (2026-08-23): 26 STAYS in the tree, but the function is SOLVED --
     PASS 113/113 exists under a per-fn cc1plus-2.8.1 splice (recipe below), and the
     W75 provenance is UPGRADED to the exact 2.8.0 bug + its fix commit.
     (1) TRUE PROVENANCE (supersedes W75's walk-internal reading -- the walk code is
     IDENTICAL in 2.8.0/2.8.1).  The orphaning distribution is try_combine(i3=insn 196
     `137 &= 0xFF00FFFF`, i2=insn 190 `137 = 139|143` = the accumulator's BIRTH): the
     merged pattern `137 = 139|143` drops the self-use (mask folded via nonzero_bits),
     i3dest_killed = reg 137, and elim_i2 = i2dest = reg 137 (full 2->1 merge, dest not
     in i2src -- combine.c:2189).  gcc-2.8.1 passes elim_i2/elim_i1 to the i3dest_killed
     distribute_notes call (combine.c:2356-2359), whose REG_DEAD case discards the note
     at `if (XEXP(note,0) == elim_i2 ...) break;` (:11282) -> place stays 0 ->
     REG_N_DEATHS-- (:11535-38) -> deaths(137)==1 -> local-alloc eligible -> $a0 = retail.
     gcc-2.8.0 passed NULL_RTX there; the fix is ChangeLog Fri Feb 6 1998 (Kenner):
     "combine.c (try_combine): Pass elim_i2 and elim_i1 to distribute_notes for
     i3dest_killed REG_DEAD note."  W75 cited the two distribute_notes-body entries
     (Feb 12/14) but the operative change is this CALL-SITE one.
     (2) THEOREM (source axis closed BY CONSTRUCTION, upgrading W75's measurements):
     on 2.8.0 the note has NO good outcome -- a successful walk PLACEMENT also leaves
     REG_N_DEATHS==2 (only the elim-discard path decrements), and the orphan fires
     whenever combine merges the accumulator birth into the first SURVIVING self-mask,
     which every >=3-field by-value byte-aggregate build produces (the first acc-mask
     folds in cse via AND-chain association, every later one sits over an IOR and
     survives to combine).  No spelling of a 4-byte by-value CVECTOR can escape.
     (3) TOOL BUG: the W72-A14 splice harness (scratchpad/W72_A14/cc1pl_splice_probe.py)
     gated VACUOUSLY -- tools/verify_asm.py re-imports build.py FRESH (module_from_spec
     ignores the monkey-patch) and compile_cpp has no cache, so the gate recompiled
     UNSPLICED.  Every W72 Finding-3 "SPLICE" cell (26/56/56) = the no-splice number.
     Fixed harness: scratchpad/w76/A13_splicegate.py (gates the pre-built object,
     SPLICE-NOOP guard).  TRUE splice table (all count 113 unless noted, x2 stable):
        shipped source + 2.8.1 splice ......... 16  (W72 said 26 "inert" -- wrong)
        r,g,b, no read-back + splice .......... 20  (W72 said 56 -- wrong; residual =
             region A exactly: b15<->newR a2/a3 pair + the parm-spill slide)
        ... + sourceB fence removed ........... 20  (the W55 fence is 2.8.1-inert)
        ... + 1-op newR fence after newR clamp   3 @114 (fence barrier blocks the chg
             mult's load-delay-slot fill -> stray nop)
        ... + tied launder on newR ............  8
        ... + `__asm__("" : : "r"(newR));` AT THIS fence position, sourceB fence
             removed, read-back removed ....... PASS 113/113  <== spec kept at
             scratchpad/w76/A13_c4.spec; same source on the 2.8.0 lane = 56.
     The PASS source is MORE faithful than the shipped basin: SLD-natural r,g,b store
     order (SLD 206-208), no read-back device, one 1-op fence.  Mechanism: +1 ref lifts
     newR (4->5 refs, pri .33->.42) above b15's .33 tie so newR allocates first ($a2,
     retail) and b15 takes $a3; at this position the barrier sits between the newB
     compute and its clamp where it blocks no slot fill.
     => SHIP DECISION unchanged until the orchestrator/user wires a PER-FN cc1PLUS
     ver-splice lane (compile_cpp has none; only compile_c has _apply_cc1_ver_splice)
     and rules on the FSF-built 2.8.1 cc1plus stand-in (-funsigned-char lab build).
     When wired: apply A13_c4.spec verbatim + the splice row -> seal.  NOTE for the
     [distribute_notes] trace belt (A20): pristine 2.8.1 does NOT reproduce the Night
     orphan -- the note dies at the :11282 elim break; to reproduce 2.8.0 behavior the
     instrument needs an env-gated NULL elim_i2/elim_i1 at the i3dest_killed call.
     CONFIRMED with A20's built instrument (GCC_TRACE_DISTRIBUTE_NOTES=2, instrumented
     2.8.1 cc1plus, this TU's .i): ZERO trace lines -- reg 137's REG_DEAD never even
     enters the place==0 walk under 2.8.1 (discarded at the elim break, upstream of
     the walk), the one-command negative certificate for this receipt.  The W75 named
     angles (a) label-move and (b) same-block-death are both DEAD BY CONSTRUCTION on
     2.8.0: a *successful* walk placement also yields REG_N_DEATHS==2 (theorem above),
     so no label/block reshape can reach deaths==1 -- only the elim discard can, and
     2.8.0 never takes it.  The splice-lane PASS recipe above supersedes them. */
  if (0xff < newB) newB = 0xff;
  /* `& ~7` (a register-held -8, oracle `addiu $v1,$zero,-0x8` + three `and`), NOT
     `& 0xf8` (which is a 16-bit unsigned immediate -> andi). */
  /* MATCH (w50-a5, 56 -> 38 diffs, count still EXACT 113/113): TWO cooperating pieces,
     NEITHER of which moves the gate alone.  (1) the three masked stores in REVERSE
     component order, so newColor.r is stored LAST; (2) a zero-insn STORE-READ-BACK of
     that last store (`newR = newColor.r;` -- cc1 forwards the just-stored value, so no
     instruction is emitted, the count stays 113).  This is aimed straight at the
     mechanism the w41-a7 -dg/-dl receipt below already named: our hard-$a0 conflict comes
     from the cse-created reload of the just-stored newColor.g byte, and retail avoids it
     because retail ALSO store-forwards a byte instead of reloading it.  Making the LAST
     store the forwarded one reproduces that.  MEASURED (all count-exact 113/113): store
     order alone rbg 56 / grb 58 / gbr 54 / brg 54 / bgr 54; read-back alone (rgb order)
     r/g/b all 56; r-stored-LAST + read-back-of-r 38 in EVERY combination (bgr, brg, gbr,
     and plain g,b,r), and adding further read-backs changes nothing.  ⚠️ do NOT also route
     the else-arm's gTableCache stores through newR/newG/newB -- that costs 7 real insns
     (141 @120).  Reverse store order is the load-bearing half; keep both. */
  /* W76-orchestrator: SLD-natural r,g,b store order, read-back REMOVED -- the
     A13_c4.spec PASS-113/113 shape under the 2.8.1 splice row.  The W50 reverse-
     order + read-back device above described the 2.8.0-lane 38/26 basins and is
     SUPERSEDED for this fn (kept as history). */
  newColor.r = (u_char)(newR & ~7);
  newColor.g = (u_char)(newG & ~7);
  newColor.b = (u_char)(newB & ~7);
  /* newColor.cd is deliberately NOT initialised: the oracle builds the by-value CVECTOR
     argument by re-reading all four bytes back off the stack (`lbu $v0,0x13($sp)` for
     .cd) with no preceding store, so retail leaves it whatever was in the slot.  Harmless
     -- Night_FindClosestColor only reads .r/.g/.b -- but writing 0 costs an extra sb. */
  if (((Night_FindClosestColor(newColor,&bestIndex) < 0x201) || (Chunk_numLight + 4 <= colorIndex)) ||
      (0xff < Night_gTotalLights)) {
    *colorval = (u_char)bestIndex;
  }
  else {
    gTableCache[Night_gTotalLights].r = newColor.r;
    gTableCache[Night_gTotalLights].g = newColor.g;
    gTableCache[Night_gTotalLights].b = newColor.b;
    *colorval = (u_char)Night_gTotalLights;
    Night_gTotalLights = Night_gTotalLights + 1;
  }
  return;
}

/* ---- Night_CreateNightTable__FiliPA256_A16_Uc  [NIGHT.CPP:236-237] SLD-VERIFIED ---- */
void Night_CreateNightTable(int colorIndex,long colorH,int bright,u_char (*tbl)[256][16])

{
  Night_CreateNightTableElement(colorIndex,colorH,bright,(*tbl)[colorIndex] + bright);
  return;
}

/* ---- Night_GenerateNextLightningEvent__Fv  [NIGHT.CPP:347-353] SLD-VERIFIED ---- */
void Night_GenerateNextLightningEvent(void)

{
  int rmask; /* SYM-CODEGEN-CARRIER: rmask -- shared masked-delay result; direct expressions are FAIL 8 (29/29) */
  int *ticksp; /* SYM-CODEGEN-CARRIER: ticksp -- explicit gameTicks cell preserves retail relocation/issue order; direct global is FAIL 2 */

  ticksp = &NIGHT_GAME_TICKS;
  rmask = (random() & 0x7ff) + 0x1f;
  Night_gNextLightning = *ticksp + rmask;
  rmask = (random() & 0xf) + 0xf;
  Night_gEndNextLightning = Night_gNextLightning + rmask;
  Night_gNextFlicker = Night_gNextLightning;
  Night_gFlashAzimuth = random() & 0xffff;
  Night_gShowForks = (u_char)random() & 1;
  return;
}

/* ---- Night_PauseLightningEffect__Fi  [NIGHT.CPP:381-416] SLD-VERIFIED ---- */
void Night_PauseLightningEffect(int player)

{
  int track;
  int slice;
  int startp;
  int endp;
  int pause_flag;

  slice = NIGHT_CAMERA_SLICE(player);
  track = D_80113228[0];
  pause_flag = 0;
  startp = Night_gLightningPauseAreas[track][0];
  endp = Night_gLightningPauseAreas[track][1];
  if (startp < slice) {
    pause_flag = slice < endp;
  }
  if (Night_WeatherType == 0) {
    pause_flag = 1;
  }
  if (pause_flag != 0) {
    Night_gNextLightning = D_8011E0B0[0];
    Night_gEndNextLightning = D_8011E0B0[0];
  }
  return;
}

/* ---- Night_DoLightningEffect__FP13DRender_tView  [NIGHT.CPP:423-467] SLD-VERIFIED ---- */
void Night_DoLightningEffect(DRender_tView *Vi)

{
  static char lightningInit = 1; /* SYM STAT CHAR @ function-relative data offset 0x1e */

  if (Night_gLightning != 0) {
    AudioCmn_PlayThunder(Night_gFlashIntensity,Night_gFlashAzimuth);
    Hrz_LightningFlicker(0);
    Night_gLightning = 0;
  }
  if (((NIGHT_GAME_TICKS > Night_gNextLightning) &&
      (NIGHT_GAME_TICKS < Night_gEndNextLightning)) && (Night_gNextFlicker < NIGHT_GAME_TICKS)
     ) {
    Night_gLightningType = random() & 1;
    Hrz_LightningFlicker(1);
    /* branched if/else, NOT `= (tunnel == 0)`: the oracle emits
       `beqz $v0,.L; addiu $v0,zero,1` + two separate `sb` stores with a `j` over the
       else arm; the boolean-expression form folds to a single sltiu. */
    if (BWorldSm_TunnelFlagSm(&NIGHT_CAMERA_SLICEPOS(Vi->player)) != 0) {
      Night_gDrawLightning = 0;
    }
    else {
      Night_gDrawLightning = 1;
    }
    Night_gLightning = 1;
    Night_gNextFlicker = NIGHT_GAME_TICKS + (random() & 3);
    Night_gFlashIntensity = (Night_gLightningType + 1) * (random() & 0x1f) + 0x40;
    if (lightningInit != '\0') {
      if (Night_gShowForks != '\0') {
        Hrz_SetLightingPosInSky(Vi);
      }
      lightningInit = '\0';
    }
  }
  if (NIGHT_GAME_TICKS > Night_gEndNextLightning) {
    Night_GenerateNextLightningEvent();
    Hrz_CalculateLightning();
    lightningInit = '\x01';
  }
  return;
}

/* ---- Night_SetCopColor__FP18GameSetup_tCarData  [NIGHT.CPP:473-484] SLD-VERIFIED ----
 * NEAR-MISS 5 diffs (ours 38 / oracle 37).  Was 25, then 21 after the per-element
 * %gp_rel split of Night_gCopColor (w39-a9), then 5 after the SYM rewrite below.
 * SYM block @43c244 is the ground truth (fsize 16, mask $00000000 = NO saved regs,
 * ONE block, six locals):
 *    carinfo  REGPARM $4  = a0
 *    cartype  REG     $2         country REG $5 = a1        carTable REG $4
 *    copColors AUTO `ARY PTR ARY ARY UCHAR size 8 dims 3 2 256 8` @ -0x10 => sp+0
 *    col1     REG     $2         col2    REG $2
 * => the retail local is `u_char (*copColors[2])[256][8]` -- TWO entries at sp+0..7, NOT
 *    the four-entry sp+0..0xF table the old recon modelled.  The oracle's second pair at
 *    sp+8/sp+0xC is gcc's TEMPORARY for a LOCAL AGGREGATE INITIALIZER whose elements are
 *    NOT compile-time constants: `u_char (*copColors[2])[256][8] = { Red, Blue };` builds
 *    the value at sp+8/0xC and then movstrsi-copies it down to sp+0/4.  That is exactly
 *    the oracle's `sw v0,8(sp); sw v1,0xC(sp); lw a2,8(sp); lw a3,0xC(sp); sw a2,0(sp);
 *    sw a3,4(sp)` -- reproduced here for the right reason (the old recon got the same
 *    bytes out of a hand-written 4-slot array + a struct-assignment, which is why the
 *    SYM's `copColors` name/shape never fit).
 *    NEW CATALOG ROW: a local array with a NON-CONSTANT aggregate initializer = build-in-
 *    temp + block copy; the same values written as element assignments do NOT produce it.
 * `country` MUST be read BEFORE `cartype` (13 -> 5 diffs): it is what puts cartype in $a0
 * and country in $a1 like retail; the reverse order swaps them and cascades.
 * RESIDUAL 5: ours `lw v0,0(v0); nop; sw v0,%gp_rel(Night_gCopColor)` for the FIRST
 * element; retail loads it into $a0 and DEFERS the store past col2's index arithmetic,
 * which fills the load-delay slot (37 vs our 38 insns).  Tried and re-gated: moving the
 * store after `col2 = ...` (35 insns, 32 diffs -- gcc cross-merges the two stores),
 * hoisting both col1/col2 reads first (same 32), dropping the carTable temp (5, tie),
 * carTable block-scoped (5, tie), a
 * `char *pair` local for the two country-table bytes (20, worse), flat single-scope
 * decls (5, tie).  Also survives -G8 and all four wired per-TU codegen flags. */
void Night_SetCopColor(GameSetup_tCarData *carinfo)

{
  int cartype;
  int country;
  /* SYM's INT carrier is confirmed by both retail allocation and the split m2c
     output (a 32-bit temp); pointer casts occur only at the table boundaries. */
  int carTable;

  country = carinfo->Country;
  cartype = Night_gCopCarTypeColorIdx[carinfo->carType];
  {
    u_char (*copColors[2])[256][8] = { Night_gCopLightingTableRed,
                                       Night_gCopLightingTableBlue };
    int col1;
    int col2;

    /* w46-a9 (5 -> 2, count now EXACT 37/37).  Two changes:
     *  (1) col2's index arithmetic is hoisted ABOVE the Night_gCopColor store, so
     *      that store lands after `addu` like retail (the w41 note's "move the store
     *      after col2" cross-merged the two stores because both were then adjacent;
     *      splitting the INDEX from the STORE avoids the merge entirely).
     *  (2) col2's table read is a `volatile`-cast deref.  A plain `copColors[col2]`
     *      ARRAY_REF of a stack local is provably non-aliasing with the gp-rel
     *      global store, so gcc hoists the `lw` above it and fills the load-delay
     *      slot with `sw a0,0(gp)` -- 36 insns, one SHORT of retail.  The volatile
     *      MEM cannot be reordered, so the `sw` issues first and the oracle's
     *      load-delay `nop` reappears (37/37).
     * MATCH (w49-a5): SEALED 37/37 PASS.  The volatile-cast deref above was the WRONG
     * cure: it pinned the load but destroyed the sp-first `addu` operand order (only a
     * genuine ARRAY_REF on the frame DECL emits `addu v0,sp,v0`; every address-of /
     * cast spelling gets fold-canonicalized to index-first `addu v0,v0,sp`).  The right
     * cure is on the STORE side: with both stores made ARRAY_REFs on the real
     * Night_gCopColor[2] object, the plain `copColors[col2]` read can
     * no longer hoist above them, so the read keeps its ARRAY_REF form AND its position.
     * Falsified on the way (all re-gated from this basin): `volatile`-qualified copColors
     * DECL (forces a memcpy call, 41 insns); volatile array-ptr / elem-ptr views over
     * copColors (35 insns); one reused `col` variable (36); a `u_char *pair` local for the
     * two table bytes (35); store-before-col2 (38); both-cols-first (35). */
    col1 = (u_char)Night_gCopCountryLightTbl[cartype][country][0];
    carTable = (int)copColors[col1];
    col2 = (u_char)Night_gCopCountryLightTbl[cartype][country][1];
    Night_gCopColor[0] = (u_char (*)[256][8])carTable;
    Night_gCopColor[1] = copColors[col2];
  }
  return;
}

/* ---- Night_InitPlayerHeadLightColor__Fi  [NIGHT.CPP:488-496] SLD-VERIFIED ---- */
void Night_InitPlayerHeadLightColor(int player)

{

  if (Night_gPlayerLightingTable == (u_char (*) [256] [16])0x0) {
    Night_gPlayerLightingTable = reservememadr("plnight",0x1000,0);
  }
  Night_gPlayerHeadLightColor[player] = *(long *)&NIGHT_TRACK_NIGHT.nightcolor;
  return;
}

/* ---- Night_SetPlayerHeadLightColor__Fiii  [NIGHT.CPP:501-503] SLD-VERIFIED ---- */
/* SEALED 15/15 PASS (w39-a9).  The prior "GENUINE FLOOR. ACCEPT." verdict here (a 10-diff
 * v0/v1 register-materialization tie-break on &Night_gPlayerHeadLightColor[player]) was
 * WRONG -- it was a per-OBJ TOOLCHAIN-IDENTITY artifact, not an allocator tie-break:
 * night.obj was built -G8, not -G4.  Proof: the retail oracle reaches the night-OWNED,
 * 8-BYTE Night_gPlayerHeadLightColor (long[2] @0x8013da80) with a one-instruction
 * %gp_rel in Night_GenerateAllLightTables -- impossible under -G4.  Under -G8 cc1plus
 * emits the `la $r,sym` assembler MACRO instead of pre-splitting it into a schedulable
 * `lui %hi / addiu %lo` pair, and the macro expansion is retail's.  See the
 * "recon/game/psx/night.cpp" entry in tools/build.py PER_TU_FLAGS.  No source change. */
void Night_SetPlayerHeadLightColor(int player,int colorIndex,int bright)

{
  Night_CreateNightTable(colorIndex,Night_gPlayerHeadLightColor[player],bright,Night_gPlayerLightingTable);
  return;
}

/* ---- Night_InitCopLightColors__Fv  [NIGHT.CPP:507-515] SLD-VERIFIED ---- */
void Night_InitCopLightColors(void)

{
  if (Night_gCopLightingTableRed == (u_char (*) [256] [8])0x0) {
    Night_gCopLightingTableRed = reservememadr("CopRed",0x800,0);
  }
  if (Night_gCopLightingTableBlue == (u_char (*) [256] [8])0x0) {
    Night_gCopLightingTableBlue = reservememadr("CopBlue",0x800,0);
  }
  return;
}

/* ---- Night_SetCopLightColors__Fii  [NIGHT.CPP:519-527] SLD-VERIFIED ---- */
void Night_SetCopLightColors(int colorIndex,int brighten)

{
  
  Night_CreateNightTableElement(colorIndex,0x602020,brighten,
             (*Night_gCopLightingTableBlue)[colorIndex] + (brighten >> 1));
  Night_CreateNightTableElement(colorIndex,0x101054,brighten,
             (*Night_gCopLightingTableRed)[colorIndex] + (brighten >> 1));
  return;
}

/* ---- Night_InitWeatherTables__Fv  [NIGHT.CPP:532-540] SLD-VERIFIED ---- */
/* NEAR-MISS 6 diffs, insn count now EXACT 33/33 (was 20 diffs at 35/33).  Residual 2 is
 * GONE: the old note's "Night_gWeatherColor[0]/[1] per-element gp-rel = confirmed
 * toolchain floor, NOT source-reachable" verdict was WRONG.  The proven TU-wide -G8
 * identity lets the real Night_gWeatherColor[2] array reproduce both %gp_rel stores.
 * REMAINING 6: the oracle materializes Night_gWeatherLightingTable's
 * base DIRECTLY into s0 (`lui s0; addiu s0,s0,lo`), ours self-temps via v0 (`lui v0;
 * addiu s0,v0,lo`) -- the sec.3.15 v0-vs-dest register-materialization tie-break, shared
 * with the sibling Night_SetWeatherColors below -- which the sized-[2] array-VIEW fix has
 * since SEALED (it cut this fn 6 -> 4 too; see that fn's note).  What is LEFT here is the
 * same self-temp materialization surviving the shape fix because the `wtnight` string
 * literal (D_8013DA18) competes for the slot: ours `lui v0,%hi; sw s0,16(sp); addiu
 * s0,v0,%lo`, retail `sw s0,16(sp); lui s0,%hi; addiu s0,s0,%lo`.  Survives -G8 and all
 * four wired per-TU
 * codegen flags (w39-a9 probe: no_split_addresses +4, no_schedule_insns +6,
 * no_schedule_insns2 +14, no_strength_reduce 0). */
/* SEALED 33/33 PASS (w41-a7).  The w40 note called the residual 4 an untouchable
 * "callee-save emission-order tie-break" -- it was NOT: the recon carried TWO FABRICATED
 * locals.  The SYM 8c block (nfs4-f-v3.txt:43c5b0) declares exactly ONE named local for
 * this function, `i` = REG $0x11 = $s1, inside a NESTED block (Block start line 1 >
 * Block start line 1 > i > Block end line 6 > Block end line 8) -- there is no
 * `tbl_walk` walking pointer and no `alloc_buf` call-result temp.  Both were compiler
 * artifacts transcribed as C: the walker is loop.c's giv for the index form, and the
 * call result is stored straight through.  Rewriting to the SYM shape (a block-scoped
 * `i`, plain `for (i = 0; i < 2; i++)` index form over the sized [2] array VIEW, and the
 * reservememadr() result assigned directly to the element) makes gcc regenerate the
 * strength-reduced walker AND fixes the prologue order in one edit.  Constant bound 2
 * => gcc rotates the `for` to the oracle's guard-free bottom-tested do-while. */
void Night_InitWeatherTables(void)

{
  {
    int i;

    for (i = 0; i < 2; i = i + 1) {
      if (Night_gWeatherLightingTable[i] == 0) {
        Night_gWeatherLightingTable[i] =
            (u_char (*)[256])reservememadr("wtnight",0x100,0);
      }
    }
  }
  Night_gWeatherColor[0] = 0x574054;
  Night_gWeatherColor[1] = 0x6c4040;
  return;
}

/* ---- Night_SetWeatherColors__Fi  [NIGHT.CPP:544-546] SLD-VERIFIED ---- */
/* SEALED 31/31 PASS (w39-a9).  The prior note certified this as a "GENUINE FLOOR" --
 * the sec.3.15 v0-vs-dest register-materialization tie-break (ours `lui v0; addiu s1,v0,lo`,
 * retail `lui s1; addiu s1,s1,lo`).  It was NOT a floor: it was the DECLARED SHAPE of the
 * two base-walk arrays.  An UNSIZED `extern T g[]` view makes cc1plus emit the `la sym`
 * assembler MACRO, and GNU-as expands that with a separate scratch; giving the view its
 * CORRECT size [2] lets gcc lower the address ITSELF (split-addresses) into the self-temp
 * `lui sN,%hi; addiu sN,sN,%lo` retail uses.  Exactly IDT Ch9's own rule -- "either omit
 * the size or give the CORRECT size" -- read in the OTHER direction from methodology
 * sec.3.12 #5's usual unsized-array lever. */
void Night_SetWeatherColors(int colorIndex)

{
  int i;

  i = 0;
  do {
    Night_CreateNightTableElement(colorIndex,Night_gWeatherColor[i],0xf,
                                  *Night_gWeatherLightingTable[i] + colorIndex);
    i = i + 1;
  } while (i < 2);
  return;
}

/* ---- Night_GenerateAllLightTables__Fv  [NIGHT.CPP:556-625] SLD-VERIFIED ---- */
void Night_GenerateAllLightTables(void)

{
  /* SYM: STAT char[16].  Retail passes colorCreationTable[i] (a dither-ordered brightness
     permutation, D_80120DAC = 00 0F 07 05 0B 0D 03 09 01 0E 0A 04 02 0C 06 08) as the
     BRIGHTNESS argument of BOTH Night_SetPlayerHeadLightColor and Night_SetCopLightColors
     (oracle `addu $v0,$s0,$s4; lbu $s1,0($v0)` then `addu $a2,$s1,zero` / `addu $a1,$s1,zero`);
     the old body passed the raw loop counter -- a REAL BUG (wrong headlight/cop-light
     brightness slot filled for every colour). */
  static char colorCreationTable[16] = {0,15,7,5,11,13,3,9,1,14,10,4,2,12,6,8};

  gNightInitCache = (tNightInitCache *)&Render_gPalettePtr;
  gTableCache = (tCompRGB *)&Render_gPalettePtr;
  Night_gTotalLights = Chunk_numLight;
  {
    int i;

    i = 0;
    do {
      gTableCache[i].r = Chunk_lightTable[i].r;
      gTableCache[i].g = Chunk_lightTable[i].g;
      gTableCache[i].b = Chunk_lightTable[i].b;
      i = i + 1;
    } while (i < 0x100);
  }
  {
    int colorIndex;
    int i;

    colorIndex = 0;
    while (colorIndex < Night_gTotalLights) {
      {
        int i;

        if (GameSetup_gData.Weather == 1) {
          Night_SetWeatherColors(colorIndex);
          i = 0;
        }
        else {
          i = 0;
        }
        while (i < 0x10) {
          int bright;

          bright = colorCreationTable[i];
          Night_SetPlayerHeadLightColor(0,colorIndex,bright);
          if ((GameSetup_gData.cops != 0) && (i < 8)) {
            Night_SetCopLightColors(colorIndex,bright);
          }
          i = i + 1;
        }
      }
      colorIndex = colorIndex + 1;
    }
  }
  {
    int i;

    i = 0;
    do {
      Chunk_lightTable[i].r = gTableCache[i].r;
      Chunk_lightTable[i].g = gTableCache[i].g;
      Chunk_lightTable[i].b = gTableCache[i].b;
      i = i + 1;
    } while (i < 0x100);
  }
  /* the .g/.b components MUST be read through a CVECTOR-typed view, not a byte cast:
     the struct-typed MEM keeps gcc from folding the access into the one-instruction
     %gp_rel(sym+N) assembler macro, so the base address is LICM-hoisted into a register
     and the two components are read as 1($a3)/2($a3) -- exactly the oracle
     (`lui $a3,%hi(sym); addiu $a3,$a3,%lo(sym)` in the preheader, `lbu $v0,0x1($a3)` /
     `lbu $v0,0x2($a3)`), while element [0] stays %gp_rel.  A byte-pointer spelling
     (`*(u_char*)((char*)sym+1)` or `((u_char*)sym)[1]`) gp-rels all three and is 2 short. */
  {
    int i;

    i = 0;
    do {
      Night_gAdditiveHeadlightColor[i].r =
           (u_char)((int)((u_int)(u_char)Night_gPlayerHeadLightColor[0] * i) / 0xf);
      Night_gAdditiveHeadlightColor[i].g =
           (u_char)((int)((u_int)((CVECTOR *)Night_gPlayerHeadLightColor)->g * i) / 0xf);
      Night_gAdditiveHeadlightColor[i].b =
           (u_char)((int)((u_int)((CVECTOR *)Night_gPlayerHeadLightColor)->b * i) / 0xf);
      i = i + 1;
    } while (i < 0x10);
  }
  return;
}

/* ---- Night_InitNightDriving__Fv  [NIGHT.CPP:631-680] SLD-VERIFIED ---- */
void Night_InitNightDriving(void)

{
  char *mem;          /* SYM: the ONLY REG local ($10 = s0) -- it serves TWO roles,
                         first the loadshapeadr buffer then the locateshape result */
  char name [256];    /* SYM: AUTO char[256] @ -0x110 => sp+16 */

  /* ONE `&&` expression, ONE store: the oracle computes the flag in $v0 (`addu
     $v0,zero,zero` in the Time==0 beqz delay slot, xori/sltu otherwise) and stores it
     once at the join, then RE-TESTS Time (same CSE'd $v1) to gate the depth-cue clear
     and RE-LOADS the flag for the early-out.  A leading `= 0` plus an overwrite emits
     two stores; an if/else pair or a ternary both come out 4-7 instructions long
     (measured).  Same lever family as methodology sec.3.12 #7. */
  gNight_renderNight = GameSetup_gData.Time != 0 && GameSetup_gData.commMode != 1;
  if ((GameSetup_gData.Time != 0) && (gNight_renderNight == 0)) {
    /* the whole 4-byte CVECTOR is cleared with ONE word store (oracle
       `sw $zero,0xF0($v0)`), not four `sb`s; distance is an int at +0xF4
       (`sw $v1,0xF4($v0)`).  Per-field byte clears cost 4 extra instructions. */
    NIGHT_TRACK_DEPTH_CUE_DISTANCE = 0xff;
    NIGHT_TRACK_DEPTH_CUE_COLOR_WORD = 0;
  }
  if (gNight_renderNight == 0) {
    return;
  }
  sprintf(name,"%snight.psh",Paths_Paths[0x19]);
  /* no `sz`/`shp` locals: the SYM lists only `mem` and `name`.  Both filesize() results
     are consumed straight out of $v0 (the second one lands in the blockmove arg while
     the loadshapeadr pointer is parked in $s0 from the jal delay slot), and `mem`
     carries the shape buffer BEFORE it carries the locateshape result. */
  nightfile = (char *)reservememadr("night.psh",filesize(name),0);
  mem = (char *)loadshapeadr(name,(void *)0x0);
  blockmove(mem,nightfile,filesize(name));
  purgememadr(mem);
  /* locateshape is 2-arg (recon/eaclib/psx/eacpsxz/locatshp.c: `void *locateshape(void
     *shapefile,int *namekey)`); the oracle sets NO fresh $a2 here -- the old 3rd arg was
     a phantom read of the stale blockmove size. */
  mem = (char *)locateshape(nightfile,(int *)"nght");
  Night_gNightTbl = mem + 0x10;
  Night_InitPlayerHeadLightColor(0);
  if (GameSetup_gData.cops != 0) {
    Night_InitCopLightColors();
  }
  if (GameSetup_gData.Weather == 1) {
    Night_InitWeatherTables();
  }
  Night_GenerateAllLightTables();
  if (GameSetup_gData.Weather == 1) {
    Night_gLightning = 0;
    Night_gNextLightning = D_8011E0B0[0] + (random() & 0x1ff);
    Night_gEndNextLightning = Night_gNextLightning + (random() & 0x31);
    Night_gNextFlicker = Night_gNextLightning;
    Hrz_CalculateLightning();
  }
  return;
}

/* ---- Night_KillNightDriving__Fv  [NIGHT.CPP:687-719] SLD-VERIFIED ---- */
/* SEALED 40/40 PASS (w39-a9).  The prior note certified the last two purge-blocks as a
 * "confirmed toolchain floor" (gp-rel-INTO-an-array-ELEMENT, catalog sec.E / Hud_Reset)
 * because Night_gWeatherLightingTable is ALSO indexed with a runtime variable in
 * draww.cpp.  That was WRONG: under the proven -G8 identity the real
 * Night_gWeatherLightingTable[2] declaration reproduces both constant-index %gp_rel
 * stores and the runtime base walk directly. */
void Night_KillNightDriving(void)

{
  if (nightfile != (char *)0x0) {
    purgememadr(nightfile);
  }
  nightfile = (char *)0x0;
  if (Night_gPlayerLightingTable != (u_char (*) [256] [16])0x0) {
    purgememadr(Night_gPlayerLightingTable);
  }
  Night_gPlayerLightingTable = (u_char (*) [256] [16])0x0;
  if (Night_gCopLightingTableRed != (u_char (*) [256] [8])0x0) {
    purgememadr(Night_gCopLightingTableRed);
  }
  Night_gCopLightingTableRed = (u_char (*) [256] [8])0x0;
  if (Night_gCopLightingTableBlue != (u_char (*) [256] [8])0x0) {
    purgememadr(Night_gCopLightingTableBlue);
  }
  Night_gCopLightingTableBlue = (u_char (*) [256] [8])0x0;
  if (Night_gWeatherLightingTable[0] != (u_char (*) [256])0x0) {
    purgememadr(Night_gWeatherLightingTable[0]);
  }
  Night_gWeatherLightingTable[0] = (u_char (*) [256])0x0;
  if (Night_gWeatherLightingTable[1] != (u_char (*) [256])0x0) {
    purgememadr(Night_gWeatherLightingTable[1]);
  }
  Night_gWeatherLightingTable[1] = (u_char (*) [256])0x0;
  return;
}

/* ---- Night_RestartNightDriving__Fv  [NIGHT.CPP:723-730] SLD-VERIFIED ---- */
void Night_RestartNightDriving(void)

{
  if ((GameSetup_gData.Weather == 1) && (GameSetup_gData.Time != 0)) {
    Night_gLightning = 0;
    Night_gNextLightning = NIGHT_GAME_TICKS + (random() & 0x1ff);
    Night_gEndNextLightning = Night_gNextLightning + (random() & 0x31);
    Night_gNextFlicker = Night_gNextLightning;
    Hrz_LightningFlicker(0);
  }
  return;
}

/* ---- Night_SetEnviroment__FP13DRender_tView  [NIGHT.CPP:736-804] SLD-VERIFIED ----
 * NEAR-MISS 8 diffs, COUNT-EXACT 68/68.  ONE register-materialization tie in the
 * camera-flag guard: retail `lw $v0,0x4($v0)` (load dest REUSES its own base = self-temp)
 * + `addiu $v1,$zero,0x80` for the Night_gZNear constant; ours takes `lw v1,4(v0)` +
 * `li v0,128`, i.e. the constant's pseudo wins $v0 and pushes the loaded `.target`
 * pointer to $v1.  SYM block @43c9fa: fsize 24, mask $80010000 (s0 + ra only), Vi
 * REGPARM $10 = s0, and NO named locals at all -- so there is nothing left to wire in
 * (the `int mode;` here is an unused recon leftover; deleting it is diff-neutral, kept
 * only to document that it is not the lever).
 * STRONG FLOOR (w39-a9): 7 alternate source forms, ALL byte-identical at 8 diffs --
 * delete `mode` (8) · named `u_char *target` local before the guard (8) · same local
 * declared before the Night_gZNear store (8) · `(char *)`-based byte cast (8) ·
 * Night_gZNear store hoisted above the two shift stores (16, worse) · store folded into
 * the guard via a comma expression (11 at 69 insns, worse) · plus -G8 and all four wired
 * per-TU codegen flags (no_split_addresses 31, no_schedule_insns 33, no_schedule_insns2
 * 22, no_strength_reduce 8 -- all >= current).  Prototype re-checked vs the raw oracle:
 * single REGPARM $a0 (Vi), VOID return ($v0 holds the last guard byte at the exit). */
/* NEAR-MISS 8 diffs, COUNT-EXACT 68/68 (w40-a9): a $v0/$v1 rotation on the
 * `Camera_gInfo[Vi->player].target` load -- ours `lw $v1,4($v0)` (separate temp) + `li
 * $v0,128`, retail `lw $v0,4($v0)` (SELF-temp, dest reuses the just-computed base) + `li
 * w46-a9 (re-gated 8, count-exact 68/68).  Ran the w44/w45 ALLOCNO-DIAL kit against it
 * -- 14 further spellings, ALL >= 8: named `tgt` local (8) · zero-insn USE fence on tgt
 * x1/x2, before/after the store (8/8/8) · tgt read before vs after the store (8/8) ·
 * no-op re-mask `(u_char*)(u_int)tgt` (8) · naming the 0x80 constant in a local before
 * the guard (8) or storing it after the guard (12) · `do{}while(0)` depth-1/-2 wrappers
 * on the tgt read (10 / 12) · wrapper on the whole guard (7 but 69 insns) · wrapper on
 * the gZNear store (7 / 69) · bare fence between store and guard (7 / 69).
 * 🔑 NEW NAMED ANGLE (the signal in that data): the ref dial DOES reach these two
 * quantities -- inflating the TARGET pointer's refs moved the output (8 -> 10/12) -- but
 * in the WRONG direction, so the reachable side is the CONSTANT, not the pointer, and it
 * needs an inflator that does NOT emit a NOTE_INSN_LOOP_BEG (every do{}while(0) here
 * costs +1 insn because the barrier splits the store group).  Next instrument: run
 * prio.py/-dl on this fn to read the two qty priorities, then reqdelta --want the swap;
 * a zero-insn ref ADD on the 0x80 value (e.g. a second consumer of the same constant
 * that cse folds) is the untried inflator class.
 * Falsified earlier: hoisting `Night_gZNear = 0x80;` above the two shift assignments
 * (16, worse), and two other spellings of the target byte read (`((u_char*)t)[0x447]`,
 * `*(u_char*)((char*)t+0x447)`) -- both byte-identical at 8.  Sec.3.15 scratch-register
 * ---- w51-a10 (2026-08-09): 8 STAYS, count-exact 68/68; 8 MORE falsifications, and
 * the w50 "NON-BARRIER qty-order device" requirement is now MEASURED AND MET WITHOUT
 * MOVING THE TIE.  The w47 OPACITY fence `__asm__("" : "=r"(tgt) : "0"(tgt))` on a
 * named `tgt` local, placed BEFORE the Night_gZNear store, is confirmed ZERO-INSN and
 * NON-BARRIER here (68 insns preserved, unlike every do{}while(0) wrapper) -- but the
 * gate is 8, byte-identical to the plain `tgt` local control.  So its +2 refs do NOT
 * reach this pair's local-alloc QTY priority.  Placed AFTER the store it reproduces
 * the w50 fence result exactly (5 @69: the tie moves, the barrier buys the nop).
 * Two stacked opacity fences before the store: 8.  Also falsified, all 8 @68: the
 * guard operand order `(4 & byte)` . the guard flag hoisted into its own u_int temp .
 * a volatile-cast Night_gZNear store.  And 20 @68 for routing BOTH gZNear stores
 * through one `mode` variable (the "make the constant a cross-block global allocno"
 * angle -- the second store sits after a call, so the pseudo re-colors the fn).
 * => the reachable dial is still a zero-insn ref/live change on the POINTER qty that
 * survives cse; the instrumented-cc1 [qty_compare] trace is the next instrument.
 * tie-break class.
 * w49-a5 -- MECHANISM READ OFF THE -dl DUMP, and it is a LOCAL-ALLOC (qty) tie, not a
 * global allocno one.  Block 4 carries ~13 qtys (so the 3-QTY hand-rolled path does NOT
 * apply -- it is the qsort/QTY_CMP_PRI path).  The two rivals are:
 *    reg 105 = the `.target` pointer   : "used 2 times across 4 insns in block 4"
 *    reg  96 = the 0x80 constant       : "used 2 times across 4 insns in block 4"
 * QTY_CMP_PRI = (floor_log2(refs)*refs - size) / (death-birth) = (1*2 - 4)/4 = -0.5 for
 * BOTH -> an exact tie, resolved by qty NUMBER.  NOTE THE SIGN: with 2 refs the numerator
 * is NEGATIVE, so for this pair a LONGER live range RAISES priority and MORE refs raises
 * it a lot (3 refs -> -1/4; 4 refs -> +4/4).  The only reachable wins are therefore
 * (a) a ZERO-INSN third reference on the pointer, or (b) shortening the CONSTANT's live
 * range below the pointer's.  Falsified this wave (all re-gated, all byte-identical 8 at
 * 68/68 unless noted): the `tgt` local hoisted to the top of the store group / after the
 * gXDistShift store / immediately before the gZNear store (sched1 canonicalizes the load's
 * position, so none of them actually lengthen the live range); a second `tgt[0x447]` read
 * inside the if-arm (12 -- a real extra insn, not a free ref); Night_gZNear stored through
 * a sized `[1]` asm-label view (12) and through an unsized `[]` view (13, +1 insn).
 * OPEN, NAMED: a zero-insn ref inflator for a POINTER pseudo (the w44 re-mask trick has no
 * pointer form that survives tree-level folding, and every do{}while(0) wrapper here costs
 * the +1 insn its NOTE_INSN_LOOP_BEG barrier splits out of the store group).
 * w50-a5 -- the w45 USE-FENCE WALK (the instrument that sealed Hrz_InitSky this wave) run
 * over this fn: a named `tgt` local + a zero-insn `__asm__("" : : "r"(tgt))` walked
 * statement-by-statement through all 13 positions of the body.  Results (diffs @insns):
 *   p1 20@68 - p2 12@68 - p3 8@68 - p4 5@69 - p5 9@69 - p6 8@68 - p7 8@68 - p8 8@68 -
 *   p9 31@71 - p10 31@71 - p11 32@70 - p12 34@70 - p13 22@70   (control: tgt local = 8@68)
 * BEST = position 4 (between the `Night_gZNear = 0x80;` store and the camera-flag guard):
 * 5 diffs, and the residual there is ONLY `sw v0,0(gp); li v0,128; nop` vs the oracle's
 * `li v1,128; sw v1,0(gp)` -- i.e. the tie IS reachable, but the fence's own scheduling
 * barrier splits the store group and buys a `nop`, so the count goes 68 -> 69.  ⇒ the
 * requirement is now sharp: a device that changes the two qtys' ORDER *without* being a
 * sched barrier.  Also falsified this wave, all byte-identical 8@68: all SIX permutations
 * of the three-store group (XZN 8 - XNZ 10 - ZXN 16 - ZNX 16 - NXZ 16 - NZX 14, so the
 * shipped XZN order is already optimal), and a named `p_ = Vi->player;` index local. */
/* ---- w61-a14 (2026-08-15): 8 -> 6 diffs, count still EXACT 68/68.  THE 5-WAVE
 * "STRONG FLOOR" IS BROKEN, and by the dial the w49/w50/w51 receipts named but never
 * found a device for.  The w49 -dl reading is confirmed correct: this is a LOCAL-ALLOC
 * QTY tie between reg105 (the `.target` pointer) and reg96 (the 0x80 constant), both
 * "used 2 times across 4 insns", both QTY_CMP_PRI -0.5, resolved by qty NUMBER.  The
 * three named escapes were (a) a zero-insn third ref on the pointer, (b) shortening the
 * constant's live range, (c) "a device that changes the two qtys' ORDER without being a
 * sched barrier".  (c) EXISTS: give the constant its own local and LAUNDER it --
 *     int zn;  ...  zn = 0x80;
 *     __asm__("" : "=r"(zn) : "0"(zn));
 *     Night_gZNear = zn;
 * Per catalog 12E the identity fence makes the pseudo die TWICE, so combine_regs refuses
 * and the constant leaves local-alloc's qty pool for a GLOBAL allocno -- the tie it was
 * losing simply stops existing.  Zero-insn (68/68 preserved, unlike every do{}while(0)
 * wrapper), and the `.target` pointer now takes retail's self-temp $v0.
 * ⚠️ NOTE the w51 receipt below reports an opacity fence on a `tgt` POINTER local as
 * neutral (8) -- that is the SAME device applied to the WRONG side of the tie.  The
 * reachable side was the CONSTANT all along, exactly as the w46 "the reachable side is
 * the CONSTANT, not the pointer" note guessed.
 * Falsified this pass, from the new basin: launder placed AFTER the store (11 @69);
 * `int zn = 0x80;` as a decl-with-init (12); the same launder on a `tgt` pointer local
 * (5 diffs but 69 insns -- +1, rejected); both launders together (7 @69).
 * RESIDUAL 6 = a pure sched1 position pair: retail materializes `li v1,128` LATE, one
 * slot before its `sw`, while our global allocno is born at the source assignment and
 * lives ~10 slots; retail's `sw v0,0(gp)` for gZDistShift=12 likewise sits 2 slots later.
 * Next dial = whatever keeps the constant's birth adjacent to its store WITHOUT putting
 * it back in the qty pool. */
/* ---- w63-a13 (2026-08-15): 6 -> 2 diffs, count still EXACT 68/68, and EVERY REGISTER
 * AND EVERY SCHEDULE POSITION NOW MATCHES except one adjacent pair.
 * 🔴 FIRST: a LAW CORRECTION that invalidates the arithmetic in the w49/w50/w51 blocks
 * above.  gcc-2.8.1 local-alloc.c:1727 and global.c:600 both read
 *     floor_log2(refs) * refs * SIZE / live_length          (size MULTIPLIES)
 * NOT `floor_log2(refs)*refs - SIZE` (the w45 "correction" that the catalog carries and
 * that the w49-a5/w50-a5 notes below build on).  Consequences here: the two rivals are
 * NOT at -0.5 each, they are at (1*2*4)/4 = +2.0 each -- still an exact tie resolved by
 * qty NUMBER, so the w49 CONCLUSION survives -- but "for this pair a LONGER live range
 * RAISES priority" is FALSE.  Shorter live and MORE refs both raise priority, normally.
 * THE LANDED SHAPE (each half measured separately; both are required):
 *   u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;   <- the pointer NAMED and
 *   int zn2 = 0x80;                                               read BEFORE the store
 *   __asm__("" : : "r"(zn2));                                  <- read-only fence on the
 *   Night_gZNear = zn2;                                           CONSTANT, before the sw
 *   if ((tgt[0x447] & 4) != 0) { ... }
 * WHY IT IS NOT THE w50 USE-FENCE WALK: that walk fenced the POINTER and its best
 * position (p4, between the store and the guard) cost the +1 nop because the fence sat
 * BETWEEN the store group and the guard, so the store could no longer sink into the
 * `lw v0,4(v0)` load-delay slot.  Here the fence sits BEFORE the store, so the whole
 * store group is still free to sink -- 68 insns preserved.
 * LADDER (all re-gated by me, all 68/68 unless noted):
 *   plain (no device)                                    8
 *   w61 constant identity-launder alone (previous ship)  6
 *   named tgt + RO fence on tgt at the guard             5 @69  (the w50 p4 result)
 *   named tgt (no fence) + w61 launder                   6
 *   named tgt + RO fence on tgt BEFORE the store + launder  4
 *   named tgt + ONE fence carrying BOTH tgt and zn2      2
 *   named tgt + RO fence on zn2 only  (LANDED)           2      <- simplest 2
 * FALSIFIED from the 2-diff basin (all re-gated): fence operand order swapped (2, bit-
 * identical) . split decl/assign (2) . `__volatile__` flavour (2) . extra "r"(tgt) or
 * "r"(zn2) operands (2) . `"i"(0)` void-tail operand added (2) . dropping the dead
 * `int mode;`/`int zn;` decls (2) . fence moved AFTER the store (5 @69) . zn2 declared
 * before tgt (4) . TWO separate fences, one per value (8 -- the second barrier re-pins
 * the store group) . the constant left inline with only tgt fenced (2 -- equivalent) .
 * dropping the `tgt` local and fencing only zn2 (6 -- THE POINTER LOCAL IS LOAD-BEARING)
 * . hoisting the guard byte into an `int flg` before the store (9 @67) .
 * `"r"(tgt[0x447])` as the fence operand (1 diff @69 -- count-INEXACT, rejected by the
 * bar; recorded because it shows the last pair IS reachable).
 * RESIDUAL 2 = a pure sched2 ISSUE-ORDER pair of two independent insns:
 *   ours   ... addu v0,v0,v1 ; li v1,128     ; lw v0,4(v0) ; sw v1,0(gp) ; lbu ...
 *   retail ... addu v0,v0,v1 ; lw v0,4(v0)   ; li v1,128   ; sw v1,0(gp) ; lbu ...
 * i.e. retail issues the .target LOAD first (its result is consumed 3 slots later by the
 * lbu, so the li+sw cover the load delay); ours issues the `li` first.  Both are legal
 * and the register map is identical.  NAMED NEXT ANGLE: the fence is a sched fixpoint --
 * everything before it cannot sink past.  A device that puts the `li` AFTER the tgt load
 * in the pre-fence group without adding an insn (the `"r"(tgt[0x447])` operand does it
 * but costs one) is the whole remaining gap. */
/* w78-root: a volatile-qualified `camera_info` member read keeps the exact `lw 4(v0)` form but is
 * schedule-neutral (2 @68).  A volatile pointer-object view DOES move the load before `li`, but
 * GCC folds the member address into the base and emits `lw v0,0(v0)` (still 2 @68).  An empty
 * memory-input dependency on the member restores the old v0/v1 allocation basin (8 @68).  All
 * three were reverted; volatility cannot independently buy both the offset form and issue order.
 * W79 follow-up deliberately took the higher-count route: fencing `tgt[0x447]` moves the target
 * load before `li` but emits a duplicate byte load (1 diff @69).  Naming that byte removes the
 * duplicate and keeps 68 instructions, but then the ZNear store schedules after the byte load
 * (2 diffs).  Moving the named byte back after the store returns exactly to this 2-diff basin.
 * Thus the load-order half is source-reachable, but the same fence boundary blocks the required
 * store/byte-load order; every temporary spelling was reverted. */
/* 🏆 W80 source-only PASS (2026-08-26): qtytrace exposed the missing source dial.
 * The natural `tgt` load plus five zero-insn read-only uses changes its block-local qty
 * from refs/live 2/8 to 7/18 (PRI 0.7777), just crossing `zn2` at 3/4 (PRI 0.7500).
 * That gives tgt $v0 and zn2 $v1 exactly as retail and, because all five uses sit at the
 * same boundary, issues `lw v0,4(v0)` before `li v1,128`.  Verified source-only PASS
 * 68/68 repeatedly and strict-branch clean.  The historical text-move receipt below is
 * retained only as provenance; it is no longer required or authoritative.
 */
/* ===== HISTORICAL w64-a13 (2026-08-15): PASS was formerly available via one text move.
 * The residual is a PURE ONE-LINE RELOCATION (the 12F/15D mechanism class), probe-verified
 * TWICE with tools/vprobe.py + W60_TEXT_MOVES_FILE and CLEAN under
 * scratchpad/w64a13/strict_branch.py (5 branch words compared).  Control (no row) = 2.
 * ORCHESTRATOR WIRING SPEC -- build.py PER_FN_TEXT_MOVES (row file kept at
 * scratchpad/w64a13/tm_night.json so it can be replayed):
 *
 *   "recon/game/psx/night.cpp": {
 *       "Night_SetEnviroment__FP13DRender_tView": [
 *           {"take":  r"\tlw\t\$2,4\(\$2\)\n(?= \#APP\n \#NO_APP\n\tsw\t\$3,Night_gZNear\n)",
 *            "after": r"\taddu\t\$2,\$2,\$3\n(?=\tli\t\$3,128)"},
 *       ],
 *   },
 *
 * Both anchors are LOOKAHEAD-PINNED per the 15D anchor law, use NUMERIC registers, and are
 * label-agnostic; each matches exactly once in the fn region.
 * SEMANTICS (15D mandate -- a count-exact gate-PASS splice CAN be a dead-code bug, so this
 * was checked by hand): the moved `lw $2,4($2)` reads $2 (just written by the anchor addu)
 * and writes $2; the line it hops over is `li $3,128`, which writes $3.  The anchor addu
 * READ $3 and already executed; the `sw $3,Night_gZNear` that consumes $3 still follows the
 * `li`.  No def/use edge is crossed in either direction -- the swap is a pure scheduling
 * permutation of two independent insns, exactly as retail emits them.
 * WHY NO SOURCE LEVER: the 12H LAUNCH-BOOST rule predicts `li $3,128` wins the ready-list
 * tie because `zn2 = 0x80` is a BIRTHING set (REG_N_SETS == 1) while the load's dest is
 * multiply-set.  The zero-insn way to give zn2 a second set is the IDENTITY LAUNDER, which
 * the w63 falsification list never tried in this basin -- executed here and FALSIFIED, all
 * @68/68: identity launder replacing the RO fence 6 . identity + RO fence 2 (no change) .
 * RO then identity 8 . identity after the store 8 . split decl + identity 6 . identity on
 * zn2 + an RO fence on tgt 2 . RO fence on tgt only 2 . identity launder on tgt 8.
 * => This conclusion is superseded by the W80 qtytrace source-level PASS above. */
void Night_SetEnviroment(DRender_tView *Vi)

{
  if (GameSetup_gData.Time != 0) {
    Night_gDrawLightning = '\0';
    Night_gCurrentNightColor = Night_gPlayerLightingTable;
    if ((GameSetup_gData.Weather == 1) &&
       (Night_PauseLightningEffect(Vi->player), Vi->player == 0)) {
      Night_DoLightningEffect(Vi);
    }
    Night_gXDistShift = 10;
    Night_gZDistShift = 0xc;
    /* MATCH (w63-a13): 6 -> 2, count still EXACT 68/68.  See the w63-a13 block
     * above the function for the mechanism and the falsification list. */
    u_char *tgt /* SYM-CODEGEN-CARRIER: tgt -- direct target access is FAIL 6 (68/68) */ =
        (u_char *)NIGHT_CAMERA_TARGET(Vi->player);
    /* W80 QTY_CMP_PRI dial: five zero-byte refs are the minimal whole-step crossing
     * for tgt (7/18) over zn2 (3/4); four refs only tie at 0.7500 and stay FAIL.
     * W86-D2: FOUR of the five zero-byte references are now PURE C -- the ABSORPTION
     * IDENTITY `X | (X & 3) == X`.  It is a real RTL insn that fold() cannot remove
     * (variable operand), so cse/loop/flow see it and count the reference, and
     * `combine` collapses `(ior X (and X K))` back to X at ZERO BYTES.
     * Measured (whole-TU gate, Night_SetEnviroment, 68/68 count-exact throughout):
     *   all 5 fences (old baseline) ....................... PASS
     *   1 fence + 4 absorptions (LANDED) .................. PASS
     *   0 fences + 1..4 absorptions, every subset (32 cells) .. 8
     *   0 fences at all ................................... 8
     * So the FIRST reference must still be the asm one: an absorption also SETS the
     * carrier, which splits its live range, and with no fence left the split costs
     * more than the reference buys.  The surviving fence is the irreducible one. */
    __asm__("" : : "r"(tgt));
    tgt = (u_char *)((unsigned int)tgt | ((unsigned int)tgt & 3u));
    tgt = (u_char *)((unsigned int)tgt | ((unsigned int)tgt & 3u));
    tgt = (u_char *)((unsigned int)tgt | ((unsigned int)tgt & 3u));
    int zn2 /* SYM-CODEGEN-CARRIER: zn2 -- direct constant store is FAIL 8 (68/68) */ = 0x80;
    zn2 = (int)((unsigned int)zn2 | ((unsigned int)zn2 & 3u));
    Night_gZNear = zn2;
    if ((tgt[0x447] & 4) != 0) {
      Night_gZDistShift = 0xd;
      Night_gXDistShift = 0xb;
    }
    if (Camera_GetMode(Vi->player) == 0) {
      Night_gZNear = -0x200;
    }
    Night_gXDist = 1 << (Night_gXDistShift);
    Night_gZDist = 1 << (Night_gZDistShift);
    Night_gZDistShift = Night_gZDistShift + -6;
    Night_gXDistShift = Night_gXDistShift + -5;
  }
  return;
}

/* ---- Night_AdditiveNightCalc__FP6VECTORP7CVECTOR  [NIGHT.CPP:811-861] SLD-VERIFIED ----
 * NEAR-MISS 77 diffs (ours 65 / oracle 64).  The ONE extra instruction is a copy of the
 * `color` parameter out of its home register (`addu $t3,$a1,zero` at insn 1): our build
 * gives `xdist` $a1 -- which IS color's home -- so color has to be relocated, and that
 * one decision rotates the whole body.  Retail keeps color in $a1 for the entire
 * function and puts xdist in $a2 (SYM: xdist $6, zfar $6, newB $6, z $3/v1, x $4/a0,
 * znear $7/a3, newR $7, newG $8/t0, index/lookup $2/v0, addColor $3).
 * FALSIFIED (11 shapes, every one re-gates to exactly 77/65 -- byte-identical output):
 * znear/zfar before z; z between them; decl-with-init; xdist before x; zfar-before-znear
 * decl order; z-after-index decl order; `z > znear`; `x > -xdist`; both; `zfar > z`;
 * and swapping the two halves of the `index` expression (81, worse).
 * PROTOTYPE RE-CHECKED against the SYM: 2 REGPARM args (v $4, color $5), void return,
 * fsize 0 / mask 0 (true leaf, which we reproduce).
 * w41-a7: 77 -> 71 via the in-place `x = x + xdist;` (see below), and the -dg/-dl dumps
 * now give the exact mechanism for the rest.  Allocation order (global.c priority
 * floor_log2(refs)*refs/live_length) is  x(4 refs/10 = 0.80) > xdist(4/11 = 0.73) >
 * z(4/16 = 0.50) = zfar(2/4 = 0.50) > znear(4/17) > ... > color(7 refs/120 = 0.117,
 * SECOND-TO-LAST).  Two consequences, and they are the whole 71:
 *  - `v` (allocno 80) carries "preferences: 3 4" ($v1 + its own $a0 home), and
 *    find_reg SKIPS any hard reg a CONFLICTING allocno prefers, so every allocno that
 *    conflicts with `v` (z, zfar, znear, xdist...) is pushed off $v1 and $a0.  x does
 *    NOT conflict with v, so x -- allocated first -- takes $v1.  Retail has x in $a0 and
 *    z in $v1, i.e. retail allocated z BEFORE x; ours cannot, because 4/16 < 4/10.
 *  - with $v1/$a0 skipped, zfar and xdist both land on $a1 -- which is `color`'s
 *    parameter home -- so color, allocated almost last, is evicted to $t3 and pays the
 *    ONE extra instruction (`addu $t3,$a1,zero` at insn 1).  color cannot win $a1 by
 *    priority (it would need >30 refs) and it carries no $a1 preference in our RTL.
 * FALSIFIED this wave on top of the 11 earlier shapes: in-place `z = z - znear;` (83),
 * both in-place (75), and hoisting `x` to the outer block (77).
 * The open route is making `z`'s allocno outrank `x`'s (shorten z's live range below 10
 * insns or lengthen x's past 16) WITHOUT adding instructions -- everything tried so far
 * moves refs, which moves priority the wrong way.
 * w49-a5: FORMULA CORRECTION for anyone re-deriving the above -- allocno_compare's
 * numerator is `floor_log2(refs)*refs - SIZE`, not `floor_log2(refs)*refs`.  With size 4
 * that gives x 4/10 = 0.40, xdist 4/11 = 0.36, z 4/16 = 0.25, znear 4/17 = 0.235,
 * zfar (2 refs) = -2/4 = -0.50, color 10/120 = 0.083 -- same ORDER as the receipt above,
 * but note zfar's numerator is NEGATIVE (2 refs, size 4), so for any 2-ref pseudo in this
 * fn a LONGER live range RAISES priority.  Attacked the "lengthen x past 16" route
 * directly (all re-gated): `x` hoisted to fn scope and read right after z (80 / 66 insns),
 * before z (80 / 66), after zfar (80 / 66) -- each ADDS an insn because the vx load then
 * runs on the z-guard's failing path too.  `x` AND `xdist` both hoisted to fn scope and
 * computed before the znear/zfar chain is COUNT-EXACT 64/64 for the first time (80 LCS
 * diffs) but structurally wrong: the oracle computes the whole zfar chain and takes the z
 * guard BEFORE touching v->vx, so the early-x form re-orders the entire head (posdiff
 * alpha-LCS 7/64).  ⇒ x's live range cannot be lengthened from the front without moving
 * the load; the remaining route is SHORTENING z's (16 -> <10) from the back.
 * w50-a5 -- BOTH remaining routes attacked and CLOSED at zero insns; all 19 probes below
 * re-gate to exactly 71 @65/64 (byte-identical output unless noted):
 *  (a) SHORTEN z FROM THE BACK: re-reading `v->vz` for the index term instead of holding
 *      `z` (so z would die at the guard) is a no-op -- cse re-CSEs the second load back
 *      onto the first, live length unchanged.  Same with znear/zfar-before-z (71),
 *      z-between-them (71), `(z > znear) && (zfar > z)` (71), and zfirst+reread (71).
 *      NOTE these three shapes were falsified at 77 in the w39 basin; re-tested here
 *      because falsifications are basin-relative -- they are still falsified at 71.
 *  (b) PROMOTE z BY REFS: with the corrected numerator `floor_log2(refs)*refs - size`,
 *      z (4 refs/16 live) = 0.25 must pass x (4/10) = 0.40, i.e. z needs 6 refs (8/16 =
 *      0.50).  A zero-insn read-only fence on z, walked through all 7 statement positions
 *      and with ONE and TWO z operands (14 probes), moves NOTHING at positions 3/4 (71)
 *      and only worsens elsewhere (75/72/75/76, three of them +1 insn) -- and the 1-operand
 *      and 2-operand forms are byte-identical everywhere, so a duplicate asm operand does
 *      NOT buy a second REG_N_REF here.  ⇒ the ref dial does not reach z in this fn.
 * REMAINING NAMED ROUTE (untried, and the only one the model leaves): DEMOTE x by shedding
 * one of its 4 refs -- (1*3-4)/10 = -0.10 falls below z's 0.25 in one step, because 3 refs
 * put x's numerator NEGATIVE.  Needs a zero-insn ref DELETER for x (the w45 store-read-back
 * class; it is what took Night_CreateNightTableElement 56 -> 38 this same wave). */
/* ---- w61-a14 (2026-08-15): 71 -> 59 diffs @65/64.  The standing verdict above says the
 * ONLY route left is 'a zero-insn ref DELETER for x'.  That route is now FALSIFIED in
 * three shapes (all re-gated): guard reads `v->vx` directly with x born as the sum (75);
 * a separate `xb` for the biased value (75); one unsigned range check
 * `(u_int)(x+xdist) < (u_int)(xdist+xdist)` replacing the two compares (73 @63 -- it does
 * shed the ref, and the fn gets SHORTER than the oracle, so the ref model was right about
 * the mechanism and wrong about the payoff).  A read-only fence on `z` after the z-guard
 * = 76 @66.
 * WHAT WORKED instead is the OTHER end of the same tie -- a zero-insn CSE-OPAQUE IDENTITY
 * LAUNDER ON THE `color` PARAMETER, placed as the FIRST statement of the function:
 *     __asm__("" : "=r"(color) : "0"(color));
 * 71 -> 59, count unchanged at 65.  Per catalog 12E an identity fence makes the pseudo
 * die TWICE, so combine_regs refuses to merge it into the parameter copy and `color`
 * becomes a GLOBAL allocno assigned by CONFLICT rather than by the priority scan that was
 * dropping it to second-to-last.  The whole head/index chain now colours like retail
 * (a3/v1/a2 -> the oracle's a3/v1/a2); the residual is the surviving `addu a3,a1,zero`
 * copy (still our one extra insn) plus a scheduling spread in the shift/sum block.
 * POSITION IS THE DIAL, again: before `z = v->vz;` = 59, AFTER it = 63, inside the
 * innermost block = 62 @66, doubled = 61, plus a 1-operand read-only fence = 61.
 * Also falsified this pass: identity launders on `x` (72 @66), `z` (75), `xdist` (75),
 * and a block-local `CVECTOR *c = color;` copy used for all six field accesses (71). */
/* ---- w63-a13 (2026-08-15): 59 STAYS @65/64.  🔴 LAW CORRECTION FIRST -- the w49-a5
 * "FORMULA CORRECTION" above is ITSELF WRONG, and everything derived from it in this
 * block (and in HrzSetPsxMatrix's w50-a5 block) must be re-derived.  gcc-2.8.1
 * global.c:600 (allocno_compare) and local-alloc.c:1727 (QTY_CMP_PRI) both read
 *     floor_log2(refs) * refs * SIZE / live_length            <- size MULTIPLIES
 * There is no `- SIZE` term anywhere in either file.  Consequences for THIS fn (size 4
 * throughout, so the ORDER the w41-a7 dump printed is unchanged -- only the derived
 * "how far away is the flip" arithmetic changes, and it changes a lot):
 *     x 2*4*4/10 = 3.20 > xdist 32/11 = 2.91 > z 32/16 = 2.00 = zfar 1*2*4/4 = 2.00
 *     > znear 32/17 = 1.88 > color 2*7*4/120 = 0.47
 * and CRITICALLY: zfar's numerator is POSITIVE (+8, not -2), so the w49 claim that "for
 * any 2-ref pseudo in this fn a LONGER live range RAISES priority" is FALSE -- shorter
 * live and more refs both raise priority here, with no inversion anywhere.
 * RE-DERIVED TARGETS (the model's real numbers): to allocate z before x, either
 *   (a) DEMOTE x below 2.00: shed one ref (3 refs -> 1*3*4/10 = 1.20) OR stretch x's
 *       live range past 16 (32/17 = 1.88); or
 *   (b) PROMOTE z above 3.20: z needs SEVEN refs (2*7*4/16 = 3.50; six gives 3.00).
 * FALSIFIED THIS PASS (all re-gated; all 65/64 unless noted):
 *   (a) the stretch-and-add-a-ref dial, a zero-insn read-only fence on `x` AFTER its
 *       last use -- at the end of the inner block 79 . before the three colour stores 79
 *       . the same on `xdist` 71 . on both 79 . on `z` 71.  Every one moves the gate the
 *       WRONG way, so the priority model's prediction is not what decides this fn.
 *   (b) the receipt's OWN named mechanism -- "find_reg SKIPS $v1/$a0 because the
 *       conflicting `v` allocno PREFERS them" -- attacked with the device that is
 *       supposed to delete a parm's copy preference (catalog 11A/12E: an asm_operands
 *       def makes global.c set_preference return early).  Identity launder on `v`:
 *       alone 75 . before the color launder 59 (bit-identical) . after it 59
 *       (bit-identical) . both on ONE asm with two tied operands 61 . a read-only fence
 *       on `v` instead 59 (bit-identical) . the v-launder moved below `z = v->vz;` 63.
 *       ⇒ laundering `v` does NOT free $v1/$a0 for z/x; the preference skip survives it.
 * NAMED NEXT ANGLE (untried): retail's x lives in $a0 = `v`'s own home and v is DEAD at
 * `x = v->vx`, i.e. retail's x looks COMBINED with v (local-alloc combine_regs ties a
 * load's dest to a dying source).  Ours cannot combine because `v` spans two blocks
 * (local-alloc.c:1867 refuses a non-block-local source).  So the reachable shape may be
 * to make `v` BLOCK-LOCAL -- read `v->vz` and `v->vx` through the SAME block-scoped
 * pointer copy that dies at the vx load -- rather than to dial priorities at all.  (The
 * w61 block-local `CVECTOR *c = color;` probe was the analogue on the COLOR side; the
 * `v` side has never been tried.)  EXECUTED SAME PASS AND FALSIFIED: a block-scoped
 * `VECTOR *vp = v; x = vp->vx;` inside the z-guard = 59, BIT-IDENTICAL (cse copy-props
 * the pointer copy away, so no new block-local pseudo is ever minted); the same with an
 * identity launder on `vp` = 65.  ⇒ the combine_regs route needs a device that survives
 * copy-propagation, not just a narrower scope. */
void Night_AdditiveNightCalc(VECTOR *v,CVECTOR *color)

{
  int z;
  int index;
  int znear;
  int zfar;

  /* MATCH (W71-A5): the 7-OPERAND read-only fence is a priced floor_log2 REF STEP,
     not scaffolding-by-taste.  With the tail fixed, `color` (p81) is a global allocno
     at 10 refs / 62 live = pri 0.484 and is allocated FIFTH -- after xdist (p93,
     4 refs / 9 = 0.889) and zfar (p85, 0.5), both of which then take $a1 (find_reg's
     pass 1 ignores regs_someone_prefers, so colour's $a1 copy-preference cannot save
     it).  Each read-only fence OPERAND buys exactly +1 REG_N_REF at zero instructions
     (catalog 05C), and colour needs 16 refs to cross the flr2 step that beats 0.889
     (4*16/62 = 1.03 > 0.889); 16 - (10 - 1) = 7 operands.  MEASURED: 1..6 operands =
     31 diffs, SEVEN = PASS 64/64, 8 and 10 also PASS -- take the cheapest.  Allocated
     third, colour takes $a1, xdist/zfar shift to $a2 and newB follows.
     ---- W85-S4 DEVICE PURITY: the 7-operand fence is GONE and the function still
     PASSes 64/64 (whole TU 19/19).  The W71 ref-step was needed against the THEN
     basin; later structural work in this TU moved `color`'s allocno ahead of
     xdist/zfar on its own, so the device had become pure scaffolding.  Re-measured
     2026-09-02: removed = PASS, i.e. no ref step is required any more. */

  z = v->vz;
  znear = Night_gZNear;
  zfar = znear + (1 << (Night_gZDistShift + 6));
  if ((znear < z) && (z < zfar)) {
    int x;
    int xdist;

    x = v->vx;
    xdist = 1 << (Night_gXDistShift + 5);
    if ((-xdist < x) && (x < xdist)) {
      int lookup;
      short newR;
      short newG;
      short newB;
      long addColor;

      /* `x` is mutated IN PLACE: the oracle's `addu $a0,$a0,$a2` reuses x's own
         register for the sum (catalog in-place-mutation lever); the two-operand
         form inside the index expression picks a fresh destination. (77 -> 71)
         W71-A5: `z` is mutated in place the SAME way and the four scalar steps are
         written in the ORACLE'S ISSUE ORDER (subu/srav on z, then addu/srav on x,
         then the sll+addu of the index).  59 -> 53 and it is what puts z in $v1. */
      z = z - znear;
      z = z >> Night_gZDistShift;
      x = x + xdist;
      x = x >> Night_gXDistShift;
      index = (z << 6) + x;
      addColor = *(long *)&Night_gAdditiveHeadlightColor[(u_char)Night_gNightTbl[index]];
      lookup = (int)addColor;
      /* W71-A5 (51 -> 31): the loaded colour byte is assigned INTO its own newX
         variable first, so the byte load and the clamp result are ONE pseudo
         (retail's `lbu $a3,0($a1)` loads straight into newR's home and only the
         SUM lives in a local temp).  Written as `newX = (short)(color->x + ...)`
         the byte load is a separate BLOCK-LOCAL quantity: local-alloc then needs a
         4th register in the tail block and hands it $a1 -- which put hard reg 5
         into `color`'s conflict set (`;; 81 conflicts: ... 5`) and made $a1
         UNREACHABLE for colour under any priority dial.  With the loads folded into
         newR/newG/newB the conflict disappears. */
      newR = color->r;
      newG = color->g;
      newB = color->b;
      newR = (short)(newR + (lookup & 0xff));
      newG = (short)(newG + ((lookup & 0xff00) >> 8));
      newB = (short)(newB + (((u_int)lookup >> 0x10) & 0xff));
      if (0xff < newR) newR = 0xff;
      if (0xff < newG) newG = 0xff;
      if (0xff < newB) newB = 0xff;
      color->r = (u_char)newR;
      color->g = (u_char)newG;
      color->b = (u_char)newB;
    }
  }
  return;
}

/* end of night.cpp */
