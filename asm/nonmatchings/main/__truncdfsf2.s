.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __truncdfsf2, 0x130

glabel __truncdfsf2
    /* E6124 800F5924 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* E6128 800F5928 FF7F023C */  lui        $v0, (0x7FFFFFFF >> 16)
    /* E612C 800F592C FFFF4234 */  ori        $v0, $v0, (0x7FFFFFFF & 0xFFFF)
    /* E6130 800F5930 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* E6134 800F5934 2800B0AF */  sw         $s0, 0x28($sp)
    /* E6138 800F5938 21808000 */  addu       $s0, $a0, $zero
    /* E613C 800F593C 2188A000 */  addu       $s1, $a1, $zero
    /* E6140 800F5940 24102202 */  and        $v0, $s1, $v0
    /* E6144 800F5944 3800BFAF */  sw         $ra, 0x38($sp)
    /* E6148 800F5948 3400B3AF */  sw         $s3, 0x34($sp)
    /* E614C 800F594C 05004014 */  bnez       $v0, .L800F5964
    /* E6150 800F5950 3000B2AF */   sw        $s2, 0x30($sp)
    /* E6154 800F5954 03000016 */  bnez       $s0, .L800F5964
    /* E6158 800F5958 0080023C */   lui       $v0, (0x80000000 >> 16)
    /* E615C 800F595C 8ED60308 */  j          .L800F5A38
    /* E6160 800F5960 24102202 */   and       $v0, $s1, $v0
  .L800F5964:
    /* E6164 800F5964 03151100 */  sra        $v0, $s1, 20
    /* E6168 800F5968 FF075330 */  andi       $s3, $v0, 0x7FF
    /* E616C 800F596C 80FC7226 */  addiu      $s2, $s3, -0x380
    /* E6170 800F5970 0F00023C */  lui        $v0, (0xFFFFF >> 16)
    /* E6174 800F5974 FFFF4234 */  ori        $v0, $v0, (0xFFFFF & 0xFFFF)
    /* E6178 800F5978 2000A427 */  addiu      $a0, $sp, 0x20
    /* E617C 800F597C 24102202 */  and        $v0, $s1, $v0
    /* E6180 800F5980 1000033C */  lui        $v1, (0x100000 >> 16)
    /* E6184 800F5984 25104300 */  or         $v0, $v0, $v1
    /* E6188 800F5988 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* E618C 800F598C 04000224 */  addiu      $v0, $zero, 0x4
    /* E6190 800F5990 1800B0AF */  sw         $s0, 0x18($sp)
    /* E6194 800F5994 1000A2AF */  sw         $v0, 0x10($sp)
    /* E6198 800F5998 1800A68F */  lw         $a2, 0x18($sp)
    /* E619C 800F599C 1C00A78F */  lw         $a3, 0x1C($sp)
    /* E61A0 800F59A0 901B040C */  jal        _dbl_shift
    /* E61A4 800F59A4 21280000 */   addu      $a1, $zero, $zero
    /* E61A8 800F59A8 2400A58F */  lw         $a1, 0x24($sp)
    /* E61AC 800F59AC 0900401A */  blez       $s2, .L800F59D4
    /* E61B0 800F59B0 00FF023C */   lui       $v0, (0xFF000000 >> 16)
    /* E61B4 800F59B4 0100A524 */  addiu      $a1, $a1, 0x1
    /* E61B8 800F59B8 42280500 */  srl        $a1, $a1, 1
    /* E61BC 800F59BC 2410A200 */  and        $v0, $a1, $v0
    /* E61C0 800F59C0 0D004010 */  beqz       $v0, .L800F59F8
    /* E61C4 800F59C4 7FFF023C */   lui       $v0, (0xFF7FFFFF >> 16)
    /* E61C8 800F59C8 42280500 */  srl        $a1, $a1, 1
    /* E61CC 800F59CC 7ED60308 */  j          .L800F59F8
    /* E61D0 800F59D0 81FC7226 */   addiu     $s2, $s3, -0x37F
  .L800F59D4:
    /* E61D4 800F59D4 23101200 */  negu       $v0, $s2
    /* E61D8 800F59D8 01004424 */  addiu      $a0, $v0, 0x1
    /* E61DC 800F59DC 01000324 */  addiu      $v1, $zero, 0x1
    /* E61E0 800F59E0 04188300 */  sllv       $v1, $v1, $a0
    /* E61E4 800F59E4 2128A300 */  addu       $a1, $a1, $v1
    /* E61E8 800F59E8 02004224 */  addiu      $v0, $v0, 0x2
    /* E61EC 800F59EC 06284500 */  srlv       $a1, $a1, $v0
    /* E61F0 800F59F0 21900000 */  addu       $s2, $zero, $zero
    /* E61F4 800F59F4 7FFF023C */  lui        $v0, (0xFF7FFFFF >> 16)
  .L800F59F8:
    /* E61F8 800F59F8 FFFF4234 */  ori        $v0, $v0, (0xFF7FFFFF & 0xFFFF)
    /* E61FC 800F59FC 2428A200 */  and        $a1, $a1, $v0
    /* E6200 800F5A00 FF00422A */  slti       $v0, $s2, 0xFF
    /* E6204 800F5A04 08004014 */  bnez       $v0, .L800F5A28
    /* E6208 800F5A08 0080023C */   lui       $v0, (0x80000000 >> 16)
    /* E620C 800F5A0C 22000424 */  addiu      $a0, $zero, 0x22
    /* E6210 800F5A10 951A040C */  jal        _err_math
    /* E6214 800F5A14 10000524 */   addiu     $a1, $zero, 0x10
    /* E6218 800F5A18 07002106 */  bgez       $s1, .L800F5A38
    /* E621C 800F5A1C 807F023C */   lui       $v0, (0x7F800000 >> 16)
    /* E6220 800F5A20 8ED60308 */  j          .L800F5A38
    /* E6224 800F5A24 80FF023C */   lui       $v0, (0xFF800000 >> 16)
  .L800F5A28:
    /* E6228 800F5A28 24102202 */  and        $v0, $s1, $v0
    /* E622C 800F5A2C C01D1200 */  sll        $v1, $s2, 23
    /* E6230 800F5A30 25104300 */  or         $v0, $v0, $v1
    /* E6234 800F5A34 25104500 */  or         $v0, $v0, $a1
  .L800F5A38:
    /* E6238 800F5A38 3800BF8F */  lw         $ra, 0x38($sp)
    /* E623C 800F5A3C 3400B38F */  lw         $s3, 0x34($sp)
    /* E6240 800F5A40 3000B28F */  lw         $s2, 0x30($sp)
    /* E6244 800F5A44 2C00B18F */  lw         $s1, 0x2C($sp)
    /* E6248 800F5A48 2800B08F */  lw         $s0, 0x28($sp)
    /* E624C 800F5A4C 0800E003 */  jr         $ra
    /* E6250 800F5A50 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel __truncdfsf2
