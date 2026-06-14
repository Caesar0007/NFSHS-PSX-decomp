.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching transpose, 0xAC

glabel transpose
    /* D4B58 800E4358 0F008514 */  bne        $a0, $a1, .L800E4398
    /* D4B5C 800E435C 00000000 */   nop
    /* D4B60 800E4360 0C00A68C */  lw         $a2, 0xC($a1)
    /* D4B64 800E4364 0400A48C */  lw         $a0, 0x4($a1)
    /* D4B68 800E4368 0800A38C */  lw         $v1, 0x8($a1)
    /* D4B6C 800E436C 1400A28C */  lw         $v0, 0x14($a1)
    /* D4B70 800E4370 0400A6AC */  sw         $a2, 0x4($a1)
    /* D4B74 800E4374 1800A68C */  lw         $a2, 0x18($a1)
    /* D4B78 800E4378 00000000 */  nop
    /* D4B7C 800E437C 0800A6AC */  sw         $a2, 0x8($a1)
    /* D4B80 800E4380 1C00A68C */  lw         $a2, 0x1C($a1)
    /* D4B84 800E4384 0C00A4AC */  sw         $a0, 0xC($a1)
    /* D4B88 800E4388 1800A3AC */  sw         $v1, 0x18($a1)
    /* D4B8C 800E438C 1C00A2AC */  sw         $v0, 0x1C($a1)
    /* D4B90 800E4390 0800E003 */  jr         $ra
    /* D4B94 800E4394 1400A6AC */   sw        $a2, 0x14($a1)
  .L800E4398:
    /* D4B98 800E4398 0000828C */  lw         $v0, 0x0($a0)
    /* D4B9C 800E439C 00000000 */  nop
    /* D4BA0 800E43A0 0000A2AC */  sw         $v0, 0x0($a1)
    /* D4BA4 800E43A4 0C00828C */  lw         $v0, 0xC($a0)
    /* D4BA8 800E43A8 00000000 */  nop
    /* D4BAC 800E43AC 0400A2AC */  sw         $v0, 0x4($a1)
    /* D4BB0 800E43B0 1800828C */  lw         $v0, 0x18($a0)
    /* D4BB4 800E43B4 00000000 */  nop
    /* D4BB8 800E43B8 0800A2AC */  sw         $v0, 0x8($a1)
    /* D4BBC 800E43BC 0400828C */  lw         $v0, 0x4($a0)
    /* D4BC0 800E43C0 00000000 */  nop
    /* D4BC4 800E43C4 0C00A2AC */  sw         $v0, 0xC($a1)
    /* D4BC8 800E43C8 1000828C */  lw         $v0, 0x10($a0)
    /* D4BCC 800E43CC 00000000 */  nop
    /* D4BD0 800E43D0 1000A2AC */  sw         $v0, 0x10($a1)
    /* D4BD4 800E43D4 1C00828C */  lw         $v0, 0x1C($a0)
    /* D4BD8 800E43D8 00000000 */  nop
    /* D4BDC 800E43DC 1400A2AC */  sw         $v0, 0x14($a1)
    /* D4BE0 800E43E0 0800828C */  lw         $v0, 0x8($a0)
    /* D4BE4 800E43E4 00000000 */  nop
    /* D4BE8 800E43E8 1800A2AC */  sw         $v0, 0x18($a1)
    /* D4BEC 800E43EC 1400828C */  lw         $v0, 0x14($a0)
    /* D4BF0 800E43F0 00000000 */  nop
    /* D4BF4 800E43F4 1C00A2AC */  sw         $v0, 0x1C($a1)
    /* D4BF8 800E43F8 2000828C */  lw         $v0, 0x20($a0)
    /* D4BFC 800E43FC 0800E003 */  jr         $ra
    /* D4C00 800E4400 2000A2AC */   sw        $v0, 0x20($a1)
endlabel transpose
