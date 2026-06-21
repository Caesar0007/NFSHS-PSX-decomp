.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AddCarToIngameList__11tCarManagerR10tCarModelsRc, 0xA0

glabel AddCarToIngameList__11tCarManagerR10tCarModelsRc
    /* 7E78 80017678 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 7E7C 8001767C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 7E80 80017680 2188A000 */  addu       $s1, $a1, $zero
    /* 7E84 80017684 1800BFAF */  sw         $ra, 0x18($sp)
    /* 7E88 80017688 1000B0AF */  sw         $s0, 0x10($sp)
    /* 7E8C 8001768C 00002586 */  lh         $a1, 0x0($s1)
    /* 7E90 80017690 9358000C */  jal        GetCarFromID__11tCarManagers
    /* 7E94 80017694 2180C000 */   addu      $s0, $a2, $zero
    /* 7E98 80017698 00000392 */  lbu        $v1, 0x0($s0)
    /* 7E9C 8001769C 00000000 */  nop
    /* 7EA0 800176A0 21104300 */  addu       $v0, $v0, $v1
    /* 7EA4 800176A4 AF004290 */  lbu        $v0, 0xAF($v0)
    /* 7EA8 800176A8 00000000 */  nop
    /* 7EAC 800176AC 00160200 */  sll        $v0, $v0, 24
    /* 7EB0 800176B0 032E0200 */  sra        $a1, $v0, 24
    /* 7EB4 800176B4 2118A000 */  addu       $v1, $a1, $zero
    /* 7EB8 800176B8 0580023C */  lui        $v0, %hi(gCarSelected)
    /* 7EBC 800176BC 02006104 */  bgez       $v1, .L800176C8
    /* 7EC0 800176C0 44154624 */   addiu     $a2, $v0, %lo(gCarSelected)
    /* 7EC4 800176C4 07006324 */  addiu      $v1, $v1, 0x7
  .L800176C8:
    /* 7EC8 800176C8 C3180300 */  sra        $v1, $v1, 3
    /* 7ECC 800176CC 40100300 */  sll        $v0, $v1, 1
    /* 7ED0 800176D0 21104300 */  addu       $v0, $v0, $v1
    /* 7ED4 800176D4 C0100200 */  sll        $v0, $v0, 3
    /* 7ED8 800176D8 21104300 */  addu       $v0, $v0, $v1
    /* 7EDC 800176DC 40100200 */  sll        $v0, $v0, 1
    /* 7EE0 800176E0 0000248E */  lw         $a0, 0x0($s1)
    /* 7EE4 800176E4 0700A530 */  andi       $a1, $a1, 0x7
    /* 7EE8 800176E8 21208200 */  addu       $a0, $a0, $v0
    /* 7EEC 800176EC 21208600 */  addu       $a0, $a0, $a2
    /* 7EF0 800176F0 01000224 */  addiu      $v0, $zero, 0x1
    /* 7EF4 800176F4 00008390 */  lbu        $v1, 0x0($a0)
    /* 7EF8 800176F8 0410A200 */  sllv       $v0, $v0, $a1
    /* 7EFC 800176FC 25186200 */  or         $v1, $v1, $v0
    /* 7F00 80017700 000083A0 */  sb         $v1, 0x0($a0)
    /* 7F04 80017704 1800BF8F */  lw         $ra, 0x18($sp)
    /* 7F08 80017708 1400B18F */  lw         $s1, 0x14($sp)
    /* 7F0C 8001770C 1000B08F */  lw         $s0, 0x10($sp)
    /* 7F10 80017710 0800E003 */  jr         $ra
    /* 7F14 80017714 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AddCarToIngameList__11tCarManagerR10tCarModelsRc
