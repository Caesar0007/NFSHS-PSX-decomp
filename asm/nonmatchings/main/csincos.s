.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching csincos, 0x11C

glabel csincos
    /* F72C4 80106AC4 A0FFBD27 */  addiu      $sp, $sp, -0x60
    /* F72C8 80106AC8 21400000 */  addu       $t0, $zero, $zero
    /* F72CC 80106ACC 4400AB27 */  addiu      $t3, $sp, 0x44
    /* F72D0 80106AD0 14800A3C */  lui        $t2, %hi(H_cor_tbl)
    /* F72D4 80106AD4 20BF4A25 */  addiu      $t2, $t2, %lo(H_cor_tbl)
    /* F72D8 80106AD8 2400A927 */  addiu      $t1, $sp, 0x24
    /* F72DC 80106ADC 2138A003 */  addu       $a3, $sp, $zero
    /* F72E0 80106AE0 B7090224 */  addiu      $v0, $zero, 0x9B7
    /* F72E4 80106AE4 0000A2AF */  sw         $v0, 0x0($sp)
    /* F72E8 80106AE8 2000A0AF */  sw         $zero, 0x20($sp)
    /* F72EC 80106AEC 4000A4AF */  sw         $a0, 0x40($sp)
  .L80106AF0:
    /* F72F0 80106AF0 4000E28C */  lw         $v0, 0x40($a3)
    /* F72F4 80106AF4 00000000 */  nop
    /* F72F8 80106AF8 0F004004 */  bltz       $v0, .L80106B38
    /* F72FC 80106AFC 00000000 */   nop
    /* F7300 80106B00 2000E28C */  lw         $v0, 0x20($a3)
    /* F7304 80106B04 0000E38C */  lw         $v1, 0x0($a3)
    /* F7308 80106B08 07100201 */  srav       $v0, $v0, $t0
    /* F730C 80106B0C 23186200 */  subu       $v1, $v1, $v0
    /* F7310 80106B10 0000E28C */  lw         $v0, 0x0($a3)
    /* F7314 80106B14 0400E3AC */  sw         $v1, 0x4($a3)
    /* F7318 80106B18 2000E38C */  lw         $v1, 0x20($a3)
    /* F731C 80106B1C 07100201 */  srav       $v0, $v0, $t0
    /* F7320 80106B20 21186200 */  addu       $v1, $v1, $v0
    /* F7324 80106B24 000023AD */  sw         $v1, 0x0($t1)
    /* F7328 80106B28 4000E28C */  lw         $v0, 0x40($a3)
    /* F732C 80106B2C 0000438D */  lw         $v1, 0x0($t2)
    /* F7330 80106B30 DC1A0408 */  j          .L80106B70
    /* F7334 80106B34 23104300 */   subu      $v0, $v0, $v1
  .L80106B38:
    /* F7338 80106B38 2000E28C */  lw         $v0, 0x20($a3)
    /* F733C 80106B3C 0000E38C */  lw         $v1, 0x0($a3)
    /* F7340 80106B40 07100201 */  srav       $v0, $v0, $t0
    /* F7344 80106B44 21186200 */  addu       $v1, $v1, $v0
    /* F7348 80106B48 0000E28C */  lw         $v0, 0x0($a3)
    /* F734C 80106B4C 0400E3AC */  sw         $v1, 0x4($a3)
    /* F7350 80106B50 2000E38C */  lw         $v1, 0x20($a3)
    /* F7354 80106B54 07100201 */  srav       $v0, $v0, $t0
    /* F7358 80106B58 23186200 */  subu       $v1, $v1, $v0
    /* F735C 80106B5C 000023AD */  sw         $v1, 0x0($t1)
    /* F7360 80106B60 4000E28C */  lw         $v0, 0x40($a3)
    /* F7364 80106B64 0000438D */  lw         $v1, 0x0($t2)
    /* F7368 80106B68 00000000 */  nop
    /* F736C 80106B6C 21104300 */  addu       $v0, $v0, $v1
  .L80106B70:
    /* F7370 80106B70 000062AD */  sw         $v0, 0x0($t3)
    /* F7374 80106B74 04006B25 */  addiu      $t3, $t3, 0x4
    /* F7378 80106B78 04004A25 */  addiu      $t2, $t2, 0x4
    /* F737C 80106B7C 04002925 */  addiu      $t1, $t1, 0x4
    /* F7380 80106B80 01000825 */  addiu      $t0, $t0, 0x1
    /* F7384 80106B84 06000229 */  slti       $v0, $t0, 0x6
    /* F7388 80106B88 D9FF4014 */  bnez       $v0, .L80106AF0
    /* F738C 80106B8C 0400E724 */   addiu     $a3, $a3, 0x4
    /* F7390 80106B90 5800A38F */  lw         $v1, 0x58($sp)
    /* F7394 80106B94 3800A28F */  lw         $v0, 0x38($sp)
    /* F7398 80106B98 00000000 */  nop
    /* F739C 80106B9C 18006200 */  mult       $v1, $v0
    /* F73A0 80106BA0 1800A28F */  lw         $v0, 0x18($sp)
    /* F73A4 80106BA4 12600000 */  mflo       $t4
    /* F73A8 80106BA8 031B0C00 */  sra        $v1, $t4, 12
    /* F73AC 80106BAC 23104300 */  subu       $v0, $v0, $v1
    /* F73B0 80106BB0 0000C2AC */  sw         $v0, 0x0($a2)
    /* F73B4 80106BB4 5800A38F */  lw         $v1, 0x58($sp)
    /* F73B8 80106BB8 1800A28F */  lw         $v0, 0x18($sp)
    /* F73BC 80106BBC 00000000 */  nop
    /* F73C0 80106BC0 18006200 */  mult       $v1, $v0
    /* F73C4 80106BC4 3800A28F */  lw         $v0, 0x38($sp)
    /* F73C8 80106BC8 12600000 */  mflo       $t4
    /* F73CC 80106BCC 031B0C00 */  sra        $v1, $t4, 12
    /* F73D0 80106BD0 21104300 */  addu       $v0, $v0, $v1
    /* F73D4 80106BD4 0000A2AC */  sw         $v0, 0x0($a1)
    /* F73D8 80106BD8 0800E003 */  jr         $ra
    /* F73DC 80106BDC 6000BD27 */   addiu     $sp, $sp, 0x60
endlabel csincos
    /* F73E0 80106BE0 00000000 */  nop
