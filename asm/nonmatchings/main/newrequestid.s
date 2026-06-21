.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching newrequestid, 0x34

glabel newrequestid
    /* E13C0 800F0BC0 6C19828F */  lw         $v0, %gp_rel(D_8013DEB8)($gp)
    /* E13C4 800F0BC4 00000000 */  nop
    /* E13C8 800F0BC8 00014224 */  addiu      $v0, $v0, 0x100
    /* E13CC 800F0BCC 6C1982AF */  sw         $v0, %gp_rel(D_8013DEB8)($gp)
    /* E13D0 800F0BD0 02004014 */  bnez       $v0, .L800F0BDC
    /* E13D4 800F0BD4 00010224 */   addiu     $v0, $zero, 0x100
    /* E13D8 800F0BD8 6C1982AF */  sw         $v0, %gp_rel(D_8013DEB8)($gp)
  .L800F0BDC:
    /* E13DC 800F0BDC 00008290 */  lbu        $v0, 0x0($a0)
    /* E13E0 800F0BE0 6C19838F */  lw         $v1, %gp_rel(D_8013DEB8)($gp)
    /* E13E4 800F0BE4 00000000 */  nop
    /* E13E8 800F0BE8 25104300 */  or         $v0, $v0, $v1
    /* E13EC 800F0BEC 0800E003 */  jr         $ra
    /* E13F0 800F0BF0 000082AC */   sw        $v0, 0x0($a0)
endlabel newrequestid
