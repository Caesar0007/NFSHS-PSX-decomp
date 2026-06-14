.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80105DD8, 0x54

glabel func_80105DD8
    /* F65D8 80105DD8 46008390 */  lbu        $v1, 0x46($a0)
    /* F65DC 80105DDC 02000224 */  addiu      $v0, $zero, 0x2
    /* F65E0 80105DE0 05006210 */  beq        $v1, $v0, .L80105DF8
    /* F65E4 80105DE4 03000224 */   addiu     $v0, $zero, 0x3
    /* F65E8 80105DE8 09006210 */  beq        $v1, $v0, .L80105E10
    /* F65EC 80105DEC 4D000224 */   addiu     $v0, $zero, 0x4D
    /* F65F0 80105DF0 89170408 */  j          .L80105E24
    /* F65F4 80105DF4 00000000 */   nop
  .L80105DF8:
    /* F65F8 80105DF8 44000224 */  addiu      $v0, $zero, 0x44
    /* F65FC 80105DFC 360082A0 */  sb         $v0, 0x36($a0)
    /* F6600 80105E00 51008224 */  addiu      $v0, $a0, 0x51
    /* F6604 80105E04 2C0082AC */  sw         $v0, 0x2C($a0)
    /* F6608 80105E08 89170408 */  j          .L80105E24
    /* F660C 80105E0C 350083A0 */   sb        $v1, 0x35($a0)
  .L80105E10:
    /* F6610 80105E10 360082A0 */  sb         $v0, 0x36($a0)
    /* F6614 80105E14 5D008224 */  addiu      $v0, $a0, 0x5D
    /* F6618 80105E18 2C0082AC */  sw         $v0, 0x2C($a0)
    /* F661C 80105E1C 06000224 */  addiu      $v0, $zero, 0x6
    /* F6620 80105E20 350082A0 */  sb         $v0, 0x35($a0)
  .L80105E24:
    /* F6624 80105E24 0800E003 */  jr         $ra
    /* F6628 80105E28 00000000 */   nop
endlabel func_80105DD8
