.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CD_newmedia, 0x2C4

glabel CD_newmedia
    /* E9B80 800F9380 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* E9B84 800F9384 01000424 */  addiu      $a0, $zero, 0x1
    /* E9B88 800F9388 10000524 */  addiu      $a1, $zero, 0x10
    /* E9B8C 800F938C 2000B0AF */  sw         $s0, 0x20($sp)
    /* E9B90 800F9390 1480103C */  lui        $s0, %hi(D_8014647C)
    /* E9B94 800F9394 7C641026 */  addiu      $s0, $s0, %lo(D_8014647C)
    /* E9B98 800F9398 21300002 */  addu       $a2, $s0, $zero
    /* E9B9C 800F939C 3C00BFAF */  sw         $ra, 0x3C($sp)
    /* E9BA0 800F93A0 3800B6AF */  sw         $s6, 0x38($sp)
    /* E9BA4 800F93A4 3400B5AF */  sw         $s5, 0x34($sp)
    /* E9BA8 800F93A8 3000B4AF */  sw         $s4, 0x30($sp)
    /* E9BAC 800F93AC 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* E9BB0 800F93B0 2800B2AF */  sw         $s2, 0x28($sp)
    /* E9BB4 800F93B4 61E6030C */  jal        cd_read
    /* E9BB8 800F93B8 2400B1AF */   sw        $s1, 0x24($sp)
    /* E9BBC 800F93BC 21884000 */  addu       $s1, $v0, $zero
    /* E9BC0 800F93C0 01000224 */  addiu      $v0, $zero, 0x1
    /* E9BC4 800F93C4 0B002212 */  beq        $s1, $v0, .L800F93F4
    /* E9BC8 800F93C8 01000426 */   addiu     $a0, $s0, 0x1
    /* E9BCC 800F93CC 1480023C */  lui        $v0, %hi(CD_debug)
    /* E9BD0 800F93D0 50BF428C */  lw         $v0, %lo(CD_debug)($v0)
    /* E9BD4 800F93D4 00000000 */  nop
    /* E9BD8 800F93D8 90004018 */  blez       $v0, .L800F961C
    /* E9BDC 800F93DC 21100000 */   addu      $v0, $zero, $zero
    /* E9BE0 800F93E0 0580043C */  lui        $a0, %hi(D_8005720C)
    /* E9BE4 800F93E4 2B0A040C */  jal        printf
    /* E9BE8 800F93E8 0C728424 */   addiu     $a0, $a0, %lo(D_8005720C)
    /* E9BEC 800F93EC 87E50308 */  j          .L800F961C
    /* E9BF0 800F93F0 21100000 */   addu      $v0, $zero, $zero
  .L800F93F4:
    /* E9BF4 800F93F4 0580053C */  lui        $a1, %hi(D_80057238)
    /* E9BF8 800F93F8 3872A524 */  addiu      $a1, $a1, %lo(D_80057238)
    /* E9BFC 800F93FC 74AC030C */  jal        strncmp
    /* E9C00 800F9400 05000624 */   addiu     $a2, $zero, 0x5
    /* E9C04 800F9404 0B004010 */  beqz       $v0, .L800F9434
    /* E9C08 800F9408 00000000 */   nop
    /* E9C0C 800F940C 1480023C */  lui        $v0, %hi(CD_debug)
    /* E9C10 800F9410 50BF428C */  lw         $v0, %lo(CD_debug)($v0)
    /* E9C14 800F9414 00000000 */  nop
    /* E9C18 800F9418 80004018 */  blez       $v0, .L800F961C
    /* E9C1C 800F941C 21100000 */   addu      $v0, $zero, $zero
    /* E9C20 800F9420 0580043C */  lui        $a0, %hi(D_80057240)
    /* E9C24 800F9424 2B0A040C */  jal        printf
    /* E9C28 800F9428 40728424 */   addiu     $a0, $a0, %lo(D_80057240)
    /* E9C2C 800F942C 87E50308 */  j          .L800F961C
    /* E9C30 800F9430 21100000 */   addu      $v0, $zero, $zero
  .L800F9434:
    /* E9C34 800F9434 8F00028A */  lwl        $v0, 0x8F($s0)
    /* E9C38 800F9438 8C00029A */  lwr        $v0, 0x8C($s0)
    /* E9C3C 800F943C 00000000 */  nop
    /* E9C40 800F9440 1B00A2AB */  swl        $v0, 0x1B($sp)
    /* E9C44 800F9444 1800A2BB */  swr        $v0, 0x18($sp)
    /* E9C48 800F9448 01000424 */  addiu      $a0, $zero, 0x1
    /* E9C4C 800F944C 1800A58F */  lw         $a1, 0x18($sp)
    /* E9C50 800F9450 61E6030C */  jal        cd_read
    /* E9C54 800F9454 21300002 */   addu      $a2, $s0, $zero
    /* E9C58 800F9458 0C005110 */  beq        $v0, $s1, .L800F948C
    /* E9C5C 800F945C 00000000 */   nop
    /* E9C60 800F9460 1480023C */  lui        $v0, %hi(CD_debug)
    /* E9C64 800F9464 50BF428C */  lw         $v0, %lo(CD_debug)($v0)
    /* E9C68 800F9468 00000000 */  nop
    /* E9C6C 800F946C 6B004018 */  blez       $v0, .L800F961C
    /* E9C70 800F9470 21100000 */   addu      $v0, $zero, $zero
    /* E9C74 800F9474 1800A58F */  lw         $a1, 0x18($sp)
    /* E9C78 800F9478 0580043C */  lui        $a0, %hi(D_80057270)
    /* E9C7C 800F947C 2B0A040C */  jal        printf
    /* E9C80 800F9480 70728424 */   addiu     $a0, $a0, %lo(D_80057270)
    /* E9C84 800F9484 87E50308 */  j          .L800F961C
    /* E9C88 800F9488 21100000 */   addu      $v0, $zero, $zero
  .L800F948C:
    /* E9C8C 800F948C 1480023C */  lui        $v0, %hi(CD_debug)
    /* E9C90 800F9490 50BF428C */  lw         $v0, %lo(CD_debug)($v0)
    /* E9C94 800F9494 00000000 */  nop
    /* E9C98 800F9498 02004228 */  slti       $v0, $v0, 0x2
    /* E9C9C 800F949C 04004014 */  bnez       $v0, .L800F94B0
    /* E9CA0 800F94A0 21880002 */   addu      $s1, $s0, $zero
    /* E9CA4 800F94A4 0580043C */  lui        $a0, %hi(D_80057294)
    /* E9CA8 800F94A8 2B0A040C */  jal        printf
    /* E9CAC 800F94AC 94728424 */   addiu     $a0, $a0, %lo(D_80057294)
  .L800F94B0:
    /* E9CB0 800F94B0 00082326 */  addiu      $v1, $s1, 0x800
    /* E9CB4 800F94B4 2B102302 */  sltu       $v0, $s1, $v1
    /* E9CB8 800F94B8 42004010 */  beqz       $v0, .L800F95C4
    /* E9CBC 800F94BC 21380000 */   addu      $a3, $zero, $zero
    /* E9CC0 800F94C0 1480143C */  lui        $s4, %hi(D_80144E84)
    /* E9CC4 800F94C4 844E9426 */  addiu      $s4, $s4, %lo(D_80144E84)
    /* E9CC8 800F94C8 04009626 */  addiu      $s6, $s4, 0x4
    /* E9CCC 800F94CC 21A86000 */  addu       $s5, $v1, $zero
  .L800F94D0:
    /* E9CD0 800F94D0 00002292 */  lbu        $v0, 0x0($s1)
    /* E9CD4 800F94D4 00000000 */  nop
    /* E9CD8 800F94D8 3A004010 */  beqz       $v0, .L800F95C4
    /* E9CDC 800F94DC 40100700 */   sll       $v0, $a3, 1
    /* E9CE0 800F94E0 21104700 */  addu       $v0, $v0, $a3
    /* E9CE4 800F94E4 80100200 */  sll        $v0, $v0, 2
    /* E9CE8 800F94E8 23104700 */  subu       $v0, $v0, $a3
    /* E9CEC 800F94EC 80800200 */  sll        $s0, $v0, 2
    /* E9CF0 800F94F0 21101402 */  addu       $v0, $s0, $s4
    /* E9CF4 800F94F4 0500238A */  lwl        $v1, 0x5($s1)
    /* E9CF8 800F94F8 0200239A */  lwr        $v1, 0x2($s1)
    /* E9CFC 800F94FC 00000000 */  nop
    /* E9D00 800F9500 030043A8 */  swl        $v1, 0x3($v0)
    /* E9D04 800F9504 000043B8 */  swr        $v1, 0x0($v0)
    /* E9D08 800F9508 21901602 */  addu       $s2, $s0, $s6
    /* E9D0C 800F950C 21204002 */  addu       $a0, $s2, $zero
    /* E9D10 800F9510 06002292 */  lbu        $v0, 0x6($s1)
    /* E9D14 800F9514 0100F324 */  addiu      $s3, $a3, 0x1
    /* E9D18 800F9518 1480013C */  lui        $at, %hi(D_80144E7C)
    /* E9D1C 800F951C 21083000 */  addu       $at, $at, $s0
    /* E9D20 800F9520 7C4E33AC */  sw         $s3, %lo(D_80144E7C)($at)
    /* E9D24 800F9524 1480013C */  lui        $at, %hi(D_80144E80)
    /* E9D28 800F9528 21083000 */  addu       $at, $at, $s0
    /* E9D2C 800F952C 804E22AC */  sw         $v0, %lo(D_80144E80)($at)
    /* E9D30 800F9530 00002692 */  lbu        $a2, 0x0($s1)
    /* E9D34 800F9534 B1AA030C */  jal        memcpy
    /* E9D38 800F9538 08002526 */   addiu     $a1, $s1, 0x8
    /* E9D3C 800F953C 00002292 */  lbu        $v0, 0x0($s1)
    /* E9D40 800F9540 00000000 */  nop
    /* E9D44 800F9544 21104202 */  addu       $v0, $s2, $v0
    /* E9D48 800F9548 000040A0 */  sb         $zero, 0x0($v0)
    /* E9D4C 800F954C 00002392 */  lbu        $v1, 0x0($s1)
    /* E9D50 800F9550 00000000 */  nop
    /* E9D54 800F9554 01006230 */  andi       $v0, $v1, 0x1
    /* E9D58 800F9558 08004224 */  addiu      $v0, $v0, 0x8
    /* E9D5C 800F955C 21186200 */  addu       $v1, $v1, $v0
    /* E9D60 800F9560 1480023C */  lui        $v0, %hi(CD_debug)
    /* E9D64 800F9564 50BF428C */  lw         $v0, %lo(CD_debug)($v0)
    /* E9D68 800F9568 00000000 */  nop
    /* E9D6C 800F956C 02004228 */  slti       $v0, $v0, 0x2
    /* E9D70 800F9570 0E004014 */  bnez       $v0, .L800F95AC
    /* E9D74 800F9574 21882302 */   addu      $s1, $s1, $v1
    /* E9D78 800F9578 1480053C */  lui        $a1, %hi(D_80144E84)
    /* E9D7C 800F957C 2128B000 */  addu       $a1, $a1, $s0
    /* E9D80 800F9580 844EA58C */  lw         $a1, %lo(D_80144E84)($a1)
    /* E9D84 800F9584 1480063C */  lui        $a2, %hi(D_80144E7C)
    /* E9D88 800F9588 2130D000 */  addu       $a2, $a2, $s0
    /* E9D8C 800F958C 7C4EC68C */  lw         $a2, %lo(D_80144E7C)($a2)
    /* E9D90 800F9590 1480073C */  lui        $a3, %hi(D_80144E80)
    /* E9D94 800F9594 2138F000 */  addu       $a3, $a3, $s0
    /* E9D98 800F9598 804EE78C */  lw         $a3, %lo(D_80144E80)($a3)
    /* E9D9C 800F959C 0580043C */  lui        $a0, %hi(D_800572B4)
    /* E9DA0 800F95A0 B4728424 */  addiu      $a0, $a0, %lo(D_800572B4)
    /* E9DA4 800F95A4 2B0A040C */  jal        printf
    /* E9DA8 800F95A8 1000B2AF */   sw        $s2, 0x10($sp)
  .L800F95AC:
    /* E9DAC 800F95AC 21386002 */  addu       $a3, $s3, $zero
    /* E9DB0 800F95B0 8000E228 */  slti       $v0, $a3, 0x80
    /* E9DB4 800F95B4 0D004010 */  beqz       $v0, .L800F95EC
    /* E9DB8 800F95B8 2B103502 */   sltu      $v0, $s1, $s5
    /* E9DBC 800F95BC C4FF4014 */  bnez       $v0, .L800F94D0
    /* E9DC0 800F95C0 00000000 */   nop
  .L800F95C4:
    /* E9DC4 800F95C4 8000E228 */  slti       $v0, $a3, 0x80
    /* E9DC8 800F95C8 08004010 */  beqz       $v0, .L800F95EC
    /* E9DCC 800F95CC 40100700 */   sll       $v0, $a3, 1
    /* E9DD0 800F95D0 21104700 */  addu       $v0, $v0, $a3
    /* E9DD4 800F95D4 80100200 */  sll        $v0, $v0, 2
    /* E9DD8 800F95D8 23104700 */  subu       $v0, $v0, $a3
    /* E9DDC 800F95DC 80100200 */  sll        $v0, $v0, 2
    /* E9DE0 800F95E0 1480013C */  lui        $at, %hi(D_80144E80)
    /* E9DE4 800F95E4 21082200 */  addu       $at, $at, $v0
    /* E9DE8 800F95E8 804E20AC */  sw         $zero, %lo(D_80144E80)($at)
  .L800F95EC:
    /* E9DEC 800F95EC 1480023C */  lui        $v0, %hi(CD_debug)
    /* E9DF0 800F95F0 50BF428C */  lw         $v0, %lo(CD_debug)($v0)
    /* E9DF4 800F95F4 1380013C */  lui        $at, %hi(D_80136C68)
    /* E9DF8 800F95F8 686C20AC */  sw         $zero, %lo(D_80136C68)($at)
    /* E9DFC 800F95FC 02004228 */  slti       $v0, $v0, 0x2
    /* E9E00 800F9600 06004014 */  bnez       $v0, .L800F961C
    /* E9E04 800F9604 01000224 */   addiu     $v0, $zero, 0x1
    /* E9E08 800F9608 0580043C */  lui        $a0, %hi(D_800572C8)
    /* E9E0C 800F960C C8728424 */  addiu      $a0, $a0, %lo(D_800572C8)
    /* E9E10 800F9610 2B0A040C */  jal        printf
    /* E9E14 800F9614 2128E000 */   addu      $a1, $a3, $zero
    /* E9E18 800F9618 01000224 */  addiu      $v0, $zero, 0x1
  .L800F961C:
    /* E9E1C 800F961C 3C00BF8F */  lw         $ra, 0x3C($sp)
    /* E9E20 800F9620 3800B68F */  lw         $s6, 0x38($sp)
    /* E9E24 800F9624 3400B58F */  lw         $s5, 0x34($sp)
    /* E9E28 800F9628 3000B48F */  lw         $s4, 0x30($sp)
    /* E9E2C 800F962C 2C00B38F */  lw         $s3, 0x2C($sp)
    /* E9E30 800F9630 2800B28F */  lw         $s2, 0x28($sp)
    /* E9E34 800F9634 2400B18F */  lw         $s1, 0x24($sp)
    /* E9E38 800F9638 2000B08F */  lw         $s0, 0x20($sp)
    /* E9E3C 800F963C 0800E003 */  jr         $ra
    /* E9E40 800F9640 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel CD_newmedia
