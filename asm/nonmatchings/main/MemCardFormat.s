.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MemCardFormat, 0x8C

glabel MemCardFormat
    /* EC7DC 800FBFDC A8FFBD27 */  addiu      $sp, $sp, -0x58
    /* EC7E0 800FBFE0 1480033C */  lui        $v1, %hi(D_80147518)
    /* EC7E4 800FBFE4 18756324 */  addiu      $v1, $v1, %lo(D_80147518)
    /* EC7E8 800FBFE8 5000BFAF */  sw         $ra, 0x50($sp)
    /* EC7EC 800FBFEC 0000628C */  lw         $v0, 0x0($v1)
    /* EC7F0 800FBFF0 00000000 */  nop
    /* EC7F4 800FBFF4 14004014 */  bnez       $v0, .L800FC048
    /* EC7F8 800FBFF8 01000224 */   addiu     $v0, $zero, 0x1
    /* EC7FC 800FBFFC 0C00658C */  lw         $a1, 0xC($v1)
    /* EC800 800FC000 1480033C */  lui        $v1, %hi(D_80147514)
    /* EC804 800FC004 1475638C */  lw         $v1, %lo(D_80147514)($v1)
    /* EC808 800FC008 0410A200 */  sllv       $v0, $v0, $a1
    /* EC80C 800FC00C 25186200 */  or         $v1, $v1, $v0
    /* EC810 800FC010 1000A527 */  addiu      $a1, $sp, 0x10
    /* EC814 800FC014 1480013C */  lui        $at, %hi(D_80147514)
    /* EC818 800FC018 7DF0030C */  jal        func_800FC1F4
    /* EC81C 800FC01C 147523AC */   sw        $v1, %lo(D_80147514)($at)
    /* EC820 800FC020 3426040C */  jal        _clr_card_event
    /* EC824 800FC024 00000000 */   nop
    /* EC828 800FC028 2028040C */  jal        format
    /* EC82C 800FC02C 1000A427 */   addiu     $a0, $sp, 0x10
    /* EC830 800FC030 AC26040C */  jal        _get_card_event_x
    /* EC834 800FC034 00000000 */   nop
    /* EC838 800FC038 47F0030C */  jal        func_800FC11C
    /* EC83C 800FC03C 21204000 */   addu      $a0, $v0, $zero
    /* EC840 800FC040 16F00308 */  j          .L800FC058
    /* EC844 800FC044 00000000 */   nop
  .L800FC048:
    /* EC848 800FC048 0580043C */  lui        $a0, %hi(D_800574C0)
    /* EC84C 800FC04C 2B0A040C */  jal        printf
    /* EC850 800FC050 C0748424 */   addiu     $a0, $a0, %lo(D_800574C0)
    /* EC854 800FC054 FFFF0224 */  addiu      $v0, $zero, -0x1
  .L800FC058:
    /* EC858 800FC058 5000BF8F */  lw         $ra, 0x50($sp)
    /* EC85C 800FC05C 5800BD27 */  addiu      $sp, $sp, 0x58
    /* EC860 800FC060 0800E003 */  jr         $ra
    /* EC864 800FC064 00000000 */   nop
endlabel MemCardFormat
