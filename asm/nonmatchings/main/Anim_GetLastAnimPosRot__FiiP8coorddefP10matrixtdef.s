.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Anim_GetLastAnimPosRot__FiiP8coorddefP10matrixtdef, 0x98

glabel Anim_GetLastAnimPosRot__FiiP8coorddefP10matrixtdef
    /* 64680 80073E80 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 64684 80073E84 1000B0AF */  sw         $s0, 0x10($sp)
    /* 64688 80073E88 2180A000 */  addu       $s0, $a1, $zero
    /* 6468C 80073E8C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 64690 80073E90 2188E000 */  addu       $s1, $a3, $zero
    /* 64694 80073E94 1180023C */  lui        $v0, %hi(animScripts)
    /* 64698 80073E98 4CE24224 */  addiu      $v0, $v0, %lo(animScripts)
    /* 6469C 80073E9C 80200400 */  sll        $a0, $a0, 2
    /* 646A0 80073EA0 21208200 */  addu       $a0, $a0, $v0
    /* 646A4 80073EA4 2128C000 */  addu       $a1, $a2, $zero
    /* 646A8 80073EA8 1800BFAF */  sw         $ra, 0x18($sp)
    /* 646AC 80073EAC 0000848C */  lw         $a0, 0x0($a0)
    /* 646B0 80073EB0 82CF010C */  jal        Anim_GetLastRotPos__FP15Trk_AnimateInstP8coorddefP10matrixtdef
    /* 646B4 80073EB4 21302002 */   addu      $a2, $s1, $zero
    /* 646B8 80073EB8 04001032 */  andi       $s0, $s0, 0x4
    /* 646BC 80073EBC 10000012 */  beqz       $s0, .L80073F00
    /* 646C0 80073EC0 00000000 */   nop
    /* 646C4 80073EC4 0C00278E */  lw         $a3, 0xC($s1)
    /* 646C8 80073EC8 1800228E */  lw         $v0, 0x18($s1)
    /* 646CC 80073ECC 1C00238E */  lw         $v1, 0x1C($s1)
    /* 646D0 80073ED0 23280700 */  negu       $a1, $a3
    /* 646D4 80073ED4 1000278E */  lw         $a3, 0x10($s1)
    /* 646D8 80073ED8 2000248E */  lw         $a0, 0x20($s1)
    /* 646DC 80073EDC 23300700 */  negu       $a2, $a3
    /* 646E0 80073EE0 1400278E */  lw         $a3, 0x14($s1)
    /* 646E4 80073EE4 0C0022AE */  sw         $v0, 0xC($s1)
    /* 646E8 80073EE8 180025AE */  sw         $a1, 0x18($s1)
    /* 646EC 80073EEC 100023AE */  sw         $v1, 0x10($s1)
    /* 646F0 80073EF0 1C0026AE */  sw         $a2, 0x1C($s1)
    /* 646F4 80073EF4 140024AE */  sw         $a0, 0x14($s1)
    /* 646F8 80073EF8 23100700 */  negu       $v0, $a3
    /* 646FC 80073EFC 200022AE */  sw         $v0, 0x20($s1)
  .L80073F00:
    /* 64700 80073F00 1800BF8F */  lw         $ra, 0x18($sp)
    /* 64704 80073F04 1400B18F */  lw         $s1, 0x14($sp)
    /* 64708 80073F08 1000B08F */  lw         $s0, 0x10($sp)
    /* 6470C 80073F0C 01000224 */  addiu      $v0, $zero, 0x1
    /* 64710 80073F10 0800E003 */  jr         $ra
    /* 64714 80073F14 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Anim_GetLastAnimPosRot__FiiP8coorddefP10matrixtdef
