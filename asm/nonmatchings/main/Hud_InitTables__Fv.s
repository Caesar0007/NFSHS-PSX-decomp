.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_InitTables__Fv, 0x2C

glabel Hud_InitTables__Fv
    /* C41EC 800D39EC 1280033C */  lui        $v1, %hi(Hud_gElementPositions)
    /* C41F0 800D39F0 1180023C */  lui        $v0, %hi(D_801135B4)
    /* C41F4 800D39F4 B435428C */  lw         $v0, %lo(D_801135B4)($v0)
    /* C41F8 800D39F8 00000000 */  nop
    /* C41FC 800D39FC 02004228 */  slti       $v0, $v0, 0x2
    /* C4200 800D3A00 02004014 */  bnez       $v0, .L800D3A0C
    /* C4204 800D3A04 24096324 */   addiu     $v1, $v1, %lo(Hud_gElementPositions)
    /* C4208 800D3A08 4C006324 */  addiu      $v1, $v1, 0x4C
  .L800D3A0C:
    /* C420C 800D3A0C B81883AF */  sw         $v1, %gp_rel(D_8013DE04)($gp)
    /* C4210 800D3A10 0800E003 */  jr         $ra
    /* C4214 800D3A14 00000000 */   nop
endlabel Hud_InitTables__Fv
