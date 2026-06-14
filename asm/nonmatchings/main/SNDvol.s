.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDvol, 0x60

glabel SNDvol
    /* D7294 800E6A94 1480023C */  lui        $v0, %hi(D_8014789C)
    /* D7298 800E6A98 9C784280 */  lb         $v0, %lo(D_8014789C)($v0)
    /* D729C 800E6A9C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D72A0 800E6AA0 1000B0AF */  sw         $s0, 0x10($sp)
    /* D72A4 800E6AA4 21808000 */  addu       $s0, $a0, $zero
    /* D72A8 800E6AA8 1400B1AF */  sw         $s1, 0x14($sp)
    /* D72AC 800E6AAC 2188A000 */  addu       $s1, $a1, $zero
    /* D72B0 800E6AB0 0A004010 */  beqz       $v0, .L800E6ADC
    /* D72B4 800E6AB4 1800BFAF */   sw        $ra, 0x18($sp)
    /* D72B8 800E6AB8 4DA9030C */  jal        iSNDenteraudio
    /* D72BC 800E6ABC 00000000 */   nop
    /* D72C0 800E6AC0 21200002 */  addu       $a0, $s0, $zero
    /* D72C4 800E6AC4 749A030C */  jal        iSNDunsafevol
    /* D72C8 800E6AC8 21282002 */   addu      $a1, $s1, $zero
    /* D72CC 800E6ACC 5BA9030C */  jal        iSNDleaveaudio
    /* D72D0 800E6AD0 21804000 */   addu      $s0, $v0, $zero
    /* D72D4 800E6AD4 B89A0308 */  j          .L800E6AE0
    /* D72D8 800E6AD8 21100002 */   addu      $v0, $s0, $zero
  .L800E6ADC:
    /* D72DC 800E6ADC F6FF0224 */  addiu      $v0, $zero, -0xA
  .L800E6AE0:
    /* D72E0 800E6AE0 1800BF8F */  lw         $ra, 0x18($sp)
    /* D72E4 800E6AE4 1400B18F */  lw         $s1, 0x14($sp)
    /* D72E8 800E6AE8 1000B08F */  lw         $s0, 0x10($sp)
    /* D72EC 800E6AEC 0800E003 */  jr         $ra
    /* D72F0 800E6AF0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SNDvol
