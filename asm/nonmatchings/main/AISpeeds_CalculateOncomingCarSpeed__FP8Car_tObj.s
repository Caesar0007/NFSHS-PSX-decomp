.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_CalculateOncomingCarSpeed__FP8Car_tObj, 0xA8

glabel AISpeeds_CalculateOncomingCarSpeed__FP8Car_tObj
    /* 5F680 8006EE80 7805828C */  lw         $v0, 0x578($a0)
    /* 5F684 8006EE84 0D00033C */  lui        $v1, (0xD5554 >> 16)
    /* 5F688 8006EE88 6405428C */  lw         $v0, 0x564($v0)
    /* 5F68C 8006EE8C 54556334 */  ori        $v1, $v1, (0xD5554 & 0xFFFF)
    /* 5F690 8006EE90 02004104 */  bgez       $v0, .L8006EE9C
    /* 5F694 8006EE94 21204000 */   addu      $a0, $v0, $zero
    /* 5F698 8006EE98 23200400 */  negu       $a0, $a0
  .L8006EE9C:
    /* 5F69C 8006EE9C 2A186400 */  slt        $v1, $v1, $a0
    /* 5F6A0 8006EEA0 1D006010 */  beqz       $v1, .L8006EF18
    /* 5F6A4 8006EEA4 1A00023C */   lui       $v0, (0x1AAAA9 >> 16)
    /* 5F6A8 8006EEA8 A9AA4234 */  ori        $v0, $v0, (0x1AAAA9 & 0xFFFF)
    /* 5F6AC 8006EEAC 2A104400 */  slt        $v0, $v0, $a0
    /* 5F6B0 8006EEB0 16004010 */  beqz       $v0, .L8006EF0C
    /* 5F6B4 8006EEB4 2700023C */   lui       $v0, (0x27FFFF >> 16)
    /* 5F6B8 8006EEB8 FFFF4234 */  ori        $v0, $v0, (0x27FFFF & 0xFFFF)
    /* 5F6BC 8006EEBC 2A104400 */  slt        $v0, $v0, $a0
    /* 5F6C0 8006EEC0 0F004010 */  beqz       $v0, .L8006EF00
    /* 5F6C4 8006EEC4 3700023C */   lui       $v0, (0x378E37 >> 16)
    /* 5F6C8 8006EEC8 378E4234 */  ori        $v0, $v0, (0x378E37 & 0xFFFF)
    /* 5F6CC 8006EECC 2A104400 */  slt        $v0, $v0, $a0
    /* 5F6D0 8006EED0 08004010 */  beqz       $v0, .L8006EEF4
    /* 5F6D4 8006EED4 4700023C */   lui       $v0, (0x471C70 >> 16)
    /* 5F6D8 8006EED8 701C4234 */  ori        $v0, $v0, (0x471C70 & 0xFFFF)
    /* 5F6DC 8006EEDC 0200033C */  lui        $v1, (0x2C51E >> 16)
    /* 5F6E0 8006EEE0 2A104400 */  slt        $v0, $v0, $a0
    /* 5F6E4 8006EEE4 0E004014 */  bnez       $v0, .L8006EF20
    /* 5F6E8 8006EEE8 1EC56334 */   ori       $v1, $v1, (0x2C51E & 0xFFFF)
    /* 5F6EC 8006EEEC C7BB0108 */  j          .L8006EF1C
    /* 5F6F0 8006EEF0 0200033C */   lui       $v1, (0x238E3 >> 16)
  .L8006EEF4:
    /* 5F6F4 8006EEF4 0400033C */  lui        $v1, (0x471C7 >> 16)
    /* 5F6F8 8006EEF8 C8BB0108 */  j          .L8006EF20
    /* 5F6FC 8006EEFC C7716334 */   ori       $v1, $v1, (0x471C7 & 0xFFFF)
  .L8006EF00:
    /* 5F700 8006EF00 0800033C */  lui        $v1, (0x8E38E >> 16)
    /* 5F704 8006EF04 C8BB0108 */  j          .L8006EF20
    /* 5F708 8006EF08 8EE36334 */   ori       $v1, $v1, (0x8E38E & 0xFFFF)
  .L8006EF0C:
    /* 5F70C 8006EF0C 0D00033C */  lui        $v1, (0xD5555 >> 16)
    /* 5F710 8006EF10 C8BB0108 */  j          .L8006EF20
    /* 5F714 8006EF14 55556334 */   ori       $v1, $v1, (0xD5555 & 0xFFFF)
  .L8006EF18:
    /* 5F718 8006EF18 1600033C */  lui        $v1, (0x1638E3 >> 16)
  .L8006EF1C:
    /* 5F71C 8006EF1C E3386334 */  ori        $v1, $v1, (0x1638E3 & 0xFFFF)
  .L8006EF20:
    /* 5F720 8006EF20 0800E003 */  jr         $ra
    /* 5F724 8006EF24 21106000 */   addu      $v0, $v1, $zero
endlabel AISpeeds_CalculateOncomingCarSpeed__FP8Car_tObj
