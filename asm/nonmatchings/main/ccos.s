.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ccos, 0xC4

glabel ccos
    /* E3F28 800F3728 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* E3F2C 800F372C 21188000 */  addu       $v1, $a0, $zero
    /* E3F30 800F3730 02006104 */  bgez       $v1, .L800F373C
    /* E3F34 800F3734 1800BFAF */   sw        $ra, 0x18($sp)
    /* E3F38 800F3738 23180300 */  negu       $v1, $v1
  .L800F373C:
    /* E3F3C 800F373C 02006104 */  bgez       $v1, .L800F3748
    /* E3F40 800F3740 21106000 */   addu      $v0, $v1, $zero
    /* E3F44 800F3744 FF0F6224 */  addiu      $v0, $v1, 0xFFF
  .L800F3748:
    /* E3F48 800F3748 03130200 */  sra        $v0, $v0, 12
    /* E3F4C 800F374C 00130200 */  sll        $v0, $v0, 12
    /* E3F50 800F3750 23186200 */  subu       $v1, $v1, $v0
    /* E3F54 800F3754 0004622C */  sltiu      $v0, $v1, 0x400
    /* E3F58 800F3758 07004010 */  beqz       $v0, .L800F3778
    /* E3F5C 800F375C 21206000 */   addu      $a0, $v1, $zero
    /* E3F60 800F3760 1000A527 */  addiu      $a1, $sp, 0x10
    /* E3F64 800F3764 B11A040C */  jal        csincos
    /* E3F68 800F3768 1400A627 */   addiu     $a2, $sp, 0x14
    /* E3F6C 800F376C 1400A28F */  lw         $v0, 0x14($sp)
    /* E3F70 800F3770 F7CD0308 */  j          .L800F37DC
    /* E3F74 800F3774 00000000 */   nop
  .L800F3778:
    /* E3F78 800F3778 00FC6224 */  addiu      $v0, $v1, -0x400
    /* E3F7C 800F377C 0004422C */  sltiu      $v0, $v0, 0x400
    /* E3F80 800F3780 03004010 */  beqz       $v0, .L800F3790
    /* E3F84 800F3784 FF070424 */   addiu     $a0, $zero, 0x7FF
    /* E3F88 800F3788 E8CD0308 */  j          .L800F37A0
    /* E3F8C 800F378C 23208300 */   subu      $a0, $a0, $v1
  .L800F3790:
    /* E3F90 800F3790 00F86424 */  addiu      $a0, $v1, -0x800
    /* E3F94 800F3794 0004822C */  sltiu      $v0, $a0, 0x400
    /* E3F98 800F3798 07004010 */  beqz       $v0, .L800F37B8
    /* E3F9C 800F379C 00000000 */   nop
  .L800F37A0:
    /* E3FA0 800F37A0 1000A527 */  addiu      $a1, $sp, 0x10
    /* E3FA4 800F37A4 B11A040C */  jal        csincos
    /* E3FA8 800F37A8 1400A627 */   addiu     $a2, $sp, 0x14
    /* E3FAC 800F37AC 1400A28F */  lw         $v0, 0x14($sp)
    /* E3FB0 800F37B0 F7CD0308 */  j          .L800F37DC
    /* E3FB4 800F37B4 23100200 */   negu      $v0, $v0
  .L800F37B8:
    /* E3FB8 800F37B8 00F46224 */  addiu      $v0, $v1, -0xC00
    /* E3FBC 800F37BC 0004422C */  sltiu      $v0, $v0, 0x400
    /* E3FC0 800F37C0 06004010 */  beqz       $v0, .L800F37DC
    /* E3FC4 800F37C4 FF0F0424 */   addiu     $a0, $zero, 0xFFF
    /* E3FC8 800F37C8 23208300 */  subu       $a0, $a0, $v1
    /* E3FCC 800F37CC 1000A527 */  addiu      $a1, $sp, 0x10
    /* E3FD0 800F37D0 B11A040C */  jal        csincos
    /* E3FD4 800F37D4 1400A627 */   addiu     $a2, $sp, 0x14
    /* E3FD8 800F37D8 1400A28F */  lw         $v0, 0x14($sp)
  .L800F37DC:
    /* E3FDC 800F37DC 1800BF8F */  lw         $ra, 0x18($sp)
    /* E3FE0 800F37E0 2000BD27 */  addiu      $sp, $sp, 0x20
    /* E3FE4 800F37E4 0800E003 */  jr         $ra
    /* E3FE8 800F37E8 00000000 */   nop
endlabel ccos
    /* E3FEC 800F37EC 00000000 */  nop
    /* E3FF0 800F37F0 00000000 */  nop
    /* E3FF4 800F37F4 00000000 */  nop
