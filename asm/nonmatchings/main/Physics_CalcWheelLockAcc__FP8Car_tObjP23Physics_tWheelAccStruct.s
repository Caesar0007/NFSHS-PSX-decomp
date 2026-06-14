.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Physics_CalcWheelLockAcc__FP8Car_tObjP23Physics_tWheelAccStruct, 0x1FC

glabel Physics_CalcWheelLockAcc__FP8Car_tObjP23Physics_tWheelAccStruct
    /* 9BC9C 800AB49C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 9BCA0 800AB4A0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 9BCA4 800AB4A4 2180A000 */  addu       $s0, $a1, $zero
    /* 9BCA8 800AB4A8 1400BFAF */  sw         $ra, 0x14($sp)
    /* 9BCAC 800AB4AC 2800028E */  lw         $v0, 0x28($s0)
    /* 9BCB0 800AB4B0 00000000 */  nop
    /* 9BCB4 800AB4B4 0A004010 */  beqz       $v0, .L800AB4E0
    /* 9BCB8 800AB4B8 21408000 */   addu      $t0, $a0, $zero
    /* 9BCBC 800AB4BC 8404028D */  lw         $v0, 0x484($t0)
    /* 9BCC0 800AB4C0 0400038E */  lw         $v1, 0x4($s0)
    /* 9BCC4 800AB4C4 00000000 */  nop
    /* 9BCC8 800AB4C8 02006104 */  bgez       $v1, .L800AB4D4
    /* 9BCCC 800AB4CC 2C0002AE */   sw        $v0, 0x2C($s0)
    /* 9BCD0 800AB4D0 FF006324 */  addiu      $v1, $v1, 0xFF
  .L800AB4D4:
    /* 9BCD4 800AB4D4 BC0D828F */  lw         $v0, %gp_rel(frontMult)($gp)
    /* 9BCD8 800AB4D8 40AD0208 */  j          .L800AB500
    /* 9BCDC 800AB4DC 031A0300 */   sra       $v1, $v1, 8
  .L800AB4E0:
    /* 9BCE0 800AB4E0 8804028D */  lw         $v0, 0x488($t0)
    /* 9BCE4 800AB4E4 0400038E */  lw         $v1, 0x4($s0)
    /* 9BCE8 800AB4E8 00000000 */  nop
    /* 9BCEC 800AB4EC 02006104 */  bgez       $v1, .L800AB4F8
    /* 9BCF0 800AB4F0 2C0002AE */   sw        $v0, 0x2C($s0)
    /* 9BCF4 800AB4F4 FF006324 */  addiu      $v1, $v1, 0xFF
  .L800AB4F8:
    /* 9BCF8 800AB4F8 C00D828F */  lw         $v0, %gp_rel(rearMult)($gp)
    /* 9BCFC 800AB4FC 031A0300 */  sra        $v1, $v1, 8
  .L800AB500:
    /* 9BD00 800AB500 02004104 */  bgez       $v0, .L800AB50C
    /* 9BD04 800AB504 00000000 */   nop
    /* 9BD08 800AB508 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AB50C:
    /* 9BD0C 800AB50C 03120200 */  sra        $v0, $v0, 8
    /* 9BD10 800AB510 18006200 */  mult       $v1, $v0
    /* 9BD14 800AB514 12300000 */  mflo       $a2
    /* 9BD18 800AB518 1000028E */  lw         $v0, 0x10($s0)
    /* 9BD1C 800AB51C 1800038E */  lw         $v1, 0x18($s0)
    /* 9BD20 800AB520 02004104 */  bgez       $v0, .L800AB52C
    /* 9BD24 800AB524 21384000 */   addu      $a3, $v0, $zero
    /* 9BD28 800AB528 23380700 */  negu       $a3, $a3
  .L800AB52C:
    /* 9BD2C 800AB52C 02006104 */  bgez       $v1, .L800AB538
    /* 9BD30 800AB530 21206000 */   addu      $a0, $v1, $zero
    /* 9BD34 800AB534 23200400 */  negu       $a0, $a0
  .L800AB538:
    /* 9BD38 800AB538 2A108700 */  slt        $v0, $a0, $a3
    /* 9BD3C 800AB53C 03004010 */  beqz       $v0, .L800AB54C
    /* 9BD40 800AB540 83100400 */   sra       $v0, $a0, 2
    /* 9BD44 800AB544 55AD0208 */  j          .L800AB554
    /* 9BD48 800AB548 2128E200 */   addu      $a1, $a3, $v0
  .L800AB54C:
    /* 9BD4C 800AB54C 83100700 */  sra        $v0, $a3, 2
    /* 9BD50 800AB550 21288200 */  addu       $a1, $a0, $v0
  .L800AB554:
    /* 9BD54 800AB554 CC0D828F */  lw         $v0, %gp_rel(slippery)($gp)
    /* 9BD58 800AB558 00000000 */  nop
    /* 9BD5C 800AB55C 06004010 */  beqz       $v0, .L800AB578
    /* 9BD60 800AB560 1180033C */   lui       $v1, %hi(gripLossTableWet)
    /* 9BD64 800AB564 8802028D */  lw         $v0, 0x288($t0)
    /* 9BD68 800AB568 00000000 */  nop
    /* 9BD6C 800AB56C 3800428C */  lw         $v0, 0x38($v0)
    /* 9BD70 800AB570 62AD0208 */  j          .L800AB588
    /* 9BD74 800AB574 C8656324 */   addiu     $v1, $v1, %lo(gripLossTableWet)
  .L800AB578:
    /* 9BD78 800AB578 8802028D */  lw         $v0, 0x288($t0)
    /* 9BD7C 800AB57C 1180033C */  lui        $v1, %hi(gripLossTable)
    /* 9BD80 800AB580 3800428C */  lw         $v0, 0x38($v0)
    /* 9BD84 800AB584 BC656324 */  addiu      $v1, $v1, %lo(gripLossTable)
  .L800AB588:
    /* 9BD88 800AB588 80100200 */  sll        $v0, $v0, 2
    /* 9BD8C 800AB58C 21104300 */  addu       $v0, $v0, $v1
    /* 9BD90 800AB590 0000428C */  lw         $v0, 0x0($v0)
    /* 9BD94 800AB594 00000000 */  nop
    /* 9BD98 800AB598 1A00C200 */  div        $zero, $a2, $v0
    /* 9BD9C 800AB59C 02004014 */  bnez       $v0, .L800AB5A8
    /* 9BDA0 800AB5A0 00000000 */   nop
    /* 9BDA4 800AB5A4 0D000700 */  break      7
  .L800AB5A8:
    /* 9BDA8 800AB5A8 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 9BDAC 800AB5AC 04004114 */  bne        $v0, $at, .L800AB5C0
    /* 9BDB0 800AB5B0 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 9BDB4 800AB5B4 0200C114 */  bne        $a2, $at, .L800AB5C0
    /* 9BDB8 800AB5B8 00000000 */   nop
    /* 9BDBC 800AB5BC 0D000600 */  break      6
  .L800AB5C0:
    /* 9BDC0 800AB5C0 12100000 */  mflo       $v0
    /* 9BDC4 800AB5C4 00000000 */  nop
    /* 9BDC8 800AB5C8 2320C200 */  subu       $a0, $a2, $v0
    /* 9BDCC 800AB5CC 2A10C500 */  slt        $v0, $a2, $a1
    /* 9BDD0 800AB5D0 0A004010 */  beqz       $v0, .L800AB5FC
    /* 9BDD4 800AB5D4 00000000 */   nop
    /* 9BDD8 800AB5D8 2C00028E */  lw         $v0, 0x2C($s0)
    /* 9BDDC 800AB5DC 00000000 */  nop
    /* 9BDE0 800AB5E0 40180200 */  sll        $v1, $v0, 1
    /* 9BDE4 800AB5E4 21186200 */  addu       $v1, $v1, $v0
    /* 9BDE8 800AB5E8 2310A600 */  subu       $v0, $a1, $a2
    /* 9BDEC 800AB5EC 21186200 */  addu       $v1, $v1, $v0
    /* 9BDF0 800AB5F0 83180300 */  sra        $v1, $v1, 2
    /* 9BDF4 800AB5F4 80AD0208 */  j          .L800AB600
    /* 9BDF8 800AB5F8 2C0003AE */   sw        $v1, 0x2C($s0)
  .L800AB5FC:
    /* 9BDFC 800AB5FC 2C0000AE */  sw         $zero, 0x2C($s0)
  .L800AB600:
    /* 9BE00 800AB600 8802028D */  lw         $v0, 0x288($t0)
    /* 9BE04 800AB604 00000000 */  nop
    /* 9BE08 800AB608 3800438C */  lw         $v1, 0x38($v0)
    /* 9BE0C 800AB60C 02000224 */  addiu      $v0, $zero, 0x2
    /* 9BE10 800AB610 02006214 */  bne        $v1, $v0, .L800AB61C
    /* 9BE14 800AB614 0A00063C */   lui       $a2, (0xA0000 >> 16)
    /* 9BE18 800AB618 0800063C */  lui        $a2, (0x80000 >> 16)
  .L800AB61C:
    /* 9BE1C 800AB61C 2C00038E */  lw         $v1, 0x2C($s0)
    /* 9BE20 800AB620 2110C000 */  addu       $v0, $a2, $zero
    /* 9BE24 800AB624 2A104300 */  slt        $v0, $v0, $v1
    /* 9BE28 800AB628 02004014 */  bnez       $v0, .L800AB634
    /* 9BE2C 800AB62C 00000000 */   nop
    /* 9BE30 800AB630 21306000 */  addu       $a2, $v1, $zero
  .L800AB634:
    /* 9BE34 800AB634 0200A104 */  bgez       $a1, .L800AB640
    /* 9BE38 800AB638 2110A000 */   addu      $v0, $a1, $zero
    /* 9BE3C 800AB63C 23100200 */  negu       $v0, $v0
  .L800AB640:
    /* 9BE40 800AB640 01014228 */  slti       $v0, $v0, 0x101
    /* 9BE44 800AB644 04004014 */  bnez       $v0, .L800AB658
    /* 9BE48 800AB648 2C0006AE */   sw        $a2, 0x2C($s0)
    /* 9BE4C 800AB64C 0191030C */  jal        rdiv
    /* 9BE50 800AB650 00000000 */   nop
    /* 9BE54 800AB654 033A0200 */  sra        $a3, $v0, 8
  .L800AB658:
    /* 9BE58 800AB658 1000028E */  lw         $v0, 0x10($s0)
    /* 9BE5C 800AB65C 00000000 */  nop
    /* 9BE60 800AB660 18004700 */  mult       $v0, $a3
    /* 9BE64 800AB664 12300000 */  mflo       $a2
    /* 9BE68 800AB668 1800028E */  lw         $v0, 0x18($s0)
    /* 9BE6C 800AB66C 00000000 */  nop
    /* 9BE70 800AB670 18004700 */  mult       $v0, $a3
    /* 9BE74 800AB674 03120600 */  sra        $v0, $a2, 8
    /* 9BE78 800AB678 1C0002AE */  sw         $v0, 0x1C($s0)
    /* 9BE7C 800AB67C 12180000 */  mflo       $v1
    /* 9BE80 800AB680 03120300 */  sra        $v0, $v1, 8
    /* 9BE84 800AB684 240002AE */  sw         $v0, 0x24($s0)
    /* 9BE88 800AB688 1400BF8F */  lw         $ra, 0x14($sp)
    /* 9BE8C 800AB68C 1000B08F */  lw         $s0, 0x10($sp)
    /* 9BE90 800AB690 0800E003 */  jr         $ra
    /* 9BE94 800AB694 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Physics_CalcWheelLockAcc__FP8Car_tObjP23Physics_tWheelAccStruct
