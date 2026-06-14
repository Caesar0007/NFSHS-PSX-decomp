.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CreateLiteGroup__15SerializedGroupP15SerializedGroupP9SimpleMem, 0x68

glabel CreateLiteGroup__15SerializedGroupP15SerializedGroupP9SimpleMem
    /* 8CA7C 8009C27C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 8CA80 8009C280 1800B2AF */  sw         $s2, 0x18($sp)
    /* 8CA84 8009C284 2190A000 */  addu       $s2, $a1, $zero
    /* 8CA88 8009C288 2120C000 */  addu       $a0, $a2, $zero
    /* 8CA8C 8009C28C 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 8CA90 8009C290 1400B1AF */  sw         $s1, 0x14($sp)
    /* 8CA94 8009C294 1000B0AF */  sw         $s0, 0x10($sp)
    /* 8CA98 8009C298 0400518E */  lw         $s1, 0x4($s2)
    /* 8CA9C 8009C29C 21300000 */  addu       $a2, $zero, $zero
    /* 8CAA0 8009C2A0 F4FF3126 */  addiu      $s1, $s1, -0xC
    /* 8CAA4 8009C2A4 94DC020C */  jal        Alloc__9SimpleMemii
    /* 8CAA8 8009C2A8 21282002 */   addu      $a1, $s1, $zero
    /* 8CAAC 8009C2AC 10004426 */  addiu      $a0, $s2, 0x10
    /* 8CAB0 8009C2B0 21804000 */  addu       $s0, $v0, $zero
    /* 8CAB4 8009C2B4 04000526 */  addiu      $a1, $s0, 0x4
    /* 8CAB8 8009C2B8 0C00428E */  lw         $v0, 0xC($s2)
    /* 8CABC 8009C2BC 21302002 */  addu       $a2, $s1, $zero
    /* 8CAC0 8009C2C0 B798030C */  jal        blockmove
    /* 8CAC4 8009C2C4 000002AE */   sw        $v0, 0x0($s0)
    /* 8CAC8 8009C2C8 21100002 */  addu       $v0, $s0, $zero
    /* 8CACC 8009C2CC 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 8CAD0 8009C2D0 1800B28F */  lw         $s2, 0x18($sp)
    /* 8CAD4 8009C2D4 1400B18F */  lw         $s1, 0x14($sp)
    /* 8CAD8 8009C2D8 1000B08F */  lw         $s0, 0x10($sp)
    /* 8CADC 8009C2DC 0800E003 */  jr         $ra
    /* 8CAE0 8009C2E0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel CreateLiteGroup__15SerializedGroupP15SerializedGroupP9SimpleMem
