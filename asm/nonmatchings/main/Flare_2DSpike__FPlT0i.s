.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Flare_2DSpike__FPlT0i, 0xAC

glabel Flare_2DSpike__FPlT0i
    /* BE6C4 800CDEC4 F8FFBD27 */  addiu      $sp, $sp, -0x8
    /* BE6C8 800CDEC8 801F083C */  lui        $t0, (0x1F800004 >> 16)
    /* BE6CC 800CDECC 04000835 */  ori        $t0, $t0, (0x1F800004 & 0xFFFF)
    /* BE6D0 800CDED0 FF00073C */  lui        $a3, (0xFFFFFF >> 16)
    /* BE6D4 800CDED4 FFFFE734 */  ori        $a3, $a3, (0xFFFFFF & 0xFFFF)
    /* BE6D8 800CDED8 0000828C */  lw         $v0, 0x0($a0)
    /* BE6DC 800CDEDC 80300600 */  sll        $a2, $a2, 2
    /* BE6E0 800CDEE0 0000A2AF */  sw         $v0, 0x0($sp)
    /* BE6E4 800CDEE4 0000A28C */  lw         $v0, 0x0($a1)
    /* BE6E8 800CDEE8 00FF053C */  lui        $a1, (0xFF000000 >> 16)
    /* BE6EC 800CDEEC 0400A2AF */  sw         $v0, 0x4($sp)
    /* BE6F0 800CDEF0 801F023C */  lui        $v0, (0x1F800000 >> 16)
    /* BE6F4 800CDEF4 0000428C */  lw         $v0, (0x1F800000 & 0xFFFF)($v0)
    /* BE6F8 800CDEF8 0000048D */  lw         $a0, 0x0($t0)
    /* BE6FC 800CDEFC 2130C200 */  addu       $a2, $a2, $v0
    /* BE700 800CDF00 0000838C */  lw         $v1, 0x0($a0)
    /* BE704 800CDF04 0000C28C */  lw         $v0, 0x0($a2)
    /* BE708 800CDF08 24186500 */  and        $v1, $v1, $a1
    /* BE70C 800CDF0C 24104700 */  and        $v0, $v0, $a3
    /* BE710 800CDF10 25186200 */  or         $v1, $v1, $v0
    /* BE714 800CDF14 000083AC */  sw         $v1, 0x0($a0)
    /* BE718 800CDF18 0000C28C */  lw         $v0, 0x0($a2)
    /* BE71C 800CDF1C 24388700 */  and        $a3, $a0, $a3
    /* BE720 800CDF20 24104500 */  and        $v0, $v0, $a1
    /* BE724 800CDF24 25104700 */  or         $v0, $v0, $a3
    /* BE728 800CDF28 0000C2AC */  sw         $v0, 0x0($a2)
    /* BE72C 800CDF2C 2413838F */  lw         $v1, %gp_rel(gfrgb2)($gp)
    /* BE730 800CDF30 14008224 */  addiu      $v0, $a0, 0x14
    /* BE734 800CDF34 000002AD */  sw         $v0, 0x0($t0)
    /* BE738 800CDF38 04000224 */  addiu      $v0, $zero, 0x4
    /* BE73C 800CDF3C 030082A0 */  sb         $v0, 0x3($a0)
    /* BE740 800CDF40 52000224 */  addiu      $v0, $zero, 0x52
    /* BE744 800CDF44 0C0080AC */  sw         $zero, 0xC($a0)
    /* BE748 800CDF48 040083AC */  sw         $v1, 0x4($a0)
    /* BE74C 800CDF4C 070082A0 */  sb         $v0, 0x7($a0)
    /* BE750 800CDF50 0000A28F */  lw         $v0, 0x0($sp)
    /* BE754 800CDF54 00000000 */  nop
    /* BE758 800CDF58 080082AC */  sw         $v0, 0x8($a0)
    /* BE75C 800CDF5C 0400A28F */  lw         $v0, 0x4($sp)
    /* BE760 800CDF60 00000000 */  nop
    /* BE764 800CDF64 100082AC */  sw         $v0, 0x10($a0)
    /* BE768 800CDF68 0800E003 */  jr         $ra
    /* BE76C 800CDF6C 0800BD27 */   addiu     $sp, $sp, 0x8
endlabel Flare_2DSpike__FPlT0i
