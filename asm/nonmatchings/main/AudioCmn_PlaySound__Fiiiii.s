.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_PlaySound__Fiiiii, 0x2C

glabel AudioCmn_PlaySound__Fiiiii
    /* 68BA0 800783A0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 68BA4 800783A4 3000A38F */  lw         $v1, 0x30($sp)
    /* 68BA8 800783A8 0100023C */  lui        $v0, (0x10000 >> 16)
    /* 68BAC 800783AC 1800BFAF */  sw         $ra, 0x18($sp)
    /* 68BB0 800783B0 1400A2AF */  sw         $v0, 0x14($sp)
    /* 68BB4 800783B4 50E0010C */  jal        AudioCmn_PlayDoppleredSound__Fiiiiii
    /* 68BB8 800783B8 1000A3AF */   sw        $v1, 0x10($sp)
    /* 68BBC 800783BC 1800BF8F */  lw         $ra, 0x18($sp)
    /* 68BC0 800783C0 00000000 */  nop
    /* 68BC4 800783C4 0800E003 */  jr         $ra
    /* 68BC8 800783C8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AudioCmn_PlaySound__Fiiiii
