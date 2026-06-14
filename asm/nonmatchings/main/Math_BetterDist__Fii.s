.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Math_BetterDist__Fii, 0x160

glabel Math_BetterDist__Fii
    /* 8DCC8 8009D4C8 2A10A400 */  slt        $v0, $a1, $a0
    /* 8DCCC 8009D4CC 03004010 */  beqz       $v0, .L8009D4DC
    /* 8DCD0 8009D4D0 21308000 */   addu      $a2, $a0, $zero
    /* 8DCD4 8009D4D4 38750208 */  j          .L8009D4E0
    /* 8DCD8 8009D4D8 2120A000 */   addu      $a0, $a1, $zero
  .L8009D4DC:
    /* 8DCDC 8009D4DC 2130A000 */  addu       $a2, $a1, $zero
  .L8009D4E0:
    /* 8DCE0 8009D4E0 83280600 */  sra        $a1, $a2, 2
    /* 8DCE4 8009D4E4 2A108500 */  slt        $v0, $a0, $a1
    /* 8DCE8 8009D4E8 0F004010 */  beqz       $v0, .L8009D528
    /* 8DCEC 8009D4EC 03110400 */   sra       $v0, $a0, 4
    /* 8DCF0 8009D4F0 2110C200 */  addu       $v0, $a2, $v0
    /* 8DCF4 8009D4F4 83190400 */  sra        $v1, $a0, 6
    /* 8DCF8 8009D4F8 21104300 */  addu       $v0, $v0, $v1
    /* 8DCFC 8009D4FC C3190400 */  sra        $v1, $a0, 7
    /* 8DD00 8009D500 21104300 */  addu       $v0, $v0, $v1
    /* 8DD04 8009D504 431A0400 */  sra        $v1, $a0, 9
    /* 8DD08 8009D508 21104300 */  addu       $v0, $v0, $v1
    /* 8DD0C 8009D50C 831B0400 */  sra        $v1, $a0, 14
    /* 8DD10 8009D510 21104300 */  addu       $v0, $v0, $v1
    /* 8DD14 8009D514 C31B0400 */  sra        $v1, $a0, 15
  .L8009D518:
    /* 8DD18 8009D518 21104300 */  addu       $v0, $v0, $v1
    /* 8DD1C 8009D51C 031C0400 */  sra        $v1, $a0, 16
    /* 8DD20 8009D520 0800E003 */  jr         $ra
    /* 8DD24 8009D524 21104300 */   addu      $v0, $v0, $v1
  .L8009D528:
    /* 8DD28 8009D528 43180600 */  sra        $v1, $a2, 1
    /* 8DD2C 8009D52C 2A108300 */  slt        $v0, $a0, $v1
    /* 8DD30 8009D530 12004010 */  beqz       $v0, .L8009D57C
    /* 8DD34 8009D534 C3100400 */   sra       $v0, $a0, 3
    /* 8DD38 8009D538 2110C200 */  addu       $v0, $a2, $v0
    /* 8DD3C 8009D53C 43190400 */  sra        $v1, $a0, 5
    /* 8DD40 8009D540 21104300 */  addu       $v0, $v0, $v1
    /* 8DD44 8009D544 83190400 */  sra        $v1, $a0, 6
    /* 8DD48 8009D548 21104300 */  addu       $v0, $v0, $v1
    /* 8DD4C 8009D54C C3190400 */  sra        $v1, $a0, 7
    /* 8DD50 8009D550 21104300 */  addu       $v0, $v0, $v1
    /* 8DD54 8009D554 031A0400 */  sra        $v1, $a0, 8
    /* 8DD58 8009D558 21104300 */  addu       $v0, $v0, $v1
    /* 8DD5C 8009D55C 431A0400 */  sra        $v1, $a0, 9
    /* 8DD60 8009D560 21104300 */  addu       $v0, $v0, $v1
    /* 8DD64 8009D564 031B0400 */  sra        $v1, $a0, 12
    /* 8DD68 8009D568 21104300 */  addu       $v0, $v0, $v1
    /* 8DD6C 8009D56C 431B0400 */  sra        $v1, $a0, 13
    /* 8DD70 8009D570 21104300 */  addu       $v0, $v0, $v1
    /* 8DD74 8009D574 46750208 */  j          .L8009D518
    /* 8DD78 8009D578 831B0400 */   sra       $v1, $a0, 14
  .L8009D57C:
    /* 8DD7C 8009D57C 21106500 */  addu       $v0, $v1, $a1
    /* 8DD80 8009D580 2A108200 */  slt        $v0, $a0, $v0
    /* 8DD84 8009D584 1A004014 */  bnez       $v0, .L8009D5F0
    /* 8DD88 8009D588 43190400 */   sra       $v1, $a0, 5
    /* 8DD8C 8009D58C 83100400 */  sra        $v0, $a0, 2
    /* 8DD90 8009D590 2110C200 */  addu       $v0, $a2, $v0
    /* 8DD94 8009D594 03190400 */  sra        $v1, $a0, 4
    /* 8DD98 8009D598 21104300 */  addu       $v0, $v0, $v1
    /* 8DD9C 8009D59C 43190400 */  sra        $v1, $a0, 5
    /* 8DDA0 8009D5A0 21104300 */  addu       $v0, $v0, $v1
    /* 8DDA4 8009D5A4 83190400 */  sra        $v1, $a0, 6
    /* 8DDA8 8009D5A8 21104300 */  addu       $v0, $v0, $v1
    /* 8DDAC 8009D5AC C3190400 */  sra        $v1, $a0, 7
    /* 8DDB0 8009D5B0 21104300 */  addu       $v0, $v0, $v1
    /* 8DDB4 8009D5B4 031A0400 */  sra        $v1, $a0, 8
    /* 8DDB8 8009D5B8 21104300 */  addu       $v0, $v0, $v1
    /* 8DDBC 8009D5BC 431A0400 */  sra        $v1, $a0, 9
    /* 8DDC0 8009D5C0 21104300 */  addu       $v0, $v0, $v1
    /* 8DDC4 8009D5C4 C31A0400 */  sra        $v1, $a0, 11
    /* 8DDC8 8009D5C8 21104300 */  addu       $v0, $v0, $v1
    /* 8DDCC 8009D5CC 031B0400 */  sra        $v1, $a0, 12
    /* 8DDD0 8009D5D0 21104300 */  addu       $v0, $v0, $v1
    /* 8DDD4 8009D5D4 431B0400 */  sra        $v1, $a0, 13
    /* 8DDD8 8009D5D8 21104300 */  addu       $v0, $v0, $v1
    /* 8DDDC 8009D5DC 831B0400 */  sra        $v1, $a0, 14
    /* 8DDE0 8009D5E0 21104300 */  addu       $v0, $v0, $v1
    /* 8DDE4 8009D5E4 C31B0400 */  sra        $v1, $a0, 15
    /* 8DDE8 8009D5E8 0800E003 */  jr         $ra
    /* 8DDEC 8009D5EC 21104300 */   addu      $v0, $v0, $v1
  .L8009D5F0:
    /* 8DDF0 8009D5F0 83100400 */  sra        $v0, $a0, 2
    /* 8DDF4 8009D5F4 2110C200 */  addu       $v0, $a2, $v0
    /* 8DDF8 8009D5F8 21104300 */  addu       $v0, $v0, $v1
    /* 8DDFC 8009D5FC 031A0400 */  sra        $v1, $a0, 8
    /* 8DE00 8009D600 21104300 */  addu       $v0, $v0, $v1
    /* 8DE04 8009D604 831A0400 */  sra        $v1, $a0, 10
    /* 8DE08 8009D608 21104300 */  addu       $v0, $v0, $v1
    /* 8DE0C 8009D60C C31A0400 */  sra        $v1, $a0, 11
    /* 8DE10 8009D610 21104300 */  addu       $v0, $v0, $v1
    /* 8DE14 8009D614 031B0400 */  sra        $v1, $a0, 12
    /* 8DE18 8009D618 21104300 */  addu       $v0, $v0, $v1
    /* 8DE1C 8009D61C 431B0400 */  sra        $v1, $a0, 13
    /* 8DE20 8009D620 0800E003 */  jr         $ra
    /* 8DE24 8009D624 21104300 */   addu      $v0, $v0, $v1
endlabel Math_BetterDist__Fii
