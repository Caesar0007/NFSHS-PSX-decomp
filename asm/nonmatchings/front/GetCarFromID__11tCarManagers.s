.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetCarFromID__11tCarManagers, 0x50

glabel GetCarFromID__11tCarManagers
    /* 6A4C 8001624C 0000868C */  lw         $a2, 0x0($a0)
    /* 6A50 80016250 00000000 */  nop
    /* 6A54 80016254 0F00C010 */  beqz       $a2, .L80016294
    /* 6A58 80016258 21180000 */   addu      $v1, $zero, $zero
    /* 6A5C 8001625C 00140500 */  sll        $v0, $a1, 16
    /* 6A60 80016260 033C0200 */  sra        $a3, $v0, 16
    /* 6A64 80016264 2128C000 */  addu       $a1, $a2, $zero
    /* 6A68 80016268 0400848C */  lw         $a0, 0x4($a0)
  .L8001626C:
    /* 6A6C 8001626C 00000000 */  nop
    /* 6A70 80016270 00008280 */  lb         $v0, 0x0($a0)
    /* 6A74 80016274 00000000 */  nop
    /* 6A78 80016278 03004714 */  bne        $v0, $a3, .L80016288
    /* 6A7C 8001627C 01006324 */   addiu     $v1, $v1, 0x1
    /* 6A80 80016280 0800E003 */  jr         $ra
    /* 6A84 80016284 21108000 */   addu      $v0, $a0, $zero
  .L80016288:
    /* 6A88 80016288 2B106500 */  sltu       $v0, $v1, $a1
    /* 6A8C 8001628C F7FF4014 */  bnez       $v0, .L8001626C
    /* 6A90 80016290 CC008424 */   addiu     $a0, $a0, 0xCC
  .L80016294:
    /* 6A94 80016294 0800E003 */  jr         $ra
    /* 6A98 80016298 21100000 */   addu      $v0, $zero, $zero
endlabel GetCarFromID__11tCarManagers
