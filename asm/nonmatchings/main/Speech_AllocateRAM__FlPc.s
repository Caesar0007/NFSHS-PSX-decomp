.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Speech_AllocateRAM__FlPc, 0x2C

glabel Speech_AllocateRAM__FlPc
    /* 84AE8 800942E8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 84AEC 800942EC 21108000 */  addu       $v0, $a0, $zero
    /* 84AF0 800942F0 2120A000 */  addu       $a0, $a1, $zero
    /* 84AF4 800942F4 21284000 */  addu       $a1, $v0, $zero
    /* 84AF8 800942F8 1000BFAF */  sw         $ra, 0x10($sp)
    /* 84AFC 800942FC CF94030C */  jal        reservememadr
    /* 84B00 80094300 21300000 */   addu      $a2, $zero, $zero
    /* 84B04 80094304 1000BF8F */  lw         $ra, 0x10($sp)
    /* 84B08 80094308 00000000 */  nop
    /* 84B0C 8009430C 0800E003 */  jr         $ra
    /* 84B10 80094310 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Speech_AllocateRAM__FlPc
