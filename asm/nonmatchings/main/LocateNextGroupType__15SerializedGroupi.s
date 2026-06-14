.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching LocateNextGroupType__15SerializedGroupi, 0x28

glabel LocateNextGroupType__15SerializedGroupi
    /* 8C928 8009C128 0400828C */  lw         $v0, 0x4($a0)
    /* 8C92C 8009C12C 00000000 */  nop
    /* 8C930 8009C130 21208200 */  addu       $a0, $a0, $v0
    /* 8C934 8009C134 0000838C */  lw         $v1, 0x0($a0)
    /* 8C938 8009C138 00000000 */  nop
    /* 8C93C 8009C13C 02006514 */  bne        $v1, $a1, .L8009C148
    /* 8C940 8009C140 21100000 */   addu      $v0, $zero, $zero
    /* 8C944 8009C144 21108000 */  addu       $v0, $a0, $zero
  .L8009C148:
    /* 8C948 8009C148 0800E003 */  jr         $ra
    /* 8C94C 8009C14C 00000000 */   nop
endlabel LocateNextGroupType__15SerializedGroupi
