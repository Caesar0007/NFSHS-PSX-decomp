.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Paths_StartUp__Fv, 0x4C

glabel Paths_StartUp__Fv
    /* 97614 800A6E14 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 97618 800A6E18 1480043C */  lui        $a0, %hi(burnPath)
    /* 9761C 800A6E1C E0D28424 */  addiu      $a0, $a0, %lo(burnPath)
    /* 97620 800A6E20 31000324 */  addiu      $v1, $zero, 0x31
    /* 97624 800A6E24 1180023C */  lui        $v0, %hi(Paths_Paths)
    /* 97628 800A6E28 68644224 */  addiu      $v0, $v0, %lo(Paths_Paths)
    /* 9762C 800A6E2C C4004224 */  addiu      $v0, $v0, 0xC4
  .L800A6E30:
    /* 97630 800A6E30 000044AC */  sw         $a0, 0x0($v0)
    /* 97634 800A6E34 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 97638 800A6E38 FDFF6104 */  bgez       $v1, .L800A6E30
    /* 9763C 800A6E3C FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 97640 800A6E40 1180023C */  lui        $v0, %hi(Paths_Paths)
    /* 97644 800A6E44 68644224 */  addiu      $v0, $v0, %lo(Paths_Paths)
    /* 97648 800A6E48 1480033C */  lui        $v1, %hi(fePath)
    /* 9764C 800A6E4C E4D26324 */  addiu      $v1, $v1, %lo(fePath)
    /* 97650 800A6E50 900043AC */  sw         $v1, 0x90($v0)
    /* 97654 800A6E54 800043AC */  sw         $v1, 0x80($v0)
    /* 97658 800A6E58 0800E003 */  jr         $ra
    /* 9765C 800A6E5C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Paths_StartUp__Fv
