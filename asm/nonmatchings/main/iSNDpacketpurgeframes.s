.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDpacketpurgeframes, 0x158

glabel iSNDpacketpurgeframes
    /* F41FC 801039FC C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* F4200 80103A00 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* F4204 80103A04 21B88000 */  addu       $s7, $a0, $zero
    /* F4208 80103A08 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* F420C 80103A0C 2198A000 */  addu       $s3, $a1, $zero
    /* F4210 80103A10 1480043C */  lui        $a0, %hi(sndpd)
    /* F4214 80103A14 18798424 */  addiu      $a0, $a0, %lo(sndpd)
    /* F4218 80103A18 80101700 */  sll        $v0, $s7, 2
    /* F421C 80103A1C 21104400 */  addu       $v0, $v0, $a0
    /* F4220 80103A20 3000BFAF */  sw         $ra, 0x30($sp)
    /* F4224 80103A24 2800B6AF */  sw         $s6, 0x28($sp)
    /* F4228 80103A28 2400B5AF */  sw         $s5, 0x24($sp)
    /* F422C 80103A2C 2000B4AF */  sw         $s4, 0x20($sp)
    /* F4230 80103A30 1800B2AF */  sw         $s2, 0x18($sp)
    /* F4234 80103A34 1400B1AF */  sw         $s1, 0x14($sp)
    /* F4238 80103A38 1000B0AF */  sw         $s0, 0x10($sp)
    /* F423C 80103A3C F804558C */  lw         $s5, 0x4F8($v0)
    /* F4240 80103A40 21A0C000 */  addu       $s4, $a2, $zero
    /* F4244 80103A44 4200A382 */  lb         $v1, 0x42($s5)
    /* F4248 80103A48 D8008424 */  addiu      $a0, $a0, 0xD8
    /* F424C 80103A4C 40100300 */  sll        $v0, $v1, 1
    /* F4250 80103A50 21104300 */  addu       $v0, $v0, $v1
    /* F4254 80103A54 80100200 */  sll        $v0, $v0, 2
    /* F4258 80103A58 23104300 */  subu       $v0, $v0, $v1
    /* F425C 80103A5C 80100200 */  sll        $v0, $v0, 2
    /* F4260 80103A60 21B04400 */  addu       $s6, $v0, $a0
  .L80103A64:
    /* F4264 80103A64 4600A296 */  lhu        $v0, 0x46($s5)
    /* F4268 80103A68 00000000 */  nop
    /* F426C 80103A6C 1B006202 */  divu       $zero, $s3, $v0
    /* F4270 80103A70 02004014 */  bnez       $v0, .L80103A7C
    /* F4274 80103A74 00000000 */   nop
    /* F4278 80103A78 0D000700 */  break      7
  .L80103A7C:
    /* F427C 80103A7C 12200000 */  mflo       $a0
    /* F4280 80103A80 00000000 */  nop
    /* F4284 80103A84 01008324 */  addiu      $v1, $a0, 0x1
    /* F4288 80103A88 18006200 */  mult       $v1, $v0
    /* F428C 80103A8C 12100000 */  mflo       $v0
    /* F4290 80103A90 23905300 */  subu       $s2, $v0, $s3
    /* F4294 80103A94 2A109202 */  slt        $v0, $s4, $s2
    /* F4298 80103A98 02004010 */  beqz       $v0, .L80103AA4
    /* F429C 80103A9C 00000000 */   nop
    /* F42A0 80103AA0 21908002 */  addu       $s2, $s4, $zero
  .L80103AA4:
    /* F42A4 80103AA4 2C00A28E */  lw         $v0, 0x2C($s5)
    /* F42A8 80103AA8 40180400 */  sll        $v1, $a0, 1
    /* F42AC 80103AAC 21186200 */  addu       $v1, $v1, $v0
    /* F42B0 80103AB0 00006494 */  lhu        $a0, 0x0($v1)
    /* F42B4 80103AB4 00000000 */  nop
    /* F42B8 80103AB8 2A109200 */  slt        $v0, $a0, $s2
    /* F42BC 80103ABC 02004010 */  beqz       $v0, .L80103AC8
    /* F42C0 80103AC0 21884002 */   addu      $s1, $s2, $zero
    /* F42C4 80103AC4 21888000 */  addu       $s1, $a0, $zero
  .L80103AC8:
    /* F42C8 80103AC8 23109100 */  subu       $v0, $a0, $s1
    /* F42CC 80103ACC 0E002012 */  beqz       $s1, .L80103B08
    /* F42D0 80103AD0 000062A4 */   sh        $v0, 0x0($v1)
    /* F42D4 80103AD4 1F00C292 */  lbu        $v0, 0x1F($s6)
    /* F42D8 80103AD8 00000000 */  nop
    /* F42DC 80103ADC 0A004010 */  beqz       $v0, .L80103B08
    /* F42E0 80103AE0 21800000 */   addu      $s0, $zero, $zero
    /* F42E4 80103AE4 2120E002 */  addu       $a0, $s7, $zero
  .L80103AE8:
    /* F42E8 80103AE8 21280002 */  addu       $a1, $s0, $zero
    /* F42EC 80103AEC F10C040C */  jal        iSNDpacketfreeframes
    /* F42F0 80103AF0 21302002 */   addu      $a2, $s1, $zero
    /* F42F4 80103AF4 1F00C292 */  lbu        $v0, 0x1F($s6)
    /* F42F8 80103AF8 01001026 */  addiu      $s0, $s0, 0x1
    /* F42FC 80103AFC 2A100202 */  slt        $v0, $s0, $v0
    /* F4300 80103B00 F9FF4014 */  bnez       $v0, .L80103AE8
    /* F4304 80103B04 2120E002 */   addu      $a0, $s7, $zero
  .L80103B08:
    /* F4308 80103B08 0C00A28E */  lw         $v0, 0xC($s5)
    /* F430C 80103B0C 21987202 */  addu       $s3, $s3, $s2
    /* F4310 80103B10 2B106202 */  sltu       $v0, $s3, $v0
    /* F4314 80103B14 02004014 */  bnez       $v0, .L80103B20
    /* F4318 80103B18 23A09202 */   subu      $s4, $s4, $s2
    /* F431C 80103B1C 21980000 */  addu       $s3, $zero, $zero
  .L80103B20:
    /* F4320 80103B20 D0FF801E */  bgtz       $s4, .L80103A64
    /* F4324 80103B24 00000000 */   nop
    /* F4328 80103B28 3000BF8F */  lw         $ra, 0x30($sp)
    /* F432C 80103B2C 2C00B78F */  lw         $s7, 0x2C($sp)
    /* F4330 80103B30 2800B68F */  lw         $s6, 0x28($sp)
    /* F4334 80103B34 2400B58F */  lw         $s5, 0x24($sp)
    /* F4338 80103B38 2000B48F */  lw         $s4, 0x20($sp)
    /* F433C 80103B3C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* F4340 80103B40 1800B28F */  lw         $s2, 0x18($sp)
    /* F4344 80103B44 1400B18F */  lw         $s1, 0x14($sp)
    /* F4348 80103B48 1000B08F */  lw         $s0, 0x10($sp)
    /* F434C 80103B4C 0800E003 */  jr         $ra
    /* F4350 80103B50 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel iSNDpacketpurgeframes
