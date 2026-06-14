.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching addsystemtask, 0xB4

glabel addsystemtask
    /* D72F4 800E6AF4 21488000 */  addu       $t1, $a0, $zero
    /* D72F8 800E6AF8 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* D72FC 800E6AFC 21200000 */  addu       $a0, $zero, $zero
    /* D7300 800E6B00 21506000 */  addu       $t2, $v1, $zero
    /* D7304 800E6B04 1480023C */  lui        $v0, %hi(D_8013E980)
    /* D7308 800E6B08 EC16878F */  lw         $a3, %gp_rel(D_8013DC38)($gp)
    /* D730C 800E6B0C 80E94824 */  addiu      $t0, $v0, %lo(D_8013E980)
    /* D7310 800E6B10 0100E224 */  addiu      $v0, $a3, 0x1
    /* D7314 800E6B14 EC1682AF */  sw         $v0, %gp_rel(D_8013DC38)($gp)
  .L800E6B18:
    /* D7318 800E6B18 0000028D */  lw         $v0, 0x0($t0)
    /* D731C 800E6B1C 00000000 */  nop
    /* D7320 800E6B20 09004910 */  beq        $v0, $t1, .L800E6B48
    /* D7324 800E6B24 00000000 */   nop
    /* D7328 800E6B28 08004014 */  bnez       $v0, .L800E6B4C
    /* D732C 800E6B2C 00000000 */   nop
    /* D7330 800E6B30 06006A14 */  bne        $v1, $t2, .L800E6B4C
    /* D7334 800E6B34 00000000 */   nop
    /* D7338 800E6B38 0300E010 */  beqz       $a3, .L800E6B48
    /* D733C 800E6B3C 00000000 */   nop
    /* D7340 800E6B40 D39A0308 */  j          .L800E6B4C
    /* D7344 800E6B44 FFFFE724 */   addiu     $a3, $a3, -0x1
  .L800E6B48:
    /* D7348 800E6B48 21188000 */  addu       $v1, $a0, $zero
  .L800E6B4C:
    /* D734C 800E6B4C 01008424 */  addiu      $a0, $a0, 0x1
    /* D7350 800E6B50 10008228 */  slti       $v0, $a0, 0x10
    /* D7354 800E6B54 F0FF4014 */  bnez       $v0, .L800E6B18
    /* D7358 800E6B58 10000825 */   addiu     $t0, $t0, 0x10
    /* D735C 800E6B5C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* D7360 800E6B60 0B006210 */  beq        $v1, $v0, .L800E6B90
    /* D7364 800E6B64 1480023C */   lui       $v0, %hi(D_8013E980)
    /* D7368 800E6B68 80E94224 */  addiu      $v0, $v0, %lo(D_8013E980)
    /* D736C 800E6B6C 00190300 */  sll        $v1, $v1, 4
    /* D7370 800E6B70 1480043C */  lui        $a0, %hi(libticks)
    /* D7374 800E6B74 B0DC848C */  lw         $a0, %lo(libticks)($a0)
    /* D7378 800E6B78 21186200 */  addu       $v1, $v1, $v0
    /* D737C 800E6B7C 000069AC */  sw         $t1, 0x0($v1)
    /* D7380 800E6B80 040065AC */  sw         $a1, 0x4($v1)
    /* D7384 800E6B84 0C0060AC */  sw         $zero, 0xC($v1)
    /* D7388 800E6B88 21208600 */  addu       $a0, $a0, $a2
    /* D738C 800E6B8C 080064AC */  sw         $a0, 0x8($v1)
  .L800E6B90:
    /* D7390 800E6B90 EC16828F */  lw         $v0, %gp_rel(D_8013DC38)($gp)
    /* D7394 800E6B94 00000000 */  nop
    /* D7398 800E6B98 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* D739C 800E6B9C EC1682AF */  sw         $v0, %gp_rel(D_8013DC38)($gp)
    /* D73A0 800E6BA0 0800E003 */  jr         $ra
    /* D73A4 800E6BA4 00000000 */   nop
endlabel addsystemtask
