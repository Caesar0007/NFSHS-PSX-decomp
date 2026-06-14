.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___14tPauseMenuDefs, 0x1B4

glabel ___14tPauseMenuDefs
    /* 8EA34 8009E234 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 8EA38 8009E238 1400B1AF */  sw         $s1, 0x14($sp)
    /* 8EA3C 8009E23C 21888000 */  addu       $s1, $a0, $zero
    /* 8EA40 8009E240 1000B0AF */  sw         $s0, 0x10($sp)
    /* 8EA44 8009E244 2180A000 */  addu       $s0, $a1, $zero
    /* 8EA48 8009E248 04032426 */  addiu      $a0, $s1, 0x304
    /* 8EA4C 8009E24C 1800BFAF */  sw         $ra, 0x18($sp)
    /* 8EA50 8009E250 05A0020C */  jal        ___6tPMenu
    /* 8EA54 8009E254 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EA58 8009E258 F4022426 */  addiu      $a0, $s1, 0x2F4
    /* 8EA5C 8009E25C BD9F020C */  jal        ___23tPMenuItemCommandButton
    /* 8EA60 8009E260 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EA64 8009E264 E4022426 */  addiu      $a0, $s1, 0x2E4
    /* 8EA68 8009E268 BD9F020C */  jal        ___23tPMenuItemCommandButton
    /* 8EA6C 8009E26C 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EA70 8009E270 D8022426 */  addiu      $a0, $s1, 0x2D8
    /* 8EA74 8009E274 219D020C */  jal        ___28tPMenuItemNonInteractiveText
    /* 8EA78 8009E278 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EA7C 8009E27C CC022426 */  addiu      $a0, $s1, 0x2CC
    /* 8EA80 8009E280 219D020C */  jal        ___28tPMenuItemNonInteractiveText
    /* 8EA84 8009E284 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EA88 8009E288 78022426 */  addiu      $a0, $s1, 0x278
    /* 8EA8C 8009E28C 05A0020C */  jal        ___6tPMenu
    /* 8EA90 8009E290 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EA94 8009E294 60022426 */  addiu      $a0, $s1, 0x260
    /* 8EA98 8009E298 2D9F020C */  jal        ___32tPMenuItemLeftRightSliderIndexed
    /* 8EA9C 8009E29C 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EAA0 8009E2A0 48022426 */  addiu      $a0, $s1, 0x248
    /* 8EAA4 8009E2A4 2D9F020C */  jal        ___32tPMenuItemLeftRightSliderIndexed
    /* 8EAA8 8009E2A8 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EAAC 8009E2AC 38022426 */  addiu      $a0, $s1, 0x238
    /* 8EAB0 8009E2B0 679D020C */  jal        ___25tPMenuItemLeftRightChoice
    /* 8EAB4 8009E2B4 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EAB8 8009E2B8 2C022426 */  addiu      $a0, $s1, 0x22C
    /* 8EABC 8009E2BC 219D020C */  jal        ___28tPMenuItemNonInteractiveText
    /* 8EAC0 8009E2C0 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EAC4 8009E2C4 1C022426 */  addiu      $a0, $s1, 0x21C
    /* 8EAC8 8009E2C8 7D9C020C */  jal        ___21tPListIteratorIndexed
    /* 8EACC 8009E2CC 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EAD0 8009E2D0 C8012426 */  addiu      $a0, $s1, 0x1C8
    /* 8EAD4 8009E2D4 05A0020C */  jal        ___6tPMenu
    /* 8EAD8 8009E2D8 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EADC 8009E2DC B4012426 */  addiu      $a0, $s1, 0x1B4
    /* 8EAE0 8009E2E0 1F9E020C */  jal        ___25tPMenuItemLeftRightSlider
    /* 8EAE4 8009E2E4 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EAE8 8009E2E8 A0012426 */  addiu      $a0, $s1, 0x1A0
    /* 8EAEC 8009E2EC 1F9E020C */  jal        ___25tPMenuItemLeftRightSlider
    /* 8EAF0 8009E2F0 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EAF4 8009E2F4 8C012426 */  addiu      $a0, $s1, 0x18C
    /* 8EAF8 8009E2F8 1F9E020C */  jal        ___25tPMenuItemLeftRightSlider
    /* 8EAFC 8009E2FC 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EB00 8009E300 78012426 */  addiu      $a0, $s1, 0x178
    /* 8EB04 8009E304 1F9E020C */  jal        ___25tPMenuItemLeftRightSlider
    /* 8EB08 8009E308 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EB0C 8009E30C 64012426 */  addiu      $a0, $s1, 0x164
    /* 8EB10 8009E310 1F9E020C */  jal        ___25tPMenuItemLeftRightSlider
    /* 8EB14 8009E314 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EB18 8009E318 54012426 */  addiu      $a0, $s1, 0x154
    /* 8EB1C 8009E31C 679D020C */  jal        ___25tPMenuItemLeftRightChoice
    /* 8EB20 8009E320 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EB24 8009E324 48012426 */  addiu      $a0, $s1, 0x148
    /* 8EB28 8009E328 039C020C */  jal        ___14tPListIterator
    /* 8EB2C 8009E32C 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EB30 8009E330 3C012426 */  addiu      $a0, $s1, 0x13C
    /* 8EB34 8009E334 219D020C */  jal        ___28tPMenuItemNonInteractiveText
    /* 8EB38 8009E338 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EB3C 8009E33C E8002426 */  addiu      $a0, $s1, 0xE8
    /* 8EB40 8009E340 05A0020C */  jal        ___6tPMenu
    /* 8EB44 8009E344 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EB48 8009E348 D4002426 */  addiu      $a0, $s1, 0xD4
    /* 8EB4C 8009E34C 729F020C */  jal        ___24tPMenuItemGoToMenuButton
    /* 8EB50 8009E350 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EB54 8009E354 C0002426 */  addiu      $a0, $s1, 0xC0
    /* 8EB58 8009E358 729F020C */  jal        ___24tPMenuItemGoToMenuButton
    /* 8EB5C 8009E35C 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EB60 8009E360 B4002426 */  addiu      $a0, $s1, 0xB4
    /* 8EB64 8009E364 219D020C */  jal        ___28tPMenuItemNonInteractiveText
    /* 8EB68 8009E368 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EB6C 8009E36C 60002426 */  addiu      $a0, $s1, 0x60
    /* 8EB70 8009E370 05A0020C */  jal        ___6tPMenu
    /* 8EB74 8009E374 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EB78 8009E378 50002426 */  addiu      $a0, $s1, 0x50
    /* 8EB7C 8009E37C BD9F020C */  jal        ___23tPMenuItemCommandButton
    /* 8EB80 8009E380 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EB84 8009E384 40002426 */  addiu      $a0, $s1, 0x40
    /* 8EB88 8009E388 BD9F020C */  jal        ___23tPMenuItemCommandButton
    /* 8EB8C 8009E38C 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EB90 8009E390 2C002426 */  addiu      $a0, $s1, 0x2C
    /* 8EB94 8009E394 729F020C */  jal        ___24tPMenuItemGoToMenuButton
    /* 8EB98 8009E398 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EB9C 8009E39C 1C002426 */  addiu      $a0, $s1, 0x1C
    /* 8EBA0 8009E3A0 BD9F020C */  jal        ___23tPMenuItemCommandButton
    /* 8EBA4 8009E3A4 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EBA8 8009E3A8 0C002426 */  addiu      $a0, $s1, 0xC
    /* 8EBAC 8009E3AC BD9F020C */  jal        ___23tPMenuItemCommandButton
    /* 8EBB0 8009E3B0 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EBB4 8009E3B4 21202002 */  addu       $a0, $s1, $zero
    /* 8EBB8 8009E3B8 219D020C */  jal        ___28tPMenuItemNonInteractiveText
    /* 8EBBC 8009E3BC 02000524 */   addiu     $a1, $zero, 0x2
    /* 8EBC0 8009E3C0 01001032 */  andi       $s0, $s0, 0x1
    /* 8EBC4 8009E3C4 03000012 */  beqz       $s0, .L8009E3D4
    /* 8EBC8 8009E3C8 00000000 */   nop
    /* 8EBCC 8009E3CC 6B8F020C */  jal        __builtin_delete
    /* 8EBD0 8009E3D0 21202002 */   addu      $a0, $s1, $zero
  .L8009E3D4:
    /* 8EBD4 8009E3D4 1800BF8F */  lw         $ra, 0x18($sp)
    /* 8EBD8 8009E3D8 1400B18F */  lw         $s1, 0x14($sp)
    /* 8EBDC 8009E3DC 1000B08F */  lw         $s0, 0x10($sp)
    /* 8EBE0 8009E3E0 0800E003 */  jr         $ra
    /* 8EBE4 8009E3E4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ___14tPauseMenuDefs
