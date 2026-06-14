.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching bigcount, 0x74

glabel bigcount
    /* D6A58 800E6258 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D6A5C 800E625C 1400B1AF */  sw         $s1, 0x14($sp)
    /* D6A60 800E6260 21888000 */  addu       $s1, $a0, $zero
    /* D6A64 800E6264 1000B0AF */  sw         $s0, 0x10($sp)
    /* D6A68 800E6268 1800BFAF */  sw         $ra, 0x18($sp)
    /* D6A6C 800E626C C797030C */  jal        typeofbigfile
    /* D6A70 800E6270 21800000 */   addu      $s0, $zero, $zero
    /* D6A74 800E6274 21184000 */  addu       $v1, $v0, $zero
    /* D6A78 800E6278 01000224 */  addiu      $v0, $zero, 0x1
    /* D6A7C 800E627C 05006210 */  beq        $v1, $v0, .L800E6294
    /* D6A80 800E6280 02000224 */   addiu     $v0, $zero, 0x2
    /* D6A84 800E6284 06006210 */  beq        $v1, $v0, .L800E62A0
    /* D6A88 800E6288 21100002 */   addu      $v0, $s0, $zero
    /* D6A8C 800E628C AE980308 */  j          .L800E62B8
    /* D6A90 800E6290 00000000 */   nop
  .L800E6294:
    /* D6A94 800E6294 04002426 */  addiu      $a0, $s1, 0x4
    /* D6A98 800E6298 AA980308 */  j          .L800E62A8
    /* D6A9C 800E629C 02000524 */   addiu     $a1, $zero, 0x2
  .L800E62A0:
    /* D6AA0 800E62A0 08002426 */  addiu      $a0, $s1, 0x8
    /* D6AA4 800E62A4 04000524 */  addiu      $a1, $zero, 0x4
  .L800E62A8:
    /* D6AA8 800E62A8 09CC030C */  jal        getm
    /* D6AAC 800E62AC 00000000 */   nop
    /* D6AB0 800E62B0 21804000 */  addu       $s0, $v0, $zero
    /* D6AB4 800E62B4 21100002 */  addu       $v0, $s0, $zero
  .L800E62B8:
    /* D6AB8 800E62B8 1800BF8F */  lw         $ra, 0x18($sp)
    /* D6ABC 800E62BC 1400B18F */  lw         $s1, 0x14($sp)
    /* D6AC0 800E62C0 1000B08F */  lw         $s0, 0x10($sp)
    /* D6AC4 800E62C4 0800E003 */  jr         $ra
    /* D6AC8 800E62C8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel bigcount
