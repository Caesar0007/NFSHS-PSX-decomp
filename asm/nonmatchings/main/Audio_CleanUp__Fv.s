.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Audio_CleanUp__Fv, 0x5C

glabel Audio_CleanUp__Fv
    /* AC4C0 800BBCC0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* AC4C4 800BBCC4 1400B1AF */  sw         $s1, 0x14($sp)
    /* AC4C8 800BBCC8 21880000 */  addu       $s1, $zero, $zero
    /* AC4CC 800BBCCC 1180023C */  lui        $v0, %hi(gSndBnk)
    /* AC4D0 800BBCD0 1000B0AF */  sw         $s0, 0x10($sp)
    /* AC4D4 800BBCD4 A8E85024 */  addiu      $s0, $v0, %lo(gSndBnk)
    /* AC4D8 800BBCD8 1800BFAF */  sw         $ra, 0x18($sp)
  .L800BBCDC:
    /* AC4DC 800BBCDC 0800048E */  lw         $a0, 0x8($s0)
    /* AC4E0 800BBCE0 00000000 */  nop
    /* AC4E4 800BBCE4 04008010 */  beqz       $a0, .L800BBCF8
    /* AC4E8 800BBCE8 00000000 */   nop
    /* AC4EC 800BBCEC 5095030C */  jal        purgememadr
    /* AC4F0 800BBCF0 00000000 */   nop
    /* AC4F4 800BBCF4 080000AE */  sw         $zero, 0x8($s0)
  .L800BBCF8:
    /* AC4F8 800BBCF8 01003126 */  addiu      $s1, $s1, 0x1
    /* AC4FC 800BBCFC 0700222A */  slti       $v0, $s1, 0x7
    /* AC500 800BBD00 F6FF4014 */  bnez       $v0, .L800BBCDC
    /* AC504 800BBD04 0C001026 */   addiu     $s0, $s0, 0xC
    /* AC508 800BBD08 1800BF8F */  lw         $ra, 0x18($sp)
    /* AC50C 800BBD0C 1400B18F */  lw         $s1, 0x14($sp)
    /* AC510 800BBD10 1000B08F */  lw         $s0, 0x10($sp)
    /* AC514 800BBD14 0800E003 */  jr         $ra
    /* AC518 800BBD18 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Audio_CleanUp__Fv
