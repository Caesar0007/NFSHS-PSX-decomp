.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MemCardStop, 0x40

glabel MemCardStop
    /* EB348 800FAB48 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* EB34C 800FAB4C 1480033C */  lui        $v1, %hi(D_80147518)
    /* EB350 800FAB50 18756324 */  addiu      $v1, $v1, %lo(D_80147518)
    /* EB354 800FAB54 1000BFAF */  sw         $ra, 0x10($sp)
  .L800FAB58:
    /* EB358 800FAB58 0000628C */  lw         $v0, 0x0($v1)
    /* EB35C 800FAB5C 00000000 */  nop
    /* EB360 800FAB60 FDFF4014 */  bnez       $v0, .L800FAB58
    /* EB364 800FAB64 07000424 */   addiu     $a0, $zero, 0x7
    /* EB368 800FAB68 44CA030C */  jal        VSyncCallbacks
    /* EB36C 800FAB6C 21280000 */   addu      $a1, $zero, $zero
    /* EB370 800FAB70 0726040C */  jal        _card_stop
    /* EB374 800FAB74 00000000 */   nop
    /* EB378 800FAB78 1000BF8F */  lw         $ra, 0x10($sp)
    /* EB37C 800FAB7C 1800BD27 */  addiu      $sp, $sp, 0x18
    /* EB380 800FAB80 0800E003 */  jr         $ra
    /* EB384 800FAB84 00000000 */   nop
endlabel MemCardStop
