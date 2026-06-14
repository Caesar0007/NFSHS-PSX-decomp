.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Texture_AddSharedPalette__FPcP12Draw_tPixMapi, 0x78

glabel Texture_AddSharedPalette__FPcP12Draw_tPixMapi
    /* CFFBC 800DF7BC 21388000 */  addu       $a3, $a0, $zero
    /* CFFC0 800DF7C0 0D00C014 */  bnez       $a2, .L800DF7F8
    /* CFFC4 800DF7C4 2140A000 */   addu      $t0, $a1, $zero
    /* CFFC8 800DF7C8 C815848F */  lw         $a0, %gp_rel(Texture_gNum4bitPal)($gp)
    /* CFFCC 800DF7CC D815828F */  lw         $v0, %gp_rel(Texture_gPalette4bit)($gp)
    /* CFFD0 800DF7D0 D015858F */  lw         $a1, %gp_rel(Texture_gP4bitPmx)($gp)
    /* CFFD4 800DF7D4 80180400 */  sll        $v1, $a0, 2
    /* CFFD8 800DF7D8 21106200 */  addu       $v0, $v1, $v0
    /* CFFDC 800DF7DC 21186500 */  addu       $v1, $v1, $a1
    /* CFFE0 800DF7E0 01008424 */  addiu      $a0, $a0, 0x1
    /* CFFE4 800DF7E4 000047AC */  sw         $a3, 0x0($v0)
    /* CFFE8 800DF7E8 000068AC */  sw         $t0, 0x0($v1)
    /* CFFEC 800DF7EC C81584AF */  sw         $a0, %gp_rel(Texture_gNum4bitPal)($gp)
    /* CFFF0 800DF7F0 0800E003 */  jr         $ra
    /* CFFF4 800DF7F4 00000000 */   nop
  .L800DF7F8:
    /* CFFF8 800DF7F8 01000224 */  addiu      $v0, $zero, 0x1
    /* CFFFC 800DF7FC 0B00C214 */  bne        $a2, $v0, .L800DF82C
    /* D0000 800DF800 00000000 */   nop
    /* D0004 800DF804 CC15848F */  lw         $a0, %gp_rel(Texture_gNum8bitPal)($gp)
    /* D0008 800DF808 DC15828F */  lw         $v0, %gp_rel(Texture_gPalette8bit)($gp)
    /* D000C 800DF80C D415858F */  lw         $a1, %gp_rel(Texture_gP8bitPmx)($gp)
    /* D0010 800DF810 80180400 */  sll        $v1, $a0, 2
    /* D0014 800DF814 21106200 */  addu       $v0, $v1, $v0
    /* D0018 800DF818 21186500 */  addu       $v1, $v1, $a1
    /* D001C 800DF81C 01008424 */  addiu      $a0, $a0, 0x1
    /* D0020 800DF820 000047AC */  sw         $a3, 0x0($v0)
    /* D0024 800DF824 000068AC */  sw         $t0, 0x0($v1)
    /* D0028 800DF828 CC1584AF */  sw         $a0, %gp_rel(Texture_gNum8bitPal)($gp)
  .L800DF82C:
    /* D002C 800DF82C 0800E003 */  jr         $ra
    /* D0030 800DF830 00000000 */   nop
endlabel Texture_AddSharedPalette__FPcP12Draw_tPixMapi
