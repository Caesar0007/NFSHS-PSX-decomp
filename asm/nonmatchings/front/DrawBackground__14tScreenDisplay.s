.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawBackground__14tScreenDisplay, 0x8C

glabel DrawBackground__14tScreenDisplay
    /* 36150 80045950 0580023C */  lui        $v0, %hi(menuDefs)
    /* 36154 80045954 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 36158 80045958 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 3615C 8004595C 2800BFAF */  sw         $ra, 0x28($sp)
    /* 36160 80045960 2400B1AF */  sw         $s1, 0x24($sp)
    /* 36164 80045964 2000B0AF */  sw         $s0, 0x20($sp)
    /* 36168 80045968 DC2A428C */  lw         $v0, 0x2ADC($v0)
    /* 3616C 8004596C 00000000 */  nop
    /* 36170 80045970 43100200 */  sra        $v0, $v0, 1
    /* 36174 80045974 21184000 */  addu       $v1, $v0, $zero
    /* 36178 80045978 00140200 */  sll        $v0, $v0, 16
    /* 3617C 8004597C 03140200 */  sra        $v0, $v0, 16
    /* 36180 80045980 81004228 */  slti       $v0, $v0, 0x81
    /* 36184 80045984 02004014 */  bnez       $v0, .L80045990
    /* 36188 80045988 21800000 */   addu      $s0, $zero, $zero
    /* 3618C 8004598C 80000324 */  addiu      $v1, $zero, 0x80
  .L80045990:
    /* 36190 80045990 00140300 */  sll        $v0, $v1, 16
    /* 36194 80045994 038C0200 */  sra        $s1, $v0, 16
    /* 36198 80045998 0B000426 */  addiu      $a0, $s0, 0xB
  .L8004599C:
    /* 3619C 8004599C 21280000 */  addu       $a1, $zero, $zero
    /* 361A0 800459A0 2130A000 */  addu       $a2, $a1, $zero
    /* 361A4 800459A4 2138A000 */  addu       $a3, $a1, $zero
    /* 361A8 800459A8 1000B1AF */  sw         $s1, 0x10($sp)
    /* 361AC 800459AC 1400A0AF */  sw         $zero, 0x14($sp)
    /* 361B0 800459B0 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 361B4 800459B4 1800A0AF */   sw        $zero, 0x18($sp)
    /* 361B8 800459B8 01001026 */  addiu      $s0, $s0, 0x1
    /* 361BC 800459BC 2000022A */  slti       $v0, $s0, 0x20
    /* 361C0 800459C0 F6FF4014 */  bnez       $v0, .L8004599C
    /* 361C4 800459C4 0B000426 */   addiu     $a0, $s0, 0xB
    /* 361C8 800459C8 2800BF8F */  lw         $ra, 0x28($sp)
    /* 361CC 800459CC 2400B18F */  lw         $s1, 0x24($sp)
    /* 361D0 800459D0 2000B08F */  lw         $s0, 0x20($sp)
    /* 361D4 800459D4 0800E003 */  jr         $ra
    /* 361D8 800459D8 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel DrawBackground__14tScreenDisplay
