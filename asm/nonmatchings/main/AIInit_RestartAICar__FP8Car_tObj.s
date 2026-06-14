.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIInit_RestartAICar__FP8Car_tObj, 0x128

glabel AIInit_RestartAICar__FP8Car_tObj
    /* 579EC 800671EC 1180023C */  lui        $v0, %hi(D_8011321C)
    /* 579F0 800671F0 1C32428C */  lw         $v0, %lo(D_8011321C)($v0)
    /* 579F4 800671F4 00000000 */  nop
    /* 579F8 800671F8 02004014 */  bnez       $v0, .L80067204
    /* 579FC 800671FC FFFF0324 */   addiu     $v1, $zero, -0x1
    /* 57A00 80067200 01000324 */  addiu      $v1, $zero, 0x1
  .L80067204:
    /* 57A04 80067204 01000524 */  addiu      $a1, $zero, 0x1
    /* 57A08 80067208 540583AC */  sw         $v1, 0x554($a0)
    /* 57A0C 8006720C 500583AC */  sw         $v1, 0x550($a0)
    /* 57A10 80067210 0100033C */  lui        $v1, (0x10000 >> 16)
    /* 57A14 80067214 140780AC */  sw         $zero, 0x714($a0)
    /* 57A18 80067218 100780AC */  sw         $zero, 0x710($a0)
    /* 57A1C 8006721C 0C0780AC */  sw         $zero, 0x70C($a0)
    /* 57A20 80067220 080780AC */  sw         $zero, 0x708($a0)
    /* 57A24 80067224 1C0780AC */  sw         $zero, 0x71C($a0)
    /* 57A28 80067228 200780AC */  sw         $zero, 0x720($a0)
    /* 57A2C 8006722C 4C0580AC */  sw         $zero, 0x54C($a0)
    /* 57A30 80067230 F00685AC */  sw         $a1, 0x6F0($a0)
    /* 57A34 80067234 F40680AC */  sw         $zero, 0x6F4($a0)
    /* 57A38 80067238 EC0680AC */  sw         $zero, 0x6EC($a0)
    /* 57A3C 8006723C C00680AC */  sw         $zero, 0x6C0($a0)
    /* 57A40 80067240 580580AC */  sw         $zero, 0x558($a0)
    /* 57A44 80067244 5C0580AC */  sw         $zero, 0x55C($a0)
    /* 57A48 80067248 600580AC */  sw         $zero, 0x560($a0)
    /* 57A4C 8006724C 640580AC */  sw         $zero, 0x564($a0)
    /* 57A50 80067250 680580AC */  sw         $zero, 0x568($a0)
    /* 57A54 80067254 6C0580AC */  sw         $zero, 0x56C($a0)
    /* 57A58 80067258 740580AC */  sw         $zero, 0x574($a0)
    /* 57A5C 8006725C 700580AC */  sw         $zero, 0x570($a0)
    /* 57A60 80067260 6C0280AC */  sw         $zero, 0x26C($a0)
    /* 57A64 80067264 780584AC */  sw         $a0, 0x578($a0)
    /* 57A68 80067268 800580AC */  sw         $zero, 0x580($a0)
    /* 57A6C 8006726C 880580AC */  sw         $zero, 0x588($a0)
    /* 57A70 80067270 8C0580AC */  sw         $zero, 0x58C($a0)
    /* 57A74 80067274 900580AC */  sw         $zero, 0x590($a0)
    /* 57A78 80067278 940580AC */  sw         $zero, 0x594($a0)
    /* 57A7C 8006727C 240780AC */  sw         $zero, 0x724($a0)
    /* 57A80 80067280 180780AC */  sw         $zero, 0x718($a0)
    /* 57A84 80067284 3C0783AC */  sw         $v1, 0x73C($a0)
    /* 57A88 80067288 400783AC */  sw         $v1, 0x740($a0)
    /* 57A8C 8006728C 340580AC */  sw         $zero, 0x534($a0)
    /* 57A90 80067290 480780AC */  sw         $zero, 0x748($a0)
    /* 57A94 80067294 4C0783AC */  sw         $v1, 0x74C($a0)
    /* 57A98 80067298 CC0683AC */  sw         $v1, 0x6CC($a0)
    /* 57A9C 8006729C 6002838C */  lw         $v1, 0x260($a0)
    /* 57AA0 800672A0 6400023C */  lui        $v0, (0x640000 >> 16)
    /* 57AA4 800672A4 C80682AC */  sw         $v0, 0x6C8($a0)
    /* 57AA8 800672A8 07000224 */  addiu      $v0, $zero, 0x7
    /* 57AAC 800672AC 500780AC */  sw         $zero, 0x750($a0)
    /* 57AB0 800672B0 C40682AC */  sw         $v0, 0x6C4($a0)
    /* 57AB4 800672B4 540780AC */  sw         $zero, 0x754($a0)
    /* 57AB8 800672B8 02006330 */  andi       $v1, $v1, 0x2
    /* 57ABC 800672BC 03006010 */  beqz       $v1, .L800672CC
    /* 57AC0 800672C0 580780AC */   sw        $zero, 0x758($a0)
    /* 57AC4 800672C4 B49C0108 */  j          .L800672D0
    /* 57AC8 800672C8 5C0780AC */   sw        $zero, 0x75C($a0)
  .L800672CC:
    /* 57ACC 800672CC 5C0785AC */  sw         $a1, 0x75C($a0)
  .L800672D0:
    /* 57AD0 800672D0 6002828C */  lw         $v0, 0x260($a0)
    /* 57AD4 800672D4 02000324 */  addiu      $v1, $zero, 0x2
    /* 57AD8 800672D8 0A004230 */  andi       $v0, $v0, 0xA
    /* 57ADC 800672DC 02004314 */  bne        $v0, $v1, .L800672E8
    /* 57AE0 800672E0 440780AC */   sw        $zero, 0x744($a0)
    /* 57AE4 800672E4 910080A0 */  sb         $zero, 0x91($a0)
  .L800672E8:
    /* 57AE8 800672E8 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 57AEC 800672EC 700782AC */  sw         $v0, 0x770($a0)
    /* 57AF0 800672F0 0100023C */  lui        $v0, (0x10000 >> 16)
    /* 57AF4 800672F4 640780AC */  sw         $zero, 0x764($a0)
    /* 57AF8 800672F8 680780AC */  sw         $zero, 0x768($a0)
    /* 57AFC 800672FC 6C0780AC */  sw         $zero, 0x76C($a0)
    /* 57B00 80067300 740780AC */  sw         $zero, 0x774($a0)
    /* 57B04 80067304 600782AC */  sw         $v0, 0x760($a0)
    /* 57B08 80067308 780782AC */  sw         $v0, 0x778($a0)
    /* 57B0C 8006730C 0800E003 */  jr         $ra
    /* 57B10 80067310 840780AC */   sw        $zero, 0x784($a0)
endlabel AIInit_RestartAICar__FP8Car_tObj
