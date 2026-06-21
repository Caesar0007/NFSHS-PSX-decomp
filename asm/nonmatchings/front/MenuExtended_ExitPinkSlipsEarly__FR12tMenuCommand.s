.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_ExitPinkSlipsEarly__FR12tMenuCommand, 0x130

glabel MenuExtended_ExitPinkSlipsEarly__FR12tMenuCommand
    /* 1EA1C 8002E21C E0FEBD27 */  addiu      $sp, $sp, -0x120
    /* 1EA20 8002E220 1401B3AF */  sw         $s3, 0x114($sp)
    /* 1EA24 8002E224 21988000 */  addu       $s3, $a0, $zero
    /* 1EA28 8002E228 1000A427 */  addiu      $a0, $sp, 0x10
    /* 1EA2C 8002E22C 1801BFAF */  sw         $ra, 0x118($sp)
    /* 1EA30 8002E230 1001B2AF */  sw         $s2, 0x110($sp)
    /* 1EA34 8002E234 0C01B1AF */  sw         $s1, 0x10C($sp)
    /* 1EA38 8002E238 A366000C */  jal        __12tDialogYesNo
    /* 1EA3C 8002E23C 0801B0AF */   sw        $s0, 0x108($sp)
    /* 1EA40 8002E240 9D000424 */  addiu      $a0, $zero, 0x9D
    /* 1EA44 8002E244 1000B027 */  addiu      $s0, $sp, 0x10
    /* 1EA48 8002E248 21030224 */  addiu      $v0, $zero, 0x321
    /* 1EA4C 8002E24C A00002AE */  sw         $v0, 0xA0($s0)
    /* 1EA50 8002E250 22030224 */  addiu      $v0, $zero, 0x322
    /* 1EA54 8002E254 A40002AE */  sw         $v0, 0xA4($s0)
    /* 1EA58 8002E258 94E4020C */  jal        TextSys_Word__Fi
    /* 1EA5C 8002E25C 880000A6 */   sh        $zero, 0x88($s0)
    /* 1EA60 8002E260 21200002 */  addu       $a0, $s0, $zero
    /* 1EA64 8002E264 FA65000C */  jal        Run__18tDialogInteractive
    /* 1EA68 8002E268 900082AC */   sw        $v0, 0x90($a0)
    /* 1EA6C 8002E26C 00140200 */  sll        $v0, $v0, 16
    /* 1EA70 8002E270 2C004010 */  beqz       $v0, .L8002E324
    /* 1EA74 8002E274 21200000 */   addu      $a0, $zero, $zero
    /* 1EA78 8002E278 A9D1000C */  jal        Init_Memcard__FbT0
    /* 1EA7C 8002E27C 01000524 */   addiu     $a1, $zero, 0x1
    /* 1EA80 8002E280 21880000 */  addu       $s1, $zero, $zero
    /* 1EA84 8002E284 B800B227 */  addiu      $s2, $sp, 0xB8
    /* 1EA88 8002E288 0200222A */  slti       $v0, $s1, 0x2
  .L8002E28C:
    /* 1EA8C 8002E28C 17004010 */  beqz       $v0, .L8002E2EC
    /* 1EA90 8002E290 00000000 */   nop
    /* 1EA94 8002E294 94E4020C */  jal        TextSys_Word__Fi
    /* 1EA98 8002E298 97020424 */   addiu     $a0, $zero, 0x297
    /* 1EA9C 8002E29C 21202002 */  addu       $a0, $s1, $zero
    /* 1EAA0 8002E2A0 7FAE000C */  jal        PlayerName__Fi
    /* 1EAA4 8002E2A4 21804000 */   addu      $s0, $v0, $zero
    /* 1EAA8 8002E2A8 21204002 */  addu       $a0, $s2, $zero
    /* 1EAAC 8002E2AC 21280002 */  addu       $a1, $s0, $zero
    /* 1EAB0 8002E2B0 21304000 */  addu       $a2, $v0, $zero
    /* 1EAB4 8002E2B4 01003026 */  addiu      $s0, $s1, 0x1
    /* 1EAB8 8002E2B8 2F91030C */  jal        sprintf
    /* 1EABC 8002E2BC 21380002 */   addu      $a3, $s0, $zero
    /* 1EAC0 8002E2C0 00241100 */  sll        $a0, $s1, 16
    /* 1EAC4 8002E2C4 03240400 */  sra        $a0, $a0, 16
    /* 1EAC8 8002E2C8 01000524 */  addiu      $a1, $zero, 0x1
    /* 1EACC 8002E2CC FFFF0624 */  addiu      $a2, $zero, -0x1
    /* 1EAD0 8002E2D0 0580023C */  lui        $v0, %hi(FEApp)
    /* 1EAD4 8002E2D4 C014428C */  lw         $v0, %lo(FEApp)($v0)
    /* 1EAD8 8002E2D8 21880002 */  addu       $s1, $s0, $zero
    /* 1EADC 8002E2DC DED5000C */  jal        SavePinkSlipsCarsWithErrorDialogs__Fsss
    /* 1EAE0 8002E2E0 600352AC */   sw        $s2, 0x360($v0)
    /* 1EAE4 8002E2E4 A3B80008 */  j          .L8002E28C
    /* 1EAE8 8002E2E8 0200222A */   slti      $v0, $s1, 0x2
  .L8002E2EC:
    /* 1EAEC 8002E2EC 00D2000C */  jal        DeInit_Memcard__Fv
    /* 1EAF0 8002E2F0 00000000 */   nop
    /* 1EAF4 8002E2F4 0580023C */  lui        $v0, %hi(FEApp)
    /* 1EAF8 8002E2F8 C014448C */  lw         $a0, %lo(FEApp)($v0)
    /* 1EAFC 8002E2FC 4162000C */  jal        Hide__11tDialogBase
    /* 1EB00 8002E300 D0028424 */   addiu     $a0, $a0, 0x2D0
    /* 1EB04 8002E304 0580023C */  lui        $v0, %hi(menuDefs)
    /* 1EB08 8002E308 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1EB0C 8002E30C 02000324 */  addiu      $v1, $zero, 0x2
    /* 1EB10 8002E310 000063AE */  sw         $v1, 0x0($s3)
    /* 1EB14 8002E314 B0004224 */  addiu      $v0, $v0, 0xB0
    /* 1EB18 8002E318 040062AE */  sw         $v0, 0x4($s3)
    /* 1EB1C 8002E31C 1180023C */  lui        $v0, %hi(D_80114604)
    /* 1EB20 8002E320 044640A0 */  sb         $zero, %lo(D_80114604)($v0)
  .L8002E324:
    /* 1EB24 8002E324 1000A427 */  addiu      $a0, $sp, 0x10
    /* 1EB28 8002E328 1E98000C */  jal        ___7tScreen
    /* 1EB2C 8002E32C 02000524 */   addiu     $a1, $zero, 0x2
    /* 1EB30 8002E330 1801BF8F */  lw         $ra, 0x118($sp)
    /* 1EB34 8002E334 1401B38F */  lw         $s3, 0x114($sp)
    /* 1EB38 8002E338 1001B28F */  lw         $s2, 0x110($sp)
    /* 1EB3C 8002E33C 0C01B18F */  lw         $s1, 0x10C($sp)
    /* 1EB40 8002E340 0801B08F */  lw         $s0, 0x108($sp)
    /* 1EB44 8002E344 0800E003 */  jr         $ra
    /* 1EB48 8002E348 2001BD27 */   addiu     $sp, $sp, 0x120
endlabel MenuExtended_ExitPinkSlipsEarly__FR12tMenuCommand
