.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MCRD_getcard, 0x48

glabel MCRD_getcard
    /* 40A44 80050244 FFFF8424 */  addiu      $a0, $a0, -0x1
    /* 40A48 80050248 0580053C */  lui        $a1, %hi(gMemCardInfo)
    /* 40A4C 8005024C 682DA524 */  addiu      $a1, $a1, %lo(gMemCardInfo)
    /* 40A50 80050250 04008230 */  andi       $v0, $a0, 0x4
    /* 40A54 80050254 80100200 */  sll        $v0, $v0, 2
    /* 40A58 80050258 03008330 */  andi       $v1, $a0, 0x3
    /* 40A5C 8005025C 25104300 */  or         $v0, $v0, $v1
    /* 40A60 80050260 3C00A2AC */  sw         $v0, 0x3C($a1)
    /* 40A64 80050264 80100400 */  sll        $v0, $a0, 2
    /* 40A68 80050268 21104400 */  addu       $v0, $v0, $a0
    /* 40A6C 8005026C 80100200 */  sll        $v0, $v0, 2
    /* 40A70 80050270 23104400 */  subu       $v0, $v0, $a0
    /* 40A74 80050274 80100200 */  sll        $v0, $v0, 2
    /* 40A78 80050278 21104400 */  addu       $v0, $v0, $a0
    /* 40A7C 8005027C C0100200 */  sll        $v0, $v0, 3
    /* 40A80 80050280 9C04A524 */  addiu      $a1, $a1, 0x49C
    /* 40A84 80050284 0800E003 */  jr         $ra
    /* 40A88 80050288 21104500 */   addu      $v0, $v0, $a1
endlabel MCRD_getcard
