.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching initlinkmode, 0xEC

glabel initlinkmode
    /* E0DF4 800F05F4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* E0DF8 800F05F8 1000B0AF */  sw         $s0, 0x10($sp)
    /* E0DFC 800F05FC 2180A000 */  addu       $s0, $a1, $zero
    /* E0E00 800F0600 1400B1AF */  sw         $s1, 0x14($sp)
    /* E0E04 800F0604 B817848F */  lw         $a0, %gp_rel(otbuf)($gp)
    /* E0E08 800F0608 10000224 */  addiu      $v0, $zero, 0x10
    /* E0E0C 800F060C 1800BFAF */  sw         $ra, 0x18($sp)
    /* E0E10 800F0610 301982AF */  sw         $v0, %gp_rel(maxot)($gp)
    /* E0E14 800F0614 401990AF */  sw         $s0, %gp_rel(maxprim)($gp)
    /* E0E18 800F0618 03008010 */  beqz       $a0, .L800F0628
    /* E0E1C 800F061C 2188C000 */   addu      $s1, $a2, $zero
    /* E0E20 800F0620 5095030C */  jal        purgememadr
    /* E0E24 800F0624 00000000 */   nop
  .L800F0628:
    /* E0E28 800F0628 0580043C */  lui        $a0, %hi(D_80056F18)
    /* E0E2C 800F062C 186F8424 */  addiu      $a0, $a0, %lo(D_80056F18)
    /* E0E30 800F0630 10000624 */  addiu      $a2, $zero, 0x10
    /* E0E34 800F0634 4019828F */  lw         $v0, %gp_rel(maxprim)($gp)
    /* E0E38 800F0638 3019838F */  lw         $v1, %gp_rel(maxot)($gp)
    /* E0E3C 800F063C 40280200 */  sll        $a1, $v0, 1
    /* E0E40 800F0640 2128A200 */  addu       $a1, $a1, $v0
    /* E0E44 800F0644 80280500 */  sll        $a1, $a1, 2
    /* E0E48 800F0648 2128A200 */  addu       $a1, $a1, $v0
    /* E0E4C 800F064C 2128A300 */  addu       $a1, $a1, $v1
    /* E0E50 800F0650 CF94030C */  jal        reservememadr
    /* E0E54 800F0654 C0280500 */   sll       $a1, $a1, 3
    /* E0E58 800F0658 3019858F */  lw         $a1, %gp_rel(maxot)($gp)
    /* E0E5C 800F065C 21204000 */  addu       $a0, $v0, $zero
    /* E0E60 800F0660 B81784AF */  sw         $a0, %gp_rel(otbuf)($gp)
    /* E0E64 800F0664 241984AF */  sw         $a0, %gp_rel(otbl)($gp)
    /* E0E68 800F0668 C0100500 */  sll        $v0, $a1, 3
    /* E0E6C 800F066C 21188200 */  addu       $v1, $a0, $v0
    /* E0E70 800F0670 80100500 */  sll        $v0, $a1, 2
    /* E0E74 800F0674 21108200 */  addu       $v0, $a0, $v0
    /* E0E78 800F0678 281982AF */  sw         $v0, %gp_rel(D_8013DE74)($gp)
    /* E0E7C 800F067C 40101000 */  sll        $v0, $s0, 1
    /* E0E80 800F0680 21105000 */  addu       $v0, $v0, $s0
    /* E0E84 800F0684 80100200 */  sll        $v0, $v0, 2
    /* E0E88 800F0688 21105000 */  addu       $v0, $v0, $s0
    /* E0E8C 800F068C 80100200 */  sll        $v0, $v0, 2
    /* E0E90 800F0690 BC1783AF */  sw         $v1, %gp_rel(primbuf)($gp)
    /* E0E94 800F0694 381983AF */  sw         $v1, %gp_rel(primbase)($gp)
    /* E0E98 800F0698 21186200 */  addu       $v1, $v1, $v0
    /* E0E9C 800F069C 3C1983AF */  sw         $v1, %gp_rel(D_8013DE88)($gp)
    /* E0EA0 800F06A0 02B7030C */  jal        ClearOTagR
    /* E0EA4 800F06A4 00000000 */   nop
    /* E0EA8 800F06A8 B817828F */  lw         $v0, %gp_rel(otbuf)($gp)
    /* E0EAC 800F06AC BC17838F */  lw         $v1, %gp_rel(primbuf)($gp)
    /* E0EB0 800F06B0 2419848F */  lw         $a0, %gp_rel(otbl)($gp)
    /* E0EB4 800F06B4 1800BF8F */  lw         $ra, 0x18($sp)
    /* E0EB8 800F06B8 C01791AF */  sw         $s1, %gp_rel(linkmodeflag)($gp)
    /* E0EBC 800F06BC 1400B18F */  lw         $s1, 0x14($sp)
    /* E0EC0 800F06C0 1000B08F */  lw         $s0, 0x10($sp)
    /* E0EC4 800F06C4 1C1980AF */  sw         $zero, %gp_rel(oti)($gp)
    /* E0EC8 800F06C8 201980AF */  sw         $zero, %gp_rel(otp)($gp)
    /* E0ECC 800F06CC C41780AF */  sw         $zero, %gp_rel(drawpending)($gp)
    /* E0ED0 800F06D0 341983AF */  sw         $v1, %gp_rel(primptr)($gp)
    /* E0ED4 800F06D4 2C1984AF */  sw         $a0, %gp_rel(nextprim)($gp)
    /* E0ED8 800F06D8 0800E003 */  jr         $ra
    /* E0EDC 800F06DC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel initlinkmode
