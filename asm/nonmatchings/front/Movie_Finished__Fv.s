.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Movie_Finished__Fv, 0x60

glabel Movie_Finished__Fv
    /* 3D484 8004CC84 0580023C */  lui        $v0, %hi(D_80052D0C)
    /* 3D488 8004CC88 0580033C */  lui        $v1, %hi(D_80052D10)
    /* 3D48C 8004CC8C 0C2D428C */  lw         $v0, %lo(D_80052D0C)($v0)
    /* 3D490 8004CC90 102D638C */  lw         $v1, %lo(D_80052D10)($v1)
    /* 3D494 8004CC94 00000000 */  nop
    /* 3D498 8004CC98 2B104300 */  sltu       $v0, $v0, $v1
    /* 3D49C 8004CC9C 0E004010 */  beqz       $v0, .L8004CCD8
    /* 3D4A0 8004CCA0 21200000 */   addu      $a0, $zero, $zero
    /* 3D4A4 8004CCA4 0580023C */  lui        $v0, %hi(D_80052D14)
    /* 3D4A8 8004CCA8 142D428C */  lw         $v0, %lo(D_80052D14)($v0)
    /* 3D4AC 8004CCAC 00000000 */  nop
    /* 3D4B0 8004CCB0 09004010 */  beqz       $v0, .L8004CCD8
    /* 3D4B4 8004CCB4 0580023C */   lui       $v0, %hi(D_80052D18)
    /* 3D4B8 8004CCB8 182D428C */  lw         $v0, %lo(D_80052D18)($v0)
    /* 3D4BC 8004CCBC 00000000 */  nop
    /* 3D4C0 8004CCC0 05004014 */  bnez       $v0, .L8004CCD8
    /* 3D4C4 8004CCC4 0580023C */   lui       $v0, %hi(D_80052D1C)
    /* 3D4C8 8004CCC8 1C2D428C */  lw         $v0, %lo(D_80052D1C)($v0)
    /* 3D4CC 8004CCCC 00000000 */  nop
    /* 3D4D0 8004CCD0 02004010 */  beqz       $v0, .L8004CCDC
    /* 3D4D4 8004CCD4 00000000 */   nop
  .L8004CCD8:
    /* 3D4D8 8004CCD8 01000424 */  addiu      $a0, $zero, 0x1
  .L8004CCDC:
    /* 3D4DC 8004CCDC 0800E003 */  jr         $ra
    /* 3D4E0 8004CCE0 21108000 */   addu      $v0, $a0, $zero
endlabel Movie_Finished__Fv
