.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching getfilesize, 0x64

glabel getfilesize
    /* E489C 800F409C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* E48A0 800F40A0 FF00023C */  lui        $v0, (0xFFFFFF >> 16)
    /* E48A4 800F40A4 FFFF4234 */  ori        $v0, $v0, (0xFFFFFF & 0xFFFF)
    /* E48A8 800F40A8 031E0400 */  sra        $v1, $a0, 24
    /* E48AC 800F40AC 24208200 */  and        $a0, $a0, $v0
    /* E48B0 800F40B0 01000224 */  addiu      $v0, $zero, 0x1
    /* E48B4 800F40B4 1800BFAF */  sw         $ra, 0x18($sp)
    /* E48B8 800F40B8 06006214 */  bne        $v1, $v0, .L800F40D4
    /* E48BC 800F40BC 1000A0AF */   sw        $zero, 0x10($sp)
    /* E48C0 800F40C0 21280000 */  addu       $a1, $zero, $zero
    /* E48C4 800F40C4 48EA030C */  jal        CD_Getinfo
    /* E48C8 800F40C8 1000A627 */   addiu     $a2, $sp, 0x10
    /* E48CC 800F40CC 3BD00308 */  j          .L800F40EC
    /* E48D0 800F40D0 00000000 */   nop
  .L800F40D4:
    /* E48D4 800F40D4 02000224 */  addiu      $v0, $zero, 0x2
    /* E48D8 800F40D8 04006214 */  bne        $v1, $v0, .L800F40EC
    /* E48DC 800F40DC 21280000 */   addu      $a1, $zero, $zero
    /* E48E0 800F40E0 471B040C */  jal        PClseek
    /* E48E4 800F40E4 21304000 */   addu      $a2, $v0, $zero
    /* E48E8 800F40E8 1000A2AF */  sw         $v0, 0x10($sp)
  .L800F40EC:
    /* E48EC 800F40EC 1000A28F */  lw         $v0, 0x10($sp)
    /* E48F0 800F40F0 1800BF8F */  lw         $ra, 0x18($sp)
    /* E48F4 800F40F4 00000000 */  nop
    /* E48F8 800F40F8 0800E003 */  jr         $ra
    /* E48FC 800F40FC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel getfilesize
