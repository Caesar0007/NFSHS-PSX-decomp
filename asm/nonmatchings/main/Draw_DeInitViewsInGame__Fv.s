.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw_DeInitViewsInGame__Fv, 0x34

glabel Draw_DeInitViewsInGame__Fv
    /* AE568 800BDD68 21200000 */  addu       $a0, $zero, $zero
    /* AE56C 800BDD6C 6012858F */  lw         $a1, %gp_rel(Draw_gNumView)($gp)
    /* AE570 800BDD70 1280023C */  lui        $v0, %hi(Draw_gView)
    /* AE574 800BDD74 54EC4324 */  addiu      $v1, $v0, %lo(Draw_gView)
  .L800BDD78:
    /* AE578 800BDD78 2A108500 */  slt        $v0, $a0, $a1
    /* AE57C 800BDD7C 05004010 */  beqz       $v0, .L800BDD94
    /* AE580 800BDD80 01008424 */   addiu     $a0, $a0, 0x1
    /* AE584 800BDD84 C00060AC */  sw         $zero, 0xC0($v1)
    /* AE588 800BDD88 C40060AC */  sw         $zero, 0xC4($v1)
    /* AE58C 800BDD8C 5EF70208 */  j          .L800BDD78
    /* AE590 800BDD90 C8006324 */   addiu     $v1, $v1, 0xC8
  .L800BDD94:
    /* AE594 800BDD94 0800E003 */  jr         $ra
    /* AE598 800BDD98 00000000 */   nop
endlabel Draw_DeInitViewsInGame__Fv
