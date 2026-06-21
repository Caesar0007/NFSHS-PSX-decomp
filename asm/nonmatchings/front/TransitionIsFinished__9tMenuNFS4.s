.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionIsFinished__9tMenuNFS4, 0xA0

glabel TransitionIsFinished__9tMenuNFS4
    /* BB60 8001B360 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* BB64 8001B364 1800B2AF */  sw         $s2, 0x18($sp)
    /* BB68 8001B368 21908000 */  addu       $s2, $a0, $zero
    /* BB6C 8001B36C 1000B0AF */  sw         $s0, 0x10($sp)
    /* BB70 8001B370 01001024 */  addiu      $s0, $zero, 0x1
    /* BB74 8001B374 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* BB78 8001B378 1400B1AF */  sw         $s1, 0x14($sp)
    /* BB7C 8001B37C 1000428E */  lw         $v0, 0x10($s2)
    /* BB80 8001B380 00000000 */  nop
    /* BB84 8001B384 17004010 */  beqz       $v0, .L8001B3E4
    /* BB88 8001B388 21880000 */   addu      $s1, $zero, $zero
  .L8001B38C:
    /* BB8C 8001B38C 00141100 */  sll        $v0, $s1, 16
    /* BB90 8001B390 83130200 */  sra        $v0, $v0, 14
    /* BB94 8001B394 21104202 */  addu       $v0, $s2, $v0
    /* BB98 8001B398 1000438C */  lw         $v1, 0x10($v0)
    /* BB9C 8001B39C 00000000 */  nop
    /* BBA0 8001B3A0 1800628C */  lw         $v0, 0x18($v1)
    /* BBA4 8001B3A4 00000000 */  nop
    /* BBA8 8001B3A8 48004484 */  lh         $a0, 0x48($v0)
    /* BBAC 8001B3AC 4C00428C */  lw         $v0, 0x4C($v0)
    /* BBB0 8001B3B0 00000000 */  nop
    /* BBB4 8001B3B4 09F84000 */  jalr       $v0
    /* BBB8 8001B3B8 21206400 */   addu      $a0, $v1, $a0
    /* BBBC 8001B3BC 24800202 */  and        $s0, $s0, $v0
    /* BBC0 8001B3C0 2B801000 */  sltu       $s0, $zero, $s0
    /* BBC4 8001B3C4 01002326 */  addiu      $v1, $s1, 0x1
    /* BBC8 8001B3C8 00140300 */  sll        $v0, $v1, 16
    /* BBCC 8001B3CC 83130200 */  sra        $v0, $v0, 14
    /* BBD0 8001B3D0 21104202 */  addu       $v0, $s2, $v0
    /* BBD4 8001B3D4 1000428C */  lw         $v0, 0x10($v0)
    /* BBD8 8001B3D8 00000000 */  nop
    /* BBDC 8001B3DC EBFF4014 */  bnez       $v0, .L8001B38C
    /* BBE0 8001B3E0 21886000 */   addu      $s1, $v1, $zero
  .L8001B3E4:
    /* BBE4 8001B3E4 21100002 */  addu       $v0, $s0, $zero
    /* BBE8 8001B3E8 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* BBEC 8001B3EC 1800B28F */  lw         $s2, 0x18($sp)
    /* BBF0 8001B3F0 1400B18F */  lw         $s1, 0x14($sp)
    /* BBF4 8001B3F4 1000B08F */  lw         $s0, 0x10($sp)
    /* BBF8 8001B3F8 0800E003 */  jr         $ra
    /* BBFC 8001B3FC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel TransitionIsFinished__9tMenuNFS4
