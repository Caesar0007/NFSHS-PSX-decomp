.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching LocateGroupNum__15SerializedGroupi, 0x44

glabel LocateGroupNum__15SerializedGroupi
    /* 8C9C0 8009C1C0 0C00828C */  lw         $v0, 0xC($a0)
    /* 8C9C4 8009C1C4 00000000 */  nop
    /* 8C9C8 8009C1C8 2A10A200 */  slt        $v0, $a1, $v0
    /* 8C9CC 8009C1CC 03004014 */  bnez       $v0, .L8009C1DC
    /* 8C9D0 8009C1D0 10008424 */   addiu     $a0, $a0, 0x10
    /* 8C9D4 8009C1D4 0800E003 */  jr         $ra
    /* 8C9D8 8009C1D8 21100000 */   addu      $v0, $zero, $zero
  .L8009C1DC:
    /* 8C9DC 8009C1DC 0700A018 */  blez       $a1, .L8009C1FC
    /* 8C9E0 8009C1E0 21180000 */   addu      $v1, $zero, $zero
  .L8009C1E4:
    /* 8C9E4 8009C1E4 0400828C */  lw         $v0, 0x4($a0)
    /* 8C9E8 8009C1E8 01006324 */  addiu      $v1, $v1, 0x1
    /* 8C9EC 8009C1EC 21208200 */  addu       $a0, $a0, $v0
    /* 8C9F0 8009C1F0 2A106500 */  slt        $v0, $v1, $a1
    /* 8C9F4 8009C1F4 FBFF4014 */  bnez       $v0, .L8009C1E4
    /* 8C9F8 8009C1F8 00000000 */   nop
  .L8009C1FC:
    /* 8C9FC 8009C1FC 0800E003 */  jr         $ra
    /* 8CA00 8009C200 21108000 */   addu      $v0, $a0, $zero
endlabel LocateGroupNum__15SerializedGroupi
