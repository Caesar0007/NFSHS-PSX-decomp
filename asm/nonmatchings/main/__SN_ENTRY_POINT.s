.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __SN_ENTRY_POINT, 0x24

glabel __SN_ENTRY_POINT
    /* D482C 800E402C 1480023C */  lui        $v0, %hi(_bss_obj)
    /* D4830 800E4030 7CDD4224 */  addiu      $v0, $v0, %lo(_bss_obj)
    /* D4834 800E4034 1580033C */  lui        $v1, %hi(__last_org)
    /* D4838 800E4038 048B6324 */  addiu      $v1, $v1, %lo(__last_org)
  .L800E403C:
    /* D483C 800E403C 000040AC */  sw         $zero, 0x0($v0)
    /* D4840 800E4040 04004224 */  addiu      $v0, $v0, 0x4
    /* D4844 800E4044 2B084300 */  sltu       $at, $v0, $v1
    /* D4848 800E4048 FCFF2014 */  bnez       $at, .L800E403C
    /* D484C 800E404C 00000000 */   nop
endlabel __SN_ENTRY_POINT
