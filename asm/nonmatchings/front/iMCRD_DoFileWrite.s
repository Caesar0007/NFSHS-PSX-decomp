.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iMCRD_DoFileWrite, 0x164

glabel iMCRD_DoFileWrite
    /* 40488 8004FC88 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 4048C 8004FC8C 0580023C */  lui        $v0, %hi(D_80052FC8)
    /* 40490 8004FC90 2000B0AF */  sw         $s0, 0x20($sp)
    /* 40494 8004FC94 C82F5024 */  addiu      $s0, $v0, %lo(D_80052FC8)
    /* 40498 8004FC98 3000BFAF */  sw         $ra, 0x30($sp)
    /* 4049C 8004FC9C 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* 404A0 8004FCA0 2800B2AF */  sw         $s2, 0x28($sp)
    /* 404A4 8004FCA4 2400B1AF */  sw         $s1, 0x24($sp)
    /* 404A8 8004FCA8 2800028E */  lw         $v0, 0x28($s0)
    /* 404AC 8004FCAC 00000000 */  nop
    /* 404B0 8004FCB0 00024230 */  andi       $v0, $v0, 0x200
    /* 404B4 8004FCB4 25004010 */  beqz       $v0, .L8004FD4C
    /* 404B8 8004FCB8 21988000 */   addu      $s3, $a0, $zero
    /* 404BC 8004FCBC A0FD1126 */  addiu      $s1, $s0, -0x260
    /* 404C0 8004FCC0 04001226 */  addiu      $s2, $s0, 0x4
    /* 404C4 8004FCC4 3C00248E */  lw         $a0, 0x3C($s1)
    /* 404C8 8004FCC8 2F000692 */  lbu        $a2, 0x2F($s0)
    /* 404CC 8004FCCC 06EF030C */  jal        MemCardCreateFile
    /* 404D0 8004FCD0 21284002 */   addu      $a1, $s2, $zero
    /* 404D4 8004FCD4 02000424 */  addiu      $a0, $zero, 0x2
    /* 404D8 8004FCD8 21284000 */  addu       $a1, $v0, $zero
    /* 404DC 8004FCDC 21306002 */  addu       $a2, $s3, $zero
    /* 404E0 8004FCE0 3341010C */  jal        iMCRD_HandleError
    /* 404E4 8004FCE4 1C00A5AF */   sw        $a1, 0x1C($sp)
    /* 404E8 8004FCE8 39004014 */  bnez       $v0, .L8004FDD0
    /* 404EC 8004FCEC 00000000 */   nop
    /* 404F0 8004FCF0 A1A0030C */  jal        timedwait
    /* 404F4 8004FCF4 40000424 */   addiu     $a0, $zero, 0x40
    /* 404F8 8004FCF8 21284002 */  addu       $a1, $s2, $zero
    /* 404FC 8004FCFC 2C000626 */  addiu      $a2, $s0, 0x2C
    /* 40500 8004FD00 21380000 */  addu       $a3, $zero, $zero
    /* 40504 8004FD04 3C00248E */  lw         $a0, 0x3C($s1)
    /* 40508 8004FD08 00020224 */  addiu      $v0, $zero, 0x200
    /* 4050C 8004FD0C 9AED030C */  jal        MemCardWriteFile
    /* 40510 8004FD10 1000A2AF */   sw        $v0, 0x10($sp)
    /* 40514 8004FD14 19004010 */  beqz       $v0, .L8004FD7C
    /* 40518 8004FD18 1C00A2AF */   sw        $v0, 0x1C($sp)
    /* 4051C 8004FD1C 21200000 */  addu       $a0, $zero, $zero
  .L8004FD20:
    /* 40520 8004FD20 1800A527 */  addiu      $a1, $sp, 0x18
    /* 40524 8004FD24 BFEE030C */  jal        MemCardSync
    /* 40528 8004FD28 1C00A627 */   addiu     $a2, $sp, 0x1C
    /* 4052C 8004FD2C FCFF4010 */  beqz       $v0, .L8004FD20
    /* 40530 8004FD30 21200000 */   addu      $a0, $zero, $zero
    /* 40534 8004FD34 02000424 */  addiu      $a0, $zero, 0x2
    /* 40538 8004FD38 1C00A58F */  lw         $a1, 0x1C($sp)
    /* 4053C 8004FD3C 3341010C */  jal        iMCRD_HandleError
    /* 40540 8004FD40 21306002 */   addu      $a2, $s3, $zero
    /* 40544 8004FD44 22004014 */  bnez       $v0, .L8004FDD0
    /* 40548 8004FD48 00000000 */   nop
  .L8004FD4C:
    /* 4054C 8004FD4C 04000526 */  addiu      $a1, $s0, 0x4
    /* 40550 8004FD50 0580023C */  lui        $v0, %hi(gMemCardInfo)
    /* 40554 8004FD54 682D5124 */  addiu      $s1, $v0, %lo(gMemCardInfo)
    /* 40558 8004FD58 3C00248E */  lw         $a0, 0x3C($s1)
    /* 4055C 8004FD5C 2C02068E */  lw         $a2, 0x22C($s0)
    /* 40560 8004FD60 2400078E */  lw         $a3, 0x24($s0)
    /* 40564 8004FD64 2000028E */  lw         $v0, 0x20($s0)
    /* 40568 8004FD68 0002E724 */  addiu      $a3, $a3, 0x200
    /* 4056C 8004FD6C 9AED030C */  jal        MemCardWriteFile
    /* 40570 8004FD70 1000A2AF */   sw        $v0, 0x10($sp)
    /* 40574 8004FD74 05004014 */  bnez       $v0, .L8004FD8C
    /* 40578 8004FD78 1C00A2AF */   sw        $v0, 0x1C($sp)
  .L8004FD7C:
    /* 4057C 8004FD7C 01000224 */  addiu      $v0, $zero, 0x1
    /* 40580 8004FD80 340022AE */  sw         $v0, 0x34($s1)
    /* 40584 8004FD84 743F0108 */  j          .L8004FDD0
    /* 40588 8004FD88 0D000224 */   addiu     $v0, $zero, 0xD
  .L8004FD8C:
    /* 4058C 8004FD8C 21200000 */  addu       $a0, $zero, $zero
  .L8004FD90:
    /* 40590 8004FD90 1800A527 */  addiu      $a1, $sp, 0x18
    /* 40594 8004FD94 BFEE030C */  jal        MemCardSync
    /* 40598 8004FD98 1C00A627 */   addiu     $a2, $sp, 0x1C
    /* 4059C 8004FD9C FCFF4010 */  beqz       $v0, .L8004FD90
    /* 405A0 8004FDA0 21200000 */   addu      $a0, $zero, $zero
    /* 405A4 8004FDA4 02000424 */  addiu      $a0, $zero, 0x2
    /* 405A8 8004FDA8 1C00A58F */  lw         $a1, 0x1C($sp)
    /* 405AC 8004FDAC 3341010C */  jal        iMCRD_HandleError
    /* 405B0 8004FDB0 21306002 */   addu      $a2, $s3, $zero
    /* 405B4 8004FDB4 06004014 */  bnez       $v0, .L8004FDD0
    /* 405B8 8004FDB8 0580033C */   lui       $v1, %hi(gMemCardInfo)
    /* 405BC 8004FDBC 0C000224 */  addiu      $v0, $zero, 0xC
    /* 405C0 8004FDC0 682D6324 */  addiu      $v1, $v1, %lo(gMemCardInfo)
    /* 405C4 8004FDC4 01000424 */  addiu      $a0, $zero, 0x1
    /* 405C8 8004FDC8 340060AC */  sw         $zero, 0x34($v1)
    /* 405CC 8004FDCC 300064AC */  sw         $a0, 0x30($v1)
  .L8004FDD0:
    /* 405D0 8004FDD0 3000BF8F */  lw         $ra, 0x30($sp)
    /* 405D4 8004FDD4 2C00B38F */  lw         $s3, 0x2C($sp)
    /* 405D8 8004FDD8 2800B28F */  lw         $s2, 0x28($sp)
    /* 405DC 8004FDDC 2400B18F */  lw         $s1, 0x24($sp)
    /* 405E0 8004FDE0 2000B08F */  lw         $s0, 0x20($sp)
    /* 405E4 8004FDE4 0800E003 */  jr         $ra
    /* 405E8 8004FDE8 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel iMCRD_DoFileWrite
