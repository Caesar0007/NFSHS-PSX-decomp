.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDgetvol, 0x9C

glabel SNDgetvol
    /* F3010 80102810 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* F3014 80102814 1480023C */  lui        $v0, %hi(sndgs)
    /* F3018 80102818 1400B1AF */  sw         $s1, 0x14($sp)
    /* F301C 8010281C 60785124 */  addiu      $s1, $v0, %lo(sndgs)
    /* F3020 80102820 1800BFAF */  sw         $ra, 0x18($sp)
    /* F3024 80102824 1000B0AF */  sw         $s0, 0x10($sp)
    /* F3028 80102828 3C002282 */  lb         $v0, 0x3C($s1)
    /* F302C 8010282C 00000000 */  nop
    /* F3030 80102830 03004014 */  bnez       $v0, .L80102840
    /* F3034 80102834 21808000 */   addu      $s0, $a0, $zero
    /* F3038 80102838 260A0408 */  j          .L80102898
    /* F303C 8010283C F6FF0224 */   addiu     $v0, $zero, -0xA
  .L80102840:
    /* F3040 80102840 4DA9030C */  jal        iSNDenteraudio
    /* F3044 80102844 00000000 */   nop
    /* F3048 80102848 71FB030C */  jal        iSNDgetchan
    /* F304C 8010284C 21200002 */   addu      $a0, $s0, $zero
    /* F3050 80102850 21804000 */  addu       $s0, $v0, $zero
    /* F3054 80102854 0D000006 */  bltz       $s0, .L8010288C
    /* F3058 80102858 00000000 */   nop
    /* F305C 8010285C 5BA9030C */  jal        iSNDleaveaudio
    /* F3060 80102860 00000000 */   nop
    /* F3064 80102864 40101000 */  sll        $v0, $s0, 1
    /* F3068 80102868 21105000 */  addu       $v0, $v0, $s0
    /* F306C 8010286C C0100200 */  sll        $v0, $v0, 3
    /* F3070 80102870 21105000 */  addu       $v0, $v0, $s0
    /* F3074 80102874 9400238E */  lw         $v1, 0x94($s1)
    /* F3078 80102878 80100200 */  sll        $v0, $v0, 2
    /* F307C 8010287C 21104300 */  addu       $v0, $v0, $v1
    /* F3080 80102880 2D004280 */  lb         $v0, 0x2D($v0)
    /* F3084 80102884 260A0408 */  j          .L80102898
    /* F3088 80102888 00000000 */   nop
  .L8010288C:
    /* F308C 8010288C 5BA9030C */  jal        iSNDleaveaudio
    /* F3090 80102890 00000000 */   nop
    /* F3094 80102894 F8FF0224 */  addiu      $v0, $zero, -0x8
  .L80102898:
    /* F3098 80102898 1800BF8F */  lw         $ra, 0x18($sp)
    /* F309C 8010289C 1400B18F */  lw         $s1, 0x14($sp)
    /* F30A0 801028A0 1000B08F */  lw         $s0, 0x10($sp)
    /* F30A4 801028A4 0800E003 */  jr         $ra
    /* F30A8 801028A8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SNDgetvol
