.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MCRD_fileexists, 0x78

glabel MCRD_fileexists
    /* 409CC 800501CC C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 409D0 800501D0 2800B0AF */  sw         $s0, 0x28($sp)
    /* 409D4 800501D4 2180A000 */  addu       $s0, $a1, $zero
    /* 409D8 800501D8 3000BFAF */  sw         $ra, 0x30($sp)
    /* 409DC 800501DC 9140010C */  jal        MCRD_getcard
    /* 409E0 800501E0 2C00B1AF */   sw        $s1, 0x2C($sp)
    /* 409E4 800501E4 10005124 */  addiu      $s1, $v0, 0x10
    /* 409E8 800501E8 1000A427 */  addiu      $a0, $sp, 0x10
    /* 409EC 800501EC 0580053C */  lui        $a1, %hi(D_80052D6C)
    /* 409F0 800501F0 CA96030C */  jal        strcpy
    /* 409F4 800501F4 6C2DA524 */   addiu     $a1, $a1, %lo(D_80052D6C)
    /* 409F8 800501F8 1000A427 */  addiu      $a0, $sp, 0x10
    /* 409FC 800501FC 3A9E030C */  jal        strcat
    /* 40A00 80050200 21280002 */   addu      $a1, $s0, $zero
    /* 40A04 80050204 21800000 */  addu       $s0, $zero, $zero
  .L80050208:
    /* 40A08 80050208 21202002 */  addu       $a0, $s1, $zero
    /* 40A0C 8005020C 5F97030C */  jal        strcmp
    /* 40A10 80050210 1000A527 */   addiu     $a1, $sp, 0x10
    /* 40A14 80050214 06004010 */  beqz       $v0, .L80050230
    /* 40A18 80050218 21100002 */   addu      $v0, $s0, $zero
    /* 40A1C 8005021C 01001026 */  addiu      $s0, $s0, 0x1
    /* 40A20 80050220 0F00022A */  slti       $v0, $s0, 0xF
    /* 40A24 80050224 F8FF4014 */  bnez       $v0, .L80050208
    /* 40A28 80050228 28003126 */   addiu     $s1, $s1, 0x28
    /* 40A2C 8005022C FFFF0224 */  addiu      $v0, $zero, -0x1
  .L80050230:
    /* 40A30 80050230 3000BF8F */  lw         $ra, 0x30($sp)
    /* 40A34 80050234 2C00B18F */  lw         $s1, 0x2C($sp)
    /* 40A38 80050238 2800B08F */  lw         $s0, 0x28($sp)
    /* 40A3C 8005023C 0800E003 */  jr         $ra
    /* 40A40 80050240 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel MCRD_fileexists
