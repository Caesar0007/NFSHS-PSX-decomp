.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Night_AdditiveNightCalc__FP6VECTORP7CVECTOR, 0x100

glabel Night_AdditiveNightCalc__FP6VECTORP7CVECTOR
    /* CC9B8 800DC1B8 01000A24 */  addiu      $t2, $zero, 0x1
    /* CC9BC 800DC1BC F014898F */  lw         $t1, %gp_rel(Night_gZDistShift)($gp)
    /* CC9C0 800DC1C0 0800838C */  lw         $v1, 0x8($a0)
    /* CC9C4 800DC1C4 E414878F */  lw         $a3, %gp_rel(Night_gZNear)($gp)
    /* CC9C8 800DC1C8 06002225 */  addiu      $v0, $t1, 0x6
    /* CC9CC 800DC1CC 04104A00 */  sllv       $v0, $t2, $v0
    /* CC9D0 800DC1D0 2130E200 */  addu       $a2, $a3, $v0
    /* CC9D4 800DC1D4 2A10E300 */  slt        $v0, $a3, $v1
    /* CC9D8 800DC1D8 35004010 */  beqz       $v0, .L800DC2B0
    /* CC9DC 800DC1DC 2A106600 */   slt       $v0, $v1, $a2
    /* CC9E0 800DC1E0 33004010 */  beqz       $v0, .L800DC2B0
    /* CC9E4 800DC1E4 00000000 */   nop
    /* CC9E8 800DC1E8 EC14888F */  lw         $t0, %gp_rel(Night_gXDistShift)($gp)
    /* CC9EC 800DC1EC 0000848C */  lw         $a0, 0x0($a0)
    /* CC9F0 800DC1F0 05000225 */  addiu      $v0, $t0, 0x5
    /* CC9F4 800DC1F4 04304A00 */  sllv       $a2, $t2, $v0
    /* CC9F8 800DC1F8 23100600 */  negu       $v0, $a2
    /* CC9FC 800DC1FC 2A104400 */  slt        $v0, $v0, $a0
    /* CCA00 800DC200 2B004010 */  beqz       $v0, .L800DC2B0
    /* CCA04 800DC204 2A108600 */   slt       $v0, $a0, $a2
    /* CCA08 800DC208 29004010 */  beqz       $v0, .L800DC2B0
    /* CCA0C 800DC20C 23186700 */   subu      $v1, $v1, $a3
    /* CCA10 800DC210 07182301 */  srav       $v1, $v1, $t1
    /* CCA14 800DC214 21208600 */  addu       $a0, $a0, $a2
    /* CCA18 800DC218 07200401 */  srav       $a0, $a0, $t0
    /* CCA1C 800DC21C 80110300 */  sll        $v0, $v1, 6
    /* CCA20 800DC220 21104400 */  addu       $v0, $v0, $a0
    /* CCA24 800DC224 1280043C */  lui        $a0, %hi(Night_gAdditiveHeadlightColor)
    /* CCA28 800DC228 BC0D8424 */  addiu      $a0, $a0, %lo(Night_gAdditiveHeadlightColor)
    /* CCA2C 800DC22C F414838F */  lw         $v1, %gp_rel(Night_gNightTbl)($gp)
    /* CCA30 800DC230 0000A790 */  lbu        $a3, 0x0($a1)
    /* CCA34 800DC234 21186200 */  addu       $v1, $v1, $v0
    /* CCA38 800DC238 00006290 */  lbu        $v0, 0x0($v1)
    /* CCA3C 800DC23C 0100A890 */  lbu        $t0, 0x1($a1)
    /* CCA40 800DC240 80100200 */  sll        $v0, $v0, 2
    /* CCA44 800DC244 21104400 */  addu       $v0, $v0, $a0
    /* CCA48 800DC248 0000438C */  lw         $v1, 0x0($v0)
    /* CCA4C 800DC24C 0200A690 */  lbu        $a2, 0x2($a1)
    /* CCA50 800DC250 FF006430 */  andi       $a0, $v1, 0xFF
    /* CCA54 800DC254 2120E400 */  addu       $a0, $a3, $a0
    /* CCA58 800DC258 21388000 */  addu       $a3, $a0, $zero
    /* CCA5C 800DC25C 00FF6230 */  andi       $v0, $v1, 0xFF00
    /* CCA60 800DC260 03120200 */  sra        $v0, $v0, 8
    /* CCA64 800DC264 21100201 */  addu       $v0, $t0, $v0
    /* CCA68 800DC268 21404000 */  addu       $t0, $v0, $zero
    /* CCA6C 800DC26C 021C0300 */  srl        $v1, $v1, 16
    /* CCA70 800DC270 FF006330 */  andi       $v1, $v1, 0xFF
    /* CCA74 800DC274 2118C300 */  addu       $v1, $a2, $v1
    /* CCA78 800DC278 00018428 */  slti       $a0, $a0, 0x100
    /* CCA7C 800DC27C 02008014 */  bnez       $a0, .L800DC288
    /* CCA80 800DC280 21306000 */   addu      $a2, $v1, $zero
    /* CCA84 800DC284 FF000724 */  addiu      $a3, $zero, 0xFF
  .L800DC288:
    /* CCA88 800DC288 00014228 */  slti       $v0, $v0, 0x100
    /* CCA8C 800DC28C 02004014 */  bnez       $v0, .L800DC298
    /* CCA90 800DC290 00016228 */   slti      $v0, $v1, 0x100
    /* CCA94 800DC294 FF000824 */  addiu      $t0, $zero, 0xFF
  .L800DC298:
    /* CCA98 800DC298 02004014 */  bnez       $v0, .L800DC2A4
    /* CCA9C 800DC29C 00000000 */   nop
    /* CCAA0 800DC2A0 FF000624 */  addiu      $a2, $zero, 0xFF
  .L800DC2A4:
    /* CCAA4 800DC2A4 0000A7A0 */  sb         $a3, 0x0($a1)
    /* CCAA8 800DC2A8 0100A8A0 */  sb         $t0, 0x1($a1)
    /* CCAAC 800DC2AC 0200A6A0 */  sb         $a2, 0x2($a1)
  .L800DC2B0:
    /* CCAB0 800DC2B0 0800E003 */  jr         $ra
    /* CCAB4 800DC2B4 00000000 */   nop
endlabel Night_AdditiveNightCalc__FP6VECTORP7CVECTOR
