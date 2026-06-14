.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIInit_IsNonStandardCarFile__Fi, 0x78

glabel AIInit_IsNonStandardCarFile__Fi
    /* 57DD8 800675D8 38FFBD27 */  addiu      $sp, $sp, -0xC8
    /* 57DDC 800675DC 2118A003 */  addu       $v1, $sp, $zero
    /* 57DE0 800675E0 0580023C */  lui        $v0, %hi(D_8005523C)
    /* 57DE4 800675E4 3C524224 */  addiu      $v0, $v0, %lo(D_8005523C)
    /* 57DE8 800675E8 C0004524 */  addiu      $a1, $v0, 0xC0
  .L800675EC:
    /* 57DEC 800675EC 0000468C */  lw         $a2, 0x0($v0)
    /* 57DF0 800675F0 0400478C */  lw         $a3, 0x4($v0)
    /* 57DF4 800675F4 0800488C */  lw         $t0, 0x8($v0)
    /* 57DF8 800675F8 0C00498C */  lw         $t1, 0xC($v0)
    /* 57DFC 800675FC 000066AC */  sw         $a2, 0x0($v1)
    /* 57E00 80067600 040067AC */  sw         $a3, 0x4($v1)
    /* 57E04 80067604 080068AC */  sw         $t0, 0x8($v1)
    /* 57E08 80067608 0C0069AC */  sw         $t1, 0xC($v1)
    /* 57E0C 8006760C 10004224 */  addiu      $v0, $v0, 0x10
    /* 57E10 80067610 F6FF4514 */  bne        $v0, $a1, .L800675EC
    /* 57E14 80067614 10006324 */   addiu     $v1, $v1, 0x10
    /* 57E18 80067618 0000468C */  lw         $a2, 0x0($v0)
    /* 57E1C 8006761C 0400478C */  lw         $a3, 0x4($v0)
    /* 57E20 80067620 000066AC */  sw         $a2, 0x0($v1)
    /* 57E24 80067624 040067AC */  sw         $a3, 0x4($v1)
    /* 57E28 80067628 32008228 */  slti       $v0, $a0, 0x32
    /* 57E2C 8006762C 05004010 */  beqz       $v0, .L80067644
    /* 57E30 80067630 80100400 */   sll       $v0, $a0, 2
    /* 57E34 80067634 2110A203 */  addu       $v0, $sp, $v0
    /* 57E38 80067638 0000428C */  lw         $v0, 0x0($v0)
    /* 57E3C 8006763C 929D0108 */  j          .L80067648
    /* 57E40 80067640 00000000 */   nop
  .L80067644:
    /* 57E44 80067644 21100000 */  addu       $v0, $zero, $zero
  .L80067648:
    /* 57E48 80067648 0800E003 */  jr         $ra
    /* 57E4C 8006764C C800BD27 */   addiu     $sp, $sp, 0xC8
endlabel AIInit_IsNonStandardCarFile__Fi
