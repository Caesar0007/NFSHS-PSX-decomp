.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TurnOffInstant__10tVideoWall, 0x7C

glabel TurnOffInstant__10tVideoWall
    /* 2767C 80036E7C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 27680 80036E80 1400B1AF */  sw         $s1, 0x14($sp)
    /* 27684 80036E84 21888000 */  addu       $s1, $a0, $zero
    /* 27688 80036E88 1800BFAF */  sw         $ra, 0x18($sp)
    /* 2768C 80036E8C 96DB000C */  jal        TurnOff__10tVideoWall
    /* 27690 80036E90 1000B0AF */   sw        $s0, 0x10($sp)
    /* 27694 80036E94 06002286 */  lh         $v0, 0x6($s1)
    /* 27698 80036E98 00000000 */  nop
    /* 2769C 80036E9C 11004018 */  blez       $v0, .L80036EE4
    /* 276A0 80036EA0 21800000 */   addu      $s0, $zero, $zero
    /* 276A4 80036EA4 00141000 */  sll        $v0, $s0, 16
  .L80036EA8:
    /* 276A8 80036EA8 03140200 */  sra        $v0, $v0, 16
    /* 276AC 80036EAC 40200200 */  sll        $a0, $v0, 1
    /* 276B0 80036EB0 21208200 */  addu       $a0, $a0, $v0
    /* 276B4 80036EB4 0000228E */  lw         $v0, 0x0($s1)
    /* 276B8 80036EB8 00210400 */  sll        $a0, $a0, 4
    /* 276BC 80036EBC 868C000C */  jal        TurnOffTV__FR9tTVConfig
    /* 276C0 80036EC0 21204400 */   addu      $a0, $v0, $a0
    /* 276C4 80036EC4 01000226 */  addiu      $v0, $s0, 0x1
    /* 276C8 80036EC8 21804000 */  addu       $s0, $v0, $zero
    /* 276CC 80036ECC 00140200 */  sll        $v0, $v0, 16
    /* 276D0 80036ED0 06002386 */  lh         $v1, 0x6($s1)
    /* 276D4 80036ED4 03140200 */  sra        $v0, $v0, 16
    /* 276D8 80036ED8 2A104300 */  slt        $v0, $v0, $v1
    /* 276DC 80036EDC F2FF4014 */  bnez       $v0, .L80036EA8
    /* 276E0 80036EE0 00141000 */   sll       $v0, $s0, 16
  .L80036EE4:
    /* 276E4 80036EE4 1800BF8F */  lw         $ra, 0x18($sp)
    /* 276E8 80036EE8 1400B18F */  lw         $s1, 0x14($sp)
    /* 276EC 80036EEC 1000B08F */  lw         $s0, 0x10($sp)
    /* 276F0 80036EF0 0800E003 */  jr         $ra
    /* 276F4 80036EF4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel TurnOffInstant__10tVideoWall
