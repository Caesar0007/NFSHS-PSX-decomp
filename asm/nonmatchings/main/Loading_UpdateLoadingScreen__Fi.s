.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Loading_UpdateLoadingScreen__Fi, 0xF8

glabel Loading_UpdateLoadingScreen__Fi
    /* CBA00 800DB200 D8FEBD27 */  addiu      $sp, $sp, -0x128
    /* CBA04 800DB204 1C01B3AF */  sw         $s3, 0x11C($sp)
    /* CBA08 800DB208 21988000 */  addu       $s3, $a0, $zero
    /* CBA0C 800DB20C 1801B2AF */  sw         $s2, 0x118($sp)
    /* CBA10 800DB210 17001224 */  addiu      $s2, $zero, 0x17
    /* CBA14 800DB214 01000224 */  addiu      $v0, $zero, 0x1
    /* CBA18 800DB218 2401BFAF */  sw         $ra, 0x124($sp)
    /* CBA1C 800DB21C 2001B4AF */  sw         $s4, 0x120($sp)
    /* CBA20 800DB220 1401B1AF */  sw         $s1, 0x114($sp)
    /* CBA24 800DB224 0E006216 */  bne        $s3, $v0, .L800DB260
    /* CBA28 800DB228 1001B0AF */   sw        $s0, 0x110($sp)
    /* CBA2C 800DB22C 8414828F */  lw         $v0, %gp_rel(smallShapeFile)($gp)
    /* CBA30 800DB230 00000000 */  nop
    /* CBA34 800DB234 0A004014 */  bnez       $v0, .L800DB260
    /* CBA38 800DB238 1000A427 */   addiu     $a0, $sp, 0x10
    /* CBA3C 800DB23C 1180023C */  lui        $v0, %hi(D_801164CC)
    /* CBA40 800DB240 0580053C */  lui        $a1, %hi(D_80056954)
    /* CBA44 800DB244 CC64468C */  lw         $a2, %lo(D_801164CC)($v0)
    /* CBA48 800DB248 2F91030C */  jal        sprintf
    /* CBA4C 800DB24C 5469A524 */   addiu     $a1, $a1, %lo(D_80056954)
    /* CBA50 800DB250 1000A427 */  addiu      $a0, $sp, 0x10
    /* CBA54 800DB254 0FC7030C */  jal        loadshapeadr
    /* CBA58 800DB258 10000524 */   addiu     $a1, $zero, 0x10
    /* CBA5C 800DB25C 841482AF */  sw         $v0, %gp_rel(smallShapeFile)($gp)
  .L800DB260:
    /* CBA60 800DB260 13004012 */  beqz       $s2, .L800DB2B0
    /* CBA64 800DB264 21800000 */   addu      $s0, $zero, $zero
    /* CBA68 800DB268 1480143C */  lui        $s4, %hi(D_8013D9D4)
    /* CBA6C 800DB26C FFFF6326 */  addiu      $v1, $s3, -0x1
    /* CBA70 800DB270 40100300 */  sll        $v0, $v1, 1
    /* CBA74 800DB274 21104300 */  addu       $v0, $v0, $v1
    /* CBA78 800DB278 C0100200 */  sll        $v0, $v0, 3
    /* CBA7C 800DB27C 23884300 */  subu       $s1, $v0, $v1
  .L800DB280:
    /* CBA80 800DB280 8414848F */  lw         $a0, %gp_rel(smallShapeFile)($gp)
    /* CBA84 800DB284 5CAC030C */  jal        locateshapez
    /* CBA88 800DB288 D4D98526 */   addiu     $a1, $s4, %lo(D_8013D9D4)
    /* CBA8C 800DB28C 21204000 */  addu       $a0, $v0, $zero
    /* CBA90 800DB290 8E000526 */  addiu      $a1, $s0, 0x8E
    /* CBA94 800DB294 21282502 */  addu       $a1, $s1, $a1
    /* CBA98 800DB298 14F9020C */  jal        Draw_DrawDirectScreen__FP8shapetblii
    /* CBA9C 800DB29C C0000624 */   addiu     $a2, $zero, 0xC0
    /* CBAA0 800DB2A0 01001026 */  addiu      $s0, $s0, 0x1
    /* CBAA4 800DB2A4 2A101202 */  slt        $v0, $s0, $s2
    /* CBAA8 800DB2A8 F5FF4014 */  bnez       $v0, .L800DB280
    /* CBAAC 800DB2AC 00000000 */   nop
  .L800DB2B0:
    /* CBAB0 800DB2B0 0A000224 */  addiu      $v0, $zero, 0xA
    /* CBAB4 800DB2B4 08006216 */  bne        $s3, $v0, .L800DB2D8
    /* CBAB8 800DB2B8 00000000 */   nop
    /* CBABC 800DB2BC 8414848F */  lw         $a0, %gp_rel(smallShapeFile)($gp)
    /* CBAC0 800DB2C0 00000000 */  nop
    /* CBAC4 800DB2C4 04008010 */  beqz       $a0, .L800DB2D8
    /* CBAC8 800DB2C8 00000000 */   nop
    /* CBACC 800DB2CC 5095030C */  jal        purgememadr
    /* CBAD0 800DB2D0 00000000 */   nop
    /* CBAD4 800DB2D4 841480AF */  sw         $zero, %gp_rel(smallShapeFile)($gp)
  .L800DB2D8:
    /* CBAD8 800DB2D8 2401BF8F */  lw         $ra, 0x124($sp)
    /* CBADC 800DB2DC 2001B48F */  lw         $s4, 0x120($sp)
    /* CBAE0 800DB2E0 1C01B38F */  lw         $s3, 0x11C($sp)
    /* CBAE4 800DB2E4 1801B28F */  lw         $s2, 0x118($sp)
    /* CBAE8 800DB2E8 1401B18F */  lw         $s1, 0x114($sp)
    /* CBAEC 800DB2EC 1001B08F */  lw         $s0, 0x110($sp)
    /* CBAF0 800DB2F0 0800E003 */  jr         $ra
    /* CBAF4 800DB2F4 2801BD27 */   addiu     $sp, $sp, 0x128
endlabel Loading_UpdateLoadingScreen__Fi
