.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching unrefpack, 0x278

glabel unrefpack
    /* E5AB8 800F52B8 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* E5ABC 800F52BC 1800B0AF */  sw         $s0, 0x18($sp)
    /* E5AC0 800F52C0 2180C000 */  addu       $s0, $a2, $zero
    /* E5AC4 800F52C4 2000B2AF */  sw         $s2, 0x20($sp)
    /* E5AC8 800F52C8 21908000 */  addu       $s2, $a0, $zero
    /* E5ACC 800F52CC 2400B3AF */  sw         $s3, 0x24($sp)
    /* E5AD0 800F52D0 2198A000 */  addu       $s3, $a1, $zero
    /* E5AD4 800F52D4 2800B4AF */  sw         $s4, 0x28($sp)
    /* E5AD8 800F52D8 21A00000 */  addu       $s4, $zero, $zero
    /* E5ADC 800F52DC 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* E5AE0 800F52E0 8A004012 */  beqz       $s2, .L800F550C
    /* E5AE4 800F52E4 1C00B1AF */   sw        $s1, 0x1C($sp)
    /* E5AE8 800F52E8 23CC030C */  jal        geti
    /* E5AEC 800F52EC 04000524 */   addiu     $a1, $zero, 0x4
    /* E5AF0 800F52F0 01004230 */  andi       $v0, $v0, 0x1
    /* E5AF4 800F52F4 02004010 */  beqz       $v0, .L800F5300
    /* E5AF8 800F52F8 02005226 */   addiu     $s2, $s2, 0x2
    /* E5AFC 800F52FC 03005226 */  addiu      $s2, $s2, 0x3
  .L800F5300:
    /* E5B00 800F5300 00004292 */  lbu        $v0, 0x0($s2)
    /* E5B04 800F5304 01004392 */  lbu        $v1, 0x1($s2)
    /* E5B08 800F5308 02004492 */  lbu        $a0, 0x2($s2)
    /* E5B0C 800F530C 03005226 */  addiu      $s2, $s2, 0x3
    /* E5B10 800F5310 00140200 */  sll        $v0, $v0, 16
    /* E5B14 800F5314 001A0300 */  sll        $v1, $v1, 8
    /* E5B18 800F5318 21104300 */  addu       $v0, $v0, $v1
    /* E5B1C 800F531C 7B000012 */  beqz       $s0, .L800F550C
    /* E5B20 800F5320 21A04400 */   addu      $s4, $v0, $a0
    /* E5B24 800F5324 21207402 */  addu       $a0, $s3, $s4
    /* E5B28 800F5328 23CC030C */  jal        geti
    /* E5B2C 800F532C 04000524 */   addiu     $a1, $zero, 0x4
    /* E5B30 800F5330 1000A427 */  addiu      $a0, $sp, 0x10
    /* E5B34 800F5334 21284000 */  addu       $a1, $v0, $zero
    /* E5B38 800F5338 35CC030C */  jal        puti
    /* E5B3C 800F533C 04000624 */   addiu     $a2, $zero, 0x4
  .L800F5340:
    /* E5B40 800F5340 21204002 */  addu       $a0, $s2, $zero
    /* E5B44 800F5344 23CC030C */  jal        geti
    /* E5B48 800F5348 04000524 */   addiu     $a1, $zero, 0x4
    /* E5B4C 800F534C 21884000 */  addu       $s1, $v0, $zero
    /* E5B50 800F5350 80002232 */  andi       $v0, $s1, 0x80
    /* E5B54 800F5354 17004014 */  bnez       $v0, .L800F53B4
    /* E5B58 800F5358 40002232 */   andi      $v0, $s1, 0x40
    /* E5B5C 800F535C 02005226 */  addiu      $s2, $s2, 0x2
    /* E5B60 800F5360 03003032 */  andi       $s0, $s1, 0x3
    /* E5B64 800F5364 21204002 */  addu       $a0, $s2, $zero
    /* E5B68 800F5368 23CC030C */  jal        geti
    /* E5B6C 800F536C 04000524 */   addiu     $a1, $zero, 0x4
    /* E5B70 800F5370 21206002 */  addu       $a0, $s3, $zero
    /* E5B74 800F5374 21284000 */  addu       $a1, $v0, $zero
    /* E5B78 800F5378 35CC030C */  jal        puti
    /* E5B7C 800F537C 04000624 */   addiu     $a2, $zero, 0x4
    /* E5B80 800F5380 21987002 */  addu       $s3, $s3, $s0
    /* E5B84 800F5384 21905002 */  addu       $s2, $s2, $s0
    /* E5B88 800F5388 21206002 */  addu       $a0, $s3, $zero
    /* E5B8C 800F538C C0281100 */  sll        $a1, $s1, 3
    /* E5B90 800F5390 0003A530 */  andi       $a1, $a1, 0x300
    /* E5B94 800F5394 02121100 */  srl        $v0, $s1, 8
    /* E5B98 800F5398 FF004230 */  andi       $v0, $v0, 0xFF
    /* E5B9C 800F539C 01004224 */  addiu      $v0, $v0, 0x1
    /* E5BA0 800F53A0 2128A200 */  addu       $a1, $a1, $v0
    /* E5BA4 800F53A4 82301100 */  srl        $a2, $s1, 2
    /* E5BA8 800F53A8 0700C630 */  andi       $a2, $a2, 0x7
    /* E5BAC 800F53AC 22D50308 */  j          .L800F5488
    /* E5BB0 800F53B0 0300C624 */   addiu     $a2, $a2, 0x3
  .L800F53B4:
    /* E5BB4 800F53B4 18004014 */  bnez       $v0, .L800F5418
    /* E5BB8 800F53B8 20002232 */   andi      $v0, $s1, 0x20
    /* E5BBC 800F53BC 03005226 */  addiu      $s2, $s2, 0x3
    /* E5BC0 800F53C0 82131100 */  srl        $v0, $s1, 14
    /* E5BC4 800F53C4 03005030 */  andi       $s0, $v0, 0x3
    /* E5BC8 800F53C8 21204002 */  addu       $a0, $s2, $zero
    /* E5BCC 800F53CC 23CC030C */  jal        geti
    /* E5BD0 800F53D0 04000524 */   addiu     $a1, $zero, 0x4
    /* E5BD4 800F53D4 21206002 */  addu       $a0, $s3, $zero
    /* E5BD8 800F53D8 21284000 */  addu       $a1, $v0, $zero
    /* E5BDC 800F53DC 35CC030C */  jal        puti
    /* E5BE0 800F53E0 04000624 */   addiu     $a2, $zero, 0x4
    /* E5BE4 800F53E4 21987002 */  addu       $s3, $s3, $s0
    /* E5BE8 800F53E8 21905002 */  addu       $s2, $s2, $s0
    /* E5BEC 800F53EC 21206002 */  addu       $a0, $s3, $zero
    /* E5BF0 800F53F0 02121100 */  srl        $v0, $s1, 8
    /* E5BF4 800F53F4 00120200 */  sll        $v0, $v0, 8
    /* E5BF8 800F53F8 003F4230 */  andi       $v0, $v0, 0x3F00
    /* E5BFC 800F53FC 022C1100 */  srl        $a1, $s1, 16
    /* E5C00 800F5400 FF00A530 */  andi       $a1, $a1, 0xFF
    /* E5C04 800F5404 0100A524 */  addiu      $a1, $a1, 0x1
    /* E5C08 800F5408 21284500 */  addu       $a1, $v0, $a1
    /* E5C0C 800F540C 3F002632 */  andi       $a2, $s1, 0x3F
    /* E5C10 800F5410 22D50308 */  j          .L800F5488
    /* E5C14 800F5414 0400C624 */   addiu     $a2, $a2, 0x4
  .L800F5418:
    /* E5C18 800F5418 1F004014 */  bnez       $v0, .L800F5498
    /* E5C1C 800F541C FF002232 */   andi      $v0, $s1, 0xFF
    /* E5C20 800F5420 04005226 */  addiu      $s2, $s2, 0x4
    /* E5C24 800F5424 03003032 */  andi       $s0, $s1, 0x3
    /* E5C28 800F5428 21204002 */  addu       $a0, $s2, $zero
    /* E5C2C 800F542C 23CC030C */  jal        geti
    /* E5C30 800F5430 04000524 */   addiu     $a1, $zero, 0x4
    /* E5C34 800F5434 21206002 */  addu       $a0, $s3, $zero
    /* E5C38 800F5438 21284000 */  addu       $a1, $v0, $zero
    /* E5C3C 800F543C 35CC030C */  jal        puti
    /* E5C40 800F5440 04000624 */   addiu     $a2, $zero, 0x4
    /* E5C44 800F5444 21987002 */  addu       $s3, $s3, $s0
    /* E5C48 800F5448 21905002 */  addu       $s2, $s2, $s0
    /* E5C4C 800F544C 21206002 */  addu       $a0, $s3, $zero
    /* E5C50 800F5450 001B1100 */  sll        $v1, $s1, 12
    /* E5C54 800F5454 0100023C */  lui        $v0, (0x10000 >> 16)
    /* E5C58 800F5458 24186200 */  and        $v1, $v1, $v0
    /* E5C5C 800F545C 00FF2232 */  andi       $v0, $s1, 0xFF00
    /* E5C60 800F5460 01004224 */  addiu      $v0, $v0, 0x1
    /* E5C64 800F5464 21186200 */  addu       $v1, $v1, $v0
    /* E5C68 800F5468 022C1100 */  srl        $a1, $s1, 16
    /* E5C6C 800F546C FF00A530 */  andi       $a1, $a1, 0xFF
    /* E5C70 800F5470 21286500 */  addu       $a1, $v1, $a1
    /* E5C74 800F5474 80311100 */  sll        $a2, $s1, 6
    /* E5C78 800F5478 0003C630 */  andi       $a2, $a2, 0x300
    /* E5C7C 800F547C 02161100 */  srl        $v0, $s1, 24
    /* E5C80 800F5480 2130C200 */  addu       $a2, $a2, $v0
    /* E5C84 800F5484 0500C624 */  addiu      $a2, $a2, 0x5
  .L800F5488:
    /* E5C88 800F5488 95D4030C */  jal        refcpy
    /* E5C8C 800F548C 00000000 */   nop
    /* E5C90 800F5490 D0D40308 */  j          .L800F5340
    /* E5C94 800F5494 21984000 */   addu      $s3, $v0, $zero
  .L800F5498:
    /* E5C98 800F5498 FC00422C */  sltiu      $v0, $v0, 0xFC
    /* E5C9C 800F549C 0B004010 */  beqz       $v0, .L800F54CC
    /* E5CA0 800F54A0 01005226 */   addiu     $s2, $s2, 0x1
    /* E5CA4 800F54A4 1F002232 */  andi       $v0, $s1, 0x1F
    /* E5CA8 800F54A8 01004224 */  addiu      $v0, $v0, 0x1
    /* E5CAC 800F54AC 80800200 */  sll        $s0, $v0, 2
    /* E5CB0 800F54B0 21206002 */  addu       $a0, $s3, $zero
    /* E5CB4 800F54B4 21284002 */  addu       $a1, $s2, $zero
    /* E5CB8 800F54B8 70D4030C */  jal        memcpyl
    /* E5CBC 800F54BC 21300002 */   addu      $a2, $s0, $zero
    /* E5CC0 800F54C0 21987002 */  addu       $s3, $s3, $s0
    /* E5CC4 800F54C4 D0D40308 */  j          .L800F5340
    /* E5CC8 800F54C8 21905002 */   addu      $s2, $s2, $s0
  .L800F54CC:
    /* E5CCC 800F54CC 03003032 */  andi       $s0, $s1, 0x3
    /* E5CD0 800F54D0 08000012 */  beqz       $s0, .L800F54F4
    /* E5CD4 800F54D4 1000A427 */   addiu     $a0, $sp, 0x10
  .L800F54D8:
    /* E5CD8 800F54D8 00004292 */  lbu        $v0, 0x0($s2)
    /* E5CDC 800F54DC 01005226 */  addiu      $s2, $s2, 0x1
    /* E5CE0 800F54E0 FFFF1026 */  addiu      $s0, $s0, -0x1
    /* E5CE4 800F54E4 000062A2 */  sb         $v0, 0x0($s3)
    /* E5CE8 800F54E8 FBFF0016 */  bnez       $s0, .L800F54D8
    /* E5CEC 800F54EC 01007326 */   addiu     $s3, $s3, 0x1
    /* E5CF0 800F54F0 1000A427 */  addiu      $a0, $sp, 0x10
  .L800F54F4:
    /* E5CF4 800F54F4 23CC030C */  jal        geti
    /* E5CF8 800F54F8 04000524 */   addiu     $a1, $zero, 0x4
    /* E5CFC 800F54FC 21206002 */  addu       $a0, $s3, $zero
    /* E5D00 800F5500 21284000 */  addu       $a1, $v0, $zero
    /* E5D04 800F5504 35CC030C */  jal        puti
    /* E5D08 800F5508 04000624 */   addiu     $a2, $zero, 0x4
  .L800F550C:
    /* E5D0C 800F550C 21108002 */  addu       $v0, $s4, $zero
    /* E5D10 800F5510 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* E5D14 800F5514 2800B48F */  lw         $s4, 0x28($sp)
    /* E5D18 800F5518 2400B38F */  lw         $s3, 0x24($sp)
    /* E5D1C 800F551C 2000B28F */  lw         $s2, 0x20($sp)
    /* E5D20 800F5520 1C00B18F */  lw         $s1, 0x1C($sp)
    /* E5D24 800F5524 1800B08F */  lw         $s0, 0x18($sp)
    /* E5D28 800F5528 0800E003 */  jr         $ra
    /* E5D2C 800F552C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel unrefpack
