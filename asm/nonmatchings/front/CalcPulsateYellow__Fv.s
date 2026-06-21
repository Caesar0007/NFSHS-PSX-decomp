.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CalcPulsateYellow__Fv, 0x58

glabel CalcPulsateYellow__Fv
    /* C748 8001BF48 1480023C */  lui        $v0, %hi(ticks)
    /* C74C 8001BF4C ACDC438C */  lw         $v1, %lo(ticks)($v0)
    /* C750 8001BF50 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* C754 8001BF54 1000BFAF */  sw         $ra, 0x10($sp)
    /* C758 8001BF58 21106000 */  addu       $v0, $v1, $zero
    /* C75C 8001BF5C 02006104 */  bgez       $v1, .L8001BF68
    /* C760 8001BF60 21206000 */   addu      $a0, $v1, $zero
    /* C764 8001BF64 7F006224 */  addiu      $v0, $v1, 0x7F
  .L8001BF68:
    /* C768 8001BF68 C3290200 */  sra        $a1, $v0, 7
    /* C76C 8001BF6C C0110500 */  sll        $v0, $a1, 7
    /* C770 8001BF70 23288200 */  subu       $a1, $a0, $v0
    /* C774 8001BF74 4100A228 */  slti       $v0, $a1, 0x41
    /* C778 8001BF78 02004014 */  bnez       $v0, .L8001BF84
    /* C77C 8001BF7C 80000224 */   addiu     $v0, $zero, 0x80
    /* C780 8001BF80 23284500 */  subu       $a1, $v0, $a1
  .L8001BF84:
    /* C784 8001BF84 222E010C */  jal        CalcFadeVal__Fii
    /* C788 8001BF88 BEBE0434 */   ori       $a0, $zero, 0xBEBE
    /* C78C 8001BF8C 1000BF8F */  lw         $ra, 0x10($sp)
    /* C790 8001BF90 0580033C */  lui        $v1, %hi(PulsateYellow)
    /* C794 8001BF94 AC1562AC */  sw         $v0, %lo(PulsateYellow)($v1)
    /* C798 8001BF98 0800E003 */  jr         $ra
    /* C79C 8001BF9C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CalcPulsateYellow__Fv
