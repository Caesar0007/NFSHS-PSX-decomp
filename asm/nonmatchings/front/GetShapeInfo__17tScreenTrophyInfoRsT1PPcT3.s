.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetShapeInfo__17tScreenTrophyInfoRsT1PPcT3, 0x130

glabel GetShapeInfo__17tScreenTrophyInfoRsT1PPcT3
    /* 31808 80041008 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 3180C 8004100C 21408000 */  addu       $t0, $a0, $zero
    /* 31810 80041010 2400B3AF */  sw         $s3, 0x24($sp)
    /* 31814 80041014 2198A000 */  addu       $s3, $a1, $zero
    /* 31818 80041018 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 3181C 8004101C 2188C000 */  addu       $s1, $a2, $zero
    /* 31820 80041020 0580023C */  lui        $v0, %hi(screenTrophyRoom)
    /* 31824 80041024 6020448C */  lw         $a0, %lo(screenTrophyRoom)($v0)
    /* 31828 80041028 1180033C */  lui        $v1, %hi(D_80114722)
    /* 3182C 8004102C 2800BFAF */  sw         $ra, 0x28($sp)
    /* 31830 80041030 2000B2AF */  sw         $s2, 0x20($sp)
    /* 31834 80041034 1800B0AF */  sw         $s0, 0x18($sp)
    /* 31838 80041038 D000828C */  lw         $v0, 0xD0($a0)
    /* 3183C 8004103C 22476390 */  lbu        $v1, %lo(D_80114722)($v1)
    /* 31840 80041040 40100200 */  sll        $v0, $v0, 1
    /* 31844 80041044 21208200 */  addu       $a0, $a0, $v0
    /* 31848 80041048 1180023C */  lui        $v0, %hi(tournamentManager)
    /* 3184C 8004104C D84A4624 */  addiu      $a2, $v0, %lo(tournamentManager)
    /* 31850 80041050 40100300 */  sll        $v0, $v1, 1
    /* 31854 80041054 21104300 */  addu       $v0, $v0, $v1
    /* 31858 80041058 1800C58C */  lw         $a1, 0x18($a2)
    /* 3185C 8004105C 80100200 */  sll        $v0, $v0, 2
    /* 31860 80041060 2110A200 */  addu       $v0, $a1, $v0
    /* 31864 80041064 02004390 */  lbu        $v1, 0x2($v0)
    /* 31868 80041068 D4008290 */  lbu        $v0, 0xD4($a0)
    /* 3186C 8004106C 00000000 */  nop
    /* 31870 80041070 21186200 */  addu       $v1, $v1, $v0
    /* 31874 80041074 80100300 */  sll        $v0, $v1, 2
    /* 31878 80041078 21104300 */  addu       $v0, $v0, $v1
    /* 3187C 8004107C 80100200 */  sll        $v0, $v0, 2
    /* 31880 80041080 21104300 */  addu       $v0, $v0, $v1
    /* 31884 80041084 80100200 */  sll        $v0, $v0, 2
    /* 31888 80041088 24004224 */  addiu      $v0, $v0, 0x24
    /* 3188C 8004108C 2128A200 */  addu       $a1, $a1, $v0
    /* 31890 80041090 0000A280 */  lb         $v0, 0x0($a1)
    /* 31894 80041094 2190E000 */  addu       $s2, $a3, $zero
    /* 31898 80041098 21104600 */  addu       $v0, $v0, $a2
    /* 3189C 8004109C F0014380 */  lb         $v1, 0x1F0($v0)
    /* 318A0 800410A0 00000000 */  nop
    /* 318A4 800410A4 FFFF6224 */  addiu      $v0, $v1, -0x1
    /* 318A8 800410A8 0300422C */  sltiu      $v0, $v0, 0x3
    /* 318AC 800410AC 02004010 */  beqz       $v0, .L800410B8
    /* 318B0 800410B0 21200000 */   addu      $a0, $zero, $zero
    /* 318B4 800410B4 21206000 */  addu       $a0, $v1, $zero
  .L800410B8:
    /* 318B8 800410B8 0580033C */  lui        $v1, %hi(kBannerColors)
    /* 318BC 800410BC 78206324 */  addiu      $v1, $v1, %lo(kBannerColors)
    /* 318C0 800410C0 00140400 */  sll        $v0, $a0, 16
    /* 318C4 800410C4 83130200 */  sra        $v0, $v0, 14
    /* 318C8 800410C8 21104300 */  addu       $v0, $v0, $v1
    /* 318CC 800410CC 0580103C */  lui        $s0, %hi(gSwapFileNameTI)
    /* 318D0 800410D0 8C201026 */  addiu      $s0, $s0, %lo(gSwapFileNameTI)
    /* 318D4 800410D4 2120C000 */  addu       $a0, $a2, $zero
    /* 318D8 800410D8 02000624 */  addiu      $a2, $zero, 0x2
    /* 318DC 800410DC 0000428C */  lw         $v0, 0x0($v0)
    /* 318E0 800410E0 21380002 */  addu       $a3, $s0, $zero
    /* 318E4 800410E4 640002AD */  sw         $v0, 0x64($t0)
    /* 318E8 800410E8 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 318EC 800410EC D9CE000C */  jal        GetTrophyName__18tTournamentManagerP12tTourneyInfo11tTrophySizePci
    /* 318F0 800410F0 1000A2AF */   sw        $v0, 0x10($sp)
    /* 318F4 800410F4 20000224 */  addiu      $v0, $zero, 0x20
    /* 318F8 800410F8 000022A6 */  sh         $v0, 0x0($s1)
    /* 318FC 800410FC 4000A28F */  lw         $v0, 0x40($sp)
    /* 31900 80041100 00000000 */  nop
    /* 31904 80041104 000050AC */  sw         $s0, 0x0($v0)
    /* 31908 80041108 0180023C */  lui        $v0, %hi(D_80011E84)
    /* 3190C 8004110C 841E4224 */  addiu      $v0, $v0, %lo(D_80011E84)
    /* 31910 80041110 000042AE */  sw         $v0, 0x0($s2)
    /* 31914 80041114 0B000224 */  addiu      $v0, $zero, 0xB
    /* 31918 80041118 000062A6 */  sh         $v0, 0x0($s3)
    /* 3191C 8004111C 2800BF8F */  lw         $ra, 0x28($sp)
    /* 31920 80041120 2400B38F */  lw         $s3, 0x24($sp)
    /* 31924 80041124 2000B28F */  lw         $s2, 0x20($sp)
    /* 31928 80041128 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 3192C 8004112C 1800B08F */  lw         $s0, 0x18($sp)
    /* 31930 80041130 0800E003 */  jr         $ra
    /* 31934 80041134 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel GetShapeInfo__17tScreenTrophyInfoRsT1PPcT3
