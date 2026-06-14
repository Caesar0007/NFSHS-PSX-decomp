.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Object_InitStatus__Fv, 0x28

glabel Object_InitStatus__Fv
    /* 95A30 800A5230 C1010324 */  addiu      $v1, $zero, 0x1C1
    /* 95A34 800A5234 1180023C */  lui        $v0, %hi(gSimObjAnims)
    /* 95A38 800A5238 605D4224 */  addiu      $v0, $v0, %lo(gSimObjAnims)
    /* 95A3C 800A523C 04074224 */  addiu      $v0, $v0, 0x704
  .L800A5240:
    /* 95A40 800A5240 000040AC */  sw         $zero, 0x0($v0)
    /* 95A44 800A5244 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 95A48 800A5248 FDFF6104 */  bgez       $v1, .L800A5240
    /* 95A4C 800A524C FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 95A50 800A5250 0800E003 */  jr         $ra
    /* 95A54 800A5254 00000000 */   nop
endlabel Object_InitStatus__Fv
