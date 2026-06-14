.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CD_Init, 0x114

glabel CD_Init
    /* EAB94 800FA394 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* EAB98 800FA398 2000B2AF */  sw         $s2, 0x20($sp)
    /* EAB9C 800FA39C 21908000 */  addu       $s2, $a0, $zero
    /* EABA0 800FA3A0 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* EABA4 800FA3A4 2188A000 */  addu       $s1, $a1, $zero
    /* EABA8 800FA3A8 2400B3AF */  sw         $s3, 0x24($sp)
    /* EABAC 800FA3AC 2198C000 */  addu       $s3, $a2, $zero
    /* EABB0 800FA3B0 1480023C */  lui        $v0, %hi(Cdinfo)
    /* EABB4 800FA3B4 1800B0AF */  sw         $s0, 0x18($sp)
    /* EABB8 800FA3B8 C46C5024 */  addiu      $s0, $v0, %lo(Cdinfo)
    /* EABBC 800FA3BC 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* EABC0 800FA3C0 2800B4AF */  sw         $s4, 0x28($sp)
    /* EABC4 800FA3C4 0800028E */  lw         $v0, 0x8($s0)
    /* EABC8 800FA3C8 00000000 */  nop
    /* EABCC 800FA3CC 2D004014 */  bnez       $v0, .L800FA484
    /* EABD0 800FA3D0 21A0E000 */   addu      $s4, $a3, $zero
    /* EABD4 800FA3D4 2324040C */  jal        CdInit
    /* EABD8 800FA3D8 00000000 */   nop
    /* EABDC 800FA3DC 2A004010 */  beqz       $v0, .L800FA488
    /* EABE0 800FA3E0 21100000 */   addu      $v0, $zero, $zero
    /* EABE4 800FA3E4 0EDE030C */  jal        CdSetDebug
    /* EABE8 800FA3E8 21200000 */   addu      $a0, $zero, $zero
    /* EABEC 800FA3EC A724040C */  jal        CdGetToc
    /* EABF0 800FA3F0 1000A427 */   addiu     $a0, $sp, 0x10
    /* EABF4 800FA3F4 23004010 */  beqz       $v0, .L800FA484
    /* EABF8 800FA3F8 21206002 */   addu      $a0, $s3, $zero
    /* EABFC 800FA3FC 80101200 */  sll        $v0, $s2, 2
    /* EAC00 800FA400 80281100 */  sll        $a1, $s1, 2
    /* EAC04 800FA404 2128B100 */  addu       $a1, $a1, $s1
    /* EAC08 800FA408 80280500 */  sll        $a1, $a1, 2
    /* EAC0C 800FA40C 21284500 */  addu       $a1, $v0, $a1
    /* EAC10 800FA410 21108200 */  addu       $v0, $a0, $v0
    /* EAC14 800FA414 040012AE */  sw         $s2, 0x4($s0)
    /* EAC18 800FA418 340004AE */  sw         $a0, 0x34($s0)
    /* EAC1C 800FA41C E8C5030C */  jal        blockclear
    /* EAC20 800FA420 380002AE */   sw        $v0, 0x38($s0)
    /* EAC24 800FA424 2AE9030C */  jal        CD_Restart
    /* EAC28 800FA428 10000424 */   addiu     $a0, $zero, 0x10
    /* EAC2C 800FA42C 55E8030C */  jal        readsectorB
    /* EAC30 800FA430 00000000 */   nop
    /* EAC34 800FA434 21302002 */  addu       $a2, $s1, $zero
    /* EAC38 800FA438 A9004588 */  lwl        $a1, 0xA9($v0)
    /* EAC3C 800FA43C A6004598 */  lwr        $a1, 0xA6($v0)
    /* EAC40 800FA440 A1004488 */  lwl        $a0, 0xA1($v0)
    /* EAC44 800FA444 9E004498 */  lwr        $a0, 0x9E($v0)
    /* EAC48 800FA448 6AE8030C */  jal        loaddirinfo
    /* EAC4C 800FA44C C22A0500 */   srl       $a1, $a1, 11
    /* EAC50 800FA450 14000624 */  addiu      $a2, $zero, 0x14
    /* EAC54 800FA454 1080073C */  lui        $a3, %hi(func_800FA344)
    /* EAC58 800FA458 3800048E */  lw         $a0, 0x38($s0)
    /* EAC5C 800FA45C 0800058E */  lw         $a1, 0x8($s0)
    /* EAC60 800FA460 6397030C */  jal        qsort
    /* EAC64 800FA464 44A3E724 */   addiu     $a3, $a3, %lo(func_800FA344)
    /* EAC68 800FA468 1080043C */  lui        $a0, %hi(CD_Restore)
    /* EAC6C 800FA46C 64A38424 */  addiu      $a0, $a0, %lo(CD_Restore)
    /* EAC70 800FA470 3EC7030C */  jal        addexit
    /* EAC74 800FA474 300014AE */   sw        $s4, 0x30($s0)
    /* EAC78 800FA478 0800028E */  lw         $v0, 0x8($s0)
    /* EAC7C 800FA47C 22E90308 */  j          .L800FA488
    /* EAC80 800FA480 00000000 */   nop
  .L800FA484:
    /* EAC84 800FA484 21100000 */  addu       $v0, $zero, $zero
  .L800FA488:
    /* EAC88 800FA488 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* EAC8C 800FA48C 2800B48F */  lw         $s4, 0x28($sp)
    /* EAC90 800FA490 2400B38F */  lw         $s3, 0x24($sp)
    /* EAC94 800FA494 2000B28F */  lw         $s2, 0x20($sp)
    /* EAC98 800FA498 1C00B18F */  lw         $s1, 0x1C($sp)
    /* EAC9C 800FA49C 1800B08F */  lw         $s0, 0x18($sp)
    /* EACA0 800FA4A0 0800E003 */  jr         $ra
    /* EACA4 800FA4A4 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel CD_Init
