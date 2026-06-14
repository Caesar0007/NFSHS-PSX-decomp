.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _padSetActAlign, 0x68

glabel _padSetActAlign
    /* F63F4 80105BF4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* F63F8 80105BF8 1000B0AF */  sw         $s0, 0x10($sp)
    /* F63FC 80105BFC 21808000 */  addu       $s0, $a0, $zero
    /* F6400 80105C00 1400B1AF */  sw         $s1, 0x14($sp)
    /* F6404 80105C04 1380023C */  lui        $v0, %hi(_padFuncChkEng)
    /* F6408 80105C08 947C428C */  lw         $v0, %lo(_padFuncChkEng)($v0)
    /* F640C 80105C0C 1800BFAF */  sw         $ra, 0x18($sp)
    /* F6410 80105C10 09F84000 */  jalr       $v0
    /* F6414 80105C14 2188A000 */   addu      $s1, $a1, $zero
    /* F6418 80105C18 0B004014 */  bnez       $v0, .L80105C48
    /* F641C 80105C1C 21100000 */   addu      $v0, $zero, $zero
    /* F6420 80105C20 01000224 */  addiu      $v0, $zero, 0x1
    /* F6424 80105C24 01000324 */  addiu      $v1, $zero, 0x1
    /* F6428 80105C28 460003A2 */  sb         $v1, 0x46($s0)
    /* F642C 80105C2C 1080033C */  lui        $v1, %hi(func_80105C5C)
    /* F6430 80105C30 5C5C6324 */  addiu      $v1, $v1, %lo(func_80105C5C)
    /* F6434 80105C34 140003AE */  sw         $v1, 0x14($s0)
    /* F6438 80105C38 1080033C */  lui        $v1, %hi(func_80105C78)
    /* F643C 80105C3C 785C6324 */  addiu      $v1, $v1, %lo(func_80105C78)
    /* F6440 80105C40 200011AE */  sw         $s1, 0x20($s0)
    /* F6444 80105C44 180003AE */  sw         $v1, 0x18($s0)
  .L80105C48:
    /* F6448 80105C48 1800BF8F */  lw         $ra, 0x18($sp)
    /* F644C 80105C4C 1400B18F */  lw         $s1, 0x14($sp)
    /* F6450 80105C50 1000B08F */  lw         $s0, 0x10($sp)
    /* F6454 80105C54 0800E003 */  jr         $ra
    /* F6458 80105C58 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel _padSetActAlign
