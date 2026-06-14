.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_FindGroundElevationGeneral__FP8coorddefN20, 0x15C

glabel Newton_FindGroundElevationGeneral__FP8coorddefN20
    /* 90330 8009FB30 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 90334 8009FB34 21408000 */  addu       $t0, $a0, $zero
    /* 90338 8009FB38 1000B0AF */  sw         $s0, 0x10($sp)
    /* 9033C 8009FB3C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 90340 8009FB40 0400A78C */  lw         $a3, 0x4($a1)
    /* 90344 8009FB44 B89E0234 */  ori        $v0, $zero, 0x9EB8
    /* 90348 8009FB48 2A104700 */  slt        $v0, $v0, $a3
    /* 9034C 8009FB4C 28004010 */  beqz       $v0, .L8009FBF0
    /* 90350 8009FB50 2180C000 */   addu      $s0, $a2, $zero
    /* 90354 8009FB54 0000A68C */  lw         $a2, 0x0($a1)
    /* 90358 8009FB58 0100023C */  lui        $v0, (0x10000 >> 16)
    /* 9035C 8009FB5C 23104700 */  subu       $v0, $v0, $a3
    /* 90360 8009FB60 0200C104 */  bgez       $a2, .L8009FB6C
    /* 90364 8009FB64 433A0200 */   sra       $a3, $v0, 9
    /* 90368 8009FB68 FF00C624 */  addiu      $a2, $a2, 0xFF
  .L8009FB6C:
    /* 9036C 8009FB6C 0000038D */  lw         $v1, 0x0($t0)
    /* 90370 8009FB70 0000028E */  lw         $v0, 0x0($s0)
    /* 90374 8009FB74 00000000 */  nop
    /* 90378 8009FB78 23106200 */  subu       $v0, $v1, $v0
    /* 9037C 8009FB7C 02004104 */  bgez       $v0, .L8009FB88
    /* 90380 8009FB80 031A0600 */   sra       $v1, $a2, 8
    /* 90384 8009FB84 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8009FB88:
    /* 90388 8009FB88 03120200 */  sra        $v0, $v0, 8
    /* 9038C 8009FB8C 18006200 */  mult       $v1, $v0
    /* 90390 8009FB90 0800A58C */  lw         $a1, 0x8($a1)
    /* 90394 8009FB94 12480000 */  mflo       $t1
    /* 90398 8009FB98 0200A104 */  bgez       $a1, .L8009FBA4
    /* 9039C 8009FB9C 23200900 */   negu      $a0, $t1
    /* 903A0 8009FBA0 FF00A524 */  addiu      $a1, $a1, 0xFF
  .L8009FBA4:
    /* 903A4 8009FBA4 0800038D */  lw         $v1, 0x8($t0)
    /* 903A8 8009FBA8 0800028E */  lw         $v0, 0x8($s0)
    /* 903AC 8009FBAC 00000000 */  nop
    /* 903B0 8009FBB0 23106200 */  subu       $v0, $v1, $v0
    /* 903B4 8009FBB4 02004104 */  bgez       $v0, .L8009FBC0
    /* 903B8 8009FBB8 032A0500 */   sra       $a1, $a1, 8
    /* 903BC 8009FBBC FF004224 */  addiu      $v0, $v0, 0xFF
  .L8009FBC0:
    /* 903C0 8009FBC0 03120200 */  sra        $v0, $v0, 8
    /* 903C4 8009FBC4 1800A200 */  mult       $a1, $v0
    /* 903C8 8009FBC8 1180033C */  lui        $v1, %hi(divTable)
    /* 903CC 8009FBCC 1C406324 */  addiu      $v1, $v1, %lo(divTable)
    /* 903D0 8009FBD0 80100700 */  sll        $v0, $a3, 2
    /* 903D4 8009FBD4 21104300 */  addu       $v0, $v0, $v1
    /* 903D8 8009FBD8 0000458C */  lw         $a1, 0x0($v0)
    /* 903DC 8009FBDC 12480000 */  mflo       $t1
    /* 903E0 8009FBE0 CA90030C */  jal        fixedmult
    /* 903E4 8009FBE4 23208900 */   subu      $a0, $a0, $t1
    /* 903E8 8009FBE8 1C7F0208 */  j          .L8009FC70
    /* 903EC 8009FBEC 00000000 */   nop
  .L8009FBF0:
    /* 903F0 8009FBF0 0000A68C */  lw         $a2, 0x0($a1)
    /* 903F4 8009FBF4 00000000 */  nop
    /* 903F8 8009FBF8 0200C104 */  bgez       $a2, .L8009FC04
    /* 903FC 8009FBFC 00000000 */   nop
    /* 90400 8009FC00 FF00C624 */  addiu      $a2, $a2, 0xFF
  .L8009FC04:
    /* 90404 8009FC04 0000038D */  lw         $v1, 0x0($t0)
    /* 90408 8009FC08 0000028E */  lw         $v0, 0x0($s0)
    /* 9040C 8009FC0C 00000000 */  nop
    /* 90410 8009FC10 23106200 */  subu       $v0, $v1, $v0
    /* 90414 8009FC14 02004104 */  bgez       $v0, .L8009FC20
    /* 90418 8009FC18 031A0600 */   sra       $v1, $a2, 8
    /* 9041C 8009FC1C FF004224 */  addiu      $v0, $v0, 0xFF
  .L8009FC20:
    /* 90420 8009FC20 03120200 */  sra        $v0, $v0, 8
    /* 90424 8009FC24 18006200 */  mult       $v1, $v0
    /* 90428 8009FC28 0800A58C */  lw         $a1, 0x8($a1)
    /* 9042C 8009FC2C 12480000 */  mflo       $t1
    /* 90430 8009FC30 0200A104 */  bgez       $a1, .L8009FC3C
    /* 90434 8009FC34 23200900 */   negu      $a0, $t1
    /* 90438 8009FC38 FF00A524 */  addiu      $a1, $a1, 0xFF
  .L8009FC3C:
    /* 9043C 8009FC3C 0800038D */  lw         $v1, 0x8($t0)
    /* 90440 8009FC40 0800028E */  lw         $v0, 0x8($s0)
    /* 90444 8009FC44 00000000 */  nop
    /* 90448 8009FC48 23106200 */  subu       $v0, $v1, $v0
    /* 9044C 8009FC4C 02004104 */  bgez       $v0, .L8009FC58
    /* 90450 8009FC50 032A0500 */   sra       $a1, $a1, 8
    /* 90454 8009FC54 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8009FC58:
    /* 90458 8009FC58 03120200 */  sra        $v0, $v0, 8
    /* 9045C 8009FC5C 1800A200 */  mult       $a1, $v0
    /* 90460 8009FC60 2128E000 */  addu       $a1, $a3, $zero
    /* 90464 8009FC64 12480000 */  mflo       $t1
    /* 90468 8009FC68 0191030C */  jal        rdiv
    /* 9046C 8009FC6C 23208900 */   subu      $a0, $a0, $t1
  .L8009FC70:
    /* 90470 8009FC70 0400038E */  lw         $v1, 0x4($s0)
    /* 90474 8009FC74 00000000 */  nop
    /* 90478 8009FC78 21104300 */  addu       $v0, $v0, $v1
    /* 9047C 8009FC7C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 90480 8009FC80 1000B08F */  lw         $s0, 0x10($sp)
    /* 90484 8009FC84 0800E003 */  jr         $ra
    /* 90488 8009FC88 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Newton_FindGroundElevationGeneral__FP8coorddefN20
