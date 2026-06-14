.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching typeofbigfile, 0x68

glabel typeofbigfile
    /* D671C 800E5F1C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D6720 800E5F20 1400B1AF */  sw         $s1, 0x14($sp)
    /* D6724 800E5F24 21888000 */  addu       $s1, $a0, $zero
    /* D6728 800E5F28 1000B0AF */  sw         $s0, 0x10($sp)
    /* D672C 800E5F2C 21800000 */  addu       $s0, $zero, $zero
    /* D6730 800E5F30 1800BFAF */  sw         $ra, 0x18($sp)
    /* D6734 800E5F34 09CC030C */  jal        getm
    /* D6738 800E5F38 02000524 */   addiu     $a1, $zero, 0x2
    /* D673C 800E5F3C FBC00334 */  ori        $v1, $zero, 0xC0FB
    /* D6740 800E5F40 03004314 */  bne        $v0, $v1, .L800E5F50
    /* D6744 800E5F44 21202002 */   addu      $a0, $s1, $zero
    /* D6748 800E5F48 DB970308 */  j          .L800E5F6C
    /* D674C 800E5F4C 01001024 */   addiu     $s0, $zero, 0x1
  .L800E5F50:
    /* D6750 800E5F50 09CC030C */  jal        getm
    /* D6754 800E5F54 04000524 */   addiu     $a1, $zero, 0x4
    /* D6758 800E5F58 4942033C */  lui        $v1, (0x42494746 >> 16)
    /* D675C 800E5F5C 46476334 */  ori        $v1, $v1, (0x42494746 & 0xFFFF)
    /* D6760 800E5F60 03004314 */  bne        $v0, $v1, .L800E5F70
    /* D6764 800E5F64 21100002 */   addu      $v0, $s0, $zero
    /* D6768 800E5F68 02001024 */  addiu      $s0, $zero, 0x2
  .L800E5F6C:
    /* D676C 800E5F6C 21100002 */  addu       $v0, $s0, $zero
  .L800E5F70:
    /* D6770 800E5F70 1800BF8F */  lw         $ra, 0x18($sp)
    /* D6774 800E5F74 1400B18F */  lw         $s1, 0x14($sp)
    /* D6778 800E5F78 1000B08F */  lw         $s0, 0x10($sp)
    /* D677C 800E5F7C 0800E003 */  jr         $ra
    /* D6780 800E5F80 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel typeofbigfile
