.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDSTRM_autovol, 0x88

glabel SNDSTRM_autovol
    /* DA5E8 800E9DE8 1480023C */  lui        $v0, %hi(D_8014789C)
    /* DA5EC 800E9DEC 9C784280 */  lb         $v0, %lo(D_8014789C)($v0)
    /* DA5F0 800E9DF0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DA5F4 800E9DF4 1000B0AF */  sw         $s0, 0x10($sp)
    /* DA5F8 800E9DF8 2180A000 */  addu       $s0, $a1, $zero
    /* DA5FC 800E9DFC 1400B1AF */  sw         $s1, 0x14($sp)
    /* DA600 800E9E00 2188C000 */  addu       $s1, $a2, $zero
    /* DA604 800E9E04 03004014 */  bnez       $v0, .L800E9E14
    /* DA608 800E9E08 1800BFAF */   sw        $ra, 0x18($sp)
    /* DA60C 800E9E0C 97A70308 */  j          .L800E9E5C
    /* DA610 800E9E10 F6FF0224 */   addiu     $v0, $zero, -0xA
  .L800E9E14:
    /* DA614 800E9E14 12A3030C */  jal        iSNDstreamgetstreamptr
    /* DA618 800E9E18 00000000 */   nop
    /* DA61C 800E9E1C 21184000 */  addu       $v1, $v0, $zero
    /* DA620 800E9E20 0D006010 */  beqz       $v1, .L800E9E58
    /* DA624 800E9E24 6666023C */   lui       $v0, (0x66666667 >> 16)
    /* DA628 800E9E28 67664234 */  ori        $v0, $v0, (0x66666667 & 0xFFFF)
    /* DA62C 800E9E2C 18000202 */  mult       $s0, $v0
    /* DA630 800E9E30 C32F1000 */  sra        $a1, $s0, 31
    /* DA634 800E9E34 0800648C */  lw         $a0, 0x8($v1)
    /* DA638 800E9E38 21302002 */  addu       $a2, $s1, $zero
    /* DA63C 800E9E3C 540071A0 */  sb         $s1, 0x54($v1)
    /* DA640 800E9E40 10380000 */  mfhi       $a3
    /* DA644 800E9E44 83100700 */  sra        $v0, $a3, 2
    /* DA648 800E9E48 B4A0030C */  jal        SNDautovol
    /* DA64C 800E9E4C 23284500 */   subu      $a1, $v0, $a1
    /* DA650 800E9E50 97A70308 */  j          .L800E9E5C
    /* DA654 800E9E54 21100000 */   addu      $v0, $zero, $zero
  .L800E9E58:
    /* DA658 800E9E58 F8FF0224 */  addiu      $v0, $zero, -0x8
  .L800E9E5C:
    /* DA65C 800E9E5C 1800BF8F */  lw         $ra, 0x18($sp)
    /* DA660 800E9E60 1400B18F */  lw         $s1, 0x14($sp)
    /* DA664 800E9E64 1000B08F */  lw         $s0, 0x10($sp)
    /* DA668 800E9E68 0800E003 */  jr         $ra
    /* DA66C 800E9E6C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SNDSTRM_autovol
