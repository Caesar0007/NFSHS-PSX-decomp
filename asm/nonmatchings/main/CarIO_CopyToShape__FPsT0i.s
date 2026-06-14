.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CarIO_CopyToShape__FPsT0i, 0xA8

glabel CarIO_CopyToShape__FPsT0i
    /* AC9B4 800BC1B4 21508000 */  addu       $t2, $a0, $zero
    /* AC9B8 800BC1B8 2140A000 */  addu       $t0, $a1, $zero
    /* AC9BC 800BC1BC 16000B24 */  addiu      $t3, $zero, 0x16
    /* AC9C0 800BC1C0 FFFF0C24 */  addiu      $t4, $zero, -0x1
  .L800BC1C4:
    /* AC9C4 800BC1C4 FFFF6B25 */  addiu      $t3, $t3, -0x1
    /* AC9C8 800BC1C8 22006C11 */  beq        $t3, $t4, .L800BC254
    /* AC9CC 800BC1CC 00000000 */   nop
    /* AC9D0 800BC1D0 0C00C014 */  bnez       $a2, .L800BC204
    /* AC9D4 800BC1D4 05000724 */   addiu     $a3, $zero, 0x5
    /* AC9D8 800BC1D8 21380000 */  addu       $a3, $zero, $zero
    /* AC9DC 800BC1DC 21184001 */  addu       $v1, $t2, $zero
  .L800BC1E0:
    /* AC9E0 800BC1E0 00006294 */  lhu        $v0, 0x0($v1)
    /* AC9E4 800BC1E4 02006324 */  addiu      $v1, $v1, 0x2
    /* AC9E8 800BC1E8 0100E724 */  addiu      $a3, $a3, 0x1
    /* AC9EC 800BC1EC 000002A5 */  sh         $v0, 0x0($t0)
    /* AC9F0 800BC1F0 0600E228 */  slti       $v0, $a3, 0x6
    /* AC9F4 800BC1F4 FAFF4014 */  bnez       $v0, .L800BC1E0
    /* AC9F8 800BC1F8 02000825 */   addiu     $t0, $t0, 0x2
    /* AC9FC 800BC1FC 71F00208 */  j          .L800BC1C4
    /* ACA00 800BC200 18004A25 */   addiu     $t2, $t2, 0x18
  .L800BC204:
    /* ACA04 800BC204 0A004925 */  addiu      $t1, $t2, 0xA
  .L800BC208:
    /* ACA08 800BC208 1000E004 */  bltz       $a3, .L800BC24C
    /* ACA0C 800BC20C FFFFE724 */   addiu     $a3, $a3, -0x1
    /* ACA10 800BC210 00002395 */  lhu        $v1, 0x0($t1)
    /* ACA14 800BC214 FEFF2925 */  addiu      $t1, $t1, -0x2
    /* ACA18 800BC218 0F006230 */  andi       $v0, $v1, 0xF
    /* ACA1C 800BC21C 00130200 */  sll        $v0, $v0, 12
    /* ACA20 800BC220 F0006530 */  andi       $a1, $v1, 0xF0
    /* ACA24 800BC224 00290500 */  sll        $a1, $a1, 4
    /* ACA28 800BC228 000F6430 */  andi       $a0, $v1, 0xF00
    /* ACA2C 800BC22C 02210400 */  srl        $a0, $a0, 4
    /* ACA30 800BC230 021B0300 */  srl        $v1, $v1, 12
    /* ACA34 800BC234 25104500 */  or         $v0, $v0, $a1
    /* ACA38 800BC238 25104400 */  or         $v0, $v0, $a0
    /* ACA3C 800BC23C 25104300 */  or         $v0, $v0, $v1
    /* ACA40 800BC240 000002A5 */  sh         $v0, 0x0($t0)
    /* ACA44 800BC244 82F00208 */  j          .L800BC208
    /* ACA48 800BC248 02000825 */   addiu     $t0, $t0, 0x2
  .L800BC24C:
    /* ACA4C 800BC24C 71F00208 */  j          .L800BC1C4
    /* ACA50 800BC250 18004A25 */   addiu     $t2, $t2, 0x18
  .L800BC254:
    /* ACA54 800BC254 0800E003 */  jr         $ra
    /* ACA58 800BC258 00000000 */   nop
endlabel CarIO_CopyToShape__FPsT0i
