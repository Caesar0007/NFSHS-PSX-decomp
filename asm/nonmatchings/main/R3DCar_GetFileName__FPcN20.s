.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching R3DCar_GetFileName__FPcN20, 0x5C

glabel R3DCar_GetFileName__FPcN20
    /* 9F5F4 800AEDF4 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 9F5F8 800AEDF8 2400B1AF */  sw         $s1, 0x24($sp)
    /* 9F5FC 800AEDFC 21888000 */  addu       $s1, $a0, $zero
    /* 9F600 800AEE00 1000A427 */  addiu      $a0, $sp, 0x10
    /* 9F604 800AEE04 2000B0AF */  sw         $s0, 0x20($sp)
    /* 9F608 800AEE08 2800BFAF */  sw         $ra, 0x28($sp)
    /* 9F60C 800AEE0C CA96030C */  jal        strcpy
    /* 9F610 800AEE10 2180C000 */   addu      $s0, $a2, $zero
    /* 9F614 800AEE14 1000A427 */  addiu      $a0, $sp, 0x10
    /* 9F618 800AEE18 3A9E030C */  jal        strcat
    /* 9F61C 800AEE1C 21280002 */   addu      $a1, $s0, $zero
    /* 9F620 800AEE20 21202002 */  addu       $a0, $s1, $zero
    /* 9F624 800AEE24 CA96030C */  jal        strcpy
    /* 9F628 800AEE28 1000A527 */   addiu     $a1, $sp, 0x10
    /* 9F62C 800AEE2C 21202002 */  addu       $a0, $s1, $zero
    /* 9F630 800AEE30 1480053C */  lui        $a1, %hi(D_8013D340)
    /* 9F634 800AEE34 3A9E030C */  jal        strcat
    /* 9F638 800AEE38 40D3A524 */   addiu     $a1, $a1, %lo(D_8013D340)
    /* 9F63C 800AEE3C 2800BF8F */  lw         $ra, 0x28($sp)
    /* 9F640 800AEE40 2400B18F */  lw         $s1, 0x24($sp)
    /* 9F644 800AEE44 2000B08F */  lw         $s0, 0x20($sp)
    /* 9F648 800AEE48 0800E003 */  jr         $ra
    /* 9F64C 800AEE4C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel R3DCar_GetFileName__FPcN20
