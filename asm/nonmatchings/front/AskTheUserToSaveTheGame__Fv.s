.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AskTheUserToSaveTheGame__Fv, 0x78

glabel AskTheUserToSaveTheGame__Fv
    /* 1CC1C 8002C41C 40FFBD27 */  addiu      $sp, $sp, -0xC0
    /* 1CC20 8002C420 BC00BFAF */  sw         $ra, 0xBC($sp)
    /* 1CC24 8002C424 F48D000C */  jal        FECheat_IsTheUserACryBabyCheater__Fv
    /* 1CC28 8002C428 B800B0AF */   sw        $s0, 0xB8($sp)
    /* 1CC2C 8002C42C 01004238 */  xori       $v0, $v0, 0x1
    /* 1CC30 8002C430 14004010 */  beqz       $v0, .L8002C484
    /* 1CC34 8002C434 21100000 */   addu      $v0, $zero, $zero
    /* 1CC38 8002C438 A366000C */  jal        __12tDialogYesNo
    /* 1CC3C 8002C43C 1000A427 */   addiu     $a0, $sp, 0x10
    /* 1CC40 8002C440 94E4020C */  jal        TextSys_Word__Fi
    /* 1CC44 8002C444 31030424 */   addiu     $a0, $zero, 0x331
    /* 1CC48 8002C448 1000B027 */  addiu      $s0, $sp, 0x10
    /* 1CC4C 8002C44C 21200002 */  addu       $a0, $s0, $zero
    /* 1CC50 8002C450 900002AE */  sw         $v0, 0x90($s0)
    /* 1CC54 8002C454 21030224 */  addiu      $v0, $zero, 0x321
    /* 1CC58 8002C458 A00002AE */  sw         $v0, 0xA0($s0)
    /* 1CC5C 8002C45C 22030224 */  addiu      $v0, $zero, 0x322
    /* 1CC60 8002C460 A40002AE */  sw         $v0, 0xA4($s0)
    /* 1CC64 8002C464 FA65000C */  jal        Run__18tDialogInteractive
    /* 1CC68 8002C468 880000A6 */   sh        $zero, 0x88($s0)
    /* 1CC6C 8002C46C 21200002 */  addu       $a0, $s0, $zero
    /* 1CC70 8002C470 00840200 */  sll        $s0, $v0, 16
    /* 1CC74 8002C474 03841000 */  sra        $s0, $s0, 16
    /* 1CC78 8002C478 1E98000C */  jal        ___7tScreen
    /* 1CC7C 8002C47C 02000524 */   addiu     $a1, $zero, 0x2
    /* 1CC80 8002C480 21100002 */  addu       $v0, $s0, $zero
  .L8002C484:
    /* 1CC84 8002C484 BC00BF8F */  lw         $ra, 0xBC($sp)
    /* 1CC88 8002C488 B800B08F */  lw         $s0, 0xB8($sp)
    /* 1CC8C 8002C48C 0800E003 */  jr         $ra
    /* 1CC90 8002C490 C000BD27 */   addiu     $sp, $sp, 0xC0
endlabel AskTheUserToSaveTheGame__Fv
