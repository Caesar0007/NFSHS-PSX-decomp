.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching StatChk_ClearNewRecords__Fv, 0x2C

glabel StatChk_ClearNewRecords__Fv
    /* 3B038 8004A838 07000324 */  addiu      $v1, $zero, 0x7
    /* 3B03C 8004A83C 0580023C */  lui        $v0, %hi(NewRecords)
    /* 3B040 8004A840 78294224 */  addiu      $v0, $v0, %lo(NewRecords)
    /* 3B044 8004A844 1C004224 */  addiu      $v0, $v0, 0x1C
  .L8004A848:
    /* 3B048 8004A848 000040AC */  sw         $zero, 0x0($v0)
    /* 3B04C 8004A84C FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 3B050 8004A850 FDFF6104 */  bgez       $v1, .L8004A848
    /* 3B054 8004A854 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 3B058 8004A858 0580023C */  lui        $v0, %hi(NewBestLap)
    /* 3B05C 8004A85C 0800E003 */  jr         $ra
    /* 3B060 8004A860 982940AC */   sw        $zero, %lo(NewBestLap)($v0)
endlabel StatChk_ClearNewRecords__Fv
    /* 3B064 8004A864 00000000 */  nop
