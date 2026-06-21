.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PurchaseCar__11tCarManagersss, 0xDC

glabel PurchaseCar__11tCarManagersss
    /* 6C50 80016450 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 6C54 80016454 1400B1AF */  sw         $s1, 0x14($sp)
    /* 6C58 80016458 21888000 */  addu       $s1, $a0, $zero
    /* 6C5C 8001645C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 6C60 80016460 2180E000 */  addu       $s0, $a3, $zero
    /* 6C64 80016464 1800B2AF */  sw         $s2, 0x18($sp)
    /* 6C68 80016468 2190A000 */  addu       $s2, $a1, $zero
    /* 6C6C 8001646C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 6C70 80016470 2198C000 */  addu       $s3, $a2, $zero
    /* 6C74 80016474 1180043C */  lui        $a0, %hi(carManager)
    /* 6C78 80016478 002C0500 */  sll        $a1, $a1, 16
    /* 6C7C 8001647C 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 6C80 80016480 2000BFAF */  sw         $ra, 0x20($sp)
    /* 6C84 80016484 9358000C */  jal        GetCarFromID__11tCarManagers
    /* 6C88 80016488 032C0500 */   sra       $a1, $a1, 16
    /* 6C8C 8001648C 21304000 */  addu       $a2, $v0, $zero
    /* 6C90 80016490 21200000 */  addu       $a0, $zero, $zero
    /* 6C94 80016494 00841000 */  sll        $s0, $s0, 16
    /* 6C98 80016498 03841000 */  sra        $s0, $s0, 16
    /* 6C9C 8001649C C0291000 */  sll        $a1, $s0, 7
    /* 6CA0 800164A0 1180023C */  lui        $v0, %hi(frontEnd)
    /* 6CA4 800164A4 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 6CA8 800164A8 21800202 */  addu       $s0, $s0, $v0
    /* 6CAC 800164AC 00140400 */  sll        $v0, $a0, 16
  .L800164B0:
    /* 6CB0 800164B0 83130200 */  sra        $v0, $v0, 14
    /* 6CB4 800164B4 21104500 */  addu       $v0, $v0, $a1
    /* 6CB8 800164B8 21182202 */  addu       $v1, $s1, $v0
    /* 6CBC 800164BC 08006280 */  lb         $v0, 0x8($v1)
    /* 6CC0 800164C0 00000000 */  nop
    /* 6CC4 800164C4 0B004104 */  bgez       $v0, .L800164F4
    /* 6CC8 800164C8 01008224 */   addiu     $v0, $a0, 0x1
    /* 6CCC 800164CC 080072A0 */  sb         $s2, 0x8($v1)
    /* 6CD0 800164D0 0A0073A0 */  sb         $s3, 0xA($v1)
    /* 6CD4 800164D4 090060A0 */  sb         $zero, 0x9($v1)
    /* 6CD8 800164D8 00002292 */  lbu        $v0, 0x0($s1)
    /* 6CDC 800164DC 00000000 */  nop
    /* 6CE0 800164E0 21108200 */  addu       $v0, $a0, $v0
    /* 6CE4 800164E4 230102A2 */  sb         $v0, 0x123($s0)
    /* 6CE8 800164E8 2000C28C */  lw         $v0, 0x20($a2)
    /* 6CEC 800164EC 44590008 */  j          .L80016510
    /* 6CF0 800164F0 00000000 */   nop
  .L800164F4:
    /* 6CF4 800164F4 21204000 */  addu       $a0, $v0, $zero
    /* 6CF8 800164F8 00140200 */  sll        $v0, $v0, 16
    /* 6CFC 800164FC 03140200 */  sra        $v0, $v0, 16
    /* 6D00 80016500 20004228 */  slti       $v0, $v0, 0x20
    /* 6D04 80016504 EAFF4014 */  bnez       $v0, .L800164B0
    /* 6D08 80016508 00140400 */   sll       $v0, $a0, 16
    /* 6D0C 8001650C 21100000 */  addu       $v0, $zero, $zero
  .L80016510:
    /* 6D10 80016510 2000BF8F */  lw         $ra, 0x20($sp)
    /* 6D14 80016514 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 6D18 80016518 1800B28F */  lw         $s2, 0x18($sp)
    /* 6D1C 8001651C 1400B18F */  lw         $s1, 0x14($sp)
    /* 6D20 80016520 1000B08F */  lw         $s0, 0x10($sp)
    /* 6D24 80016524 0800E003 */  jr         $ra
    /* 6D28 80016528 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel PurchaseCar__11tCarManagersss
