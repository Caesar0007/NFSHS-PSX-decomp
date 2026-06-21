.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _padIntQuery, 0xD8

glabel _padIntQuery
    /* FC8F0 8010C0F0 1380033C */  lui        $v1, %hi(_padSioChan)
    /* FC8F4 8010C0F4 B87C638C */  lw         $v1, %lo(_padSioChan)($v1)
    /* FC8F8 8010C0F8 1380023C */  lui        $v0, %hi(_padChanStart)
    /* FC8FC 8010C0FC C87C428C */  lw         $v0, %lo(_padChanStart)($v0)
    /* FC900 8010C100 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* FC904 8010C104 1000B0AF */  sw         $s0, 0x10($sp)
    /* FC908 8010C108 21808000 */  addu       $s0, $a0, $zero
    /* FC90C 8010C10C 10006214 */  bne        $v1, $v0, .L8010C150
    /* FC910 8010C110 1400BFAF */   sw        $ra, 0x14($sp)
    /* FC914 8010C114 1380023C */  lui        $v0, %hi(_padGunExec)
    /* FC918 8010C118 B47C428C */  lw         $v0, %lo(_padGunExec)($v0)
    /* FC91C 8010C11C 00000000 */  nop
    /* FC920 8010C120 0B004010 */  beqz       $v0, .L8010C150
    /* FC924 8010C124 00000000 */   nop
    /* FC928 8010C128 1380023C */  lui        $v0, %hi(_padFuncGetGunPos)
    /* FC92C 8010C12C A87C428C */  lw         $v0, %lo(_padFuncGetGunPos)($v0)
    /* FC930 8010C130 00000000 */  nop
    /* FC934 8010C134 09F84000 */  jalr       $v0
    /* FC938 8010C138 00000000 */   nop
    /* FC93C 8010C13C 1380023C */  lui        $v0, %hi(_padFuncSetGunPort)
    /* FC940 8010C140 A47C428C */  lw         $v0, %lo(_padFuncSetGunPort)($v0)
    /* FC944 8010C144 00000000 */  nop
    /* FC948 8010C148 09F84000 */  jalr       $v0
    /* FC94C 8010C14C 00000000 */   nop
  .L8010C150:
    /* FC950 8010C150 1480023C */  lui        $v0, %hi(D_8013C310)
    /* FC954 8010C154 10C3428C */  lw         $v0, %lo(D_8013C310)($v0)
    /* FC958 8010C158 00000000 */  nop
    /* FC95C 8010C15C 0D004010 */  beqz       $v0, .L8010C194
    /* FC960 8010C160 00000000 */   nop
    /* FC964 8010C164 0C00048E */  lw         $a0, 0xC($s0)
    /* FC968 8010C168 1380023C */  lui        $v0, %hi(_padFuncSendAuto)
    /* FC96C 8010C16C 907C428C */  lw         $v0, %lo(_padFuncSendAuto)($v0)
    /* FC970 8010C170 00000000 */  nop
    /* FC974 8010C174 09F84000 */  jalr       $v0
    /* FC978 8010C178 00000000 */   nop
    /* FC97C 8010C17C 0C00048E */  lw         $a0, 0xC($s0)
    /* FC980 8010C180 1380023C */  lui        $v0, %hi(_padFuncSendAuto)
    /* FC984 8010C184 907C428C */  lw         $v0, %lo(_padFuncSendAuto)($v0)
    /* FC988 8010C188 00000000 */  nop
    /* FC98C 8010C18C 09F84000 */  jalr       $v0
    /* FC990 8010C190 F0008424 */   addiu     $a0, $a0, 0xF0
  .L8010C194:
    /* FC994 8010C194 36000292 */  lbu        $v0, 0x36($s0)
    /* FC998 8010C198 00000000 */  nop
    /* FC99C 8010C19C 03004014 */  bnez       $v0, .L8010C1AC
    /* FC9A0 8010C1A0 21200002 */   addu      $a0, $s0, $zero
    /* FC9A4 8010C1A4 6C300408 */  j          .L8010C1B0
    /* FC9A8 8010C1A8 42000524 */   addiu     $a1, $zero, 0x42
  .L8010C1AC:
    /* FC9AC 8010C1AC 36000592 */  lbu        $a1, 0x36($s0)
  .L8010C1B0:
    /* FC9B0 8010C1B0 C014040C */  jal        _padSioRW2
    /* FC9B4 8010C1B4 00000000 */   nop
    /* FC9B8 8010C1B8 1400BF8F */  lw         $ra, 0x14($sp)
    /* FC9BC 8010C1BC 1000B08F */  lw         $s0, 0x10($sp)
    /* FC9C0 8010C1C0 0800E003 */  jr         $ra
    /* FC9C4 8010C1C4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel _padIntQuery
