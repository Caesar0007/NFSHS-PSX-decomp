.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_801065F8, 0x2C

glabel func_801065F8
    /* F6DF8 801065F8 1380023C */  lui        $v0, %hi(D_80137CF0)
    /* F6DFC 801065FC F07C4224 */  addiu      $v0, $v0, %lo(D_80137CF0)
    /* F6E00 80106600 80200400 */  sll        $a0, $a0, 2
    /* F6E04 80106604 21208200 */  addu       $a0, $a0, $v0
    /* F6E08 80106608 0000828C */  lw         $v0, 0x0($a0)
    /* F6E0C 8010660C 00000000 */  nop
    /* F6E10 80106610 0200A210 */  beq        $a1, $v0, .L8010661C
    /* F6E14 80106614 00000000 */   nop
    /* F6E18 80106618 000085AC */  sw         $a1, 0x0($a0)
  .L8010661C:
    /* F6E1C 8010661C 0800E003 */  jr         $ra
    /* F6E20 80106620 00000000 */   nop
endlabel func_801065F8
