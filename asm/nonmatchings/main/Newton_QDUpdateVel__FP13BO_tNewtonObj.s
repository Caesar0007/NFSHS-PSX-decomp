.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_QDUpdateVel__FP13BO_tNewtonObj, 0xE4

glabel Newton_QDUpdateVel__FP13BO_tNewtonObj
    /* 92668 800A1E68 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 9266C 800A1E6C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 92670 800A1E70 21908000 */  addu       $s2, $a0, $zero
    /* 92674 800A1E74 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 92678 800A1E78 1400B1AF */  sw         $s1, 0x14($sp)
    /* 9267C 800A1E7C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 92680 800A1E80 91004292 */  lbu        $v0, 0x91($s2)
    /* 92684 800A1E84 00000000 */  nop
    /* 92688 800A1E88 2A004010 */  beqz       $v0, .L800A1F34
    /* 9268C 800A1E8C 1180023C */   lui       $v0, %hi(D_80113224)
    /* 92690 800A1E90 2432428C */  lw         $v0, %lo(D_80113224)($v0)
    /* 92694 800A1E94 00000000 */  nop
    /* 92698 800A1E98 04004230 */  andi       $v0, $v0, 0x4
    /* 9269C 800A1E9C 16004010 */  beqz       $v0, .L800A1EF8
    /* 926A0 800A1EA0 CCCC0534 */   ori       $a1, $zero, 0xCCCC
    /* 926A4 800A1EA4 AC00448E */  lw         $a0, 0xAC($s2)
    /* 926A8 800A1EA8 B000518E */  lw         $s1, 0xB0($s2)
    /* 926AC 800A1EAC B400508E */  lw         $s0, 0xB4($s2)
    /* 926B0 800A1EB0 83210400 */  sra        $a0, $a0, 6
    /* 926B4 800A1EB4 83891100 */  sra        $s1, $s1, 6
    /* 926B8 800A1EB8 CA90030C */  jal        fixedmult
    /* 926BC 800A1EBC 83811000 */   sra       $s0, $s0, 6
    /* 926C0 800A1EC0 21200002 */  addu       $a0, $s0, $zero
    /* 926C4 800A1EC4 CCCC0534 */  ori        $a1, $zero, 0xCCCC
    /* 926C8 800A1EC8 CA90030C */  jal        fixedmult
    /* 926CC 800A1ECC 21804000 */   addu      $s0, $v0, $zero
    /* 926D0 800A1ED0 A000438E */  lw         $v1, 0xA0($s2)
    /* 926D4 800A1ED4 A800448E */  lw         $a0, 0xA8($s2)
    /* 926D8 800A1ED8 21187000 */  addu       $v1, $v1, $s0
    /* 926DC 800A1EDC A00043AE */  sw         $v1, 0xA0($s2)
    /* 926E0 800A1EE0 A400438E */  lw         $v1, 0xA4($s2)
    /* 926E4 800A1EE4 21208200 */  addu       $a0, $a0, $v0
    /* 926E8 800A1EE8 A80044AE */  sw         $a0, 0xA8($s2)
    /* 926EC 800A1EEC 21187100 */  addu       $v1, $v1, $s1
    /* 926F0 800A1EF0 CD870208 */  j          .L800A1F34
    /* 926F4 800A1EF4 A40043AE */   sw        $v1, 0xA4($s2)
  .L800A1EF8:
    /* 926F8 800A1EF8 AC00428E */  lw         $v0, 0xAC($s2)
    /* 926FC 800A1EFC A000438E */  lw         $v1, 0xA0($s2)
    /* 92700 800A1F00 83110200 */  sra        $v0, $v0, 6
    /* 92704 800A1F04 21186200 */  addu       $v1, $v1, $v0
    /* 92708 800A1F08 B000428E */  lw         $v0, 0xB0($s2)
    /* 9270C 800A1F0C A00043AE */  sw         $v1, 0xA0($s2)
    /* 92710 800A1F10 A400438E */  lw         $v1, 0xA4($s2)
    /* 92714 800A1F14 83110200 */  sra        $v0, $v0, 6
    /* 92718 800A1F18 21186200 */  addu       $v1, $v1, $v0
    /* 9271C 800A1F1C B400428E */  lw         $v0, 0xB4($s2)
    /* 92720 800A1F20 A40043AE */  sw         $v1, 0xA4($s2)
    /* 92724 800A1F24 A800438E */  lw         $v1, 0xA8($s2)
    /* 92728 800A1F28 83110200 */  sra        $v0, $v0, 6
    /* 9272C 800A1F2C 21186200 */  addu       $v1, $v1, $v0
    /* 92730 800A1F30 A80043AE */  sw         $v1, 0xA8($s2)
  .L800A1F34:
    /* 92734 800A1F34 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 92738 800A1F38 1800B28F */  lw         $s2, 0x18($sp)
    /* 9273C 800A1F3C 1400B18F */  lw         $s1, 0x14($sp)
    /* 92740 800A1F40 1000B08F */  lw         $s0, 0x10($sp)
    /* 92744 800A1F44 0800E003 */  jr         $ra
    /* 92748 800A1F48 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Newton_QDUpdateVel__FP13BO_tNewtonObj
