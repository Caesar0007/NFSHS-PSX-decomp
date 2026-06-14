.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCH_AddEvent, 0x148

glabel SPCH_AddEvent
    /* D79B8 800E71B8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D79BC 800E71BC 1800B2AF */  sw         $s2, 0x18($sp)
    /* D79C0 800E71C0 21908000 */  addu       $s2, $a0, $zero
    /* D79C4 800E71C4 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* D79C8 800E71C8 1400B1AF */  sw         $s1, 0x14($sp)
    /* D79CC 800E71CC 1000B0AF */  sw         $s0, 0x10($sp)
    /* D79D0 800E71D0 0000448E */  lw         $a0, 0x0($s2)
    /* D79D4 800E71D4 D39B030C */  jal        iSPCH_FindEvent
    /* D79D8 800E71D8 00000000 */   nop
    /* D79DC 800E71DC 21884000 */  addu       $s1, $v0, $zero
    /* D79E0 800E71E0 40002012 */  beqz       $s1, .L800E72E4
    /* D79E4 800E71E4 00000000 */   nop
    /* D79E8 800E71E8 09003082 */  lb         $s0, 0x9($s1)
    /* D79EC 800E71EC CCAE030C */  jal        iSPCH_Rand
    /* D79F0 800E71F0 64000424 */   addiu     $a0, $zero, 0x64
    /* D79F4 800E71F4 2A800202 */  slt        $s0, $s0, $v0
    /* D79F8 800E71F8 3A000016 */  bnez       $s0, .L800E72E4
    /* D79FC 800E71FC 00000000 */   nop
    /* D7A00 800E7200 04002496 */  lhu        $a0, 0x4($s1)
    /* D7A04 800E7204 229C030C */  jal        iSPCH_FindEventSlot
    /* D7A08 800E7208 00000000 */   nop
    /* D7A0C 800E720C 21804000 */  addu       $s0, $v0, $zero
    /* D7A10 800E7210 34000006 */  bltz       $s0, .L800E72E4
    /* D7A14 800E7214 00000000 */   nop
    /* D7A18 800E7218 88A0030C */  jal        gettick
    /* D7A1C 800E721C 00000000 */   nop
    /* D7A20 800E7220 1580033C */  lui        $v1, %hi(gLastTick)
    /* D7A24 800E7224 3884638C */  lw         $v1, %lo(gLastTick)($v1)
    /* D7A28 800E7228 21384000 */  addu       $a3, $v0, $zero
    /* D7A2C 800E722C 0700E314 */  bne        $a3, $v1, .L800E724C
    /* D7A30 800E7230 1580023C */   lui       $v0, %hi(gLastSubTick)
    /* D7A34 800E7234 1580033C */  lui        $v1, %hi(gLastSubTick)
    /* D7A38 800E7238 30846294 */  lhu        $v0, %lo(gLastSubTick)($v1)
    /* D7A3C 800E723C 00000000 */  nop
    /* D7A40 800E7240 01004224 */  addiu      $v0, $v0, 0x1
    /* D7A44 800E7244 949C0308 */  j          .L800E7250
    /* D7A48 800E7248 308462A4 */   sh        $v0, %lo(gLastSubTick)($v1)
  .L800E724C:
    /* D7A4C 800E724C 308440A4 */  sh         $zero, %lo(gLastSubTick)($v0)
  .L800E7250:
    /* D7A50 800E7250 21300000 */  addu       $a2, $zero, $zero
    /* D7A54 800E7254 1580023C */  lui        $v0, %hi(gVoxEvents)
    /* D7A58 800E7258 60804224 */  addiu      $v0, $v0, %lo(gVoxEvents)
    /* D7A5C 800E725C 21404000 */  addu       $t0, $v0, $zero
    /* D7A60 800E7260 21204002 */  addu       $a0, $s2, $zero
    /* D7A64 800E7264 00111000 */  sll        $v0, $s0, 4
    /* D7A68 800E7268 23105000 */  subu       $v0, $v0, $s0
    /* D7A6C 800E726C 80100200 */  sll        $v0, $v0, 2
    /* D7A70 800E7270 21284000 */  addu       $a1, $v0, $zero
    /* D7A74 800E7274 1580023C */  lui        $v0, %hi(gLastTick)
    /* D7A78 800E7278 388447AC */  sw         $a3, %lo(gLastTick)($v0)
    /* D7A7C 800E727C 1580023C */  lui        $v0, %hi(gLastSubTick)
    /* D7A80 800E7280 30844394 */  lhu        $v1, %lo(gLastSubTick)($v0)
    /* D7A84 800E7284 2110A800 */  addu       $v0, $a1, $t0
    /* D7A88 800E7288 100051AC */  sw         $s1, 0x10($v0)
    /* D7A8C 800E728C 0C0047AC */  sw         $a3, 0xC($v0)
    /* D7A90 800E7290 0A0043A4 */  sh         $v1, 0xA($v0)
  .L800E7294:
    /* D7A94 800E7294 0000838C */  lw         $v1, 0x0($a0)
    /* D7A98 800E7298 04008424 */  addiu      $a0, $a0, 0x4
    /* D7A9C 800E729C 2110A800 */  addu       $v0, $a1, $t0
    /* D7AA0 800E72A0 0100C624 */  addiu      $a2, $a2, 0x1
    /* D7AA4 800E72A4 140043AC */  sw         $v1, 0x14($v0)
    /* D7AA8 800E72A8 0C00C228 */  slti       $v0, $a2, 0xC
    /* D7AAC 800E72AC F9FF4014 */  bnez       $v0, .L800E7294
    /* D7AB0 800E72B0 0400A524 */   addiu     $a1, $a1, 0x4
    /* D7AB4 800E72B4 1580033C */  lui        $v1, %hi(gVoxEvents)
    /* D7AB8 800E72B8 6080628C */  lw         $v0, %lo(gVoxEvents)($v1)
    /* D7ABC 800E72BC 00000000 */  nop
    /* D7AC0 800E72C0 01004224 */  addiu      $v0, $v0, 0x1
    /* D7AC4 800E72C4 608062AC */  sw         $v0, %lo(gVoxEvents)($v1)
    /* D7AC8 800E72C8 60806324 */  addiu      $v1, $v1, %lo(gVoxEvents)
    /* D7ACC 800E72CC 00111000 */  sll        $v0, $s0, 4
    /* D7AD0 800E72D0 23105000 */  subu       $v0, $v0, $s0
    /* D7AD4 800E72D4 80100200 */  sll        $v0, $v0, 2
    /* D7AD8 800E72D8 21104300 */  addu       $v0, $v0, $v1
    /* D7ADC 800E72DC 01000324 */  addiu      $v1, $zero, 0x1
    /* D7AE0 800E72E0 080043A4 */  sh         $v1, 0x8($v0)
  .L800E72E4:
    /* D7AE4 800E72E4 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* D7AE8 800E72E8 1800B28F */  lw         $s2, 0x18($sp)
    /* D7AEC 800E72EC 1400B18F */  lw         $s1, 0x14($sp)
    /* D7AF0 800E72F0 1000B08F */  lw         $s0, 0x10($sp)
    /* D7AF4 800E72F4 21100000 */  addu       $v0, $zero, $zero
    /* D7AF8 800E72F8 0800E003 */  jr         $ra
    /* D7AFC 800E72FC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SPCH_AddEvent
