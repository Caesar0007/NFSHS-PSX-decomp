.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Replay_SaveInput__Fi, 0x314

glabel Replay_SaveInput__Fi
    /* A5024 800B4824 78FFBD27 */  addiu      $sp, $sp, -0x88
    /* A5028 800B4828 8000B0AF */  sw         $s0, 0x80($sp)
    /* A502C 800B482C 8400BFAF */  sw         $ra, 0x84($sp)
    /* A5030 800B4830 A574020C */  jal        Input_Fetch__Fi
    /* A5034 800B4834 21808000 */   addu      $s0, $a0, $zero
    /* A5038 800B4838 1180023C */  lui        $v0, %hi(controlData)
    /* A503C 800B483C 6C704724 */  addiu      $a3, $v0, %lo(controlData)
    /* A5040 800B4840 80301000 */  sll        $a2, $s0, 2
    /* A5044 800B4844 1480023C */  lui        $v0, %hi(Replay_ReplayCounter)
    /* A5048 800B4848 00D44224 */  addiu      $v0, $v0, %lo(Replay_ReplayCounter)
    /* A504C 800B484C 2120C200 */  addu       $a0, $a2, $v0
    /* A5050 800B4850 C0811000 */  sll        $s0, $s0, 7
    /* A5054 800B4854 0000828C */  lw         $v0, 0x0($a0)
    /* A5058 800B4858 1480033C */  lui        $v1, %hi(Input_gSim)
    /* A505C 800B485C 2CD26380 */  lb         $v1, %lo(Input_gSim)($v1)
    /* A5060 800B4860 21105000 */  addu       $v0, $v0, $s0
    /* A5064 800B4864 02006104 */  bgez       $v1, .L800B4870
    /* A5068 800B4868 21284700 */   addu      $a1, $v0, $a3
    /* A506C 800B486C 03006324 */  addiu      $v1, $v1, 0x3
  .L800B4870:
    /* A5070 800B4870 83100300 */  sra        $v0, $v1, 2
    /* A5074 800B4874 40004224 */  addiu      $v0, $v0, 0x40
    /* A5078 800B4878 0000A2A0 */  sb         $v0, 0x0($a1)
    /* A507C 800B487C 0000838C */  lw         $v1, 0x0($a0)
    /* A5080 800B4880 1480023C */  lui        $v0, %hi(D_8013D22D)
    /* A5084 800B4884 2DD24290 */  lbu        $v0, %lo(D_8013D22D)($v0)
    /* A5088 800B4888 21187000 */  addu       $v1, $v1, $s0
    /* A508C 800B488C 21186700 */  addu       $v1, $v1, $a3
    /* A5090 800B4890 C2100200 */  srl        $v0, $v0, 3
    /* A5094 800B4894 200062A0 */  sb         $v0, 0x20($v1)
    /* A5098 800B4898 0000838C */  lw         $v1, 0x0($a0)
    /* A509C 800B489C 1480023C */  lui        $v0, %hi(D_8013D22E)
    /* A50A0 800B48A0 2ED24290 */  lbu        $v0, %lo(D_8013D22E)($v0)
    /* A50A4 800B48A4 21187000 */  addu       $v1, $v1, $s0
    /* A50A8 800B48A8 21186700 */  addu       $v1, $v1, $a3
    /* A50AC 800B48AC C2100200 */  srl        $v0, $v0, 3
    /* A50B0 800B48B0 400062A0 */  sb         $v0, 0x40($v1)
    /* A50B4 800B48B4 0000828C */  lw         $v0, 0x0($a0)
    /* A50B8 800B48B8 1480033C */  lui        $v1, %hi(D_8013D22F)
    /* A50BC 800B48BC 2FD26390 */  lbu        $v1, %lo(D_8013D22F)($v1)
    /* A50C0 800B48C0 21105000 */  addu       $v0, $v0, $s0
    /* A50C4 800B48C4 21104700 */  addu       $v0, $v0, $a3
    /* A50C8 800B48C8 600043A0 */  sb         $v1, 0x60($v0)
    /* A50CC 800B48CC 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* A50D0 800B48D0 48FA4224 */  addiu      $v0, $v0, %lo(Cars_gHumanRaceCarList)
    /* A50D4 800B48D4 2128C200 */  addu       $a1, $a2, $v0
    /* A50D8 800B48D8 0000A28C */  lw         $v0, 0x0($a1)
    /* A50DC 800B48DC 00000000 */  nop
    /* A50E0 800B48E0 8802428C */  lw         $v0, 0x288($v0)
    /* A50E4 800B48E4 00000000 */  nop
    /* A50E8 800B48E8 1800428C */  lw         $v0, 0x18($v0)
    /* A50EC 800B48EC 00000000 */  nop
    /* A50F0 800B48F0 09004010 */  beqz       $v0, .L800B4918
    /* A50F4 800B48F4 00000000 */   nop
    /* A50F8 800B48F8 0000838C */  lw         $v1, 0x0($a0)
    /* A50FC 800B48FC 00000000 */  nop
    /* A5100 800B4900 21187000 */  addu       $v1, $v1, $s0
    /* A5104 800B4904 21186700 */  addu       $v1, $v1, $a3
    /* A5108 800B4908 00006290 */  lbu        $v0, 0x0($v1)
    /* A510C 800B490C 00000000 */  nop
    /* A5110 800B4910 80004234 */  ori        $v0, $v0, 0x80
    /* A5114 800B4914 000062A0 */  sb         $v0, 0x0($v1)
  .L800B4918:
    /* A5118 800B4918 0000A28C */  lw         $v0, 0x0($a1)
    /* A511C 800B491C 00000000 */  nop
    /* A5120 800B4920 8802428C */  lw         $v0, 0x288($v0)
    /* A5124 800B4924 00000000 */  nop
    /* A5128 800B4928 1C00428C */  lw         $v0, 0x1C($v0)
    /* A512C 800B492C 00000000 */  nop
    /* A5130 800B4930 09004010 */  beqz       $v0, .L800B4958
    /* A5134 800B4934 00000000 */   nop
    /* A5138 800B4938 0000838C */  lw         $v1, 0x0($a0)
    /* A513C 800B493C 00000000 */  nop
    /* A5140 800B4940 21187000 */  addu       $v1, $v1, $s0
    /* A5144 800B4944 21186700 */  addu       $v1, $v1, $a3
    /* A5148 800B4948 20006290 */  lbu        $v0, 0x20($v1)
    /* A514C 800B494C 00000000 */  nop
    /* A5150 800B4950 80004234 */  ori        $v0, $v0, 0x80
    /* A5154 800B4954 200062A0 */  sb         $v0, 0x20($v1)
  .L800B4958:
    /* A5158 800B4958 0000A28C */  lw         $v0, 0x0($a1)
    /* A515C 800B495C 00000000 */  nop
    /* A5160 800B4960 8802428C */  lw         $v0, 0x288($v0)
    /* A5164 800B4964 00000000 */  nop
    /* A5168 800B4968 2000428C */  lw         $v0, 0x20($v0)
    /* A516C 800B496C 00000000 */  nop
    /* A5170 800B4970 09004010 */  beqz       $v0, .L800B4998
    /* A5174 800B4974 00000000 */   nop
    /* A5178 800B4978 0000838C */  lw         $v1, 0x0($a0)
    /* A517C 800B497C 00000000 */  nop
    /* A5180 800B4980 21187000 */  addu       $v1, $v1, $s0
    /* A5184 800B4984 21186700 */  addu       $v1, $v1, $a3
    /* A5188 800B4988 40006290 */  lbu        $v0, 0x40($v1)
    /* A518C 800B498C 00000000 */  nop
    /* A5190 800B4990 80004234 */  ori        $v0, $v0, 0x80
    /* A5194 800B4994 400062A0 */  sb         $v0, 0x40($v1)
  .L800B4998:
    /* A5198 800B4998 0000828C */  lw         $v0, 0x0($a0)
    /* A519C 800B499C 20000324 */  addiu      $v1, $zero, 0x20
    /* A51A0 800B49A0 01004224 */  addiu      $v0, $v0, 0x1
    /* A51A4 800B49A4 60004314 */  bne        $v0, $v1, .L800B4B28
    /* A51A8 800B49A8 000082AC */   sw        $v0, 0x0($a0)
    /* A51AC 800B49AC 00FF053C */  lui        $a1, (0xFF00FFFF >> 16)
    /* A51B0 800B49B0 FFFFA534 */  ori        $a1, $a1, (0xFF00FFFF & 0xFFFF)
    /* A51B4 800B49B4 FF00063C */  lui        $a2, (0xFFFFFF >> 16)
    /* A51B8 800B49B8 FFFFC634 */  ori        $a2, $a2, (0xFFFFFF & 0xFFFF)
    /* A51BC 800B49BC 1000AC27 */  addiu      $t4, $sp, 0x10
    /* A51C0 800B49C0 21800702 */  addu       $s0, $s0, $a3
    /* A51C4 800B49C4 10000B26 */  addiu      $t3, $s0, 0x10
    /* A51C8 800B49C8 000080AC */  sw         $zero, 0x0($a0)
    /* A51CC 800B49CC 00000892 */  lbu        $t0, 0x0($s0)
    /* A51D0 800B49D0 04000992 */  lbu        $t1, 0x4($s0)
    /* A51D4 800B49D4 08000A92 */  lbu        $t2, 0x8($s0)
    /* A51D8 800B49D8 01000292 */  lbu        $v0, 0x1($s0)
    /* A51DC 800B49DC 0C000792 */  lbu        $a3, 0xC($s0)
    /* A51E0 800B49E0 02000392 */  lbu        $v1, 0x2($s0)
    /* A51E4 800B49E4 03000492 */  lbu        $a0, 0x3($s0)
    /* A51E8 800B49E8 00120200 */  sll        $v0, $v0, 8
    /* A51EC 800B49EC 25400201 */  or         $t0, $t0, $v0
    /* A51F0 800B49F0 001C0300 */  sll        $v1, $v1, 16
    /* A51F4 800B49F4 25400301 */  or         $t0, $t0, $v1
    /* A51F8 800B49F8 00260400 */  sll        $a0, $a0, 24
    /* A51FC 800B49FC 25400401 */  or         $t0, $t0, $a0
    /* A5200 800B4A00 05000292 */  lbu        $v0, 0x5($s0)
    /* A5204 800B4A04 07000392 */  lbu        $v1, 0x7($s0)
    /* A5208 800B4A08 00120200 */  sll        $v0, $v0, 8
    /* A520C 800B4A0C 25482201 */  or         $t1, $t1, $v0
    /* A5210 800B4A10 24482501 */  and        $t1, $t1, $a1
    /* A5214 800B4A14 06000292 */  lbu        $v0, 0x6($s0)
    /* A5218 800B4A18 001E0300 */  sll        $v1, $v1, 24
    /* A521C 800B4A1C 00140200 */  sll        $v0, $v0, 16
    /* A5220 800B4A20 25482201 */  or         $t1, $t1, $v0
    /* A5224 800B4A24 24482601 */  and        $t1, $t1, $a2
    /* A5228 800B4A28 25482301 */  or         $t1, $t1, $v1
    /* A522C 800B4A2C 09000292 */  lbu        $v0, 0x9($s0)
    /* A5230 800B4A30 0B000392 */  lbu        $v1, 0xB($s0)
    /* A5234 800B4A34 00120200 */  sll        $v0, $v0, 8
    /* A5238 800B4A38 25504201 */  or         $t2, $t2, $v0
    /* A523C 800B4A3C 24504501 */  and        $t2, $t2, $a1
    /* A5240 800B4A40 0A000292 */  lbu        $v0, 0xA($s0)
    /* A5244 800B4A44 001E0300 */  sll        $v1, $v1, 24
    /* A5248 800B4A48 00140200 */  sll        $v0, $v0, 16
    /* A524C 800B4A4C 25504201 */  or         $t2, $t2, $v0
    /* A5250 800B4A50 24504601 */  and        $t2, $t2, $a2
    /* A5254 800B4A54 0D000292 */  lbu        $v0, 0xD($s0)
    /* A5258 800B4A58 00000000 */  nop
    /* A525C 800B4A5C 00120200 */  sll        $v0, $v0, 8
    /* A5260 800B4A60 2538E200 */  or         $a3, $a3, $v0
    /* A5264 800B4A64 0E000292 */  lbu        $v0, 0xE($s0)
    /* A5268 800B4A68 2438E500 */  and        $a3, $a3, $a1
    /* A526C 800B4A6C 00140200 */  sll        $v0, $v0, 16
    /* A5270 800B4A70 2538E200 */  or         $a3, $a3, $v0
    /* A5274 800B4A74 0F000292 */  lbu        $v0, 0xF($s0)
    /* A5278 800B4A78 2438E600 */  and        $a3, $a3, $a2
    /* A527C 800B4A7C 00160200 */  sll        $v0, $v0, 24
    /* A5280 800B4A80 2538E200 */  or         $a3, $a3, $v0
    /* A5284 800B4A84 03006231 */  andi       $v0, $t3, 0x3
    /* A5288 800B4A88 17004010 */  beqz       $v0, .L800B4AE8
    /* A528C 800B4A8C 25504301 */   or        $t2, $t2, $v1
    /* A5290 800B4A90 80000226 */  addiu      $v0, $s0, 0x80
  .L800B4A94:
    /* A5294 800B4A94 03006D89 */  lwl        $t5, 0x3($t3)
    /* A5298 800B4A98 00006D99 */  lwr        $t5, 0x0($t3)
    /* A529C 800B4A9C 07006E89 */  lwl        $t6, 0x7($t3)
    /* A52A0 800B4AA0 04006E99 */  lwr        $t6, 0x4($t3)
    /* A52A4 800B4AA4 0B006F89 */  lwl        $t7, 0xB($t3)
    /* A52A8 800B4AA8 08006F99 */  lwr        $t7, 0x8($t3)
    /* A52AC 800B4AAC 0F007889 */  lwl        $t8, 0xF($t3)
    /* A52B0 800B4AB0 0C007899 */  lwr        $t8, 0xC($t3)
    /* A52B4 800B4AB4 03008DA9 */  swl        $t5, 0x3($t4)
    /* A52B8 800B4AB8 00008DB9 */  swr        $t5, 0x0($t4)
    /* A52BC 800B4ABC 07008EA9 */  swl        $t6, 0x7($t4)
    /* A52C0 800B4AC0 04008EB9 */  swr        $t6, 0x4($t4)
    /* A52C4 800B4AC4 0B008FA9 */  swl        $t7, 0xB($t4)
    /* A52C8 800B4AC8 08008FB9 */  swr        $t7, 0x8($t4)
    /* A52CC 800B4ACC 0F0098A9 */  swl        $t8, 0xF($t4)
    /* A52D0 800B4AD0 0C0098B9 */  swr        $t8, 0xC($t4)
    /* A52D4 800B4AD4 10006B25 */  addiu      $t3, $t3, 0x10
    /* A52D8 800B4AD8 EEFF6215 */  bne        $t3, $v0, .L800B4A94
    /* A52DC 800B4ADC 10008C25 */   addiu     $t4, $t4, 0x10
    /* A52E0 800B4AE0 C7D20208 */  j          .L800B4B1C
    /* A52E4 800B4AE4 21200001 */   addu      $a0, $t0, $zero
  .L800B4AE8:
    /* A52E8 800B4AE8 80000226 */  addiu      $v0, $s0, 0x80
  .L800B4AEC:
    /* A52EC 800B4AEC 00006D8D */  lw         $t5, 0x0($t3)
    /* A52F0 800B4AF0 04006E8D */  lw         $t6, 0x4($t3)
    /* A52F4 800B4AF4 08006F8D */  lw         $t7, 0x8($t3)
    /* A52F8 800B4AF8 0C00788D */  lw         $t8, 0xC($t3)
    /* A52FC 800B4AFC 00008DAD */  sw         $t5, 0x0($t4)
    /* A5300 800B4B00 04008EAD */  sw         $t6, 0x4($t4)
    /* A5304 800B4B04 08008FAD */  sw         $t7, 0x8($t4)
    /* A5308 800B4B08 0C0098AD */  sw         $t8, 0xC($t4)
    /* A530C 800B4B0C 10006B25 */  addiu      $t3, $t3, 0x10
    /* A5310 800B4B10 F6FF6215 */  bne        $t3, $v0, .L800B4AEC
    /* A5314 800B4B14 10008C25 */   addiu     $t4, $t4, 0x10
    /* A5318 800B4B18 21200001 */  addu       $a0, $t0, $zero
  .L800B4B1C:
    /* A531C 800B4B1C 21282001 */  addu       $a1, $t1, $zero
    /* A5320 800B4B20 2FD0020C */  jal        Replay_StoringControllerData__FG15tControllerData
    /* A5324 800B4B24 21304001 */   addu      $a2, $t2, $zero
  .L800B4B28:
    /* A5328 800B4B28 8400BF8F */  lw         $ra, 0x84($sp)
    /* A532C 800B4B2C 8000B08F */  lw         $s0, 0x80($sp)
    /* A5330 800B4B30 0800E003 */  jr         $ra
    /* A5334 800B4B34 8800BD27 */   addiu     $sp, $sp, 0x88
endlabel Replay_SaveInput__Fi
