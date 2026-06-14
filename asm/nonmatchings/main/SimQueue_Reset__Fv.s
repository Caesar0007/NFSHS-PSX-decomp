.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SimQueue_Reset__Fv, 0xA0

glabel SimQueue_Reset__Fv
    /* A7B18 800B7318 21280000 */  addu       $a1, $zero, $zero
    /* A7B1C 800B731C 01000824 */  addiu      $t0, $zero, 0x1
    /* A7B20 800B7320 1480023C */  lui        $v0, %hi(D_8013E0F4)
    /* A7B24 800B7324 F4E04624 */  addiu      $a2, $v0, %lo(D_8013E0F4)
    /* A7B28 800B7328 2138C000 */  addu       $a3, $a2, $zero
    /* A7B2C 800B732C 21100001 */  addu       $v0, $t0, $zero
    /* A7B30 800B7330 EC0E82AF */  sw         $v0, %gp_rel(gSimQueue_BlockSelf)($gp)
    /* A7B34 800B7334 F00E82AF */  sw         $v0, %gp_rel(gSimQueue_BlockOther)($gp)
    /* A7B38 800B7338 21200000 */  addu       $a0, $zero, $zero
  .L800B733C:
    /* A7B3C 800B733C C0190500 */  sll        $v1, $a1, 7
  .L800B7340:
    /* A7B40 800B7340 04008228 */  slti       $v0, $a0, 0x4
    /* A7B44 800B7344 03004010 */  beqz       $v0, .L800B7354
    /* A7B48 800B7348 21106600 */   addu      $v0, $v1, $a2
    /* A7B4C 800B734C D7DC0208 */  j          .L800B735C
    /* A7B50 800B7350 000148AC */   sw        $t0, 0x100($v0)
  .L800B7354:
    /* A7B54 800B7354 000140AC */  sw         $zero, 0x100($v0)
    /* A7B58 800B7358 21106600 */  addu       $v0, $v1, $a2
  .L800B735C:
    /* A7B5C 800B735C 01008424 */  addiu      $a0, $a0, 0x1
    /* A7B60 800B7360 000040A0 */  sb         $zero, 0x0($v0)
    /* A7B64 800B7364 010040A0 */  sb         $zero, 0x1($v0)
    /* A7B68 800B7368 020040A0 */  sb         $zero, 0x2($v0)
    /* A7B6C 800B736C 030040A0 */  sb         $zero, 0x3($v0)
    /* A7B70 800B7370 20008228 */  slti       $v0, $a0, 0x20
    /* A7B74 800B7374 F2FF4014 */  bnez       $v0, .L800B7340
    /* A7B78 800B7378 04006324 */   addiu     $v1, $v1, 0x4
    /* A7B7C 800B737C 04000224 */  addiu      $v0, $zero, 0x4
    /* A7B80 800B7380 0402E2AC */  sw         $v0, 0x204($a3)
    /* A7B84 800B7384 2138E200 */  addu       $a3, $a3, $v0
    /* A7B88 800B7388 0100A524 */  addiu      $a1, $a1, 0x1
    /* A7B8C 800B738C 0200A228 */  slti       $v0, $a1, 0x2
    /* A7B90 800B7390 EAFF4014 */  bnez       $v0, .L800B733C
    /* A7B94 800B7394 21200000 */   addu      $a0, $zero, $zero
    /* A7B98 800B7398 1480023C */  lui        $v0, %hi(D_8013E2F4)
    /* A7B9C 800B739C F4E240AC */  sw         $zero, %lo(D_8013E2F4)($v0)
    /* A7BA0 800B73A0 03000224 */  addiu      $v0, $zero, 0x3
    /* A7BA4 800B73A4 E80E82AF */  sw         $v0, %gp_rel(gSimQueue_Ticker)($gp)
    /* A7BA8 800B73A8 F00E80AF */  sw         $zero, %gp_rel(gSimQueue_BlockOther)($gp)
    /* A7BAC 800B73AC EC0E80AF */  sw         $zero, %gp_rel(gSimQueue_BlockSelf)($gp)
    /* A7BB0 800B73B0 0800E003 */  jr         $ra
    /* A7BB4 800B73B4 00000000 */   nop
endlabel SimQueue_Reset__Fv
