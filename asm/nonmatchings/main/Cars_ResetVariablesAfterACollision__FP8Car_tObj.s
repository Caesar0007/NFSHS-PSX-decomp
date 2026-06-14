.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cars_ResetVariablesAfterACollision__FP8Car_tObj, 0x68

glabel Cars_ResetVariablesAfterACollision__FP8Car_tObj
    /* 76DFC 800865FC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 76E00 80086600 1000BFAF */  sw         $ra, 0x10($sp)
    /* 76E04 80086604 140180AC */  sw         $zero, 0x114($a0)
    /* 76E08 80086608 180180AC */  sw         $zero, 0x118($a0)
    /* 76E0C 8008660C 1C0180AC */  sw         $zero, 0x11C($a0)
    /* 76E10 80086610 240480AC */  sw         $zero, 0x424($a0)
    /* 76E14 80086614 280480AC */  sw         $zero, 0x428($a0)
    /* 76E18 80086618 2C0480AC */  sw         $zero, 0x42C($a0)
    /* 76E1C 8008661C 0C0480AC */  sw         $zero, 0x40C($a0)
    /* 76E20 80086620 100480AC */  sw         $zero, 0x410($a0)
    /* 76E24 80086624 140480AC */  sw         $zero, 0x414($a0)
    /* 76E28 80086628 7C0180A4 */  sh         $zero, 0x17C($a0)
    /* 76E2C 8008662C 8C0180AC */  sw         $zero, 0x18C($a0)
    /* 76E30 80086630 AC0180AC */  sw         $zero, 0x1AC($a0)
    /* 76E34 80086634 900180AC */  sw         $zero, 0x190($a0)
    /* 76E38 80086638 940180AC */  sw         $zero, 0x194($a0)
    /* 76E3C 8008663C 9C0180AC */  sw         $zero, 0x19C($a0)
    /* 76E40 80086640 840180AC */  sw         $zero, 0x184($a0)
    /* 76E44 80086644 C00080AC */  sw         $zero, 0xC0($a0)
    /* 76E48 80086648 8C0780AC */  sw         $zero, 0x78C($a0)
    /* 76E4C 8008664C 8FA9020C */  jal        Physics_ResetCar__FP8Car_tObj
    /* 76E50 80086650 740180AC */   sw        $zero, 0x174($a0)
    /* 76E54 80086654 1000BF8F */  lw         $ra, 0x10($sp)
    /* 76E58 80086658 00000000 */  nop
    /* 76E5C 8008665C 0800E003 */  jr         $ra
    /* 76E60 80086660 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Cars_ResetVariablesAfterACollision__FP8Car_tObj
