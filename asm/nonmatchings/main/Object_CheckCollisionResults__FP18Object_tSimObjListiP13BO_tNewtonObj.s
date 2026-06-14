.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Object_CheckCollisionResults__FP18Object_tSimObjListiP13BO_tNewtonObj, 0x298

glabel Object_CheckCollisionResults__FP18Object_tSimObjListiP13BO_tNewtonObj
    /* 95AF0 800A52F0 B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* 95AF4 800A52F4 21108000 */  addu       $v0, $a0, $zero
    /* 95AF8 800A52F8 3000B0AF */  sw         $s0, 0x30($sp)
    /* 95AFC 800A52FC 21800000 */  addu       $s0, $zero, $zero
    /* 95B00 800A5300 2120A000 */  addu       $a0, $a1, $zero
    /* 95B04 800A5304 21284000 */  addu       $a1, $v0, $zero
    /* 95B08 800A5308 4800B6AF */  sw         $s6, 0x48($sp)
    /* 95B0C 800A530C 21B0C000 */  addu       $s6, $a2, $zero
    /* 95B10 800A5310 2800A627 */  addiu      $a2, $sp, 0x28
    /* 95B14 800A5314 4C00BFAF */  sw         $ra, 0x4C($sp)
    /* 95B18 800A5318 4400B5AF */  sw         $s5, 0x44($sp)
    /* 95B1C 800A531C 4000B4AF */  sw         $s4, 0x40($sp)
    /* 95B20 800A5320 3C00B3AF */  sw         $s3, 0x3C($sp)
    /* 95B24 800A5324 3800B2AF */  sw         $s2, 0x38($sp)
    /* 95B28 800A5328 3400B1AF */  sw         $s1, 0x34($sp)
    /* 95B2C 800A532C AC00C38E */  lw         $v1, 0xAC($s6)
    /* 95B30 800A5330 B400C28E */  lw         $v0, 0xB4($s6)
    /* 95B34 800A5334 02006104 */  bgez       $v1, .L800A5340
    /* 95B38 800A5338 00000000 */   nop
    /* 95B3C 800A533C 23180300 */  negu       $v1, $v1
  .L800A5340:
    /* 95B40 800A5340 02004104 */  bgez       $v0, .L800A534C
    /* 95B44 800A5344 00000000 */   nop
    /* 95B48 800A5348 23100200 */  negu       $v0, $v0
  .L800A534C:
    /* 95B4C 800A534C 21186200 */  addu       $v1, $v1, $v0
    /* 95B50 800A5350 C593020C */  jal        GetSimObj__FiP18Object_tSimObjListPi
    /* 95B54 800A5354 038C0300 */   sra       $s1, $v1, 16
    /* 95B58 800A5358 21984000 */  addu       $s3, $v0, $zero
    /* 95B5C 800A535C 1180033C */  lui        $v1, %hi(gSimObjAnims)
    /* 95B60 800A5360 605D6324 */  addiu      $v1, $v1, %lo(gSimObjAnims)
    /* 95B64 800A5364 0E006286 */  lh         $v0, 0xE($s3)
    /* 95B68 800A5368 13006492 */  lbu        $a0, 0x13($s3)
    /* 95B6C 800A536C 80100200 */  sll        $v0, $v0, 2
    /* 95B70 800A5370 21104300 */  addu       $v0, $v0, $v1
    /* 95B74 800A5374 0F008430 */  andi       $a0, $a0, 0xF
    /* 95B78 800A5378 02000324 */  addiu      $v1, $zero, 0x2
    /* 95B7C 800A537C 0000428C */  lw         $v0, 0x0($v0)
    /* 95B80 800A5380 0D008310 */  beq        $a0, $v1, .L800A53B8
    /* 95B84 800A5384 00000000 */   nop
    /* 95B88 800A5388 03008228 */  slti       $v0, $a0, 0x3
    /* 95B8C 800A538C 05004010 */  beqz       $v0, .L800A53A4
    /* 95B90 800A5390 01000224 */   addiu     $v0, $zero, 0x1
    /* 95B94 800A5394 6E008210 */  beq        $a0, $v0, .L800A5550
    /* 95B98 800A5398 21100002 */   addu      $v0, $s0, $zero
    /* 95B9C 800A539C 58950208 */  j          .L800A5560
    /* 95BA0 800A53A0 00000000 */   nop
  .L800A53A4:
    /* 95BA4 800A53A4 03000224 */  addiu      $v0, $zero, 0x3
    /* 95BA8 800A53A8 6B008210 */  beq        $a0, $v0, .L800A5558
    /* 95BAC 800A53AC 21100002 */   addu      $v0, $s0, $zero
    /* 95BB0 800A53B0 58950208 */  j          .L800A5560
    /* 95BB4 800A53B4 00000000 */   nop
  .L800A53B8:
    /* 95BB8 800A53B8 69004014 */  bnez       $v0, .L800A5560
    /* 95BBC 800A53BC 21100002 */   addu      $v0, $s0, $zero
    /* 95BC0 800A53C0 63002006 */  bltz       $s1, .L800A5550
    /* 95BC4 800A53C4 00000000 */   nop
    /* 95BC8 800A53C8 2800A38F */  lw         $v1, 0x28($sp)
    /* 95BCC 800A53CC 12006592 */  lbu        $a1, 0x12($s3)
    /* 95BD0 800A53D0 C0100300 */  sll        $v0, $v1, 3
    /* 95BD4 800A53D4 23104300 */  subu       $v0, $v0, $v1
    /* 95BD8 800A53D8 1480033C */  lui        $v1, %hi(Track_chunkList)
    /* 95BDC 800A53DC B8D4638C */  lw         $v1, %lo(Track_chunkList)($v1)
    /* 95BE0 800A53E0 00110200 */  sll        $v0, $v0, 4
    /* 95BE4 800A53E4 21186200 */  addu       $v1, $v1, $v0
    /* 95BE8 800A53E8 4000648C */  lw         $a0, 0x40($v1)
    /* 95BEC 800A53EC 2393020C */  jal        FindObjInstanceFromSerialNum__FP5Groupi
    /* 95BF0 800A53F0 00000000 */   nop
    /* 95BF4 800A53F4 21A04000 */  addu       $s4, $v0, $zero
    /* 95BF8 800A53F8 02004390 */  lbu        $v1, 0x2($v0)
    /* 95BFC 800A53FC 06000224 */  addiu      $v0, $zero, 0x6
    /* 95C00 800A5400 04006214 */  bne        $v1, $v0, .L800A5414
    /* 95C04 800A5404 00000000 */   nop
    /* 95C08 800A5408 0D008292 */  lbu        $v0, 0xD($s4)
    /* 95C0C 800A540C 08950208 */  j          .L800A5420
    /* 95C10 800A5410 80180200 */   sll       $v1, $v0, 2
  .L800A5414:
    /* 95C14 800A5414 23008292 */  lbu        $v0, 0x23($s4)
    /* 95C18 800A5418 00000000 */  nop
    /* 95C1C 800A541C 80180200 */  sll        $v1, $v0, 2
  .L800A5420:
    /* 95C20 800A5420 21186200 */  addu       $v1, $v1, $v0
    /* 95C24 800A5424 80180300 */  sll        $v1, $v1, 2
    /* 95C28 800A5428 1180023C */  lui        $v0, %hi(gAnimDefs)
    /* 95C2C 800A542C 485C4224 */  addiu      $v0, $v0, %lo(gAnimDefs)
    /* 95C30 800A5430 21906200 */  addu       $s2, $v1, $v0
    /* 95C34 800A5434 1000428E */  lw         $v0, 0x10($s2)
    /* 95C38 800A5438 00000000 */  nop
    /* 95C3C 800A543C 05004010 */  beqz       $v0, .L800A5454
    /* 95C40 800A5440 00000000 */   nop
    /* 95C44 800A5444 1480023C */  lui        $v0, %hi(gPersistObjDef)
    /* 95C48 800A5448 BCD4428C */  lw         $v0, %lo(gPersistObjDef)($v0)
    /* 95C4C 800A544C 1B950208 */  j          .L800A546C
    /* 95C50 800A5450 04005524 */   addiu     $s5, $v0, 0x4
  .L800A5454:
    /* 95C54 800A5454 06008286 */  lh         $v0, 0x6($s4)
    /* 95C58 800A5458 1480033C */  lui        $v1, %hi(Track_gObjDefs)
    /* 95C5C 800A545C D4D4638C */  lw         $v1, %lo(Track_gObjDefs)($v1)
    /* 95C60 800A5460 80100200 */  sll        $v0, $v0, 2
    /* 95C64 800A5464 21104300 */  addu       $v0, $v0, $v1
    /* 95C68 800A5468 0000558C */  lw         $s5, 0x0($v0)
  .L800A546C:
    /* 95C6C 800A546C 0000438E */  lw         $v1, 0x0($s2)
    /* 95C70 800A5470 00000000 */  nop
    /* 95C74 800A5474 15006010 */  beqz       $v1, .L800A54CC
    /* 95C78 800A5478 01000224 */   addiu     $v0, $zero, 0x1
    /* 95C7C 800A547C 37006214 */  bne        $v1, $v0, .L800A555C
    /* 95C80 800A5480 FFFF1024 */   addiu     $s0, $zero, -0x1
    /* 95C84 800A5484 578F020C */  jal        __builtin_new
    /* 95C88 800A5488 04000424 */   addiu     $a0, $zero, 0x4
    /* 95C8C 800A548C 30000424 */  addiu      $a0, $zero, 0x30
    /* 95C90 800A5490 21804000 */  addu       $s0, $v0, $zero
    /* 95C94 800A5494 0580023C */  lui        $v0, %hi(_vt_23ObjectFinishedMultiAnim)
    /* 95C98 800A5498 D0604224 */  addiu      $v0, $v0, %lo(_vt_23ObjectFinishedMultiAnim)
    /* 95C9C 800A549C 578F020C */  jal        __builtin_new
    /* 95CA0 800A54A0 000002AE */   sw        $v0, 0x0($s0)
    /* 95CA4 800A54A4 21204000 */  addu       $a0, $v0, $zero
    /* 95CA8 800A54A8 AC00C526 */  addiu      $a1, $s6, 0xAC
    /* 95CAC 800A54AC 21304002 */  addu       $a2, $s2, $zero
    /* 95CB0 800A54B0 21388002 */  addu       $a3, $s4, $zero
    /* 95CB4 800A54B4 1000B5AF */  sw         $s5, 0x10($sp)
    /* 95CB8 800A54B8 1400B3AF */  sw         $s3, 0x14($sp)
    /* 95CBC 800A54BC 8098020C */  jal        __15ObjectMultiAnimP8coorddefP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectP23ObjectFinishedMultiAnim
    /* 95CC0 800A54C0 1800B0AF */   sw        $s0, 0x18($sp)
    /* 95CC4 800A54C4 4D950208 */  j          .L800A5534
    /* 95CC8 800A54C8 1180043C */   lui       $a0, %hi(gSimObjAnims)
  .L800A54CC:
    /* 95CCC 800A54CC 578F020C */  jal        __builtin_new
    /* 95CD0 800A54D0 30000424 */   addiu     $a0, $zero, 0x30
    /* 95CD4 800A54D4 30000424 */  addiu      $a0, $zero, 0x30
    /* 95CD8 800A54D8 21884000 */  addu       $s1, $v0, $zero
    /* 95CDC 800A54DC 0580023C */  lui        $v0, %hi(_vt_22ObjectFinishedSignAnim)
    /* 95CE0 800A54E0 A0604224 */  addiu      $v0, $v0, %lo(_vt_22ObjectFinishedSignAnim)
    /* 95CE4 800A54E4 578F020C */  jal        __builtin_new
    /* 95CE8 800A54E8 000022AE */   sw        $v0, 0x0($s1)
    /* 95CEC 800A54EC 21804000 */  addu       $s0, $v0, $zero
    /* 95CF0 800A54F0 AC00C48E */  lw         $a0, 0xAC($s6)
    /* 95CF4 800A54F4 B400C58E */  lw         $a1, 0xB4($s6)
    /* 95CF8 800A54F8 03220400 */  sra        $a0, $a0, 8
    /* 95CFC 800A54FC 4AB5030C */  jal        fixedatan
    /* 95D00 800A5500 032A0500 */   sra       $a1, $a1, 8
    /* 95D04 800A5504 21200002 */  addu       $a0, $s0, $zero
    /* 95D08 800A5508 AC00C526 */  addiu      $a1, $s6, 0xAC
    /* 95D0C 800A550C 03320200 */  sra        $a2, $v0, 8
    /* 95D10 800A5510 21384002 */  addu       $a3, $s2, $zero
    /* 95D14 800A5514 5001C226 */  addiu      $v0, $s6, 0x150
    /* 95D18 800A5518 1000B4AF */  sw         $s4, 0x10($sp)
    /* 95D1C 800A551C 1400B5AF */  sw         $s5, 0x14($sp)
    /* 95D20 800A5520 1800B3AF */  sw         $s3, 0x18($sp)
    /* 95D24 800A5524 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* 95D28 800A5528 D999020C */  jal        __14ObjectSignAnimP8coorddefiP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectT1P22ObjectFinishedSignAnim
    /* 95D2C 800A552C 2000B1AF */   sw        $s1, 0x20($sp)
    /* 95D30 800A5530 1180043C */  lui        $a0, %hi(gSimObjAnims)
  .L800A5534:
    /* 95D34 800A5534 0E006386 */  lh         $v1, 0xE($s3)
    /* 95D38 800A5538 605D8424 */  addiu      $a0, $a0, %lo(gSimObjAnims)
    /* 95D3C 800A553C 80180300 */  sll        $v1, $v1, 2
    /* 95D40 800A5540 21186400 */  addu       $v1, $v1, $a0
    /* 95D44 800A5544 000062AC */  sw         $v0, 0x0($v1)
    /* 95D48 800A5548 57950208 */  j          .L800A555C
    /* 95D4C 800A554C FFFF1024 */   addiu     $s0, $zero, -0x1
  .L800A5550:
    /* 95D50 800A5550 57950208 */  j          .L800A555C
    /* 95D54 800A5554 01001024 */   addiu     $s0, $zero, 0x1
  .L800A5558:
    /* 95D58 800A5558 02001024 */  addiu      $s0, $zero, 0x2
  .L800A555C:
    /* 95D5C 800A555C 21100002 */  addu       $v0, $s0, $zero
  .L800A5560:
    /* 95D60 800A5560 4C00BF8F */  lw         $ra, 0x4C($sp)
    /* 95D64 800A5564 4800B68F */  lw         $s6, 0x48($sp)
    /* 95D68 800A5568 4400B58F */  lw         $s5, 0x44($sp)
    /* 95D6C 800A556C 4000B48F */  lw         $s4, 0x40($sp)
    /* 95D70 800A5570 3C00B38F */  lw         $s3, 0x3C($sp)
    /* 95D74 800A5574 3800B28F */  lw         $s2, 0x38($sp)
    /* 95D78 800A5578 3400B18F */  lw         $s1, 0x34($sp)
    /* 95D7C 800A557C 3000B08F */  lw         $s0, 0x30($sp)
    /* 95D80 800A5580 0800E003 */  jr         $ra
    /* 95D84 800A5584 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel Object_CheckCollisionResults__FP18Object_tSimObjListiP13BO_tNewtonObj
