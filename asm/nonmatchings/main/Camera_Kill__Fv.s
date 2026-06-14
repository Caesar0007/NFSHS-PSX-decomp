.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Camera_Kill__Fv, 0x88

glabel Camera_Kill__Fv
    /* 743EC 80083BEC 1180023C */  lui        $v0, %hi(D_801131F8)
    /* 743F0 80083BF0 F831428C */  lw         $v0, %lo(D_801131F8)($v0)
    /* 743F4 80083BF4 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 743F8 80083BF8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 743FC 80083BFC 21880000 */  addu       $s1, $zero, $zero
    /* 74400 80083C00 2000BFAF */  sw         $ra, 0x20($sp)
    /* 74404 80083C04 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 74408 80083C08 1800B2AF */  sw         $s2, 0x18($sp)
    /* 7440C 80083C0C 01004238 */  xori       $v0, $v0, 0x1
    /* 74410 80083C10 0100522C */  sltiu      $s2, $v0, 0x1
    /* 74414 80083C14 2A105102 */  slt        $v0, $s2, $s1
    /* 74418 80083C18 0F004014 */  bnez       $v0, .L80083C58
    /* 7441C 80083C1C 1000B0AF */   sw        $s0, 0x10($sp)
    /* 74420 80083C20 FFFF1324 */  addiu      $s3, $zero, -0x1
    /* 74424 80083C24 1180023C */  lui        $v0, %hi(Camera_gInfo)
    /* 74428 80083C28 ACF25024 */  addiu      $s0, $v0, %lo(Camera_gInfo)
  .L80083C2C:
    /* 7442C 80083C2C 7D000482 */  lb         $a0, 0x7D($s0)
    /* 74430 80083C30 00000000 */  nop
    /* 74434 80083C34 03009310 */  beq        $a0, $s3, .L80083C44
    /* 74438 80083C38 00000000 */   nop
    /* 7443C 80083C3C 5BCF010C */  jal        Anim_FreeHandle__Fi
    /* 74440 80083C40 00000000 */   nop
  .L80083C44:
    /* 74444 80083C44 7D0013A2 */  sb         $s3, 0x7D($s0)
    /* 74448 80083C48 01003126 */  addiu      $s1, $s1, 0x1
    /* 7444C 80083C4C 2A105102 */  slt        $v0, $s2, $s1
    /* 74450 80083C50 F6FF4010 */  beqz       $v0, .L80083C2C
    /* 74454 80083C54 10011026 */   addiu     $s0, $s0, 0x110
  .L80083C58:
    /* 74458 80083C58 2000BF8F */  lw         $ra, 0x20($sp)
    /* 7445C 80083C5C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 74460 80083C60 1800B28F */  lw         $s2, 0x18($sp)
    /* 74464 80083C64 1400B18F */  lw         $s1, 0x14($sp)
    /* 74468 80083C68 1000B08F */  lw         $s0, 0x10($sp)
    /* 7446C 80083C6C 0800E003 */  jr         $ra
    /* 74470 80083C70 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Camera_Kill__Fv
