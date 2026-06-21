.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateTransition__27tMenuItemGoToMenuNFS4Buttonb, 0x5C

glabel UpdateTransition__27tMenuItemGoToMenuNFS4Buttonb
    /* AFE0 8001A7E0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* AFE4 8001A7E4 1000BFAF */  sw         $ra, 0x10($sp)
    /* AFE8 8001A7E8 26008294 */  lhu        $v0, 0x26($a0)
    /* AFEC 8001A7EC 28008394 */  lhu        $v1, 0x28($a0)
    /* AFF0 8001A7F0 00000000 */  nop
    /* AFF4 8001A7F4 21104300 */  addu       $v0, $v0, $v1
    /* AFF8 8001A7F8 260082A4 */  sh         $v0, 0x26($a0)
    /* AFFC 8001A7FC 00140200 */  sll        $v0, $v0, 16
    /* B000 8001A800 03140200 */  sra        $v0, $v0, 16
    /* B004 8001A804 03004104 */  bgez       $v0, .L8001A814
    /* B008 8001A808 81004228 */   slti      $v0, $v0, 0x81
    /* B00C 8001A80C 086A0008 */  j          .L8001A820
    /* B010 8001A810 260080A4 */   sh        $zero, 0x26($a0)
  .L8001A814:
    /* B014 8001A814 03004014 */  bnez       $v0, .L8001A824
    /* B018 8001A818 80000224 */   addiu     $v0, $zero, 0x80
    /* B01C 8001A81C 260082A4 */  sh         $v0, 0x26($a0)
  .L8001A820:
    /* B020 8001A820 280080A4 */  sh         $zero, 0x28($a0)
  .L8001A824:
    /* B024 8001A824 EA91000C */  jal        UpdateTransition__9tMenuItemb
    /* B028 8001A828 00000000 */   nop
    /* B02C 8001A82C 1000BF8F */  lw         $ra, 0x10($sp)
    /* B030 8001A830 00000000 */  nop
    /* B034 8001A834 0800E003 */  jr         $ra
    /* B038 8001A838 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel UpdateTransition__27tMenuItemGoToMenuNFS4Buttonb
