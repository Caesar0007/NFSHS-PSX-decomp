.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDsetvol, 0x15C

glabel iSNDsetvol
    /* EFA38 800FF238 40100400 */  sll        $v0, $a0, 1
    /* EFA3C 800FF23C 21104400 */  addu       $v0, $v0, $a0
    /* EFA40 800FF240 80100200 */  sll        $v0, $v0, 2
    /* EFA44 800FF244 23104400 */  subu       $v0, $v0, $a0
    /* EFA48 800FF248 80100200 */  sll        $v0, $v0, 2
    /* EFA4C 800FF24C 1480033C */  lui        $v1, %hi(D_801479F0)
    /* EFA50 800FF250 F0796324 */  addiu      $v1, $v1, %lo(D_801479F0)
    /* EFA54 800FF254 21404300 */  addu       $t0, $v0, $v1
    /* EFA58 800FF258 28FF6924 */  addiu      $t1, $v1, -0xD8
    /* EFA5C 800FF25C 00210400 */  sll        $a0, $a0, 4
    /* EFA60 800FF260 1005228D */  lw         $v0, 0x510($t1)
    /* EFA64 800FF264 1F000391 */  lbu        $v1, 0x1F($t0)
    /* EFA68 800FF268 21384400 */  addu       $a3, $v0, $a0
    /* EFA6C 800FF26C FF006430 */  andi       $a0, $v1, 0xFF
    /* EFA70 800FF270 01000224 */  addiu      $v0, $zero, 0x1
    /* EFA74 800FF274 23008214 */  bne        $a0, $v0, .L800FF304
    /* EFA78 800FF278 1480023C */   lui       $v0, %hi(D_80147870)
    /* EFA7C 800FF27C 70784390 */  lbu        $v1, %lo(D_80147870)($v0)
    /* EFA80 800FF280 02000224 */  addiu      $v0, $zero, 0x2
    /* EFA84 800FF284 09006214 */  bne        $v1, $v0, .L800FF2AC
    /* EFA88 800FF288 C0110500 */   sll       $v0, $a1, 7
    /* EFA8C 800FF28C 21104500 */  addu       $v0, $v0, $a1
    /* EFA90 800FF290 FF7F4230 */  andi       $v0, $v0, 0x7FFF
    /* EFA94 800FF294 0000E2A4 */  sh         $v0, 0x0($a3)
    /* EFA98 800FF298 C0110600 */  sll        $v0, $a2, 7
    /* EFA9C 800FF29C 21104600 */  addu       $v0, $v0, $a2
    /* EFAA0 800FF2A0 FF7F4230 */  andi       $v0, $v0, 0x7FFF
    /* EFAA4 800FF2A4 0800E003 */  jr         $ra
    /* EFAA8 800FF2A8 0200E2A4 */   sh        $v0, 0x2($a3)
  .L800FF2AC:
    /* EFAAC 800FF2AC 1E000291 */  lbu        $v0, 0x1E($t0)
    /* EFAB0 800FF2B0 00000000 */  nop
    /* EFAB4 800FF2B4 0E004414 */  bne        $v0, $a0, .L800FF2F0
    /* EFAB8 800FF2B8 2118A600 */   addu      $v1, $a1, $a2
    /* EFABC 800FF2BC 0200A104 */  bgez       $a1, .L800FF2C8
    /* EFAC0 800FF2C0 00000000 */   nop
    /* EFAC4 800FF2C4 23280500 */  negu       $a1, $a1
  .L800FF2C8:
    /* EFAC8 800FF2C8 0200C104 */  bgez       $a2, .L800FF2D4
    /* EFACC 800FF2CC 8000A228 */   slti      $v0, $a1, 0x80
    /* EFAD0 800FF2D0 23300600 */  negu       $a2, $a2
  .L800FF2D4:
    /* EFAD4 800FF2D4 02004014 */  bnez       $v0, .L800FF2E0
    /* EFAD8 800FF2D8 8000C228 */   slti      $v0, $a2, 0x80
    /* EFADC 800FF2DC 7F000524 */  addiu      $a1, $zero, 0x7F
  .L800FF2E0:
    /* EFAE0 800FF2E0 03004014 */  bnez       $v0, .L800FF2F0
    /* EFAE4 800FF2E4 2118A600 */   addu      $v1, $a1, $a2
    /* EFAE8 800FF2E8 7F000624 */  addiu      $a2, $zero, 0x7F
    /* EFAEC 800FF2EC 2118A600 */  addu       $v1, $a1, $a2
  .L800FF2F0:
    /* EFAF0 800FF2F0 C0110300 */  sll        $v0, $v1, 7
    /* EFAF4 800FF2F4 21104300 */  addu       $v0, $v0, $v1
    /* EFAF8 800FF2F8 43100200 */  sra        $v0, $v0, 1
    /* EFAFC 800FF2FC E2FC0308 */  j          .L800FF388
    /* EFB00 800FF300 FF7F4430 */   andi      $a0, $v0, 0x7FFF
  .L800FF304:
    /* EFB04 800FF304 70784390 */  lbu        $v1, %lo(D_80147870)($v0)
    /* EFB08 800FF308 02000224 */  addiu      $v0, $zero, 0x2
    /* EFB0C 800FF30C 10006214 */  bne        $v1, $v0, .L800FF350
    /* EFB10 800FF310 C0110500 */   sll       $v0, $a1, 7
    /* EFB14 800FF314 21104500 */  addu       $v0, $v0, $a1
    /* EFB18 800FF318 FF7F4230 */  andi       $v0, $v0, 0x7FFF
    /* EFB1C 800FF31C 0000E2A4 */  sh         $v0, 0x0($a3)
    /* EFB20 800FF320 0200E0A4 */  sh         $zero, 0x2($a3)
    /* EFB24 800FF324 20000291 */  lbu        $v0, 0x20($t0)
    /* EFB28 800FF328 1005238D */  lw         $v1, 0x510($t1)
    /* EFB2C 800FF32C 00160200 */  sll        $v0, $v0, 24
    /* EFB30 800FF330 03150200 */  sra        $v0, $v0, 20
    /* EFB34 800FF334 21386200 */  addu       $a3, $v1, $v0
    /* EFB38 800FF338 C0110600 */  sll        $v0, $a2, 7
    /* EFB3C 800FF33C 21104600 */  addu       $v0, $v0, $a2
    /* EFB40 800FF340 FF7F4230 */  andi       $v0, $v0, 0x7FFF
    /* EFB44 800FF344 0000E0A4 */  sh         $zero, 0x0($a3)
    /* EFB48 800FF348 0800E003 */  jr         $ra
    /* EFB4C 800FF34C 0200E2A4 */   sh        $v0, 0x2($a3)
  .L800FF350:
    /* EFB50 800FF350 21104500 */  addu       $v0, $v0, $a1
    /* EFB54 800FF354 43100200 */  sra        $v0, $v0, 1
    /* EFB58 800FF358 FF7F4430 */  andi       $a0, $v0, 0x7FFF
    /* EFB5C 800FF35C C0110600 */  sll        $v0, $a2, 7
    /* EFB60 800FF360 21104600 */  addu       $v0, $v0, $a2
    /* EFB64 800FF364 43100200 */  sra        $v0, $v0, 1
    /* EFB68 800FF368 0000E4A4 */  sh         $a0, 0x0($a3)
    /* EFB6C 800FF36C 0200E4A4 */  sh         $a0, 0x2($a3)
    /* EFB70 800FF370 FF7F4430 */  andi       $a0, $v0, 0x7FFF
    /* EFB74 800FF374 20000391 */  lbu        $v1, 0x20($t0)
    /* EFB78 800FF378 1005228D */  lw         $v0, 0x510($t1)
    /* EFB7C 800FF37C 001E0300 */  sll        $v1, $v1, 24
    /* EFB80 800FF380 031D0300 */  sra        $v1, $v1, 20
    /* EFB84 800FF384 21384300 */  addu       $a3, $v0, $v1
  .L800FF388:
    /* EFB88 800FF388 0000E4A4 */  sh         $a0, 0x0($a3)
    /* EFB8C 800FF38C 0800E003 */  jr         $ra
    /* EFB90 800FF390 0200E4A4 */   sh        $a0, 0x2($a3)
endlabel iSNDsetvol
