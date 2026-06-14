.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Texture_MenuReleaseClutId__Fs, 0x60

glabel Texture_MenuReleaseClutId__Fs
    /* D01A4 800DF9A4 21288000 */  addu       $a1, $a0, $zero
    /* D01A8 800DF9A8 00140500 */  sll        $v0, $a1, 16
    /* D01AC 800DF9AC 83150200 */  sra        $v0, $v0, 22
    /* D01B0 800DF9B0 E8014228 */  slti       $v0, $v0, 0x1E8
    /* D01B4 800DF9B4 0A004010 */  beqz       $v0, .L800DF9E0
    /* D01B8 800DF9B8 00000000 */   nop
    /* D01BC 800DF9BC EC15828F */  lw         $v0, %gp_rel(gNbFreePal8)($gp)
    /* D01C0 800DF9C0 E815848F */  lw         $a0, %gp_rel(gFreePal8)($gp)
    /* D01C4 800DF9C4 40180200 */  sll        $v1, $v0, 1
    /* D01C8 800DF9C8 01004224 */  addiu      $v0, $v0, 0x1
    /* D01CC 800DF9CC 21186400 */  addu       $v1, $v1, $a0
    /* D01D0 800DF9D0 000065A4 */  sh         $a1, 0x0($v1)
    /* D01D4 800DF9D4 EC1582AF */  sw         $v0, %gp_rel(gNbFreePal8)($gp)
    /* D01D8 800DF9D8 0800E003 */  jr         $ra
    /* D01DC 800DF9DC 00000000 */   nop
  .L800DF9E0:
    /* D01E0 800DF9E0 E415828F */  lw         $v0, %gp_rel(gNbFreePal4)($gp)
    /* D01E4 800DF9E4 E015848F */  lw         $a0, %gp_rel(gFreePal4)($gp)
    /* D01E8 800DF9E8 40180200 */  sll        $v1, $v0, 1
    /* D01EC 800DF9EC 01004224 */  addiu      $v0, $v0, 0x1
    /* D01F0 800DF9F0 21186400 */  addu       $v1, $v1, $a0
    /* D01F4 800DF9F4 000065A4 */  sh         $a1, 0x0($v1)
    /* D01F8 800DF9F8 E41582AF */  sw         $v0, %gp_rel(gNbFreePal4)($gp)
    /* D01FC 800DF9FC 0800E003 */  jr         $ra
    /* D0200 800DFA00 00000000 */   nop
endlabel Texture_MenuReleaseClutId__Fs
