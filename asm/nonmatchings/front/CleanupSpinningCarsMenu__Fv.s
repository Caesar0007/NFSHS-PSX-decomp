.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CleanupSpinningCarsMenu__Fv, 0x70

glabel CleanupSpinningCarsMenu__Fv
    /* 3E2C4 8004DAC4 0580023C */  lui        $v0, %hi(D_80052A60)
    /* 3E2C8 8004DAC8 602A4290 */  lbu        $v0, %lo(D_80052A60)($v0)
    /* 3E2CC 8004DACC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 3E2D0 8004DAD0 1800BFAF */  sw         $ra, 0x18($sp)
    /* 3E2D4 8004DAD4 1400B1AF */  sw         $s1, 0x14($sp)
    /* 3E2D8 8004DAD8 11004010 */  beqz       $v0, .L8004DB20
    /* 3E2DC 8004DADC 1000B0AF */   sw        $s0, 0x10($sp)
    /* 3E2E0 8004DAE0 1FB6030C */  jal        DrawSync
    /* 3E2E4 8004DAE4 21200000 */   addu      $a0, $zero, $zero
    /* 3E2E8 8004DAE8 21880000 */  addu       $s1, $zero, $zero
    /* 3E2EC 8004DAEC 0580023C */  lui        $v0, %hi(gCarObj)
    /* 3E2F0 8004DAF0 682A5024 */  addiu      $s0, $v0, %lo(gCarObj)
  .L8004DAF4:
    /* 3E2F4 8004DAF4 0000048E */  lw         $a0, 0x0($s0)
    /* 3E2F8 8004DAF8 04001026 */  addiu      $s0, $s0, 0x4
    /* 3E2FC 8004DAFC 2DBB020C */  jal        R3DCar_DeInstantiate3DCarMenu__FP8Car_tObj
    /* 3E300 8004DB00 01003126 */   addiu     $s1, $s1, 0x1
    /* 3E304 8004DB04 0200222A */  slti       $v0, $s1, 0x2
    /* 3E308 8004DB08 FAFF4014 */  bnez       $v0, .L8004DAF4
    /* 3E30C 8004DB0C 00000000 */   nop
    /* 3E310 8004DB10 8E81030C */  jal        Texture_CleanupMenuTexture__Fv
    /* 3E314 8004DB14 00000000 */   nop
    /* 3E318 8004DB18 E9EF020C */  jal        CarIO_ReStart__Fv
    /* 3E31C 8004DB1C 00000000 */   nop
  .L8004DB20:
    /* 3E320 8004DB20 1800BF8F */  lw         $ra, 0x18($sp)
    /* 3E324 8004DB24 1400B18F */  lw         $s1, 0x14($sp)
    /* 3E328 8004DB28 1000B08F */  lw         $s0, 0x10($sp)
    /* 3E32C 8004DB2C 0800E003 */  jr         $ra
    /* 3E330 8004DB30 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel CleanupSpinningCarsMenu__Fv
