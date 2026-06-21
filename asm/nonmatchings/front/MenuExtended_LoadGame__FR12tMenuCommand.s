.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_LoadGame__FR12tMenuCommand, 0x98

glabel MenuExtended_LoadGame__FR12tMenuCommand
    /* 1E0D0 8002D8D0 0580023C */  lui        $v0, %hi(menuDefs)
    /* 1E0D4 8002D8D4 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1E0D8 8002D8D8 38FFBD27 */  addiu      $sp, $sp, -0xC8
    /* 1E0DC 8002D8DC C400BFAF */  sw         $ra, 0xC4($sp)
    /* 1E0E0 8002D8E0 C000B0AF */  sw         $s0, 0xC0($sp)
    /* 1E0E4 8002D8E4 8030428C */  lw         $v0, 0x3080($v0)
    /* 1E0E8 8002D8E8 00000000 */  nop
    /* 1E0EC 8002D8EC 01004230 */  andi       $v0, $v0, 0x1
    /* 1E0F0 8002D8F0 19004014 */  bnez       $v0, .L8002D958
    /* 1E0F4 8002D8F4 00000000 */   nop
    /* 1E0F8 8002D8F8 A366000C */  jal        __12tDialogYesNo
    /* 1E0FC 8002D8FC 1000A427 */   addiu     $a0, $sp, 0x10
    /* 1E100 8002D900 C0020424 */  addiu      $a0, $zero, 0x2C0
    /* 1E104 8002D904 1000B027 */  addiu      $s0, $sp, 0x10
    /* 1E108 8002D908 21030224 */  addiu      $v0, $zero, 0x321
    /* 1E10C 8002D90C A00002AE */  sw         $v0, 0xA0($s0)
    /* 1E110 8002D910 22030224 */  addiu      $v0, $zero, 0x322
    /* 1E114 8002D914 A40002AE */  sw         $v0, 0xA4($s0)
    /* 1E118 8002D918 94E4020C */  jal        TextSys_Word__Fi
    /* 1E11C 8002D91C 880000A6 */   sh        $zero, 0x88($s0)
    /* 1E120 8002D920 21200002 */  addu       $a0, $s0, $zero
    /* 1E124 8002D924 FA65000C */  jal        Run__18tDialogInteractive
    /* 1E128 8002D928 900002AE */   sw        $v0, 0x90($s0)
    /* 1E12C 8002D92C 00140200 */  sll        $v0, $v0, 16
    /* 1E130 8002D930 06004010 */  beqz       $v0, .L8002D94C
    /* 1E134 8002D934 0580023C */   lui       $v0, %hi(screenMemcard)
    /* 1E138 8002D938 F028428C */  lw         $v0, %lo(screenMemcard)($v0)
    /* 1E13C 8002D93C 00000000 */  nop
    /* 1E140 8002D940 9C054484 */  lh         $a0, 0x59C($v0)
    /* 1E144 8002D944 0FB6000C */  jal        GenericMenuLoadGame__Fi
    /* 1E148 8002D948 00000000 */   nop
  .L8002D94C:
    /* 1E14C 8002D94C 21200002 */  addu       $a0, $s0, $zero
    /* 1E150 8002D950 1E98000C */  jal        ___7tScreen
    /* 1E154 8002D954 02000524 */   addiu     $a1, $zero, 0x2
  .L8002D958:
    /* 1E158 8002D958 C400BF8F */  lw         $ra, 0xC4($sp)
    /* 1E15C 8002D95C C000B08F */  lw         $s0, 0xC0($sp)
    /* 1E160 8002D960 0800E003 */  jr         $ra
    /* 1E164 8002D964 C800BD27 */   addiu     $sp, $sp, 0xC8
endlabel MenuExtended_LoadGame__FR12tMenuCommand
