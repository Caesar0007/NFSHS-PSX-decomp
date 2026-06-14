.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_CalculateRoadPositionFromSliceAndPosition__FiP8coorddefP10matrixtdef, 0xF4

glabel Newton_CalculateRoadPositionFromSliceAndPosition__FiP8coorddefP10matrixtdef
    /* 94360 800A3B60 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 94364 800A3B64 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* 94368 800A3B68 C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* 9436C 800A3B6C 40210400 */  sll        $a0, $a0, 5
    /* 94370 800A3B70 21208200 */  addu       $a0, $a0, $v0
    /* 94374 800A3B74 0000898C */  lw         $t1, 0x0($a0)
    /* 94378 800A3B78 04008A8C */  lw         $t2, 0x4($a0)
    /* 9437C 800A3B7C 08008B8C */  lw         $t3, 0x8($a0)
    /* 94380 800A3B80 0000A9AF */  sw         $t1, 0x0($sp)
    /* 94384 800A3B84 0400AAAF */  sw         $t2, 0x4($sp)
    /* 94388 800A3B88 0800ABAF */  sw         $t3, 0x8($sp)
    /* 9438C 800A3B8C 0000A38C */  lw         $v1, 0x0($a1)
    /* 94390 800A3B90 0000A28F */  lw         $v0, 0x0($sp)
    /* 94394 800A3B94 00000000 */  nop
    /* 94398 800A3B98 23386200 */  subu       $a3, $v1, $v0
    /* 9439C 800A3B9C 1000A7AF */  sw         $a3, 0x10($sp)
    /* 943A0 800A3BA0 0400A38C */  lw         $v1, 0x4($a1)
    /* 943A4 800A3BA4 0400A28F */  lw         $v0, 0x4($sp)
    /* 943A8 800A3BA8 00000000 */  nop
    /* 943AC 800A3BAC 23406200 */  subu       $t0, $v1, $v0
    /* 943B0 800A3BB0 1400A8AF */  sw         $t0, 0x14($sp)
    /* 943B4 800A3BB4 0800A38C */  lw         $v1, 0x8($a1)
    /* 943B8 800A3BB8 0800A28F */  lw         $v0, 0x8($sp)
    /* 943BC 800A3BBC 00000000 */  nop
    /* 943C0 800A3BC0 23186200 */  subu       $v1, $v1, $v0
    /* 943C4 800A3BC4 1800A3AF */  sw         $v1, 0x18($sp)
    /* 943C8 800A3BC8 0000C48C */  lw         $a0, 0x0($a2)
    /* 943CC 800A3BCC 00000000 */  nop
    /* 943D0 800A3BD0 02008104 */  bgez       $a0, .L800A3BDC
    /* 943D4 800A3BD4 2110E000 */   addu      $v0, $a3, $zero
    /* 943D8 800A3BD8 FF008424 */  addiu      $a0, $a0, 0xFF
  .L800A3BDC:
    /* 943DC 800A3BDC 02004104 */  bgez       $v0, .L800A3BE8
    /* 943E0 800A3BE0 032A0400 */   sra       $a1, $a0, 8
    /* 943E4 800A3BE4 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A3BE8:
    /* 943E8 800A3BE8 03120200 */  sra        $v0, $v0, 8
    /* 943EC 800A3BEC 1800A200 */  mult       $a1, $v0
    /* 943F0 800A3BF0 0400C48C */  lw         $a0, 0x4($a2)
    /* 943F4 800A3BF4 12280000 */  mflo       $a1
    /* 943F8 800A3BF8 02008104 */  bgez       $a0, .L800A3C04
    /* 943FC 800A3BFC 21100001 */   addu      $v0, $t0, $zero
    /* 94400 800A3C00 FF008424 */  addiu      $a0, $a0, 0xFF
  .L800A3C04:
    /* 94404 800A3C04 02004104 */  bgez       $v0, .L800A3C10
    /* 94408 800A3C08 03220400 */   sra       $a0, $a0, 8
    /* 9440C 800A3C0C FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A3C10:
    /* 94410 800A3C10 03120200 */  sra        $v0, $v0, 8
    /* 94414 800A3C14 18008200 */  mult       $a0, $v0
    /* 94418 800A3C18 0800C68C */  lw         $a2, 0x8($a2)
    /* 9441C 800A3C1C 12480000 */  mflo       $t1
    /* 94420 800A3C20 0200C104 */  bgez       $a2, .L800A3C2C
    /* 94424 800A3C24 2120A900 */   addu      $a0, $a1, $t1
    /* 94428 800A3C28 FF00C624 */  addiu      $a2, $a2, 0xFF
  .L800A3C2C:
    /* 9442C 800A3C2C 21106000 */  addu       $v0, $v1, $zero
    /* 94430 800A3C30 02004104 */  bgez       $v0, .L800A3C3C
    /* 94434 800A3C34 03320600 */   sra       $a2, $a2, 8
    /* 94438 800A3C38 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A3C3C:
    /* 9443C 800A3C3C 03120200 */  sra        $v0, $v0, 8
    /* 94440 800A3C40 1800C200 */  mult       $a2, $v0
    /* 94444 800A3C44 12480000 */  mflo       $t1
    /* 94448 800A3C48 21108900 */  addu       $v0, $a0, $t1
    /* 9444C 800A3C4C 0800E003 */  jr         $ra
    /* 94450 800A3C50 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Newton_CalculateRoadPositionFromSliceAndPosition__FiP8coorddefP10matrixtdef
