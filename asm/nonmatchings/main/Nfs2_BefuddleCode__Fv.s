.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Nfs2_BefuddleCode__Fv, 0x58

glabel Nfs2_BefuddleCode__Fv
    /* 94650 800A3E50 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 94654 800A3E54 1400B1AF */  sw         $s1, 0x14($sp)
    /* 94658 800A3E58 21880000 */  addu       $s1, $zero, $zero
    /* 9465C 800A3E5C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 94660 800A3E60 1180123C */  lui        $s2, %hi(befuddleTemp)
    /* 94664 800A3E64 1180023C */  lui        $v0, %hi(befuddleExtensions)
    /* 94668 800A3E68 1000B0AF */  sw         $s0, 0x10($sp)
    /* 9466C 800A3E6C 3C425024 */  addiu      $s0, $v0, %lo(befuddleExtensions)
    /* 94670 800A3E70 1C00BFAF */  sw         $ra, 0x1C($sp)
  .L800A3E74:
    /* 94674 800A3E74 3C5C4426 */  addiu      $a0, $s2, %lo(befuddleTemp)
    /* 94678 800A3E78 CA96030C */  jal        strcpy
    /* 9467C 800A3E7C 21280002 */   addu      $a1, $s0, $zero
    /* 94680 800A3E80 01003126 */  addiu      $s1, $s1, 0x1
    /* 94684 800A3E84 0E00222A */  slti       $v0, $s1, 0xE
    /* 94688 800A3E88 FAFF4014 */  bnez       $v0, .L800A3E74
    /* 9468C 800A3E8C 04001026 */   addiu     $s0, $s0, 0x4
    /* 94690 800A3E90 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 94694 800A3E94 1800B28F */  lw         $s2, 0x18($sp)
    /* 94698 800A3E98 1400B18F */  lw         $s1, 0x14($sp)
    /* 9469C 800A3E9C 1000B08F */  lw         $s0, 0x10($sp)
    /* 946A0 800A3EA0 0800E003 */  jr         $ra
    /* 946A4 800A3EA4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Nfs2_BefuddleCode__Fv
