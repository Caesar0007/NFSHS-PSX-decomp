.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _padSendAtLoadInfo, 0x84

glabel _padSendAtLoadInfo
    /* F5DFC 801055FC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F5E00 80105600 1000BFAF */  sw         $ra, 0x10($sp)
    /* F5E04 80105604 46008390 */  lbu        $v1, 0x46($a0)
    /* F5E08 80105608 03000224 */  addiu      $v0, $zero, 0x3
    /* F5E0C 8010560C 10006210 */  beq        $v1, $v0, .L80105650
    /* F5E10 80105610 04006228 */   slti      $v0, $v1, 0x4
    /* F5E14 80105614 05004010 */  beqz       $v0, .L8010562C
    /* F5E18 80105618 02000224 */   addiu     $v0, $zero, 0x2
    /* F5E1C 8010561C 08006210 */  beq        $v1, $v0, .L80105640
    /* F5E20 80105620 00000000 */   nop
    /* F5E24 80105624 9C150408 */  j          .L80105670
    /* F5E28 80105628 00000000 */   nop
  .L8010562C:
    /* F5E2C 8010562C 04000224 */  addiu      $v0, $zero, 0x4
    /* F5E30 80105630 0C006210 */  beq        $v1, $v0, .L80105664
    /* F5E34 80105634 00000000 */   nop
    /* F5E38 80105638 9C150408 */  j          .L80105670
    /* F5E3C 8010563C 00000000 */   nop
  .L80105640:
    /* F5E40 80105640 AB17040C */  jal        func_80105EAC
    /* F5E44 80105644 00000000 */   nop
    /* F5E48 80105648 9C150408 */  j          .L80105670
    /* F5E4C 8010564C 00000000 */   nop
  .L80105650:
    /* F5E50 80105650 E4008590 */  lbu        $a1, 0xE4($a0)
    /* F5E54 80105654 B017040C */  jal        func_80105EC0
    /* F5E58 80105658 00000000 */   nop
    /* F5E5C 8010565C 9C150408 */  j          .L80105670
    /* F5E60 80105660 00000000 */   nop
  .L80105664:
    /* F5E64 80105664 47008590 */  lbu        $a1, 0x47($a0)
    /* F5E68 80105668 C017040C */  jal        func_80105F00
    /* F5E6C 8010566C 00000000 */   nop
  .L80105670:
    /* F5E70 80105670 1000BF8F */  lw         $ra, 0x10($sp)
    /* F5E74 80105674 1800BD27 */  addiu      $sp, $sp, 0x18
    /* F5E78 80105678 0800E003 */  jr         $ra
    /* F5E7C 8010567C 00000000 */   nop
endlabel _padSendAtLoadInfo
