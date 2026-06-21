.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdatefOpenHeight__20tMenuItemSlidingMenub, 0x220

glabel UpdatefOpenHeight__20tMenuItemSlidingMenub
    /* DC1C 8001D41C 28008284 */  lh         $v0, 0x28($a0)
    /* DC20 8001D420 00000000 */  nop
    /* DC24 8001D424 07004014 */  bnez       $v0, .L8001D444
    /* DC28 8001D428 380080AC */   sw        $zero, 0x38($a0)
    /* DC2C 8001D42C 26008394 */  lhu        $v1, 0x26($a0)
    /* DC30 8001D430 00000000 */  nop
    /* DC34 8001D434 00140300 */  sll        $v0, $v1, 16
    /* DC38 8001D438 43140200 */  sra        $v0, $v0, 17
    /* DC3C 8001D43C 21186200 */  addu       $v1, $v1, $v0
    /* DC40 8001D440 2A0083A4 */  sh         $v1, 0x2A($a0)
  .L8001D444:
    /* DC44 8001D444 2000838C */  lw         $v1, 0x20($a0)
    /* DC48 8001D448 1C00828C */  lw         $v0, 0x1C($a0)
    /* DC4C 8001D44C 00000000 */  nop
    /* DC50 8001D450 0C006210 */  beq        $v1, $v0, .L8001D484
    /* DC54 8001D454 00000000 */   nop
    /* DC58 8001D458 28008284 */  lh         $v0, 0x28($a0)
    /* DC5C 8001D45C 00000000 */  nop
    /* DC60 8001D460 08004018 */  blez       $v0, .L8001D484
    /* DC64 8001D464 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* DC68 8001D468 02004104 */  bgez       $v0, .L8001D474
    /* DC6C 8001D46C 00000000 */   nop
    /* DC70 8001D470 21100000 */  addu       $v0, $zero, $zero
  .L8001D474:
    /* DC74 8001D474 280082A4 */  sh         $v0, 0x28($a0)
    /* DC78 8001D478 01000224 */  addiu      $v0, $zero, 0x1
    /* DC7C 8001D47C 66750008 */  j          .L8001D598
    /* DC80 8001D480 380082AC */   sw        $v0, 0x38($a0)
  .L8001D484:
    /* DC84 8001D484 2000828C */  lw         $v0, 0x20($a0)
    /* DC88 8001D488 00000000 */  nop
    /* DC8C 8001D48C 0C004014 */  bnez       $v0, .L8001D4C0
    /* DC90 8001D490 00000000 */   nop
    /* DC94 8001D494 2C008384 */  lh         $v1, 0x2C($a0)
    /* DC98 8001D498 00000000 */  nop
    /* DC9C 8001D49C 80006228 */  slti       $v0, $v1, 0x80
    /* DCA0 8001D4A0 08004010 */  beqz       $v0, .L8001D4C4
    /* DCA4 8001D4A4 00000000 */   nop
    /* DCA8 8001D4A8 3000828C */  lw         $v0, 0x30($a0)
    /* DCAC 8001D4AC 00000000 */  nop
    /* DCB0 8001D4B0 39004014 */  bnez       $v0, .L8001D598
    /* DCB4 8001D4B4 28006324 */   addiu     $v1, $v1, 0x28
    /* DCB8 8001D4B8 62750008 */  j          .L8001D588
    /* DCBC 8001D4BC 81006228 */   slti      $v0, $v1, 0x81
  .L8001D4C0:
    /* DCC0 8001D4C0 2C008384 */  lh         $v1, 0x2C($a0)
  .L8001D4C4:
    /* DCC4 8001D4C4 00000000 */  nop
    /* DCC8 8001D4C8 18006018 */  blez       $v1, .L8001D52C
    /* DCCC 8001D4CC 00000000 */   nop
    /* DCD0 8001D4D0 1C00828C */  lw         $v0, 0x1C($a0)
    /* DCD4 8001D4D4 00000000 */  nop
    /* DCD8 8001D4D8 14004014 */  bnez       $v0, .L8001D52C
    /* DCDC 8001D4DC 00000000 */   nop
    /* DCE0 8001D4E0 2000828C */  lw         $v0, 0x20($a0)
    /* DCE4 8001D4E4 00000000 */  nop
    /* DCE8 8001D4E8 10004010 */  beqz       $v0, .L8001D52C
    /* DCEC 8001D4EC 00000000 */   nop
    /* DCF0 8001D4F0 3000828C */  lw         $v0, 0x30($a0)
    /* DCF4 8001D4F4 00000000 */  nop
    /* DCF8 8001D4F8 05004014 */  bnez       $v0, .L8001D510
    /* DCFC 8001D4FC D8FF6224 */   addiu     $v0, $v1, -0x28
    /* DD00 8001D500 02004104 */  bgez       $v0, .L8001D50C
    /* DD04 8001D504 00000000 */   nop
    /* DD08 8001D508 21100000 */  addu       $v0, $zero, $zero
  .L8001D50C:
    /* DD0C 8001D50C 2C0082A4 */  sh         $v0, 0x2C($a0)
  .L8001D510:
    /* DD10 8001D510 3400828C */  lw         $v0, 0x34($a0)
    /* DD14 8001D514 00000000 */  nop
    /* DD18 8001D518 1F004014 */  bnez       $v0, .L8001D598
    /* DD1C 8001D51C 00000000 */   nop
    /* DD20 8001D520 2000828C */  lw         $v0, 0x20($a0)
    /* DD24 8001D524 66750008 */  j          .L8001D598
    /* DD28 8001D528 1C0082AC */   sw        $v0, 0x1C($a0)
  .L8001D52C:
    /* DD2C 8001D52C 2000838C */  lw         $v1, 0x20($a0)
    /* DD30 8001D530 3400828C */  lw         $v0, 0x34($a0)
    /* DD34 8001D534 00000000 */  nop
    /* DD38 8001D538 17004014 */  bnez       $v0, .L8001D598
    /* DD3C 8001D53C 1C0083AC */   sw        $v1, 0x1C($a0)
    /* DD40 8001D540 3000828C */  lw         $v0, 0x30($a0)
    /* DD44 8001D544 00000000 */  nop
    /* DD48 8001D548 13004014 */  bnez       $v0, .L8001D598
    /* DD4C 8001D54C 00000000 */   nop
    /* DD50 8001D550 09006010 */  beqz       $v1, .L8001D578
    /* DD54 8001D554 00000000 */   nop
    /* DD58 8001D558 2C008284 */  lh         $v0, 0x2C($a0)
    /* DD5C 8001D55C 00000000 */  nop
    /* DD60 8001D560 D8FF4224 */  addiu      $v0, $v0, -0x28
    /* DD64 8001D564 02004104 */  bgez       $v0, .L8001D570
    /* DD68 8001D568 00000000 */   nop
    /* DD6C 8001D56C 21100000 */  addu       $v0, $zero, $zero
  .L8001D570:
    /* DD70 8001D570 66750008 */  j          .L8001D598
    /* DD74 8001D574 2C0082A4 */   sh        $v0, 0x2C($a0)
  .L8001D578:
    /* DD78 8001D578 2C008284 */  lh         $v0, 0x2C($a0)
    /* DD7C 8001D57C 00000000 */  nop
    /* DD80 8001D580 28004324 */  addiu      $v1, $v0, 0x28
    /* DD84 8001D584 81006228 */  slti       $v0, $v1, 0x81
  .L8001D588:
    /* DD88 8001D588 02004014 */  bnez       $v0, .L8001D594
    /* DD8C 8001D58C 00000000 */   nop
    /* DD90 8001D590 80000324 */  addiu      $v1, $zero, 0x80
  .L8001D594:
    /* DD94 8001D594 2C0083A4 */  sh         $v1, 0x2C($a0)
  .L8001D598:
    /* DD98 8001D598 1C00828C */  lw         $v0, 0x1C($a0)
    /* DD9C 8001D59C 00000000 */  nop
    /* DDA0 8001D5A0 24004010 */  beqz       $v0, .L8001D634
    /* DDA4 8001D5A4 00000000 */   nop
    /* DDA8 8001D5A8 1A00A010 */  beqz       $a1, .L8001D614
    /* DDAC 8001D5AC 00000000 */   nop
    /* DDB0 8001D5B0 3800828C */  lw         $v0, 0x38($a0)
    /* DDB4 8001D5B4 00000000 */  nop
    /* DDB8 8001D5B8 14004014 */  bnez       $v0, .L8001D60C
    /* DDBC 8001D5BC 00000000 */   nop
    /* DDC0 8001D5C0 28008684 */  lh         $a2, 0x28($a0)
    /* DDC4 8001D5C4 26008384 */  lh         $v1, 0x26($a0)
    /* DDC8 8001D5C8 00000000 */  nop
    /* DDCC 8001D5CC 2A10C300 */  slt        $v0, $a2, $v1
    /* DDD0 8001D5D0 07004010 */  beqz       $v0, .L8001D5F0
    /* DDD4 8001D5D4 0400C624 */   addiu     $a2, $a2, 0x4
    /* DDD8 8001D5D8 2A10C300 */  slt        $v0, $a2, $v1
    /* DDDC 8001D5DC 02004010 */  beqz       $v0, .L8001D5E8
    /* DDE0 8001D5E0 00000000 */   nop
    /* DDE4 8001D5E4 2118C000 */  addu       $v1, $a2, $zero
  .L8001D5E8:
    /* DDE8 8001D5E8 83750008 */  j          .L8001D60C
    /* DDEC 8001D5EC 280083A4 */   sh        $v1, 0x28($a0)
  .L8001D5F0:
    /* DDF0 8001D5F0 2A008284 */  lh         $v0, 0x2A($a0)
    /* DDF4 8001D5F4 00000000 */  nop
    /* DDF8 8001D5F8 FAFF4224 */  addiu      $v0, $v0, -0x6
    /* DDFC 8001D5FC 02004104 */  bgez       $v0, .L8001D608
    /* DE00 8001D600 00000000 */   nop
    /* DE04 8001D604 21100000 */  addu       $v0, $zero, $zero
  .L8001D608:
    /* DE08 8001D608 2A0082A4 */  sh         $v0, 0x2A($a0)
  .L8001D60C:
    /* DE0C 8001D60C 0900A014 */  bnez       $a1, .L8001D634
    /* DE10 8001D610 00000000 */   nop
  .L8001D614:
    /* DE14 8001D614 28008284 */  lh         $v0, 0x28($a0)
    /* DE18 8001D618 00000000 */  nop
    /* DE1C 8001D61C 05004018 */  blez       $v0, .L8001D634
    /* DE20 8001D620 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* DE24 8001D624 02004104 */  bgez       $v0, .L8001D630
    /* DE28 8001D628 00000000 */   nop
    /* DE2C 8001D62C 21100000 */  addu       $v0, $zero, $zero
  .L8001D630:
    /* DE30 8001D630 280082A4 */  sh         $v0, 0x28($a0)
  .L8001D634:
    /* DE34 8001D634 0800E003 */  jr         $ra
    /* DE38 8001D638 00000000 */   nop
endlabel UpdatefOpenHeight__20tMenuItemSlidingMenub
