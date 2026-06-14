.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Clock_SystemCleanUp__Fv, 0x30

glabel Clock_SystemCleanUp__Fv
    /* 7C240 8008BA40 D402828F */  lw         $v0, %gp_rel(D_8013C820)($gp)
    /* 7C244 8008BA44 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 7C248 8008BA48 05004010 */  beqz       $v0, .L8008BA60
    /* 7C24C 8008BA4C 1000BFAF */   sw        $ra, 0x10($sp)
    /* 7C250 8008BA50 D40280AF */  sw         $zero, %gp_rel(D_8013C820)($gp)
    /* 7C254 8008BA54 0980043C */  lui        $a0, %hi(Clock_MasterInterruptHandler__Fv)
    /* 7C258 8008BA58 12AC030C */  jal        deltimer
    /* 7C25C 8008BA5C 38B98424 */   addiu     $a0, $a0, %lo(Clock_MasterInterruptHandler__Fv)
  .L8008BA60:
    /* 7C260 8008BA60 1000BF8F */  lw         $ra, 0x10($sp)
    /* 7C264 8008BA64 00000000 */  nop
    /* 7C268 8008BA68 0800E003 */  jr         $ra
    /* 7C26C 8008BA6C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Clock_SystemCleanUp__Fv
