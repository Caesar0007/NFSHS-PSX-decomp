.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching R3DCar_StartUp__Fv, 0xD0

glabel R3DCar_StartUp__Fv
    /* 9E514 800ADD14 80FFBD27 */  addiu      $sp, $sp, -0x80
    /* 9E518 800ADD18 7800BFAF */  sw         $ra, 0x78($sp)
    /* 9E51C 800ADD1C 21280000 */  addu       $a1, $zero, $zero
    /* 9E520 800ADD20 1180023C */  lui        $v0, %hi(R3DCar_LoadedSceneCounter)
    /* 9E524 800ADD24 986A4924 */  addiu      $t1, $v0, %lo(R3DCar_LoadedSceneCounter)
    /* 9E528 800ADD28 1180023C */  lui        $v0, %hi(R3DCar_LoadedSceneCountry)
    /* 9E52C 800ADD2C FC6A4824 */  addiu      $t0, $v0, %lo(R3DCar_LoadedSceneCountry)
    /* 9E530 800ADD30 FFFF0724 */  addiu      $a3, $zero, -0x1
    /* 9E534 800ADD34 FFFF0624 */  addiu      $a2, $zero, -0x1
    /* 9E538 800ADD38 1180023C */  lui        $v0, %hi(R3DCar_LoadedSceneColor)
    /* 9E53C 800ADD3C 306B4424 */  addiu      $a0, $v0, %lo(R3DCar_LoadedSceneColor)
    /* 9E540 800ADD40 1180023C */  lui        $v0, %hi(R3DCar_LoadedScenePointer)
    /* 9E544 800ADD44 08694324 */  addiu      $v1, $v0, %lo(R3DCar_LoadedScenePointer)
  .L800ADD48:
    /* 9E548 800ADD48 2110A900 */  addu       $v0, $a1, $t1
    /* 9E54C 800ADD4C C80060AC */  sw         $zero, 0xC8($v1)
    /* 9E550 800ADD50 000060AC */  sw         $zero, 0x0($v1)
    /* 9E554 800ADD54 320040A0 */  sb         $zero, 0x32($v0)
    /* 9E558 800ADD58 000040A0 */  sb         $zero, 0x0($v0)
    /* 9E55C 800ADD5C 2110A800 */  addu       $v0, $a1, $t0
    /* 9E560 800ADD60 000047A0 */  sb         $a3, 0x0($v0)
    /* 9E564 800ADD64 640086A4 */  sh         $a2, 0x64($a0)
    /* 9E568 800ADD68 000086A4 */  sh         $a2, 0x0($a0)
    /* 9E56C 800ADD6C 02008424 */  addiu      $a0, $a0, 0x2
    /* 9E570 800ADD70 0100A524 */  addiu      $a1, $a1, 0x1
    /* 9E574 800ADD74 3200A228 */  slti       $v0, $a1, 0x32
    /* 9E578 800ADD78 F3FF4014 */  bnez       $v0, .L800ADD48
    /* 9E57C 800ADD7C 04006324 */   addiu     $v1, $v1, 0x4
    /* 9E580 800ADD80 0580043C */  lui        $a0, %hi(D_800563BC)
    /* 9E584 800ADD84 BC638424 */  addiu      $a0, $a0, %lo(D_800563BC)
    /* 9E588 800ADD88 04080524 */  addiu      $a1, $zero, 0x804
    /* 9E58C 800ADD8C CF94030C */  jal        reservememadr
    /* 9E590 800ADD90 21300000 */   addu      $a2, $zero, $zero
    /* 9E594 800ADD94 0580043C */  lui        $a0, %hi(D_800563C8)
    /* 9E598 800ADD98 C8638424 */  addiu      $a0, $a0, %lo(D_800563C8)
    /* 9E59C 800ADD9C B8020524 */  addiu      $a1, $zero, 0x2B8
    /* 9E5A0 800ADDA0 3C0E82AF */  sw         $v0, %gp_rel(R3DCar_orientMat)($gp)
    /* 9E5A4 800ADDA4 CF94030C */  jal        reservememadr
    /* 9E5A8 800ADDA8 21300000 */   addu      $a2, $zero, $zero
    /* 9E5AC 800ADDAC 1000A427 */  addiu      $a0, $sp, 0x10
    /* 9E5B0 800ADDB0 1180033C */  lui        $v1, %hi(D_801164CC)
    /* 9E5B4 800ADDB4 0580053C */  lui        $a1, %hi(D_800563D4)
    /* 9E5B8 800ADDB8 CC64668C */  lw         $a2, %lo(D_801164CC)($v1)
    /* 9E5BC 800ADDBC 400E82AF */  sw         $v0, %gp_rel(R3DCar_position)($gp)
    /* 9E5C0 800ADDC0 2F91030C */  jal        sprintf
    /* 9E5C4 800ADDC4 D463A524 */   addiu     $a1, $a1, %lo(D_800563D4)
    /* 9E5C8 800ADDC8 1000A427 */  addiu      $a0, $sp, 0x10
    /* 9E5CC 800ADDCC FA95030C */  jal        loadfileadr
    /* 9E5D0 800ADDD0 21280000 */   addu      $a1, $zero, $zero
    /* 9E5D4 800ADDD4 7800BF8F */  lw         $ra, 0x78($sp)
    /* 9E5D8 800ADDD8 680E82AF */  sw         $v0, %gp_rel(R3DCar_LicenseShapeFile)($gp)
    /* 9E5DC 800ADDDC 0800E003 */  jr         $ra
    /* 9E5E0 800ADDE0 8000BD27 */   addiu     $sp, $sp, 0x80
endlabel R3DCar_StartUp__Fv
