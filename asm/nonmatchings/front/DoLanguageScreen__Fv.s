.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DoLanguageScreen__Fv, 0x3C

glabel DoLanguageScreen__Fv
    /* 3E434 8004DC34 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 3E438 8004DC38 1000BFAF */  sw         $ra, 0x10($sp)
    /* 3E43C 8004DC3C 529E000C */  jal        Front_InitialMemCardCheck__Fv
    /* 3E440 8004DC40 00000000 */   nop
    /* 3E444 8004DC44 1180023C */  lui        $v0, %hi(frontEnd)
    /* 3E448 8004DC48 00464424 */  addiu      $a0, $v0, %lo(frontEnd)
    /* 3E44C 8004DC4C 40038390 */  lbu        $v1, 0x340($a0)
    /* 3E450 8004DC50 FF000224 */  addiu      $v0, $zero, 0xFF
    /* 3E454 8004DC54 02006214 */  bne        $v1, $v0, .L8004DC60
    /* 3E458 8004DC58 00000000 */   nop
    /* 3E45C 8004DC5C 400380A0 */  sb         $zero, 0x340($a0)
  .L8004DC60:
    /* 3E460 8004DC60 1000BF8F */  lw         $ra, 0x10($sp)
    /* 3E464 8004DC64 00000000 */  nop
    /* 3E468 8004DC68 0800E003 */  jr         $ra
    /* 3E46C 8004DC6C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel DoLanguageScreen__Fv
