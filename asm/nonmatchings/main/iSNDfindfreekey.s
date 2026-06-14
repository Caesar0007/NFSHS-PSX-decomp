.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDfindfreekey, 0x90

glabel iSNDfindfreekey
    /* F23FC 80101BFC 1380053C */  lui        $a1, %hi(D_801371CC)
    /* F2400 80101C00 CC71A390 */  lbu        $v1, %lo(D_801371CC)($a1)
    /* F2404 80101C04 00000000 */  nop
    /* F2408 80101C08 01006224 */  addiu      $v0, $v1, 0x1
    /* F240C 80101C0C CC71A2A0 */  sb         $v0, %lo(D_801371CC)($a1)
    /* F2410 80101C10 FF004230 */  andi       $v0, $v0, 0xFF
    /* F2414 80101C14 04004014 */  bnez       $v0, .L80101C28
    /* F2418 80101C18 1480023C */   lui       $v0, %hi(sndgs)
    /* F241C 80101C1C 02006224 */  addiu      $v0, $v1, 0x2
    /* F2420 80101C20 CC71A2A0 */  sb         $v0, %lo(D_801371CC)($a1)
    /* F2424 80101C24 1480023C */  lui        $v0, %hi(sndgs)
  .L80101C28:
    /* F2428 80101C28 60784224 */  addiu      $v0, $v0, %lo(sndgs)
    /* F242C 80101C2C 11004390 */  lbu        $v1, 0x11($v0)
    /* F2430 80101C30 00000000 */  nop
    /* F2434 80101C34 11006010 */  beqz       $v1, .L80101C7C
    /* F2438 80101C38 21200000 */   addu      $a0, $zero, $zero
    /* F243C 80101C3C 21306000 */  addu       $a2, $v1, $zero
    /* F2440 80101C40 CC71A590 */  lbu        $a1, %lo(D_801371CC)($a1)
    /* F2444 80101C44 9400438C */  lw         $v1, 0x94($v0)
  .L80101C48:
    /* F2448 80101C48 00000000 */  nop
    /* F244C 80101C4C 0B006280 */  lb         $v0, 0xB($v1)
    /* F2450 80101C50 00000000 */  nop
    /* F2454 80101C54 05004010 */  beqz       $v0, .L80101C6C
    /* F2458 80101C58 00000000 */   nop
    /* F245C 80101C5C 37006290 */  lbu        $v0, 0x37($v1)
    /* F2460 80101C60 00000000 */  nop
    /* F2464 80101C64 E5FF4510 */  beq        $v0, $a1, iSNDfindfreekey
    /* F2468 80101C68 00000000 */   nop
  .L80101C6C:
    /* F246C 80101C6C 01008424 */  addiu      $a0, $a0, 0x1
    /* F2470 80101C70 2A108600 */  slt        $v0, $a0, $a2
    /* F2474 80101C74 F4FF4014 */  bnez       $v0, .L80101C48
    /* F2478 80101C78 64006324 */   addiu     $v1, $v1, 0x64
  .L80101C7C:
    /* F247C 80101C7C 1380023C */  lui        $v0, %hi(D_801371CC)
    /* F2480 80101C80 CC714290 */  lbu        $v0, %lo(D_801371CC)($v0)
    /* F2484 80101C84 0800E003 */  jr         $ra
    /* F2488 80101C88 00000000 */   nop
endlabel iSNDfindfreekey
