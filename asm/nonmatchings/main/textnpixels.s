.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching textnpixels, 0x94

glabel textnpixels
    /* D458C 800E3D8C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D4590 800E3D90 1800B2AF */  sw         $s2, 0x18($sp)
    /* D4594 800E3D94 2190A000 */  addu       $s2, $a1, $zero
    /* D4598 800E3D98 1400B1AF */  sw         $s1, 0x14($sp)
    /* D459C 800E3D9C 21880000 */  addu       $s1, $zero, $zero
    /* D45A0 800E3DA0 1000B0AF */  sw         $s0, 0x10($sp)
    /* D45A4 800E3DA4 21802002 */  addu       $s0, $s1, $zero
    /* D45A8 800E3DA8 2000BFAF */  sw         $ra, 0x20($sp)
    /* D45AC 800E3DAC 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* D45B0 800E3DB0 1300401A */  blez       $s2, .L800E3E00
    /* D45B4 800E3DB4 2800A4AF */   sw        $a0, 0x28($sp)
    /* D45B8 800E3DB8 1380023C */  lui        $v0, %hi(currentfont)
    /* D45BC 800E3DBC A05B5324 */  addiu      $s3, $v0, %lo(currentfont)
  .L800E3DC0:
    /* D45C0 800E3DC0 A000628E */  lw         $v0, 0xA0($s3)
    /* D45C4 800E3DC4 00000000 */  nop
    /* D45C8 800E3DC8 09F84000 */  jalr       $v0
    /* D45CC 800E3DCC 2800A427 */   addiu     $a0, $sp, 0x28
    /* D45D0 800E3DD0 0B004010 */  beqz       $v0, .L800E3E00
    /* D45D4 800E3DD4 01003126 */   addiu     $s1, $s1, 0x1
    /* D45D8 800E3DD8 44D1030C */  jal        getcharacter
    /* D45DC 800E3DDC 21204000 */   addu      $a0, $v0, $zero
    /* D45E0 800E3DE0 04004010 */  beqz       $v0, .L800E3DF4
    /* D45E4 800E3DE4 00000000 */   nop
    /* D45E8 800E3DE8 08004280 */  lb         $v0, 0x8($v0)
    /* D45EC 800E3DEC 00000000 */  nop
    /* D45F0 800E3DF0 21800202 */  addu       $s0, $s0, $v0
  .L800E3DF4:
    /* D45F4 800E3DF4 2A103202 */  slt        $v0, $s1, $s2
    /* D45F8 800E3DF8 F1FF4014 */  bnez       $v0, .L800E3DC0
    /* D45FC 800E3DFC 00000000 */   nop
  .L800E3E00:
    /* D4600 800E3E00 21100002 */  addu       $v0, $s0, $zero
    /* D4604 800E3E04 2000BF8F */  lw         $ra, 0x20($sp)
    /* D4608 800E3E08 1C00B38F */  lw         $s3, 0x1C($sp)
    /* D460C 800E3E0C 1800B28F */  lw         $s2, 0x18($sp)
    /* D4610 800E3E10 1400B18F */  lw         $s1, 0x14($sp)
    /* D4614 800E3E14 1000B08F */  lw         $s0, 0x10($sp)
    /* D4618 800E3E18 0800E003 */  jr         $ra
    /* D461C 800E3E1C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel textnpixels
