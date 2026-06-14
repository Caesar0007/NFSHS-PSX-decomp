.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Weather_DeInit__Fv, 0x94

glabel Weather_DeInit__Fv
    /* D307C 800E287C 1180023C */  lui        $v0, %hi(D_80113234)
    /* D3080 800E2880 3432428C */  lw         $v0, %lo(D_80113234)($v0)
    /* D3084 800E2884 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D3088 800E2888 1D004010 */  beqz       $v0, .L800E2900
    /* D308C 800E288C 1000BFAF */   sw        $ra, 0x10($sp)
    /* D3090 800E2890 6016848F */  lw         $a0, %gp_rel(Weather_gSplatInfo)($gp)
    /* D3094 800E2894 00000000 */  nop
    /* D3098 800E2898 03008010 */  beqz       $a0, .L800E28A8
    /* D309C 800E289C 00000000 */   nop
    /* D30A0 800E28A0 5095030C */  jal        purgememadr
    /* D30A4 800E28A4 00000000 */   nop
  .L800E28A8:
    /* D30A8 800E28A8 5C16848F */  lw         $a0, %gp_rel(Weather_gPos)($gp)
    /* D30AC 800E28AC 00000000 */  nop
    /* D30B0 800E28B0 03008010 */  beqz       $a0, .L800E28C0
    /* D30B4 800E28B4 00000000 */   nop
    /* D30B8 800E28B8 5095030C */  jal        purgememadr
    /* D30BC 800E28BC 00000000 */   nop
  .L800E28C0:
    /* D30C0 800E28C0 6416848F */  lw         $a0, %gp_rel(Weather_gPrevPos)($gp)
    /* D30C4 800E28C4 00000000 */  nop
    /* D30C8 800E28C8 03008010 */  beqz       $a0, .L800E28D8
    /* D30CC 800E28CC 00000000 */   nop
    /* D30D0 800E28D0 5095030C */  jal        purgememadr
    /* D30D4 800E28D4 00000000 */   nop
  .L800E28D8:
    /* D30D8 800E28D8 5816848F */  lw         $a0, %gp_rel(Weather_gWasDrawn)($gp)
    /* D30DC 800E28DC 00000000 */  nop
    /* D30E0 800E28E0 03008010 */  beqz       $a0, .L800E28F0
    /* D30E4 800E28E4 00000000 */   nop
    /* D30E8 800E28E8 5095030C */  jal        purgememadr
    /* D30EC 800E28EC 00000000 */   nop
  .L800E28F0:
    /* D30F0 800E28F0 601680AF */  sw         $zero, %gp_rel(Weather_gSplatInfo)($gp)
    /* D30F4 800E28F4 5C1680AF */  sw         $zero, %gp_rel(Weather_gPos)($gp)
    /* D30F8 800E28F8 641680AF */  sw         $zero, %gp_rel(Weather_gPrevPos)($gp)
    /* D30FC 800E28FC 581680AF */  sw         $zero, %gp_rel(Weather_gWasDrawn)($gp)
  .L800E2900:
    /* D3100 800E2900 1000BF8F */  lw         $ra, 0x10($sp)
    /* D3104 800E2904 00000000 */  nop
    /* D3108 800E2908 0800E003 */  jr         $ra
    /* D310C 800E290C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Weather_DeInit__Fv
