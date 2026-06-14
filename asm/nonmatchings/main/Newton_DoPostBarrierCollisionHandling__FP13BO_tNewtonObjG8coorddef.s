.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef, 0x1A8

glabel Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef
    /* 932F0 800A2AF0 90FFBD27 */  addiu      $sp, $sp, -0x70
    /* 932F4 800A2AF4 6400B1AF */  sw         $s1, 0x64($sp)
    /* 932F8 800A2AF8 21888000 */  addu       $s1, $a0, $zero
    /* 932FC 800A2AFC 0100023C */  lui        $v0, (0x10000 >> 16)
    /* 93300 800A2B00 6800BFAF */  sw         $ra, 0x68($sp)
    /* 93304 800A2B04 6000B0AF */  sw         $s0, 0x60($sp)
    /* 93308 800A2B08 7400A5AF */  sw         $a1, 0x74($sp)
    /* 9330C 800A2B0C 7800A6AF */  sw         $a2, 0x78($sp)
    /* 93310 800A2B10 7C00A7AF */  sw         $a3, 0x7C($sp)
    /* 93314 800A2B14 2800A0AF */  sw         $zero, 0x28($sp)
    /* 93318 800A2B18 2C00A2AF */  sw         $v0, 0x2C($sp)
    /* 9331C 800A2B1C 3000A0AF */  sw         $zero, 0x30($sp)
    /* 93320 800A2B20 0200E104 */  bgez       $a3, .L800A2B2C
    /* 93324 800A2B24 2110E000 */   addu      $v0, $a3, $zero
    /* 93328 800A2B28 FF00E224 */  addiu      $v0, $a3, 0xFF
  .L800A2B2C:
    /* 9332C 800A2B2C 03120200 */  sra        $v0, $v0, 8
    /* 93330 800A2B30 00120200 */  sll        $v0, $v0, 8
    /* 93334 800A2B34 23100200 */  negu       $v0, $v0
    /* 93338 800A2B38 1800A2AF */  sw         $v0, 0x18($sp)
    /* 9333C 800A2B3C 2138A000 */  addu       $a3, $a1, $zero
    /* 93340 800A2B40 0200E104 */  bgez       $a3, .L800A2B4C
    /* 93344 800A2B44 2110E000 */   addu      $v0, $a3, $zero
    /* 93348 800A2B48 FF00E224 */  addiu      $v0, $a3, 0xFF
  .L800A2B4C:
    /* 9334C 800A2B4C 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* 93350 800A2B50 031A0200 */  sra        $v1, $v0, 8
    /* 93354 800A2B54 2110C000 */  addu       $v0, $a2, $zero
    /* 93358 800A2B58 0200C104 */  bgez       $a2, .L800A2B64
    /* 9335C 800A2B5C 005A0300 */   sll       $t3, $v1, 8
    /* 93360 800A2B60 FF00C224 */  addiu      $v0, $a2, 0xFF
  .L800A2B64:
    /* 93364 800A2B64 2000ABAF */  sw         $t3, 0x20($sp)
    /* 93368 800A2B68 032A0200 */  sra        $a1, $v0, 8
    /* 9336C 800A2B6C AC00228E */  lw         $v0, 0xAC($s1)
    /* 93370 800A2B70 00000000 */  nop
    /* 93374 800A2B74 02004104 */  bgez       $v0, .L800A2B80
    /* 93378 800A2B78 00000000 */   nop
    /* 9337C 800A2B7C FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A2B80:
    /* 93380 800A2B80 03120200 */  sra        $v0, $v0, 8
    /* 93384 800A2B84 18006200 */  mult       $v1, $v0
    /* 93388 800A2B88 12200000 */  mflo       $a0
    /* 9338C 800A2B8C B000228E */  lw         $v0, 0xB0($s1)
    /* 93390 800A2B90 00000000 */  nop
    /* 93394 800A2B94 02004104 */  bgez       $v0, .L800A2BA0
    /* 93398 800A2B98 00000000 */   nop
    /* 9339C 800A2B9C FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A2BA0:
    /* 933A0 800A2BA0 03120200 */  sra        $v0, $v0, 8
    /* 933A4 800A2BA4 1800A200 */  mult       $a1, $v0
    /* 933A8 800A2BA8 7C00AA8F */  lw         $t2, 0x7C($sp)
    /* 933AC 800A2BAC 00000000 */  nop
    /* 933B0 800A2BB0 21184001 */  addu       $v1, $t2, $zero
    /* 933B4 800A2BB4 12600000 */  mflo       $t4
    /* 933B8 800A2BB8 02004105 */  bgez       $t2, .L800A2BC4
    /* 933BC 800A2BBC 21208C00 */   addu      $a0, $a0, $t4
    /* 933C0 800A2BC0 FF004325 */  addiu      $v1, $t2, 0xFF
  .L800A2BC4:
    /* 933C4 800A2BC4 B400228E */  lw         $v0, 0xB4($s1)
    /* 933C8 800A2BC8 00000000 */  nop
    /* 933CC 800A2BCC 02004104 */  bgez       $v0, .L800A2BD8
    /* 933D0 800A2BD0 031A0300 */   sra       $v1, $v1, 8
    /* 933D4 800A2BD4 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A2BD8:
    /* 933D8 800A2BD8 03120200 */  sra        $v0, $v0, 8
    /* 933DC 800A2BDC 18006200 */  mult       $v1, $v0
    /* 933E0 800A2BE0 12600000 */  mflo       $t4
    /* 933E4 800A2BE4 21108C00 */  addu       $v0, $a0, $t4
    /* 933E8 800A2BE8 02004104 */  bgez       $v0, .L800A2BF4
    /* 933EC 800A2BEC 00000000 */   nop
    /* 933F0 800A2BF0 23100200 */  negu       $v0, $v0
  .L800A2BF4:
    /* 933F4 800A2BF4 23100200 */  negu       $v0, $v0
    /* 933F8 800A2BF8 03004104 */  bgez       $v0, .L800A2C08
    /* 933FC 800A2BFC 03190200 */   sra       $v1, $v0, 4
    /* 93400 800A2C00 0F004224 */  addiu      $v0, $v0, 0xF
    /* 93404 800A2C04 03190200 */  sra        $v1, $v0, 4
  .L800A2C08:
    /* 93408 800A2C08 53F86228 */  slti       $v0, $v1, -0x7AD
    /* 9340C 800A2C0C 02004010 */  beqz       $v0, .L800A2C18
    /* 93410 800A2C10 52F80524 */   addiu     $a1, $zero, -0x7AE
    /* 93414 800A2C14 21286000 */  addu       $a1, $v1, $zero
  .L800A2C18:
    /* 93418 800A2C18 21202002 */  addu       $a0, $s1, $zero
    /* 9341C 800A2C1C 3800A7AF */  sw         $a3, 0x38($sp)
    /* 93420 800A2C20 7800A28F */  lw         $v0, 0x78($sp)
    /* 93424 800A2C24 2C00A38F */  lw         $v1, 0x2C($sp)
    /* 93428 800A2C28 3000A78F */  lw         $a3, 0x30($sp)
    /* 9342C 800A2C2C 1800A88F */  lw         $t0, 0x18($sp)
    /* 93430 800A2C30 1C00A98F */  lw         $t1, 0x1C($sp)
    /* 93434 800A2C34 3800A627 */  addiu      $a2, $sp, 0x38
    /* 93438 800A2C38 4000AAAF */  sw         $t2, 0x40($sp)
    /* 9343C 800A2C3C 4400A0AF */  sw         $zero, 0x44($sp)
    /* 93440 800A2C40 5800ABAF */  sw         $t3, 0x58($sp)
    /* 93444 800A2C44 3C00A2AF */  sw         $v0, 0x3C($sp)
    /* 93448 800A2C48 4800A3AF */  sw         $v1, 0x48($sp)
    /* 9344C 800A2C4C 4C00A7AF */  sw         $a3, 0x4C($sp)
    /* 93450 800A2C50 5000A8AF */  sw         $t0, 0x50($sp)
    /* 93454 800A2C54 9FA3020C */  jal        Physics_AttenuateVelocity__FP8Car_tObjiP10matrixtdef
    /* 93458 800A2C58 5400A9AF */   sw        $t1, 0x54($sp)
    /* 9345C 800A2C5C 04000424 */  addiu      $a0, $zero, 0x4
    /* 93460 800A2C60 B6A4020C */  jal        Physics_SetCurrentWallType__Fi
    /* 93464 800A2C64 21804000 */   addu      $s0, $v0, $zero
    /* 93468 800A2C68 7C00A28F */  lw         $v0, 0x7C($sp)
    /* 9346C 800A2C6C 21202002 */  addu       $a0, $s1, $zero
    /* 93470 800A2C70 1000A2AF */  sw         $v0, 0x10($sp)
    /* 93474 800A2C74 7400A68F */  lw         $a2, 0x74($sp)
    /* 93478 800A2C78 7800A78F */  lw         $a3, 0x78($sp)
    /* 9347C 800A2C7C C8A4020C */  jal        Physics_CorrectPostCollisionYaw__FP8Car_tObjiG8coorddef
    /* 93480 800A2C80 21280002 */   addu      $a1, $s0, $zero
    /* 93484 800A2C84 6800BF8F */  lw         $ra, 0x68($sp)
    /* 93488 800A2C88 6400B18F */  lw         $s1, 0x64($sp)
    /* 9348C 800A2C8C 6000B08F */  lw         $s0, 0x60($sp)
    /* 93490 800A2C90 0800E003 */  jr         $ra
    /* 93494 800A2C94 7000BD27 */   addiu     $sp, $sp, 0x70
endlabel Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef
