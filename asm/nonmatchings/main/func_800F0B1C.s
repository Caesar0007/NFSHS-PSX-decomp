.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching func_800F0B1C, 0x58

glabel func_800F0B1C
    /* E131C 800F0B1C 00600340 */  mfc0       $v1, $12 /* handwritten instruction */
    /* E1320 800F0B20 00000000 */  nop
    /* E1324 800F0B24 FEFB0124 */  addiu      $at, $zero, -0x402
    /* E1328 800F0B28 24406100 */  and        $t0, $v1, $at
    /* E132C 800F0B2C 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* E1330 800F0B30 00000000 */  nop
    /* E1334 800F0B34 00000000 */  nop
    /* E1338 800F0B38 00000000 */  nop
    /* E133C 800F0B3C 0000828C */  lw         $v0, 0x0($a0)
    /* E1340 800F0B40 00000000 */  nop
    /* E1344 800F0B44 03004014 */  bnez       $v0, .L800F0B54
    /* E1348 800F0B48 00000000 */   nop
    /* E134C 800F0B4C D8C20308 */  j          .L800F0B60
    /* E1350 800F0B50 000085AC */   sw        $a1, 0x0($a0)
  .L800F0B54:
    /* E1354 800F0B54 0400828C */  lw         $v0, 0x4($a0)
    /* E1358 800F0B58 00000000 */  nop
    /* E135C 800F0B5C 040045AC */  sw         $a1, 0x4($v0)
  .L800F0B60:
    /* E1360 800F0B60 040085AC */  sw         $a1, 0x4($a0)
    /* E1364 800F0B64 0400A0AC */  sw         $zero, 0x4($a1)
    /* E1368 800F0B68 00608340 */  mtc0       $v1, $12 /* handwritten instruction */
    /* E136C 800F0B6C 0800E003 */  jr         $ra
    /* E1370 800F0B70 00000000 */   nop
endlabel func_800F0B1C
