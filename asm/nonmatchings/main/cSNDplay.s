.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching cSNDplay, 0xAC

glabel cSNDplay
    /* D8268 800E7A68 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D826C 800E7A6C 1000B0AF */  sw         $s0, 0x10($sp)
    /* D8270 800E7A70 21808000 */  addu       $s0, $a0, $zero
    /* D8274 800E7A74 1400BFAF */  sw         $ra, 0x14($sp)
    /* D8278 800E7A78 04000482 */  lb         $a0, 0x4($s0)
    /* D827C 800E7A7C AFF9030C */  jal        iSNDvalidbank
    /* D8280 800E7A80 00000000 */   nop
    /* D8284 800E7A84 11004004 */  bltz       $v0, .L800E7ACC
    /* D8288 800E7A88 1480043C */   lui       $a0, %hi(D_801478F8)
    /* D828C 800E7A8C 04000382 */  lb         $v1, 0x4($s0)
    /* D8290 800E7A90 00000000 */  nop
    /* D8294 800E7A94 40100300 */  sll        $v0, $v1, 1
    /* D8298 800E7A98 21104300 */  addu       $v0, $v0, $v1
    /* D829C 800E7A9C 80100200 */  sll        $v0, $v0, 2
    /* D82A0 800E7AA0 F878838C */  lw         $v1, %lo(D_801478F8)($a0)
    /* D82A4 800E7AA4 0000048E */  lw         $a0, 0x0($s0)
    /* D82A8 800E7AA8 21104300 */  addu       $v0, $v0, $v1
    /* D82AC 800E7AAC 0000458C */  lw         $a1, 0x0($v0)
    /* D82B0 800E7AB0 14008004 */  bltz       $a0, .L800E7B04
    /* D82B4 800E7AB4 F8FF0224 */   addiu     $v0, $zero, -0x8
    /* D82B8 800E7AB8 0600A294 */  lhu        $v0, 0x6($a1)
    /* D82BC 800E7ABC 00000000 */  nop
    /* D82C0 800E7AC0 2A108200 */  slt        $v0, $a0, $v0
    /* D82C4 800E7AC4 03004014 */  bnez       $v0, .L800E7AD4
    /* D82C8 800E7AC8 04000224 */   addiu     $v0, $zero, 0x4
  .L800E7ACC:
    /* D82CC 800E7ACC C19E0308 */  j          .L800E7B04
    /* D82D0 800E7AD0 F8FF0224 */   addiu     $v0, $zero, -0x8
  .L800E7AD4:
    /* D82D4 800E7AD4 0400A390 */  lbu        $v1, 0x4($a1)
    /* D82D8 800E7AD8 00000000 */  nop
    /* D82DC 800E7ADC 05006214 */  bne        $v1, $v0, .L800E7AF4
    /* D82E0 800E7AE0 80100400 */   sll       $v0, $a0, 2
    /* D82E4 800E7AE4 2110A200 */  addu       $v0, $a1, $v0
    /* D82E8 800E7AE8 1400448C */  lw         $a0, 0x14($v0)
    /* D82EC 800E7AEC BF9E0308 */  j          .L800E7AFC
    /* D82F0 800E7AF0 00000000 */   nop
  .L800E7AF4:
    /* D82F4 800E7AF4 2110A200 */  addu       $v0, $a1, $v0
    /* D82F8 800E7AF8 0C00448C */  lw         $a0, 0xC($v0)
  .L800E7AFC:
    /* D82FC 800E7AFC 6308040C */  jal        iSNDplaytaggedpatch
    /* D8300 800E7B00 21280002 */   addu      $a1, $s0, $zero
  .L800E7B04:
    /* D8304 800E7B04 1400BF8F */  lw         $ra, 0x14($sp)
    /* D8308 800E7B08 1000B08F */  lw         $s0, 0x10($sp)
    /* D830C 800E7B0C 0800E003 */  jr         $ra
    /* D8310 800E7B10 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel cSNDplay
