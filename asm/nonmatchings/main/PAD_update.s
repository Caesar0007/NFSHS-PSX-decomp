.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PAD_update, 0x108

glabel PAD_update
    /* D4A10 800E4210 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D4A14 800E4214 1480023C */  lui        $v0, %hi(D_8013E8A0)
    /* D4A18 800E4218 A0E84224 */  addiu      $v0, $v0, %lo(D_8013E8A0)
    /* D4A1C 800E421C 1800B2AF */  sw         $s2, 0x18($sp)
    /* D4A20 800E4220 08005224 */  addiu      $s2, $v0, 0x8
    /* D4A24 800E4224 1400B1AF */  sw         $s1, 0x14($sp)
    /* D4A28 800E4228 21884000 */  addu       $s1, $v0, $zero
    /* D4A2C 800E422C 1000B0AF */  sw         $s0, 0x10($sp)
    /* D4A30 800E4230 21800000 */  addu       $s0, $zero, $zero
    /* D4A34 800E4234 1C00BFAF */  sw         $ra, 0x1C($sp)
  .L800E4238:
    /* D4A38 800E4238 1480013C */  lui        $at, %hi(Padglobal)
    /* D4A3C 800E423C 21083000 */  addu       $at, $at, $s0
    /* D4A40 800E4240 F0E82290 */  lbu        $v0, %lo(Padglobal)($at)
    /* D4A44 800E4244 00000000 */  nop
    /* D4A48 800E4248 03004010 */  beqz       $v0, .L800E4258
    /* D4A4C 800E424C 21202002 */   addu      $a0, $s1, $zero
    /* D4A50 800E4250 9E900308 */  j          .L800E4278
    /* D4A54 800E4254 20000524 */   addiu     $a1, $zero, 0x20
  .L800E4258:
    /* D4A58 800E4258 1480043C */  lui        $a0, %hi(Padglobal)
    /* D4A5C 800E425C F0E88424 */  addiu      $a0, $a0, %lo(Padglobal)
    /* D4A60 800E4260 21200402 */  addu       $a0, $s0, $a0
    /* D4A64 800E4264 21282002 */  addu       $a1, $s1, $zero
    /* D4A68 800E4268 B798030C */  jal        blockmove
    /* D4A6C 800E426C 08000624 */   addiu     $a2, $zero, 0x8
    /* D4A70 800E4270 21204002 */  addu       $a0, $s2, $zero
    /* D4A74 800E4274 18000524 */  addiu      $a1, $zero, 0x18
  .L800E4278:
    /* D4A78 800E4278 E9C5030C */  jal        blockfill
    /* D4A7C 800E427C FF000624 */   addiu     $a2, $zero, 0xFF
    /* D4A80 800E4280 20005226 */  addiu      $s2, $s2, 0x20
    /* D4A84 800E4284 08001026 */  addiu      $s0, $s0, 0x8
    /* D4A88 800E4288 1000022A */  slti       $v0, $s0, 0x10
    /* D4A8C 800E428C EAFF4014 */  bnez       $v0, .L800E4238
    /* D4A90 800E4290 20003126 */   addiu     $s1, $s1, 0x20
    /* D4A94 800E4294 21400000 */  addu       $t0, $zero, $zero
    /* D4A98 800E4298 1480043C */  lui        $a0, %hi(D_8013E8E1)
    /* D4A9C 800E429C E1E88424 */  addiu      $a0, $a0, %lo(D_8013E8E1)
    /* D4AA0 800E42A0 FFFF8624 */  addiu      $a2, $a0, -0x1
    /* D4AA4 800E42A4 21380000 */  addu       $a3, $zero, $zero
  .L800E42A8:
    /* D4AA8 800E42A8 1480013C */  lui        $at, %hi(D_8013E8A0)
    /* D4AAC 800E42AC 21082700 */  addu       $at, $at, $a3
    /* D4AB0 800E42B0 A0E82290 */  lbu        $v0, %lo(D_8013E8A0)($at)
    /* D4AB4 800E42B4 0000C390 */  lbu        $v1, 0x0($a2)
    /* D4AB8 800E42B8 0100452C */  sltiu      $a1, $v0, 0x1
    /* D4ABC 800E42BC 0900A310 */  beq        $a1, $v1, .L800E42E4
    /* D4AC0 800E42C0 00000000 */   nop
    /* D4AC4 800E42C4 00008390 */  lbu        $v1, 0x0($a0)
    /* D4AC8 800E42C8 00000000 */  nop
    /* D4ACC 800E42CC 01006224 */  addiu      $v0, $v1, 0x1
    /* D4AD0 800E42D0 0600632C */  sltiu      $v1, $v1, 0x6
    /* D4AD4 800E42D4 03006014 */  bnez       $v1, .L800E42E4
    /* D4AD8 800E42D8 000082A0 */   sb        $v0, 0x0($a0)
    /* D4ADC 800E42DC 0000C5A0 */  sb         $a1, 0x0($a2)
    /* D4AE0 800E42E0 000080A0 */  sb         $zero, 0x0($a0)
  .L800E42E4:
    /* D4AE4 800E42E4 02008424 */  addiu      $a0, $a0, 0x2
    /* D4AE8 800E42E8 0200C624 */  addiu      $a2, $a2, 0x2
    /* D4AEC 800E42EC 01000825 */  addiu      $t0, $t0, 0x1
    /* D4AF0 800E42F0 08000229 */  slti       $v0, $t0, 0x8
    /* D4AF4 800E42F4 ECFF4014 */  bnez       $v0, .L800E42A8
    /* D4AF8 800E42F8 0800E724 */   addiu     $a3, $a3, 0x8
    /* D4AFC 800E42FC 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* D4B00 800E4300 1800B28F */  lw         $s2, 0x18($sp)
    /* D4B04 800E4304 1400B18F */  lw         $s1, 0x14($sp)
    /* D4B08 800E4308 1000B08F */  lw         $s0, 0x10($sp)
    /* D4B0C 800E430C 2000BD27 */  addiu      $sp, $sp, 0x20
    /* D4B10 800E4310 0800E003 */  jr         $ra
    /* D4B14 800E4314 00000000 */   nop
endlabel PAD_update
