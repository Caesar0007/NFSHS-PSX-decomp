.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDover, 0x50

glabel SNDover
    /* D8314 800E7B14 1480023C */  lui        $v0, %hi(D_8014789C)
    /* D8318 800E7B18 9C784280 */  lb         $v0, %lo(D_8014789C)($v0)
    /* D831C 800E7B1C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D8320 800E7B20 1000B0AF */  sw         $s0, 0x10($sp)
    /* D8324 800E7B24 21808000 */  addu       $s0, $a0, $zero
    /* D8328 800E7B28 03004014 */  bnez       $v0, .L800E7B38
    /* D832C 800E7B2C 1400BFAF */   sw        $ra, 0x14($sp)
    /* D8330 800E7B30 D59E0308 */  j          .L800E7B54
    /* D8334 800E7B34 F6FF0224 */   addiu     $v0, $zero, -0xA
  .L800E7B38:
    /* D8338 800E7B38 4DA9030C */  jal        iSNDenteraudio
    /* D833C 800E7B3C 00000000 */   nop
    /* D8340 800E7B40 71FB030C */  jal        iSNDgetchan
    /* D8344 800E7B44 21200002 */   addu      $a0, $s0, $zero
    /* D8348 800E7B48 5BA9030C */  jal        iSNDleaveaudio
    /* D834C 800E7B4C C2870200 */   srl       $s0, $v0, 31
    /* D8350 800E7B50 21100002 */  addu       $v0, $s0, $zero
  .L800E7B54:
    /* D8354 800E7B54 1400BF8F */  lw         $ra, 0x14($sp)
    /* D8358 800E7B58 1000B08F */  lw         $s0, 0x10($sp)
    /* D835C 800E7B5C 0800E003 */  jr         $ra
    /* D8360 800E7B60 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SNDover
