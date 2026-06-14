.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cars_CalcVelDownRoad__FP8Car_tObj, 0x9C

glabel Cars_CalcVelDownRoad__FP8Car_tObj
    /* 7B6E8 8008AEE8 AC00838C */  lw         $v1, 0xAC($a0)
    /* 7B6EC 8008AEEC 00000000 */  nop
    /* 7B6F0 8008AEF0 02006104 */  bgez       $v1, .L8008AEFC
    /* 7B6F4 8008AEF4 00000000 */   nop
    /* 7B6F8 8008AEF8 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008AEFC:
    /* 7B6FC 8008AEFC 5C01828C */  lw         $v0, 0x15C($a0)
    /* 7B700 8008AF00 00000000 */  nop
    /* 7B704 8008AF04 02004104 */  bgez       $v0, .L8008AF10
    /* 7B708 8008AF08 032A0300 */   sra       $a1, $v1, 8
    /* 7B70C 8008AF0C FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008AF10:
    /* 7B710 8008AF10 03120200 */  sra        $v0, $v0, 8
    /* 7B714 8008AF14 1800A200 */  mult       $a1, $v0
    /* 7B718 8008AF18 B000838C */  lw         $v1, 0xB0($a0)
    /* 7B71C 8008AF1C 12280000 */  mflo       $a1
    /* 7B720 8008AF20 02006104 */  bgez       $v1, .L8008AF2C
    /* 7B724 8008AF24 00000000 */   nop
    /* 7B728 8008AF28 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008AF2C:
    /* 7B72C 8008AF2C 6001828C */  lw         $v0, 0x160($a0)
    /* 7B730 8008AF30 00000000 */  nop
    /* 7B734 8008AF34 02004104 */  bgez       $v0, .L8008AF40
    /* 7B738 8008AF38 031A0300 */   sra       $v1, $v1, 8
    /* 7B73C 8008AF3C FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008AF40:
    /* 7B740 8008AF40 03120200 */  sra        $v0, $v0, 8
    /* 7B744 8008AF44 18006200 */  mult       $v1, $v0
    /* 7B748 8008AF48 B400838C */  lw         $v1, 0xB4($a0)
    /* 7B74C 8008AF4C 12300000 */  mflo       $a2
    /* 7B750 8008AF50 02006104 */  bgez       $v1, .L8008AF5C
    /* 7B754 8008AF54 2128A600 */   addu      $a1, $a1, $a2
    /* 7B758 8008AF58 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008AF5C:
    /* 7B75C 8008AF5C 6401828C */  lw         $v0, 0x164($a0)
    /* 7B760 8008AF60 00000000 */  nop
    /* 7B764 8008AF64 02004104 */  bgez       $v0, .L8008AF70
    /* 7B768 8008AF68 031A0300 */   sra       $v1, $v1, 8
    /* 7B76C 8008AF6C FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008AF70:
    /* 7B770 8008AF70 03120200 */  sra        $v0, $v0, 8
    /* 7B774 8008AF74 18006200 */  mult       $v1, $v0
    /* 7B778 8008AF78 12300000 */  mflo       $a2
    /* 7B77C 8008AF7C 0800E003 */  jr         $ra
    /* 7B780 8008AF80 2110A600 */   addu      $v0, $a1, $a2
endlabel Cars_CalcVelDownRoad__FP8Car_tObj
