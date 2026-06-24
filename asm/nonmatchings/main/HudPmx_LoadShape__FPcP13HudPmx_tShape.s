.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching HudPmx_LoadShape__FPcP13HudPmx_tShape, 0x78

glabel HudPmx_LoadShape__FPcP13HudPmx_tShape
    /* 82C64 80092464 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 82C68 80092468 2400B1AF */  sw         $s1, 0x24($sp)
    /* 82C6C 8009246C 21888000 */  addu       $s1, $a0, $zero
    /* 82C70 80092470 2000B0AF */  sw         $s0, 0x20($sp)
    /* 82C74 80092474 2180A000 */  addu       $s0, $a1, $zero
    /* 82C78 80092478 5C18848F */  lw         $a0, %gp_rel(D_8013DDA8)($gp)
    /* 82C7C 8009247C 2800BFAF */  sw         $ra, 0x28($sp)
    /* 82C80 80092480 44AC030C */  jal        locateshape
    /* 82C84 80092484 21282002 */   addu      $a1, $s1, $zero
    /* 82C88 80092488 21282002 */  addu       $a1, $s1, $zero
    /* 82C8C 8009248C 04004394 */  lhu        $v1, 0x4($v0)
    /* 82C90 80092490 5C18848F */  lw         $a0, %gp_rel(D_8013DDA8)($gp)
    /* 82C94 80092494 60188793 */  lbu        $a3, %gp_rel(D_8013DDAC)($gp)
    /* 82C98 80092498 41000624 */  addiu      $a2, $zero, 0x41
    /* 82C9C 8009249C 100003A6 */  sh         $v1, 0x10($s0)
    /* 82CA0 800924A0 06004294 */  lhu        $v0, 0x6($v0)
    /* 82CA4 800924A4 8000E724 */  addiu      $a3, $a3, 0x80
    /* 82CA8 800924A8 120002A6 */  sh         $v0, 0x12($s0)
    /* 82CAC 800924AC 80000224 */  addiu      $v0, $zero, 0x80
    /* 82CB0 800924B0 1000A2AF */  sw         $v0, 0x10($sp)
    /* 82CB4 800924B4 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 82CB8 800924B8 1400A2AF */  sw         $v0, 0x14($sp)
    /* 82CBC 800924BC 1800A2AF */  sw         $v0, 0x18($sp)
    /* 82CC0 800924C0 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* 82CC4 800924C4 1C00B0AF */   sw        $s0, 0x1C($sp)
    /* 82CC8 800924C8 2800BF8F */  lw         $ra, 0x28($sp)
    /* 82CCC 800924CC 2400B18F */  lw         $s1, 0x24($sp)
    /* 82CD0 800924D0 2000B08F */  lw         $s0, 0x20($sp)
    /* 82CD4 800924D4 0800E003 */  jr         $ra
    /* 82CD8 800924D8 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel HudPmx_LoadShape__FPcP13HudPmx_tShape
