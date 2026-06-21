.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetShapeInfo__18tScreenTournSelectRsT1PPcT3, 0xCC

glabel GetShapeInfo__18tScreenTournSelectRsT1PPcT3
    /* 2FFD4 8003F7D4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 2FFD8 8003F7D8 1180023C */  lui        $v0, %hi(frontEnd)
    /* 2FFDC 8003F7DC 00464324 */  addiu      $v1, $v0, %lo(frontEnd)
    /* 2FFE0 8003F7E0 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 2FFE4 8003F7E4 1800B0AF */  sw         $s0, 0x18($sp)
    /* 2FFE8 8003F7E8 22016290 */  lbu        $v0, 0x122($v1)
    /* 2FFEC 8003F7EC 00000000 */  nop
    /* 2FFF0 8003F7F0 04004010 */  beqz       $v0, .L8003F804
    /* 2FFF4 8003F7F4 2148C000 */   addu      $t1, $a2, $zero
    /* 2FFF8 8003F7F8 21016890 */  lbu        $t0, 0x121($v1)
    /* 2FFFC 8003F7FC 03FE0008 */  j          .L8003F80C
    /* 30000 8003F800 1180043C */   lui       $a0, %hi(tournamentManager)
  .L8003F804:
    /* 30004 8003F804 20016890 */  lbu        $t0, 0x120($v1)
    /* 30008 8003F808 1180043C */  lui        $a0, %hi(tournamentManager)
  .L8003F80C:
    /* 3000C 8003F80C D84A8424 */  addiu      $a0, $a0, %lo(tournamentManager)
    /* 30010 8003F810 0580103C */  lui        $s0, %hi(D_80052C90)
    /* 30014 8003F814 902C1026 */  addiu      $s0, $s0, %lo(D_80052C90)
    /* 30018 8003F818 22016390 */  lbu        $v1, 0x122($v1)
    /* 3001C 8003F81C 1800868C */  lw         $a2, 0x18($a0)
    /* 30020 8003F820 40100300 */  sll        $v0, $v1, 1
    /* 30024 8003F824 21104300 */  addu       $v0, $v0, $v1
    /* 30028 8003F828 80100200 */  sll        $v0, $v0, 2
    /* 3002C 8003F82C 2110C200 */  addu       $v0, $a2, $v0
    /* 30030 8003F830 02004390 */  lbu        $v1, 0x2($v0)
    /* 30034 8003F834 40000224 */  addiu      $v0, $zero, 0x40
    /* 30038 8003F838 0000A2A4 */  sh         $v0, 0x0($a1)
    /* 3003C 8003F83C 20000224 */  addiu      $v0, $zero, 0x20
    /* 30040 8003F840 000022A5 */  sh         $v0, 0x0($t1)
    /* 30044 8003F844 0180023C */  lui        $v0, %hi(D_80011D94)
    /* 30048 8003F848 941D4224 */  addiu      $v0, $v0, %lo(D_80011D94)
    /* 3004C 8003F84C 0000E2AC */  sw         $v0, 0x0($a3)
    /* 30050 8003F850 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 30054 8003F854 21380002 */  addu       $a3, $s0, $zero
    /* 30058 8003F858 1000A2AF */  sw         $v0, 0x10($sp)
    /* 3005C 8003F85C 21180301 */  addu       $v1, $t0, $v1
    /* 30060 8003F860 80280300 */  sll        $a1, $v1, 2
    /* 30064 8003F864 2128A300 */  addu       $a1, $a1, $v1
    /* 30068 8003F868 80280500 */  sll        $a1, $a1, 2
    /* 3006C 8003F86C 2128A300 */  addu       $a1, $a1, $v1
    /* 30070 8003F870 80280500 */  sll        $a1, $a1, 2
    /* 30074 8003F874 2400A524 */  addiu      $a1, $a1, 0x24
    /* 30078 8003F878 2128C500 */  addu       $a1, $a2, $a1
    /* 3007C 8003F87C D9CE000C */  jal        GetTrophyName__18tTournamentManagerP12tTourneyInfo11tTrophySizePci
    /* 30080 8003F880 01000624 */   addiu     $a2, $zero, 0x1
    /* 30084 8003F884 3000A28F */  lw         $v0, 0x30($sp)
    /* 30088 8003F888 00000000 */  nop
    /* 3008C 8003F88C 000050AC */  sw         $s0, 0x0($v0)
    /* 30090 8003F890 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 30094 8003F894 1800B08F */  lw         $s0, 0x18($sp)
    /* 30098 8003F898 0800E003 */  jr         $ra
    /* 3009C 8003F89C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel GetShapeInfo__18tScreenTournSelectRsT1PPcT3
