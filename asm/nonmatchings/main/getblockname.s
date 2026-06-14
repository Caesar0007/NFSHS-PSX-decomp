.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching getblockname, 0x5C

glabel getblockname
    /* D5AE0 800E52E0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D5AE4 800E52E4 1400B1AF */  sw         $s1, 0x14($sp)
    /* D5AE8 800E52E8 21888000 */  addu       $s1, $a0, $zero
    /* D5AEC 800E52EC 1000B0AF */  sw         $s0, 0x10($sp)
    /* D5AF0 800E52F0 F0FF3026 */  addiu      $s0, $s1, -0x10
    /* D5AF4 800E52F4 1800BFAF */  sw         $ra, 0x18($sp)
    /* D5AF8 800E52F8 02000496 */  lhu        $a0, 0x2($s0)
    /* D5AFC 800E52FC 00000000 */  nop
    /* D5B00 800E5300 00018230 */  andi       $v0, $a0, 0x100
    /* D5B04 800E5304 07004010 */  beqz       $v0, .L800E5324
    /* D5B08 800E5308 21180000 */   addu      $v1, $zero, $zero
    /* D5B0C 800E530C 0294030C */  jal        MEM_infosize
    /* D5B10 800E5310 00000000 */   nop
    /* D5B14 800E5314 0400038E */  lw         $v1, 0x4($s0)
    /* D5B18 800E5318 00000000 */  nop
    /* D5B1C 800E531C 21182302 */  addu       $v1, $s1, $v1
    /* D5B20 800E5320 21186200 */  addu       $v1, $v1, $v0
  .L800E5324:
    /* D5B24 800E5324 1800BF8F */  lw         $ra, 0x18($sp)
    /* D5B28 800E5328 1400B18F */  lw         $s1, 0x14($sp)
    /* D5B2C 800E532C 1000B08F */  lw         $s0, 0x10($sp)
    /* D5B30 800E5330 21106000 */  addu       $v0, $v1, $zero
    /* D5B34 800E5334 0800E003 */  jr         $ra
    /* D5B38 800E5338 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel getblockname
