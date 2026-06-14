.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDplaytaggedpatch, 0x360

glabel iSNDplaytaggedpatch
    /* F298C 8010218C 48FEBD27 */  addiu      $sp, $sp, -0x1B8
    /* F2990 80102190 AC01B7AF */  sw         $s7, 0x1AC($sp)
    /* F2994 80102194 21B8A000 */  addu       $s7, $a1, $zero
    /* F2998 80102198 A401B5AF */  sw         $s5, 0x1A4($sp)
    /* F299C 8010219C 21A80000 */  addu       $s5, $zero, $zero
    /* F29A0 801021A0 A001B4AF */  sw         $s4, 0x1A0($sp)
    /* F29A4 801021A4 F7FF1424 */  addiu      $s4, $zero, -0x9
    /* F29A8 801021A8 9801B2AF */  sw         $s2, 0x198($sp)
    /* F29AC 801021AC 2190A002 */  addu       $s2, $s5, $zero
    /* F29B0 801021B0 9C01B3AF */  sw         $s3, 0x19C($sp)
    /* F29B4 801021B4 2198A002 */  addu       $s3, $s5, $zero
    /* F29B8 801021B8 A801B6AF */  sw         $s6, 0x1A8($sp)
    /* F29BC 801021BC 21B0A002 */  addu       $s6, $s5, $zero
    /* F29C0 801021C0 B401BFAF */  sw         $ra, 0x1B4($sp)
    /* F29C4 801021C4 B001BEAF */  sw         $fp, 0x1B0($sp)
    /* F29C8 801021C8 9401B1AF */  sw         $s1, 0x194($sp)
    /* F29CC 801021CC 03008014 */  bnez       $a0, .L801021DC
    /* F29D0 801021D0 9001B0AF */   sw        $s0, 0x190($sp)
    /* F29D4 801021D4 2F090408 */  j          .L801024BC
    /* F29D8 801021D8 F8FF0224 */   addiu     $v0, $zero, -0x8
  .L801021DC:
    /* F29DC 801021DC 0500F182 */  lb         $s1, 0x5($s7)
    /* F29E0 801021E0 0600F082 */  lb         $s0, 0x6($s7)
    /* F29E4 801021E4 8001A4AF */  sw         $a0, 0x180($sp)
    /* F29E8 801021E8 03008290 */  lbu        $v0, 0x3($a0)
    /* F29EC 801021EC 00000000 */  nop
    /* F29F0 801021F0 02004230 */  andi       $v0, $v0, 0x2
    /* F29F4 801021F4 02004014 */  bnez       $v0, .L80102200
    /* F29F8 801021F8 08008224 */   addiu     $v0, $a0, 0x8
    /* F29FC 801021FC 04008224 */  addiu      $v0, $a0, 0x4
  .L80102200:
    /* F2A00 80102200 8001A2AF */  sw         $v0, 0x180($sp)
    /* F2A04 80102204 AF06040C */  jal        iSNDresetpatch
    /* F2A08 80102208 2000A427 */   addiu     $a0, $sp, 0x20
    /* F2A0C 8010220C 2000A427 */  addiu      $a0, $sp, 0x20
    /* F2A10 80102210 B106040C */  jal        iSNDresettimbre
    /* F2A14 80102214 B800A527 */   addiu     $a1, $sp, 0xB8
    /* F2A18 80102218 4DA9030C */  jal        iSNDenteraudio
    /* F2A1C 8010221C 00000000 */   nop
    /* F2A20 80102220 FF06040C */  jal        iSNDfindfreekey
    /* F2A24 80102224 00000000 */   nop
    /* F2A28 80102228 21F04000 */  addu       $fp, $v0, $zero
  .L8010222C:
    /* F2A2C 8010222C 8001A427 */  addiu      $a0, $sp, 0x180
  .L80102230:
    /* F2A30 80102230 8401A527 */  addiu      $a1, $sp, 0x184
    /* F2A34 80102234 8801A627 */  addiu      $a2, $sp, 0x188
    /* F2A38 80102238 542F040C */  jal        iSNDgettag
    /* F2A3C 8010223C 8C01A727 */   addiu     $a3, $sp, 0x18C
    /* F2A40 80102240 40004010 */  beqz       $v0, .L80102344
    /* F2A44 80102244 FD000224 */   addiu     $v0, $zero, 0xFD
    /* F2A48 80102248 8401A58F */  lw         $a1, 0x184($sp)
    /* F2A4C 8010224C 00000000 */  nop
    /* F2A50 80102250 0400A214 */  bne        $a1, $v0, .L80102264
    /* F2A54 80102254 FE000224 */   addiu     $v0, $zero, 0xFE
    /* F2A58 80102258 8001B58F */  lw         $s5, 0x180($sp)
    /* F2A5C 8010225C 8C080408 */  j          .L80102230
    /* F2A60 80102260 8001A427 */   addiu     $a0, $sp, 0x180
  .L80102264:
    /* F2A64 80102264 2700A214 */  bne        $a1, $v0, .L80102304
    /* F2A68 80102268 2600A228 */   slti      $v0, $a1, 0x26
    /* F2A6C 8010226C 2400A28F */  lw         $v0, 0x24($sp)
    /* F2A70 80102270 00000000 */  nop
    /* F2A74 80102274 2A100202 */  slt        $v0, $s0, $v0
    /* F2A78 80102278 1E004014 */  bnez       $v0, .L801022F4
    /* F2A7C 8010227C 2000A427 */   addiu     $a0, $sp, 0x20
    /* F2A80 80102280 2800A28F */  lw         $v0, 0x28($sp)
    /* F2A84 80102284 00000000 */  nop
    /* F2A88 80102288 2A105000 */  slt        $v0, $v0, $s0
    /* F2A8C 8010228C 19004014 */  bnez       $v0, .L801022F4
    /* F2A90 80102290 00000000 */   nop
    /* F2A94 80102294 2C00A28F */  lw         $v0, 0x2C($sp)
    /* F2A98 80102298 00000000 */  nop
    /* F2A9C 8010229C 2A102202 */  slt        $v0, $s1, $v0
    /* F2AA0 801022A0 14004014 */  bnez       $v0, .L801022F4
    /* F2AA4 801022A4 00000000 */   nop
    /* F2AA8 801022A8 3000A28F */  lw         $v0, 0x30($sp)
    /* F2AAC 801022AC 00000000 */  nop
    /* F2AB0 801022B0 2A105100 */  slt        $v0, $v0, $s1
    /* F2AB4 801022B4 0F004014 */  bnez       $v0, .L801022F4
    /* F2AB8 801022B8 2128E002 */   addu      $a1, $s7, $zero
    /* F2ABC 801022BC 2120A002 */  addu       $a0, $s5, $zero
    /* F2AC0 801022C0 2000A627 */  addiu      $a2, $sp, 0x20
    /* F2AC4 801022C4 B800A727 */  addiu      $a3, $sp, 0xB8
    /* F2AC8 801022C8 1000B1AF */  sw         $s1, 0x10($sp)
    /* F2ACC 801022CC 1400B0AF */  sw         $s0, 0x14($sp)
    /* F2AD0 801022D0 2307040C */  jal        iSNDplaytaggedtimbre
    /* F2AD4 801022D4 1800B6AF */   sw        $s6, 0x18($sp)
    /* F2AD8 801022D8 21A04000 */  addu       $s4, $v0, $zero
    /* F2ADC 801022DC 6B008006 */  bltz       $s4, .L8010248C
    /* F2AE0 801022E0 80101200 */   sll       $v0, $s2, 2
    /* F2AE4 801022E4 2110A203 */  addu       $v0, $sp, $v0
    /* F2AE8 801022E8 500154AC */  sw         $s4, 0x150($v0)
    /* F2AEC 801022EC 01005226 */  addiu      $s2, $s2, 0x1
    /* F2AF0 801022F0 2000A427 */  addiu      $a0, $sp, 0x20
  .L801022F4:
    /* F2AF4 801022F4 B106040C */  jal        iSNDresettimbre
    /* F2AF8 801022F8 B800A527 */   addiu     $a1, $sp, 0xB8
    /* F2AFC 801022FC 8C080408 */  j          .L80102230
    /* F2B00 80102300 8001A427 */   addiu     $a0, $sp, 0x180
  .L80102304:
    /* F2B04 80102304 CAFF4010 */  beqz       $v0, .L80102230
    /* F2B08 80102308 8001A427 */   addiu     $a0, $sp, 0x180
    /* F2B0C 8010230C 80200500 */  sll        $a0, $a1, 2
    /* F2B10 80102310 8801A68F */  lw         $a2, 0x188($sp)
    /* F2B14 80102314 2110A403 */  addu       $v0, $sp, $a0
    /* F2B18 80102318 200046AC */  sw         $a2, 0x20($v0)
    /* F2B1C 8010231C 8C01A38F */  lw         $v1, 0x18C($sp)
    /* F2B20 80102320 00000000 */  nop
    /* F2B24 80102324 B80043AC */  sw         $v1, 0xB8($v0)
    /* F2B28 80102328 24000224 */  addiu      $v0, $zero, 0x24
    /* F2B2C 8010232C C0FFA214 */  bne        $a1, $v0, .L80102230
    /* F2B30 80102330 8001A427 */   addiu     $a0, $sp, 0x180
    /* F2B34 80102334 3D2F040C */  jal        randrange
    /* F2B38 80102338 2120C000 */   addu      $a0, $a2, $zero
    /* F2B3C 8010233C 8B080408 */  j          .L8010222C
    /* F2B40 80102340 21B04000 */   addu      $s6, $v0, $zero
  .L80102344:
    /* F2B44 80102344 2400A28F */  lw         $v0, 0x24($sp)
    /* F2B48 80102348 00000000 */  nop
    /* F2B4C 8010234C 2A100202 */  slt        $v0, $s0, $v0
    /* F2B50 80102350 1D004014 */  bnez       $v0, .L801023C8
    /* F2B54 80102354 00000000 */   nop
    /* F2B58 80102358 2800A28F */  lw         $v0, 0x28($sp)
    /* F2B5C 8010235C 00000000 */  nop
    /* F2B60 80102360 2A105000 */  slt        $v0, $v0, $s0
    /* F2B64 80102364 18004014 */  bnez       $v0, .L801023C8
    /* F2B68 80102368 00000000 */   nop
    /* F2B6C 8010236C 2C00A28F */  lw         $v0, 0x2C($sp)
    /* F2B70 80102370 00000000 */  nop
    /* F2B74 80102374 2A102202 */  slt        $v0, $s1, $v0
    /* F2B78 80102378 13004014 */  bnez       $v0, .L801023C8
    /* F2B7C 8010237C 00000000 */   nop
    /* F2B80 80102380 3000A28F */  lw         $v0, 0x30($sp)
    /* F2B84 80102384 00000000 */  nop
    /* F2B88 80102388 2A105100 */  slt        $v0, $v0, $s1
    /* F2B8C 8010238C 0E004014 */  bnez       $v0, .L801023C8
    /* F2B90 80102390 2120A002 */   addu      $a0, $s5, $zero
    /* F2B94 80102394 2128E002 */  addu       $a1, $s7, $zero
    /* F2B98 80102398 2000A627 */  addiu      $a2, $sp, 0x20
    /* F2B9C 8010239C B800A727 */  addiu      $a3, $sp, 0xB8
    /* F2BA0 801023A0 1000B1AF */  sw         $s1, 0x10($sp)
    /* F2BA4 801023A4 1400B0AF */  sw         $s0, 0x14($sp)
    /* F2BA8 801023A8 2307040C */  jal        iSNDplaytaggedtimbre
    /* F2BAC 801023AC 1800B6AF */   sw        $s6, 0x18($sp)
    /* F2BB0 801023B0 21A04000 */  addu       $s4, $v0, $zero
    /* F2BB4 801023B4 35008006 */  bltz       $s4, .L8010248C
    /* F2BB8 801023B8 80101200 */   sll       $v0, $s2, 2
    /* F2BBC 801023BC 2110A203 */  addu       $v0, $sp, $v0
    /* F2BC0 801023C0 500154AC */  sw         $s4, 0x150($v0)
    /* F2BC4 801023C4 01005226 */  addiu      $s2, $s2, 0x1
  .L801023C8:
    /* F2BC8 801023C8 30004012 */  beqz       $s2, .L8010248C
    /* F2BCC 801023CC 01000224 */   addiu     $v0, $zero, 0x1
    /* F2BD0 801023D0 11004216 */  bne        $s2, $v0, .L80102418
    /* F2BD4 801023D4 00000000 */   nop
    /* F2BD8 801023D8 5001A48F */  lw         $a0, 0x150($sp)
    /* F2BDC 801023DC 71FB030C */  jal        iSNDgetchan
    /* F2BE0 801023E0 00000000 */   nop
    /* F2BE4 801023E4 21204000 */  addu       $a0, $v0, $zero
    /* F2BE8 801023E8 24008004 */  bltz       $a0, .L8010247C
    /* F2BEC 801023EC 1480023C */   lui       $v0, %hi(D_801478F4)
    /* F2BF0 801023F0 40180400 */  sll        $v1, $a0, 1
    /* F2BF4 801023F4 21186400 */  addu       $v1, $v1, $a0
    /* F2BF8 801023F8 C0180300 */  sll        $v1, $v1, 3
    /* F2BFC 801023FC 21186400 */  addu       $v1, $v1, $a0
    /* F2C00 80102400 F478428C */  lw         $v0, %lo(D_801478F4)($v0)
    /* F2C04 80102404 80180300 */  sll        $v1, $v1, 2
    /* F2C08 80102408 21984300 */  addu       $s3, $v0, $v1
    /* F2C0C 8010240C 370060A2 */  sb         $zero, 0x37($s3)
    /* F2C10 80102410 1F090408 */  j          .L8010247C
    /* F2C14 80102414 360060A2 */   sb        $zero, 0x36($s3)
  .L80102418:
    /* F2C18 80102418 1600401A */  blez       $s2, .L80102474
    /* F2C1C 8010241C 21800000 */   addu      $s0, $zero, $zero
    /* F2C20 80102420 1480023C */  lui        $v0, %hi(sndgs)
    /* F2C24 80102424 60785524 */  addiu      $s5, $v0, %lo(sndgs)
    /* F2C28 80102428 5001B127 */  addiu      $s1, $sp, 0x150
  .L8010242C:
    /* F2C2C 8010242C 0000248E */  lw         $a0, 0x0($s1)
    /* F2C30 80102430 71FB030C */  jal        iSNDgetchan
    /* F2C34 80102434 00000000 */   nop
    /* F2C38 80102438 21204000 */  addu       $a0, $v0, $zero
    /* F2C3C 8010243C 09008004 */  bltz       $a0, .L80102464
    /* F2C40 80102440 40100400 */   sll       $v0, $a0, 1
    /* F2C44 80102444 21104400 */  addu       $v0, $v0, $a0
    /* F2C48 80102448 C0100200 */  sll        $v0, $v0, 3
    /* F2C4C 8010244C 21104400 */  addu       $v0, $v0, $a0
    /* F2C50 80102450 9400A38E */  lw         $v1, 0x94($s5)
    /* F2C54 80102454 80100200 */  sll        $v0, $v0, 2
    /* F2C58 80102458 21986200 */  addu       $s3, $v1, $v0
    /* F2C5C 8010245C 37007EA2 */  sb         $fp, 0x37($s3)
    /* F2C60 80102460 360060A2 */  sb         $zero, 0x36($s3)
  .L80102464:
    /* F2C64 80102464 01001026 */  addiu      $s0, $s0, 0x1
    /* F2C68 80102468 2A101202 */  slt        $v0, $s0, $s2
    /* F2C6C 8010246C EFFF4014 */  bnez       $v0, .L8010242C
    /* F2C70 80102470 04003126 */   addiu     $s1, $s1, 0x4
  .L80102474:
    /* F2C74 80102474 01000224 */  addiu      $v0, $zero, 0x1
    /* F2C78 80102478 360062A2 */  sb         $v0, 0x36($s3)
  .L8010247C:
    /* F2C7C 8010247C 5BA9030C */  jal        iSNDleaveaudio
    /* F2C80 80102480 00000000 */   nop
    /* F2C84 80102484 2F090408 */  j          .L801024BC
    /* F2C88 80102488 21108002 */   addu      $v0, $s4, $zero
  .L8010248C:
    /* F2C8C 8010248C 5BA9030C */  jal        iSNDleaveaudio
    /* F2C90 80102490 21800000 */   addu      $s0, $zero, $zero
    /* F2C94 80102494 0800401A */  blez       $s2, .L801024B8
    /* F2C98 80102498 5001B127 */   addiu     $s1, $sp, 0x150
  .L8010249C:
    /* F2C9C 8010249C 0000248E */  lw         $a0, 0x0($s1)
    /* F2CA0 801024A0 04003126 */  addiu      $s1, $s1, 0x4
    /* F2CA4 801024A4 A09F030C */  jal        SNDstop
    /* F2CA8 801024A8 01001026 */   addiu     $s0, $s0, 0x1
    /* F2CAC 801024AC 2A101202 */  slt        $v0, $s0, $s2
    /* F2CB0 801024B0 FAFF4014 */  bnez       $v0, .L8010249C
    /* F2CB4 801024B4 00000000 */   nop
  .L801024B8:
    /* F2CB8 801024B8 21108002 */  addu       $v0, $s4, $zero
  .L801024BC:
    /* F2CBC 801024BC B401BF8F */  lw         $ra, 0x1B4($sp)
    /* F2CC0 801024C0 B001BE8F */  lw         $fp, 0x1B0($sp)
    /* F2CC4 801024C4 AC01B78F */  lw         $s7, 0x1AC($sp)
    /* F2CC8 801024C8 A801B68F */  lw         $s6, 0x1A8($sp)
    /* F2CCC 801024CC A401B58F */  lw         $s5, 0x1A4($sp)
    /* F2CD0 801024D0 A001B48F */  lw         $s4, 0x1A0($sp)
    /* F2CD4 801024D4 9C01B38F */  lw         $s3, 0x19C($sp)
    /* F2CD8 801024D8 9801B28F */  lw         $s2, 0x198($sp)
    /* F2CDC 801024DC 9401B18F */  lw         $s1, 0x194($sp)
    /* F2CE0 801024E0 9001B08F */  lw         $s0, 0x190($sp)
    /* F2CE4 801024E4 0800E003 */  jr         $ra
    /* F2CE8 801024E8 B801BD27 */   addiu     $sp, $sp, 0x1B8
endlabel iSNDplaytaggedpatch
