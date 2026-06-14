.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw_DrawDirectScreen__FP8shapetblii, 0x28

glabel Draw_DrawDirectScreen__FP8shapetblii
    /* AEC50 800BE450 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* AEC54 800BE454 0001C624 */  addiu      $a2, $a2, 0x100
    /* AEC58 800BE458 21380000 */  addu       $a3, $zero, $zero
    /* AEC5C 800BE45C 1800BFAF */  sw         $ra, 0x18($sp)
    /* AEC60 800BE460 4E7F030C */  jal        Texture_Vramcf__FP8shapetbliiii
    /* AEC64 800BE464 1000A0AF */   sw        $zero, 0x10($sp)
    /* AEC68 800BE468 1800BF8F */  lw         $ra, 0x18($sp)
    /* AEC6C 800BE46C 00000000 */  nop
    /* AEC70 800BE470 0800E003 */  jr         $ra
    /* AEC74 800BE474 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Draw_DrawDirectScreen__FP8shapetblii
