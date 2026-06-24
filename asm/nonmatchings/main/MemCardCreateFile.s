.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MemCardCreateFile, 0x208

glabel MemCardCreateFile
    /* EC418 800FBC18 B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* EC41C 800FBC1C 4400B3AF */  sw         $s3, 0x44($sp)
    /* EC420 800FBC20 21988000 */  addu       $s3, $a0, $zero
    /* EC424 800FBC24 3800B0AF */  sw         $s0, 0x38($sp)
    /* EC428 800FBC28 2180A000 */  addu       $s0, $a1, $zero
    /* EC42C 800FBC2C 4800B4AF */  sw         $s4, 0x48($sp)
    /* EC430 800FBC30 21A0C000 */  addu       $s4, $a2, $zero
    /* EC434 800FBC34 4000B2AF */  sw         $s2, 0x40($sp)
    /* EC438 800FBC38 1480123C */  lui        $s2, %hi(D_80147518)
    /* EC43C 800FBC3C 18755226 */  addiu      $s2, $s2, %lo(D_80147518)
    /* EC440 800FBC40 4C00BFAF */  sw         $ra, 0x4C($sp)
    /* EC444 800FBC44 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* EC448 800FBC48 0000428E */  lw         $v0, 0x0($s2)
    /* EC44C 800FBC4C 00000000 */  nop
    /* EC450 800FBC50 06004010 */  beqz       $v0, .L800FBC6C
    /* EC454 800FBC54 21880000 */   addu      $s1, $zero, $zero
    /* EC458 800FBC58 0580043C */  lui        $a0, %hi(D_800574C0)
    /* EC45C 800FBC5C 2B0A040C */  jal        printf
    /* EC460 800FBC60 C0748424 */   addiu     $a0, $a0, %lo(D_800574C0)
    /* EC464 800FBC64 80EF0308 */  j          .L800FBE00
    /* EC468 800FBC68 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L800FBC6C:
    /* EC46C 800FBC6C 21206002 */  addu       $a0, $s3, $zero
    /* EC470 800FBC70 7DF0030C */  jal        MemCardMakeDevname
    /* EC474 800FBC74 1000A527 */   addiu     $a1, $sp, 0x10
    /* EC478 800FBC78 1000A427 */  addiu      $a0, $sp, 0x10
    /* EC47C 800FBC7C 3A9E030C */  jal        strcat
    /* EC480 800FBC80 21280002 */   addu      $a1, $s0, $zero
    /* EC484 800FBC84 1000A427 */  addiu      $a0, $sp, 0x10
    /* EC488 800FBC88 01000524 */  addiu      $a1, $zero, 0x1
    /* EC48C 800FBC8C 01000224 */  addiu      $v0, $zero, 0x1
    /* EC490 800FBC90 0C00468E */  lw         $a2, 0xC($s2)
    /* EC494 800FBC94 1480033C */  lui        $v1, %hi(D_80147514)
    /* EC498 800FBC98 1475638C */  lw         $v1, %lo(D_80147514)($v1)
    /* EC49C 800FBC9C 0410C200 */  sllv       $v0, $v0, $a2
    /* EC4A0 800FBCA0 25186200 */  or         $v1, $v1, $v0
    /* EC4A4 800FBCA4 1480013C */  lui        $at, %hi(D_80147514)
    /* EC4A8 800FBCA8 5C27040C */  jal        open
    /* EC4AC 800FBCAC 147523AC */   sw        $v1, %lo(D_80147514)($at)
    /* EC4B0 800FBCB0 07004004 */  bltz       $v0, .L800FBCD0
    /* EC4B4 800FBCB4 00A41400 */   sll       $s4, $s4, 16
    /* EC4B8 800FBCB8 6027040C */  jal        close
    /* EC4BC 800FBCBC 21204000 */   addu      $a0, $v0, $zero
    /* EC4C0 800FBCC0 80EF0308 */  j          .L800FBE00
    /* EC4C4 800FBCC4 06000224 */   addiu     $v0, $zero, 0x6
  .L800FBCC8:
    /* EC4C8 800FBCC8 80EF0308 */  j          .L800FBE00
    /* EC4CC 800FBCCC 07000224 */   addiu     $v0, $zero, 0x7
  .L800FBCD0:
    /* EC4D0 800FBCD0 21804002 */  addu       $s0, $s2, $zero
    /* EC4D4 800FBCD4 02001224 */  addiu      $s2, $zero, 0x2
  .L800FBCD8:
    /* EC4D8 800FBCD8 1000A427 */  addiu      $a0, $sp, 0x10
  .L800FBCDC:
    /* EC4DC 800FBCDC 5C27040C */  jal        open
    /* EC4E0 800FBCE0 00028536 */   ori       $a1, $s4, 0x200
    /* EC4E4 800FBCE4 43004104 */  bgez       $v0, .L800FBDF4
    /* EC4E8 800FBCE8 00000000 */   nop
    /* EC4EC 800FBCEC BAEE030C */  jal        MemCardCallback
    /* EC4F0 800FBCF0 21200000 */   addu      $a0, $zero, $zero
    /* EC4F4 800FBCF4 0000038E */  lw         $v1, 0x0($s0)
    /* EC4F8 800FBCF8 1480013C */  lui        $at, %hi(D_8014756C)
    /* EC4FC 800FBCFC 06006018 */  blez       $v1, .L800FBD18
    /* EC500 800FBD00 6C7522AC */   sw        $v0, %lo(D_8014756C)($at)
    /* EC504 800FBD04 0580043C */  lui        $a0, %hi(D_80057370)
    /* EC508 800FBD08 2B0A040C */  jal        printf
    /* EC50C 800FBD0C 70738424 */   addiu     $a0, $a0, %lo(D_80057370)
    /* EC510 800FBD10 4EEF0308 */  j          .L800FBD38
    /* EC514 800FBD14 00000000 */   nop
  .L800FBD18:
    /* EC518 800FBD18 1080043C */  lui        $a0, %hi(MemCardCmd_cb)
    /* EC51C 800FBD1C 2CAE8424 */  addiu      $a0, $a0, %lo(MemCardCmd_cb)
    /* EC520 800FBD20 000012AE */  sw         $s2, 0x0($s0)
    /* EC524 800FBD24 040000AE */  sw         $zero, 0x4($s0)
    /* EC528 800FBD28 080000AE */  sw         $zero, 0x8($s0)
    /* EC52C 800FBD2C 1480013C */  lui        $at, %hi(D_80147524)
    /* EC530 800FBD30 0427040C */  jal        UserFuncOpen
    /* EC534 800FBD34 247533AC */   sw        $s3, %lo(D_80147524)($at)
  .L800FBD38:
    /* EC538 800FBD38 0000028E */  lw         $v0, 0x0($s0)
    /* EC53C 800FBD3C 00000000 */  nop
    /* EC540 800FBD40 05004014 */  bnez       $v0, .L800FBD58
    /* EC544 800FBD44 00000000 */   nop
    /* EC548 800FBD48 0800028E */  lw         $v0, 0x8($s0)
    /* EC54C 800FBD4C 00000000 */  nop
    /* EC550 800FBD50 12004010 */  beqz       $v0, .L800FBD9C
    /* EC554 800FBD54 00000000 */   nop
  .L800FBD58:
    /* EC558 800FBD58 0000028E */  lw         $v0, 0x0($s0)
    /* EC55C 800FBD5C 0400028E */  lw         $v0, 0x4($s0)
    /* EC560 800FBD60 0800028E */  lw         $v0, 0x8($s0)
    /* EC564 800FBD64 00000000 */  nop
    /* EC568 800FBD68 07004014 */  bnez       $v0, .L800FBD88
    /* EC56C 800FBD6C 00000000 */   nop
    /* EC570 800FBD70 1480033C */  lui        $v1, %hi(D_80147520)
    /* EC574 800FBD74 20756324 */  addiu      $v1, $v1, %lo(D_80147520)
  .L800FBD78:
    /* EC578 800FBD78 0000628C */  lw         $v0, 0x0($v1)
    /* EC57C 800FBD7C 00000000 */  nop
    /* EC580 800FBD80 FDFF4010 */  beqz       $v0, .L800FBD78
    /* EC584 800FBD84 00000000 */   nop
  .L800FBD88:
    /* EC588 800FBD88 1480023C */  lui        $v0, %hi(D_80147564)
    /* EC58C 800FBD8C 64754224 */  addiu      $v0, $v0, %lo(D_80147564)
    /* EC590 800FBD90 0000428C */  lw         $v0, 0x0($v0)
    /* EC594 800FBD94 080000AE */  sw         $zero, 0x8($s0)
    /* EC598 800FBD98 3000A2AF */  sw         $v0, 0x30($sp)
  .L800FBD9C:
    /* EC59C 800FBD9C 1480043C */  lui        $a0, %hi(D_8014756C)
    /* EC5A0 800FBDA0 6C75848C */  lw         $a0, %lo(D_8014756C)($a0)
    /* EC5A4 800FBDA4 BAEE030C */  jal        MemCardCallback
    /* EC5A8 800FBDA8 00000000 */   nop
    /* EC5AC 800FBDAC 3000A38F */  lw         $v1, 0x30($sp)
    /* EC5B0 800FBDB0 00000000 */  nop
    /* EC5B4 800FBDB4 C4FF6010 */  beqz       $v1, .L800FBCC8
    /* EC5B8 800FBDB8 03000224 */   addiu     $v0, $zero, 0x3
    /* EC5BC 800FBDBC C7FF6210 */  beq        $v1, $v0, .L800FBCDC
    /* EC5C0 800FBDC0 1000A427 */   addiu     $a0, $sp, 0x10
    /* EC5C4 800FBDC4 05007214 */  bne        $v1, $s2, .L800FBDDC
    /* EC5C8 800FBDC8 00000000 */   nop
    /* EC5CC 800FBDCC 01003126 */  addiu      $s1, $s1, 0x1
    /* EC5D0 800FBDD0 0400222A */  slti       $v0, $s1, 0x4
    /* EC5D4 800FBDD4 C0FF4014 */  bnez       $v0, .L800FBCD8
    /* EC5D8 800FBDD8 00000000 */   nop
  .L800FBDDC:
    /* EC5DC 800FBDDC 02006014 */  bnez       $v1, .L800FBDE8
    /* EC5E0 800FBDE0 05000224 */   addiu     $v0, $zero, 0x5
    /* EC5E4 800FBDE4 3000A2AF */  sw         $v0, 0x30($sp)
  .L800FBDE8:
    /* EC5E8 800FBDE8 3000A28F */  lw         $v0, 0x30($sp)
    /* EC5EC 800FBDEC 80EF0308 */  j          .L800FBE00
    /* EC5F0 800FBDF0 00000000 */   nop
  .L800FBDF4:
    /* EC5F4 800FBDF4 6027040C */  jal        close
    /* EC5F8 800FBDF8 21204000 */   addu      $a0, $v0, $zero
    /* EC5FC 800FBDFC 21100000 */  addu       $v0, $zero, $zero
  .L800FBE00:
    /* EC600 800FBE00 4C00BF8F */  lw         $ra, 0x4C($sp)
    /* EC604 800FBE04 4800B48F */  lw         $s4, 0x48($sp)
    /* EC608 800FBE08 4400B38F */  lw         $s3, 0x44($sp)
    /* EC60C 800FBE0C 4000B28F */  lw         $s2, 0x40($sp)
    /* EC610 800FBE10 3C00B18F */  lw         $s1, 0x3C($sp)
    /* EC614 800FBE14 3800B08F */  lw         $s0, 0x38($sp)
    /* EC618 800FBE18 0800E003 */  jr         $ra
    /* EC61C 800FBE1C 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel MemCardCreateFile
