.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching inittimer, 0x114

glabel inittimer
    /* E49F0 800F41F0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E49F4 800F41F4 1000B0AF */  sw         $s0, 0x10($sp)
    /* E49F8 800F41F8 21808000 */  addu       $s0, $a0, $zero
    /* E49FC 800F41FC 02000016 */  bnez       $s0, .L800F4208
    /* E4A00 800F4200 1400BFAF */   sw        $ra, 0x14($sp)
    /* E4A04 800F4204 64001024 */  addiu      $s0, $zero, 0x64
  .L800F4208:
    /* E4A08 800F4208 631A040C */  jal        EnterCriticalSection
    /* E4A0C 800F420C 00000000 */   nop
    /* E4A10 800F4210 0018828F */  lw         $v0, %gp_rel(timerflag)($gp)
    /* E4A14 800F4214 00000000 */  nop
    /* E4A18 800F4218 15004014 */  bnez       $v0, .L800F4270
    /* E4A1C 800F421C 00000000 */   nop
    /* E4A20 800F4220 1280043C */  lui        $a0, %hi(tmrsub)
    /* E4A24 800F4224 0C368424 */  addiu      $a0, $a0, %lo(tmrsub)
    /* E4A28 800F4228 E8C5030C */  jal        blockclear
    /* E4A2C 800F422C 20000524 */   addiu     $a1, $zero, 0x20
    /* E4A30 800F4230 00F2043C */  lui        $a0, (0xF2000002 >> 16)
    /* E4A34 800F4234 02008434 */  ori        $a0, $a0, (0xF2000002 & 0xFFFF)
    /* E4A38 800F4238 02000524 */  addiu      $a1, $zero, 0x2
    /* E4A3C 800F423C 00100624 */  addiu      $a2, $zero, 0x1000
    /* E4A40 800F4240 0F80073C */  lui        $a3, %hi(tmrint)
    /* E4A44 800F4244 881B040C */  jal        OpenEvent
    /* E4A48 800F4248 2843E724 */   addiu     $a3, $a3, %lo(tmrint)
    /* E4A4C 800F424C 21204000 */  addu       $a0, $v0, $zero
    /* E4A50 800F4250 781984AF */  sw         $a0, %gp_rel(timerevent)($gp)
    /* E4A54 800F4254 841B040C */  jal        EnableEvent
    /* E4A58 800F4258 00000000 */   nop
    /* E4A5C 800F425C 0F80043C */  lui        $a0, %hi(restoretimer)
    /* E4A60 800F4260 01000224 */  addiu      $v0, $zero, 0x1
    /* E4A64 800F4264 001882AF */  sw         $v0, %gp_rel(timerflag)($gp)
    /* E4A68 800F4268 3EC7030C */  jal        addexit
    /* E4A6C 800F426C 04438424 */   addiu     $a0, $a0, %lo(restoretimer)
  .L800F4270:
    /* E4A70 800F4270 20AC030C */  jal        initgp
    /* E4A74 800F4274 00000000 */   nop
    /* E4A78 800F4278 4000053C */  lui        $a1, (0x409980 >> 16)
    /* E4A7C 800F427C 8099A534 */  ori        $a1, $a1, (0x409980 & 0xFFFF)
    /* E4A80 800F4280 1A00B000 */  div        $zero, $a1, $s0
    /* E4A84 800F4284 02000016 */  bnez       $s0, .L800F4290
    /* E4A88 800F4288 00000000 */   nop
    /* E4A8C 800F428C 0D000700 */  break      7
  .L800F4290:
    /* E4A90 800F4290 FFFF0124 */  addiu      $at, $zero, -0x1
    /* E4A94 800F4294 04000116 */  bne        $s0, $at, .L800F42A8
    /* E4A98 800F4298 0080013C */   lui       $at, (0x80000000 >> 16)
    /* E4A9C 800F429C 0200A114 */  bne        $a1, $at, .L800F42A8
    /* E4AA0 800F42A0 00000000 */   nop
    /* E4AA4 800F42A4 0D000600 */  break      6
  .L800F42A8:
    /* E4AA8 800F42A8 12280000 */  mflo       $a1
    /* E4AAC 800F42AC 00F2043C */  lui        $a0, (0xF2000002 >> 16)
    /* E4AB0 800F42B0 02008434 */  ori        $a0, $a0, (0xF2000002 & 0xFFFF)
    /* E4AB4 800F42B4 00100624 */  addiu      $a2, $zero, 0x1000
    /* E4AB8 800F42B8 1480013C */  lui        $at, %hi(timerhz)
    /* E4ABC 800F42BC C4DC30AC */  sw         $s0, %lo(timerhz)($at)
    /* E4AC0 800F42C0 741980AF */  sw         $zero, %gp_rel(reentryflag)($gp)
    /* E4AC4 800F42C4 9CA7030C */  jal        SetRCnt
    /* E4AC8 800F42C8 FFFFA530 */   andi      $a1, $a1, 0xFFFF
    /* E4ACC 800F42CC 00F2043C */  lui        $a0, (0xF2000002 >> 16)
    /* E4AD0 800F42D0 D1A7030C */  jal        StartRCnt
    /* E4AD4 800F42D4 02008434 */   ori       $a0, $a0, (0xF2000002 & 0xFFFF)
    /* E4AD8 800F42D8 5B1A040C */  jal        ExitCriticalSection
    /* E4ADC 800F42DC 00000000 */   nop
    /* E4AE0 800F42E0 98A0030C */  jal        resettick
    /* E4AE4 800F42E4 00000000 */   nop
    /* E4AE8 800F42E8 0F80043C */  lui        $a0, %hi(restoretimer)
    /* E4AEC 800F42EC 3EC7030C */  jal        addexit
    /* E4AF0 800F42F0 04438424 */   addiu     $a0, $a0, %lo(restoretimer)
    /* E4AF4 800F42F4 1400BF8F */  lw         $ra, 0x14($sp)
    /* E4AF8 800F42F8 1000B08F */  lw         $s0, 0x10($sp)
    /* E4AFC 800F42FC 0800E003 */  jr         $ra
    /* E4B00 800F4300 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel inittimer
