.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CalcTrackFinishDamageBill__18tTournamentManagerbRlT2, 0x1C4

glabel CalcTrackFinishDamageBill__18tTournamentManagerbRlT2
    /* 2346C 80032C6C 10FFBD27 */  addiu      $sp, $sp, -0xF0
    /* 23470 80032C70 E400B1AF */  sw         $s1, 0xE4($sp)
    /* 23474 80032C74 2188C000 */  addu       $s1, $a2, $zero
    /* 23478 80032C78 E800B2AF */  sw         $s2, 0xE8($sp)
    /* 2347C 80032C7C 2190E000 */  addu       $s2, $a3, $zero
    /* 23480 80032C80 EC00BFAF */  sw         $ra, 0xEC($sp)
    /* 23484 80032C84 5C00A010 */  beqz       $a1, .L80032DF8
    /* 23488 80032C88 E000B0AF */   sw        $s0, 0xE0($sp)
    /* 2348C 80032C8C 1180023C */  lui        $v0, %hi(Cars_gNewCarStatsList)
    /* 23490 80032C90 44FB5024 */  addiu      $s0, $v0, %lo(Cars_gNewCarStatsList)
    /* 23494 80032C94 1180043C */  lui        $a0, %hi(carManager)
    /* 23498 80032C98 1180023C */  lui        $v0, %hi(D_80114723)
    /* 2349C 80032C9C 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 234A0 80032CA0 1000A627 */  addiu      $a2, $sp, 0x10
    /* 234A4 80032CA4 23474590 */  lbu        $a1, %lo(D_80114723)($v0)
    /* 234A8 80032CA8 D35B000C */  jal        GetGarageCar__11tCarManagersR8tCarInfos
    /* 234AC 80032CAC 21380000 */   addu      $a3, $zero, $zero
    /* 234B0 80032CB0 21180000 */  addu       $v1, $zero, $zero
    /* 234B4 80032CB4 01000824 */  addiu      $t0, $zero, 0x1
    /* 234B8 80032CB8 1000A727 */  addiu      $a3, $sp, 0x10
    /* 234BC 80032CBC 04000424 */  addiu      $a0, $zero, 0x4
    /* 234C0 80032CC0 3000A58F */  lw         $a1, 0x30($sp)
    /* 234C4 80032CC4 D400A693 */  lbu        $a2, 0xD4($sp)
  .L80032CC8:
    /* 234C8 80032CC8 04106800 */  sllv       $v0, $t0, $v1
    /* 234CC 80032CCC 00140200 */  sll        $v0, $v0, 16
    /* 234D0 80032CD0 03140200 */  sra        $v0, $v0, 16
    /* 234D4 80032CD4 2410C200 */  and        $v0, $a2, $v0
    /* 234D8 80032CD8 04004010 */  beqz       $v0, .L80032CEC
    /* 234DC 80032CDC 2110E400 */   addu      $v0, $a3, $a0
    /* 234E0 80032CE0 2000428C */  lw         $v0, 0x20($v0)
    /* 234E4 80032CE4 00000000 */  nop
    /* 234E8 80032CE8 2128A200 */  addu       $a1, $a1, $v0
  .L80032CEC:
    /* 234EC 80032CEC 01006324 */  addiu      $v1, $v1, 0x1
    /* 234F0 80032CF0 02006228 */  slti       $v0, $v1, 0x2
    /* 234F4 80032CF4 F4FF4014 */  bnez       $v0, .L80032CC8
    /* 234F8 80032CF8 04008424 */   addiu     $a0, $a0, 0x4
    /* 234FC 80032CFC 7000038E */  lw         $v1, 0x70($s0)
    /* 23500 80032D00 00000000 */  nop
    /* 23504 80032D04 02006104 */  bgez       $v1, .L80032D10
    /* 23508 80032D08 FFFF0234 */   ori       $v0, $zero, 0xFFFF
    /* 2350C 80032D0C 21186200 */  addu       $v1, $v1, $v0
  .L80032D10:
    /* 23510 80032D10 031C0300 */  sra        $v1, $v1, 16
    /* 23514 80032D14 2A006014 */  bnez       $v1, .L80032DC0
    /* 23518 80032D18 1800A300 */   mult      $a1, $v1
    /* 2351C 80032D1C 8400028E */  lw         $v0, 0x84($s0)
    /* 23520 80032D20 00000000 */  nop
    /* 23524 80032D24 04004228 */  slti       $v0, $v0, 0x4
    /* 23528 80032D28 24004010 */  beqz       $v0, .L80032DBC
    /* 2352C 80032D2C 6666023C */   lui       $v0, (0x66666667 >> 16)
    /* 23530 80032D30 67664234 */  ori        $v0, $v0, (0x66666667 & 0xFFFF)
    /* 23534 80032D34 1800A200 */  mult       $a1, $v0
    /* 23538 80032D38 0580023C */  lui        $v0, %hi(D_80051A60)
    /* 2353C 80032D3C 0580063C */  lui        $a2, %hi(D_80051A64)
    /* 23540 80032D40 8400038E */  lw         $v1, 0x84($s0)
    /* 23544 80032D44 C3270500 */  sra        $a0, $a1, 31
    /* 23548 80032D48 601A40AC */  sw         $zero, %lo(D_80051A60)($v0)
    /* 2354C 80032D4C 10480000 */  mfhi       $t1
    /* 23550 80032D50 C3100900 */  sra        $v0, $t1, 3
    /* 23554 80032D54 23104400 */  subu       $v0, $v0, $a0
    /* 23558 80032D58 641AC2AC */  sw         $v0, %lo(D_80051A64)($a2)
    /* 2355C 80032D5C 02000224 */  addiu      $v0, $zero, 0x2
    /* 23560 80032D60 0C006214 */  bne        $v1, $v0, .L80032D94
    /* 23564 80032D64 03000224 */   addiu     $v0, $zero, 0x3
    /* 23568 80032D68 EB51033C */  lui        $v1, (0x51EB851F >> 16)
    /* 2356C 80032D6C 1F856334 */  ori        $v1, $v1, (0x51EB851F & 0xFFFF)
    /* 23570 80032D70 40100500 */  sll        $v0, $a1, 1
    /* 23574 80032D74 21104500 */  addu       $v0, $v0, $a1
    /* 23578 80032D78 18004300 */  mult       $v0, $v1
    /* 2357C 80032D7C C3170200 */  sra        $v0, $v0, 31
    /* 23580 80032D80 10480000 */  mfhi       $t1
    /* 23584 80032D84 43190900 */  sra        $v1, $t1, 5
    /* 23588 80032D88 23186200 */  subu       $v1, $v1, $v0
    /* 2358C 80032D8C 7ECB0008 */  j          .L80032DF8
    /* 23590 80032D90 641AC3AC */   sw        $v1, %lo(D_80051A64)($a2)
  .L80032D94:
    /* 23594 80032D94 19006214 */  bne        $v1, $v0, .L80032DFC
    /* 23598 80032D98 0580023C */   lui       $v0, %hi(D_80051A60)
    /* 2359C 80032D9C EB51023C */  lui        $v0, (0x51EB851F >> 16)
    /* 235A0 80032DA0 1F854234 */  ori        $v0, $v0, (0x51EB851F & 0xFFFF)
    /* 235A4 80032DA4 1800A200 */  mult       $a1, $v0
    /* 235A8 80032DA8 10480000 */  mfhi       $t1
    /* 235AC 80032DAC 43110900 */  sra        $v0, $t1, 5
    /* 235B0 80032DB0 23104400 */  subu       $v0, $v0, $a0
    /* 235B4 80032DB4 7ECB0008 */  j          .L80032DF8
    /* 235B8 80032DB8 641AC2AC */   sw        $v0, %lo(D_80051A64)($a2)
  .L80032DBC:
    /* 235BC 80032DBC 1800A300 */  mult       $a1, $v1
  .L80032DC0:
    /* 235C0 80032DC0 DB68043C */  lui        $a0, (0x68DB8BAD >> 16)
    /* 235C4 80032DC4 AD8B8434 */  ori        $a0, $a0, (0x68DB8BAD & 0xFFFF)
    /* 235C8 80032DC8 12100000 */  mflo       $v0
    /* 235CC 80032DCC 40180200 */  sll        $v1, $v0, 1
    /* 235D0 80032DD0 21186200 */  addu       $v1, $v1, $v0
    /* 235D4 80032DD4 18006400 */  mult       $v1, $a0
    /* 235D8 80032DD8 0580023C */  lui        $v0, %hi(D_80051A64)
    /* 235DC 80032DDC 0580043C */  lui        $a0, %hi(D_80051A60)
    /* 235E0 80032DE0 C31F0300 */  sra        $v1, $v1, 31
    /* 235E4 80032DE4 641A40AC */  sw         $zero, %lo(D_80051A64)($v0)
    /* 235E8 80032DE8 10400000 */  mfhi       $t0
    /* 235EC 80032DEC 03130800 */  sra        $v0, $t0, 12
    /* 235F0 80032DF0 23104300 */  subu       $v0, $v0, $v1
    /* 235F4 80032DF4 601A82AC */  sw         $v0, %lo(D_80051A60)($a0)
  .L80032DF8:
    /* 235F8 80032DF8 0580023C */  lui        $v0, %hi(D_80051A60)
  .L80032DFC:
    /* 235FC 80032DFC 601A428C */  lw         $v0, %lo(D_80051A60)($v0)
    /* 23600 80032E00 00000000 */  nop
    /* 23604 80032E04 000022AE */  sw         $v0, 0x0($s1)
    /* 23608 80032E08 0580023C */  lui        $v0, %hi(D_80051A64)
    /* 2360C 80032E0C 641A428C */  lw         $v0, %lo(D_80051A64)($v0)
    /* 23610 80032E10 00000000 */  nop
    /* 23614 80032E14 000042AE */  sw         $v0, 0x0($s2)
    /* 23618 80032E18 EC00BF8F */  lw         $ra, 0xEC($sp)
    /* 2361C 80032E1C E800B28F */  lw         $s2, 0xE8($sp)
    /* 23620 80032E20 E400B18F */  lw         $s1, 0xE4($sp)
    /* 23624 80032E24 E000B08F */  lw         $s0, 0xE0($sp)
    /* 23628 80032E28 0800E003 */  jr         $ra
    /* 2362C 80032E2C F000BD27 */   addiu     $sp, $sp, 0xF0
endlabel CalcTrackFinishDamageBill__18tTournamentManagerbRlT2
