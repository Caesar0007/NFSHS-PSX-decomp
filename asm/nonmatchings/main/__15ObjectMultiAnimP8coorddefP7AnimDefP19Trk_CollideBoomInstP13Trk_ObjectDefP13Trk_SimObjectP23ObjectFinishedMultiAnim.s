.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __15ObjectMultiAnimP8coorddefP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectP23ObjectFinishedMultiAnim, 0xF8

glabel __15ObjectMultiAnimP8coorddefP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectP23ObjectFinishedMultiAnim
    /* 96A00 800A6200 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 96A04 800A6204 1800B0AF */  sw         $s0, 0x18($sp)
    /* 96A08 800A6208 21808000 */  addu       $s0, $a0, $zero
    /* 96A0C 800A620C 0580023C */  lui        $v0, %hi(_vt_15ObjectMultiAnim)
    /* 96A10 800A6210 B8604224 */  addiu      $v0, $v0, %lo(_vt_15ObjectMultiAnim)
    /* 96A14 800A6214 2000BFAF */  sw         $ra, 0x20($sp)
    /* 96A18 800A6218 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 96A1C 800A621C 000002AE */  sw         $v0, 0x0($s0)
    /* 96A20 800A6220 0000A28C */  lw         $v0, 0x0($a1)
    /* 96A24 800A6224 00000000 */  nop
    /* 96A28 800A6228 83110200 */  sra        $v0, $v0, 6
    /* 96A2C 800A622C 040002AE */  sw         $v0, 0x4($s0)
    /* 96A30 800A6230 0400A28C */  lw         $v0, 0x4($a1)
    /* 96A34 800A6234 00000000 */  nop
    /* 96A38 800A6238 83110200 */  sra        $v0, $v0, 6
    /* 96A3C 800A623C 080002AE */  sw         $v0, 0x8($s0)
    /* 96A40 800A6240 0800A28C */  lw         $v0, 0x8($a1)
    /* 96A44 800A6244 1C0006AE */  sw         $a2, 0x1C($s0)
    /* 96A48 800A6248 3800A38F */  lw         $v1, 0x38($sp)
    /* 96A4C 800A624C 3C00A48F */  lw         $a0, 0x3C($sp)
    /* 96A50 800A6250 2188E000 */  addu       $s1, $a3, $zero
    /* 96A54 800A6254 140011AE */  sw         $s1, 0x14($s0)
    /* 96A58 800A6258 83110200 */  sra        $v0, $v0, 6
    /* 96A5C 800A625C 180003AE */  sw         $v1, 0x18($s0)
    /* 96A60 800A6260 100004AE */  sw         $a0, 0x10($s0)
    /* 96A64 800A6264 0C0002AE */  sw         $v0, 0xC($s0)
    /* 96A68 800A6268 02002292 */  lbu        $v0, 0x2($s1)
    /* 96A6C 800A626C 06000324 */  addiu      $v1, $zero, 0x6
    /* 96A70 800A6270 0A004314 */  bne        $v0, $v1, .L800A629C
    /* 96A74 800A6274 00000000 */   nop
    /* 96A78 800A6278 578F020C */  jal        __builtin_new
    /* 96A7C 800A627C 14000424 */   addiu     $a0, $zero, 0x14
    /* 96A80 800A6280 21204000 */  addu       $a0, $v0, $zero
    /* 96A84 800A6284 1480053C */  lui        $a1, %hi(gPersistObjInst)
    /* 96A88 800A6288 C0D4A58C */  lw         $a1, %lo(gPersistObjInst)($a1)
    /* 96A8C 800A628C 1C00028E */  lw         $v0, 0x1C($s0)
    /* 96A90 800A6290 0D002792 */  lbu        $a3, 0xD($s1)
    /* 96A94 800A6294 AE980208 */  j          .L800A62B8
    /* 96A98 800A6298 00000000 */   nop
  .L800A629C:
    /* 96A9C 800A629C 578F020C */  jal        __builtin_new
    /* 96AA0 800A62A0 14000424 */   addiu     $a0, $zero, 0x14
    /* 96AA4 800A62A4 21204000 */  addu       $a0, $v0, $zero
    /* 96AA8 800A62A8 1480053C */  lui        $a1, %hi(gPersistObjInst)
    /* 96AAC 800A62AC C0D4A58C */  lw         $a1, %lo(gPersistObjInst)($a1)
    /* 96AB0 800A62B0 1C00028E */  lw         $v0, 0x1C($s0)
    /* 96AB4 800A62B4 23002792 */  lbu        $a3, 0x23($s1)
  .L800A62B8:
    /* 96AB8 800A62B8 0400428C */  lw         $v0, 0x4($v0)
    /* 96ABC 800A62BC 08000624 */  addiu      $a2, $zero, 0x8
    /* 96AC0 800A62C0 1AD1010C */  jal        __10AnimScriptP5Groupiii
    /* 96AC4 800A62C4 1000A2AF */   sw        $v0, 0x10($sp)
    /* 96AC8 800A62C8 280002AE */  sw         $v0, 0x28($s0)
    /* 96ACC 800A62CC 2800048E */  lw         $a0, 0x28($s0)
    /* 96AD0 800A62D0 4DD1010C */  jal        SetAnimAttrib__10AnimScripti
    /* 96AD4 800A62D4 02000524 */   addiu     $a1, $zero, 0x2
    /* 96AD8 800A62D8 4000A38F */  lw         $v1, 0x40($sp)
    /* 96ADC 800A62DC 21100002 */  addu       $v0, $s0, $zero
    /* 96AE0 800A62E0 2C0043AC */  sw         $v1, 0x2C($v0)
    /* 96AE4 800A62E4 2000BF8F */  lw         $ra, 0x20($sp)
    /* 96AE8 800A62E8 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 96AEC 800A62EC 1800B08F */  lw         $s0, 0x18($sp)
    /* 96AF0 800A62F0 0800E003 */  jr         $ra
    /* 96AF4 800A62F4 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel __15ObjectMultiAnimP8coorddefP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectP23ObjectFinishedMultiAnim
