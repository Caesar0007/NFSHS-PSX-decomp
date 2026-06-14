.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Anim_DeInitSystem__Fv, 0x38

glabel Anim_DeInitSystem__Fv
    /* 644B0 80073CB0 09000324 */  addiu      $v1, $zero, 0x9
    /* 644B4 80073CB4 FFFF6324 */  addiu      $v1, $v1, -0x1
  .L80073CB8:
    /* 644B8 80073CB8 FFFF6104 */  bgez       $v1, .L80073CB8
    /* 644BC 80073CBC FFFF6324 */   addiu     $v1, $v1, -0x1
    /* 644C0 80073CC0 1F000324 */  addiu      $v1, $zero, 0x1F
    /* 644C4 80073CC4 1180023C */  lui        $v0, %hi(Anim_gInstanceFromIndex)
    /* 644C8 80073CC8 CCE14224 */  addiu      $v0, $v0, %lo(Anim_gInstanceFromIndex)
    /* 644CC 80073CCC 7C004224 */  addiu      $v0, $v0, 0x7C
  .L80073CD0:
    /* 644D0 80073CD0 000040AC */  sw         $zero, 0x0($v0)
    /* 644D4 80073CD4 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 644D8 80073CD8 FDFF6104 */  bgez       $v1, .L80073CD0
    /* 644DC 80073CDC FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 644E0 80073CE0 0800E003 */  jr         $ra
    /* 644E4 80073CE4 00000000 */   nop
endlabel Anim_DeInitSystem__Fv
