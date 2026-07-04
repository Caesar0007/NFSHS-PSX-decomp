.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Flare_LensFlare__FP7DVECTORP15Draw_FlareCache, 0x664

glabel Flare_LensFlare__FP7DVECTORP15Draw_FlareCache
    /* BF36C 800CEB6C 48FFBD27 */  addiu      $sp, $sp, -0xB8
    /* BF370 800CEB70 B400BFAF */  sw         $ra, 0xB4($sp)
    /* BF374 800CEB74 B000BEAF */  sw         $fp, 0xB0($sp)
    /* BF378 800CEB78 AC00B7AF */  sw         $s7, 0xAC($sp)
    /* BF37C 800CEB7C A800B6AF */  sw         $s6, 0xA8($sp)
    /* BF380 800CEB80 A400B5AF */  sw         $s5, 0xA4($sp)
    /* BF384 800CEB84 A000B4AF */  sw         $s4, 0xA0($sp)
    /* BF388 800CEB88 9C00B3AF */  sw         $s3, 0x9C($sp)
    /* BF38C 800CEB8C 9800B2AF */  sw         $s2, 0x98($sp)
    /* BF390 800CEB90 9400B1AF */  sw         $s1, 0x94($sp)
    /* BF394 800CEB94 9000B0AF */  sw         $s0, 0x90($sp)
    /* BF398 800CEB98 B800A4AF */  sw         $a0, 0xB8($sp)
    /* BF39C 800CEB9C 0800A28C */  lw         $v0, 0x8($a1)
    /* BF3A0 800CEBA0 0400A38C */  lw         $v1, 0x4($a1)
    /* BF3A4 800CEBA4 00FC4224 */  addiu      $v0, $v0, -0x400
    /* BF3A8 800CEBA8 2B186200 */  sltu       $v1, $v1, $v0
    /* BF3AC 800CEBAC 7C016010 */  beqz       $v1, .L800CF1A0
    /* BF3B0 800CEBB0 FF00073C */   lui       $a3, (0xFFFFFF >> 16)
    /* BF3B4 800CEBB4 FFFFE734 */  ori        $a3, $a3, (0xFFFFFF & 0xFFFF)
    /* BF3B8 800CEBB8 2000A427 */  addiu      $a0, $sp, 0x20
    /* BF3BC 800CEBBC 3000A527 */  addiu      $a1, $sp, 0x30
    /* BF3C0 800CEBC0 21800000 */  addu       $s0, $zero, $zero
    /* BF3C4 800CEBC4 B800AF8F */  lw         $t7, 0xB8($sp)
    /* BF3C8 800CEBC8 1480063C */  lui        $a2, %hi(Draw_gViewOtSize)
    /* BF3CC 800CEBCC B0D7C68C */  lw         $a2, %lo(Draw_gViewOtSize)($a2)
    /* BF3D0 800CEBD0 0000E285 */  lh         $v0, 0x0($t7)
    /* BF3D4 800CEBD4 0200E385 */  lh         $v1, 0x2($t7)
    /* BF3D8 800CEBD8 FEFFC624 */  addiu      $a2, $a2, -0x2
    /* BF3DC 800CEBDC 3000A7AF */  sw         $a3, 0x30($sp)
    /* BF3E0 800CEBE0 21F04000 */  addu       $fp, $v0, $zero
    /* BF3E4 800CEBE4 FEFFC727 */  addiu      $a3, $fp, -0x2
    /* BF3E8 800CEBE8 21B86000 */  addu       $s7, $v1, $zero
    /* BF3EC 800CEBEC FEFFE226 */  addiu      $v0, $s7, -0x2
    /* BF3F0 800CEBF0 0300C327 */  addiu      $v1, $fp, 0x3
    /* BF3F4 800CEBF4 2200A2A7 */  sh         $v0, 0x22($sp)
    /* BF3F8 800CEBF8 2600A2A7 */  sh         $v0, 0x26($sp)
    /* BF3FC 800CEBFC 0300E226 */  addiu      $v0, $s7, 0x3
    /* BF400 800CEC00 2400A3A7 */  sh         $v1, 0x24($sp)
    /* BF404 800CEC04 2C00A3A7 */  sh         $v1, 0x2C($sp)
    /* BF408 800CEC08 2118D703 */  addu       $v1, $fp, $s7
    /* BF40C 800CEC0C C0880300 */  sll        $s1, $v1, 3
    /* BF410 800CEC10 2A00A2A7 */  sh         $v0, 0x2A($sp)
    /* BF414 800CEC14 2E00A2A7 */  sh         $v0, 0x2E($sp)
    /* BF418 800CEC18 40100300 */  sll        $v0, $v1, 1
    /* BF41C 800CEC1C 21104300 */  addu       $v0, $v0, $v1
    /* BF420 800CEC20 40100200 */  sll        $v0, $v0, 1
    /* BF424 800CEC24 2000A7A7 */  sh         $a3, 0x20($sp)
    /* BF428 800CEC28 2800A7A7 */  sh         $a3, 0x28($sp)
    /* BF42C 800CEC2C 3139030C */  jal        Flare_QuadNotTransparent__FPlP7CVECTORi
    /* BF430 800CEC30 8000A2AF */   sw        $v0, 0x80($sp)
    /* BF434 800CEC34 40010224 */  addiu      $v0, $zero, 0x140
    /* BF438 800CEC38 23105E00 */  subu       $v0, $v0, $fp
    /* BF43C 800CEC3C 7800A2AF */  sw         $v0, 0x78($sp)
    /* BF440 800CEC40 F0000224 */  addiu      $v0, $zero, 0xF0
    /* BF444 800CEC44 23105700 */  subu       $v0, $v0, $s7
    /* BF448 800CEC48 21A80002 */  addu       $s5, $s0, $zero
    /* BF44C 800CEC4C 7C00A2AF */  sw         $v0, 0x7C($sp)
    /* BF450 800CEC50 1280023C */  lui        $v0, %hi(gFlare_LensFlare)
    /* BF454 800CEC54 78024324 */  addiu      $v1, $v0, %lo(gFlare_LensFlare)
    /* BF458 800CEC58 78024494 */  lhu        $a0, %lo(gFlare_LensFlare)($v0)
    /* BF45C 800CEC5C 02006594 */  lhu        $a1, 0x2($v1)
    /* BF460 800CEC60 FF7F0624 */  addiu      $a2, $zero, 0x7FFF
    /* BF464 800CEC64 78025EA4 */  sh         $fp, %lo(gFlare_LensFlare)($v0)
    /* BF468 800CEC68 01000224 */  addiu      $v0, $zero, 0x1
    /* BF46C 800CEC6C 020077A4 */  sh         $s7, 0x2($v1)
    /* BF470 800CEC70 7C0062A0 */  sb         $v0, 0x7C($v1)
    /* BF474 800CEC74 080064A4 */  sh         $a0, 0x8($v1)
    /* BF478 800CEC78 0A0065A4 */  sh         $a1, 0xA($v1)
  .L800CEC7C:
    /* BF47C 800CEC7C 10006294 */  lhu        $v0, 0x10($v1)
    /* BF480 800CEC80 00000000 */  nop
    /* BF484 800CEC84 FF7F4230 */  andi       $v0, $v0, 0x7FFF
    /* BF488 800CEC88 02004614 */  bne        $v0, $a2, .L800CEC94
    /* BF48C 800CEC8C 00000000 */   nop
    /* BF490 800CEC90 0100B526 */  addiu      $s5, $s5, 0x1
  .L800CEC94:
    /* BF494 800CEC94 01001026 */  addiu      $s0, $s0, 0x1
    /* BF498 800CEC98 1900022A */  slti       $v0, $s0, 0x19
    /* BF49C 800CEC9C F7FF4014 */  bnez       $v0, .L800CEC7C
    /* BF4A0 800CECA0 02006324 */   addiu     $v1, $v1, 0x2
    /* BF4A4 800CECA4 FF00B632 */  andi       $s6, $s5, 0xFF
    /* BF4A8 800CECA8 3D01C012 */  beqz       $s6, .L800CF1A0
    /* BF4AC 800CECAC 5800B027 */   addiu     $s0, $sp, 0x58
    /* BF4B0 800CECB0 21200002 */  addu       $a0, $s0, $zero
    /* BF4B4 800CECB4 C0111600 */  sll        $v0, $s6, 7
    /* BF4B8 800CECB8 1280133C */  lui        $s3, %hi(D_80123334)
    /* BF4BC 800CECBC 80A91600 */  sll        $s5, $s6, 6
    /* BF4C0 800CECC0 3800A2AF */  sw         $v0, 0x38($sp)
    /* BF4C4 800CECC4 3433628E */  lw         $v0, %lo(D_80123334)($s3)
    /* BF4C8 800CECC8 4000B5AF */  sw         $s5, 0x40($sp)
    /* BF4CC 800CECCC 4800A0AF */  sw         $zero, 0x48($sp)
    /* BF4D0 800CECD0 3C00A0AF */  sw         $zero, 0x3C($sp)
    /* BF4D4 800CECD4 4400A0AF */  sw         $zero, 0x44($sp)
    /* BF4D8 800CECD8 241382AF */  sw         $v0, %gp_rel(gfrgb2)($gp)
    /* BF4DC 800CECDC 7E2F030C */  jal        Flare_IdentMatrix__FP6MATRIX
    /* BF4E0 800CECE0 34337326 */   addiu     $s3, $s3, %lo(D_80123334)
    /* BF4E4 800CECE4 21202002 */  addu       $a0, $s1, $zero
    /* BF4E8 800CECE8 4BCC030C */  jal        RotMatrixZ
    /* BF4EC 800CECEC 21280002 */   addu      $a1, $s0, $zero
    /* BF4F0 800CECF0 3800B427 */  addiu      $s4, $sp, 0x38
    /* BF4F4 800CECF4 00008C8E */  lw         $t4, 0x0($s4)
    /* BF4F8 800CECF8 04008D8E */  lw         $t5, 0x4($s4)
    /* BF4FC 800CECFC 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* BF500 800CED00 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* BF504 800CED04 08008C8E */  lw         $t4, 0x8($s4)
    /* BF508 800CED08 0C008D8E */  lw         $t5, 0xC($s4)
    /* BF50C 800CED0C 10008E8E */  lw         $t6, 0x10($s4)
    /* BF510 800CED10 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* BF514 800CED14 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* BF518 800CED18 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* BF51C 800CED1C 00000C96 */  lhu        $t4, 0x0($s0)
    /* BF520 800CED20 06000D96 */  lhu        $t5, 0x6($s0)
    /* BF524 800CED24 0C000E96 */  lhu        $t6, 0xC($s0)
    /* BF528 800CED28 00488C48 */  mtc2       $t4, $9 /* handwritten instruction */
    /* BF52C 800CED2C 00508D48 */  mtc2       $t5, $10 /* handwritten instruction */
    /* BF530 800CED30 00588E48 */  mtc2       $t6, $11 /* handwritten instruction */
    /* BF534 800CED34 00000000 */  nop
    /* BF538 800CED38 00000000 */  nop
    /* BF53C 800CED3C 12E0494A */  .word 0x4A49E012  /* mvmva      1, 0, 3, 3, 0 */
    /* BF540 800CED40 00480C48 */  mfc2       $t4, $9 /* handwritten instruction */
    /* BF544 800CED44 00500D48 */  mfc2       $t5, $10 /* handwritten instruction */
    /* BF548 800CED48 00580E48 */  mfc2       $t6, $11 /* handwritten instruction */
    /* BF54C 800CED4C 00000CA6 */  sh         $t4, 0x0($s0)
    /* BF550 800CED50 06000DA6 */  sh         $t5, 0x6($s0)
    /* BF554 800CED54 0C000EA6 */  sh         $t6, 0xC($s0)
    /* BF558 800CED58 5A00B227 */  addiu      $s2, $sp, 0x5A
    /* BF55C 800CED5C 00004C96 */  lhu        $t4, 0x0($s2)
    /* BF560 800CED60 06004D96 */  lhu        $t5, 0x6($s2)
    /* BF564 800CED64 0C004E96 */  lhu        $t6, 0xC($s2)
    /* BF568 800CED68 00488C48 */  mtc2       $t4, $9 /* handwritten instruction */
    /* BF56C 800CED6C 00508D48 */  mtc2       $t5, $10 /* handwritten instruction */
    /* BF570 800CED70 00588E48 */  mtc2       $t6, $11 /* handwritten instruction */
    /* BF574 800CED74 00000000 */  nop
    /* BF578 800CED78 00000000 */  nop
    /* BF57C 800CED7C 12E0494A */  .word 0x4A49E012  /* mvmva      1, 0, 3, 3, 0 */
    /* BF580 800CED80 00480C48 */  mfc2       $t4, $9 /* handwritten instruction */
    /* BF584 800CED84 00500D48 */  mfc2       $t5, $10 /* handwritten instruction */
    /* BF588 800CED88 00580E48 */  mfc2       $t6, $11 /* handwritten instruction */
    /* BF58C 800CED8C 00004CA6 */  sh         $t4, 0x0($s2)
    /* BF590 800CED90 06004DA6 */  sh         $t5, 0x6($s2)
    /* BF594 800CED94 0C004EA6 */  sh         $t6, 0xC($s2)
    /* BF598 800CED98 5C00B127 */  addiu      $s1, $sp, 0x5C
    /* BF59C 800CED9C 00002C96 */  lhu        $t4, 0x0($s1)
    /* BF5A0 800CEDA0 06002D96 */  lhu        $t5, 0x6($s1)
    /* BF5A4 800CEDA4 0C002E96 */  lhu        $t6, 0xC($s1)
    /* BF5A8 800CEDA8 00488C48 */  mtc2       $t4, $9 /* handwritten instruction */
    /* BF5AC 800CEDAC 00508D48 */  mtc2       $t5, $10 /* handwritten instruction */
    /* BF5B0 800CEDB0 00588E48 */  mtc2       $t6, $11 /* handwritten instruction */
    /* BF5B4 800CEDB4 00000000 */  nop
    /* BF5B8 800CEDB8 00000000 */  nop
    /* BF5BC 800CEDBC 12E0494A */  .word 0x4A49E012  /* mvmva      1, 0, 3, 3, 0 */
    /* BF5C0 800CEDC0 00480C48 */  mfc2       $t4, $9 /* handwritten instruction */
    /* BF5C4 800CEDC4 00500D48 */  mfc2       $t5, $10 /* handwritten instruction */
    /* BF5C8 800CEDC8 00580E48 */  mfc2       $t6, $11 /* handwritten instruction */
    /* BF5CC 800CEDCC 00002CA6 */  sh         $t4, 0x0($s1)
    /* BF5D0 800CEDD0 06002DA6 */  sh         $t5, 0x6($s1)
    /* BF5D4 800CEDD4 0C002EA6 */  sh         $t6, 0xC($s1)
    /* BF5D8 800CEDD8 00000C8E */  lw         $t4, 0x0($s0)
    /* BF5DC 800CEDDC 04000D8E */  lw         $t5, 0x4($s0)
    /* BF5E0 800CEDE0 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* BF5E4 800CEDE4 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* BF5E8 800CEDE8 08000C8E */  lw         $t4, 0x8($s0)
    /* BF5EC 800CEDEC 0C000D8E */  lw         $t5, 0xC($s0)
    /* BF5F0 800CEDF0 10000E8E */  lw         $t6, 0x10($s0)
    /* BF5F4 800CEDF4 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* BF5F8 800CEDF8 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* BF5FC 800CEDFC 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* BF600 800CEE00 B800A48F */  lw         $a0, 0xB8($sp)
    /* BF604 800CEE04 EE30030C */  jal        Flare_Spikes__FPli
    /* BF608 800CEE08 21280000 */   addu      $a1, $zero, $zero
    /* BF60C 800CEE0C 21200002 */  addu       $a0, $s0, $zero
    /* BF610 800CEE10 7E2F030C */  jal        Flare_IdentMatrix__FP6MATRIX
    /* BF614 800CEE14 3800B5AF */   sw        $s5, 0x38($sp)
    /* BF618 800CEE18 8000A48F */  lw         $a0, 0x80($sp)
    /* BF61C 800CEE1C 4BCC030C */  jal        RotMatrixZ
    /* BF620 800CEE20 21280002 */   addu      $a1, $s0, $zero
    /* BF624 800CEE24 00008C8E */  lw         $t4, 0x0($s4)
    /* BF628 800CEE28 04008D8E */  lw         $t5, 0x4($s4)
    /* BF62C 800CEE2C 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* BF630 800CEE30 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* BF634 800CEE34 08008C8E */  lw         $t4, 0x8($s4)
    /* BF638 800CEE38 0C008D8E */  lw         $t5, 0xC($s4)
    /* BF63C 800CEE3C 10008E8E */  lw         $t6, 0x10($s4)
    /* BF640 800CEE40 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* BF644 800CEE44 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* BF648 800CEE48 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* BF64C 800CEE4C 00000C96 */  lhu        $t4, 0x0($s0)
    /* BF650 800CEE50 06000D96 */  lhu        $t5, 0x6($s0)
    /* BF654 800CEE54 0C000E96 */  lhu        $t6, 0xC($s0)
    /* BF658 800CEE58 00488C48 */  mtc2       $t4, $9 /* handwritten instruction */
    /* BF65C 800CEE5C 00508D48 */  mtc2       $t5, $10 /* handwritten instruction */
    /* BF660 800CEE60 00588E48 */  mtc2       $t6, $11 /* handwritten instruction */
    /* BF664 800CEE64 00000000 */  nop
    /* BF668 800CEE68 00000000 */  nop
    /* BF66C 800CEE6C 12E0494A */  .word 0x4A49E012  /* mvmva      1, 0, 3, 3, 0 */
    /* BF670 800CEE70 00480C48 */  mfc2       $t4, $9 /* handwritten instruction */
    /* BF674 800CEE74 00500D48 */  mfc2       $t5, $10 /* handwritten instruction */
    /* BF678 800CEE78 00580E48 */  mfc2       $t6, $11 /* handwritten instruction */
    /* BF67C 800CEE7C 00000CA6 */  sh         $t4, 0x0($s0)
    /* BF680 800CEE80 06000DA6 */  sh         $t5, 0x6($s0)
    /* BF684 800CEE84 0C000EA6 */  sh         $t6, 0xC($s0)
    /* BF688 800CEE88 00004C96 */  lhu        $t4, 0x0($s2)
    /* BF68C 800CEE8C 06004D96 */  lhu        $t5, 0x6($s2)
    /* BF690 800CEE90 0C004E96 */  lhu        $t6, 0xC($s2)
    /* BF694 800CEE94 00488C48 */  mtc2       $t4, $9 /* handwritten instruction */
    /* BF698 800CEE98 00508D48 */  mtc2       $t5, $10 /* handwritten instruction */
    /* BF69C 800CEE9C 00588E48 */  mtc2       $t6, $11 /* handwritten instruction */
    /* BF6A0 800CEEA0 00000000 */  nop
    /* BF6A4 800CEEA4 00000000 */  nop
    /* BF6A8 800CEEA8 12E0494A */  .word 0x4A49E012  /* mvmva      1, 0, 3, 3, 0 */
    /* BF6AC 800CEEAC 00480C48 */  mfc2       $t4, $9 /* handwritten instruction */
    /* BF6B0 800CEEB0 00500D48 */  mfc2       $t5, $10 /* handwritten instruction */
    /* BF6B4 800CEEB4 00580E48 */  mfc2       $t6, $11 /* handwritten instruction */
    /* BF6B8 800CEEB8 00004CA6 */  sh         $t4, 0x0($s2)
    /* BF6BC 800CEEBC 06004DA6 */  sh         $t5, 0x6($s2)
    /* BF6C0 800CEEC0 0C004EA6 */  sh         $t6, 0xC($s2)
    /* BF6C4 800CEEC4 00002C96 */  lhu        $t4, 0x0($s1)
    /* BF6C8 800CEEC8 06002D96 */  lhu        $t5, 0x6($s1)
    /* BF6CC 800CEECC 0C002E96 */  lhu        $t6, 0xC($s1)
    /* BF6D0 800CEED0 00488C48 */  mtc2       $t4, $9 /* handwritten instruction */
    /* BF6D4 800CEED4 00508D48 */  mtc2       $t5, $10 /* handwritten instruction */
    /* BF6D8 800CEED8 00588E48 */  mtc2       $t6, $11 /* handwritten instruction */
    /* BF6DC 800CEEDC 00000000 */  nop
    /* BF6E0 800CEEE0 00000000 */  nop
    /* BF6E4 800CEEE4 12E0494A */  .word 0x4A49E012  /* mvmva      1, 0, 3, 3, 0 */
    /* BF6E8 800CEEE8 00480C48 */  mfc2       $t4, $9 /* handwritten instruction */
    /* BF6EC 800CEEEC 00500D48 */  mfc2       $t5, $10 /* handwritten instruction */
    /* BF6F0 800CEEF0 00580E48 */  mfc2       $t6, $11 /* handwritten instruction */
    /* BF6F4 800CEEF4 00002CA6 */  sh         $t4, 0x0($s1)
    /* BF6F8 800CEEF8 06002DA6 */  sh         $t5, 0x6($s1)
    /* BF6FC 800CEEFC 0C002EA6 */  sh         $t6, 0xC($s1)
    /* BF700 800CEF00 00000C8E */  lw         $t4, 0x0($s0)
    /* BF704 800CEF04 04000D8E */  lw         $t5, 0x4($s0)
    /* BF708 800CEF08 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* BF70C 800CEF0C 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* BF710 800CEF10 08000C8E */  lw         $t4, 0x8($s0)
    /* BF714 800CEF14 0C000D8E */  lw         $t5, 0xC($s0)
    /* BF718 800CEF18 10000E8E */  lw         $t6, 0x10($s0)
    /* BF71C 800CEF1C 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* BF720 800CEF20 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* BF724 800CEF24 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* BF728 800CEF28 B800A48F */  lw         $a0, 0xB8($sp)
    /* BF72C 800CEF2C EE30030C */  jal        Flare_Spikes__FPli
    /* BF730 800CEF30 21280000 */   addu      $a1, $zero, $zero
    /* BF734 800CEF34 21800000 */  addu       $s0, $zero, $zero
    /* BF738 800CEF38 1280023C */  lui        $v0, %hi(gFlare_LensFlare)
    /* BF73C 800CEF3C 78024224 */  addiu      $v0, $v0, %lo(gFlare_LensFlare)
    /* BF740 800CEF40 21A04000 */  addu       $s4, $v0, $zero
    /* BF744 800CEF44 FFFF1234 */  ori        $s2, $zero, 0xFFFF
    /* BF748 800CEF48 21A8C002 */  addu       $s5, $s6, $zero
    /* BF74C 800CEF4C EB51113C */  lui        $s1, (0x51EB851F >> 16)
    /* BF750 800CEF50 7800838E */  lw         $v1, 0x78($s4)
    /* BF754 800CEF54 0400628E */  lw         $v0, 0x4($s3)
    /* BF758 800CEF58 1F853136 */  ori        $s1, $s1, (0x51EB851F & 0xFFFF)
    /* BF75C 800CEF5C 080062AC */  sw         $v0, 0x8($v1)
  .L800CEF60:
    /* BF760 800CEF60 0900022A */  slti       $v0, $s0, 0x9
    /* BF764 800CEF64 72004010 */  beqz       $v0, .L800CF130
    /* BF768 800CEF68 00111000 */   sll       $v0, $s0, 4
    /* BF76C 800CEF6C 7800838E */  lw         $v1, 0x78($s4)
    /* BF770 800CEF70 00000000 */  nop
    /* BF774 800CEF74 21406200 */  addu       $t0, $v1, $v0
    /* BF778 800CEF78 0000038D */  lw         $v1, 0x0($t0)
    /* BF77C 800CEF7C 01000F3C */  lui        $t7, (0x10000 >> 16)
    /* BF780 800CEF80 2310E301 */  subu       $v0, $t7, $v1
    /* BF784 800CEF84 18005E00 */  mult       $v0, $fp
    /* BF788 800CEF88 12100000 */  mflo       $v0
    /* BF78C 800CEF8C 7800AF8F */  lw         $t7, 0x78($sp)
    /* BF790 800CEF90 00000000 */  nop
    /* BF794 800CEF94 18006F00 */  mult       $v1, $t7
    /* BF798 800CEF98 12180000 */  mflo       $v1
    /* BF79C 800CEF9C 21104300 */  addu       $v0, $v0, $v1
    /* BF7A0 800CEFA0 02004104 */  bgez       $v0, .L800CEFAC
    /* BF7A4 800CEFA4 00000000 */   nop
    /* BF7A8 800CEFA8 21105200 */  addu       $v0, $v0, $s2
  .L800CEFAC:
    /* BF7AC 800CEFAC 03140200 */  sra        $v0, $v0, 16
    /* BF7B0 800CEFB0 1800A2A7 */  sh         $v0, 0x18($sp)
    /* BF7B4 800CEFB4 0000038D */  lw         $v1, 0x0($t0)
    /* BF7B8 800CEFB8 01000F3C */  lui        $t7, (0x10000 >> 16)
    /* BF7BC 800CEFBC 2310E301 */  subu       $v0, $t7, $v1
    /* BF7C0 800CEFC0 18005700 */  mult       $v0, $s7
    /* BF7C4 800CEFC4 12100000 */  mflo       $v0
    /* BF7C8 800CEFC8 7C00AF8F */  lw         $t7, 0x7C($sp)
    /* BF7CC 800CEFCC 00000000 */  nop
    /* BF7D0 800CEFD0 18006F00 */  mult       $v1, $t7
    /* BF7D4 800CEFD4 12180000 */  mflo       $v1
    /* BF7D8 800CEFD8 21104300 */  addu       $v0, $v0, $v1
    /* BF7DC 800CEFDC 02004104 */  bgez       $v0, .L800CEFE8
    /* BF7E0 800CEFE0 00000000 */   nop
    /* BF7E4 800CEFE4 21105200 */  addu       $v0, $v0, $s2
  .L800CEFE8:
    /* BF7E8 800CEFE8 03140200 */  sra        $v0, $v0, 16
    /* BF7EC 800CEFEC 1A00A2A7 */  sh         $v0, 0x1A($sp)
    /* BF7F0 800CEFF0 7400838E */  lw         $v1, 0x74($s4)
    /* BF7F4 800CEFF4 0400028D */  lw         $v0, 0x4($t0)
    /* BF7F8 800CEFF8 00000000 */  nop
    /* BF7FC 800CEFFC 18006200 */  mult       $v1, $v0
    /* BF800 800CF000 12100000 */  mflo       $v0
    /* BF804 800CF004 03004104 */  bgez       $v0, .L800CF014
    /* BF808 800CF008 033C0200 */   sra       $a3, $v0, 16
    /* BF80C 800CF00C 21105200 */  addu       $v0, $v0, $s2
    /* BF810 800CF010 033C0200 */  sra        $a3, $v0, 16
  .L800CF014:
    /* BF814 800CF014 0400E228 */  slti       $v0, $a3, 0x4
    /* BF818 800CF018 43004014 */  bnez       $v0, .L800CF128
    /* BF81C 800CF01C 2130E000 */   addu      $a2, $a3, $zero
    /* BF820 800CF020 08000291 */  lbu        $v0, 0x8($t0)
    /* BF824 800CF024 00000000 */  nop
    /* BF828 800CF028 18005500 */  mult       $v0, $s5
    /* BF82C 800CF02C 12180000 */  mflo       $v1
    /* BF830 800CF030 00000000 */  nop
    /* BF834 800CF034 00000000 */  nop
    /* BF838 800CF038 18007100 */  mult       $v1, $s1
    /* BF83C 800CF03C 10180000 */  mfhi       $v1
    /* BF840 800CF040 C3100300 */  sra        $v0, $v1, 3
    /* BF844 800CF044 2000A2A3 */  sb         $v0, 0x20($sp)
    /* BF848 800CF048 09000291 */  lbu        $v0, 0x9($t0)
    /* BF84C 800CF04C 00000000 */  nop
    /* BF850 800CF050 18005500 */  mult       $v0, $s5
    /* BF854 800CF054 12180000 */  mflo       $v1
    /* BF858 800CF058 00000000 */  nop
    /* BF85C 800CF05C 00000000 */  nop
    /* BF860 800CF060 18007100 */  mult       $v1, $s1
    /* BF864 800CF064 10180000 */  mfhi       $v1
    /* BF868 800CF068 C3100300 */  sra        $v0, $v1, 3
    /* BF86C 800CF06C 2100A2A3 */  sb         $v0, 0x21($sp)
    /* BF870 800CF070 0A000291 */  lbu        $v0, 0xA($t0)
    /* BF874 800CF074 00000000 */  nop
    /* BF878 800CF078 18005500 */  mult       $v0, $s5
    /* BF87C 800CF07C 12180000 */  mflo       $v1
    /* BF880 800CF080 00000000 */  nop
    /* BF884 800CF084 00000000 */  nop
    /* BF888 800CF088 18007100 */  mult       $v1, $s1
    /* BF88C 800CF08C 10180000 */  mfhi       $v1
    /* BF890 800CF090 C3100300 */  sra        $v0, $v1, 3
    /* BF894 800CF094 2200A2A3 */  sb         $v0, 0x22($sp)
    /* BF898 800CF098 0C000391 */  lbu        $v1, 0xC($t0)
    /* BF89C 800CF09C 00000000 */  nop
    /* BF8A0 800CF0A0 0500622C */  sltiu      $v0, $v1, 0x5
    /* BF8A4 800CF0A4 20004010 */  beqz       $v0, .L800CF128
    /* BF8A8 800CF0A8 0580023C */   lui       $v0, %hi(jtbl_80056894)
    /* BF8AC 800CF0AC 94684224 */  addiu      $v0, $v0, %lo(jtbl_80056894)
    /* BF8B0 800CF0B0 80180300 */  sll        $v1, $v1, 2
    /* BF8B4 800CF0B4 21186200 */  addu       $v1, $v1, $v0
    /* BF8B8 800CF0B8 0000628C */  lw         $v0, 0x0($v1)
    /* BF8BC 800CF0BC 00000000 */  nop
    /* BF8C0 800CF0C0 08004000 */  jr         $v0
    /* BF8C4 800CF0C4 00000000 */   nop
  jlabel .L800CF0C8
    /* BF8C8 800CF0C8 1800A427 */  addiu      $a0, $sp, 0x18
    /* BF8CC 800CF0CC 0C000291 */  lbu        $v0, 0xC($t0)
    /* BF8D0 800CF0D0 2000A527 */  addiu      $a1, $sp, 0x20
    /* BF8D4 800CF0D4 1400A0AF */  sw         $zero, 0x14($sp)
    /* BF8D8 800CF0D8 BE39030C */  jal        Flare_SingleColorTex__FP7DVECTORP7CVECTORiici
    /* BF8DC 800CF0DC 1000A2AF */   sw        $v0, 0x10($sp)
    /* BF8E0 800CF0E0 D83B0308 */  j          .L800CEF60
    /* BF8E4 800CF0E4 01001026 */   addiu     $s0, $s0, 0x1
  jlabel .L800CF0E8
    /* BF8E8 800CF0E8 1000A0AF */  sw         $zero, 0x10($sp)
    /* BF8EC 800CF0EC 1800A427 */  addiu      $a0, $sp, 0x18
    /* BF8F0 800CF0F0 E739030C */  jal        Flare_SingleColorHex__FP7DVECTORP7CVECTORiii
    /* BF8F4 800CF0F4 2000A527 */   addiu     $a1, $sp, 0x20
    /* BF8F8 800CF0F8 D83B0308 */  j          .L800CEF60
    /* BF8FC 800CF0FC 01001026 */   addiu     $s0, $s0, 0x1
  jlabel .L800CF100
    /* BF900 800CF100 1000A0AF */  sw         $zero, 0x10($sp)
    /* BF904 800CF104 1800A427 */  addiu      $a0, $sp, 0x18
    /* BF908 800CF108 2C3A030C */  jal        Flare_SingleColorOct__FP7DVECTORP7CVECTORiii
    /* BF90C 800CF10C 2000A527 */   addiu     $a1, $sp, 0x20
    /* BF910 800CF110 D83B0308 */  j          .L800CEF60
    /* BF914 800CF114 01001026 */   addiu     $s0, $s0, 0x1
  jlabel .L800CF118
    /* BF918 800CF118 1000A0AF */  sw         $zero, 0x10($sp)
    /* BF91C 800CF11C 1800A427 */  addiu      $a0, $sp, 0x18
    /* BF920 800CF120 623A030C */  jal        Flare_SingleColorOctRing__FP7DVECTORP7CVECTORiii
    /* BF924 800CF124 2000A527 */   addiu     $a1, $sp, 0x20
  .L800CF128:
    /* BF928 800CF128 D83B0308 */  j          .L800CEF60
    /* BF92C 800CF12C 01001026 */   addiu     $s0, $s0, 0x1
  .L800CF130:
    /* BF930 800CF130 801F0B3C */  lui        $t3, (0x1F800004 >> 16)
    /* BF934 800CF134 04006B35 */  ori        $t3, $t3, (0x1F800004 & 0xFFFF)
    /* BF938 800CF138 FF00093C */  lui        $t1, (0xFFFFFF >> 16)
    /* BF93C 800CF13C FFFF2935 */  ori        $t1, $t1, (0xFFFFFF & 0xFFFF)
    /* BF940 800CF140 21280000 */  addu       $a1, $zero, $zero
    /* BF944 800CF144 2130A000 */  addu       $a2, $a1, $zero
    /* BF948 800CF148 20010724 */  addiu      $a3, $zero, 0x120
    /* BF94C 800CF14C 80400600 */  sll        $t0, $a2, 2
    /* BF950 800CF150 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* BF954 800CF154 801F023C */  lui        $v0, (0x1F800000 >> 16)
    /* BF958 800CF158 0000428C */  lw         $v0, (0x1F800000 & 0xFFFF)($v0)
    /* BF95C 800CF15C 0000648D */  lw         $a0, 0x0($t3)
    /* BF960 800CF160 21400201 */  addu       $t0, $t0, $v0
    /* BF964 800CF164 0000838C */  lw         $v1, 0x0($a0)
    /* BF968 800CF168 0000028D */  lw         $v0, 0x0($t0)
    /* BF96C 800CF16C 24186A00 */  and        $v1, $v1, $t2
    /* BF970 800CF170 24104900 */  and        $v0, $v0, $t1
    /* BF974 800CF174 25186200 */  or         $v1, $v1, $v0
    /* BF978 800CF178 000083AC */  sw         $v1, 0x0($a0)
    /* BF97C 800CF17C 0000028D */  lw         $v0, 0x0($t0)
    /* BF980 800CF180 0C008324 */  addiu      $v1, $a0, 0xC
    /* BF984 800CF184 000063AD */  sw         $v1, 0x0($t3)
    /* BF988 800CF188 24188900 */  and        $v1, $a0, $t1
    /* BF98C 800CF18C 24104A00 */  and        $v0, $v0, $t2
    /* BF990 800CF190 25104300 */  or         $v0, $v0, $v1
    /* BF994 800CF194 000002AD */  sw         $v0, 0x0($t0)
    /* BF998 800CF198 EFB8030C */  jal        SetDrawMode
    /* BF99C 800CF19C 1000A0AF */   sw        $zero, 0x10($sp)
  .L800CF1A0:
    /* BF9A0 800CF1A0 B400BF8F */  lw         $ra, 0xB4($sp)
    /* BF9A4 800CF1A4 B000BE8F */  lw         $fp, 0xB0($sp)
    /* BF9A8 800CF1A8 AC00B78F */  lw         $s7, 0xAC($sp)
    /* BF9AC 800CF1AC A800B68F */  lw         $s6, 0xA8($sp)
    /* BF9B0 800CF1B0 A400B58F */  lw         $s5, 0xA4($sp)
    /* BF9B4 800CF1B4 A000B48F */  lw         $s4, 0xA0($sp)
    /* BF9B8 800CF1B8 9C00B38F */  lw         $s3, 0x9C($sp)
    /* BF9BC 800CF1BC 9800B28F */  lw         $s2, 0x98($sp)
    /* BF9C0 800CF1C0 9400B18F */  lw         $s1, 0x94($sp)
    /* BF9C4 800CF1C4 9000B08F */  lw         $s0, 0x90($sp)
    /* BF9C8 800CF1C8 0800E003 */  jr         $ra
    /* BF9CC 800CF1CC B800BD27 */   addiu     $sp, $sp, 0xB8
endlabel Flare_LensFlare__FP7DVECTORP15Draw_FlareCache
