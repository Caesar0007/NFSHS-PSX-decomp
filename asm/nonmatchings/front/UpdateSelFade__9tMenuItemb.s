.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateSelFade__9tMenuItemb, 0x58

glabel UpdateSelFade__9tMenuItemb
    /* 14FD0 800247D0 0400A010 */  beqz       $a1, .L800247E4
    /* 14FD4 800247D4 00000000 */   nop
    /* 14FD8 800247D8 08008294 */  lhu        $v0, 0x8($a0)
    /* 14FDC 800247DC FC910008 */  j          .L800247F0
    /* 14FE0 800247E0 40004224 */   addiu     $v0, $v0, 0x40
  .L800247E4:
    /* 14FE4 800247E4 08008294 */  lhu        $v0, 0x8($a0)
    /* 14FE8 800247E8 00000000 */  nop
    /* 14FEC 800247EC F6FF4224 */  addiu      $v0, $v0, -0xA
  .L800247F0:
    /* 14FF0 800247F0 080082A4 */  sh         $v0, 0x8($a0)
    /* 14FF4 800247F4 08008284 */  lh         $v0, 0x8($a0)
    /* 14FF8 800247F8 00000000 */  nop
    /* 14FFC 800247FC 81004228 */  slti       $v0, $v0, 0x81
    /* 15000 80024800 02004014 */  bnez       $v0, .L8002480C
    /* 15004 80024804 80000224 */   addiu     $v0, $zero, 0x80
    /* 15008 80024808 080082A4 */  sh         $v0, 0x8($a0)
  .L8002480C:
    /* 1500C 8002480C 08008284 */  lh         $v0, 0x8($a0)
    /* 15010 80024810 00000000 */  nop
    /* 15014 80024814 02004104 */  bgez       $v0, .L80024820
    /* 15018 80024818 00000000 */   nop
    /* 1501C 8002481C 080080A4 */  sh         $zero, 0x8($a0)
  .L80024820:
    /* 15020 80024820 0800E003 */  jr         $ra
    /* 15024 80024824 00000000 */   nop
endlabel UpdateSelFade__9tMenuItemb
