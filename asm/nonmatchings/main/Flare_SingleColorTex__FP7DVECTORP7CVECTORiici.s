.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Flare_SingleColorTex__FP7DVECTORP7CVECTORiici, 0xA4

glabel Flare_SingleColorTex__FP7DVECTORP7CVECTORiici
    /* BEEF8 800CE6F8 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* BEEFC 800CE6FC 2000BFAF */  sw         $ra, 0x20($sp)
    /* BEF00 800CE700 00008294 */  lhu        $v0, 0x0($a0)
    /* BEF04 800CE704 3800A393 */  lbu        $v1, 0x38($sp)
    /* BEF08 800CE708 23104600 */  subu       $v0, $v0, $a2
    /* BEF0C 800CE70C 1000A2A7 */  sh         $v0, 0x10($sp)
    /* BEF10 800CE710 02008294 */  lhu        $v0, 0x2($a0)
    /* BEF14 800CE714 00000000 */  nop
    /* BEF18 800CE718 21104700 */  addu       $v0, $v0, $a3
    /* BEF1C 800CE71C 1200A2A7 */  sh         $v0, 0x12($sp)
    /* BEF20 800CE720 00008294 */  lhu        $v0, 0x0($a0)
    /* BEF24 800CE724 00000000 */  nop
    /* BEF28 800CE728 21104600 */  addu       $v0, $v0, $a2
    /* BEF2C 800CE72C 1400A2A7 */  sh         $v0, 0x14($sp)
    /* BEF30 800CE730 02008294 */  lhu        $v0, 0x2($a0)
    /* BEF34 800CE734 00000000 */  nop
    /* BEF38 800CE738 21104700 */  addu       $v0, $v0, $a3
    /* BEF3C 800CE73C 1600A2A7 */  sh         $v0, 0x16($sp)
    /* BEF40 800CE740 00008294 */  lhu        $v0, 0x0($a0)
    /* BEF44 800CE744 00000000 */  nop
    /* BEF48 800CE748 23104600 */  subu       $v0, $v0, $a2
    /* BEF4C 800CE74C 1800A2A7 */  sh         $v0, 0x18($sp)
    /* BEF50 800CE750 02008294 */  lhu        $v0, 0x2($a0)
    /* BEF54 800CE754 00000000 */  nop
    /* BEF58 800CE758 23104700 */  subu       $v0, $v0, $a3
    /* BEF5C 800CE75C 1A00A2A7 */  sh         $v0, 0x1A($sp)
    /* BEF60 800CE760 00008294 */  lhu        $v0, 0x0($a0)
    /* BEF64 800CE764 00000000 */  nop
    /* BEF68 800CE768 21104600 */  addu       $v0, $v0, $a2
    /* BEF6C 800CE76C 1C00A2A7 */  sh         $v0, 0x1C($sp)
    /* BEF70 800CE770 02008294 */  lhu        $v0, 0x2($a0)
    /* BEF74 800CE774 1000A427 */  addiu      $a0, $sp, 0x10
    /* BEF78 800CE778 23104700 */  subu       $v0, $v0, $a3
    /* BEF7C 800CE77C 1E00A2A7 */  sh         $v0, 0x1E($sp)
    /* BEF80 800CE780 3C00A78F */  lw         $a3, 0x3C($sp)
    /* BEF84 800CE784 8739030C */  jal        Flare_TextureQuad__FPlP7CVECTORci
    /* BEF88 800CE788 FF006630 */   andi      $a2, $v1, 0xFF
    /* BEF8C 800CE78C 2000BF8F */  lw         $ra, 0x20($sp)
    /* BEF90 800CE790 00000000 */  nop
    /* BEF94 800CE794 0800E003 */  jr         $ra
    /* BEF98 800CE798 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Flare_SingleColorTex__FP7DVECTORP7CVECTORiici
