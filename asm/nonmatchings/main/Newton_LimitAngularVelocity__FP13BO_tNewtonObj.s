.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_LimitAngularVelocity__FP13BO_tNewtonObj, 0x98

glabel Newton_LimitAngularVelocity__FP13BO_tNewtonObj
    /* 93DDC 800A35DC 0100033C */  lui        $v1, (0x18000 >> 16)
    /* 93DE0 800A35E0 1401858C */  lw         $a1, 0x114($a0)
    /* 93DE4 800A35E4 00806334 */  ori        $v1, $v1, (0x18000 & 0xFFFF)
    /* 93DE8 800A35E8 2A106500 */  slt        $v0, $v1, $a1
    /* 93DEC 800A35EC 06004014 */  bnez       $v0, .L800A3608
    /* 93DF0 800A35F0 00000000 */   nop
    /* 93DF4 800A35F4 FEFF033C */  lui        $v1, (0xFFFE8000 >> 16)
    /* 93DF8 800A35F8 00806334 */  ori        $v1, $v1, (0xFFFE8000 & 0xFFFF)
    /* 93DFC 800A35FC 2A10A300 */  slt        $v0, $a1, $v1
    /* 93E00 800A3600 02004010 */  beqz       $v0, .L800A360C
    /* 93E04 800A3604 00000000 */   nop
  .L800A3608:
    /* 93E08 800A3608 140183AC */  sw         $v1, 0x114($a0)
  .L800A360C:
    /* 93E0C 800A360C 0100033C */  lui        $v1, (0x18000 >> 16)
    /* 93E10 800A3610 1801858C */  lw         $a1, 0x118($a0)
    /* 93E14 800A3614 00806334 */  ori        $v1, $v1, (0x18000 & 0xFFFF)
    /* 93E18 800A3618 2A106500 */  slt        $v0, $v1, $a1
    /* 93E1C 800A361C 06004014 */  bnez       $v0, .L800A3638
    /* 93E20 800A3620 00000000 */   nop
    /* 93E24 800A3624 FEFF033C */  lui        $v1, (0xFFFE8000 >> 16)
    /* 93E28 800A3628 00806334 */  ori        $v1, $v1, (0xFFFE8000 & 0xFFFF)
    /* 93E2C 800A362C 2A10A300 */  slt        $v0, $a1, $v1
    /* 93E30 800A3630 02004010 */  beqz       $v0, .L800A363C
    /* 93E34 800A3634 00000000 */   nop
  .L800A3638:
    /* 93E38 800A3638 180183AC */  sw         $v1, 0x118($a0)
  .L800A363C:
    /* 93E3C 800A363C 0100033C */  lui        $v1, (0x18000 >> 16)
    /* 93E40 800A3640 1C01858C */  lw         $a1, 0x11C($a0)
    /* 93E44 800A3644 00806334 */  ori        $v1, $v1, (0x18000 & 0xFFFF)
    /* 93E48 800A3648 2A106500 */  slt        $v0, $v1, $a1
    /* 93E4C 800A364C 06004014 */  bnez       $v0, .L800A3668
    /* 93E50 800A3650 00000000 */   nop
    /* 93E54 800A3654 FEFF033C */  lui        $v1, (0xFFFE8000 >> 16)
    /* 93E58 800A3658 00806334 */  ori        $v1, $v1, (0xFFFE8000 & 0xFFFF)
    /* 93E5C 800A365C 2A10A300 */  slt        $v0, $a1, $v1
    /* 93E60 800A3660 02004010 */  beqz       $v0, .L800A366C
    /* 93E64 800A3664 00000000 */   nop
  .L800A3668:
    /* 93E68 800A3668 1C0183AC */  sw         $v1, 0x11C($a0)
  .L800A366C:
    /* 93E6C 800A366C 0800E003 */  jr         $ra
    /* 93E70 800A3670 00000000 */   nop
endlabel Newton_LimitAngularVelocity__FP13BO_tNewtonObj
