.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching DrawC_SpotPrims__FP10matrixtdefP8coorddefP13Draw_CarCache, 0x384

glabel DrawC_SpotPrims__FP10matrixtdefP8coorddefP13Draw_CarCache
    /* B5000 800C4800 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* B5004 800C4804 1800B0AF */  sw         $s0, 0x18($sp)
    /* B5008 800C4808 21808000 */  addu       $s0, $a0, $zero
    /* B500C 800C480C 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* B5010 800C4810 2188A000 */  addu       $s1, $a1, $zero
    /* B5014 800C4814 2000B2AF */  sw         $s2, 0x20($sp)
    /* B5018 800C4818 2190C000 */  addu       $s2, $a2, $zero
    /* B501C 800C481C 2400BFAF */  sw         $ra, 0x24($sp)
    /* B5020 800C4820 4B86030C */  jal        TrsProj_SetTransPrecision__Fi
    /* B5024 800C4824 08000424 */   addiu     $a0, $zero, 0x8
    /* B5028 800C4828 0000028E */  lw         $v0, 0x0($s0)
    /* B502C 800C482C 0C00038E */  lw         $v1, 0xC($s0)
    /* B5030 800C4830 1800048E */  lw         $a0, 0x18($s0)
    /* B5034 800C4834 03110200 */  sra        $v0, $v0, 4
    /* B5038 800C4838 03190300 */  sra        $v1, $v1, 4
    /* B503C 800C483C 03210400 */  sra        $a0, $a0, 4
    /* B5040 800C4840 140042A6 */  sh         $v0, 0x14($s2)
    /* B5044 800C4844 160043A6 */  sh         $v1, 0x16($s2)
    /* B5048 800C4848 180044A6 */  sh         $a0, 0x18($s2)
    /* B504C 800C484C 0400028E */  lw         $v0, 0x4($s0)
    /* B5050 800C4850 1000038E */  lw         $v1, 0x10($s0)
    /* B5054 800C4854 1C00048E */  lw         $a0, 0x1C($s0)
    /* B5058 800C4858 03110200 */  sra        $v0, $v0, 4
    /* B505C 800C485C 03190300 */  sra        $v1, $v1, 4
    /* B5060 800C4860 03210400 */  sra        $a0, $a0, 4
    /* B5064 800C4864 1A0042A6 */  sh         $v0, 0x1A($s2)
    /* B5068 800C4868 1C0043A6 */  sh         $v1, 0x1C($s2)
    /* B506C 800C486C 1E0044A6 */  sh         $a0, 0x1E($s2)
    /* B5070 800C4870 0800038E */  lw         $v1, 0x8($s0)
    /* B5074 800C4874 1400048E */  lw         $a0, 0x14($s0)
    /* B5078 800C4878 2000058E */  lw         $a1, 0x20($s0)
    /* B507C 800C487C 23100200 */  negu       $v0, $v0
    /* B5080 800C4880 1A0042A6 */  sh         $v0, 0x1A($s2)
    /* B5084 800C4884 1C004296 */  lhu        $v0, 0x1C($s2)
    /* B5088 800C4888 03190300 */  sra        $v1, $v1, 4
    /* B508C 800C488C 03210400 */  sra        $a0, $a0, 4
    /* B5090 800C4890 03290500 */  sra        $a1, $a1, 4
    /* B5094 800C4894 200043A6 */  sh         $v1, 0x20($s2)
    /* B5098 800C4898 1E004396 */  lhu        $v1, 0x1E($s2)
    /* B509C 800C489C 23100200 */  negu       $v0, $v0
    /* B50A0 800C48A0 220044A6 */  sh         $a0, 0x22($s2)
    /* B50A4 800C48A4 240045A6 */  sh         $a1, 0x24($s2)
    /* B50A8 800C48A8 1C0042A6 */  sh         $v0, 0x1C($s2)
    /* B50AC 800C48AC 23180300 */  negu       $v1, $v1
    /* B50B0 800C48B0 1E0043A6 */  sh         $v1, 0x1E($s2)
    /* B50B4 800C48B4 0000228E */  lw         $v0, 0x0($s1)
    /* B50B8 800C48B8 1480033C */  lui        $v1, %hi(TrsProj_precision)
    /* B50BC 800C48BC 9CDB638C */  lw         $v1, %lo(TrsProj_precision)($v1)
    /* B50C0 800C48C0 00000000 */  nop
    /* B50C4 800C48C4 07106200 */  srav       $v0, $v0, $v1
    /* B50C8 800C48C8 280042AE */  sw         $v0, 0x28($s2)
    /* B50CC 800C48CC 0400228E */  lw         $v0, 0x4($s1)
    /* B50D0 800C48D0 00000000 */  nop
    /* B50D4 800C48D4 07106200 */  srav       $v0, $v0, $v1
    /* B50D8 800C48D8 23100200 */  negu       $v0, $v0
    /* B50DC 800C48DC 2C0042AE */  sw         $v0, 0x2C($s2)
    /* B50E0 800C48E0 0800228E */  lw         $v0, 0x8($s1)
    /* B50E4 800C48E4 00000000 */  nop
    /* B50E8 800C48E8 07106200 */  srav       $v0, $v0, $v1
    /* B50EC 800C48EC 4E86030C */  jal        TrsProj_ResetTransPrecision__Fv
    /* B50F0 800C48F0 300042AE */   sw        $v0, 0x30($s2)
    /* B50F4 800C48F4 14004226 */  addiu      $v0, $s2, 0x14
    /* B50F8 800C48F8 00004C8C */  lw         $t4, 0x0($v0)
    /* B50FC 800C48FC 04004D8C */  lw         $t5, 0x4($v0)
    /* B5100 800C4900 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* B5104 800C4904 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* B5108 800C4908 08004C8C */  lw         $t4, 0x8($v0)
    /* B510C 800C490C 0C004D8C */  lw         $t5, 0xC($v0)
    /* B5110 800C4910 10004E8C */  lw         $t6, 0x10($v0)
    /* B5114 800C4914 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* B5118 800C4918 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* B511C 800C491C 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* B5120 800C4920 14004C8C */  lw         $t4, 0x14($v0)
    /* B5124 800C4924 18004D8C */  lw         $t5, 0x18($v0)
    /* B5128 800C4928 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B512C 800C492C 1C004E8C */  lw         $t6, 0x1C($v0)
    /* B5130 800C4930 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B5134 800C4934 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* B5138 800C4938 FF00093C */  lui        $t1, (0xFFFFFF >> 16)
    /* B513C 800C493C FFFF2935 */  ori        $t1, $t1, (0xFFFFFF & 0xFFFF)
    /* B5140 800C4940 21280000 */  addu       $a1, $zero, $zero
    /* B5144 800C4944 2130A000 */  addu       $a2, $a1, $zero
    /* B5148 800C4948 20010724 */  addiu      $a3, $zero, 0x120
    /* B514C 800C494C 0400448E */  lw         $a0, 0x4($s2)
    /* B5150 800C4950 0000488E */  lw         $t0, 0x0($s2)
    /* B5154 800C4954 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* B5158 800C4958 3C0040AE */  sw         $zero, 0x3C($s2)
    /* B515C 800C495C 0C008224 */  addiu      $v0, $a0, 0xC
    /* B5160 800C4960 040042AE */  sw         $v0, 0x4($s2)
    /* B5164 800C4964 3C00428E */  lw         $v0, 0x3C($s2)
    /* B5168 800C4968 0000838C */  lw         $v1, 0x0($a0)
    /* B516C 800C496C 80100200 */  sll        $v0, $v0, 2
    /* B5170 800C4970 21400201 */  addu       $t0, $t0, $v0
    /* B5174 800C4974 0000028D */  lw         $v0, 0x0($t0)
    /* B5178 800C4978 24186A00 */  and        $v1, $v1, $t2
    /* B517C 800C497C 24104900 */  and        $v0, $v0, $t1
    /* B5180 800C4980 25186200 */  or         $v1, $v1, $v0
    /* B5184 800C4984 000083AC */  sw         $v1, 0x0($a0)
    /* B5188 800C4988 0000028D */  lw         $v0, 0x0($t0)
    /* B518C 800C498C 24188900 */  and        $v1, $a0, $t1
    /* B5190 800C4990 24104A00 */  and        $v0, $v0, $t2
    /* B5194 800C4994 25104300 */  or         $v0, $v0, $v1
    /* B5198 800C4998 000002AD */  sw         $v0, 0x0($t0)
    /* B519C 800C499C EFB8030C */  jal        SetDrawMode
    /* B51A0 800C49A0 1000A0AF */   sw        $zero, 0x10($sp)
    /* B51A4 800C49A4 21380000 */  addu       $a3, $zero, $zero
    /* B51A8 800C49A8 AC004C26 */  addiu      $t4, $s2, 0xAC
    /* B51AC 800C49AC B4004B26 */  addiu      $t3, $s2, 0xB4
    /* B51B0 800C49B0 FF00083C */  lui        $t0, (0xFFFFFF >> 16)
    /* B51B4 800C49B4 FFFF0835 */  ori        $t0, $t0, (0xFFFFFF & 0xFFFF)
    /* B51B8 800C49B8 00FF093C */  lui        $t1, (0xFF000000 >> 16)
    /* B51BC 800C49BC 0580033C */  lui        $v1, %hi(D_8005132C)
    /* B51C0 800C49C0 2C136224 */  addiu      $v0, $v1, %lo(D_8005132C)
    /* B51C4 800C49C4 40FF4A24 */  addiu      $t2, $v0, -0xC0
    /* B51C8 800C49C8 2C136394 */  lhu        $v1, %lo(D_8005132C)($v1)
    /* B51CC 800C49CC 02004494 */  lhu        $a0, 0x2($v0)
    /* B51D0 800C49D0 04004294 */  lhu        $v0, 0x4($v0)
    /* B51D4 800C49D4 21304001 */  addu       $a2, $t2, $zero
    /* B51D8 800C49D8 AC0043A6 */  sh         $v1, 0xAC($s2)
    /* B51DC 800C49DC AE0044A6 */  sh         $a0, 0xAE($s2)
    /* B51E0 800C49E0 B00042A6 */  sh         $v0, 0xB0($s2)
  .L800C49E4:
    /* B51E4 800C49E4 2000E228 */  slti       $v0, $a3, 0x20
    /* B51E8 800C49E8 46004010 */  beqz       $v0, .L800C4B04
    /* B51EC 800C49EC 0100E524 */   addiu     $a1, $a3, 0x1
    /* B51F0 800C49F0 20000224 */  addiu      $v0, $zero, 0x20
    /* B51F4 800C49F4 0200A214 */  bne        $a1, $v0, .L800C4A00
    /* B51F8 800C49F8 00000000 */   nop
    /* B51FC 800C49FC 21280000 */  addu       $a1, $zero, $zero
  .L800C4A00:
    /* B5200 800C4A00 0400428E */  lw         $v0, 0x4($s2)
    /* B5204 800C4A04 0800438E */  lw         $v1, 0x8($s2)
    /* B5208 800C4A08 00000000 */  nop
    /* B520C 800C4A0C 2B104300 */  sltu       $v0, $v0, $v1
    /* B5210 800C4A10 39004010 */  beqz       $v0, .L800C4AF8
    /* B5214 800C4A14 00000000 */   nop
    /* B5218 800C4A18 0000C294 */  lhu        $v0, 0x0($a2)
    /* B521C 800C4A1C 0200C394 */  lhu        $v1, 0x2($a2)
    /* B5220 800C4A20 0400C494 */  lhu        $a0, 0x4($a2)
    /* B5224 800C4A24 B40042A6 */  sh         $v0, 0xB4($s2)
    /* B5228 800C4A28 40100500 */  sll        $v0, $a1, 1
    /* B522C 800C4A2C 21104500 */  addu       $v0, $v0, $a1
    /* B5230 800C4A30 40100200 */  sll        $v0, $v0, 1
    /* B5234 800C4A34 21104A00 */  addu       $v0, $v0, $t2
    /* B5238 800C4A38 B60043A6 */  sh         $v1, 0xB6($s2)
    /* B523C 800C4A3C B80044A6 */  sh         $a0, 0xB8($s2)
    /* B5240 800C4A40 00004394 */  lhu        $v1, 0x0($v0)
    /* B5244 800C4A44 02004494 */  lhu        $a0, 0x2($v0)
    /* B5248 800C4A48 04004294 */  lhu        $v0, 0x4($v0)
    /* B524C 800C4A4C 00000000 */  nop
    /* B5250 800C4A50 C00042A6 */  sh         $v0, 0xC0($s2)
    /* B5254 800C4A54 BC004226 */  addiu      $v0, $s2, 0xBC
    /* B5258 800C4A58 BC0043A6 */  sh         $v1, 0xBC($s2)
    /* B525C 800C4A5C BE0044A6 */  sh         $a0, 0xBE($s2)
    /* B5260 800C4A60 000080C9 */  lwc2       $0, 0x0($t4)
    /* B5264 800C4A64 040081C9 */  lwc2       $1, 0x4($t4)
    /* B5268 800C4A68 000062C9 */  lwc2       $2, 0x0($t3)
    /* B526C 800C4A6C 040063C9 */  lwc2       $3, 0x4($t3)
    /* B5270 800C4A70 000044C8 */  lwc2       $4, 0x0($v0)
    /* B5274 800C4A74 040045C8 */  lwc2       $5, 0x4($v0)
    /* B5278 800C4A78 00000000 */  nop
    /* B527C 800C4A7C 00000000 */  nop
    /* B5280 800C4A80 3000284A */  .word 0x4A280030  /* rtpt */
    /* B5284 800C4A84 0400448E */  lw         $a0, 0x4($s2)
    /* B5288 800C4A88 0000458E */  lw         $a1, 0x0($s2)
    /* B528C 800C4A8C 1C008224 */  addiu      $v0, $a0, 0x1C
    /* B5290 800C4A90 040042AE */  sw         $v0, 0x4($s2)
    /* B5294 800C4A94 3C00428E */  lw         $v0, 0x3C($s2)
    /* B5298 800C4A98 0000838C */  lw         $v1, 0x0($a0)
    /* B529C 800C4A9C 80100200 */  sll        $v0, $v0, 2
    /* B52A0 800C4AA0 2128A200 */  addu       $a1, $a1, $v0
    /* B52A4 800C4AA4 0000A28C */  lw         $v0, 0x0($a1)
    /* B52A8 800C4AA8 24186900 */  and        $v1, $v1, $t1
    /* B52AC 800C4AAC 24104800 */  and        $v0, $v0, $t0
    /* B52B0 800C4AB0 25186200 */  or         $v1, $v1, $v0
    /* B52B4 800C4AB4 000083AC */  sw         $v1, 0x0($a0)
    /* B52B8 800C4AB8 0000A28C */  lw         $v0, 0x0($a1)
    /* B52BC 800C4ABC 24188800 */  and        $v1, $a0, $t0
    /* B52C0 800C4AC0 24104900 */  and        $v0, $v0, $t1
    /* B52C4 800C4AC4 25104300 */  or         $v0, $v0, $v1
    /* B52C8 800C4AC8 0000A2AC */  sw         $v0, 0x0($a1)
    /* B52CC 800C4ACC 08008CE8 */  swc2       $12, 0x8($a0)
    /* B52D0 800C4AD0 10008DE8 */  swc2       $13, 0x10($a0)
    /* B52D4 800C4AD4 18008EE8 */  swc2       $14, 0x18($a0)
    /* B52D8 800C4AD8 8C00438E */  lw         $v1, 0x8C($s2)
    /* B52DC 800C4ADC 06000224 */  addiu      $v0, $zero, 0x6
    /* B52E0 800C4AE0 030082A0 */  sb         $v0, 0x3($a0)
    /* B52E4 800C4AE4 32000224 */  addiu      $v0, $zero, 0x32
    /* B52E8 800C4AE8 0C0080AC */  sw         $zero, 0xC($a0)
    /* B52EC 800C4AEC 140080AC */  sw         $zero, 0x14($a0)
    /* B52F0 800C4AF0 040083AC */  sw         $v1, 0x4($a0)
    /* B52F4 800C4AF4 070082A0 */  sb         $v0, 0x7($a0)
  .L800C4AF8:
    /* B52F8 800C4AF8 0600C624 */  addiu      $a2, $a2, 0x6
    /* B52FC 800C4AFC 79120308 */  j          .L800C49E4
    /* B5300 800C4B00 0100E724 */   addiu     $a3, $a3, 0x1
  .L800C4B04:
    /* B5304 800C4B04 FF00093C */  lui        $t1, (0xFFFFFF >> 16)
    /* B5308 800C4B08 FFFF2935 */  ori        $t1, $t1, (0xFFFFFF & 0xFFFF)
    /* B530C 800C4B0C 21280000 */  addu       $a1, $zero, $zero
    /* B5310 800C4B10 01000624 */  addiu      $a2, $zero, 0x1
    /* B5314 800C4B14 20010724 */  addiu      $a3, $zero, 0x120
    /* B5318 800C4B18 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* B531C 800C4B1C 0400448E */  lw         $a0, 0x4($s2)
    /* B5320 800C4B20 0000488E */  lw         $t0, 0x0($s2)
    /* B5324 800C4B24 0C008224 */  addiu      $v0, $a0, 0xC
    /* B5328 800C4B28 040042AE */  sw         $v0, 0x4($s2)
    /* B532C 800C4B2C 3C00428E */  lw         $v0, 0x3C($s2)
    /* B5330 800C4B30 0000838C */  lw         $v1, 0x0($a0)
    /* B5334 800C4B34 80100200 */  sll        $v0, $v0, 2
    /* B5338 800C4B38 21400201 */  addu       $t0, $t0, $v0
    /* B533C 800C4B3C 0000028D */  lw         $v0, 0x0($t0)
    /* B5340 800C4B40 24186A00 */  and        $v1, $v1, $t2
    /* B5344 800C4B44 24104900 */  and        $v0, $v0, $t1
    /* B5348 800C4B48 25186200 */  or         $v1, $v1, $v0
    /* B534C 800C4B4C 000083AC */  sw         $v1, 0x0($a0)
    /* B5350 800C4B50 0000028D */  lw         $v0, 0x0($t0)
    /* B5354 800C4B54 24188900 */  and        $v1, $a0, $t1
    /* B5358 800C4B58 24104A00 */  and        $v0, $v0, $t2
    /* B535C 800C4B5C 25104300 */  or         $v0, $v0, $v1
    /* B5360 800C4B60 000002AD */  sw         $v0, 0x0($t0)
    /* B5364 800C4B64 EFB8030C */  jal        SetDrawMode
    /* B5368 800C4B68 1000A0AF */   sw        $zero, 0x10($sp)
    /* B536C 800C4B6C 2400BF8F */  lw         $ra, 0x24($sp)
    /* B5370 800C4B70 2000B28F */  lw         $s2, 0x20($sp)
    /* B5374 800C4B74 1C00B18F */  lw         $s1, 0x1C($sp)
    /* B5378 800C4B78 1800B08F */  lw         $s0, 0x18($sp)
    /* B537C 800C4B7C 0800E003 */  jr         $ra
    /* B5380 800C4B80 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel DrawC_SpotPrims__FP10matrixtdefP8coorddefP13Draw_CarCache
