.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw_SetViewColor__Fiiii, 0x60

glabel Draw_SetViewColor__Fiiii
    /* AE600 800BDE00 40100400 */  sll        $v0, $a0, 1
    /* AE604 800BDE04 21104400 */  addu       $v0, $v0, $a0
    /* AE608 800BDE08 C0100200 */  sll        $v0, $v0, 3
    /* AE60C 800BDE0C 21104400 */  addu       $v0, $v0, $a0
    /* AE610 800BDE10 C0100200 */  sll        $v0, $v0, 3
    /* AE614 800BDE14 1280033C */  lui        $v1, %hi(Draw_gView)
    /* AE618 800BDE18 54EC6324 */  addiu      $v1, $v1, %lo(Draw_gView)
    /* AE61C 800BDE1C 21184300 */  addu       $v1, $v0, $v1
    /* AE620 800BDE20 20006290 */  lbu        $v0, 0x20($v1)
    /* AE624 800BDE24 00000000 */  nop
    /* AE628 800BDE28 04004010 */  beqz       $v0, .L800BDE3C
    /* AE62C 800BDE2C 00000000 */   nop
    /* AE630 800BDE30 210065A0 */  sb         $a1, 0x21($v1)
    /* AE634 800BDE34 220066A0 */  sb         $a2, 0x22($v1)
    /* AE638 800BDE38 230067A0 */  sb         $a3, 0x23($v1)
  .L800BDE3C:
    /* AE63C 800BDE3C 7C006290 */  lbu        $v0, 0x7C($v1)
    /* AE640 800BDE40 00000000 */  nop
    /* AE644 800BDE44 04004010 */  beqz       $v0, .L800BDE58
    /* AE648 800BDE48 00000000 */   nop
    /* AE64C 800BDE4C 7D0065A0 */  sb         $a1, 0x7D($v1)
    /* AE650 800BDE50 7E0066A0 */  sb         $a2, 0x7E($v1)
    /* AE654 800BDE54 7F0067A0 */  sb         $a3, 0x7F($v1)
  .L800BDE58:
    /* AE658 800BDE58 0800E003 */  jr         $ra
    /* AE65C 800BDE5C 00000000 */   nop
endlabel Draw_SetViewColor__Fiiii
