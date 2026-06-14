.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_RemoveAsyncSfx__Fi, 0x88

glabel AudioCmn_RemoveAsyncSfx__Fi
    /* 66DB4 800765B4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 66DB8 800765B8 40100400 */  sll        $v0, $a0, 1
    /* 66DBC 800765BC 21104400 */  addu       $v0, $v0, $a0
    /* 66DC0 800765C0 C0100200 */  sll        $v0, $v0, 3
    /* 66DC4 800765C4 1180033C */  lui        $v1, %hi(AudioCmn_gSfxSlot)
    /* 66DC8 800765C8 34EB6324 */  addiu      $v1, $v1, %lo(AudioCmn_gSfxSlot)
    /* 66DCC 800765CC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 66DD0 800765D0 21804300 */  addu       $s0, $v0, $v1
    /* 66DD4 800765D4 1800BFAF */  sw         $ra, 0x18($sp)
    /* 66DD8 800765D8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 66DDC 800765DC 0400028E */  lw         $v0, 0x4($s0)
    /* 66DE0 800765E0 FFFF1124 */  addiu      $s1, $zero, -0x1
    /* 66DE4 800765E4 10005110 */  beq        $v0, $s1, .L80076628
    /* 66DE8 800765E8 00000000 */   nop
    /* 66DEC 800765EC 0800048E */  lw         $a0, 0x8($s0)
    /* 66DF0 800765F0 00000000 */  nop
    /* 66DF4 800765F4 0B009110 */  beq        $a0, $s1, .L80076624
    /* 66DF8 800765F8 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 66DFC 800765FC 9D99030C */  jal        SNDbankremove
    /* 66E00 80076600 00000000 */   nop
    /* 66E04 80076604 1400048E */  lw         $a0, 0x14($s0)
    /* 66E08 80076608 00000000 */  nop
    /* 66E0C 8007660C 04008010 */  beqz       $a0, .L80076620
    /* 66E10 80076610 080011AE */   sw        $s1, 0x8($s0)
    /* 66E14 80076614 5095030C */  jal        purgememadr
    /* 66E18 80076618 00000000 */   nop
    /* 66E1C 8007661C 140000AE */  sw         $zero, 0x14($s0)
  .L80076620:
    /* 66E20 80076620 FFFF0224 */  addiu      $v0, $zero, -0x1
  .L80076624:
    /* 66E24 80076624 040002AE */  sw         $v0, 0x4($s0)
  .L80076628:
    /* 66E28 80076628 1800BF8F */  lw         $ra, 0x18($sp)
    /* 66E2C 8007662C 1400B18F */  lw         $s1, 0x14($sp)
    /* 66E30 80076630 1000B08F */  lw         $s0, 0x10($sp)
    /* 66E34 80076634 0800E003 */  jr         $ra
    /* 66E38 80076638 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AudioCmn_RemoveAsyncSfx__Fi
