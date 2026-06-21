.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching IsCarAnAddedModel__11tCarManagerR10tCarModelsRc, 0x80

glabel IsCarAnAddedModel__11tCarManagerR10tCarModelsRc
    /* 7DF8 800175F8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 7DFC 800175FC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 7E00 80017600 2188A000 */  addu       $s1, $a1, $zero
    /* 7E04 80017604 1800BFAF */  sw         $ra, 0x18($sp)
    /* 7E08 80017608 1000B0AF */  sw         $s0, 0x10($sp)
    /* 7E0C 8001760C 00002586 */  lh         $a1, 0x0($s1)
    /* 7E10 80017610 9358000C */  jal        GetCarFromID__11tCarManagers
    /* 7E14 80017614 2180C000 */   addu      $s0, $a2, $zero
    /* 7E18 80017618 00000392 */  lbu        $v1, 0x0($s0)
    /* 7E1C 8001761C 00000000 */  nop
    /* 7E20 80017620 21104300 */  addu       $v0, $v0, $v1
    /* 7E24 80017624 AF004380 */  lb         $v1, 0xAF($v0)
    /* 7E28 80017628 0580023C */  lui        $v0, %hi(gCarSelected)
    /* 7E2C 8001762C 02006104 */  bgez       $v1, .L80017638
    /* 7E30 80017630 44154424 */   addiu     $a0, $v0, %lo(gCarSelected)
    /* 7E34 80017634 07006324 */  addiu      $v1, $v1, 0x7
  .L80017638:
    /* 7E38 80017638 C3180300 */  sra        $v1, $v1, 3
    /* 7E3C 8001763C 40100300 */  sll        $v0, $v1, 1
    /* 7E40 80017640 21104300 */  addu       $v0, $v0, $v1
    /* 7E44 80017644 C0100200 */  sll        $v0, $v0, 3
    /* 7E48 80017648 21104300 */  addu       $v0, $v0, $v1
    /* 7E4C 8001764C 40100200 */  sll        $v0, $v0, 1
    /* 7E50 80017650 0000238E */  lw         $v1, 0x0($s1)
    /* 7E54 80017654 1800BF8F */  lw         $ra, 0x18($sp)
    /* 7E58 80017658 1400B18F */  lw         $s1, 0x14($sp)
    /* 7E5C 8001765C 21186200 */  addu       $v1, $v1, $v0
    /* 7E60 80017660 21186400 */  addu       $v1, $v1, $a0
    /* 7E64 80017664 00006290 */  lbu        $v0, 0x0($v1)
    /* 7E68 80017668 1000B08F */  lw         $s0, 0x10($sp)
    /* 7E6C 8001766C 2B100200 */  sltu       $v0, $zero, $v0
    /* 7E70 80017670 0800E003 */  jr         $ra
    /* 7E74 80017674 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel IsCarAnAddedModel__11tCarManagerR10tCarModelsRc
