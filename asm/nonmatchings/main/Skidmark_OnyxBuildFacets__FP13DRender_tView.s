.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Skidmark_OnyxBuildFacets__FP13DRender_tView, 0xA0

glabel Skidmark_OnyxBuildFacets__FP13DRender_tView
    /* CFC64 800DF464 B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* CFC68 800DF468 21188000 */  addu       $v1, $a0, $zero
    /* CFC6C 800DF46C 8015828F */  lw         $v0, %gp_rel(gCountSm)($gp)
    /* CFC70 800DF470 7C15858F */  lw         $a1, %gp_rel(gSm)($gp)
    /* CFC74 800DF474 1000A427 */  addiu      $a0, $sp, 0x10
    /* CFC78 800DF478 4800BFAF */  sw         $ra, 0x48($sp)
    /* CFC7C 800DF47C 0800678C */  lw         $a3, 0x8($v1)
    /* CFC80 800DF480 0C00688C */  lw         $t0, 0xC($v1)
    /* CFC84 800DF484 1000698C */  lw         $t1, 0x10($v1)
    /* CFC88 800DF488 3400A7AF */  sw         $a3, 0x34($sp)
    /* CFC8C 800DF48C 3800A8AF */  sw         $t0, 0x38($sp)
    /* CFC90 800DF490 3C00A9AF */  sw         $t1, 0x3C($sp)
    /* CFC94 800DF494 300082AC */  sw         $v0, 0x30($a0)
    /* CFC98 800DF498 340085AC */  sw         $a1, 0x34($a0)
    /* CFC9C 800DF49C 4400658C */  lw         $a1, 0x44($v1)
    /* CFCA0 800DF4A0 4800628C */  lw         $v0, 0x48($v1)
    /* CFCA4 800DF4A4 4C00668C */  lw         $a2, 0x4C($v1)
    /* CFCA8 800DF4A8 23100200 */  negu       $v0, $v0
    /* CFCAC 800DF4AC 1000A5AF */  sw         $a1, 0x10($sp)
    /* CFCB0 800DF4B0 040082AC */  sw         $v0, 0x4($a0)
    /* CFCB4 800DF4B4 080086AC */  sw         $a2, 0x8($a0)
    /* CFCB8 800DF4B8 5000658C */  lw         $a1, 0x50($v1)
    /* CFCBC 800DF4BC 5400628C */  lw         $v0, 0x54($v1)
    /* CFCC0 800DF4C0 5800668C */  lw         $a2, 0x58($v1)
    /* CFCC4 800DF4C4 23100200 */  negu       $v0, $v0
    /* CFCC8 800DF4C8 0C0085AC */  sw         $a1, 0xC($a0)
    /* CFCCC 800DF4CC 100082AC */  sw         $v0, 0x10($a0)
    /* CFCD0 800DF4D0 140086AC */  sw         $a2, 0x14($a0)
    /* CFCD4 800DF4D4 5C00658C */  lw         $a1, 0x5C($v1)
    /* CFCD8 800DF4D8 6000628C */  lw         $v0, 0x60($v1)
    /* CFCDC 800DF4DC 6400668C */  lw         $a2, 0x64($v1)
    /* CFCE0 800DF4E0 23100200 */  negu       $v0, $v0
    /* CFCE4 800DF4E4 180085AC */  sw         $a1, 0x18($a0)
    /* CFCE8 800DF4E8 1C0082AC */  sw         $v0, 0x1C($a0)
    /* CFCEC 800DF4EC 2724030C */  jal        Draw_kCtrlSkidmark__FP18Draw_tCtrlSkidmark
    /* CFCF0 800DF4F0 200086AC */   sw        $a2, 0x20($a0)
    /* CFCF4 800DF4F4 4800BF8F */  lw         $ra, 0x48($sp)
    /* CFCF8 800DF4F8 00000000 */  nop
    /* CFCFC 800DF4FC 0800E003 */  jr         $ra
    /* CFD00 800DF500 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel Skidmark_OnyxBuildFacets__FP13DRender_tView
