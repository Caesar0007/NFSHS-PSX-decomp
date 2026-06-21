.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetActuators__23tScreenControllerConfigi, 0x88

glabel SetActuators__23tScreenControllerConfigi
    /* 33924 80043124 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 33928 80043128 1000BFAF */  sw         $ra, 0x10($sp)
    /* 3392C 8004312C 7001828C */  lw         $v0, 0x170($a0)
    /* 33930 80043130 00000000 */  nop
    /* 33934 80043134 03004010 */  beqz       $v0, .L80043144
    /* 33938 80043138 40000224 */   addiu     $v0, $zero, 0x40
    /* 3393C 8004313C 550C0108 */  j          .L80043154
    /* 33940 80043140 700180AC */   sw        $zero, 0x170($a0)
  .L80043144:
    /* 33944 80043144 68008290 */  lbu        $v0, 0x68($a0)
    /* 33948 80043148 00000000 */  nop
    /* 3394C 8004314C 11004010 */  beqz       $v0, .L80043194
    /* 33950 80043150 FFFF4224 */   addiu     $v0, $v0, -0x1
  .L80043154:
    /* 33954 80043154 680082A0 */  sb         $v0, 0x68($a0)
    /* 33958 80043158 68008290 */  lbu        $v0, 0x68($a0)
    /* 3395C 8004315C 00000000 */  nop
    /* 33960 80043160 0C004010 */  beqz       $v0, .L80043194
    /* 33964 80043164 1480023C */   lui       $v0, %hi(ticks)
    /* 33968 80043168 1280033C */  lui        $v1, %hi(Force_rand_256)
    /* 3396C 8004316C ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 33970 80043170 60FC6324 */  addiu      $v1, $v1, %lo(Force_rand_256)
    /* 33974 80043174 83100200 */  sra        $v0, $v0, 2
    /* 33978 80043178 FF004230 */  andi       $v0, $v0, 0xFF
    /* 3397C 8004317C 21104300 */  addu       $v0, $v0, $v1
    /* 33980 80043180 00004290 */  lbu        $v0, 0x0($v0)
    /* 33984 80043184 6B0085A0 */  sb         $a1, 0x6B($a0)
    /* 33988 80043188 2A104500 */  slt        $v0, $v0, $a1
    /* 3398C 8004318C 670C0108 */  j          .L8004319C
    /* 33990 80043190 6A0082A0 */   sb        $v0, 0x6A($a0)
  .L80043194:
    /* 33994 80043194 460C010C */  jal        ClearActuators__23tScreenControllerConfig
    /* 33998 80043198 00000000 */   nop
  .L8004319C:
    /* 3399C 8004319C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 339A0 800431A0 00000000 */  nop
    /* 339A4 800431A4 0800E003 */  jr         $ra
    /* 339A8 800431A8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SetActuators__23tScreenControllerConfigi
