.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Device_Analog__FUl, 0x100

glabel Device_Analog__FUl
    /* AE1B8 800BD9B8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* AE1BC 800BD9BC 1000B0AF */  sw         $s0, 0x10($sp)
    /* AE1C0 800BD9C0 21808000 */  addu       $s0, $a0, $zero
    /* AE1C4 800BD9C4 1400B1AF */  sw         $s1, 0x14($sp)
    /* AE1C8 800BD9C8 028D1000 */  srl        $s1, $s0, 20
    /* AE1CC 800BD9CC 1800BFAF */  sw         $ra, 0x18($sp)
    /* AE1D0 800BD9D0 F0F4020C */  jal        Device_VerifyType__Fi
    /* AE1D4 800BD9D4 21202002 */   addu      $a0, $s1, $zero
    /* AE1D8 800BD9D8 03004014 */  bnez       $v0, .L800BD9E8
    /* AE1DC 800BD9DC 02241000 */   srl       $a0, $s0, 16
    /* AE1E0 800BD9E0 A9F60208 */  j          .L800BDAA4
    /* AE1E4 800BD9E4 21100000 */   addu      $v0, $zero, $zero
  .L800BD9E8:
    /* AE1E8 800BD9E8 03008430 */  andi       $a0, $a0, 0x3
    /* AE1EC 800BD9EC 1480033C */  lui        $v1, %hi(D_8013E8A4)
    /* AE1F0 800BD9F0 A4E86324 */  addiu      $v1, $v1, %lo(D_8013E8A4)
    /* AE1F4 800BD9F4 C0101100 */  sll        $v0, $s1, 3
    /* AE1F8 800BD9F8 21104400 */  addu       $v0, $v0, $a0
    /* AE1FC 800BD9FC 21104300 */  addu       $v0, $v0, $v1
    /* AE200 800BDA00 00004390 */  lbu        $v1, 0x0($v0)
    /* AE204 800BDA04 02121000 */  srl        $v0, $s0, 8
    /* AE208 800BDA08 FF004530 */  andi       $a1, $v0, 0xFF
    /* AE20C 800BDA0C FF000432 */  andi       $a0, $s0, 0xFF
    /* AE210 800BDA10 2A10A400 */  slt        $v0, $a1, $a0
    /* AE214 800BDA14 0B004010 */  beqz       $v0, .L800BDA44
    /* AE218 800BDA18 2A106500 */   slt       $v0, $v1, $a1
    /* AE21C 800BDA1C 0F004014 */  bnez       $v0, .L800BDA5C
    /* AE220 800BDA20 2A108300 */   slt       $v0, $a0, $v1
    /* AE224 800BDA24 03004010 */  beqz       $v0, .L800BDA34
    /* AE228 800BDA28 23186500 */   subu      $v1, $v1, $a1
  .L800BDA2C:
    /* AE22C 800BDA2C A7F60208 */  j          .L800BDA9C
    /* AE230 800BDA30 FF000324 */   addiu     $v1, $zero, 0xFF
  .L800BDA34:
    /* AE234 800BDA34 00120300 */  sll        $v0, $v1, 8
    /* AE238 800BDA38 23104300 */  subu       $v0, $v0, $v1
    /* AE23C 800BDA3C 9CF60208 */  j          .L800BDA70
    /* AE240 800BDA40 23188500 */   subu      $v1, $a0, $a1
  .L800BDA44:
    /* AE244 800BDA44 0500A410 */  beq        $a1, $a0, .L800BDA5C
    /* AE248 800BDA48 2A106400 */   slt       $v0, $v1, $a0
    /* AE24C 800BDA4C F7FF4014 */  bnez       $v0, .L800BDA2C
    /* AE250 800BDA50 2A10A300 */   slt       $v0, $a1, $v1
    /* AE254 800BDA54 03004010 */  beqz       $v0, .L800BDA64
    /* AE258 800BDA58 2318A300 */   subu      $v1, $a1, $v1
  .L800BDA5C:
    /* AE25C 800BDA5C A7F60208 */  j          .L800BDA9C
    /* AE260 800BDA60 21180000 */   addu      $v1, $zero, $zero
  .L800BDA64:
    /* AE264 800BDA64 00120300 */  sll        $v0, $v1, 8
    /* AE268 800BDA68 23104300 */  subu       $v0, $v0, $v1
    /* AE26C 800BDA6C 2318A400 */  subu       $v1, $a1, $a0
  .L800BDA70:
    /* AE270 800BDA70 1A004300 */  div        $zero, $v0, $v1
    /* AE274 800BDA74 02006014 */  bnez       $v1, .L800BDA80
    /* AE278 800BDA78 00000000 */   nop
    /* AE27C 800BDA7C 0D000700 */  break      7
  .L800BDA80:
    /* AE280 800BDA80 FFFF0124 */  addiu      $at, $zero, -0x1
    /* AE284 800BDA84 04006114 */  bne        $v1, $at, .L800BDA98
    /* AE288 800BDA88 0080013C */   lui       $at, (0x80000000 >> 16)
    /* AE28C 800BDA8C 02004114 */  bne        $v0, $at, .L800BDA98
    /* AE290 800BDA90 00000000 */   nop
    /* AE294 800BDA94 0D000600 */  break      6
  .L800BDA98:
    /* AE298 800BDA98 12180000 */  mflo       $v1
  .L800BDA9C:
    /* AE29C 800BDA9C 00000000 */  nop
    /* AE2A0 800BDAA0 21106000 */  addu       $v0, $v1, $zero
  .L800BDAA4:
    /* AE2A4 800BDAA4 1800BF8F */  lw         $ra, 0x18($sp)
    /* AE2A8 800BDAA8 1400B18F */  lw         $s1, 0x14($sp)
    /* AE2AC 800BDAAC 1000B08F */  lw         $s0, 0x10($sp)
    /* AE2B0 800BDAB0 0800E003 */  jr         $ra
    /* AE2B4 800BDAB4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Device_Analog__FUl
