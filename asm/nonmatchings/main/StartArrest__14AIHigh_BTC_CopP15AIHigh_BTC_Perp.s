.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching StartArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp, 0x70

glabel StartArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
    /* 4D610 8005CE10 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4D614 8005CE14 1000BFAF */  sw         $ra, 0x10($sp)
    /* 4D618 8005CE18 6000828C */  lw         $v0, 0x60($a0)
    /* 4D61C 8005CE1C 00000000 */  nop
    /* 4D620 8005CE20 13004014 */  bnez       $v0, .L8005CE70
    /* 4D624 8005CE24 03000224 */   addiu     $v0, $zero, 0x3
    /* 4D628 8005CE28 0000838C */  lw         $v1, 0x0($a0)
    /* 4D62C 8005CE2C 600082AC */  sw         $v0, 0x60($a0)
    /* 4D630 8005CE30 6002628C */  lw         $v0, 0x260($v1)
    /* 4D634 8005CE34 00000000 */  nop
    /* 4D638 8005CE38 00024230 */  andi       $v0, $v0, 0x200
    /* 4D63C 8005CE3C 0C004010 */  beqz       $v0, .L8005CE70
    /* 4D640 8005CE40 00000000 */   nop
    /* 4D644 8005CE44 175E020C */  jal        Mobile__6SpeechP8Car_tObj
    /* 4D648 8005CE48 21206000 */   addu      $a0, $v1, $zero
    /* 4D64C 8005CE4C 4C00438C */  lw         $v1, 0x4C($v0)
    /* 4D650 8005CE50 00000000 */  nop
    /* 4D654 8005CE54 48006484 */  lh         $a0, 0x48($v1)
    /* 4D658 8005CE58 00000000 */  nop
    /* 4D65C 8005CE5C 21204400 */  addu       $a0, $v0, $a0
    /* 4D660 8005CE60 4C00628C */  lw         $v0, 0x4C($v1)
    /* 4D664 8005CE64 00000000 */  nop
    /* 4D668 8005CE68 09F84000 */  jalr       $v0
    /* 4D66C 8005CE6C 01000524 */   addiu     $a1, $zero, 0x1
  .L8005CE70:
    /* 4D670 8005CE70 1000BF8F */  lw         $ra, 0x10($sp)
    /* 4D674 8005CE74 00000000 */  nop
    /* 4D678 8005CE78 0800E003 */  jr         $ra
    /* 4D67C 8005CE7C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel StartArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
