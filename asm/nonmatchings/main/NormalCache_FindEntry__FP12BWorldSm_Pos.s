.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching NormalCache_FindEntry__FP12BWorldSm_Pos, 0xC4

glabel NormalCache_FindEntry__FP12BWorldSm_Pos
    /* 708E8 800800E8 1180023C */  lui        $v0, %hi(BWSM_NormalCache)
    /* 708EC 800800EC ACF04624 */  addiu      $a2, $v0, %lo(BWSM_NormalCache)
    /* 708F0 800800F0 21380000 */  addu       $a3, $zero, $zero
    /* 708F4 800800F4 0200C524 */  addiu      $a1, $a2, 0x2
    /* 708F8 800800F8 8C02828F */  lw         $v0, %gp_rel(BWSM_NormalCacheSysTime)($gp)
    /* 708FC 800800FC 00008984 */  lh         $t1, 0x0($a0)
    /* 70900 80080100 01004224 */  addiu      $v0, $v0, 0x1
    /* 70904 80080104 8C0282AF */  sw         $v0, %gp_rel(BWSM_NormalCacheSysTime)($gp)
    /* 70908 80080108 74008880 */  lb         $t0, 0x74($a0)
  .L8008010C:
    /* 7090C 8008010C 0000C284 */  lh         $v0, 0x0($a2)
    /* 70910 80080110 00000000 */  nop
    /* 70914 80080114 0A004914 */  bne        $v0, $t1, .L80080140
    /* 70918 80080118 00000000 */   nop
    /* 7091C 8008011C 0100A280 */  lb         $v0, 0x1($a1)
    /* 70920 80080120 00000000 */  nop
    /* 70924 80080124 06004814 */  bne        $v0, $t0, .L80080140
    /* 70928 80080128 00000000 */   nop
    /* 7092C 8008012C 0000A390 */  lbu        $v1, 0x0($a1)
    /* 70930 80080130 5B008280 */  lb         $v0, 0x5B($a0)
    /* 70934 80080134 00000000 */  nop
    /* 70938 80080138 0B006210 */  beq        $v1, $v0, .L80080168
    /* 7093C 8008013C 00000000 */   nop
  .L80080140:
    /* 70940 80080140 2000A524 */  addiu      $a1, $a1, 0x20
    /* 70944 80080144 0100E724 */  addiu      $a3, $a3, 0x1
    /* 70948 80080148 1000E228 */  slti       $v0, $a3, 0x10
    /* 7094C 8008014C EFFF4014 */  bnez       $v0, .L8008010C
    /* 70950 80080150 2000C624 */   addiu     $a2, $a2, 0x20
  .L80080154:
    /* 70954 80080154 1000E228 */  slti       $v0, $a3, 0x10
    /* 70958 80080158 06004014 */  bnez       $v0, .L80080174
    /* 7095C 8008015C 21100000 */   addu      $v0, $zero, $zero
    /* 70960 80080160 0800E003 */  jr         $ra
    /* 70964 80080164 00000000 */   nop
  .L80080168:
    /* 70968 80080168 8C02828F */  lw         $v0, %gp_rel(BWSM_NormalCacheSysTime)($gp)
    /* 7096C 8008016C 55000208 */  j          .L80080154
    /* 70970 80080170 1C00C2AC */   sw        $v0, 0x1C($a2)
  .L80080174:
    /* 70974 80080174 0400CA8C */  lw         $t2, 0x4($a2)
    /* 70978 80080178 0800CB8C */  lw         $t3, 0x8($a2)
    /* 7097C 8008017C 0C00CC8C */  lw         $t4, 0xC($a2)
    /* 70980 80080180 5C008AAC */  sw         $t2, 0x5C($a0)
    /* 70984 80080184 60008BAC */  sw         $t3, 0x60($a0)
    /* 70988 80080188 64008CAC */  sw         $t4, 0x64($a0)
    /* 7098C 8008018C 1000CA8C */  lw         $t2, 0x10($a2)
    /* 70990 80080190 1400CB8C */  lw         $t3, 0x14($a2)
    /* 70994 80080194 1800CC8C */  lw         $t4, 0x18($a2)
    /* 70998 80080198 68008AAC */  sw         $t2, 0x68($a0)
    /* 7099C 8008019C 6C008BAC */  sw         $t3, 0x6C($a0)
    /* 709A0 800801A0 70008CAC */  sw         $t4, 0x70($a0)
    /* 709A4 800801A4 0800E003 */  jr         $ra
    /* 709A8 800801A8 01000224 */   addiu     $v0, $zero, 0x1
endlabel NormalCache_FindEntry__FP12BWorldSm_Pos
