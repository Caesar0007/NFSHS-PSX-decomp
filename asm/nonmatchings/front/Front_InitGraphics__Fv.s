.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Front_InitGraphics__Fv, 0x78

glabel Front_InitGraphics__Fv
    /* 1825C 80027A5C C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* 18260 80027A60 21200000 */  addu       $a0, $zero, $zero
    /* 18264 80027A64 01000524 */  addiu      $a1, $zero, 0x1
    /* 18268 80027A68 3800BFAF */  sw         $ra, 0x38($sp)
    /* 1826C 80027A6C 7DC1030C */  jal        initlinkmode
    /* 18270 80027A70 2130A000 */   addu      $a2, $a1, $zero
    /* 18274 80027A74 1000A427 */  addiu      $a0, $sp, 0x10
    /* 18278 80027A78 1180023C */  lui        $v0, %hi(D_801164F4)
    /* 1827C 80027A7C 0180053C */  lui        $a1, %hi(D_800114A4)
    /* 18280 80027A80 F464468C */  lw         $a2, %lo(D_801164F4)($v0)
    /* 18284 80027A84 2F91030C */  jal        sprintf
    /* 18288 80027A88 A414A524 */   addiu     $a1, $a1, %lo(D_800114A4)
    /* 1828C 80027A8C 1000A427 */  addiu      $a0, $sp, 0x10
    /* 18290 80027A90 21280000 */  addu       $a1, $zero, $zero
    /* 18294 80027A94 64000624 */  addiu      $a2, $zero, 0x64
    /* 18298 80027A98 1480073C */  lui        $a3, %hi(gFEBigHandle)
    /* 1829C 80027A9C 7EAA030C */  jal        FILE_addbigsync
    /* 182A0 80027AA0 80D2E724 */   addiu     $a3, $a3, %lo(gFEBigHandle)
    /* 182A4 80027AA4 03004014 */  bnez       $v0, .L80027AB4
    /* 182A8 80027AA8 00000000 */   nop
  .L80027AAC:
    /* 182AC 80027AAC AB9E0008 */  j          .L80027AAC
    /* 182B0 80027AB0 00000000 */   nop
  .L80027AB4:
    /* 182B4 80027AB4 2871030C */  jal        Platform_ResetDCTBuffer__Fv
    /* 182B8 80027AB8 00000000 */   nop
    /* 182BC 80027ABC 7E37010C */  jal        Init_PSX_FrontEnd__Fv
    /* 182C0 80027AC0 00000000 */   nop
    /* 182C4 80027AC4 3800BF8F */  lw         $ra, 0x38($sp)
    /* 182C8 80027AC8 00000000 */  nop
    /* 182CC 80027ACC 0800E003 */  jr         $ra
    /* 182D0 80027AD0 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel Front_InitGraphics__Fv
