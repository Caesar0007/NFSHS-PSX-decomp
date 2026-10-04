/* recon/mod/game/common/trackmod_stack.c -- run a function on the MAIN stack while the simulation is
 * on its 1 KB scratchpad stack.
 *
 *   NFS4 runs the simulation schedules on the scratchpad (Sim_ProcessSimSchedules:
 *   gWSavePtr = SetSp(&gScratchLastWord)); the retail road-query chain
 *   (AIPhysic_Main -> Newton_FindGroundElevationAndNormal [448-byte frame] -> BWorldSm_FindClosestTriangleRez
 *   -> BWorldSm_FindClosestQuadRez -> FindClosestQuad -> RawFindClosestQuad) nearly fills it.  The streaming
 *   veneers that replace BWorld_SetSimSlice / BWorldSm_FindClosestQuadRez may have to load a chunk from the
 *   disc, which needs far more stack than that: on the streamed 01B the scratchpad underflowed to 0x1F7FFFB4,
 *   the saved ra/s-registers read back as 0xFFFFFFFF and the sim returned into -1 (route D, 2026-10-04).
 *
 *   TrackMod_OnMainStack(fn, a0, a1, a2): if $sp is inside the scratchpad (0x1F80xxxx), switch to the main
 *   stack just below the pointer the sim saved in gWSavePtr, call fn(a0, a1, a2), and switch back.  When the
 *   caller is already on the main stack the call is made in place.  ASPSX dialect: numeric registers only.
 */

extern unsigned long gWSavePtr;   /* main-stack $sp saved by Sim_ProcessSimSchedules while the sim runs on the scratchpad */

#if defined(__mips__)

__asm__(
"       .text\n"
"       .set noreorder\n"
"       .set noat\n"
"       .globl TrackMod_OnMainStack\n"
"TrackMod_OnMainStack:\n"
"       addiu   $29, $29, -24\n"
"       sw      $31, 20($29)\n"
"       sw      $16, 16($29)\n"
"       addu    $16, $29, $0\n"          /* remember the caller's stack */
"       addu    $9, $4, $0\n"            /* fn */
"       addu    $4, $5, $0\n"            /* a0 */
"       addu    $5, $6, $0\n"            /* a1 */
"       addu    $6, $7, $0\n"            /* a2 */
"       srl     $10, $29, 16\n"
"       ori     $11, $0, 0x1F80\n"
"       bne     $10, $11, 1f\n"          /* not on the scratchpad: call in place */
"        nop\n"
"       lui     $8, %hi(gWSavePtr)\n"
"       lw      $8, %lo(gWSavePtr)($8)\n"
"       nop\n"
"       addiu   $29, $8, -32\n"          /* main stack, below the frame that switched away */
"1:\n"
"       jalr    $31, $9\n"
"        nop\n"
"       addu    $29, $16, $0\n"          /* back to the caller's stack */
"       lw      $31, 20($29)\n"
"       lw      $16, 16($29)\n"
"       jr      $31\n"
"        addiu  $29, $29, 24\n"
"       .set at\n"
"       .set reorder\n"
);

#else

int TrackMod_OnMainStack(int (*fn)(int, int, int), int a0, int a1, int a2) { return fn(a0, a1, a2); }

#endif
