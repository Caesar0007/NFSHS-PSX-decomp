.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateCarLineup__18tTournamentManager, 0xB0

glabel UpdateCarLineup__18tTournamentManager
    /* 23DD8 800335D8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 23DDC 800335DC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 23DE0 800335E0 1400BFAF */  sw         $ra, 0x14($sp)
    /* 23DE4 800335E4 63CD000C */  jal        GetNumCompetitors__18tTournamentManager
    /* 23DE8 800335E8 21808000 */   addu      $s0, $a0, $zero
    /* 23DEC 800335EC 21300000 */  addu       $a2, $zero, $zero
    /* 23DF0 800335F0 00140200 */  sll        $v0, $v0, 16
    /* 23DF4 800335F4 03140200 */  sra        $v0, $v0, 16
    /* 23DF8 800335F8 1F004018 */  blez       $v0, .L80033678
    /* 23DFC 800335FC 2128C000 */   addu      $a1, $a2, $zero
    /* 23E00 80033600 21384000 */  addu       $a3, $v0, $zero
    /* 23E04 80033604 00140500 */  sll        $v0, $a1, 16
  .L80033608:
    /* 23E08 80033608 03130200 */  sra        $v0, $v0, 12
    /* 23E0C 8003360C 21200202 */  addu       $a0, $s0, $v0
    /* 23E10 80033610 2001828C */  lw         $v0, 0x120($a0)
    /* 23E14 80033614 00000000 */  nop
    /* 23E18 80033618 11004014 */  bnez       $v0, .L80033660
    /* 23E1C 8003361C 0100A224 */   addiu     $v0, $a1, 0x1
    /* 23E20 80033620 00140600 */  sll        $v0, $a2, 16
    /* 23E24 80033624 03140200 */  sra        $v0, $v0, 16
    /* 23E28 80033628 80180200 */  sll        $v1, $v0, 2
    /* 23E2C 8003362C 21186200 */  addu       $v1, $v1, $v0
    /* 23E30 80033630 80180300 */  sll        $v1, $v1, 2
    /* 23E34 80033634 1D018280 */  lb         $v0, 0x11D($a0)
    /* 23E38 80033638 21180302 */  addu       $v1, $s0, $v1
    /* 23E3C 8003363C 2B100200 */  sltu       $v0, $zero, $v0
    /* 23E40 80033640 780162AC */  sw         $v0, 0x178($v1)
    /* 23E44 80033644 1801828C */  lw         $v0, 0x118($a0)
    /* 23E48 80033648 00000000 */  nop
    /* 23E4C 8003364C 7C0162AC */  sw         $v0, 0x17C($v1)
    /* 23E50 80033650 26018290 */  lbu        $v0, 0x126($a0)
    /* 23E54 80033654 0100C624 */  addiu      $a2, $a2, 0x1
    /* 23E58 80033658 800162A0 */  sb         $v0, 0x180($v1)
    /* 23E5C 8003365C 0100A224 */  addiu      $v0, $a1, 0x1
  .L80033660:
    /* 23E60 80033660 21284000 */  addu       $a1, $v0, $zero
    /* 23E64 80033664 00140200 */  sll        $v0, $v0, 16
    /* 23E68 80033668 03140200 */  sra        $v0, $v0, 16
    /* 23E6C 8003366C 2A104700 */  slt        $v0, $v0, $a3
    /* 23E70 80033670 E5FF4014 */  bnez       $v0, .L80033608
    /* 23E74 80033674 00140500 */   sll       $v0, $a1, 16
  .L80033678:
    /* 23E78 80033678 1400BF8F */  lw         $ra, 0x14($sp)
    /* 23E7C 8003367C 1000B08F */  lw         $s0, 0x10($sp)
    /* 23E80 80033680 0800E003 */  jr         $ra
    /* 23E84 80033684 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel UpdateCarLineup__18tTournamentManager
