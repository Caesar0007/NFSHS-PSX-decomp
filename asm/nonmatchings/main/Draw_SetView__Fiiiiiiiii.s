.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw_SetView__Fiiiiiiiii, 0x114

glabel Draw_SetView__Fiiiiiiiii
    /* AE2C0 800BDAC0 6012828F */  lw         $v0, %gp_rel(Draw_gNumView)($gp)
    /* AE2C4 800BDAC4 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* AE2C8 800BDAC8 2400B3AF */  sw         $s3, 0x24($sp)
    /* AE2CC 800BDACC 5000B38F */  lw         $s3, 0x50($sp)
    /* AE2D0 800BDAD0 2800B4AF */  sw         $s4, 0x28($sp)
    /* AE2D4 800BDAD4 5400B48F */  lw         $s4, 0x54($sp)
    /* AE2D8 800BDAD8 3000B6AF */  sw         $s6, 0x30($sp)
    /* AE2DC 800BDADC 5800B68F */  lw         $s6, 0x58($sp)
    /* AE2E0 800BDAE0 2118A000 */  addu       $v1, $a1, $zero
    /* AE2E4 800BDAE4 3800BEAF */  sw         $fp, 0x38($sp)
    /* AE2E8 800BDAE8 21F0C000 */  addu       $fp, $a2, $zero
    /* AE2EC 800BDAEC 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* AE2F0 800BDAF0 5C00B58F */  lw         $s5, 0x5C($sp)
    /* AE2F4 800BDAF4 21288000 */  addu       $a1, $a0, $zero
    /* AE2F8 800BDAF8 3400B7AF */  sw         $s7, 0x34($sp)
    /* AE2FC 800BDAFC 6000B78F */  lw         $s7, 0x60($sp)
    /* AE300 800BDB00 21306000 */  addu       $a2, $v1, $zero
    /* AE304 800BDB04 3C00BFAF */  sw         $ra, 0x3C($sp)
    /* AE308 800BDB08 2000B2AF */  sw         $s2, 0x20($sp)
    /* AE30C 800BDB0C 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* AE310 800BDB10 1800B0AF */  sw         $s0, 0x18($sp)
    /* AE314 800BDB14 4C00A7AF */  sw         $a3, 0x4C($sp)
    /* AE318 800BDB18 40800200 */  sll        $s0, $v0, 1
    /* AE31C 800BDB1C 21800202 */  addu       $s0, $s0, $v0
    /* AE320 800BDB20 C0801000 */  sll        $s0, $s0, 3
    /* AE324 800BDB24 21800202 */  addu       $s0, $s0, $v0
    /* AE328 800BDB28 C0801000 */  sll        $s0, $s0, 3
    /* AE32C 800BDB2C 1280023C */  lui        $v0, %hi(Draw_gView)
    /* AE330 800BDB30 54EC4224 */  addiu      $v0, $v0, %lo(Draw_gView)
    /* AE334 800BDB34 21800202 */  addu       $s0, $s0, $v0
    /* AE338 800BDB38 08001226 */  addiu      $s2, $s0, 0x8
    /* AE33C 800BDB3C 21204002 */  addu       $a0, $s2, $zero
    /* AE340 800BDB40 21386002 */  addu       $a3, $s3, $zero
    /* AE344 800BDB44 8BC8030C */  jal        SetDefDrawEnv
    /* AE348 800BDB48 1000B4AF */   sw        $s4, 0x10($sp)
    /* AE34C 800BDB4C 64001126 */  addiu      $s1, $s0, 0x64
    /* AE350 800BDB50 21202002 */  addu       $a0, $s1, $zero
    /* AE354 800BDB54 2128C003 */  addu       $a1, $fp, $zero
    /* AE358 800BDB58 4C00A68F */  lw         $a2, 0x4C($sp)
    /* AE35C 800BDB5C 21386002 */  addu       $a3, $s3, $zero
    /* AE360 800BDB60 8BC8030C */  jal        SetDefDrawEnv
    /* AE364 800BDB64 1000B4AF */   sw        $s4, 0x10($sp)
    /* AE368 800BDB68 190040A2 */  sb         $zero, 0x19($s2)
    /* AE36C 800BDB6C 1A0040A2 */  sb         $zero, 0x1A($s2)
    /* AE370 800BDB70 1B0040A2 */  sb         $zero, 0x1B($s2)
    /* AE374 800BDB74 190020A2 */  sb         $zero, 0x19($s1)
    /* AE378 800BDB78 1A0020A2 */  sb         $zero, 0x1A($s1)
    /* AE37C 800BDB7C 1B0020A2 */  sb         $zero, 0x1B($s1)
    /* AE380 800BDB80 180035A2 */  sb         $s5, 0x18($s1)
    /* AE384 800BDB84 180055A2 */  sb         $s5, 0x18($s2)
    /* AE388 800BDB88 160036A2 */  sb         $s6, 0x16($s1)
    /* AE38C 800BDB8C 160056A2 */  sb         $s6, 0x16($s2)
    /* AE390 800BDB90 6012828F */  lw         $v0, %gp_rel(Draw_gNumView)($gp)
    /* AE394 800BDB94 000017AE */  sw         $s7, 0x0($s0)
    /* AE398 800BDB98 040000AE */  sw         $zero, 0x4($s0)
    /* AE39C 800BDB9C 3C00BF8F */  lw         $ra, 0x3C($sp)
    /* AE3A0 800BDBA0 3800BE8F */  lw         $fp, 0x38($sp)
    /* AE3A4 800BDBA4 3400B78F */  lw         $s7, 0x34($sp)
    /* AE3A8 800BDBA8 3000B68F */  lw         $s6, 0x30($sp)
    /* AE3AC 800BDBAC 2C00B58F */  lw         $s5, 0x2C($sp)
    /* AE3B0 800BDBB0 2800B48F */  lw         $s4, 0x28($sp)
    /* AE3B4 800BDBB4 2400B38F */  lw         $s3, 0x24($sp)
    /* AE3B8 800BDBB8 2000B28F */  lw         $s2, 0x20($sp)
    /* AE3BC 800BDBBC 1C00B18F */  lw         $s1, 0x1C($sp)
    /* AE3C0 800BDBC0 1800B08F */  lw         $s0, 0x18($sp)
    /* AE3C4 800BDBC4 01004324 */  addiu      $v1, $v0, 0x1
    /* AE3C8 800BDBC8 601283AF */  sw         $v1, %gp_rel(Draw_gNumView)($gp)
    /* AE3CC 800BDBCC 0800E003 */  jr         $ra
    /* AE3D0 800BDBD0 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel Draw_SetView__Fiiiiiiiii
