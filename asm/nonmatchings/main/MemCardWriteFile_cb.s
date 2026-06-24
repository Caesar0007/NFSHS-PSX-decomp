.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MemCardWriteFile_cb, 0x108

glabel MemCardWriteFile_cb
    /* EBF80 800FB780 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* EBF84 800FB784 1400B1AF */  sw         $s1, 0x14($sp)
    /* EBF88 800FB788 21888000 */  addu       $s1, $a0, $zero
    /* EBF8C 800FB78C 1800BFAF */  sw         $ra, 0x18($sp)
    /* EBF90 800FB790 1000B0AF */  sw         $s0, 0x10($sp)
    /* EBF94 800FB794 0000238E */  lw         $v1, 0x0($s1)
    /* EBF98 800FB798 0A001024 */  addiu      $s0, $zero, 0xA
    /* EBF9C 800FB79C 14007010 */  beq        $v1, $s0, .L800FB7F0
    /* EBFA0 800FB7A0 0B006228 */   slti      $v0, $v1, 0xB
    /* EBFA4 800FB7A4 05004010 */  beqz       $v0, .L800FB7BC
    /* EBFA8 800FB7A8 0B000224 */   addiu     $v0, $zero, 0xB
    /* EBFAC 800FB7AC 09006010 */  beqz       $v1, .L800FB7D4
    /* EBFB0 800FB7B0 21100000 */   addu      $v0, $zero, $zero
    /* EBFB4 800FB7B4 1DEE0308 */  j          .L800FB874
    /* EBFB8 800FB7B8 00000000 */   nop
  .L800FB7BC:
    /* EBFBC 800FB7BC 1C006210 */  beq        $v1, $v0, .L800FB830
    /* EBFC0 800FB7C0 14000224 */   addiu     $v0, $zero, 0x14
    /* EBFC4 800FB7C4 21006210 */  beq        $v1, $v0, .L800FB84C
    /* EBFC8 800FB7C8 21100000 */   addu      $v0, $zero, $zero
    /* EBFCC 800FB7CC 1DEE0308 */  j          .L800FB874
    /* EBFD0 800FB7D0 00000000 */   nop
  .L800FB7D4:
    /* EBFD4 800FB7D4 1080043C */  lui        $a0, %hi(MemCardExist_cb)
    /* EBFD8 800FB7D8 F0AB8424 */  addiu      $a0, $a0, %lo(MemCardExist_cb)
    /* EBFDC 800FB7DC 1380013C */  lui        $at, %hi(D_80136CC4)
    /* EBFE0 800FB7E0 0427040C */  jal        UserFuncOpen
    /* EBFE4 800FB7E4 C46C20AC */   sw        $zero, %lo(D_80136CC4)($at)
    /* EBFE8 800FB7E8 1CEE0308 */  j          .L800FB870
    /* EBFEC 800FB7EC 000030AE */   sw        $s0, 0x0($s1)
  .L800FB7F0:
    /* EBFF0 800FB7F0 1480103C */  lui        $s0, %hi(D_8014751C)
    /* EBFF4 800FB7F4 1C751026 */  addiu      $s0, $s0, %lo(D_8014751C)
    /* EBFF8 800FB7F8 0000028E */  lw         $v0, 0x0($s0)
    /* EBFFC 800FB7FC 00000000 */  nop
    /* EC000 800FB800 1C004014 */  bnez       $v0, .L800FB874
    /* EC004 800FB804 01000224 */   addiu     $v0, $zero, 0x1
    /* EC008 800FB808 1C000426 */  addiu      $a0, $s0, 0x1C
    /* EC00C 800FB80C 5C27040C */  jal        open
    /* EC010 800FB810 01800534 */   ori       $a1, $zero, 0x8001
    /* EC014 800FB814 06004104 */  bgez       $v0, .L800FB830
    /* EC018 800FB818 0C0002AE */   sw        $v0, 0xC($s0)
    /* EC01C 800FB81C FCFF0326 */  addiu      $v1, $s0, -0x4
    /* EC020 800FB820 05000224 */  addiu      $v0, $zero, 0x5
    /* EC024 800FB824 040062AC */  sw         $v0, 0x4($v1)
    /* EC028 800FB828 1DEE0308 */  j          .L800FB874
    /* EC02C 800FB82C 01000224 */   addiu     $v0, $zero, 0x1
  .L800FB830:
    /* EC030 800FB830 14000224 */  addiu      $v0, $zero, 0x14
    /* EC034 800FB834 1080043C */  lui        $a0, %hi(MemCardWriteData_cb)
    /* EC038 800FB838 0CB38424 */  addiu      $a0, $a0, %lo(MemCardWriteData_cb)
    /* EC03C 800FB83C 0427040C */  jal        UserFuncOpen
    /* EC040 800FB840 000022AE */   sw        $v0, 0x0($s1)
    /* EC044 800FB844 1DEE0308 */  j          .L800FB874
    /* EC048 800FB848 21100000 */   addu      $v0, $zero, $zero
  .L800FB84C:
    /* EC04C 800FB84C 1480103C */  lui        $s0, %hi(D_80147528)
    /* EC050 800FB850 28751026 */  addiu      $s0, $s0, %lo(D_80147528)
    /* EC054 800FB854 0000048E */  lw         $a0, 0x0($s0)
    /* EC058 800FB858 6027040C */  jal        close
    /* EC05C 800FB85C 00000000 */   nop
    /* EC060 800FB860 01000224 */  addiu      $v0, $zero, 0x1
    /* EC064 800FB864 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* EC068 800FB868 1DEE0308 */  j          .L800FB874
    /* EC06C 800FB86C 000003AE */   sw        $v1, 0x0($s0)
  .L800FB870:
    /* EC070 800FB870 21100000 */  addu       $v0, $zero, $zero
  .L800FB874:
    /* EC074 800FB874 1800BF8F */  lw         $ra, 0x18($sp)
    /* EC078 800FB878 1400B18F */  lw         $s1, 0x14($sp)
    /* EC07C 800FB87C 1000B08F */  lw         $s0, 0x10($sp)
    /* EC080 800FB880 0800E003 */  jr         $ra
    /* EC084 800FB884 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel MemCardWriteFile_cb
