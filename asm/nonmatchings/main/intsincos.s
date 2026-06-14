.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching intsincos, 0x11C

glabel intsincos
    /* DB5BC 800EADBC 03120400 */  sra        $v0, $a0, 8
    /* DB5C0 800EADC0 03004330 */  andi       $v1, $v0, 0x3
    /* DB5C4 800EADC4 01000224 */  addiu      $v0, $zero, 0x1
    /* DB5C8 800EADC8 1A006210 */  beq        $v1, $v0, .L800EAE34
    /* DB5CC 800EADCC FF008430 */   andi      $a0, $a0, 0xFF
    /* DB5D0 800EADD0 02006228 */  slti       $v0, $v1, 0x2
    /* DB5D4 800EADD4 05004010 */  beqz       $v0, .L800EADEC
    /* DB5D8 800EADD8 00000000 */   nop
    /* DB5DC 800EADDC 0B006010 */  beqz       $v1, .L800EAE0C
    /* DB5E0 800EADE0 1380033C */   lui       $v1, %hi(sintbl)
    /* DB5E4 800EADE4 0800E003 */  jr         $ra
    /* DB5E8 800EADE8 00000000 */   nop
  .L800EADEC:
    /* DB5EC 800EADEC 02000224 */  addiu      $v0, $zero, 0x2
    /* DB5F0 800EADF0 20006210 */  beq        $v1, $v0, .L800EAE74
    /* DB5F4 800EADF4 80100400 */   sll       $v0, $a0, 2
    /* DB5F8 800EADF8 03000224 */  addiu      $v0, $zero, 0x3
    /* DB5FC 800EADFC 28006210 */  beq        $v1, $v0, .L800EAEA0
    /* DB600 800EAE00 1380033C */   lui       $v1, %hi(sintbl)
    /* DB604 800EAE04 0800E003 */  jr         $ra
    /* DB608 800EAE08 00000000 */   nop
  .L800EAE0C:
    /* DB60C 800EAE0C 64746324 */  addiu      $v1, $v1, %lo(sintbl)
    /* DB610 800EAE10 80100400 */  sll        $v0, $a0, 2
    /* DB614 800EAE14 21104300 */  addu       $v0, $v0, $v1
    /* DB618 800EAE18 0000428C */  lw         $v0, 0x0($v0)
    /* DB61C 800EAE1C 00000000 */  nop
    /* DB620 800EAE20 0000A2AC */  sw         $v0, 0x0($a1)
    /* DB624 800EAE24 00010224 */  addiu      $v0, $zero, 0x100
    /* DB628 800EAE28 23104400 */  subu       $v0, $v0, $a0
    /* DB62C 800EAE2C B2AB0308 */  j          .L800EAEC8
    /* DB630 800EAE30 80100200 */   sll       $v0, $v0, 2
  .L800EAE34:
    /* DB634 800EAE34 1380033C */  lui        $v1, %hi(sintbl)
    /* DB638 800EAE38 64746324 */  addiu      $v1, $v1, %lo(sintbl)
    /* DB63C 800EAE3C 00010224 */  addiu      $v0, $zero, 0x100
    /* DB640 800EAE40 23104400 */  subu       $v0, $v0, $a0
    /* DB644 800EAE44 80100200 */  sll        $v0, $v0, 2
    /* DB648 800EAE48 21104300 */  addu       $v0, $v0, $v1
    /* DB64C 800EAE4C 0000428C */  lw         $v0, 0x0($v0)
    /* DB650 800EAE50 00000000 */  nop
    /* DB654 800EAE54 0000A2AC */  sw         $v0, 0x0($a1)
    /* DB658 800EAE58 80100400 */  sll        $v0, $a0, 2
  .L800EAE5C:
    /* DB65C 800EAE5C 21104300 */  addu       $v0, $v0, $v1
    /* DB660 800EAE60 0000428C */  lw         $v0, 0x0($v0)
    /* DB664 800EAE64 00000000 */  nop
    /* DB668 800EAE68 23100200 */  negu       $v0, $v0
    /* DB66C 800EAE6C 0800E003 */  jr         $ra
    /* DB670 800EAE70 0000C2AC */   sw        $v0, 0x0($a2)
  .L800EAE74:
    /* DB674 800EAE74 1380033C */  lui        $v1, %hi(sintbl)
    /* DB678 800EAE78 64746324 */  addiu      $v1, $v1, %lo(sintbl)
    /* DB67C 800EAE7C 21104300 */  addu       $v0, $v0, $v1
    /* DB680 800EAE80 0000428C */  lw         $v0, 0x0($v0)
    /* DB684 800EAE84 00000000 */  nop
    /* DB688 800EAE88 23100200 */  negu       $v0, $v0
    /* DB68C 800EAE8C 0000A2AC */  sw         $v0, 0x0($a1)
    /* DB690 800EAE90 00010224 */  addiu      $v0, $zero, 0x100
    /* DB694 800EAE94 23104400 */  subu       $v0, $v0, $a0
    /* DB698 800EAE98 97AB0308 */  j          .L800EAE5C
    /* DB69C 800EAE9C 80100200 */   sll       $v0, $v0, 2
  .L800EAEA0:
    /* DB6A0 800EAEA0 64746324 */  addiu      $v1, $v1, %lo(sintbl)
    /* DB6A4 800EAEA4 00010224 */  addiu      $v0, $zero, 0x100
    /* DB6A8 800EAEA8 23104400 */  subu       $v0, $v0, $a0
    /* DB6AC 800EAEAC 80100200 */  sll        $v0, $v0, 2
    /* DB6B0 800EAEB0 21104300 */  addu       $v0, $v0, $v1
    /* DB6B4 800EAEB4 0000428C */  lw         $v0, 0x0($v0)
    /* DB6B8 800EAEB8 00000000 */  nop
    /* DB6BC 800EAEBC 23100200 */  negu       $v0, $v0
    /* DB6C0 800EAEC0 0000A2AC */  sw         $v0, 0x0($a1)
    /* DB6C4 800EAEC4 80100400 */  sll        $v0, $a0, 2
  .L800EAEC8:
    /* DB6C8 800EAEC8 21104300 */  addu       $v0, $v0, $v1
    /* DB6CC 800EAECC 0000428C */  lw         $v0, 0x0($v0)
    /* DB6D0 800EAED0 0800E003 */  jr         $ra
    /* DB6D4 800EAED4 0000C2AC */   sw        $v0, 0x0($a2)
endlabel intsincos
