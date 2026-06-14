.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CD_flush, 0xD4

glabel CD_flush
    /* F8730 80107F30 1480033C */  lui        $v1, %hi(D_8013C20C)
    /* F8734 80107F34 0CC2638C */  lw         $v1, %lo(D_8013C20C)($v1)
    /* F8738 80107F38 01000224 */  addiu      $v0, $zero, 0x1
    /* F873C 80107F3C 000062A0 */  sb         $v0, 0x0($v1)
    /* F8740 80107F40 1480023C */  lui        $v0, %hi(D_8013C218)
    /* F8744 80107F44 18C2428C */  lw         $v0, %lo(D_8013C218)($v0)
    /* F8748 80107F48 00000000 */  nop
    /* F874C 80107F4C 00004290 */  lbu        $v0, 0x0($v0)
    /* F8750 80107F50 00000000 */  nop
    /* F8754 80107F54 07004230 */  andi       $v0, $v0, 0x7
    /* F8758 80107F58 16004010 */  beqz       $v0, .L80107FB4
    /* F875C 80107F5C 01000424 */   addiu     $a0, $zero, 0x1
    /* F8760 80107F60 07000324 */  addiu      $v1, $zero, 0x7
  .L80107F64:
    /* F8764 80107F64 1480023C */  lui        $v0, %hi(D_8013C20C)
    /* F8768 80107F68 0CC2428C */  lw         $v0, %lo(D_8013C20C)($v0)
    /* F876C 80107F6C 00000000 */  nop
    /* F8770 80107F70 000044A0 */  sb         $a0, 0x0($v0)
    /* F8774 80107F74 1480023C */  lui        $v0, %hi(D_8013C218)
    /* F8778 80107F78 18C2428C */  lw         $v0, %lo(D_8013C218)($v0)
    /* F877C 80107F7C 00000000 */  nop
    /* F8780 80107F80 000043A0 */  sb         $v1, 0x0($v0)
    /* F8784 80107F84 1480023C */  lui        $v0, %hi(D_8013C214)
    /* F8788 80107F88 14C2428C */  lw         $v0, %lo(D_8013C214)($v0)
    /* F878C 80107F8C 00000000 */  nop
    /* F8790 80107F90 000043A0 */  sb         $v1, 0x0($v0)
    /* F8794 80107F94 1480023C */  lui        $v0, %hi(D_8013C218)
    /* F8798 80107F98 18C2428C */  lw         $v0, %lo(D_8013C218)($v0)
    /* F879C 80107F9C 00000000 */  nop
    /* F87A0 80107FA0 00004290 */  lbu        $v0, 0x0($v0)
    /* F87A4 80107FA4 00000000 */  nop
    /* F87A8 80107FA8 07004230 */  andi       $v0, $v0, 0x7
    /* F87AC 80107FAC EDFF4014 */  bnez       $v0, .L80107F64
    /* F87B0 80107FB0 00000000 */   nop
  .L80107FB4:
    /* F87B4 80107FB4 1480033C */  lui        $v1, %hi(D_8013C224)
    /* F87B8 80107FB8 24C26324 */  addiu      $v1, $v1, %lo(D_8013C224)
    /* F87BC 80107FBC 020060A0 */  sb         $zero, 0x2($v1)
    /* F87C0 80107FC0 02006290 */  lbu        $v0, 0x2($v1)
    /* F87C4 80107FC4 00000000 */  nop
    /* F87C8 80107FC8 010062A0 */  sb         $v0, 0x1($v1)
    /* F87CC 80107FCC 1480043C */  lui        $a0, %hi(D_8013C20C)
    /* F87D0 80107FD0 0CC2848C */  lw         $a0, %lo(D_8013C20C)($a0)
    /* F87D4 80107FD4 02000224 */  addiu      $v0, $zero, 0x2
    /* F87D8 80107FD8 000062A0 */  sb         $v0, 0x0($v1)
    /* F87DC 80107FDC 000080A0 */  sb         $zero, 0x0($a0)
    /* F87E0 80107FE0 1480023C */  lui        $v0, %hi(D_8013C218)
    /* F87E4 80107FE4 18C2428C */  lw         $v0, %lo(D_8013C218)($v0)
    /* F87E8 80107FE8 00000000 */  nop
    /* F87EC 80107FEC 000040A0 */  sb         $zero, 0x0($v0)
    /* F87F0 80107FF0 1480033C */  lui        $v1, %hi(D_8013C21C)
    /* F87F4 80107FF4 1CC2638C */  lw         $v1, %lo(D_8013C21C)($v1)
    /* F87F8 80107FF8 25130224 */  addiu      $v0, $zero, 0x1325
    /* F87FC 80107FFC 0800E003 */  jr         $ra
    /* F8800 80108000 000062AC */   sw        $v0, 0x0($v1)
endlabel CD_flush
