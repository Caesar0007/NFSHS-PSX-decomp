.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800B75F8, 0x54

glabel func_800B75F8
    /* A7DF8 800B75F8 03008010 */  beqz       $a0, .L800B7608
    /* A7DFC 800B75FC 1180023C */   lui       $v0, %hi(D_801131F8)
    /* A7E00 800B7600 0800E003 */  jr         $ra
    /* A7E04 800B7604 21100000 */   addu      $v0, $zero, $zero
  .L800B7608:
    /* A7E08 800B7608 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* A7E0C 800B760C 00000000 */  nop
    /* A7E10 800B7610 04006010 */  beqz       $v1, .L800B7624
    /* A7E14 800B7614 1480023C */   lui       $v0, %hi(D_8013E0F4)
    /* A7E18 800B7618 01000224 */  addiu      $v0, $zero, 0x1
    /* A7E1C 800B761C 09006214 */  bne        $v1, $v0, .L800B7644
    /* A7E20 800B7620 1480023C */   lui       $v0, %hi(D_8013E0F4)
  .L800B7624:
    /* A7E24 800B7624 F4E04224 */  addiu      $v0, $v0, %lo(D_8013E0F4)
    /* A7E28 800B7628 0002438C */  lw         $v1, 0x200($v0)
    /* A7E2C 800B762C 8418848F */  lw         $a0, %gp_rel(D_8013DDD0)($gp)
    /* A7E30 800B7630 0402428C */  lw         $v0, 0x204($v0)
    /* A7E34 800B7634 21186400 */  addu       $v1, $v1, $a0
    /* A7E38 800B7638 2A104300 */  slt        $v0, $v0, $v1
    /* A7E3C 800B763C 0800E003 */  jr         $ra
    /* A7E40 800B7640 01004238 */   xori      $v0, $v0, 0x1
  .L800B7644:
    /* A7E44 800B7644 0800E003 */  jr         $ra
    /* A7E48 800B7648 21100000 */   addu      $v0, $zero, $zero
endlabel func_800B75F8
