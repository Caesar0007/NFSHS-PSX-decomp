.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDdivu64, 0x48

glabel iSNDdivu64
    /* F3CC0 801034C0 21180000 */  addu       $v1, $zero, $zero
    /* F3CC4 801034C4 20000724 */  addiu      $a3, $zero, 0x20
    /* F3CC8 801034C8 0000A4AF */  sw         $a0, 0x0($sp)
    /* F3CCC 801034CC 0400A5AF */  sw         $a1, 0x4($sp)
    /* F3CD0 801034D0 FFFFE724 */  addiu      $a3, $a3, -0x1
  .L801034D4:
    /* F3CD4 801034D4 40180300 */  sll        $v1, $v1, 1
    /* F3CD8 801034D8 40280500 */  sll        $a1, $a1, 1
    /* F3CDC 801034DC C2170400 */  srl        $v0, $a0, 31
    /* F3CE0 801034E0 2128A200 */  addu       $a1, $a1, $v0
    /* F3CE4 801034E4 2B10A600 */  sltu       $v0, $a1, $a2
    /* F3CE8 801034E8 03004014 */  bnez       $v0, .L801034F8
    /* F3CEC 801034EC 40200400 */   sll       $a0, $a0, 1
    /* F3CF0 801034F0 2328A600 */  subu       $a1, $a1, $a2
    /* F3CF4 801034F4 01006324 */  addiu      $v1, $v1, 0x1
  .L801034F8:
    /* F3CF8 801034F8 F6FFE014 */  bnez       $a3, .L801034D4
    /* F3CFC 801034FC FFFFE724 */   addiu     $a3, $a3, -0x1
    /* F3D00 80103500 0800E003 */  jr         $ra
    /* F3D04 80103504 21106000 */   addu      $v0, $v1, $zero
endlabel iSNDdivu64
