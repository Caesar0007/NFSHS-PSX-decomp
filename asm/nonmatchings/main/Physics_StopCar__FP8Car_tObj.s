.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Physics_StopCar__FP8Car_tObj, 0xD8

glabel Physics_StopCar__FP8Car_tObj
    /* 9AED8 800AA6D8 AC00838C */  lw         $v1, 0xAC($a0)
    /* 9AEDC 800AA6DC 00000000 */  nop
    /* 9AEE0 800AA6E0 00110300 */  sll        $v0, $v1, 4
    /* 9AEE4 800AA6E4 23104300 */  subu       $v0, $v0, $v1
    /* 9AEE8 800AA6E8 80100200 */  sll        $v0, $v0, 2
    /* 9AEEC 800AA6EC 21104300 */  addu       $v0, $v0, $v1
    /* 9AEF0 800AA6F0 80100200 */  sll        $v0, $v0, 2
    /* 9AEF4 800AA6F4 21104300 */  addu       $v0, $v0, $v1
    /* 9AEF8 800AA6F8 02004104 */  bgez       $v0, .L800AA704
    /* 9AEFC 800AA6FC 00000000 */   nop
    /* 9AF00 800AA700 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AA704:
    /* 9AF04 800AA704 B000838C */  lw         $v1, 0xB0($a0)
    /* 9AF08 800AA708 03120200 */  sra        $v0, $v0, 8
    /* 9AF0C 800AA70C AC0082AC */  sw         $v0, 0xAC($a0)
    /* 9AF10 800AA710 00110300 */  sll        $v0, $v1, 4
    /* 9AF14 800AA714 23104300 */  subu       $v0, $v0, $v1
    /* 9AF18 800AA718 80100200 */  sll        $v0, $v0, 2
    /* 9AF1C 800AA71C 21104300 */  addu       $v0, $v0, $v1
    /* 9AF20 800AA720 80100200 */  sll        $v0, $v0, 2
    /* 9AF24 800AA724 21104300 */  addu       $v0, $v0, $v1
    /* 9AF28 800AA728 02004104 */  bgez       $v0, .L800AA734
    /* 9AF2C 800AA72C 00000000 */   nop
    /* 9AF30 800AA730 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AA734:
    /* 9AF34 800AA734 B400838C */  lw         $v1, 0xB4($a0)
    /* 9AF38 800AA738 03120200 */  sra        $v0, $v0, 8
    /* 9AF3C 800AA73C B00082AC */  sw         $v0, 0xB0($a0)
    /* 9AF40 800AA740 00110300 */  sll        $v0, $v1, 4
    /* 9AF44 800AA744 23104300 */  subu       $v0, $v0, $v1
    /* 9AF48 800AA748 80100200 */  sll        $v0, $v0, 2
    /* 9AF4C 800AA74C 21104300 */  addu       $v0, $v0, $v1
    /* 9AF50 800AA750 80100200 */  sll        $v0, $v0, 2
    /* 9AF54 800AA754 21184300 */  addu       $v1, $v0, $v1
    /* 9AF58 800AA758 02006104 */  bgez       $v1, .L800AA764
    /* 9AF5C 800AA75C 00000000 */   nop
    /* 9AF60 800AA760 FF006324 */  addiu      $v1, $v1, 0xFF
  .L800AA764:
    /* 9AF64 800AA764 2C01828C */  lw         $v0, 0x12C($a0)
    /* 9AF68 800AA768 031A0300 */  sra        $v1, $v1, 8
    /* 9AF6C 800AA76C 33334228 */  slti       $v0, $v0, 0x3333
    /* 9AF70 800AA770 0D004010 */  beqz       $v0, .L800AA7A8
    /* 9AF74 800AA774 B40083AC */   sw        $v1, 0xB4($a0)
    /* 9AF78 800AA778 1801838C */  lw         $v1, 0x118($a0)
    /* 9AF7C 800AA77C 00000000 */  nop
    /* 9AF80 800AA780 02006104 */  bgez       $v1, .L800AA78C
    /* 9AF84 800AA784 00000000 */   nop
    /* 9AF88 800AA788 FF006324 */  addiu      $v1, $v1, 0xFF
  .L800AA78C:
    /* 9AF8C 800AA78C 031A0300 */  sra        $v1, $v1, 8
    /* 9AF90 800AA790 40110300 */  sll        $v0, $v1, 5
    /* 9AF94 800AA794 23104300 */  subu       $v0, $v0, $v1
    /* 9AF98 800AA798 80100200 */  sll        $v0, $v0, 2
    /* 9AF9C 800AA79C 21104300 */  addu       $v0, $v0, $v1
    /* 9AFA0 800AA7A0 40100200 */  sll        $v0, $v0, 1
    /* 9AFA4 800AA7A4 180182AC */  sw         $v0, 0x118($a0)
  .L800AA7A8:
    /* 9AFA8 800AA7A8 0800E003 */  jr         $ra
    /* 9AFAC 800AA7AC 00000000 */   nop
endlabel Physics_StopCar__FP8Car_tObj
