.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Flare_TextureQuad__FPlP7CVECTORci, 0xDC

glabel Flare_TextureQuad__FPlP7CVECTORci
    /* BEE1C 800CE61C 801F0B3C */  lui        $t3, (0x1F800004 >> 16)
    /* BEE20 800CE620 04006B35 */  ori        $t3, $t3, (0x1F800004 & 0xFFFF)
    /* BEE24 800CE624 FF00093C */  lui        $t1, (0xFFFFFF >> 16)
    /* BEE28 800CE628 FFFF2935 */  ori        $t1, $t1, (0xFFFFFF & 0xFFFF)
    /* BEE2C 800CE62C 80380700 */  sll        $a3, $a3, 2
    /* BEE30 800CE630 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* BEE34 800CE634 801F023C */  lui        $v0, (0x1F800000 >> 16)
    /* BEE38 800CE638 0000428C */  lw         $v0, (0x1F800000 & 0xFFFF)($v0)
    /* BEE3C 800CE63C 0000688D */  lw         $t0, 0x0($t3)
    /* BEE40 800CE640 2138E200 */  addu       $a3, $a3, $v0
    /* BEE44 800CE644 0000038D */  lw         $v1, 0x0($t0)
    /* BEE48 800CE648 0000E28C */  lw         $v0, 0x0($a3)
    /* BEE4C 800CE64C 24186A00 */  and        $v1, $v1, $t2
    /* BEE50 800CE650 24104900 */  and        $v0, $v0, $t1
    /* BEE54 800CE654 25186200 */  or         $v1, $v1, $v0
    /* BEE58 800CE658 000003AD */  sw         $v1, 0x0($t0)
    /* BEE5C 800CE65C 28000325 */  addiu      $v1, $t0, 0x28
    /* BEE60 800CE660 0000E28C */  lw         $v0, 0x0($a3)
    /* BEE64 800CE664 24480901 */  and        $t1, $t0, $t1
    /* BEE68 800CE668 000063AD */  sw         $v1, 0x0($t3)
    /* BEE6C 800CE66C 24104A00 */  and        $v0, $v0, $t2
    /* BEE70 800CE670 25104900 */  or         $v0, $v0, $t1
    /* BEE74 800CE674 0000E2AC */  sw         $v0, 0x0($a3)
    /* BEE78 800CE678 0000A38C */  lw         $v1, 0x0($a1)
    /* BEE7C 800CE67C 09000224 */  addiu      $v0, $zero, 0x9
    /* BEE80 800CE680 030002A1 */  sb         $v0, 0x3($t0)
    /* BEE84 800CE684 2E000224 */  addiu      $v0, $zero, 0x2E
    /* BEE88 800CE688 040003AD */  sw         $v1, 0x4($t0)
    /* BEE8C 800CE68C 070002A1 */  sb         $v0, 0x7($t0)
    /* BEE90 800CE690 0000828C */  lw         $v0, 0x0($a0)
    /* BEE94 800CE694 00000000 */  nop
    /* BEE98 800CE698 080002AD */  sw         $v0, 0x8($t0)
    /* BEE9C 800CE69C 0400828C */  lw         $v0, 0x4($a0)
    /* BEEA0 800CE6A0 00000000 */  nop
    /* BEEA4 800CE6A4 100002AD */  sw         $v0, 0x10($t0)
    /* BEEA8 800CE6A8 0800828C */  lw         $v0, 0x8($a0)
    /* BEEAC 800CE6AC FF00C630 */  andi       $a2, $a2, 0xFF
    /* BEEB0 800CE6B0 180002AD */  sw         $v0, 0x18($t0)
    /* BEEB4 800CE6B4 0C00828C */  lw         $v0, 0xC($a0)
    /* BEEB8 800CE6B8 80300600 */  sll        $a2, $a2, 2
    /* BEEBC 800CE6BC 200002AD */  sw         $v0, 0x20($t0)
    /* BEEC0 800CE6C0 1180023C */  lui        $v0, %hi(gFlarePixmap)
    /* BEEC4 800CE6C4 882B4224 */  addiu      $v0, $v0, %lo(gFlarePixmap)
    /* BEEC8 800CE6C8 2130C200 */  addu       $a2, $a2, $v0
    /* BEECC 800CE6CC 0000C28C */  lw         $v0, 0x0($a2)
    /* BEED0 800CE6D0 00000000 */  nop
    /* BEED4 800CE6D4 0000438C */  lw         $v1, 0x0($v0)
    /* BEED8 800CE6D8 0400448C */  lw         $a0, 0x4($v0)
    /* BEEDC 800CE6DC 0800458C */  lw         $a1, 0x8($v0)
    /* BEEE0 800CE6E0 0C00428C */  lw         $v0, 0xC($v0)
    /* BEEE4 800CE6E4 0C0003AD */  sw         $v1, 0xC($t0)
    /* BEEE8 800CE6E8 140004AD */  sw         $a0, 0x14($t0)
    /* BEEEC 800CE6EC 1C0005AD */  sw         $a1, 0x1C($t0)
    /* BEEF0 800CE6F0 0800E003 */  jr         $ra
    /* BEEF4 800CE6F4 240002AD */   sw        $v0, 0x24($t0)
endlabel Flare_TextureQuad__FPlP7CVECTORci
