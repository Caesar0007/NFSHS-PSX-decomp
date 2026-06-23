.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MCRD_init, 0xA0

glabel MCRD_init
    /* 3FBE0 8004F3E0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 3FBE4 8004F3E4 1400B1AF */  sw         $s1, 0x14($sp)
    /* 3FBE8 8004F3E8 21888000 */  addu       $s1, $a0, $zero
    /* 3FBEC 8004F3EC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 3FBF0 8004F3F0 0580103C */  lui        $s0, %hi(gMemCardInfo)
    /* 3FBF4 8004F3F4 682D1026 */  addiu      $s0, $s0, %lo(gMemCardInfo)
    /* 3FBF8 8004F3F8 21200002 */  addu       $a0, $s0, $zero
    /* 3FBFC 8004F3FC 1800BFAF */  sw         $ra, 0x18($sp)
    /* 3FC00 8004F400 E8C5030C */  jal        blockclear
    /* 3FC04 8004F404 DC170524 */   addiu     $a1, $zero, 0x17DC
    /* 3FC08 8004F408 01000424 */  addiu      $a0, $zero, 0x1
    /* 3FC0C 8004F40C 0580023C */  lui        $v0, %hi(iMCRD_DefaultCBProc1)
    /* 3FC10 8004F410 E8064224 */  addiu      $v0, $v0, %lo(iMCRD_DefaultCBProc1)
    /* 3FC14 8004F414 240002AE */  sw         $v0, 0x24($s0)
    /* 3FC18 8004F418 200002AE */  sw         $v0, 0x20($s0)
    /* 3FC1C 8004F41C 0F80023C */  lui        $v0, %hi(setclipwindow)
    /* 3FC20 8004F420 14614224 */  addiu      $v0, $v0, %lo(setclipwindow)
    /* 3FC24 8004F424 300000AE */  sw         $zero, 0x30($s0)
    /* 3FC28 8004F428 380011AE */  sw         $s1, 0x38($s0)
    /* 3FC2C 8004F42C 2C0002AE */  sw         $v0, 0x2C($s0)
    /* 3FC30 8004F430 ABEA030C */  jal        MemCardInit
    /* 3FC34 8004F434 280002AE */   sw        $v0, 0x28($s0)
    /* 3FC38 8004F438 01001024 */  addiu      $s0, $zero, 0x1
  .L8004F43C:
    /* 3FC3C 8004F43C A1A0030C */  jal        timedwait
    /* 3FC40 8004F440 0A000424 */   addiu     $a0, $zero, 0xA
    /* 3FC44 8004F444 203D010C */  jal        iMCRD_InitCard
    /* 3FC48 8004F448 21200002 */   addu      $a0, $s0, $zero
    /* 3FC4C 8004F44C 01001026 */  addiu      $s0, $s0, 0x1
    /* 3FC50 8004F450 0900022A */  slti       $v0, $s0, 0x9
    /* 3FC54 8004F454 F9FF4014 */  bnez       $v0, .L8004F43C
    /* 3FC58 8004F458 0580043C */   lui       $a0, %hi(iMCRD_timersub)
    /* 3FC5C 8004F45C FAAB030C */  jal        addtimer
    /* 3FC60 8004F460 8C028424 */   addiu     $a0, $a0, %lo(iMCRD_timersub)
    /* 3FC64 8004F464 BEEA030C */  jal        MemCardStart
    /* 3FC68 8004F468 00000000 */   nop
    /* 3FC6C 8004F46C 1800BF8F */  lw         $ra, 0x18($sp)
    /* 3FC70 8004F470 1400B18F */  lw         $s1, 0x14($sp)
    /* 3FC74 8004F474 1000B08F */  lw         $s0, 0x10($sp)
    /* 3FC78 8004F478 0800E003 */  jr         $ra
    /* 3FC7C 8004F47C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel MCRD_init
