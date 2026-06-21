.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching play_movie__Fc, 0x20

glabel play_movie__Fc
    /* 3D6F4 8004CEF4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 3D6F8 8004CEF8 1000BFAF */  sw         $ra, 0x10($sp)
    /* 3D6FC 8004CEFC 3933010C */  jal        Movie_Play__Fc
    /* 3D700 8004CF00 FF008430 */   andi      $a0, $a0, 0xFF
    /* 3D704 8004CF04 1000BF8F */  lw         $ra, 0x10($sp)
    /* 3D708 8004CF08 00000000 */  nop
    /* 3D70C 8004CF0C 0800E003 */  jr         $ra
    /* 3D710 8004CF10 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel play_movie__Fc
