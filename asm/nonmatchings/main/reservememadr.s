.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching reservememadr, 0x204

glabel reservememadr
    /* D5B3C 800E533C B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* D5B40 800E5340 3C00B7AF */  sw         $s7, 0x3C($sp)
    /* D5B44 800E5344 21B88000 */  addu       $s7, $a0, $zero
    /* D5B48 800E5348 3800B6AF */  sw         $s6, 0x38($sp)
    /* D5B4C 800E534C 21B0A000 */  addu       $s6, $a1, $zero
    /* D5B50 800E5350 2800B2AF */  sw         $s2, 0x28($sp)
    /* D5B54 800E5354 2190C000 */  addu       $s2, $a2, $zero
    /* D5B58 800E5358 3400B5AF */  sw         $s5, 0x34($sp)
    /* D5B5C 800E535C 21A80000 */  addu       $s5, $zero, $zero
    /* D5B60 800E5360 2400B1AF */  sw         $s1, 0x24($sp)
    /* D5B64 800E5364 1480023C */  lui        $v0, %hi(memclass)
    /* D5B68 800E5368 00E94224 */  addiu      $v0, $v0, %lo(memclass)
    /* D5B6C 800E536C 0F004332 */  andi       $v1, $s2, 0xF
    /* D5B70 800E5370 80180300 */  sll        $v1, $v1, 2
    /* D5B74 800E5374 21186200 */  addu       $v1, $v1, $v0
    /* D5B78 800E5378 0800C22A */  slti       $v0, $s6, 0x8
    /* D5B7C 800E537C 4000BFAF */  sw         $ra, 0x40($sp)
    /* D5B80 800E5380 3000B4AF */  sw         $s4, 0x30($sp)
    /* D5B84 800E5384 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* D5B88 800E5388 2000B0AF */  sw         $s0, 0x20($sp)
    /* D5B8C 800E538C 0000738C */  lw         $s3, 0x0($v1)
    /* D5B90 800E5390 03004010 */  beqz       $v0, .L800E53A0
    /* D5B94 800E5394 2188C002 */   addu      $s1, $s6, $zero
    /* D5B98 800E5398 5D00C006 */  bltz       $s6, .L800E5510
    /* D5B9C 800E539C 08001124 */   addiu     $s1, $zero, 0x8
  .L800E53A0:
    /* D5BA0 800E53A0 2120E002 */  addu       $a0, $s7, $zero
    /* D5BA4 800E53A4 0C94030C */  jal        MEM_tailsize
    /* D5BA8 800E53A8 21284002 */   addu      $a1, $s2, $zero
    /* D5BAC 800E53AC 2800638E */  lw         $v1, 0x28($s3)
    /* D5BB0 800E53B0 21102202 */  addu       $v0, $s1, $v0
    /* D5BB4 800E53B4 FFFF7424 */  addiu      $s4, $v1, -0x1
    /* D5BB8 800E53B8 0F006324 */  addiu      $v1, $v1, 0xF
    /* D5BBC 800E53BC 21104300 */  addu       $v0, $v0, $v1
    /* D5BC0 800E53C0 27181400 */  nor        $v1, $zero, $s4
    /* D5BC4 800E53C4 24104300 */  and        $v0, $v0, $v1
    /* D5BC8 800E53C8 F0FF5124 */  addiu      $s1, $v0, -0x10
    /* D5BCC 800E53CC 20004232 */  andi       $v0, $s2, 0x20
    /* D5BD0 800E53D0 06004010 */  beqz       $v0, .L800E53EC
    /* D5BD4 800E53D4 21206002 */   addu      $a0, $s3, $zero
    /* D5BD8 800E53D8 21282002 */  addu       $a1, $s1, $zero
    /* D5BDC 800E53DC 6C93030C */  jal        FREE_findlargest
    /* D5BE0 800E53E0 10004632 */   andi      $a2, $s2, 0x10
    /* D5BE4 800E53E4 FF940308 */  j          .L800E53FC
    /* D5BE8 800E53E8 21804000 */   addu      $s0, $v0, $zero
  .L800E53EC:
    /* D5BEC 800E53EC 21282002 */  addu       $a1, $s1, $zero
    /* D5BF0 800E53F0 5393030C */  jal        FREE_find
    /* D5BF4 800E53F4 10004632 */   andi      $a2, $s2, 0x10
    /* D5BF8 800E53F8 21804000 */  addu       $s0, $v0, $zero
  .L800E53FC:
    /* D5BFC 800E53FC 44000012 */  beqz       $s0, .L800E5510
    /* D5C00 800E5400 21206002 */   addu      $a0, $s3, $zero
    /* D5C04 800E5404 C193030C */  jal        FREE_remove
    /* D5C08 800E5408 21280002 */   addu      $a1, $s0, $zero
    /* D5C0C 800E540C 0400028E */  lw         $v0, 0x4($s0)
    /* D5C10 800E5410 00000000 */  nop
    /* D5C14 800E5414 23185100 */  subu       $v1, $v0, $s1
    /* D5C18 800E5418 41006228 */  slti       $v0, $v1, 0x41
    /* D5C1C 800E541C 2A004014 */  bnez       $v0, .L800E54C8
    /* D5C20 800E5420 10004232 */   andi      $v0, $s2, 0x10
    /* D5C24 800E5424 17004010 */  beqz       $v0, .L800E5484
    /* D5C28 800E5428 27101400 */   nor       $v0, $zero, $s4
    /* D5C2C 800E542C 21880002 */  addu       $s1, $s0, $zero
    /* D5C30 800E5430 24106200 */  and        $v0, $v1, $v0
    /* D5C34 800E5434 21800202 */  addu       $s0, $s0, $v0
    /* D5C38 800E5438 21202002 */  addu       $a0, $s1, $zero
    /* D5C3C 800E543C 0800228E */  lw         $v0, 0x8($s1)
    /* D5C40 800E5440 21280000 */  addu       $a1, $zero, $zero
    /* D5C44 800E5444 0C0050AC */  sw         $s0, 0xC($v0)
    /* D5C48 800E5448 0800228E */  lw         $v0, 0x8($s1)
    /* D5C4C 800E544C 2130A000 */  addu       $a2, $a1, $zero
    /* D5C50 800E5450 0C0011AE */  sw         $s1, 0xC($s0)
    /* D5C54 800E5454 080002AE */  sw         $v0, 0x8($s0)
    /* D5C58 800E5458 1000A0AF */  sw         $zero, 0x10($sp)
    /* D5C5C 800E545C 0C00228E */  lw         $v0, 0xC($s1)
    /* D5C60 800E5460 2138A000 */  addu       $a3, $a1, $zero
    /* D5C64 800E5464 1800B0AF */  sw         $s0, 0x18($sp)
    /* D5C68 800E5468 CB93030C */  jal        initmemblock
    /* D5C6C 800E546C 1400A2AF */   sw        $v0, 0x14($sp)
    /* D5C70 800E5470 21206002 */  addu       $a0, $s3, $zero
    /* D5C74 800E5474 9C93030C */  jal        FREE_add
    /* D5C78 800E5478 21282002 */   addu      $a1, $s1, $zero
    /* D5C7C 800E547C 32950308 */  j          .L800E54C8
    /* D5C80 800E5480 00000000 */   nop
  .L800E5484:
    /* D5C84 800E5484 10002226 */  addiu      $v0, $s1, 0x10
    /* D5C88 800E5488 21880202 */  addu       $s1, $s0, $v0
    /* D5C8C 800E548C 21202002 */  addu       $a0, $s1, $zero
    /* D5C90 800E5490 21280000 */  addu       $a1, $zero, $zero
    /* D5C94 800E5494 0800028E */  lw         $v0, 0x8($s0)
    /* D5C98 800E5498 2130A000 */  addu       $a2, $a1, $zero
    /* D5C9C 800E549C 0C0051AC */  sw         $s1, 0xC($v0)
    /* D5CA0 800E54A0 1000A0AF */  sw         $zero, 0x10($sp)
    /* D5CA4 800E54A4 1400B0AF */  sw         $s0, 0x14($sp)
    /* D5CA8 800E54A8 0800028E */  lw         $v0, 0x8($s0)
    /* D5CAC 800E54AC 2138A000 */  addu       $a3, $a1, $zero
    /* D5CB0 800E54B0 CB93030C */  jal        initmemblock
    /* D5CB4 800E54B4 1800A2AF */   sw        $v0, 0x18($sp)
    /* D5CB8 800E54B8 21206002 */  addu       $a0, $s3, $zero
    /* D5CBC 800E54BC 9C93030C */  jal        FREE_add
    /* D5CC0 800E54C0 21282002 */   addu      $a1, $s1, $zero
    /* D5CC4 800E54C4 080011AE */  sw         $s1, 0x8($s0)
  .L800E54C8:
    /* D5CC8 800E54C8 3400628E */  lw         $v0, 0x34($s3)
    /* D5CCC 800E54CC 00000000 */  nop
    /* D5CD0 800E54D0 00074230 */  andi       $v0, $v0, 0x700
    /* D5CD4 800E54D4 0300E016 */  bnez       $s7, .L800E54E4
    /* D5CD8 800E54D8 25904202 */   or        $s2, $s2, $v0
    /* D5CDC 800E54DC FFFE0224 */  addiu      $v0, $zero, -0x101
    /* D5CE0 800E54E0 24904202 */  and        $s2, $s2, $v0
  .L800E54E4:
    /* D5CE4 800E54E4 21200002 */  addu       $a0, $s0, $zero
    /* D5CE8 800E54E8 1000B2AF */  sw         $s2, 0x10($sp)
    /* D5CEC 800E54EC 0C00828C */  lw         $v0, 0xC($a0)
    /* D5CF0 800E54F0 2128E002 */  addu       $a1, $s7, $zero
    /* D5CF4 800E54F4 1400A2AF */  sw         $v0, 0x14($sp)
    /* D5CF8 800E54F8 0800828C */  lw         $v0, 0x8($a0)
    /* D5CFC 800E54FC 2130C002 */  addu       $a2, $s6, $zero
    /* D5D00 800E5500 1800A2AF */  sw         $v0, 0x18($sp)
    /* D5D04 800E5504 3000678E */  lw         $a3, 0x30($s3)
    /* D5D08 800E5508 CB93030C */  jal        initmemblock
    /* D5D0C 800E550C 10009524 */   addiu     $s5, $a0, 0x10
  .L800E5510:
    /* D5D10 800E5510 2110A002 */  addu       $v0, $s5, $zero
    /* D5D14 800E5514 4000BF8F */  lw         $ra, 0x40($sp)
    /* D5D18 800E5518 3C00B78F */  lw         $s7, 0x3C($sp)
    /* D5D1C 800E551C 3800B68F */  lw         $s6, 0x38($sp)
    /* D5D20 800E5520 3400B58F */  lw         $s5, 0x34($sp)
    /* D5D24 800E5524 3000B48F */  lw         $s4, 0x30($sp)
    /* D5D28 800E5528 2C00B38F */  lw         $s3, 0x2C($sp)
    /* D5D2C 800E552C 2800B28F */  lw         $s2, 0x28($sp)
    /* D5D30 800E5530 2400B18F */  lw         $s1, 0x24($sp)
    /* D5D34 800E5534 2000B08F */  lw         $s0, 0x20($sp)
    /* D5D38 800E5538 0800E003 */  jr         $ra
    /* D5D3C 800E553C 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel reservememadr
