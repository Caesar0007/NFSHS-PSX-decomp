.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching bsearch, 0xC0

glabel bsearch
    /* F99DC 801091DC C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* F99E0 801091E0 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* F99E4 801091E4 4800B78F */  lw         $s7, 0x48($sp)
    /* F99E8 801091E8 2400B5AF */  sw         $s5, 0x24($sp)
    /* F99EC 801091EC 21A88000 */  addu       $s5, $a0, $zero
    /* F99F0 801091F0 2800B6AF */  sw         $s6, 0x28($sp)
    /* F99F4 801091F4 21B0A000 */  addu       $s6, $a1, $zero
    /* F99F8 801091F8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* F99FC 801091FC 2198C000 */  addu       $s3, $a2, $zero
    /* F9A00 80109200 1800B2AF */  sw         $s2, 0x18($sp)
    /* F9A04 80109204 21900000 */  addu       $s2, $zero, $zero
    /* F9A08 80109208 2000B4AF */  sw         $s4, 0x20($sp)
    /* F9A0C 8010920C 21A0E000 */  addu       $s4, $a3, $zero
    /* F9A10 80109210 3000BFAF */  sw         $ra, 0x30($sp)
    /* F9A14 80109214 1400B1AF */  sw         $s1, 0x14($sp)
    /* F9A18 80109218 14006012 */  beqz       $s3, .L8010926C
    /* F9A1C 8010921C 1000B0AF */   sw        $s0, 0x10($sp)
    /* F9A20 80109220 21105302 */  addu       $v0, $s2, $s3
  .L80109224:
    /* F9A24 80109224 42800200 */  srl        $s0, $v0, 1
    /* F9A28 80109228 18009002 */  mult       $s4, $s0
    /* F9A2C 8010922C 2128A002 */  addu       $a1, $s5, $zero
    /* F9A30 80109230 12180000 */  mflo       $v1
    /* F9A34 80109234 2188C302 */  addu       $s1, $s6, $v1
    /* F9A38 80109238 09F8E002 */  jalr       $s7
    /* F9A3C 8010923C 21202002 */   addu      $a0, $s1, $zero
    /* F9A40 80109240 03004104 */  bgez       $v0, .L80109250
    /* F9A44 80109244 00000000 */   nop
    /* F9A48 80109248 98240408 */  j          .L80109260
    /* F9A4C 8010924C 01001226 */   addiu     $s2, $s0, 0x1
  .L80109250:
    /* F9A50 80109250 0300401C */  bgtz       $v0, .L80109260
    /* F9A54 80109254 21980002 */   addu      $s3, $s0, $zero
    /* F9A58 80109258 9C240408 */  j          .L80109270
    /* F9A5C 8010925C 21102002 */   addu      $v0, $s1, $zero
  .L80109260:
    /* F9A60 80109260 2B105302 */  sltu       $v0, $s2, $s3
    /* F9A64 80109264 EFFF4014 */  bnez       $v0, .L80109224
    /* F9A68 80109268 21105302 */   addu      $v0, $s2, $s3
  .L8010926C:
    /* F9A6C 8010926C 21100000 */  addu       $v0, $zero, $zero
  .L80109270:
    /* F9A70 80109270 3000BF8F */  lw         $ra, 0x30($sp)
    /* F9A74 80109274 2C00B78F */  lw         $s7, 0x2C($sp)
    /* F9A78 80109278 2800B68F */  lw         $s6, 0x28($sp)
    /* F9A7C 8010927C 2400B58F */  lw         $s5, 0x24($sp)
    /* F9A80 80109280 2000B48F */  lw         $s4, 0x20($sp)
    /* F9A84 80109284 1C00B38F */  lw         $s3, 0x1C($sp)
    /* F9A88 80109288 1800B28F */  lw         $s2, 0x18($sp)
    /* F9A8C 8010928C 1400B18F */  lw         $s1, 0x14($sp)
    /* F9A90 80109290 1000B08F */  lw         $s0, 0x10($sp)
    /* F9A94 80109294 0800E003 */  jr         $ra
    /* F9A98 80109298 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel bsearch
