.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDleaveaudio, 0x84

glabel iSNDleaveaudio
    /* DAD6C 800EA56C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DAD70 800EA570 1480023C */  lui        $v0, %hi(sndgs)
    /* DAD74 800EA574 1000B0AF */  sw         $s0, 0x10($sp)
    /* DAD78 800EA578 60785024 */  addiu      $s0, $v0, %lo(sndgs)
    /* DAD7C 800EA57C 1400BFAF */  sw         $ra, 0x14($sp)
    /* DAD80 800EA580 3F000292 */  lbu        $v0, 0x3F($s0)
    /* DAD84 800EA584 00000000 */  nop
    /* DAD88 800EA588 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* DAD8C 800EA58C 3F0002A2 */  sb         $v0, 0x3F($s0)
    /* DAD90 800EA590 8100040C */  jal        SNDI_mutexunlock
    /* DAD94 800EA594 00000000 */   nop
    /* DAD98 800EA598 3F000292 */  lbu        $v0, 0x3F($s0)
    /* DAD9C 800EA59C 00000000 */  nop
    /* DADA0 800EA5A0 0F004014 */  bnez       $v0, .L800EA5E0
    /* DADA4 800EA5A4 00000000 */   nop
    /* DADA8 800EA5A8 B2000296 */  lhu        $v0, 0xB2($s0)
    /* DADAC 800EA5AC 00000000 */  nop
    /* DADB0 800EA5B0 0B004010 */  beqz       $v0, .L800EA5E0
    /* DADB4 800EA5B4 00000000 */   nop
  .L800EA5B8:
    /* DADB8 800EA5B8 B2000296 */  lhu        $v0, 0xB2($s0)
    /* DADBC 800EA5BC 00000000 */  nop
    /* DADC0 800EA5C0 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* DADC4 800EA5C4 B20002A6 */  sh         $v0, 0xB2($s0)
    /* DADC8 800EA5C8 4EA8030C */  jal        iSNDserver
    /* DADCC 800EA5CC 00000000 */   nop
    /* DADD0 800EA5D0 B2000296 */  lhu        $v0, 0xB2($s0)
    /* DADD4 800EA5D4 00000000 */  nop
    /* DADD8 800EA5D8 F7FF4014 */  bnez       $v0, .L800EA5B8
    /* DADDC 800EA5DC 00000000 */   nop
  .L800EA5E0:
    /* DADE0 800EA5E0 1400BF8F */  lw         $ra, 0x14($sp)
    /* DADE4 800EA5E4 1000B08F */  lw         $s0, 0x10($sp)
    /* DADE8 800EA5E8 0800E003 */  jr         $ra
    /* DADEC 800EA5EC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iSNDleaveaudio
