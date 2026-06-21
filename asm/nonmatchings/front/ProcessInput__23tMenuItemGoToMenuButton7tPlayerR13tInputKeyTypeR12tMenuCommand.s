.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__23tMenuItemGoToMenuButton7tPlayerR13tInputKeyTypeR12tMenuCommand, 0x90

glabel ProcessInput__23tMenuItemGoToMenuButton7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* 15BA4 800253A4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 15BA8 800253A8 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 15BAC 800253AC 1800B0AF */  sw         $s0, 0x18($sp)
    /* 15BB0 800253B0 0000858C */  lw         $a1, 0x0($a0)
    /* 15BB4 800253B4 00000000 */  nop
    /* 15BB8 800253B8 0100A230 */  andi       $v0, $a1, 0x1
    /* 15BBC 800253BC 19004014 */  bnez       $v0, .L80025424
    /* 15BC0 800253C0 2180C000 */   addu      $s0, $a2, $zero
    /* 15BC4 800253C4 0000038E */  lw         $v1, 0x0($s0)
    /* 15BC8 800253C8 02000224 */  addiu      $v0, $zero, 0x2
    /* 15BCC 800253CC 15006214 */  bne        $v1, $v0, .L80025424
    /* 15BD0 800253D0 00000000 */   nop
    /* 15BD4 800253D4 1400828C */  lw         $v0, 0x14($a0)
    /* 15BD8 800253D8 00000000 */  nop
    /* 15BDC 800253DC 09004010 */  beqz       $v0, .L80025404
    /* 15BE0 800253E0 4000A230 */   andi      $v0, $a1, 0x40
    /* 15BE4 800253E4 03004010 */  beqz       $v0, .L800253F4
    /* 15BE8 800253E8 01000224 */   addiu     $v0, $zero, 0x1
    /* 15BEC 800253EC FE940008 */  j          .L800253F8
    /* 15BF0 800253F0 0000E3AC */   sw        $v1, 0x0($a3)
  .L800253F4:
    /* 15BF4 800253F4 0000E2AC */  sw         $v0, 0x0($a3)
  .L800253F8:
    /* 15BF8 800253F8 1400828C */  lw         $v0, 0x14($a0)
    /* 15BFC 800253FC 00000000 */  nop
    /* 15C00 80025400 0400E2AC */  sw         $v0, 0x4($a3)
  .L80025404:
    /* 15C04 80025404 1C00828C */  lw         $v0, 0x1C($a0)
    /* 15C08 80025408 00000000 */  nop
    /* 15C0C 8002540C 03004010 */  beqz       $v0, .L8002541C
    /* 15C10 80025410 00000000 */   nop
    /* 15C14 80025414 09F84000 */  jalr       $v0
    /* 15C18 80025418 2120E000 */   addu      $a0, $a3, $zero
  .L8002541C:
    /* 15C1C 8002541C 01000224 */  addiu      $v0, $zero, 0x1
    /* 15C20 80025420 000002AE */  sw         $v0, 0x0($s0)
  .L80025424:
    /* 15C24 80025424 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 15C28 80025428 1800B08F */  lw         $s0, 0x18($sp)
    /* 15C2C 8002542C 0800E003 */  jr         $ra
    /* 15C30 80025430 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ProcessInput__23tMenuItemGoToMenuButton7tPlayerR13tInputKeyTypeR12tMenuCommand
