.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CheckConditionWithCop0__19AIHigh_BTC_HumanCop, 0xEC

glabel CheckConditionWithCop0__19AIHigh_BTC_HumanCop
    /* 4DD64 8005D564 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 4DD68 8005D568 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4DD6C 8005D56C 21888000 */  addu       $s1, $a0, $zero
    /* 4DD70 8005D570 1800BFAF */  sw         $ra, 0x18($sp)
    /* 4DD74 8005D574 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4DD78 8005D578 1C00228E */  lw         $v0, 0x1C($s1)
    /* 4DD7C 8005D57C 00000000 */  nop
    /* 4DD80 8005D580 2E004010 */  beqz       $v0, .L8005D63C
    /* 4DD84 8005D584 1180023C */   lui       $v0, %hi(highLevelAIObjs)
    /* 4DD88 8005D588 38CD508C */  lw         $s0, %lo(highLevelAIObjs)($v0)
    /* 4DD8C 8005D58C 6400238E */  lw         $v1, 0x64($s1)
    /* 4DD90 8005D590 6400028E */  lw         $v0, 0x64($s0)
    /* 4DD94 8005D594 00000000 */  nop
    /* 4DD98 8005D598 2A106200 */  slt        $v0, $v1, $v0
    /* 4DD9C 8005D59C 22004010 */  beqz       $v0, .L8005D628
    /* 4DDA0 8005D5A0 00000000 */   nop
    /* 4DDA4 8005D5A4 0000028E */  lw         $v0, 0x0($s0)
    /* 4DDA8 8005D5A8 8000068E */  lw         $a2, 0x80($s0)
    /* 4DDAC 8005D5AC 8400078E */  lw         $a3, 0x84($s0)
    /* 4DDB0 8005D5B0 08004584 */  lh         $a1, 0x8($v0)
    /* 4DDB4 8005D5B4 01006224 */  addiu      $v0, $v1, 0x1
    /* 4DDB8 8005D5B8 01004230 */  andi       $v0, $v0, 0x1
    /* 4DDBC 8005D5BC 04004010 */  beqz       $v0, .L8005D5D0
    /* 4DDC0 8005D5C0 C0100600 */   sll       $v0, $a2, 3
    /* 4DDC4 8005D5C4 23104600 */  subu       $v0, $v0, $a2
    /* 4DDC8 8005D5C8 77750108 */  j          .L8005D5DC
    /* 4DDCC 8005D5CC 40100200 */   sll       $v0, $v0, 1
  .L8005D5D0:
    /* 4DDD0 8005D5D0 23104600 */  subu       $v0, $v0, $a2
    /* 4DDD4 8005D5D4 40100200 */  sll        $v0, $v0, 1
    /* 4DDD8 8005D5D8 23100200 */  negu       $v0, $v0
  .L8005D5DC:
    /* 4DDDC 8005D5DC 09004004 */  bltz       $v0, .L8005D604
    /* 4DDE0 8005D5E0 00000000 */   nop
    /* 4DDE4 8005D5E4 1480033C */  lui        $v1, %hi(gNumSlices)
    /* 4DDE8 8005D5E8 C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* 4DDEC 8005D5EC 2128A200 */  addu       $a1, $a1, $v0
    /* 4DDF0 8005D5F0 2A10A300 */  slt        $v0, $a1, $v1
    /* 4DDF4 8005D5F4 0A004014 */  bnez       $v0, .L8005D620
    /* 4DDF8 8005D5F8 00000000 */   nop
    /* 4DDFC 8005D5FC 88750108 */  j          .L8005D620
    /* 4DE00 8005D600 2328A300 */   subu      $a1, $a1, $v1
  .L8005D604:
    /* 4DE04 8005D604 2128A200 */  addu       $a1, $a1, $v0
    /* 4DE08 8005D608 0500A104 */  bgez       $a1, .L8005D620
    /* 4DE0C 8005D60C 00000000 */   nop
    /* 4DE10 8005D610 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 4DE14 8005D614 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 4DE18 8005D618 00000000 */  nop
    /* 4DE1C 8005D61C 2128A200 */  addu       $a1, $a1, $v0
  .L8005D620:
    /* 4DE20 8005D620 9475010C */  jal        NewStage__19AIHigh_BTC_HumanCopiii
    /* 4DE24 8005D624 21202002 */   addu      $a0, $s1, $zero
  .L8005D628:
    /* 4DE28 8005D628 0000028E */  lw         $v0, 0x0($s0)
    /* 4DE2C 8005D62C 0000238E */  lw         $v1, 0x0($s1)
    /* 4DE30 8005D630 5C05428C */  lw         $v0, 0x55C($v0)
    /* 4DE34 8005D634 00000000 */  nop
    /* 4DE38 8005D638 5C0562AC */  sw         $v0, 0x55C($v1)
  .L8005D63C:
    /* 4DE3C 8005D63C 1800BF8F */  lw         $ra, 0x18($sp)
    /* 4DE40 8005D640 1400B18F */  lw         $s1, 0x14($sp)
    /* 4DE44 8005D644 1000B08F */  lw         $s0, 0x10($sp)
    /* 4DE48 8005D648 0800E003 */  jr         $ra
    /* 4DE4C 8005D64C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel CheckConditionWithCop0__19AIHigh_BTC_HumanCop
