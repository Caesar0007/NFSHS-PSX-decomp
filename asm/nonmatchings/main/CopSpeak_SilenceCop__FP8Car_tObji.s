.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopSpeak_SilenceCop__FP8Car_tObji, 0x64

glabel CopSpeak_SilenceCop__FP8Car_tObji
    /* 89E20 80099620 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 89E24 80099624 0B008010 */  beqz       $a0, .L80099654
    /* 89E28 80099628 1000BFAF */   sw        $ra, 0x10($sp)
    /* 89E2C 8009962C 1180033C */  lui        $v1, %hi(CopSpeak_gCurrent)
    /* 89E30 80099630 041F6224 */  addiu      $v0, $v1, %lo(CopSpeak_gCurrent)
    /* 89E34 80099634 1C004290 */  lbu        $v0, 0x1C($v0)
    /* 89E38 80099638 00000000 */  nop
    /* 89E3C 8009963C 0D004514 */  bne        $v0, $a1, .L80099674
    /* 89E40 80099640 00000000 */   nop
    /* 89E44 80099644 041F628C */  lw         $v0, %lo(CopSpeak_gCurrent)($v1)
    /* 89E48 80099648 00000000 */  nop
    /* 89E4C 8009964C 09008214 */  bne        $a0, $v0, .L80099674
    /* 89E50 80099650 00000000 */   nop
  .L80099654:
    /* 89E54 80099654 840B848F */  lw         $a0, %gp_rel(CopSpeak_gSpchHandle)($gp)
    /* 89E58 80099658 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 89E5C 8009965C 03008210 */  beq        $a0, $v0, .L8009966C
    /* 89E60 80099660 00000000 */   nop
    /* 89E64 80099664 A59A030C */  jal        SNDvol
    /* 89E68 80099668 21280000 */   addu      $a1, $zero, $zero
  .L8009966C:
    /* 89E6C 8009966C 6265020C */  jal        CopSpeak_RadioStaticSquelch__Fv
    /* 89E70 80099670 00000000 */   nop
  .L80099674:
    /* 89E74 80099674 1000BF8F */  lw         $ra, 0x10($sp)
    /* 89E78 80099678 00000000 */  nop
    /* 89E7C 8009967C 0800E003 */  jr         $ra
    /* 89E80 80099680 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CopSpeak_SilenceCop__FP8Car_tObji
