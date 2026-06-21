.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching decbufferusage, 0x8C

glabel decbufferusage
    /* ECB74 800FC374 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* ECB78 800FC378 21308000 */  addu       $a2, $a0, $zero
    /* ECB7C 800FC37C 1000BFAF */  sw         $ra, 0x10($sp)
    /* ECB80 800FC380 00600340 */  mfc0       $v1, $12 /* handwritten instruction */
    /* ECB84 800FC384 00000000 */  nop
    /* ECB88 800FC388 FEFB0124 */  addiu      $at, $zero, -0x402
    /* ECB8C 800FC38C 24406100 */  and        $t0, $v1, $at
    /* ECB90 800FC390 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* ECB94 800FC394 00000000 */  nop
    /* ECB98 800FC398 00000000 */  nop
    /* ECB9C 800FC39C 00000000 */  nop
    /* ECBA0 800FC3A0 3C00C28C */  lw         $v0, 0x3C($a2)
    /* ECBA4 800FC3A4 00000000 */  nop
    /* ECBA8 800FC3A8 23204500 */  subu       $a0, $v0, $a1
    /* ECBAC 800FC3AC 3C00C4AC */  sw         $a0, 0x3C($a2)
    /* ECBB0 800FC3B0 00608340 */  mtc0       $v1, $12 /* handwritten instruction */
    /* ECBB4 800FC3B4 3400C38C */  lw         $v1, 0x34($a2)
    /* ECBB8 800FC3B8 00000000 */  nop
    /* ECBBC 800FC3BC 2A104300 */  slt        $v0, $v0, $v1
    /* ECBC0 800FC3C0 0B004014 */  bnez       $v0, .L800FC3F0
    /* ECBC4 800FC3C4 2A108300 */   slt       $v0, $a0, $v1
    /* ECBC8 800FC3C8 09004010 */  beqz       $v0, .L800FC3F0
    /* ECBCC 800FC3CC 01000224 */   addiu     $v0, $zero, 0x1
    /* ECBD0 800FC3D0 2800C38C */  lw         $v1, 0x28($a2)
    /* ECBD4 800FC3D4 00000000 */  nop
    /* ECBD8 800FC3D8 05006214 */  bne        $v1, $v0, .L800FC3F0
    /* ECBDC 800FC3DC 3800C2AC */   sw        $v0, 0x38($a2)
    /* ECBE0 800FC3E0 A400C48C */  lw         $a0, 0xA4($a2)
    /* ECBE4 800FC3E4 3000C58C */  lw         $a1, 0x30($a2)
    /* ECBE8 800FC3E8 B3AF030C */  jal        FILE_priorityop
    /* ECBEC 800FC3EC 00000000 */   nop
  .L800FC3F0:
    /* ECBF0 800FC3F0 1000BF8F */  lw         $ra, 0x10($sp)
    /* ECBF4 800FC3F4 00000000 */  nop
    /* ECBF8 800FC3F8 0800E003 */  jr         $ra
    /* ECBFC 800FC3FC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel decbufferusage
