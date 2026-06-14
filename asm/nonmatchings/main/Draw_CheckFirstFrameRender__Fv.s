.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw_CheckFirstFrameRender__Fv, 0x90

glabel Draw_CheckFirstFrameRender__Fv
    /* AEA30 800BE230 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* AEA34 800BE234 6812838F */  lw         $v1, %gp_rel(gFlip)($gp)
    /* AEA38 800BE238 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* AEA3C 800BE23C 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* AEA40 800BE240 1B006214 */  bne        $v1, $v0, .L800BE2B0
    /* AEA44 800BE244 2800B0AF */   sw        $s0, 0x28($sp)
    /* AEA48 800BE248 40010424 */  addiu      $a0, $zero, 0x140
    /* AEA4C 800BE24C 00010524 */  addiu      $a1, $zero, 0x100
    /* AEA50 800BE250 21308000 */  addu       $a2, $a0, $zero
    /* AEA54 800BE254 F0000724 */  addiu      $a3, $zero, 0xF0
    /* AEA58 800BE258 01001024 */  addiu      $s0, $zero, 0x1
    /* AEA5C 800BE25C 1000B0AF */  sw         $s0, 0x10($sp)
    /* AEA60 800BE260 1400A0AF */  sw         $zero, 0x14($sp)
    /* AEA64 800BE264 1800B0AF */  sw         $s0, 0x18($sp)
    /* AEA68 800BE268 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* AEA6C 800BE26C 2000A0AF */  sw         $zero, 0x20($sp)
    /* AEA70 800BE270 1EF9020C */  jal        Draw_DirectSetEnvironment__Fiiiiiiiiii
    /* AEA74 800BE274 2400A0AF */   sw        $zero, 0x24($sp)
    /* AEA78 800BE278 21200000 */  addu       $a0, $zero, $zero
    /* AEA7C 800BE27C 00010524 */  addiu      $a1, $zero, 0x100
    /* AEA80 800BE280 40010624 */  addiu      $a2, $zero, 0x140
    /* AEA84 800BE284 F0000724 */  addiu      $a3, $zero, 0xF0
    /* AEA88 800BE288 1000B0AF */  sw         $s0, 0x10($sp)
    /* AEA8C 800BE28C 1400B0AF */  sw         $s0, 0x14($sp)
    /* AEA90 800BE290 1800B0AF */  sw         $s0, 0x18($sp)
    /* AEA94 800BE294 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* AEA98 800BE298 2000A0AF */  sw         $zero, 0x20($sp)
    /* AEA9C 800BE29C 1EF9020C */  jal        Draw_DirectSetEnvironment__Fiiiiiiiiii
    /* AEAA0 800BE2A0 2400A0AF */   sw        $zero, 0x24($sp)
    /* AEAA4 800BE2A4 681290AF */  sw         $s0, %gp_rel(gFlip)($gp)
    /* AEAA8 800BE2A8 98F7020C */  jal        AllocatePrimitivesBuffer__Fv
    /* AEAAC 800BE2AC 00000000 */   nop
  .L800BE2B0:
    /* AEAB0 800BE2B0 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* AEAB4 800BE2B4 2800B08F */  lw         $s0, 0x28($sp)
    /* AEAB8 800BE2B8 0800E003 */  jr         $ra
    /* AEABC 800BE2BC 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Draw_CheckFirstFrameRender__Fv
