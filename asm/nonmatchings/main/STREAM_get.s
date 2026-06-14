.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching STREAM_get, 0x124

glabel STREAM_get
    /* EE1AC 800FD9AC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* EE1B0 800FD9B0 1800BFAF */  sw         $ra, 0x18($sp)
    /* EE1B4 800FD9B4 1000A527 */  addiu      $a1, $sp, 0x10
    /* EE1B8 800FD9B8 BEF0030C */  jal        func_800FC2F8
    /* EE1BC 800FD9BC 1400A627 */   addiu     $a2, $sp, 0x14
    /* EE1C0 800FD9C0 3F004014 */  bnez       $v0, .L800FDAC0
    /* EE1C4 800FD9C4 21100000 */   addu      $v0, $zero, $zero
    /* EE1C8 800FD9C8 1400A58F */  lw         $a1, 0x14($sp)
    /* EE1CC 800FD9CC 00000000 */  nop
    /* EE1D0 800FD9D0 0800A28C */  lw         $v0, 0x8($a1)
    /* EE1D4 800FD9D4 00000000 */  nop
    /* EE1D8 800FD9D8 03004014 */  bnez       $v0, .L800FD9E8
    /* EE1DC 800FD9DC FF00033C */   lui       $v1, (0xFFFFFF >> 16)
    /* EE1E0 800FD9E0 B0F60308 */  j          .L800FDAC0
    /* EE1E4 800FD9E4 21100000 */   addu      $v0, $zero, $zero
  .L800FD9E8:
    /* EE1E8 800FD9E8 0C00A78C */  lw         $a3, 0xC($a1)
    /* EE1EC 800FD9EC 00000000 */  nop
    /* EE1F0 800FD9F0 0400E28C */  lw         $v0, 0x4($a3)
    /* EE1F4 800FD9F4 FFFF6334 */  ori        $v1, $v1, (0xFFFFFF & 0xFFFF)
    /* EE1F8 800FD9F8 24204300 */  and        $a0, $v0, $v1
    /* EE1FC 800FD9FC 0400E4AC */  sw         $a0, 0x4($a3)
    /* EE200 800FDA00 00600340 */  mfc0       $v1, $12 /* handwritten instruction */
    /* EE204 800FDA04 00000000 */  nop
    /* EE208 800FDA08 FEFB0124 */  addiu      $at, $zero, -0x402
    /* EE20C 800FDA0C 24406100 */  and        $t0, $v1, $at
    /* EE210 800FDA10 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* EE214 800FDA14 00000000 */  nop
    /* EE218 800FDA18 00000000 */  nop
    /* EE21C 800FDA1C 00000000 */  nop
    /* EE220 800FDA20 0800A28C */  lw         $v0, 0x8($a1)
    /* EE224 800FDA24 00000000 */  nop
    /* EE228 800FDA28 23104400 */  subu       $v0, $v0, $a0
    /* EE22C 800FDA2C 0800A2AC */  sw         $v0, 0x8($a1)
    /* EE230 800FDA30 00608340 */  mtc0       $v1, $12 /* handwritten instruction */
    /* EE234 800FDA34 22004018 */  blez       $v0, .L800FDAC0
    /* EE238 800FDA38 2110E000 */   addu      $v0, $a3, $zero
    /* EE23C 800FDA3C 0400A28C */  lw         $v0, 0x4($a1)
    /* EE240 800FDA40 2128E400 */  addu       $a1, $a3, $a0
    /* EE244 800FDA44 00360200 */  sll        $a2, $v0, 24
    /* EE248 800FDA48 0400A28C */  lw         $v0, 0x4($a1)
    /* EE24C 800FDA4C 00FF033C */  lui        $v1, (0xFF000000 >> 16)
    /* EE250 800FDA50 24104300 */  and        $v0, $v0, $v1
    /* EE254 800FDA54 16004610 */  beq        $v0, $a2, .L800FDAB0
    /* EE258 800FDA58 00000000 */   nop
    /* EE25C 800FDA5C FFFF0A24 */  addiu      $t2, $zero, -0x1
    /* EE260 800FDA60 1000A88F */  lw         $t0, 0x10($sp)
    /* EE264 800FDA64 FF00033C */  lui        $v1, (0xFFFFFF >> 16)
    /* EE268 800FDA68 FFFF6334 */  ori        $v1, $v1, (0xFFFFFF & 0xFFFF)
    /* EE26C 800FDA6C 00FF093C */  lui        $t1, (0xFF000000 >> 16)
  .L800FDA70:
    /* EE270 800FDA70 0000A28C */  lw         $v0, 0x0($a1)
    /* EE274 800FDA74 00000000 */  nop
    /* EE278 800FDA78 04004A14 */  bne        $v0, $t2, .L800FDA8C
    /* EE27C 800FDA7C 00000000 */   nop
    /* EE280 800FDA80 2000058D */  lw         $a1, 0x20($t0)
    /* EE284 800FDA84 A7F60308 */  j          .L800FDA9C
    /* EE288 800FDA88 00000000 */   nop
  .L800FDA8C:
    /* EE28C 800FDA8C 0400A28C */  lw         $v0, 0x4($a1)
    /* EE290 800FDA90 00000000 */  nop
    /* EE294 800FDA94 24204300 */  and        $a0, $v0, $v1
    /* EE298 800FDA98 2128A400 */  addu       $a1, $a1, $a0
  .L800FDA9C:
    /* EE29C 800FDA9C 0400A28C */  lw         $v0, 0x4($a1)
    /* EE2A0 800FDAA0 00000000 */  nop
    /* EE2A4 800FDAA4 24104900 */  and        $v0, $v0, $t1
    /* EE2A8 800FDAA8 F1FF4614 */  bne        $v0, $a2, .L800FDA70
    /* EE2AC 800FDAAC 00000000 */   nop
  .L800FDAB0:
    /* EE2B0 800FDAB0 1400A28F */  lw         $v0, 0x14($sp)
    /* EE2B4 800FDAB4 00000000 */  nop
    /* EE2B8 800FDAB8 0C0045AC */  sw         $a1, 0xC($v0)
    /* EE2BC 800FDABC 2110E000 */  addu       $v0, $a3, $zero
  .L800FDAC0:
    /* EE2C0 800FDAC0 1800BF8F */  lw         $ra, 0x18($sp)
    /* EE2C4 800FDAC4 00000000 */  nop
    /* EE2C8 800FDAC8 0800E003 */  jr         $ra
    /* EE2CC 800FDACC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel STREAM_get
