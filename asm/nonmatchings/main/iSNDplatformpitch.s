.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDplatformpitch, 0xC4

glabel iSNDplatformpitch
    /* F0794 800FFF94 40100400 */  sll        $v0, $a0, 1
    /* F0798 800FFF98 21104400 */  addu       $v0, $v0, $a0
    /* F079C 800FFF9C 80100200 */  sll        $v0, $v0, 2
    /* F07A0 800FFFA0 23104400 */  subu       $v0, $v0, $a0
    /* F07A4 800FFFA4 80100200 */  sll        $v0, $v0, 2
    /* F07A8 800FFFA8 1480033C */  lui        $v1, %hi(D_801479F0)
    /* F07AC 800FFFAC F0796424 */  addiu      $a0, $v1, %lo(D_801479F0)
    /* F07B0 800FFFB0 21304400 */  addu       $a2, $v0, $a0
    /* F07B4 800FFFB4 1A00C294 */  lhu        $v0, 0x1A($a2)
    /* F07B8 800FFFB8 00000000 */  nop
    /* F07BC 800FFFBC 18004500 */  mult       $v0, $a1
    /* F07C0 800FFFC0 01000524 */  addiu      $a1, $zero, 0x1
    /* F07C4 800FFFC4 12380000 */  mflo       $a3
    /* F07C8 800FFFC8 03130700 */  sra        $v0, $a3, 12
    /* F07CC 800FFFCC C0180200 */  sll        $v1, $v0, 3
    /* F07D0 800FFFD0 23186200 */  subu       $v1, $v1, $v0
    /* F07D4 800FFFD4 80110300 */  sll        $v0, $v1, 6
    /* F07D8 800FFFD8 23104300 */  subu       $v0, $v0, $v1
    /* F07DC 800FFFDC 0800C2AC */  sw         $v0, 0x8($a2)
    /* F07E0 800FFFE0 2800C5A0 */  sb         $a1, 0x28($a2)
    /* F07E4 800FFFE4 1F00C390 */  lbu        $v1, 0x1F($a2)
    /* F07E8 800FFFE8 02000224 */  addiu      $v0, $zero, 0x2
    /* F07EC 800FFFEC 18006214 */  bne        $v1, $v0, .L80100050
    /* F07F0 800FFFF0 00000000 */   nop
    /* F07F4 800FFFF4 2000C390 */  lbu        $v1, 0x20($a2)
    /* F07F8 800FFFF8 28FF8424 */  addiu      $a0, $a0, -0xD8
    /* F07FC 800FFFFC 001E0300 */  sll        $v1, $v1, 24
    /* F0800 80100000 031E0300 */  sra        $v1, $v1, 24
    /* F0804 80100004 40100300 */  sll        $v0, $v1, 1
    /* F0808 80100008 21104300 */  addu       $v0, $v0, $v1
    /* F080C 8010000C 80100200 */  sll        $v0, $v0, 2
    /* F0810 80100010 23104300 */  subu       $v0, $v0, $v1
    /* F0814 80100014 80100200 */  sll        $v0, $v0, 2
    /* F0818 80100018 0800C38C */  lw         $v1, 0x8($a2)
    /* F081C 8010001C 21104400 */  addu       $v0, $v0, $a0
    /* F0820 80100020 E00043AC */  sw         $v1, 0xE0($v0)
    /* F0824 80100024 2000C390 */  lbu        $v1, 0x20($a2)
    /* F0828 80100028 00000000 */  nop
    /* F082C 8010002C 001E0300 */  sll        $v1, $v1, 24
    /* F0830 80100030 031E0300 */  sra        $v1, $v1, 24
    /* F0834 80100034 40100300 */  sll        $v0, $v1, 1
    /* F0838 80100038 21104300 */  addu       $v0, $v0, $v1
    /* F083C 8010003C 80100200 */  sll        $v0, $v0, 2
    /* F0840 80100040 23104300 */  subu       $v0, $v0, $v1
    /* F0844 80100044 80100200 */  sll        $v0, $v0, 2
    /* F0848 80100048 21104400 */  addu       $v0, $v0, $a0
    /* F084C 8010004C 000145A0 */  sb         $a1, 0x100($v0)
  .L80100050:
    /* F0850 80100050 0800E003 */  jr         $ra
    /* F0854 80100054 21100000 */   addu      $v0, $zero, $zero
endlabel iSNDplatformpitch
