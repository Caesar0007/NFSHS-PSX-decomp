.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AsyncLoadSwapShapeFile__7tScreenPc, 0x54

glabel AsyncLoadSwapShapeFile__7tScreenPc
    /* 165B8 80025DB8 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 165BC 80025DBC 3000B0AF */  sw         $s0, 0x30($sp)
    /* 165C0 80025DC0 21808000 */  addu       $s0, $a0, $zero
    /* 165C4 80025DC4 2130A000 */  addu       $a2, $a1, $zero
    /* 165C8 80025DC8 0800C010 */  beqz       $a2, .L80025DEC
    /* 165CC 80025DCC 3400BFAF */   sw        $ra, 0x34($sp)
    /* 165D0 80025DD0 1000A427 */  addiu      $a0, $sp, 0x10
    /* 165D4 80025DD4 0180053C */  lui        $a1, %hi(D_800113F8)
    /* 165D8 80025DD8 2F91030C */  jal        sprintf
    /* 165DC 80025DDC F813A524 */   addiu     $a1, $a1, %lo(D_800113F8)
    /* 165E0 80025DE0 21200002 */  addu       $a0, $s0, $zero
    /* 165E4 80025DE4 7D970008 */  j          .L80025DF4
    /* 165E8 80025DE8 1000A527 */   addiu     $a1, $sp, 0x10
  .L80025DEC:
    /* 165EC 80025DEC 21200002 */  addu       $a0, $s0, $zero
    /* 165F0 80025DF0 21280000 */  addu       $a1, $zero, $zero
  .L80025DF4:
    /* 165F4 80025DF4 9098000C */  jal        AsyncLoadShapeFile__7tScreenPcR17tShapeInformation
    /* 165F8 80025DF8 28008624 */   addiu     $a2, $a0, 0x28
    /* 165FC 80025DFC 3400BF8F */  lw         $ra, 0x34($sp)
    /* 16600 80025E00 3000B08F */  lw         $s0, 0x30($sp)
    /* 16604 80025E04 0800E003 */  jr         $ra
    /* 16608 80025E08 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel AsyncLoadSwapShapeFile__7tScreenPc
