.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopSpeak_RadioStaticActive__Fi, 0x170

glabel CopSpeak_RadioStaticActive__Fi
    /* 89C18 80099418 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 89C1C 8009941C 3C00B5AF */  sw         $s5, 0x3C($sp)
    /* 89C20 80099420 03001524 */  addiu      $s5, $zero, 0x3
    /* 89C24 80099424 61008228 */  slti       $v0, $a0, 0x61
    /* 89C28 80099428 4400BFAF */  sw         $ra, 0x44($sp)
    /* 89C2C 8009942C 4000B6AF */  sw         $s6, 0x40($sp)
    /* 89C30 80099430 3800B4AF */  sw         $s4, 0x38($sp)
    /* 89C34 80099434 3400B3AF */  sw         $s3, 0x34($sp)
    /* 89C38 80099438 3000B2AF */  sw         $s2, 0x30($sp)
    /* 89C3C 8009943C 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* 89C40 80099440 02004014 */  bnez       $v0, .L8009944C
    /* 89C44 80099444 2800B0AF */   sw        $s0, 0x28($sp)
    /* 89C48 80099448 04001524 */  addiu      $s5, $zero, 0x4
  .L8009944C:
    /* 89C4C 8009944C 21980000 */  addu       $s3, $zero, $zero
    /* 89C50 80099450 FFFF1424 */  addiu      $s4, $zero, -0x1
    /* 89C54 80099454 C0110400 */  sll        $v0, $a0, 7
    /* 89C58 80099458 21B04400 */  addu       $s6, $v0, $a0
    /* 89C5C 8009945C 0200622A */  slti       $v0, $s3, 0x2
  .L80099460:
    /* 89C60 80099460 3F004010 */  beqz       $v0, .L80099560
    /* 89C64 80099464 00000000 */   nop
    /* 89C68 80099468 1480023C */  lui        $v0, %hi(CopSpeak_gStaticPatch)
    /* 89C6C 8009946C F8D04224 */  addiu      $v0, $v0, %lo(CopSpeak_gStaticPatch)
    /* 89C70 80099470 21906202 */  addu       $s2, $s3, $v0
    /* 89C74 80099474 00004282 */  lb         $v0, 0x0($s2)
    /* 89C78 80099478 00000000 */  nop
    /* 89C7C 8009947C 0B005414 */  bne        $v0, $s4, .L800994AC
    /* 89C80 80099480 80181300 */   sll       $v1, $s3, 2
    /* 89C84 80099484 EA9D030C */  jal        random
    /* 89C88 80099488 00000000 */   nop
    /* 89C8C 8009948C 1B005500 */  divu       $zero, $v0, $s5
    /* 89C90 80099490 0200A016 */  bnez       $s5, .L8009949C
    /* 89C94 80099494 00000000 */   nop
    /* 89C98 80099498 0D000700 */  break      7
  .L8009949C:
    /* 89C9C 8009949C 10180000 */  mfhi       $v1
    /* 89CA0 800994A0 00000000 */  nop
    /* 89CA4 800994A4 000043A2 */  sb         $v1, 0x0($s2)
    /* 89CA8 800994A8 80181300 */  sll        $v1, $s3, 2
  .L800994AC:
    /* 89CAC 800994AC 1480023C */  lui        $v0, %hi(CopSpeak_gStaticHandle)
    /* 89CB0 800994B0 F0D04224 */  addiu      $v0, $v0, %lo(CopSpeak_gStaticHandle)
    /* 89CB4 800994B4 21886200 */  addu       $s1, $v1, $v0
    /* 89CB8 800994B8 0000248E */  lw         $a0, 0x0($s1)
    /* 89CBC 800994BC 00000000 */  nop
    /* 89CC0 800994C0 1F009414 */  bne        $a0, $s4, .L80099540
    /* 89CC4 800994C4 21300000 */   addu      $a2, $zero, $zero
    /* 89CC8 800994C8 00004582 */  lb         $a1, 0x0($s2)
    /* 89CCC 800994CC 02000424 */  addiu      $a0, $zero, 0x2
    /* 89CD0 800994D0 40DA010C */  jal        AudioCmn_GetAsyncSfx__Fiib
    /* 89CD4 800994D4 2F00A524 */   addiu     $a1, $a1, 0x2F
    /* 89CD8 800994D8 21804000 */  addu       $s0, $v0, $zero
    /* 89CDC 800994DC 1D000006 */  bltz       $s0, .L80099554
    /* 89CE0 800994E0 00000000 */   nop
    /* 89CE4 800994E4 0D9A030C */  jal        SNDplaysetdef
    /* 89CE8 800994E8 1000A427 */   addiu     $a0, $sp, 0x10
    /* 89CEC 800994EC 1480023C */  lui        $v0, %hi(gMasterFENarrationLevel)
    /* 89CF0 800994F0 5CC6428C */  lw         $v0, %lo(gMasterFENarrationLevel)($v0)
    /* 89CF4 800994F4 00000000 */  nop
    /* 89CF8 800994F8 18005600 */  mult       $v0, $s6
    /* 89CFC 800994FC 1000A427 */  addiu      $a0, $sp, 0x10
    /* 89D00 80099500 1400B0A3 */  sb         $s0, 0x14($sp)
    /* 89D04 80099504 1000A0AF */  sw         $zero, 0x10($sp)
    /* 89D08 80099508 12380000 */  mflo       $a3
    /* 89D0C 8009950C 83130700 */  sra        $v0, $a3, 14
    /* 89D10 80099510 8C9E030C */  jal        SNDplay
    /* 89D14 80099514 1800A2A3 */   sb        $v0, 0x18($sp)
    /* 89D18 80099518 000022AE */  sw         $v0, 0x0($s1)
    /* 89D1C 8009951C 000054A2 */  sb         $s4, 0x0($s2)
    /* 89D20 80099520 0000248E */  lw         $a0, 0x0($s1)
    /* 89D24 80099524 00000000 */  nop
    /* 89D28 80099528 0A008104 */  bgez       $a0, .L80099554
    /* 89D2C 8009952C 00000000 */   nop
    /* 89D30 80099530 CCD1010C */  jal        AudioClc_SndError__Fi
    /* 89D34 80099534 01007326 */   addiu     $s3, $s3, 0x1
    /* 89D38 80099538 18650208 */  j          .L80099460
    /* 89D3C 8009953C 0200622A */   slti      $v0, $s3, 0x2
  .L80099540:
    /* 89D40 80099540 C59E030C */  jal        SNDover
    /* 89D44 80099544 00000000 */   nop
    /* 89D48 80099548 02004010 */  beqz       $v0, .L80099554
    /* 89D4C 8009954C 00000000 */   nop
    /* 89D50 80099550 000034AE */  sw         $s4, 0x0($s1)
  .L80099554:
    /* 89D54 80099554 01007326 */  addiu      $s3, $s3, 0x1
    /* 89D58 80099558 18650208 */  j          .L80099460
    /* 89D5C 8009955C 0200622A */   slti      $v0, $s3, 0x2
  .L80099560:
    /* 89D60 80099560 4400BF8F */  lw         $ra, 0x44($sp)
    /* 89D64 80099564 4000B68F */  lw         $s6, 0x40($sp)
    /* 89D68 80099568 3C00B58F */  lw         $s5, 0x3C($sp)
    /* 89D6C 8009956C 3800B48F */  lw         $s4, 0x38($sp)
    /* 89D70 80099570 3400B38F */  lw         $s3, 0x34($sp)
    /* 89D74 80099574 3000B28F */  lw         $s2, 0x30($sp)
    /* 89D78 80099578 2C00B18F */  lw         $s1, 0x2C($sp)
    /* 89D7C 8009957C 2800B08F */  lw         $s0, 0x28($sp)
    /* 89D80 80099580 0800E003 */  jr         $ra
    /* 89D84 80099584 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel CopSpeak_RadioStaticActive__Fi
