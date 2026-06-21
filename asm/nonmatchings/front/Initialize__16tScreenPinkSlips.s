.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Initialize__16tScreenPinkSlips, 0x148

glabel Initialize__16tScreenPinkSlips
    /* 299D8 800391D8 50FFBD27 */  addiu      $sp, $sp, -0xB0
    /* 299DC 800391DC A000B0AF */  sw         $s0, 0xA0($sp)
    /* 299E0 800391E0 21808000 */  addu       $s0, $a0, $zero
    /* 299E4 800391E4 1800A427 */  addiu      $a0, $sp, 0x18
    /* 299E8 800391E8 21280000 */  addu       $a1, $zero, $zero
    /* 299EC 800391EC 2130A000 */  addu       $a2, $a1, $zero
    /* 299F0 800391F0 2138A000 */  addu       $a3, $a1, $zero
    /* 299F4 800391F4 00020224 */  addiu      $v0, $zero, 0x200
    /* 299F8 800391F8 1800A2A7 */  sh         $v0, 0x18($sp)
    /* 299FC 800391FC AA000224 */  addiu      $v0, $zero, 0xAA
    /* 29A00 80039200 1C00A2A7 */  sh         $v0, 0x1C($sp)
    /* 29A04 80039204 00010224 */  addiu      $v0, $zero, 0x100
    /* 29A08 80039208 AC00BFAF */  sw         $ra, 0xAC($sp)
    /* 29A0C 8003920C A800B2AF */  sw         $s2, 0xA8($sp)
    /* 29A10 80039210 A400B1AF */  sw         $s1, 0xA4($sp)
    /* 29A14 80039214 1A00A0A7 */  sh         $zero, 0x1A($sp)
    /* 29A18 80039218 80B6030C */  jal        ClearImage
    /* 29A1C 8003921C 1E00A2A7 */   sh        $v0, 0x1E($sp)
    /* 29A20 80039220 1FB6030C */  jal        DrawSync
    /* 29A24 80039224 21200000 */   addu      $a0, $zero, $zero
    /* 29A28 80039228 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 29A2C 8003922C 1180113C */  lui        $s1, %hi(frontEnd)
    /* 29A30 80039230 0580123C */  lui        $s2, %hi(menuDefs)
    /* 29A34 80039234 581A448E */  lw         $a0, %lo(menuDefs)($s2)
    /* 29A38 80039238 00463126 */  addiu      $s1, $s1, %lo(frontEnd)
    /* 29A3C 8003923C 460020A2 */  sb         $zero, 0x46($s1)
    /* 29A40 80039240 B087000C */  jal        Decrement__18tListIteratorTrack7tPlayer
    /* 29A44 80039244 880C8424 */   addiu     $a0, $a0, 0xC88
    /* 29A48 80039248 581A448E */  lw         $a0, %lo(menuDefs)($s2)
    /* 29A4C 8003924C FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 29A50 80039250 8587000C */  jal        Increment__18tListIteratorTrack7tPlayer
    /* 29A54 80039254 880C8424 */   addiu     $a0, $a0, 0xC88
    /* 29A58 80039258 0580023C */  lui        $v0, %hi(FEApp)
    /* 29A5C 8003925C C014428C */  lw         $v0, %lo(FEApp)($v0)
    /* 29A60 80039260 00000000 */  nop
    /* 29A64 80039264 0400428C */  lw         $v0, 0x4($v0)
    /* 29A68 80039268 21200002 */  addu       $a0, $s0, $zero
    /* 29A6C 8003926C 2B98000C */  jal        Initialize__7tScreen
    /* 29A70 80039270 640002AE */   sw        $v0, 0x64($s0)
    /* 29A74 80039274 1180043C */  lui        $a0, %hi(trackManager)
    /* 29A78 80039278 504A8424 */  addiu      $a0, $a0, %lo(trackManager)
    /* 29A7C 8003927C C40200AE */  sw         $zero, 0x2C4($s0)
    /* 29A80 80039280 23002592 */  lbu        $a1, 0x23($s1)
    /* 29A84 80039284 A986000C */  jal        GetTrack__13tTrackManagersR17tTrackInformation
    /* 29A88 80039288 7000A627 */   addiu     $a2, $sp, 0x70
    /* 29A8C 8003928C 2000B127 */  addiu      $s1, $sp, 0x20
    /* 29A90 80039290 21202002 */  addu       $a0, $s1, $zero
    /* 29A94 80039294 1180023C */  lui        $v0, %hi(D_8011650C)
    /* 29A98 80039298 0180053C */  lui        $a1, %hi(D_8001190C)
    /* 29A9C 8003929C 0C65468C */  lw         $a2, %lo(D_8011650C)($v0)
    /* 29AA0 800392A0 7000A783 */  lb         $a3, 0x70($sp)
    /* 29AA4 800392A4 2F91030C */  jal        sprintf
    /* 29AA8 800392A8 0C19A524 */   addiu     $a1, $a1, %lo(D_8001190C)
    /* 29AAC 800392AC A0000424 */  addiu      $a0, $zero, 0xA0
    /* 29AB0 800392B0 80000524 */  addiu      $a1, $zero, 0x80
    /* 29AB4 800392B4 0F00063C */  lui        $a2, (0xF0000 >> 16)
    /* 29AB8 800392B8 0200073C */  lui        $a3, (0x20000 >> 16)
    /* 29ABC 800392BC 10000224 */  addiu      $v0, $zero, 0x10
    /* 29AC0 800392C0 3243010C */  jal        VIDEO_create__Fiiiii
    /* 29AC4 800392C4 1000A2AF */   sw        $v0, 0x10($sp)
    /* 29AC8 800392C8 21204000 */  addu       $a0, $v0, $zero
    /* 29ACC 800392CC 21282002 */  addu       $a1, $s1, $zero
    /* 29AD0 800392D0 A643010C */  jal        VIDEO_spoolfile__FiPc
    /* 29AD4 800392D4 680004AE */   sw        $a0, 0x68($s0)
    /* 29AD8 800392D8 6800048E */  lw         $a0, 0x68($s0)
    /* 29ADC 800392DC BD43010C */  jal        VIDEO_startplayback__Fi
    /* 29AE0 800392E0 00000000 */   nop
    /* 29AE4 800392E4 1480023C */  lui        $v0, %hi(ticks)
    /* 29AE8 800392E8 ACDC438C */  lw         $v1, %lo(ticks)($v0)
    /* 29AEC 800392EC 01000224 */  addiu      $v0, $zero, 0x1
    /* 29AF0 800392F0 6C0000AE */  sw         $zero, 0x6C($s0)
    /* 29AF4 800392F4 720000A6 */  sh         $zero, 0x72($s0)
    /* 29AF8 800392F8 740000A6 */  sh         $zero, 0x74($s0)
    /* 29AFC 800392FC C40200AE */  sw         $zero, 0x2C4($s0)
    /* 29B00 80039300 800002A2 */  sb         $v0, 0x80($s0)
    /* 29B04 80039304 7C0003AE */  sw         $v1, 0x7C($s0)
    /* 29B08 80039308 AC00BF8F */  lw         $ra, 0xAC($sp)
    /* 29B0C 8003930C A800B28F */  lw         $s2, 0xA8($sp)
    /* 29B10 80039310 A400B18F */  lw         $s1, 0xA4($sp)
    /* 29B14 80039314 A000B08F */  lw         $s0, 0xA0($sp)
    /* 29B18 80039318 0800E003 */  jr         $ra
    /* 29B1C 8003931C B000BD27 */   addiu     $sp, $sp, 0xB0
endlabel Initialize__16tScreenPinkSlips
