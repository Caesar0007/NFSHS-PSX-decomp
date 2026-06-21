.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Initialize__18tScreenTrackSelect, 0x1BC

glabel Initialize__18tScreenTrackSelect
    /* 3236C 80041B6C 48FFBD27 */  addiu      $sp, $sp, -0xB8
    /* 32370 80041B70 B000B2AF */  sw         $s2, 0xB0($sp)
    /* 32374 80041B74 21908000 */  addu       $s2, $a0, $zero
    /* 32378 80041B78 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 3237C 80041B7C A800B0AF */  sw         $s0, 0xA8($sp)
    /* 32380 80041B80 1180103C */  lui        $s0, %hi(frontEnd)
    /* 32384 80041B84 AC00B1AF */  sw         $s1, 0xAC($sp)
    /* 32388 80041B88 0580113C */  lui        $s1, %hi(menuDefs)
    /* 3238C 80041B8C 581A248E */  lw         $a0, %lo(menuDefs)($s1)
    /* 32390 80041B90 00461026 */  addiu      $s0, $s0, %lo(frontEnd)
    /* 32394 80041B94 B400BFAF */  sw         $ra, 0xB4($sp)
    /* 32398 80041B98 460000A2 */  sb         $zero, 0x46($s0)
    /* 3239C 80041B9C B087000C */  jal        Decrement__18tListIteratorTrack7tPlayer
    /* 323A0 80041BA0 880C8424 */   addiu     $a0, $a0, 0xC88
    /* 323A4 80041BA4 581A248E */  lw         $a0, %lo(menuDefs)($s1)
    /* 323A8 80041BA8 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 323AC 80041BAC 8587000C */  jal        Increment__18tListIteratorTrack7tPlayer
    /* 323B0 80041BB0 880C8424 */   addiu     $a0, $a0, 0xC88
    /* 323B4 80041BB4 1180043C */  lui        $a0, %hi(trackManager)
    /* 323B8 80041BB8 504A8424 */  addiu      $a0, $a0, %lo(trackManager)
    /* 323BC 80041BBC 23000592 */  lbu        $a1, 0x23($s0)
    /* 323C0 80041BC0 A986000C */  jal        GetTrack__13tTrackManagersR17tTrackInformation
    /* 323C4 80041BC4 2000A627 */   addiu     $a2, $sp, 0x20
    /* 323C8 80041BC8 5000A427 */  addiu      $a0, $sp, 0x50
    /* 323CC 80041BCC 21280000 */  addu       $a1, $zero, $zero
    /* 323D0 80041BD0 2130A000 */  addu       $a2, $a1, $zero
    /* 323D4 80041BD4 2138A000 */  addu       $a3, $a1, $zero
    /* 323D8 80041BD8 00020224 */  addiu      $v0, $zero, 0x200
    /* 323DC 80041BDC 5000A2A7 */  sh         $v0, 0x50($sp)
    /* 323E0 80041BE0 AA000224 */  addiu      $v0, $zero, 0xAA
    /* 323E4 80041BE4 5400A2A7 */  sh         $v0, 0x54($sp)
    /* 323E8 80041BE8 00010224 */  addiu      $v0, $zero, 0x100
    /* 323EC 80041BEC 5200A0A7 */  sh         $zero, 0x52($sp)
    /* 323F0 80041BF0 80B6030C */  jal        ClearImage
    /* 323F4 80041BF4 5600A2A7 */   sh        $v0, 0x56($sp)
    /* 323F8 80041BF8 1FB6030C */  jal        DrawSync
    /* 323FC 80041BFC 21200000 */   addu      $a0, $zero, $zero
    /* 32400 80041C00 2B98000C */  jal        Initialize__7tScreen
    /* 32404 80041C04 21204002 */   addu      $a0, $s2, $zero
    /* 32408 80041C08 5800B027 */  addiu      $s0, $sp, 0x58
    /* 3240C 80041C0C 21200002 */  addu       $a0, $s0, $zero
    /* 32410 80041C10 1180023C */  lui        $v0, %hi(D_8011650C)
    /* 32414 80041C14 0180053C */  lui        $a1, %hi(D_80011EEC)
    /* 32418 80041C18 0C65468C */  lw         $a2, %lo(D_8011650C)($v0)
    /* 3241C 80041C1C 2000A783 */  lb         $a3, 0x20($sp)
    /* 32420 80041C20 2F91030C */  jal        sprintf
    /* 32424 80041C24 EC1EA524 */   addiu     $a1, $a1, %lo(D_80011EEC)
    /* 32428 80041C28 A0000424 */  addiu      $a0, $zero, 0xA0
    /* 3242C 80041C2C 80000524 */  addiu      $a1, $zero, 0x80
    /* 32430 80041C30 0F00063C */  lui        $a2, (0xF0000 >> 16)
    /* 32434 80041C34 0200073C */  lui        $a3, (0x2C000 >> 16)
    /* 32438 80041C38 00C0E734 */  ori        $a3, $a3, (0x2C000 & 0xFFFF)
    /* 3243C 80041C3C 10000224 */  addiu      $v0, $zero, 0x10
    /* 32440 80041C40 3243010C */  jal        VIDEO_create__Fiiiii
    /* 32444 80041C44 1000A2AF */   sw        $v0, 0x10($sp)
    /* 32448 80041C48 21204000 */  addu       $a0, $v0, $zero
    /* 3244C 80041C4C 21280002 */  addu       $a1, $s0, $zero
    /* 32450 80041C50 A643010C */  jal        VIDEO_spoolfile__FiPc
    /* 32454 80041C54 640044AE */   sw        $a0, 0x64($s2)
    /* 32458 80041C58 6400448E */  lw         $a0, 0x64($s2)
    /* 3245C 80041C5C BD43010C */  jal        VIDEO_startplayback__Fi
    /* 32460 80041C60 60025026 */   addiu     $s0, $s2, 0x260
    /* 32464 80041C64 21200002 */  addu       $a0, $s0, $zero
    /* 32468 80041C68 80004526 */  addiu      $a1, $s2, 0x80
    /* 3246C 80041C6C 0A000224 */  addiu      $v0, $zero, 0xA
    /* 32470 80041C70 680040AE */  sw         $zero, 0x68($s2)
    /* 32474 80041C74 1000A2AF */  sw         $v0, 0x10($sp)
    /* 32478 80041C78 0580023C */  lui        $v0, %hi(D_800520A0)
    /* 3247C 80041C7C A0204224 */  addiu      $v0, $v0, %lo(D_800520A0)
    /* 32480 80041C80 1400A2AF */  sw         $v0, 0x14($sp)
    /* 32484 80041C84 96000224 */  addiu      $v0, $zero, 0x96
    /* 32488 80041C88 1800A2AF */  sw         $v0, 0x18($sp)
    /* 3248C 80041C8C 2800468E */  lw         $a2, 0x28($s2)
    /* 32490 80041C90 E4D9000C */  jal        Initialize__10tVideoWallP9tTVConfigP18tTexture_ShapeInfossPss
    /* 32494 80041C94 21380000 */   addu      $a3, $zero, $zero
    /* 32498 80041C98 21200002 */  addu       $a0, $s0, $zero
    /* 3249C 80041C9C F8000524 */  addiu      $a1, $zero, 0xF8
    /* 324A0 80041CA0 40010624 */  addiu      $a2, $zero, 0x140
    /* 324A4 80041CA4 63DA000C */  jal        SetAvailableText__10tVideoWallsss
    /* 324A8 80041CA8 50000724 */   addiu     $a3, $zero, 0x50
    /* 324AC 80041CAC 21200002 */  addu       $a0, $s0, $zero
    /* 324B0 80041CB0 26000524 */  addiu      $a1, $zero, 0x26
    /* 324B4 80041CB4 0A000624 */  addiu      $a2, $zero, 0xA
    /* 324B8 80041CB8 3C000224 */  addiu      $v0, $zero, 0x3C
    /* 324BC 80041CBC 1000A2AF */  sw         $v0, 0x10($sp)
    /* 324C0 80041CC0 0000428E */  lw         $v0, 0x0($s2)
    /* 324C4 80041CC4 36010724 */  addiu      $a3, $zero, 0x136
    /* 324C8 80041CC8 6ADA000C */  jal        SetAvailableIcon__10tVideoWallssssP18tTexture_ShapeInfo
    /* 324CC 80041CCC 1400A2AF */   sw        $v0, 0x14($sp)
    /* 324D0 80041CD0 21200002 */  addu       $a0, $s0, $zero
    /* 324D4 80041CD4 700040A6 */  sh         $zero, 0x70($s2)
    /* 324D8 80041CD8 720040A6 */  sh         $zero, 0x72($s2)
    /* 324DC 80041CDC BEDB000C */  jal        TurnOn__10tVideoWall
    /* 324E0 80041CE0 980240AE */   sw        $zero, 0x298($s2)
    /* 324E4 80041CE4 1480023C */  lui        $v0, %hi(ticks)
    /* 324E8 80041CE8 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 324EC 80041CEC 01000324 */  addiu      $v1, $zero, 0x1
    /* 324F0 80041CF0 7C0043AE */  sw         $v1, 0x7C($s2)
    /* 324F4 80041CF4 00FF4224 */  addiu      $v0, $v0, -0x100
    /* 324F8 80041CF8 9C0242AE */  sw         $v0, 0x29C($s2)
    /* 324FC 80041CFC 2000A293 */  lbu        $v0, 0x20($sp)
    /* 32500 80041D00 00000000 */  nop
    /* 32504 80041D04 00160200 */  sll        $v0, $v0, 24
    /* 32508 80041D08 03160200 */  sra        $v0, $v0, 24
    /* 3250C 80041D0C 6E0042A6 */  sh         $v0, 0x6E($s2)
    /* 32510 80041D10 B400BF8F */  lw         $ra, 0xB4($sp)
    /* 32514 80041D14 B000B28F */  lw         $s2, 0xB0($sp)
    /* 32518 80041D18 AC00B18F */  lw         $s1, 0xAC($sp)
    /* 3251C 80041D1C A800B08F */  lw         $s0, 0xA8($sp)
    /* 32520 80041D20 0800E003 */  jr         $ra
    /* 32524 80041D24 B800BD27 */   addiu     $sp, $sp, 0xB8
endlabel Initialize__18tScreenTrackSelect
