.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching loadbigfileheaderatomic, 0x144

glabel loadbigfileheaderatomic
    /* D6138 800E5938 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* D613C 800E593C 3000B4AF */  sw         $s4, 0x30($sp)
    /* D6140 800E5940 21A08000 */  addu       $s4, $a0, $zero
    /* D6144 800E5944 2000B0AF */  sw         $s0, 0x20($sp)
    /* D6148 800E5948 2180A000 */  addu       $s0, $a1, $zero
    /* D614C 800E594C 01000524 */  addiu      $a1, $zero, 0x1
    /* D6150 800E5950 21308002 */  addu       $a2, $s4, $zero
    /* D6154 800E5954 3400BFAF */  sw         $ra, 0x34($sp)
    /* D6158 800E5958 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* D615C 800E595C 2800B2AF */  sw         $s2, 0x28($sp)
    /* D6160 800E5960 2400B1AF */  sw         $s1, 0x24($sp)
    /* D6164 800E5964 0000048E */  lw         $a0, 0x0($s0)
    /* D6168 800E5968 2AAA030C */  jal        FILE_opensync
    /* D616C 800E596C 1800A727 */   addiu     $a3, $sp, 0x18
    /* D6170 800E5970 3A004010 */  beqz       $v0, .L800E5A5C
    /* D6174 800E5974 21100000 */   addu      $v0, $zero, $zero
    /* D6178 800E5978 0000048E */  lw         $a0, 0x0($s0)
    /* D617C 800E597C 0800068E */  lw         $a2, 0x8($s0)
    /* D6180 800E5980 CF94030C */  jal        reservememadr
    /* D6184 800E5984 900A0524 */   addiu     $a1, $zero, 0xA90
    /* D6188 800E5988 21884000 */  addu       $s1, $v0, $zero
    /* D618C 800E598C 2E002012 */  beqz       $s1, .L800E5A48
    /* D6190 800E5990 21280000 */   addu      $a1, $zero, $zero
    /* D6194 800E5994 21302002 */  addu       $a2, $s1, $zero
    /* D6198 800E5998 900A0724 */  addiu      $a3, $zero, 0xA90
    /* D619C 800E599C 1800A48F */  lw         $a0, 0x18($sp)
    /* D61A0 800E59A0 FFFF9326 */  addiu      $s3, $s4, -0x1
    /* D61A4 800E59A4 48AA030C */  jal        FILE_readsync
    /* D61A8 800E59A8 1000B3AF */   sw        $s3, 0x10($sp)
    /* D61AC 800E59AC C797030C */  jal        typeofbigfile
    /* D61B0 800E59B0 21202002 */   addu      $a0, $s1, $zero
    /* D61B4 800E59B4 06004014 */  bnez       $v0, .L800E59D0
    /* D61B8 800E59B8 00000000 */   nop
  .L800E59BC:
    /* D61BC 800E59BC 5095030C */  jal        purgememadr
    /* D61C0 800E59C0 21202002 */   addu      $a0, $s1, $zero
    /* D61C4 800E59C4 1800A48F */  lw         $a0, 0x18($sp)
    /* D61C8 800E59C8 94960308 */  j          .L800E5A50
    /* D61CC 800E59CC 21286002 */   addu      $a1, $s3, $zero
  .L800E59D0:
    /* D61D0 800E59D0 E197030C */  jal        sizeofbigfileheader
    /* D61D4 800E59D4 21202002 */   addu      $a0, $s1, $zero
    /* D61D8 800E59D8 21904000 */  addu       $s2, $v0, $zero
    /* D61DC 800E59DC 910A422E */  sltiu      $v0, $s2, 0xA91
    /* D61E0 800E59E0 14004014 */  bnez       $v0, .L800E5A34
    /* D61E4 800E59E4 00000000 */   nop
    /* D61E8 800E59E8 0000048E */  lw         $a0, 0x0($s0)
    /* D61EC 800E59EC 0800068E */  lw         $a2, 0x8($s0)
    /* D61F0 800E59F0 CF94030C */  jal        reservememadr
    /* D61F4 800E59F4 21284002 */   addu      $a1, $s2, $zero
    /* D61F8 800E59F8 21804000 */  addu       $s0, $v0, $zero
    /* D61FC 800E59FC EFFF0012 */  beqz       $s0, .L800E59BC
    /* D6200 800E5A00 21202002 */   addu      $a0, $s1, $zero
    /* D6204 800E5A04 21280002 */  addu       $a1, $s0, $zero
    /* D6208 800E5A08 B798030C */  jal        blockmove
    /* D620C 800E5A0C 900A0624 */   addiu     $a2, $zero, 0xA90
    /* D6210 800E5A10 5095030C */  jal        purgememadr
    /* D6214 800E5A14 21202002 */   addu      $a0, $s1, $zero
    /* D6218 800E5A18 21880002 */  addu       $s1, $s0, $zero
    /* D621C 800E5A1C 900A0524 */  addiu      $a1, $zero, 0xA90
    /* D6220 800E5A20 21302502 */  addu       $a2, $s1, $a1
    /* D6224 800E5A24 1800A48F */  lw         $a0, 0x18($sp)
    /* D6228 800E5A28 70F54726 */  addiu      $a3, $s2, -0xA90
    /* D622C 800E5A2C 48AA030C */  jal        FILE_readsync
    /* D6230 800E5A30 1000B3AF */   sw        $s3, 0x10($sp)
  .L800E5A34:
    /* D6234 800E5A34 1800A48F */  lw         $a0, 0x18($sp)
    /* D6238 800E5A38 54AA030C */  jal        FILE_closesync
    /* D623C 800E5A3C FFFF8526 */   addiu     $a1, $s4, -0x1
    /* D6240 800E5A40 97960308 */  j          .L800E5A5C
    /* D6244 800E5A44 21102002 */   addu      $v0, $s1, $zero
  .L800E5A48:
    /* D6248 800E5A48 1800A48F */  lw         $a0, 0x18($sp)
    /* D624C 800E5A4C FFFF8526 */  addiu      $a1, $s4, -0x1
  .L800E5A50:
    /* D6250 800E5A50 54AA030C */  jal        FILE_closesync
    /* D6254 800E5A54 00000000 */   nop
    /* D6258 800E5A58 21100000 */  addu       $v0, $zero, $zero
  .L800E5A5C:
    /* D625C 800E5A5C 3400BF8F */  lw         $ra, 0x34($sp)
    /* D6260 800E5A60 3000B48F */  lw         $s4, 0x30($sp)
    /* D6264 800E5A64 2C00B38F */  lw         $s3, 0x2C($sp)
    /* D6268 800E5A68 2800B28F */  lw         $s2, 0x28($sp)
    /* D626C 800E5A6C 2400B18F */  lw         $s1, 0x24($sp)
    /* D6270 800E5A70 2000B08F */  lw         $s0, 0x20($sp)
    /* D6274 800E5A74 0800E003 */  jr         $ra
    /* D6278 800E5A78 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel loadbigfileheaderatomic
