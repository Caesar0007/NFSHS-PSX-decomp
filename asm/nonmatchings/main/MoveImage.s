.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MoveImage, 0xB8

glabel MoveImage
    /* DE350 800EDB50 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DE354 800EDB54 1000B0AF */  sw         $s0, 0x10($sp)
    /* DE358 800EDB58 21808000 */  addu       $s0, $a0, $zero
    /* DE35C 800EDB5C 1800B2AF */  sw         $s2, 0x18($sp)
    /* DE360 800EDB60 2190A000 */  addu       $s2, $a1, $zero
    /* DE364 800EDB64 1400B1AF */  sw         $s1, 0x14($sp)
    /* DE368 800EDB68 2188C000 */  addu       $s1, $a2, $zero
    /* DE36C 800EDB6C 0580043C */  lui        $a0, %hi(D_80056E1C)
    /* DE370 800EDB70 1C6E8424 */  addiu      $a0, $a0, %lo(D_80056E1C)
    /* DE374 800EDB74 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* DE378 800EDB78 39B6030C */  jal        _image
    /* DE37C 800EDB7C 21280002 */   addu      $a1, $s0, $zero
    /* DE380 800EDB80 04000286 */  lh         $v0, 0x4($s0)
    /* DE384 800EDB84 00000000 */  nop
    /* DE388 800EDB88 19004010 */  beqz       $v0, .L800EDBF0
    /* DE38C 800EDB8C FFFF0224 */   addiu     $v0, $zero, -0x1
    /* DE390 800EDB90 06000286 */  lh         $v0, 0x6($s0)
    /* DE394 800EDB94 00000000 */  nop
    /* DE398 800EDB98 03004014 */  bnez       $v0, .L800EDBA8
    /* DE39C 800EDB9C 00141100 */   sll       $v0, $s1, 16
    /* DE3A0 800EDBA0 FCB60308 */  j          .L800EDBF0
    /* DE3A4 800EDBA4 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L800EDBA8:
    /* DE3A8 800EDBA8 1280033C */  lui        $v1, %hi(D_8012373C)
    /* DE3AC 800EDBAC 3C376324 */  addiu      $v1, $v1, %lo(D_8012373C)
    /* DE3B0 800EDBB0 FFFF4432 */  andi       $a0, $s2, 0xFFFF
    /* DE3B4 800EDBB4 25104400 */  or         $v0, $v0, $a0
    /* DE3B8 800EDBB8 0000058E */  lw         $a1, 0x0($s0)
    /* DE3BC 800EDBBC 1280073C */  lui        $a3, %hi(D_80123694)
    /* DE3C0 800EDBC0 9436E78C */  lw         $a3, %lo(D_80123694)($a3)
    /* DE3C4 800EDBC4 14000624 */  addiu      $a2, $zero, 0x14
    /* DE3C8 800EDBC8 040062AC */  sw         $v0, 0x4($v1)
    /* DE3CC 800EDBCC 000065AC */  sw         $a1, 0x0($v1)
    /* DE3D0 800EDBD0 0400028E */  lw         $v0, 0x4($s0)
    /* DE3D4 800EDBD4 F8FF6524 */  addiu      $a1, $v1, -0x8
    /* DE3D8 800EDBD8 080062AC */  sw         $v0, 0x8($v1)
    /* DE3DC 800EDBDC 1800E48C */  lw         $a0, 0x18($a3)
    /* DE3E0 800EDBE0 0800E28C */  lw         $v0, 0x8($a3)
    /* DE3E4 800EDBE4 00000000 */  nop
    /* DE3E8 800EDBE8 09F84000 */  jalr       $v0
    /* DE3EC 800EDBEC 21380000 */   addu      $a3, $zero, $zero
  .L800EDBF0:
    /* DE3F0 800EDBF0 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* DE3F4 800EDBF4 1800B28F */  lw         $s2, 0x18($sp)
    /* DE3F8 800EDBF8 1400B18F */  lw         $s1, 0x14($sp)
    /* DE3FC 800EDBFC 1000B08F */  lw         $s0, 0x10($sp)
    /* DE400 800EDC00 0800E003 */  jr         $ra
    /* DE404 800EDC04 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel MoveImage
