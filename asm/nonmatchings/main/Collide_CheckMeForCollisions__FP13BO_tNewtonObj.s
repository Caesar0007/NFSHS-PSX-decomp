.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Collide_CheckMeForCollisions__FP13BO_tNewtonObj, 0x5F4

glabel Collide_CheckMeForCollisions__FP13BO_tNewtonObj
    /* 820CC 800918CC 50FFBD27 */  addiu      $sp, $sp, -0xB0
    /* 820D0 800918D0 9000B2AF */  sw         $s2, 0x90($sp)
    /* 820D4 800918D4 21908000 */  addu       $s2, $a0, $zero
    /* 820D8 800918D8 A800BFAF */  sw         $ra, 0xA8($sp)
    /* 820DC 800918DC A400B7AF */  sw         $s7, 0xA4($sp)
    /* 820E0 800918E0 A000B6AF */  sw         $s6, 0xA0($sp)
    /* 820E4 800918E4 9C00B5AF */  sw         $s5, 0x9C($sp)
    /* 820E8 800918E8 9800B4AF */  sw         $s4, 0x98($sp)
    /* 820EC 800918EC 9400B3AF */  sw         $s3, 0x94($sp)
    /* 820F0 800918F0 8C00B1AF */  sw         $s1, 0x8C($sp)
    /* 820F4 800918F4 8800B0AF */  sw         $s0, 0x88($sp)
    /* 820F8 800918F8 91004292 */  lbu        $v0, 0x91($s2)
    /* 820FC 800918FC 00000000 */  nop
    /* 82100 80091900 64014010 */  beqz       $v0, .L80091E94
    /* 82104 80091904 00000000 */   nop
    /* 82108 80091908 90004292 */  lbu        $v0, 0x90($s2)
    /* 8210C 8009190C 00000000 */  nop
    /* 82110 80091910 05004010 */  beqz       $v0, .L80091928
    /* 82114 80091914 00000000 */   nop
    /* 82118 80091918 ECA9020C */  jal        Physics_TestForBarrierCollision__FP8Car_tObj
    /* 8211C 8009191C 00000000 */   nop
    /* 82120 80091920 A5470208 */  j          .L80091E94
    /* 82124 80091924 00000000 */   nop
  .L80091928:
    /* 82128 80091928 9C01428E */  lw         $v0, 0x19C($s2)
    /* 8212C 8009192C 00000000 */  nop
    /* 82130 80091930 02004018 */  blez       $v0, .L8009193C
    /* 82134 80091934 FFFF4224 */   addiu     $v0, $v0, -0x1
    /* 82138 80091938 9C0142AE */  sw         $v0, 0x19C($s2)
  .L8009193C:
    /* 8213C 8009193C 9C01428E */  lw         $v0, 0x19C($s2)
    /* 82140 80091940 00000000 */  nop
    /* 82144 80091944 CF004014 */  bnez       $v0, .L80091C84
    /* 82148 80091948 00000000 */   nop
    /* 8214C 8009194C BC01428E */  lw         $v0, 0x1BC($s2)
    /* 82150 80091950 00000000 */  nop
    /* 82154 80091954 40004230 */  andi       $v0, $v0, 0x40
    /* 82158 80091958 CA004010 */  beqz       $v0, .L80091C84
    /* 8215C 8009195C 08004426 */   addiu     $a0, $s2, 0x8
    /* 82160 80091960 1000A527 */  addiu      $a1, $sp, 0x10
    /* 82164 80091964 3F93020C */  jal        Object_InitCollisionCheckLoop__FP12BWorldSm_PosP18Object_tSimObjListPi
    /* 82168 80091968 7800A627 */   addiu     $a2, $sp, 0x78
    /* 8216C 8009196C 21A80000 */  addu       $s5, $zero, $zero
    /* 82170 80091970 01001724 */  addiu      $s7, $zero, 0x1
    /* 82174 80091974 3000B627 */  addiu      $s6, $sp, 0x30
  .L80091978:
    /* 82178 80091978 7800A28F */  lw         $v0, 0x78($sp)
    /* 8217C 8009197C 00000000 */  nop
    /* 82180 80091980 2A10A202 */  slt        $v0, $s5, $v0
    /* 82184 80091984 BF004010 */  beqz       $v0, .L80091C84
    /* 82188 80091988 0A00143C */   lui       $s4, (0xA0000 >> 16)
    /* 8218C 8009198C FFFF1324 */  addiu      $s3, $zero, -0x1
    /* 82190 80091990 1000A427 */  addiu      $a0, $sp, 0x10
    /* 82194 80091994 2128A002 */  addu       $a1, $s5, $zero
    /* 82198 80091998 2000A627 */  addiu      $a2, $sp, 0x20
    /* 8219C 8009199C 7C00A727 */  addiu      $a3, $sp, 0x7C
    /* 821A0 800919A0 FA93020C */  jal        Object_GetRadiusCollisionData__FP18Object_tSimObjListiP8coorddefPi
    /* 821A4 800919A4 8000B7AF */   sw        $s7, 0x80($sp)
    /* 821A8 800919A8 1000A427 */  addiu      $a0, $sp, 0x10
    /* 821AC 800919AC 2128A002 */  addu       $a1, $s5, $zero
    /* 821B0 800919B0 8000A627 */  addiu      $a2, $sp, 0x80
    /* 821B4 800919B4 3D94020C */  jal        Object_GetPointsCollisionData__FP18Object_tSimObjListiPiP8coorddef
    /* 821B8 800919B8 3000A727 */   addiu     $a3, $sp, 0x30
    /* 821BC 800919BC 8000A28F */  lw         $v0, 0x80($sp)
    /* 821C0 800919C0 00000000 */  nop
    /* 821C4 800919C4 15004018 */  blez       $v0, .L80091A1C
    /* 821C8 800919C8 21800000 */   addu      $s0, $zero, $zero
    /* 821CC 800919CC 2188C002 */  addu       $s1, $s6, $zero
  .L800919D0:
    /* 821D0 800919D0 21202002 */  addu       $a0, $s1, $zero
    /* 821D4 800919D4 F974020C */  jal        Math_DistXZ__FP8coorddefT0
    /* 821D8 800919D8 A0004526 */   addiu     $a1, $s2, 0xA0
    /* 821DC 800919DC 7C00A38F */  lw         $v1, 0x7C($sp)
    /* 821E0 800919E0 4001448E */  lw         $a0, 0x140($s2)
    /* 821E4 800919E4 21284000 */  addu       $a1, $v0, $zero
    /* 821E8 800919E8 21186400 */  addu       $v1, $v1, $a0
    /* 821EC 800919EC 2A18A300 */  slt        $v1, $a1, $v1
    /* 821F0 800919F0 05006010 */  beqz       $v1, .L80091A08
    /* 821F4 800919F4 2A10B400 */   slt       $v0, $a1, $s4
    /* 821F8 800919F8 03004010 */  beqz       $v0, .L80091A08
    /* 821FC 800919FC 00000000 */   nop
    /* 82200 80091A00 21A0A000 */  addu       $s4, $a1, $zero
    /* 82204 80091A04 21980002 */  addu       $s3, $s0, $zero
  .L80091A08:
    /* 82208 80091A08 8000A28F */  lw         $v0, 0x80($sp)
    /* 8220C 80091A0C 01001026 */  addiu      $s0, $s0, 0x1
    /* 82210 80091A10 2A100202 */  slt        $v0, $s0, $v0
    /* 82214 80091A14 EEFF4014 */  bnez       $v0, .L800919D0
    /* 82218 80091A18 0C003126 */   addiu     $s1, $s1, 0xC
  .L80091A1C:
    /* 8221C 80091A1C 97006006 */  bltz       $s3, .L80091C7C
    /* 82220 80091A20 21204002 */   addu      $a0, $s2, $zero
    /* 82224 80091A24 7C00A68F */  lw         $a2, 0x7C($sp)
    /* 82228 80091A28 40281300 */  sll        $a1, $s3, 1
    /* 8222C 80091A2C 2128B300 */  addu       $a1, $a1, $s3
    /* 82230 80091A30 80280500 */  sll        $a1, $a1, 2
    /* 82234 80091A34 B545020C */  jal        Collide_CheckAccuratePointRadiusCollision__FP13BO_tNewtonObjP8coorddefi
    /* 82238 80091A38 2128C502 */   addu      $a1, $s6, $a1
    /* 8223C 80091A3C 8F004010 */  beqz       $v0, .L80091C7C
    /* 82240 80091A40 1000A427 */   addiu     $a0, $sp, 0x10
    /* 82244 80091A44 2128A002 */  addu       $a1, $s5, $zero
    /* 82248 80091A48 BC94020C */  jal        Object_CheckCollisionResults__FP18Object_tSimObjListiP13BO_tNewtonObj
    /* 8224C 80091A4C 21304002 */   addu      $a2, $s2, $zero
    /* 82250 80091A50 21884000 */  addu       $s1, $v0, $zero
    /* 82254 80091A54 89002012 */  beqz       $s1, .L80091C7C
    /* 82258 80091A58 1000A427 */   addiu     $a0, $sp, 0x10
    /* 8225C 80091A5C 2128A002 */  addu       $a1, $s5, $zero
    /* 82260 80091A60 2000A627 */  addiu      $a2, $sp, 0x20
    /* 82264 80091A64 FA93020C */  jal        Object_GetRadiusCollisionData__FP18Object_tSimObjListiP8coorddefPi
    /* 82268 80091A68 7C00A727 */   addiu     $a3, $sp, 0x7C
    /* 8226C 80091A6C 67003716 */  bne        $s1, $s7, .L80091C0C
    /* 82270 80091A70 02000224 */   addiu     $v0, $zero, 0x2
    /* 82274 80091A74 5C00A0AF */  sw         $zero, 0x5C($sp)
    /* 82278 80091A78 A000428E */  lw         $v0, 0xA0($s2)
    /* 8227C 80091A7C 2000A38F */  lw         $v1, 0x20($sp)
    /* 82280 80091A80 00000000 */  nop
    /* 82284 80091A84 23104300 */  subu       $v0, $v0, $v1
    /* 82288 80091A88 5800A2AF */  sw         $v0, 0x58($sp)
    /* 8228C 80091A8C A800428E */  lw         $v0, 0xA8($s2)
    /* 82290 80091A90 2800A38F */  lw         $v1, 0x28($sp)
    /* 82294 80091A94 5800A427 */  addiu      $a0, $sp, 0x58
    /* 82298 80091A98 23104300 */  subu       $v0, $v0, $v1
    /* 8229C 80091A9C F576020C */  jal        Math_NormalizeShortVector__FP8coorddef
    /* 822A0 80091AA0 6000A2AF */   sw        $v0, 0x60($sp)
    /* 822A4 80091AA4 7C00A38F */  lw         $v1, 0x7C($sp)
    /* 822A8 80091AA8 21800000 */  addu       $s0, $zero, $zero
    /* 822AC 80091AAC 02006104 */  bgez       $v1, .L80091AB8
    /* 822B0 80091AB0 21206000 */   addu      $a0, $v1, $zero
    /* 822B4 80091AB4 FF006324 */  addiu      $v1, $v1, 0xFF
  .L80091AB8:
    /* 822B8 80091AB8 5800A28F */  lw         $v0, 0x58($sp)
    /* 822BC 80091ABC 031A0300 */  sra        $v1, $v1, 8
    /* 822C0 80091AC0 18006200 */  mult       $v1, $v0
    /* 822C4 80091AC4 12100000 */  mflo       $v0
    /* 822C8 80091AC8 03004104 */  bgez       $v0, .L80091AD8
    /* 822CC 80091ACC 03320200 */   sra       $a2, $v0, 8
    /* 822D0 80091AD0 FF004224 */  addiu      $v0, $v0, 0xFF
    /* 822D4 80091AD4 03320200 */  sra        $a2, $v0, 8
  .L80091AD8:
    /* 822D8 80091AD8 6800A6AF */  sw         $a2, 0x68($sp)
    /* 822DC 80091ADC 5C00A28F */  lw         $v0, 0x5C($sp)
    /* 822E0 80091AE0 00000000 */  nop
    /* 822E4 80091AE4 18006200 */  mult       $v1, $v0
    /* 822E8 80091AE8 12100000 */  mflo       $v0
    /* 822EC 80091AEC 03004104 */  bgez       $v0, .L80091AFC
    /* 822F0 80091AF0 032A0200 */   sra       $a1, $v0, 8
    /* 822F4 80091AF4 FF004224 */  addiu      $v0, $v0, 0xFF
    /* 822F8 80091AF8 032A0200 */  sra        $a1, $v0, 8
  .L80091AFC:
    /* 822FC 80091AFC 6C00A5AF */  sw         $a1, 0x6C($sp)
    /* 82300 80091B00 6000A28F */  lw         $v0, 0x60($sp)
    /* 82304 80091B04 00000000 */  nop
    /* 82308 80091B08 18006200 */  mult       $v1, $v0
    /* 8230C 80091B0C 12180000 */  mflo       $v1
    /* 82310 80091B10 02006104 */  bgez       $v1, .L80091B1C
    /* 82314 80091B14 00000000 */   nop
    /* 82318 80091B18 FF006324 */  addiu      $v1, $v1, 0xFF
  .L80091B1C:
    /* 8231C 80091B1C 2000A28F */  lw         $v0, 0x20($sp)
    /* 82320 80091B20 2800A48F */  lw         $a0, 0x28($sp)
    /* 82324 80091B24 031A0300 */  sra        $v1, $v1, 8
    /* 82328 80091B28 7000A3AF */  sw         $v1, 0x70($sp)
    /* 8232C 80091B2C 2110C200 */  addu       $v0, $a2, $v0
    /* 82330 80091B30 6800A2AF */  sw         $v0, 0x68($sp)
    /* 82334 80091B34 2400A28F */  lw         $v0, 0x24($sp)
    /* 82338 80091B38 21186400 */  addu       $v1, $v1, $a0
    /* 8233C 80091B3C 7000A3AF */  sw         $v1, 0x70($sp)
    /* 82340 80091B40 2110A200 */  addu       $v0, $a1, $v0
    /* 82344 80091B44 6C00A2AF */  sw         $v0, 0x6C($sp)
    /* 82348 80091B48 C000438E */  lw         $v1, 0xC0($s2)
    /* 8234C 80091B4C 2800023C */  lui        $v0, (0x280000 >> 16)
    /* 82350 80091B50 2A104300 */  slt        $v0, $v0, $v1
    /* 82354 80091B54 08004010 */  beqz       $v0, .L80091B78
    /* 82358 80091B58 40100300 */   sll       $v0, $v1, 1
    /* 8235C 80091B5C 21804000 */  addu       $s0, $v0, $zero
    /* 82360 80091B60 9600023C */  lui        $v0, (0x960000 >> 16)
    /* 82364 80091B64 2A105000 */  slt        $v0, $v0, $s0
    /* 82368 80091B68 0E004010 */  beqz       $v0, .L80091BA4
    /* 8236C 80091B6C 00000000 */   nop
    /* 82370 80091B70 E9460208 */  j          .L80091BA4
    /* 82374 80091B74 9600103C */   lui       $s0, (0x960000 >> 16)
  .L80091B78:
    /* 82378 80091B78 1900023C */  lui        $v0, (0x190000 >> 16)
    /* 8237C 80091B7C 2A104300 */  slt        $v0, $v0, $v1
    /* 82380 80091B80 07004010 */  beqz       $v0, .L80091BA0
    /* 82384 80091B84 1E00023C */   lui       $v0, (0x1E0000 >> 16)
    /* 82388 80091B88 21806000 */  addu       $s0, $v1, $zero
    /* 8238C 80091B8C 2A100202 */  slt        $v0, $s0, $v0
    /* 82390 80091B90 04004010 */  beqz       $v0, .L80091BA4
    /* 82394 80091B94 00000000 */   nop
    /* 82398 80091B98 E9460208 */  j          .L80091BA4
    /* 8239C 80091B9C 1E00103C */   lui       $s0, (0x1E0000 >> 16)
  .L80091BA0:
    /* 823A0 80091BA0 E40291AF */  sw         $s1, %gp_rel(frictionLess)($gp)
  .L80091BA4:
    /* 823A4 80091BA4 21204002 */  addu       $a0, $s2, $zero
    /* 823A8 80091BA8 5800A527 */  addiu      $a1, $sp, 0x58
    /* 823AC 80091BAC 6A36020C */  jal        Collide_TestWithPlane__FP13BO_tNewtonObjP8coorddefT1
    /* 823B0 80091BB0 6800A627 */   addiu     $a2, $sp, 0x68
    /* 823B4 80091BB4 5800A58F */  lw         $a1, 0x58($sp)
    /* 823B8 80091BB8 5C00A68F */  lw         $a2, 0x5C($sp)
    /* 823BC 80091BBC 6000A78F */  lw         $a3, 0x60($sp)
    /* 823C0 80091BC0 E40280AF */  sw         $zero, %gp_rel(frictionLess)($gp)
    /* 823C4 80091BC4 BC8A020C */  jal        Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef
    /* 823C8 80091BC8 21204002 */   addu      $a0, $s2, $zero
    /* 823CC 80091BCC 900150AE */  sw         $s0, 0x190($s2)
    /* 823D0 80091BD0 21100002 */  addu       $v0, $s0, $zero
    /* 823D4 80091BD4 8C0157AE */  sw         $s7, 0x18C($s2)
    /* 823D8 80091BD8 28004010 */  beqz       $v0, .L80091C7C
    /* 823DC 80091BDC 940140AE */   sw        $zero, 0x194($s2)
    /* 823E0 80091BE0 0500023C */  lui        $v0, (0x50001 >> 16)
    /* 823E4 80091BE4 01004234 */  ori        $v0, $v0, (0x50001 & 0xFFFF)
    /* 823E8 80091BE8 980142AE */  sw         $v0, 0x198($s2)
    /* 823EC 80091BEC A000488E */  lw         $t0, 0xA0($s2)
    /* 823F0 80091BF0 A400498E */  lw         $t1, 0xA4($s2)
    /* 823F4 80091BF4 A8004A8E */  lw         $t2, 0xA8($s2)
    /* 823F8 80091BF8 A00148AE */  sw         $t0, 0x1A0($s2)
    /* 823FC 80091BFC A40149AE */  sw         $t1, 0x1A4($s2)
    /* 82400 80091C00 A8014AAE */  sw         $t2, 0x1A8($s2)
    /* 82404 80091C04 5E460208 */  j          .L80091978
    /* 82408 80091C08 0100B526 */   addiu     $s5, $s5, 0x1
  .L80091C0C:
    /* 8240C 80091C0C 08002216 */  bne        $s1, $v0, .L80091C30
    /* 82410 80091C10 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 82414 80091C14 C000438E */  lw         $v1, 0xC0($s2)
    /* 82418 80091C18 0200023C */  lui        $v0, (0x20000 >> 16)
    /* 8241C 80091C1C 2A104300 */  slt        $v0, $v0, $v1
    /* 82420 80091C20 16004010 */  beqz       $v0, .L80091C7C
    /* 82424 80091C24 0600033C */   lui       $v1, (0x60006 >> 16)
    /* 82428 80091C28 0F470208 */  j          .L80091C3C
    /* 8242C 80091C2C 06006334 */   ori       $v1, $v1, (0x60006 & 0xFFFF)
  .L80091C30:
    /* 82430 80091C30 12002216 */  bne        $s1, $v0, .L80091C7C
    /* 82434 80091C34 0600033C */   lui       $v1, (0x60005 >> 16)
    /* 82438 80091C38 05006334 */  ori        $v1, $v1, (0x60005 & 0xFFFF)
  .L80091C3C:
    /* 8243C 80091C3C 0F00023C */  lui        $v0, (0xF0000 >> 16)
    /* 82440 80091C40 900142AE */  sw         $v0, 0x190($s2)
    /* 82444 80091C44 980143AE */  sw         $v1, 0x198($s2)
    /* 82448 80091C48 940140AE */  sw         $zero, 0x194($s2)
    /* 8244C 80091C4C A000488E */  lw         $t0, 0xA0($s2)
    /* 82450 80091C50 A400498E */  lw         $t1, 0xA4($s2)
    /* 82454 80091C54 A8004A8E */  lw         $t2, 0xA8($s2)
    /* 82458 80091C58 A00148AE */  sw         $t0, 0x1A0($s2)
    /* 8245C 80091C5C A40149AE */  sw         $t1, 0x1A4($s2)
    /* 82460 80091C60 A8014AAE */  sw         $t2, 0x1A8($s2)
    /* 82464 80091C64 562C030C */  jal        Force_IsForceOn__FP8Car_tObj
    /* 82468 80091C68 21204002 */   addu      $a0, $s2, $zero
    /* 8246C 80091C6C 03004010 */  beqz       $v0, .L80091C7C
    /* 82470 80091C70 00000000 */   nop
    /* 82474 80091C74 7F2C030C */  jal        Force_HitSign__FP8Car_tObj
    /* 82478 80091C78 21204002 */   addu      $a0, $s2, $zero
  .L80091C7C:
    /* 8247C 80091C7C 5E460208 */  j          .L80091978
    /* 82480 80091C80 0100B526 */   addiu     $s5, $s5, 0x1
  .L80091C84:
    /* 82484 80091C84 BC01428E */  lw         $v0, 0x1BC($s2)
    /* 82488 80091C88 00000000 */  nop
    /* 8248C 80091C8C 80004230 */  andi       $v0, $v0, 0x80
    /* 82490 80091C90 03004010 */  beqz       $v0, .L80091CA0
    /* 82494 80091C94 00000000 */   nop
    /* 82498 80091C98 A18B020C */  jal        Newton_TestForUndrivableSurfaces__FP13BO_tNewtonObj
    /* 8249C 80091C9C 21204002 */   addu      $a0, $s2, $zero
  .L80091CA0:
    /* 824A0 80091CA0 7C014296 */  lhu        $v0, 0x17C($s2)
    /* 824A4 80091CA4 00000000 */  nop
    /* 824A8 80091CA8 03004010 */  beqz       $v0, .L80091CB8
    /* 824AC 80091CAC 00000000 */   nop
    /* 824B0 80091CB0 ECA9020C */  jal        Physics_TestForBarrierCollision__FP8Car_tObj
    /* 824B4 80091CB4 21204002 */   addu      $a0, $s2, $zero
  .L80091CB8:
    /* 824B8 80091CB8 9C01428E */  lw         $v0, 0x19C($s2)
    /* 824BC 80091CBC 00000000 */  nop
    /* 824C0 80091CC0 74004014 */  bnez       $v0, .L80091E94
    /* 824C4 80091CC4 21880000 */   addu      $s1, $zero, $zero
    /* 824C8 80091CC8 1180023C */  lui        $v0, %hi(Collide_gRegistry)
    /* 824CC 80091CCC E802838F */  lw         $v1, %gp_rel(Collide_gNumRegistered)($gp)
    /* 824D0 80091CD0 300C4424 */  addiu      $a0, $v0, %lo(Collide_gRegistry)
    /* 824D4 80091CD4 80100300 */  sll        $v0, $v1, 2
    /* 824D8 80091CD8 21104400 */  addu       $v0, $v0, $a0
    /* 824DC 80091CDC 69006018 */  blez       $v1, .L80091E84
    /* 824E0 80091CE0 000052AC */   sw        $s2, 0x0($v0)
    /* 824E4 80091CE4 21988000 */  addu       $s3, $a0, $zero
  .L80091CE8:
    /* 824E8 80091CE8 0000708E */  lw         $s0, 0x0($s3)
    /* 824EC 80091CEC 4001438E */  lw         $v1, 0x140($s2)
    /* 824F0 80091CF0 A800458E */  lw         $a1, 0xA8($s2)
    /* 824F4 80091CF4 4001028E */  lw         $v0, 0x140($s0)
    /* 824F8 80091CF8 A800048E */  lw         $a0, 0xA8($s0)
    /* 824FC 80091CFC 21186200 */  addu       $v1, $v1, $v0
    /* 82500 80091D00 2310A400 */  subu       $v0, $a1, $a0
    /* 82504 80091D04 0300401C */  bgtz       $v0, .L80091D14
    /* 82508 80091D08 2A104300 */   slt       $v0, $v0, $v1
    /* 8250C 80091D0C 23108500 */  subu       $v0, $a0, $a1
    /* 82510 80091D10 2A104300 */  slt        $v0, $v0, $v1
  .L80091D14:
    /* 82514 80091D14 56004010 */  beqz       $v0, .L80091E70
    /* 82518 80091D18 00000000 */   nop
    /* 8251C 80091D1C 4001438E */  lw         $v1, 0x140($s2)
    /* 82520 80091D20 4001028E */  lw         $v0, 0x140($s0)
    /* 82524 80091D24 A000458E */  lw         $a1, 0xA0($s2)
    /* 82528 80091D28 A000048E */  lw         $a0, 0xA0($s0)
    /* 8252C 80091D2C 21186200 */  addu       $v1, $v1, $v0
    /* 82530 80091D30 2310A400 */  subu       $v0, $a1, $a0
    /* 82534 80091D34 0300401C */  bgtz       $v0, .L80091D44
    /* 82538 80091D38 2A104300 */   slt       $v0, $v0, $v1
    /* 8253C 80091D3C 23108500 */  subu       $v0, $a0, $a1
    /* 82540 80091D40 2A104300 */  slt        $v0, $v0, $v1
  .L80091D44:
    /* 82544 80091D44 4A004010 */  beqz       $v0, .L80091E70
    /* 82548 80091D48 00000000 */   nop
    /* 8254C 80091D4C 4001438E */  lw         $v1, 0x140($s2)
    /* 82550 80091D50 4001028E */  lw         $v0, 0x140($s0)
    /* 82554 80091D54 A400458E */  lw         $a1, 0xA4($s2)
    /* 82558 80091D58 A400048E */  lw         $a0, 0xA4($s0)
    /* 8255C 80091D5C 21186200 */  addu       $v1, $v1, $v0
    /* 82560 80091D60 2310A400 */  subu       $v0, $a1, $a0
    /* 82564 80091D64 0300401C */  bgtz       $v0, .L80091D74
    /* 82568 80091D68 2A104300 */   slt       $v0, $v0, $v1
    /* 8256C 80091D6C 23108500 */  subu       $v0, $a0, $a1
    /* 82570 80091D70 2A104300 */  slt        $v0, $v0, $v1
  .L80091D74:
    /* 82574 80091D74 3E004010 */  beqz       $v0, .L80091E70
    /* 82578 80091D78 00000000 */   nop
    /* 8257C 80091D7C 0600043C */  lui        $a0, (0x6487E >> 16)
    /* 82580 80091D80 1401458E */  lw         $a1, 0x114($s2)
    /* 82584 80091D84 CA90030C */  jal        fixedmult
    /* 82588 80091D88 7E488434 */   ori       $a0, $a0, (0x6487E & 0xFFFF)
    /* 8258C 80091D8C 0600043C */  lui        $a0, (0x6487E >> 16)
    /* 82590 80091D90 1801458E */  lw         $a1, 0x118($s2)
    /* 82594 80091D94 7E488434 */  ori        $a0, $a0, (0x6487E & 0xFFFF)
    /* 82598 80091D98 CA90030C */  jal        fixedmult
    /* 8259C 80091D9C 140142AE */   sw        $v0, 0x114($s2)
    /* 825A0 80091DA0 0600043C */  lui        $a0, (0x6487E >> 16)
    /* 825A4 80091DA4 1C01458E */  lw         $a1, 0x11C($s2)
    /* 825A8 80091DA8 7E488434 */  ori        $a0, $a0, (0x6487E & 0xFFFF)
    /* 825AC 80091DAC CA90030C */  jal        fixedmult
    /* 825B0 80091DB0 180142AE */   sw        $v0, 0x118($s2)
    /* 825B4 80091DB4 0600043C */  lui        $a0, (0x6487E >> 16)
    /* 825B8 80091DB8 1C0142AE */  sw         $v0, 0x11C($s2)
    /* 825BC 80091DBC 1401058E */  lw         $a1, 0x114($s0)
    /* 825C0 80091DC0 CA90030C */  jal        fixedmult
    /* 825C4 80091DC4 7E488434 */   ori       $a0, $a0, (0x6487E & 0xFFFF)
    /* 825C8 80091DC8 0600043C */  lui        $a0, (0x6487E >> 16)
    /* 825CC 80091DCC 1801058E */  lw         $a1, 0x118($s0)
    /* 825D0 80091DD0 7E488434 */  ori        $a0, $a0, (0x6487E & 0xFFFF)
    /* 825D4 80091DD4 CA90030C */  jal        fixedmult
    /* 825D8 80091DD8 140102AE */   sw        $v0, 0x114($s0)
    /* 825DC 80091DDC 0600043C */  lui        $a0, (0x6487E >> 16)
    /* 825E0 80091DE0 1C01058E */  lw         $a1, 0x11C($s0)
    /* 825E4 80091DE4 7E488434 */  ori        $a0, $a0, (0x6487E & 0xFFFF)
    /* 825E8 80091DE8 CA90030C */  jal        fixedmult
    /* 825EC 80091DEC 180102AE */   sw        $v0, 0x118($s0)
    /* 825F0 80091DF0 21204002 */  addu       $a0, $s2, $zero
    /* 825F4 80091DF4 21280002 */  addu       $a1, $s0, $zero
    /* 825F8 80091DF8 DD44020C */  jal        Collide_CheckForCollisionBetween__FP13BO_tNewtonObjT0
    /* 825FC 80091DFC 1C0102AE */   sw        $v0, 0x11C($s0)
    /* 82600 80091E00 1401458E */  lw         $a1, 0x114($s2)
    /* 82604 80091E04 CA90030C */  jal        fixedmult
    /* 82608 80091E08 BE280424 */   addiu     $a0, $zero, 0x28BE
    /* 8260C 80091E0C 1801458E */  lw         $a1, 0x118($s2)
    /* 82610 80091E10 BE280424 */  addiu      $a0, $zero, 0x28BE
    /* 82614 80091E14 CA90030C */  jal        fixedmult
    /* 82618 80091E18 140142AE */   sw        $v0, 0x114($s2)
    /* 8261C 80091E1C 1C01458E */  lw         $a1, 0x11C($s2)
    /* 82620 80091E20 BE280424 */  addiu      $a0, $zero, 0x28BE
    /* 82624 80091E24 CA90030C */  jal        fixedmult
    /* 82628 80091E28 180142AE */   sw        $v0, 0x118($s2)
    /* 8262C 80091E2C 1C0142AE */  sw         $v0, 0x11C($s2)
    /* 82630 80091E30 1401058E */  lw         $a1, 0x114($s0)
    /* 82634 80091E34 CA90030C */  jal        fixedmult
    /* 82638 80091E38 BE280424 */   addiu     $a0, $zero, 0x28BE
    /* 8263C 80091E3C 1801058E */  lw         $a1, 0x118($s0)
    /* 82640 80091E40 BE280424 */  addiu      $a0, $zero, 0x28BE
    /* 82644 80091E44 CA90030C */  jal        fixedmult
    /* 82648 80091E48 140102AE */   sw        $v0, 0x114($s0)
    /* 8264C 80091E4C 1C01058E */  lw         $a1, 0x11C($s0)
    /* 82650 80091E50 BE280424 */  addiu      $a0, $zero, 0x28BE
    /* 82654 80091E54 CA90030C */  jal        fixedmult
    /* 82658 80091E58 180102AE */   sw        $v0, 0x118($s0)
    /* 8265C 80091E5C 21204002 */  addu       $a0, $s2, $zero
    /* 82660 80091E60 2D36020C */  jal        Collide_LimitAngularVel__FP13BO_tNewtonObj
    /* 82664 80091E64 1C0102AE */   sw        $v0, 0x11C($s0)
    /* 82668 80091E68 2D36020C */  jal        Collide_LimitAngularVel__FP13BO_tNewtonObj
    /* 8266C 80091E6C 21200002 */   addu      $a0, $s0, $zero
  .L80091E70:
    /* 82670 80091E70 E802828F */  lw         $v0, %gp_rel(Collide_gNumRegistered)($gp)
    /* 82674 80091E74 01003126 */  addiu      $s1, $s1, 0x1
    /* 82678 80091E78 2A102202 */  slt        $v0, $s1, $v0
    /* 8267C 80091E7C 9AFF4014 */  bnez       $v0, .L80091CE8
    /* 82680 80091E80 04007326 */   addiu     $s3, $s3, 0x4
  .L80091E84:
    /* 82684 80091E84 E802828F */  lw         $v0, %gp_rel(Collide_gNumRegistered)($gp)
    /* 82688 80091E88 00000000 */  nop
    /* 8268C 80091E8C 01004224 */  addiu      $v0, $v0, 0x1
    /* 82690 80091E90 E80282AF */  sw         $v0, %gp_rel(Collide_gNumRegistered)($gp)
  .L80091E94:
    /* 82694 80091E94 A800BF8F */  lw         $ra, 0xA8($sp)
    /* 82698 80091E98 A400B78F */  lw         $s7, 0xA4($sp)
    /* 8269C 80091E9C A000B68F */  lw         $s6, 0xA0($sp)
    /* 826A0 80091EA0 9C00B58F */  lw         $s5, 0x9C($sp)
    /* 826A4 80091EA4 9800B48F */  lw         $s4, 0x98($sp)
    /* 826A8 80091EA8 9400B38F */  lw         $s3, 0x94($sp)
    /* 826AC 80091EAC 9000B28F */  lw         $s2, 0x90($sp)
    /* 826B0 80091EB0 8C00B18F */  lw         $s1, 0x8C($sp)
    /* 826B4 80091EB4 8800B08F */  lw         $s0, 0x88($sp)
    /* 826B8 80091EB8 0800E003 */  jr         $ra
    /* 826BC 80091EBC B000BD27 */   addiu     $sp, $sp, 0xB0
endlabel Collide_CheckMeForCollisions__FP13BO_tNewtonObj
