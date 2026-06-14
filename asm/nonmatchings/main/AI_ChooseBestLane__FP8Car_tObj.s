.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_ChooseBestLane__FP8Car_tObj, 0x8C

glabel AI_ChooseBestLane__FP8Car_tObj
    /* 4A620 80059E20 1180023C */  lui        $v0, %hi(AI_Info)
    /* 4A624 80059E24 F0CC4524 */  addiu      $a1, $v0, %lo(AI_Info)
    /* 4A628 80059E28 3400A68C */  lw         $a2, 0x34($a1)
    /* 4A62C 80059E2C C406838C */  lw         $v1, 0x6C4($a0)
    /* 4A630 80059E30 3000A78C */  lw         $a3, 0x30($a1)
    /* 4A634 80059E34 01000224 */  addiu      $v0, $zero, 0x1
    /* 4A638 80059E38 4000A2AC */  sw         $v0, 0x40($a1)
    /* 4A63C 80059E3C 2A10C700 */  slt        $v0, $a2, $a3
    /* 4A640 80059E40 06004010 */  beqz       $v0, .L80059E5C
    /* 4A644 80059E44 3C00A3AC */   sw        $v1, 0x3C($a1)
    /* 4A648 80059E48 C406828C */  lw         $v0, 0x6C4($a0)
    /* 4A64C 80059E4C 2130E000 */  addu       $a2, $a3, $zero
    /* 4A650 80059E50 4000A0AC */  sw         $zero, 0x40($a1)
    /* 4A654 80059E54 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 4A658 80059E58 3C00A2AC */  sw         $v0, 0x3C($a1)
  .L80059E5C:
    /* 4A65C 80059E5C 3800A28C */  lw         $v0, 0x38($a1)
    /* 4A660 80059E60 00000000 */  nop
    /* 4A664 80059E64 2A10C200 */  slt        $v0, $a2, $v0
    /* 4A668 80059E68 05004010 */  beqz       $v0, .L80059E80
    /* 4A66C 80059E6C 02000324 */   addiu     $v1, $zero, 0x2
    /* 4A670 80059E70 C406828C */  lw         $v0, 0x6C4($a0)
    /* 4A674 80059E74 4000A3AC */  sw         $v1, 0x40($a1)
    /* 4A678 80059E78 01004224 */  addiu      $v0, $v0, 0x1
    /* 4A67C 80059E7C 3C00A2AC */  sw         $v0, 0x3C($a1)
  .L80059E80:
    /* 4A680 80059E80 3C00A28C */  lw         $v0, 0x3C($a1)
    /* 4A684 80059E84 00000000 */  nop
    /* 4A688 80059E88 03004104 */  bgez       $v0, .L80059E98
    /* 4A68C 80059E8C 0E004228 */   slti      $v0, $v0, 0xE
    /* 4A690 80059E90 0800E003 */  jr         $ra
    /* 4A694 80059E94 3C00A0AC */   sw        $zero, 0x3C($a1)
  .L80059E98:
    /* 4A698 80059E98 02004014 */  bnez       $v0, .L80059EA4
    /* 4A69C 80059E9C 0D000224 */   addiu     $v0, $zero, 0xD
    /* 4A6A0 80059EA0 3C00A2AC */  sw         $v0, 0x3C($a1)
  .L80059EA4:
    /* 4A6A4 80059EA4 0800E003 */  jr         $ra
    /* 4A6A8 80059EA8 00000000 */   nop
endlabel AI_ChooseBestLane__FP8Car_tObj
