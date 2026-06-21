.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawForeground__18tScreenTournSelect, 0x98

glabel DrawForeground__18tScreenTournSelect
    /* 30CD8 800404D8 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 30CDC 800404DC 2800B2AF */  sw         $s2, 0x28($sp)
    /* 30CE0 800404E0 21908000 */  addu       $s2, $a0, $zero
    /* 30CE4 800404E4 2300043C */  lui        $a0, (0x232323 >> 16)
    /* 30CE8 800404E8 23238434 */  ori        $a0, $a0, (0x232323 & 0xFFFF)
    /* 30CEC 800404EC A7000524 */  addiu      $a1, $zero, 0xA7
    /* 30CF0 800404F0 29000624 */  addiu      $a2, $zero, 0x29
    /* 30CF4 800404F4 3C010724 */  addiu      $a3, $zero, 0x13C
    /* 30CF8 800404F8 2000B0AF */  sw         $s0, 0x20($sp)
    /* 30CFC 800404FC 01001024 */  addiu      $s0, $zero, 0x1
    /* 30D00 80040500 03000224 */  addiu      $v0, $zero, 0x3
    /* 30D04 80040504 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 30D08 80040508 2400B1AF */  sw         $s1, 0x24($sp)
    /* 30D0C 8004050C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 30D10 80040510 1400A2AF */  sw         $v0, 0x14($sp)
    /* 30D14 80040514 5C004286 */  lh         $v0, 0x5C($s2)
    /* 30D18 80040518 14001124 */  addiu      $s1, $zero, 0x14
    /* 30D1C 8004051C 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 30D20 80040520 CE2E010C */  jal        PSXDrawBrightEndLine__Fiiiiiiii
    /* 30D24 80040524 1800A2AF */   sw        $v0, 0x18($sp)
    /* 30D28 80040528 2300043C */  lui        $a0, (0x232323 >> 16)
    /* 30D2C 8004052C 23238434 */  ori        $a0, $a0, (0x232323 & 0xFFFF)
    /* 30D30 80040530 A7000524 */  addiu      $a1, $zero, 0xA7
    /* 30D34 80040534 4A000624 */  addiu      $a2, $zero, 0x4A
    /* 30D38 80040538 02000224 */  addiu      $v0, $zero, 0x2
    /* 30D3C 8004053C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 30D40 80040540 1400A2AF */  sw         $v0, 0x14($sp)
    /* 30D44 80040544 5C004286 */  lh         $v0, 0x5C($s2)
    /* 30D48 80040548 3C010724 */  addiu      $a3, $zero, 0x13C
    /* 30D4C 8004054C 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 30D50 80040550 CE2E010C */  jal        PSXDrawBrightEndLine__Fiiiiiiii
    /* 30D54 80040554 1800A2AF */   sw        $v0, 0x18($sp)
    /* 30D58 80040558 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 30D5C 8004055C 2800B28F */  lw         $s2, 0x28($sp)
    /* 30D60 80040560 2400B18F */  lw         $s1, 0x24($sp)
    /* 30D64 80040564 2000B08F */  lw         $s0, 0x20($sp)
    /* 30D68 80040568 0800E003 */  jr         $ra
    /* 30D6C 8004056C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel DrawForeground__18tScreenTournSelect
