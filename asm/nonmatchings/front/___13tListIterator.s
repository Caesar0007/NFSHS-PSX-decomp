.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___13tListIterator, 0x34

glabel ___13tListIterator
    /* 145F4 80023DF4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 145F8 80023DF8 0180023C */  lui        $v0, %hi(_vt_13tListIterator)
    /* 145FC 80023DFC C8134224 */  addiu      $v0, $v0, %lo(_vt_13tListIterator)
    /* 14600 80023E00 0100A530 */  andi       $a1, $a1, 0x1
    /* 14604 80023E04 1000BFAF */  sw         $ra, 0x10($sp)
    /* 14608 80023E08 0300A010 */  beqz       $a1, .L80023E18
    /* 1460C 80023E0C 0C0082AC */   sw        $v0, 0xC($a0)
    /* 14610 80023E10 6B8F020C */  jal        __builtin_delete
    /* 14614 80023E14 00000000 */   nop
  .L80023E18:
    /* 14618 80023E18 1000BF8F */  lw         $ra, 0x10($sp)
    /* 1461C 80023E1C 00000000 */  nop
    /* 14620 80023E20 0800E003 */  jr         $ra
    /* 14624 80023E24 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___13tListIterator
