.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDplatformpacketoverhead, 0x34

glabel iSNDplatformpacketoverhead
    /* F49B8 801041B8 1280023C */  lui        $v0, %hi(D_801234E4)
    /* F49BC 801041BC E434428C */  lw         $v0, %lo(D_801234E4)($v0)
    /* F49C0 801041C0 00000000 */  nop
    /* F49C4 801041C4 02004104 */  bgez       $v0, .L801041D0
    /* F49C8 801041C8 00000000 */   nop
    /* F49CC 801041CC FF0F4224 */  addiu      $v0, $v0, 0xFFF
  .L801041D0:
    /* F49D0 801041D0 03130200 */  sra        $v0, $v0, 12
    /* F49D4 801041D4 03004224 */  addiu      $v0, $v0, 0x3
    /* F49D8 801041D8 FCFF0324 */  addiu      $v1, $zero, -0x4
    /* F49DC 801041DC 24104300 */  and        $v0, $v0, $v1
    /* F49E0 801041E0 40100200 */  sll        $v0, $v0, 1
    /* F49E4 801041E4 0800E003 */  jr         $ra
    /* F49E8 801041E8 50104224 */   addiu     $v0, $v0, 0x1050
endlabel iSNDplatformpacketoverhead
