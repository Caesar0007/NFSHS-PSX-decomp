.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Nfs2_SystemNLibStartUp__Fv, 0x64

glabel Nfs2_SystemNLibStartUp__Fv
    /* 945EC 800A3DEC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 945F0 800A3DF0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 945F4 800A3DF4 DE70030C */  jal        Platform_SysStartUp__Fv
    /* 945F8 800A3DF8 00000000 */   nop
    /* 945FC 800A3DFC BE6C030C */  jal        Loading_GetInitialMemory__Fv
    /* 94600 800A3E00 00000000 */   nop
    /* 94604 800A3E04 1480023C */  lui        $v0, %hi(_6Speech_fgUndefined)
    /* 94608 800A3E08 88CD428C */  lw         $v0, %lo(_6Speech_fgUndefined)($v0)
    /* 9460C 800A3E0C 00000000 */  nop
    /* 94610 800A3E10 09004014 */  bnez       $v0, .L800A3E38
    /* 94614 800A3E14 00000000 */   nop
    /* 94618 800A3E18 578F020C */  jal        __builtin_new
    /* 9461C 800A3E1C 50000424 */   addiu     $a0, $zero, 0x50
    /* 94620 800A3E20 0580033C */  lui        $v1, %hi(_vt_Q26Speech7Speaker)
    /* 94624 800A3E24 C45D6324 */  addiu      $v1, $v1, %lo(_vt_Q26Speech7Speaker)
    /* 94628 800A3E28 4C0043AC */  sw         $v1, 0x4C($v0)
    /* 9462C 800A3E2C 480040AC */  sw         $zero, 0x48($v0)
    /* 94630 800A3E30 1480013C */  lui        $at, %hi(_6Speech_fgUndefined)
    /* 94634 800A3E34 88CD22AC */  sw         $v0, %lo(_6Speech_fgUndefined)($at)
  .L800A3E38:
    /* 94638 800A3E38 22CE020C */  jal        Render_InitLibRender__Fv
    /* 9463C 800A3E3C 00000000 */   nop
    /* 94640 800A3E40 1000BF8F */  lw         $ra, 0x10($sp)
    /* 94644 800A3E44 00000000 */  nop
    /* 94648 800A3E48 0800E003 */  jr         $ra
    /* 9464C 800A3E4C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Nfs2_SystemNLibStartUp__Fv
