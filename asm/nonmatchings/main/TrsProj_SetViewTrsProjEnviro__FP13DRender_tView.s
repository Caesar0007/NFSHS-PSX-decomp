.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TrsProj_SetViewTrsProjEnviro__FP13DRender_tView, 0x54

glabel TrsProj_SetViewTrsProjEnviro__FP13DRender_tView
    /* D2208 800E1A08 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D220C 800E1A0C 1180023C */  lui        $v0, %hi(D_801131F8)
    /* D2210 800E1A10 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* D2214 800E1A14 01000224 */  addiu      $v0, $zero, 0x1
    /* D2218 800E1A18 06006214 */  bne        $v1, $v0, .L800E1A34
    /* D221C 800E1A1C 1000BFAF */   sw        $ra, 0x10($sp)
    /* D2220 800E1A20 21200000 */  addu       $a0, $zero, $zero
    /* D2224 800E1A24 21288000 */  addu       $a1, $a0, $zero
    /* D2228 800E1A28 40010624 */  addiu      $a2, $zero, 0x140
    /* D222C 800E1A2C 91860308 */  j          .L800E1A44
    /* D2230 800E1A30 78000724 */   addiu     $a3, $zero, 0x78
  .L800E1A34:
    /* D2234 800E1A34 21200000 */  addu       $a0, $zero, $zero
    /* D2238 800E1A38 21288000 */  addu       $a1, $a0, $zero
    /* D223C 800E1A3C 40010624 */  addiu      $a2, $zero, 0x140
    /* D2240 800E1A40 F0000724 */  addiu      $a3, $zero, 0xF0
  .L800E1A44:
    /* D2244 800E1A44 5286030C */  jal        TrsProj_SetProjection__Fiiii
    /* D2248 800E1A48 00000000 */   nop
    /* D224C 800E1A4C 1000BF8F */  lw         $ra, 0x10($sp)
    /* D2250 800E1A50 00000000 */  nop
    /* D2254 800E1A54 0800E003 */  jr         $ra
    /* D2258 800E1A58 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel TrsProj_SetViewTrsProjEnviro__FP13DRender_tView
