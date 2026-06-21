.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawLeftFlare__FiiiRi, 0x15C

glabel DrawLeftFlare__FiiiRi
    /* C7A0 8001BFA0 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* C7A4 8001BFA4 3000B4AF */  sw         $s4, 0x30($sp)
    /* C7A8 8001BFA8 21A08000 */  addu       $s4, $a0, $zero
    /* C7AC 8001BFAC 80000224 */  addiu      $v0, $zero, 0x80
    /* C7B0 8001BFB0 3400BFAF */  sw         $ra, 0x34($sp)
    /* C7B4 8001BFB4 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* C7B8 8001BFB8 2800B2AF */  sw         $s2, 0x28($sp)
    /* C7BC 8001BFBC 2400B1AF */  sw         $s1, 0x24($sp)
    /* C7C0 8001BFC0 0400A214 */  bne        $a1, $v0, .L8001BFD4
    /* C7C4 8001BFC4 2000B0AF */   sw        $s0, 0x20($sp)
    /* C7C8 8001BFC8 0000E28C */  lw         $v0, 0x0($a3)
    /* C7CC 8001BFCC F96F0008 */  j          .L8001BFE4
    /* C7D0 8001BFD0 01004224 */   addiu     $v0, $v0, 0x1
  .L8001BFD4:
    /* C7D4 8001BFD4 0000E28C */  lw         $v0, 0x0($a3)
    /* C7D8 8001BFD8 00000000 */  nop
    /* C7DC 8001BFDC 02004010 */  beqz       $v0, .L8001BFE8
    /* C7E0 8001BFE0 05004224 */   addiu     $v0, $v0, 0x5
  .L8001BFE4:
    /* C7E4 8001BFE4 0000E2AC */  sw         $v0, 0x0($a3)
  .L8001BFE8:
    /* C7E8 8001BFE8 0000E28C */  lw         $v0, 0x0($a3)
    /* C7EC 8001BFEC 00000000 */  nop
    /* C7F0 8001BFF0 3D004228 */  slti       $v0, $v0, 0x3D
    /* C7F4 8001BFF4 02004014 */  bnez       $v0, .L8001C000
    /* C7F8 8001BFF8 00000000 */   nop
    /* C7FC 8001BFFC 0000E0AC */  sw         $zero, 0x0($a3)
  .L8001C000:
    /* C800 8001C000 0000E78C */  lw         $a3, 0x0($a3)
    /* C804 8001C004 00000000 */  nop
    /* C808 8001C008 1F00E228 */  slti       $v0, $a3, 0x1F
    /* C80C 8001C00C 05004014 */  bnez       $v0, .L8001C024
    /* C810 8001C010 3C000224 */   addiu     $v0, $zero, 0x3C
    /* C814 8001C014 23104700 */  subu       $v0, $v0, $a3
    /* C818 8001C018 C21F0200 */  srl        $v1, $v0, 31
    /* C81C 8001C01C 0B700008 */  j          .L8001C02C
    /* C820 8001C020 21104300 */   addu      $v0, $v0, $v1
  .L8001C024:
    /* C824 8001C024 C2170700 */  srl        $v0, $a3, 31
    /* C828 8001C028 2110E200 */  addu       $v0, $a3, $v0
  .L8001C02C:
    /* C82C 8001C02C 43880200 */  sra        $s1, $v0, 1
    /* C830 8001C030 14003126 */  addiu      $s1, $s1, 0x14
    /* C834 8001C034 18002502 */  mult       $s1, $a1
    /* C838 8001C038 12880000 */  mflo       $s1
    /* C83C 8001C03C 80000324 */  addiu      $v1, $zero, 0x80
    /* C840 8001C040 23106600 */  subu       $v0, $v1, $a2
    /* C844 8001C044 18002202 */  mult       $s1, $v0
    /* C848 8001C048 12900000 */  mflo       $s2
    /* C84C 8001C04C 02004106 */  bgez       $s2, .L8001C058
    /* C850 8001C050 23986500 */   subu      $s3, $v1, $a1
    /* C854 8001C054 7F005226 */  addiu      $s2, $s2, 0x7F
  .L8001C058:
    /* C858 8001C058 2A106602 */  slt        $v0, $s3, $a2
    /* C85C 8001C05C 02004010 */  beqz       $v0, .L8001C068
    /* C860 8001C060 C3891200 */   sra       $s1, $s2, 7
    /* C864 8001C064 2198C000 */  addu       $s3, $a2, $zero
  .L8001C068:
    /* C868 8001C068 1C00201A */  blez       $s1, .L8001C0DC
    /* C86C 8001C06C 00000000 */   nop
    /* C870 8001C070 A4E4020C */  jal        TextSys_WordX__Fi
    /* C874 8001C074 DE010424 */   addiu     $a0, $zero, 0x1DE
    /* C878 8001C078 5555033C */  lui        $v1, (0x55555556 >> 16)
    /* C87C 8001C07C 56556334 */  ori        $v1, $v1, (0x55555556 & 0xFFFF)
    /* C880 8001C080 40381100 */  sll        $a3, $s1, 1
    /* C884 8001C084 1800E300 */  mult       $a3, $v1
    /* C888 8001C088 21804000 */  addu       $s0, $v0, $zero
    /* C88C 8001C08C 21200002 */  addu       $a0, $s0, $zero
    /* C890 8001C090 05008526 */  addiu      $a1, $s4, 0x5
    /* C894 8001C094 C2371200 */  srl        $a2, $s2, 31
    /* C898 8001C098 21302602 */  addu       $a2, $s1, $a2
    /* C89C 8001C09C 43300600 */  sra        $a2, $a2, 1
    /* C8A0 8001C0A0 17000224 */  addiu      $v0, $zero, 0x17
    /* C8A4 8001C0A4 C33F0700 */  sra        $a3, $a3, 31
    /* C8A8 8001C0A8 1000A2AF */  sw         $v0, 0x10($sp)
    /* C8AC 8001C0AC 10400000 */  mfhi       $t0
    /* C8B0 8001C0B0 DC37030C */  jal        Flare_2DHalo__Fiiiii
    /* C8B4 8001C0B4 23380701 */   subu      $a3, $t0, $a3
    /* C8B8 8001C0B8 21200000 */  addu       $a0, $zero, $zero
    /* C8BC 8001C0BC 21288000 */  addu       $a1, $a0, $zero
    /* C8C0 8001C0C0 FDFF0626 */  addiu      $a2, $s0, -0x3
    /* C8C4 8001C0C4 FFFF8726 */  addiu      $a3, $s4, -0x1
    /* C8C8 8001C0C8 2B109300 */  sltu       $v0, $a0, $s3
    /* C8CC 8001C0CC 1000B3AF */  sw         $s3, 0x10($sp)
    /* C8D0 8001C0D0 1400A2AF */  sw         $v0, 0x14($sp)
    /* C8D4 8001C0D4 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* C8D8 8001C0D8 1800A0AF */   sw        $zero, 0x18($sp)
  .L8001C0DC:
    /* C8DC 8001C0DC 3400BF8F */  lw         $ra, 0x34($sp)
    /* C8E0 8001C0E0 3000B48F */  lw         $s4, 0x30($sp)
    /* C8E4 8001C0E4 2C00B38F */  lw         $s3, 0x2C($sp)
    /* C8E8 8001C0E8 2800B28F */  lw         $s2, 0x28($sp)
    /* C8EC 8001C0EC 2400B18F */  lw         $s1, 0x24($sp)
    /* C8F0 8001C0F0 2000B08F */  lw         $s0, 0x20($sp)
    /* C8F4 8001C0F4 0800E003 */  jr         $ra
    /* C8F8 8001C0F8 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel DrawLeftFlare__FiiiRi
