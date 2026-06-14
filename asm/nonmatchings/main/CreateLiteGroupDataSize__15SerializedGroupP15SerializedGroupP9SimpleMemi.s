.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CreateLiteGroupDataSize__15SerializedGroupP15SerializedGroupP9SimpleMemi, 0x60

glabel CreateLiteGroupDataSize__15SerializedGroupP15SerializedGroupP9SimpleMemi
    /* 8CAE4 8009C2E4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 8CAE8 8009C2E8 1800B2AF */  sw         $s2, 0x18($sp)
    /* 8CAEC 8009C2EC 2190A000 */  addu       $s2, $a1, $zero
    /* 8CAF0 8009C2F0 2120C000 */  addu       $a0, $a2, $zero
    /* 8CAF4 8009C2F4 1400B1AF */  sw         $s1, 0x14($sp)
    /* 8CAF8 8009C2F8 0400F124 */  addiu      $s1, $a3, 0x4
    /* 8CAFC 8009C2FC 21282002 */  addu       $a1, $s1, $zero
    /* 8CB00 8009C300 21300000 */  addu       $a2, $zero, $zero
    /* 8CB04 8009C304 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 8CB08 8009C308 94DC020C */  jal        Alloc__9SimpleMemii
    /* 8CB0C 8009C30C 1000B0AF */   sw        $s0, 0x10($sp)
    /* 8CB10 8009C310 21804000 */  addu       $s0, $v0, $zero
    /* 8CB14 8009C314 10004426 */  addiu      $a0, $s2, 0x10
    /* 8CB18 8009C318 04000526 */  addiu      $a1, $s0, 0x4
    /* 8CB1C 8009C31C 21302002 */  addu       $a2, $s1, $zero
    /* 8CB20 8009C320 B798030C */  jal        blockmove
    /* 8CB24 8009C324 000000AE */   sw        $zero, 0x0($s0)
    /* 8CB28 8009C328 21100002 */  addu       $v0, $s0, $zero
    /* 8CB2C 8009C32C 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 8CB30 8009C330 1800B28F */  lw         $s2, 0x18($sp)
    /* 8CB34 8009C334 1400B18F */  lw         $s1, 0x14($sp)
    /* 8CB38 8009C338 1000B08F */  lw         $s0, 0x10($sp)
    /* 8CB3C 8009C33C 0800E003 */  jr         $ra
    /* 8CB40 8009C340 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel CreateLiteGroupDataSize__15SerializedGroupP15SerializedGroupP9SimpleMemi
