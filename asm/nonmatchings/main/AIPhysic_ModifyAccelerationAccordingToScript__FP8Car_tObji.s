.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_ModifyAccelerationAccordingToScript__FP8Car_tObji, 0x58

glabel AIPhysic_ModifyAccelerationAccordingToScript__FP8Car_tObji
    /* 5A190 80069990 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5A194 80069994 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5A198 80069998 2180A000 */  addu       $s0, $a1, $zero
    /* 5A19C 8006999C F4048424 */  addiu      $a0, $a0, 0x4F4
    /* 5A1A0 800699A0 1400BFAF */  sw         $ra, 0x14($sp)
    /* 5A1A4 800699A4 56BE010C */  jal        AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction
    /* 5A1A8 800699A8 04000524 */   addiu     $a1, $zero, 0x4
    /* 5A1AC 800699AC FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 5A1B0 800699B0 09004310 */  beq        $v0, $v1, .L800699D8
    /* 5A1B4 800699B4 21100002 */   addu      $v0, $s0, $zero
    /* 5A1B8 800699B8 02000106 */  bgez       $s0, .L800699C4
    /* 5A1BC 800699BC 21180002 */   addu      $v1, $s0, $zero
    /* 5A1C0 800699C0 FF000326 */  addiu      $v1, $s0, 0xFF
  .L800699C4:
    /* 5A1C4 800699C4 031A0300 */  sra        $v1, $v1, 8
    /* 5A1C8 800699C8 40100300 */  sll        $v0, $v1, 1
    /* 5A1CC 800699CC 21104300 */  addu       $v0, $v0, $v1
    /* 5A1D0 800699D0 C0810200 */  sll        $s0, $v0, 7
    /* 5A1D4 800699D4 21100002 */  addu       $v0, $s0, $zero
  .L800699D8:
    /* 5A1D8 800699D8 1400BF8F */  lw         $ra, 0x14($sp)
    /* 5A1DC 800699DC 1000B08F */  lw         $s0, 0x10($sp)
    /* 5A1E0 800699E0 0800E003 */  jr         $ra
    /* 5A1E4 800699E4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AIPhysic_ModifyAccelerationAccordingToScript__FP8Car_tObji
