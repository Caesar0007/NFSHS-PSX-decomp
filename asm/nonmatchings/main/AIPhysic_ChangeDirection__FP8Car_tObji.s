.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_ChangeDirection__FP8Car_tObji, 0xB8

glabel AIPhysic_ChangeDirection__FP8Car_tObji
    /* 5D1F0 8006C9F0 21308000 */  addu       $a2, $a0, $zero
    /* 5D1F4 8006C9F4 F006C38C */  lw         $v1, 0x6F0($a2)
    /* 5D1F8 8006C9F8 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 5D1FC 8006C9FC 0E006214 */  bne        $v1, $v0, .L8006CA38
    /* 5D200 8006CA00 01000224 */   addiu     $v0, $zero, 0x1
    /* 5D204 8006CA04 1280023C */  lui        $v0, %hi(simGlobal)
    /* 5D208 8006CA08 ACE04724 */  addiu      $a3, $v0, %lo(simGlobal)
    /* 5D20C 8006CA0C 0400E48C */  lw         $a0, 0x4($a3)
    /* 5D210 8006CA10 F406C38C */  lw         $v1, 0x6F4($a2)
    /* 5D214 8006CA14 EC06C28C */  lw         $v0, 0x6EC($a2)
    /* 5D218 8006CA18 23208300 */  subu       $a0, $a0, $v1
    /* 5D21C 8006CA1C C21F0200 */  srl        $v1, $v0, 31
    /* 5D220 8006CA20 21104300 */  addu       $v0, $v0, $v1
    /* 5D224 8006CA24 43100200 */  sra        $v0, $v0, 1
    /* 5D228 8006CA28 2A104400 */  slt        $v0, $v0, $a0
    /* 5D22C 8006CA2C 18004014 */  bnez       $v0, .L8006CA90
    /* 5D230 8006CA30 01000224 */   addiu     $v0, $zero, 0x1
    /* 5D234 8006CA34 F006C38C */  lw         $v1, 0x6F0($a2)
  .L8006CA38:
    /* 5D238 8006CA38 00000000 */  nop
    /* 5D23C 8006CA3C 18006214 */  bne        $v1, $v0, .L8006CAA0
    /* 5D240 8006CA40 1280023C */   lui       $v0, %hi(simGlobal)
    /* 5D244 8006CA44 ACE04724 */  addiu      $a3, $v0, %lo(simGlobal)
    /* 5D248 8006CA48 0400E48C */  lw         $a0, 0x4($a3)
    /* 5D24C 8006CA4C F406C38C */  lw         $v1, 0x6F4($a2)
    /* 5D250 8006CA50 EC06C28C */  lw         $v0, 0x6EC($a2)
    /* 5D254 8006CA54 23208300 */  subu       $a0, $a0, $v1
    /* 5D258 8006CA58 C21F0200 */  srl        $v1, $v0, 31
    /* 5D25C 8006CA5C 21104300 */  addu       $v0, $v0, $v1
    /* 5D260 8006CA60 43100200 */  sra        $v0, $v0, 1
    /* 5D264 8006CA64 2A104400 */  slt        $v0, $v0, $a0
    /* 5D268 8006CA68 0D004010 */  beqz       $v0, .L8006CAA0
    /* 5D26C 8006CA6C 1300033C */   lui       $v1, (0x13FFFF >> 16)
    /* 5D270 8006CA70 6405C28C */  lw         $v0, 0x564($a2)
    /* 5D274 8006CA74 FFFF6334 */  ori        $v1, $v1, (0x13FFFF & 0xFFFF)
    /* 5D278 8006CA78 02004104 */  bgez       $v0, .L8006CA84
    /* 5D27C 8006CA7C 00000000 */   nop
    /* 5D280 8006CA80 23100200 */  negu       $v0, $v0
  .L8006CA84:
    /* 5D284 8006CA84 2A186200 */  slt        $v1, $v1, $v0
    /* 5D288 8006CA88 05006014 */  bnez       $v1, .L8006CAA0
    /* 5D28C 8006CA8C FFFF0224 */   addiu     $v0, $zero, -0x1
  .L8006CA90:
    /* 5D290 8006CA90 F006C2AC */  sw         $v0, 0x6F0($a2)
    /* 5D294 8006CA94 0400E28C */  lw         $v0, 0x4($a3)
    /* 5D298 8006CA98 EC06C5AC */  sw         $a1, 0x6EC($a2)
    /* 5D29C 8006CA9C F406C2AC */  sw         $v0, 0x6F4($a2)
  .L8006CAA0:
    /* 5D2A0 8006CAA0 0800E003 */  jr         $ra
    /* 5D2A4 8006CAA4 00000000 */   nop
endlabel AIPhysic_ChangeDirection__FP8Car_tObji
