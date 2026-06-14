.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Flare_Tri__FPlN20i, 0x9C

glabel Flare_Tri__FPlN20i
    /* BC4B0 800CBCB0 801F0B3C */  lui        $t3, (0x1F800004 >> 16)
    /* BC4B4 800CBCB4 04006B35 */  ori        $t3, $t3, (0x1F800004 & 0xFFFF)
    /* BC4B8 800CBCB8 FF00093C */  lui        $t1, (0xFFFFFF >> 16)
    /* BC4BC 800CBCBC FFFF2935 */  ori        $t1, $t1, (0xFFFFFF & 0xFFFF)
    /* BC4C0 800CBCC0 80380700 */  sll        $a3, $a3, 2
    /* BC4C4 800CBCC4 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* BC4C8 800CBCC8 801F023C */  lui        $v0, (0x1F800000 >> 16)
    /* BC4CC 800CBCCC 0000428C */  lw         $v0, (0x1F800000 & 0xFFFF)($v0)
    /* BC4D0 800CBCD0 0000688D */  lw         $t0, 0x0($t3)
    /* BC4D4 800CBCD4 2138E200 */  addu       $a3, $a3, $v0
    /* BC4D8 800CBCD8 0000038D */  lw         $v1, 0x0($t0)
    /* BC4DC 800CBCDC 0000E28C */  lw         $v0, 0x0($a3)
    /* BC4E0 800CBCE0 24186A00 */  and        $v1, $v1, $t2
    /* BC4E4 800CBCE4 24104900 */  and        $v0, $v0, $t1
    /* BC4E8 800CBCE8 25186200 */  or         $v1, $v1, $v0
    /* BC4EC 800CBCEC 000003AD */  sw         $v1, 0x0($t0)
    /* BC4F0 800CBCF0 1C000325 */  addiu      $v1, $t0, 0x1C
    /* BC4F4 800CBCF4 0000E28C */  lw         $v0, 0x0($a3)
    /* BC4F8 800CBCF8 24480901 */  and        $t1, $t0, $t1
    /* BC4FC 800CBCFC 000063AD */  sw         $v1, 0x0($t3)
    /* BC500 800CBD00 24104A00 */  and        $v0, $v0, $t2
    /* BC504 800CBD04 25104900 */  or         $v0, $v0, $t1
    /* BC508 800CBD08 0000E2AC */  sw         $v0, 0x0($a3)
    /* BC50C 800CBD0C 0032023C */  lui        $v0, (0x32000000 >> 16)
    /* BC510 800CBD10 040002AD */  sw         $v0, 0x4($t0)
    /* BC514 800CBD14 2013838F */  lw         $v1, %gp_rel(gfrgb)($gp)
    /* BC518 800CBD18 06000224 */  addiu      $v0, $zero, 0x6
    /* BC51C 800CBD1C 140000AD */  sw         $zero, 0x14($t0)
    /* BC520 800CBD20 030002A1 */  sb         $v0, 0x3($t0)
    /* BC524 800CBD24 0C0003AD */  sw         $v1, 0xC($t0)
    /* BC528 800CBD28 0000C28C */  lw         $v0, 0x0($a2)
    /* BC52C 800CBD2C 00000000 */  nop
    /* BC530 800CBD30 080002AD */  sw         $v0, 0x8($t0)
    /* BC534 800CBD34 0000828C */  lw         $v0, 0x0($a0)
    /* BC538 800CBD38 00000000 */  nop
    /* BC53C 800CBD3C 100002AD */  sw         $v0, 0x10($t0)
    /* BC540 800CBD40 0000A28C */  lw         $v0, 0x0($a1)
    /* BC544 800CBD44 0800E003 */  jr         $ra
    /* BC548 800CBD48 180002AD */   sw        $v0, 0x18($t0)
endlabel Flare_Tri__FPlN20i
