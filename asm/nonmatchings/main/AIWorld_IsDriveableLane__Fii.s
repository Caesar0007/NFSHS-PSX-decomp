.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIWorld_IsDriveableLane__Fii, 0x54

glabel AIWorld_IsDriveableLane__Fii
    /* 63BA8 800733A8 07000224 */  addiu      $v0, $zero, 0x7
    /* 63BAC 800733AC 23104500 */  subu       $v0, $v0, $a1
    /* 63BB0 800733B0 08000324 */  addiu      $v1, $zero, 0x8
    /* 63BB4 800733B4 23186200 */  subu       $v1, $v1, $v0
    /* 63BB8 800733B8 02006104 */  bgez       $v1, .L800733C4
    /* 63BBC 800733BC 21308000 */   addu      $a2, $a0, $zero
    /* 63BC0 800733C0 21180000 */  addu       $v1, $zero, $zero
  .L800733C4:
    /* 63BC4 800733C4 10006228 */  slti       $v0, $v1, 0x10
    /* 63BC8 800733C8 02004014 */  bnez       $v0, .L800733D4
    /* 63BCC 800733CC 0F000424 */   addiu     $a0, $zero, 0xF
    /* 63BD0 800733D0 0F000324 */  addiu      $v1, $zero, 0xF
  .L800733D4:
    /* 63BD4 800733D4 23208300 */  subu       $a0, $a0, $v1
    /* 63BD8 800733D8 01000224 */  addiu      $v0, $zero, 0x1
    /* 63BDC 800733DC 1480053C */  lui        $a1, %hi(BWorldSm_slices)
    /* 63BE0 800733E0 C0C7A58C */  lw         $a1, %lo(BWorldSm_slices)($a1)
    /* 63BE4 800733E4 40190600 */  sll        $v1, $a2, 5
    /* 63BE8 800733E8 21186500 */  addu       $v1, $v1, $a1
    /* 63BEC 800733EC 16006384 */  lh         $v1, 0x16($v1)
    /* 63BF0 800733F0 04108200 */  sllv       $v0, $v0, $a0
    /* 63BF4 800733F4 0800E003 */  jr         $ra
    /* 63BF8 800733F8 24106200 */   and       $v0, $v1, $v0
endlabel AIWorld_IsDriveableLane__Fii
