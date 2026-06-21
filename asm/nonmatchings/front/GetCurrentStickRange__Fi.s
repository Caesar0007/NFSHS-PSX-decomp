.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetCurrentStickRange__Fi, 0x5C

glabel GetCurrentStickRange__Fi
    /* 10060 8001F860 1480023C */  lui        $v0, %hi(gPadinfo)
    /* 10064 8001F864 9CE84224 */  addiu      $v0, $v0, %lo(gPadinfo)
    /* 10068 8001F868 40210400 */  sll        $a0, $a0, 5
    /* 1006C 8001F86C 21208200 */  addu       $a0, $a0, $v0
    /* 10070 8001F870 08008290 */  lbu        $v0, 0x8($a0)
    /* 10074 8001F874 80000324 */  addiu      $v1, $zero, 0x80
    /* 10078 8001F878 23286200 */  subu       $a1, $v1, $v0
    /* 1007C 8001F87C 0200A01C */  bgtz       $a1, .L8001F888
    /* 10080 8001F880 00000000 */   nop
    /* 10084 8001F884 80FF4524 */  addiu      $a1, $v0, -0x80
  .L8001F888:
    /* 10088 8001F888 09008490 */  lbu        $a0, 0x9($a0)
    /* 1008C 8001F88C 00000000 */  nop
    /* 10090 8001F890 23106400 */  subu       $v0, $v1, $a0
    /* 10094 8001F894 0300401C */  bgtz       $v0, .L8001F8A4
    /* 10098 8001F898 21184000 */   addu      $v1, $v0, $zero
    /* 1009C 8001F89C 80FF8224 */  addiu      $v0, $a0, -0x80
    /* 100A0 8001F8A0 21184000 */  addu       $v1, $v0, $zero
  .L8001F8A4:
    /* 100A4 8001F8A4 2A106500 */  slt        $v0, $v1, $a1
    /* 100A8 8001F8A8 02004010 */  beqz       $v0, .L8001F8B4
    /* 100AC 8001F8AC 00000000 */   nop
    /* 100B0 8001F8B0 2118A000 */  addu       $v1, $a1, $zero
  .L8001F8B4:
    /* 100B4 8001F8B4 0800E003 */  jr         $ra
    /* 100B8 8001F8B8 21106000 */   addu      $v0, $v1, $zero
endlabel GetCurrentStickRange__Fi
