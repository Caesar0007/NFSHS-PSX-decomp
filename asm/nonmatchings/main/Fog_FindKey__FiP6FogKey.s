.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Fog_FindKey__FiP6FogKey, 0x94

glabel Fog_FindKey__FiP6FogKey
    /* D13EC 800E0BEC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D13F0 800E0BF0 1400B1AF */  sw         $s1, 0x14($sp)
    /* D13F4 800E0BF4 21888000 */  addu       $s1, $a0, $zero
    /* D13F8 800E0BF8 1000B0AF */  sw         $s0, 0x10($sp)
    /* D13FC 800E0BFC 2180A000 */  addu       $s0, $a1, $zero
    /* D1400 800E0C00 02000016 */  bnez       $s0, .L800E0C0C
    /* D1404 800E0C04 1800BFAF */   sw        $ra, 0x18($sp)
    /* D1408 800E0C08 3C16908F */  lw         $s0, %gp_rel(Fog_gHeadKey)($gp)
  .L800E0C0C:
    /* D140C 800E0C0C 21202002 */  addu       $a0, $s1, $zero
    /* D1410 800E0C10 E682030C */  jal        Fog_CheckRange__FiP6FogKey
    /* D1414 800E0C14 21280002 */   addu      $a1, $s0, $zero
    /* D1418 800E0C18 14004014 */  bnez       $v0, .L800E0C6C
    /* D141C 800E0C1C 21100002 */   addu      $v0, $s0, $zero
    /* D1420 800E0C20 02000286 */  lh         $v0, 0x2($s0)
    /* D1424 800E0C24 00000000 */  nop
    /* D1428 800E0C28 2A102202 */  slt        $v0, $s1, $v0
    /* D142C 800E0C2C 09004010 */  beqz       $v0, .L800E0C54
    /* D1430 800E0C30 00000000 */   nop
  .L800E0C34:
    /* D1434 800E0C34 0800108E */  lw         $s0, 0x8($s0)
    /* D1438 800E0C38 21202002 */  addu       $a0, $s1, $zero
    /* D143C 800E0C3C E682030C */  jal        Fog_CheckRange__FiP6FogKey
    /* D1440 800E0C40 21280002 */   addu      $a1, $s0, $zero
    /* D1444 800E0C44 FBFF4010 */  beqz       $v0, .L800E0C34
    /* D1448 800E0C48 21100002 */   addu      $v0, $s0, $zero
    /* D144C 800E0C4C 1B830308 */  j          .L800E0C6C
    /* D1450 800E0C50 00000000 */   nop
  .L800E0C54:
    /* D1454 800E0C54 0400108E */  lw         $s0, 0x4($s0)
    /* D1458 800E0C58 21202002 */  addu       $a0, $s1, $zero
    /* D145C 800E0C5C E682030C */  jal        Fog_CheckRange__FiP6FogKey
    /* D1460 800E0C60 21280002 */   addu      $a1, $s0, $zero
    /* D1464 800E0C64 FBFF4010 */  beqz       $v0, .L800E0C54
    /* D1468 800E0C68 21100002 */   addu      $v0, $s0, $zero
  .L800E0C6C:
    /* D146C 800E0C6C 1800BF8F */  lw         $ra, 0x18($sp)
    /* D1470 800E0C70 1400B18F */  lw         $s1, 0x14($sp)
    /* D1474 800E0C74 1000B08F */  lw         $s0, 0x10($sp)
    /* D1478 800E0C78 0800E003 */  jr         $ra
    /* D147C 800E0C7C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Fog_FindKey__FiP6FogKey
