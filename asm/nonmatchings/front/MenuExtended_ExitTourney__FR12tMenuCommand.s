.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_ExitTourney__FR12tMenuCommand, 0x90

glabel MenuExtended_ExitTourney__FR12tMenuCommand
    /* 1E98C 8002E18C 38FFBD27 */  addiu      $sp, $sp, -0xC8
    /* 1E990 8002E190 BC00B1AF */  sw         $s1, 0xBC($sp)
    /* 1E994 8002E194 21888000 */  addu       $s1, $a0, $zero
    /* 1E998 8002E198 1000A427 */  addiu      $a0, $sp, 0x10
    /* 1E99C 8002E19C C000BFAF */  sw         $ra, 0xC0($sp)
    /* 1E9A0 8002E1A0 A366000C */  jal        __12tDialogYesNo
    /* 1E9A4 8002E1A4 B800B0AF */   sw        $s0, 0xB8($sp)
    /* 1E9A8 8002E1A8 9D000424 */  addiu      $a0, $zero, 0x9D
    /* 1E9AC 8002E1AC 1000B027 */  addiu      $s0, $sp, 0x10
    /* 1E9B0 8002E1B0 21030224 */  addiu      $v0, $zero, 0x321
    /* 1E9B4 8002E1B4 A00002AE */  sw         $v0, 0xA0($s0)
    /* 1E9B8 8002E1B8 22030224 */  addiu      $v0, $zero, 0x322
    /* 1E9BC 8002E1BC A40002AE */  sw         $v0, 0xA4($s0)
    /* 1E9C0 8002E1C0 94E4020C */  jal        TextSys_Word__Fi
    /* 1E9C4 8002E1C4 880000A6 */   sh        $zero, 0x88($s0)
    /* 1E9C8 8002E1C8 21200002 */  addu       $a0, $s0, $zero
    /* 1E9CC 8002E1CC FA65000C */  jal        Run__18tDialogInteractive
    /* 1E9D0 8002E1D0 900082AC */   sw        $v0, 0x90($a0)
    /* 1E9D4 8002E1D4 00140200 */  sll        $v0, $v0, 16
    /* 1E9D8 8002E1D8 07004010 */  beqz       $v0, .L8002E1F8
    /* 1E9DC 8002E1DC 0580023C */   lui       $v0, %hi(menuDefs)
    /* 1E9E0 8002E1E0 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1E9E4 8002E1E4 02000324 */  addiu      $v1, $zero, 0x2
    /* 1E9E8 8002E1E8 000023AE */  sw         $v1, 0x0($s1)
    /* 1E9EC 8002E1EC B0004224 */  addiu      $v0, $v0, 0xB0
    /* 1E9F0 8002E1F0 7FB80008 */  j          .L8002E1FC
    /* 1E9F4 8002E1F4 040022AE */   sw        $v0, 0x4($s1)
  .L8002E1F8:
    /* 1E9F8 8002E1F8 000020AE */  sw         $zero, 0x0($s1)
  .L8002E1FC:
    /* 1E9FC 8002E1FC 1000A427 */  addiu      $a0, $sp, 0x10
    /* 1EA00 8002E200 1E98000C */  jal        ___7tScreen
    /* 1EA04 8002E204 02000524 */   addiu     $a1, $zero, 0x2
    /* 1EA08 8002E208 C000BF8F */  lw         $ra, 0xC0($sp)
    /* 1EA0C 8002E20C BC00B18F */  lw         $s1, 0xBC($sp)
    /* 1EA10 8002E210 B800B08F */  lw         $s0, 0xB8($sp)
    /* 1EA14 8002E214 0800E003 */  jr         $ra
    /* 1EA18 8002E218 C800BD27 */   addiu     $sp, $sp, 0xC8
endlabel MenuExtended_ExitTourney__FR12tMenuCommand
