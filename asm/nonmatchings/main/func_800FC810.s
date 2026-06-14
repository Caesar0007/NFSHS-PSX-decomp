.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800FC810, 0x40

glabel func_800FC810
    /* ED010 800FC810 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* ED014 800FC814 1000B0AF */  sw         $s0, 0x10($sp)
    /* ED018 800FC818 2180C000 */  addu       $s0, $a2, $zero
    /* ED01C 800FC81C 1400BFAF */  sw         $ra, 0x14($sp)
    /* ED020 800FC820 A400048E */  lw         $a0, 0xA4($s0)
    /* ED024 800FC824 ACB0030C */  jal        FILE_completeop
    /* ED028 800FC828 00000000 */   nop
    /* ED02C 800FC82C 04004010 */  beqz       $v0, .L800FC840
    /* ED030 800FC830 9C0002AE */   sw        $v0, 0x9C($s0)
    /* ED034 800FC834 3000058E */  lw         $a1, 0x30($s0)
    /* ED038 800FC838 D1F2030C */  jal        func_800FCB44
    /* ED03C 800FC83C 21200002 */   addu      $a0, $s0, $zero
  .L800FC840:
    /* ED040 800FC840 1400BF8F */  lw         $ra, 0x14($sp)
    /* ED044 800FC844 1000B08F */  lw         $s0, 0x10($sp)
    /* ED048 800FC848 0800E003 */  jr         $ra
    /* ED04C 800FC84C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_800FC810
