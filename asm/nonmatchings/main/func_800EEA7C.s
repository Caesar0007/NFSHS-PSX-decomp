.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800EEA7C, 0xE0

glabel func_800EEA7C
    /* DF27C 800EEA7C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DF280 800EEA80 1000B0AF */  sw         $s0, 0x10($sp)
    /* DF284 800EEA84 2180A000 */  addu       $s0, $a1, $zero
    /* DF288 800EEA88 1280053C */  lui        $a1, %hi(D_801237C0)
    /* DF28C 800EEA8C C037A58C */  lw         $a1, %lo(D_801237C0)($a1)
    /* DF290 800EEA90 1800BFAF */  sw         $ra, 0x18($sp)
    /* DF294 800EEA94 1400B1AF */  sw         $s1, 0x14($sp)
    /* DF298 800EEA98 0000A28C */  lw         $v0, 0x0($a1)
    /* DF29C 800EEA9C 0008033C */  lui        $v1, (0x8000000 >> 16)
    /* DF2A0 800EEAA0 25104300 */  or         $v0, $v0, $v1
    /* DF2A4 800EEAA4 0000A2AC */  sw         $v0, 0x0($a1)
    /* DF2A8 800EEAA8 1280023C */  lui        $v0, %hi(D_801237BC)
    /* DF2AC 800EEAAC BC37428C */  lw         $v0, %lo(D_801237BC)($v0)
    /* DF2B0 800EEAB0 00000000 */  nop
    /* DF2B4 800EEAB4 000040AC */  sw         $zero, 0x0($v0)
    /* DF2B8 800EEAB8 80101000 */  sll        $v0, $s0, 2
    /* DF2BC 800EEABC FCFF4224 */  addiu      $v0, $v0, -0x4
    /* DF2C0 800EEAC0 1280033C */  lui        $v1, %hi(D_801237B4)
    /* DF2C4 800EEAC4 B437638C */  lw         $v1, %lo(D_801237B4)($v1)
    /* DF2C8 800EEAC8 21208200 */  addu       $a0, $a0, $v0
    /* DF2CC 800EEACC 000064AC */  sw         $a0, 0x0($v1)
    /* DF2D0 800EEAD0 1280023C */  lui        $v0, %hi(D_801237B8)
    /* DF2D4 800EEAD4 B837428C */  lw         $v0, %lo(D_801237B8)($v0)
    /* DF2D8 800EEAD8 0011033C */  lui        $v1, (0x11000002 >> 16)
    /* DF2DC 800EEADC 000050AC */  sw         $s0, 0x0($v0)
    /* DF2E0 800EEAE0 1280023C */  lui        $v0, %hi(D_801237BC)
    /* DF2E4 800EEAE4 BC37428C */  lw         $v0, %lo(D_801237BC)($v0)
    /* DF2E8 800EEAE8 02006334 */  ori        $v1, $v1, (0x11000002 & 0xFFFF)
    /* DF2EC 800EEAEC BEBE030C */  jal        func_800EFAF8
    /* DF2F0 800EEAF0 000043AC */   sw        $v1, 0x0($v0)
    /* DF2F4 800EEAF4 1280023C */  lui        $v0, %hi(D_801237BC)
    /* DF2F8 800EEAF8 BC37428C */  lw         $v0, %lo(D_801237BC)($v0)
    /* DF2FC 800EEAFC 00000000 */  nop
    /* DF300 800EEB00 0000428C */  lw         $v0, 0x0($v0)
    /* DF304 800EEB04 0001033C */  lui        $v1, (0x1000000 >> 16)
    /* DF308 800EEB08 24104300 */  and        $v0, $v0, $v1
    /* DF30C 800EEB0C 0E004010 */  beqz       $v0, .L800EEB48
    /* DF310 800EEB10 21100002 */   addu      $v0, $s0, $zero
    /* DF314 800EEB14 0001113C */  lui        $s1, (0x1000000 >> 16)
  .L800EEB18:
    /* DF318 800EEB18 CBBE030C */  jal        func_800EFB2C
    /* DF31C 800EEB1C 00000000 */   nop
    /* DF320 800EEB20 09004014 */  bnez       $v0, .L800EEB48
    /* DF324 800EEB24 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* DF328 800EEB28 1280023C */  lui        $v0, %hi(D_801237BC)
    /* DF32C 800EEB2C BC37428C */  lw         $v0, %lo(D_801237BC)($v0)
    /* DF330 800EEB30 00000000 */  nop
    /* DF334 800EEB34 0000428C */  lw         $v0, 0x0($v0)
    /* DF338 800EEB38 00000000 */  nop
    /* DF33C 800EEB3C 24105100 */  and        $v0, $v0, $s1
    /* DF340 800EEB40 F5FF4014 */  bnez       $v0, .L800EEB18
    /* DF344 800EEB44 21100002 */   addu      $v0, $s0, $zero
  .L800EEB48:
    /* DF348 800EEB48 1800BF8F */  lw         $ra, 0x18($sp)
    /* DF34C 800EEB4C 1400B18F */  lw         $s1, 0x14($sp)
    /* DF350 800EEB50 1000B08F */  lw         $s0, 0x10($sp)
    /* DF354 800EEB54 0800E003 */  jr         $ra
    /* DF358 800EEB58 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel func_800EEA7C
