.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDpitchbend, 0x60

glabel SNDpitchbend
    /* D81D0 800E79D0 1480023C */  lui        $v0, %hi(D_8014789C)
    /* D81D4 800E79D4 9C784280 */  lb         $v0, %lo(D_8014789C)($v0)
    /* D81D8 800E79D8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D81DC 800E79DC 1000B0AF */  sw         $s0, 0x10($sp)
    /* D81E0 800E79E0 21808000 */  addu       $s0, $a0, $zero
    /* D81E4 800E79E4 1400B1AF */  sw         $s1, 0x14($sp)
    /* D81E8 800E79E8 2188A000 */  addu       $s1, $a1, $zero
    /* D81EC 800E79EC 0A004010 */  beqz       $v0, .L800E7A18
    /* D81F0 800E79F0 1800BFAF */   sw        $ra, 0x18($sp)
    /* D81F4 800E79F4 4DA9030C */  jal        iSNDenteraudio
    /* D81F8 800E79F8 00000000 */   nop
    /* D81FC 800E79FC 21200002 */  addu       $a0, $s0, $zero
    /* D8200 800E7A00 3E9E030C */  jal        iSNDunsafebend
    /* D8204 800E7A04 21282002 */   addu      $a1, $s1, $zero
    /* D8208 800E7A08 5BA9030C */  jal        iSNDleaveaudio
    /* D820C 800E7A0C 21804000 */   addu      $s0, $v0, $zero
    /* D8210 800E7A10 879E0308 */  j          .L800E7A1C
    /* D8214 800E7A14 21100002 */   addu      $v0, $s0, $zero
  .L800E7A18:
    /* D8218 800E7A18 F6FF0224 */  addiu      $v0, $zero, -0xA
  .L800E7A1C:
    /* D821C 800E7A1C 1800BF8F */  lw         $ra, 0x18($sp)
    /* D8220 800E7A20 1400B18F */  lw         $s1, 0x14($sp)
    /* D8224 800E7A24 1000B08F */  lw         $s0, 0x10($sp)
    /* D8228 800E7A28 0800E003 */  jr         $ra
    /* D822C 800E7A2C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SNDpitchbend
