.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Initialize__23tScreenPinkSlipCongrats, 0x58

glabel Initialize__23tScreenPinkSlipCongrats
    /* 395EC 80048DEC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 395F0 80048DF0 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 395F4 80048DF4 1180033C */  lui        $v1, %hi(frontEnd)
    /* 395F8 80048DF8 00466324 */  addiu      $v1, $v1, %lo(frontEnd)
    /* 395FC 80048DFC 1000BFAF */  sw         $ra, 0x10($sp)
    /* 39600 80048E00 840182A4 */  sh         $v0, 0x184($a0)
    /* 39604 80048E04 47006290 */  lbu        $v0, 0x47($v1)
    /* 39608 80048E08 48006390 */  lbu        $v1, 0x48($v1)
    /* 3960C 80048E0C 42100200 */  srl        $v0, $v0, 1
    /* 39610 80048E10 01004224 */  addiu      $v0, $v0, 0x1
    /* 39614 80048E14 2A186200 */  slt        $v1, $v1, $v0
    /* 39618 80048E18 03006014 */  bnez       $v1, .L80048E28
    /* 3961C 80048E1C 01000224 */   addiu     $v0, $zero, 0x1
    /* 39620 80048E20 8B230108 */  j          .L80048E2C
    /* 39624 80048E24 840180A4 */   sh        $zero, 0x184($a0)
  .L80048E28:
    /* 39628 80048E28 840182A4 */  sh         $v0, 0x184($a0)
  .L80048E2C:
    /* 3962C 80048E2C 8B22010C */  jal        Initialize__15tScreenCongrats
    /* 39630 80048E30 00000000 */   nop
    /* 39634 80048E34 1000BF8F */  lw         $ra, 0x10($sp)
    /* 39638 80048E38 00000000 */  nop
    /* 3963C 80048E3C 0800E003 */  jr         $ra
    /* 39640 80048E40 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Initialize__23tScreenPinkSlipCongrats
