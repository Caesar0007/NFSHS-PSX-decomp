.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CleanupSpinningCars__Fv, 0xF8

glabel CleanupSpinningCars__Fv
    /* 3E1CC 8004D9CC 0580023C */  lui        $v0, %hi(D_80052A60)
    /* 3E1D0 8004D9D0 602A4290 */  lbu        $v0, %lo(D_80052A60)($v0)
    /* 3E1D4 8004D9D4 A0FFBD27 */  addiu      $sp, $sp, -0x60
    /* 3E1D8 8004D9D8 5800BFAF */  sw         $ra, 0x58($sp)
    /* 3E1DC 8004D9DC 5400B1AF */  sw         $s1, 0x54($sp)
    /* 3E1E0 8004D9E0 33004010 */  beqz       $v0, .L8004DAB0
    /* 3E1E4 8004D9E4 5000B0AF */   sw        $s0, 0x50($sp)
    /* 3E1E8 8004D9E8 1FB6030C */  jal        DrawSync
    /* 3E1EC 8004D9EC 21200000 */   addu      $a0, $zero, $zero
    /* 3E1F0 8004D9F0 21880000 */  addu       $s1, $zero, $zero
    /* 3E1F4 8004D9F4 0580023C */  lui        $v0, %hi(gCarObj)
    /* 3E1F8 8004D9F8 682A5024 */  addiu      $s0, $v0, %lo(gCarObj)
  .L8004D9FC:
    /* 3E1FC 8004D9FC 0000048E */  lw         $a0, 0x0($s0)
    /* 3E200 8004DA00 1EBB020C */  jal        R3DCar_DeInstantiate3DCar__FP8Car_tObj
    /* 3E204 8004DA04 01003126 */   addiu     $s1, $s1, 0x1
    /* 3E208 8004DA08 0000048E */  lw         $a0, 0x0($s0)
    /* 3E20C 8004DA0C 5095030C */  jal        purgememadr
    /* 3E210 8004DA10 04001026 */   addiu     $s0, $s0, 0x4
    /* 3E214 8004DA14 0200222A */  slti       $v0, $s1, 0x2
    /* 3E218 8004DA18 F8FF4014 */  bnez       $v0, .L8004D9FC
    /* 3E21C 8004DA1C 01000224 */   addiu     $v0, $zero, 0x1
    /* 3E220 8004DA20 1480103C */  lui        $s0, %hi(inFrontEnd)
    /* 3E224 8004DA24 D0B7020C */  jal        R3DCar_CleanUp__Fv
    /* 3E228 8004DA28 58D702AE */   sw        $v0, %lo(inFrontEnd)($s0)
    /* 3E22C 8004DA2C DFEF020C */  jal        CarIO_CleanUp__Fv
    /* 3E230 8004DA30 00000000 */   nop
    /* 3E234 8004DA34 1582030C */  jal        Texture_KillMenuTexture__Fv
    /* 3E238 8004DA38 58D700AE */   sw        $zero, %lo(inFrontEnd)($s0)
    /* 3E23C 8004DA3C 0C36010C */  jal        PSXFront_FreeDrawMemory__Fv
    /* 3E240 8004DA40 00000000 */   nop
    /* 3E244 8004DA44 1480023C */  lui        $v0, %hi(R3DCar_InMenu)
    /* 3E248 8004DA48 1480033C */  lui        $v1, %hi(gFlip)
    /* 3E24C 8004DA4C 24D340AC */  sw         $zero, %lo(R3DCar_InMenu)($v0)
    /* 3E250 8004DA50 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 3E254 8004DA54 B4D762AC */  sw         $v0, %lo(gFlip)($v1)
    /* 3E258 8004DA58 0580023C */  lui        $v0, %hi(D_80052A60)
    /* 3E25C 8004DA5C 2871030C */  jal        Platform_ResetDCTBuffer__Fv
    /* 3E260 8004DA60 602A40A0 */   sb        $zero, %lo(D_80052A60)($v0)
    /* 3E264 8004DA64 1000A427 */  addiu      $a0, $sp, 0x10
    /* 3E268 8004DA68 0180053C */  lui        $a1, %hi(D_800127FC)
    /* 3E26C 8004DA6C 1180023C */  lui        $v0, %hi(D_801164E8)
    /* 3E270 8004DA70 E864468C */  lw         $a2, %lo(D_801164E8)($v0)
    /* 3E274 8004DA74 2F91030C */  jal        sprintf
    /* 3E278 8004DA78 FC27A524 */   addiu     $a1, $a1, %lo(D_800127FC)
    /* 3E27C 8004DA7C 1000A427 */  addiu      $a0, $sp, 0x10
    /* 3E280 8004DA80 1280053C */  lui        $a1, %hi(CF_DVLC)
    /* 3E284 8004DA84 0FC5030C */  jal        asyncloadfileat
    /* 3E288 8004DA88 3840A524 */   addiu     $a1, $a1, %lo(CF_DVLC)
    /* 3E28C 8004DA8C 21804000 */  addu       $s0, $v0, $zero
  .L8004DA90:
    /* 3E290 8004DA90 B6C5030C */  jal        getasyncreadstatus
    /* 3E294 8004DA94 21200002 */   addu      $a0, $s0, $zero
    /* 3E298 8004DA98 05004014 */  bnez       $v0, .L8004DAB0
    /* 3E29C 8004DA9C 00000000 */   nop
    /* 3E2A0 8004DAA0 019B030C */  jal        systemtask
    /* 3E2A4 8004DAA4 21200000 */   addu      $a0, $zero, $zero
    /* 3E2A8 8004DAA8 A4360108 */  j          .L8004DA90
    /* 3E2AC 8004DAAC 00000000 */   nop
  .L8004DAB0:
    /* 3E2B0 8004DAB0 5800BF8F */  lw         $ra, 0x58($sp)
    /* 3E2B4 8004DAB4 5400B18F */  lw         $s1, 0x54($sp)
    /* 3E2B8 8004DAB8 5000B08F */  lw         $s0, 0x50($sp)
    /* 3E2BC 8004DABC 0800E003 */  jr         $ra
    /* 3E2C0 8004DAC0 6000BD27 */   addiu     $sp, $sp, 0x60
endlabel CleanupSpinningCars__Fv
