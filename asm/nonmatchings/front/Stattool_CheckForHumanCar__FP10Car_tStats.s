.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Stattool_CheckForHumanCar__FP10Car_tStats, 0x88

glabel Stattool_CheckForHumanCar__FP10Car_tStats
    /* 3B6C4 8004AEC4 21300000 */  addu       $a2, $zero, $zero
    /* 3B6C8 8004AEC8 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 3B6CC 8004AECC EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* 3B6D0 8004AED0 C8034394 */  lhu        $v1, 0x3C8($v0)
    /* 3B6D4 8004AED4 CC034294 */  lhu        $v0, 0x3CC($v0)
    /* 3B6D8 8004AED8 00000000 */  nop
    /* 3B6DC 8004AEDC 21186200 */  addu       $v1, $v1, $v0
    /* 3B6E0 8004AEE0 001C0300 */  sll        $v1, $v1, 16
    /* 3B6E4 8004AEE4 031C0300 */  sra        $v1, $v1, 16
    /* 3B6E8 8004AEE8 16006018 */  blez       $v1, .L8004AF44
    /* 3B6EC 8004AEEC 2128C000 */   addu      $a1, $a2, $zero
    /* 3B6F0 8004AEF0 01000824 */  addiu      $t0, $zero, 0x1
    /* 3B6F4 8004AEF4 21386000 */  addu       $a3, $v1, $zero
    /* 3B6F8 8004AEF8 00140500 */  sll        $v0, $a1, 16
  .L8004AEFC:
    /* 3B6FC 8004AEFC 03140200 */  sra        $v0, $v0, 16
    /* 3B700 8004AF00 80180200 */  sll        $v1, $v0, 2
    /* 3B704 8004AF04 21186200 */  addu       $v1, $v1, $v0
    /* 3B708 8004AF08 40190300 */  sll        $v1, $v1, 5
    /* 3B70C 8004AF0C 21186400 */  addu       $v1, $v1, $a0
    /* 3B710 8004AF10 6C00628C */  lw         $v0, 0x6C($v1)
    /* 3B714 8004AF14 00000000 */  nop
    /* 3B718 8004AF18 04004230 */  andi       $v0, $v0, 0x4
    /* 3B71C 8004AF1C 02004010 */  beqz       $v0, .L8004AF28
    /* 3B720 8004AF20 0100A224 */   addiu     $v0, $a1, 0x1
    /* 3B724 8004AF24 01000624 */  addiu      $a2, $zero, 0x1
  .L8004AF28:
    /* 3B728 8004AF28 0600C810 */  beq        $a2, $t0, .L8004AF44
    /* 3B72C 8004AF2C 21284000 */   addu      $a1, $v0, $zero
    /* 3B730 8004AF30 00140200 */  sll        $v0, $v0, 16
    /* 3B734 8004AF34 03140200 */  sra        $v0, $v0, 16
    /* 3B738 8004AF38 2A104700 */  slt        $v0, $v0, $a3
    /* 3B73C 8004AF3C EFFF4014 */  bnez       $v0, .L8004AEFC
    /* 3B740 8004AF40 00140500 */   sll       $v0, $a1, 16
  .L8004AF44:
    /* 3B744 8004AF44 0800E003 */  jr         $ra
    /* 3B748 8004AF48 2110C000 */   addu      $v0, $a2, $zero
endlabel Stattool_CheckForHumanCar__FP10Car_tStats
