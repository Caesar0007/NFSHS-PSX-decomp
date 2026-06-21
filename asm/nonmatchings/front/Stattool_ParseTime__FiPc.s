.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Stattool_ParseTime__FiPc, 0x118

glabel Stattool_ParseTime__FiPc
    /* 3B19C 8004A99C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 3B1A0 8004A9A0 21508000 */  addu       $t2, $a0, $zero
    /* 3B1A4 8004A9A4 2000B0AF */  sw         $s0, 0x20($sp)
    /* 3B1A8 8004A9A8 2400BFAF */  sw         $ra, 0x24($sp)
    /* 3B1AC 8004A9AC 89D8030C */  jal        __floatsisf
    /* 3B1B0 8004A9B0 2180A000 */   addu      $s0, $a1, $zero
    /* 3B1B4 8004A9B4 233F053C */  lui        $a1, (0x3F23D70A >> 16)
    /* 3B1B8 8004A9B8 0AD7A534 */  ori        $a1, $a1, (0x3F23D70A & 0xFFFF)
    /* 3B1BC 8004A9BC B9D9030C */  jal        __divsf3
    /* 3B1C0 8004A9C0 21204000 */   addu      $a0, $v0, $zero
    /* 3B1C4 8004A9C4 4ECE030C */  jal        __fixsfsi
    /* 3B1C8 8004A9C8 21204000 */   addu      $a0, $v0, $zero
    /* 3B1CC 8004A9CC 21504000 */  addu       $t2, $v0, $zero
    /* 3B1D0 8004A9D0 7605023C */  lui        $v0, (0x57619F1 >> 16)
    /* 3B1D4 8004A9D4 F1194234 */  ori        $v0, $v0, (0x57619F1 & 0xFFFF)
    /* 3B1D8 8004A9D8 18004201 */  mult       $t2, $v0
    /* 3B1DC 8004A9DC EB51033C */  lui        $v1, (0x51EB851F >> 16)
    /* 3B1E0 8004A9E0 1F856334 */  ori        $v1, $v1, (0x51EB851F & 0xFFFF)
    /* 3B1E4 8004A9E4 C3170A00 */  sra        $v0, $t2, 31
    /* 3B1E8 8004A9E8 10580000 */  mfhi       $t3
    /* 3B1EC 8004A9EC C3310B00 */  sra        $a2, $t3, 7
    /* 3B1F0 8004A9F0 2330C200 */  subu       $a2, $a2, $v0
    /* 3B1F4 8004A9F4 00340600 */  sll        $a2, $a2, 16
    /* 3B1F8 8004A9F8 03340600 */  sra        $a2, $a2, 16
    /* 3B1FC 8004A9FC 40100600 */  sll        $v0, $a2, 1
    /* 3B200 8004AA00 21104600 */  addu       $v0, $v0, $a2
    /* 3B204 8004AA04 00110200 */  sll        $v0, $v0, 4
    /* 3B208 8004AA08 23104600 */  subu       $v0, $v0, $a2
    /* 3B20C 8004AA0C C0100200 */  sll        $v0, $v0, 3
    /* 3B210 8004AA10 23104600 */  subu       $v0, $v0, $a2
    /* 3B214 8004AA14 00110200 */  sll        $v0, $v0, 4
    /* 3B218 8004AA18 23504201 */  subu       $t2, $t2, $v0
    /* 3B21C 8004AA1C 18004301 */  mult       $t2, $v1
    /* 3B220 8004AA20 21200002 */  addu       $a0, $s0, $zero
    /* 3B224 8004AA24 0180053C */  lui        $a1, %hi(D_80012520)
    /* 3B228 8004AA28 2025A524 */  addiu      $a1, $a1, %lo(D_80012520)
    /* 3B22C 8004AA2C 0580073C */  lui        $a3, %hi(minChar)
    /* 3B230 8004AA30 1180093C */  lui        $t1, %hi(frontEnd)
    /* 3B234 8004AA34 00462925 */  addiu      $t1, $t1, %lo(frontEnd)
    /* 3B238 8004AA38 A029E724 */  addiu      $a3, $a3, %lo(minChar)
    /* 3B23C 8004AA3C C3170A00 */  sra        $v0, $t2, 31
    /* 3B240 8004AA40 10580000 */  mfhi       $t3
    /* 3B244 8004AA44 43410B00 */  sra        $t0, $t3, 5
    /* 3B248 8004AA48 23400201 */  subu       $t0, $t0, $v0
    /* 3B24C 8004AA4C 00440800 */  sll        $t0, $t0, 16
    /* 3B250 8004AA50 03440800 */  sra        $t0, $t0, 16
    /* 3B254 8004AA54 40180800 */  sll        $v1, $t0, 1
    /* 3B258 8004AA58 21186800 */  addu       $v1, $v1, $t0
    /* 3B25C 8004AA5C C0180300 */  sll        $v1, $v1, 3
    /* 3B260 8004AA60 21186800 */  addu       $v1, $v1, $t0
    /* 3B264 8004AA64 80180300 */  sll        $v1, $v1, 2
    /* 3B268 8004AA68 40032291 */  lbu        $v0, 0x340($t1)
    /* 3B26C 8004AA6C 23504301 */  subu       $t2, $t2, $v1
    /* 3B270 8004AA70 21104700 */  addu       $v0, $v0, $a3
    /* 3B274 8004AA74 00004790 */  lbu        $a3, 0x0($v0)
    /* 3B278 8004AA78 0580023C */  lui        $v0, %hi(secChar)
    /* 3B27C 8004AA7C 1000A8AF */  sw         $t0, 0x10($sp)
    /* 3B280 8004AA80 40032391 */  lbu        $v1, 0x340($t1)
    /* 3B284 8004AA84 A8294224 */  addiu      $v0, $v0, %lo(secChar)
    /* 3B288 8004AA88 21186200 */  addu       $v1, $v1, $v0
    /* 3B28C 8004AA8C 00140A00 */  sll        $v0, $t2, 16
    /* 3B290 8004AA90 00006390 */  lbu        $v1, 0x0($v1)
    /* 3B294 8004AA94 03140200 */  sra        $v0, $v0, 16
    /* 3B298 8004AA98 1800A2AF */  sw         $v0, 0x18($sp)
    /* 3B29C 8004AA9C 2F91030C */  jal        sprintf
    /* 3B2A0 8004AAA0 1400A3AF */   sw        $v1, 0x14($sp)
    /* 3B2A4 8004AAA4 2400BF8F */  lw         $ra, 0x24($sp)
    /* 3B2A8 8004AAA8 2000B08F */  lw         $s0, 0x20($sp)
    /* 3B2AC 8004AAAC 0800E003 */  jr         $ra
    /* 3B2B0 8004AAB0 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Stattool_ParseTime__FiPc
