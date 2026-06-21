.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _padSetMainMode_rcv, 0x60

glabel _padSetMainMode_rcv
    /* F662C 80105E2C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F6630 80105E30 1000BFAF */  sw         $ra, 0x10($sp)
    /* F6634 80105E34 53008290 */  lbu        $v0, 0x53($a0)
    /* F6638 80105E38 00000000 */  nop
    /* F663C 80105E3C 09004010 */  beqz       $v0, .L80105E64
    /* F6640 80105E40 02000224 */   addiu     $v0, $zero, 0x2
    /* F6644 80105E44 46008390 */  lbu        $v1, 0x46($a0)
    /* F6648 80105E48 00000000 */  nop
    /* F664C 80105E4C 03006214 */  bne        $v1, $v0, .L80105E5C
    /* F6650 80105E50 FE000224 */   addiu     $v0, $zero, 0xFE
    /* F6654 80105E54 9F170408 */  j          .L80105E7C
    /* F6658 80105E58 01000224 */   addiu     $v0, $zero, 0x1
  .L80105E5C:
    /* F665C 80105E5C 9E170408 */  j          .L80105E78
    /* F6660 80105E60 460082A0 */   sb        $v0, 0x46($a0)
  .L80105E64:
    /* F6664 80105E64 1380023C */  lui        $v0, %hi(_padFuncClrInfo)
    /* F6668 80105E68 7C7C428C */  lw         $v0, %lo(_padFuncClrInfo)($v0)
    /* F666C 80105E6C 00000000 */  nop
    /* F6670 80105E70 09F84000 */  jalr       $v0
    /* F6674 80105E74 00000000 */   nop
  .L80105E78:
    /* F6678 80105E78 21100000 */  addu       $v0, $zero, $zero
  .L80105E7C:
    /* F667C 80105E7C 1000BF8F */  lw         $ra, 0x10($sp)
    /* F6680 80105E80 1800BD27 */  addiu      $sp, $sp, 0x18
    /* F6684 80105E84 0800E003 */  jr         $ra
    /* F6688 80105E88 00000000 */   nop
endlabel _padSetMainMode_rcv
