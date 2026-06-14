.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Platform_SysStartUp__Fv, 0xD8

glabel Platform_SysStartUp__Fv
    /* CCB78 800DC378 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* CCB7C 800DC37C 1F80053C */  lui        $a1, (0x801FC000 >> 16)
    /* CCB80 800DC380 00C0A534 */  ori        $a1, $a1, (0x801FC000 & 0xFFFF)
    /* CCB84 800DC384 1580043C */  lui        $a0, %hi(D_80148B0C)
    /* CCB88 800DC388 0C8B8424 */  addiu      $a0, $a0, %lo(D_80148B0C)
    /* CCB8C 800DC38C 2328A400 */  subu       $a1, $a1, $a0
    /* CCB90 800DC390 2400BFAF */  sw         $ra, 0x24($sp)
    /* CCB94 800DC394 2000B0AF */  sw         $s0, 0x20($sp)
    /* CCB98 800DC398 1480013C */  lui        $at, %hi(disablecd)
    /* CCB9C 800DC39C 58DC20AC */  sw         $zero, %lo(disablecd)($at)
    /* CCBA0 800DC3A0 1480013C */  lui        $at, %hi(nfs_sysInfo)
    /* CCBA4 800DC3A4 B4D225AC */  sw         $a1, %lo(nfs_sysInfo)($at)
    /* CCBA8 800DC3A8 60D0030C */  jal        initmemadr
    /* CCBAC 800DC3AC 00000000 */   nop
    /* CCBB0 800DC3B0 1671030C */  jal        nfs2eacinit__Fv
    /* CCBB4 800DC3B4 00000000 */   nop
    /* CCBB8 800DC3B8 00020424 */  addiu      $a0, $zero, 0x200
    /* CCBBC 800DC3BC F0000524 */  addiu      $a1, $zero, 0xF0
    /* CCBC0 800DC3C0 01000624 */  addiu      $a2, $zero, 0x1
    /* CCBC4 800DC3C4 2180C000 */  addu       $s0, $a2, $zero
    /* CCBC8 800DC3C8 21380000 */  addu       $a3, $zero, $zero
    /* CCBCC 800DC3CC 1000B0AF */  sw         $s0, 0x10($sp)
    /* CCBD0 800DC3D0 1400A0AF */  sw         $zero, 0x14($sp)
    /* CCBD4 800DC3D4 1800A0AF */  sw         $zero, 0x18($sp)
    /* CCBD8 800DC3D8 5FF9020C */  jal        Draw_SetEnvironment__Fiiiiiiii
    /* CCBDC 800DC3DC 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* CCBE0 800DC3E0 21200000 */  addu       $a0, $zero, $zero
    /* CCBE4 800DC3E4 01000524 */  addiu      $a1, $zero, 0x1
    /* CCBE8 800DC3E8 7DC1030C */  jal        initlinkmode
    /* CCBEC 800DC3EC 2130A000 */   addu      $a2, $a1, $zero
    /* CCBF0 800DC3F0 1480043C */  lui        $a0, %hi(D_8013DAA0)
    /* CCBF4 800DC3F4 B3CE030C */  jal        setdirectory
    /* CCBF8 800DC3F8 A0DA8424 */   addiu     $a0, $a0, %lo(D_8013DAA0)
    /* CCBFC 800DC3FC 21200000 */  addu       $a0, $zero, $zero
    /* CCC00 800DC400 E8030524 */  addiu      $a1, $zero, 0x3E8
    /* CCC04 800DC404 7DC1030C */  jal        initlinkmode
    /* CCC08 800DC408 01000624 */   addiu     $a2, $zero, 0x1
    /* CCC0C 800DC40C 21200000 */  addu       $a0, $zero, $zero
    /* CCC10 800DC410 E8030524 */  addiu      $a1, $zero, 0x3E8
    /* CCC14 800DC414 7DC1030C */  jal        initlinkmode
    /* CCC18 800DC418 01000624 */   addiu     $a2, $zero, 0x1
    /* CCC1C 800DC41C 501590AF */  sw         $s0, %gp_rel(gSysStartUp)($gp)
    /* CCC20 800DC420 7CD0030C */  jal        inittimer
    /* CCC24 800DC424 80000424 */   addiu     $a0, $zero, 0x80
    /* CCC28 800DC428 859B020C */  jal        Paths_StartUp__Fv
    /* CCC2C 800DC42C 00000000 */   nop
    /* CCC30 800DC430 1E000424 */  addiu      $a0, $zero, 0x1E
    /* CCC34 800DC434 00200524 */  addiu      $a1, $zero, 0x2000
    /* CCC38 800DC438 6CC4030C */  jal        initasync
    /* CCC3C 800DC43C 21300000 */   addu      $a2, $zero, $zero
    /* CCC40 800DC440 2400BF8F */  lw         $ra, 0x24($sp)
    /* CCC44 800DC444 2000B08F */  lw         $s0, 0x20($sp)
    /* CCC48 800DC448 0800E003 */  jr         $ra
    /* CCC4C 800DC44C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Platform_SysStartUp__Fv
