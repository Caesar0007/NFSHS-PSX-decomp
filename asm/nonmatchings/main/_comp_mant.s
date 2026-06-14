.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _comp_mant, 0x50

glabel _comp_mant
    /* E68B4 800F60B4 2B10E500 */  sltu       $v0, $a3, $a1
    /* E68B8 800F60B8 0000A4AF */  sw         $a0, 0x0($sp)
    /* E68BC 800F60BC 0400A5AF */  sw         $a1, 0x4($sp)
    /* E68C0 800F60C0 0800A6AF */  sw         $a2, 0x8($sp)
    /* E68C4 800F60C4 0C004014 */  bnez       $v0, .L800F60F8
    /* E68C8 800F60C8 0C00A7AF */   sw        $a3, 0xC($sp)
    /* E68CC 800F60CC 2B10A700 */  sltu       $v0, $a1, $a3
    /* E68D0 800F60D0 0A004014 */  bnez       $v0, .L800F60FC
    /* E68D4 800F60D4 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* E68D8 800F60D8 2B10C400 */  sltu       $v0, $a2, $a0
    /* E68DC 800F60DC 07004014 */  bnez       $v0, .L800F60FC
    /* E68E0 800F60E0 01000224 */   addiu     $v0, $zero, 0x1
    /* E68E4 800F60E4 2B188600 */  sltu       $v1, $a0, $a2
    /* E68E8 800F60E8 04006014 */  bnez       $v1, .L800F60FC
    /* E68EC 800F60EC FFFF0224 */   addiu     $v0, $zero, -0x1
    /* E68F0 800F60F0 3FD80308 */  j          .L800F60FC
    /* E68F4 800F60F4 21100000 */   addu      $v0, $zero, $zero
  .L800F60F8:
    /* E68F8 800F60F8 01000224 */  addiu      $v0, $zero, 0x1
  .L800F60FC:
    /* E68FC 800F60FC 0800E003 */  jr         $ra
    /* E6900 800F6100 00000000 */   nop
endlabel _comp_mant
