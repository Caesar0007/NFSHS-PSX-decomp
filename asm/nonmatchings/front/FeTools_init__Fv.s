.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FeTools_init__Fv, 0xE8

glabel FeTools_init__Fv
    /* 173A8 80026BA8 E8FEBD27 */  addiu      $sp, $sp, -0x118
    /* 173AC 80026BAC 1401BFAF */  sw         $ra, 0x114($sp)
    /* 173B0 80026BB0 2A2E030C */  jal        Font_ExitFromGame__Fv
    /* 173B4 80026BB4 1001B0AF */   sw        $s0, 0x110($sp)
    /* 173B8 80026BB8 1000A427 */  addiu      $a0, $sp, 0x10
    /* 173BC 80026BBC 1180103C */  lui        $s0, %hi(Paths_Paths)
    /* 173C0 80026BC0 68641026 */  addiu      $s0, $s0, %lo(Paths_Paths)
    /* 173C4 80026BC4 0180053C */  lui        $a1, %hi(D_80011474)
    /* 173C8 80026BC8 8400068E */  lw         $a2, 0x84($s0)
    /* 173CC 80026BCC 2F91030C */  jal        sprintf
    /* 173D0 80026BD0 7414A524 */   addiu     $a1, $a1, %lo(D_80011474)
    /* 173D4 80026BD4 1000A427 */  addiu      $a0, $sp, 0x10
    /* 173D8 80026BD8 EA95030C */  jal        loadfileadrz
    /* 173DC 80026BDC 21280000 */   addu      $a1, $zero, $zero
    /* 173E0 80026BE0 21204000 */  addu       $a0, $v0, $zero
    /* 173E4 80026BE4 C0030524 */  addiu      $a1, $zero, 0x3C0
    /* 173E8 80026BE8 81010624 */  addiu      $a2, $zero, 0x181
    /* 173EC 80026BEC 21380000 */  addu       $a3, $zero, $zero
    /* 173F0 80026BF0 0580023C */  lui        $v0, %hi(font12)
    /* 173F4 80026BF4 2F2E030C */  jal        Font_LoadFont__FPciic
    /* 173F8 80026BF8 D41744AC */   sw        $a0, %lo(font12)($v0)
    /* 173FC 80026BFC 1000A427 */  addiu      $a0, $sp, 0x10
    /* 17400 80026C00 0180053C */  lui        $a1, %hi(D_80011480)
    /* 17404 80026C04 8400068E */  lw         $a2, 0x84($s0)
    /* 17408 80026C08 2F91030C */  jal        sprintf
    /* 1740C 80026C0C 8014A524 */   addiu     $a1, $a1, %lo(D_80011480)
    /* 17410 80026C10 1000A427 */  addiu      $a0, $sp, 0x10
    /* 17414 80026C14 EA95030C */  jal        loadfileadrz
    /* 17418 80026C18 21280000 */   addu      $a1, $zero, $zero
    /* 1741C 80026C1C 21204000 */  addu       $a0, $v0, $zero
    /* 17420 80026C20 80030524 */  addiu      $a1, $zero, 0x380
    /* 17424 80026C24 00010624 */  addiu      $a2, $zero, 0x100
    /* 17428 80026C28 21380000 */  addu       $a3, $zero, $zero
    /* 1742C 80026C2C 0580023C */  lui        $v0, %hi(font18)
    /* 17430 80026C30 2F2E030C */  jal        Font_LoadFont__FPciic
    /* 17434 80026C34 D81744AC */   sw        $a0, %lo(font18)($v0)
    /* 17438 80026C38 1000A427 */  addiu      $a0, $sp, 0x10
    /* 1743C 80026C3C 0180053C */  lui        $a1, %hi(D_8001148C)
    /* 17440 80026C40 8400068E */  lw         $a2, 0x84($s0)
    /* 17444 80026C44 2F91030C */  jal        sprintf
    /* 17448 80026C48 8C14A524 */   addiu     $a1, $a1, %lo(D_8001148C)
    /* 1744C 80026C4C 1000A427 */  addiu      $a0, $sp, 0x10
    /* 17450 80026C50 EA95030C */  jal        loadfileadrz
    /* 17454 80026C54 21280000 */   addu      $a1, $zero, $zero
    /* 17458 80026C58 21204000 */  addu       $a0, $v0, $zero
    /* 1745C 80026C5C C0030524 */  addiu      $a1, $zero, 0x3C0
    /* 17460 80026C60 00010624 */  addiu      $a2, $zero, 0x100
    /* 17464 80026C64 21380000 */  addu       $a3, $zero, $zero
    /* 17468 80026C68 0580023C */  lui        $v0, %hi(fontTitle)
    /* 1746C 80026C6C 2F2E030C */  jal        Font_LoadFont__FPciic
    /* 17470 80026C70 DC1744AC */   sw        $a0, %lo(fontTitle)($v0)
    /* 17474 80026C74 0580033C */  lui        $v1, %hi(currentSize)
    /* 17478 80026C78 1401BF8F */  lw         $ra, 0x114($sp)
    /* 1747C 80026C7C 1001B08F */  lw         $s0, 0x110($sp)
    /* 17480 80026C80 03000224 */  addiu      $v0, $zero, 0x3
    /* 17484 80026C84 E01762A4 */  sh         $v0, %lo(currentSize)($v1)
    /* 17488 80026C88 0800E003 */  jr         $ra
    /* 1748C 80026C8C 1801BD27 */   addiu     $sp, $sp, 0x118
endlabel FeTools_init__Fv
