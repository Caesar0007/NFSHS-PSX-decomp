.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioClc_CalcCarDirection__FP17DRender_tCalcViewP8Car_tObj, 0xD4

glabel AudioClc_CalcCarDirection__FP17DRender_tCalcViewP8Car_tObj
    /* 65550 80074D50 2138A000 */  addu       $a3, $a1, $zero
    /* 65554 80074D54 A000E38C */  lw         $v1, 0xA0($a3)
    /* 65558 80074D58 0000828C */  lw         $v0, 0x0($a0)
    /* 6555C 80074D5C F0FFBD27 */  addiu      $sp, $sp, -0x10
    /* 65560 80074D60 23186200 */  subu       $v1, $v1, $v0
    /* 65564 80074D64 0000A3AF */  sw         $v1, 0x0($sp)
    /* 65568 80074D68 A400E58C */  lw         $a1, 0xA4($a3)
    /* 6556C 80074D6C 0400828C */  lw         $v0, 0x4($a0)
    /* 65570 80074D70 00000000 */  nop
    /* 65574 80074D74 2330A200 */  subu       $a2, $a1, $v0
    /* 65578 80074D78 0400A6AF */  sw         $a2, 0x4($sp)
    /* 6557C 80074D7C A800E58C */  lw         $a1, 0xA8($a3)
    /* 65580 80074D80 0800828C */  lw         $v0, 0x8($a0)
    /* 65584 80074D84 00000000 */  nop
    /* 65588 80074D88 2320A200 */  subu       $a0, $a1, $v0
    /* 6558C 80074D8C 02006104 */  bgez       $v1, .L80074D98
    /* 65590 80074D90 0800A4AF */   sw        $a0, 0x8($sp)
    /* 65594 80074D94 FF006324 */  addiu      $v1, $v1, 0xFF
  .L80074D98:
    /* 65598 80074D98 0801E28C */  lw         $v0, 0x108($a3)
    /* 6559C 80074D9C 00000000 */  nop
    /* 655A0 80074DA0 02004104 */  bgez       $v0, .L80074DAC
    /* 655A4 80074DA4 031A0300 */   sra       $v1, $v1, 8
    /* 655A8 80074DA8 FF004224 */  addiu      $v0, $v0, 0xFF
  .L80074DAC:
    /* 655AC 80074DAC 03120200 */  sra        $v0, $v0, 8
    /* 655B0 80074DB0 18006200 */  mult       $v1, $v0
    /* 655B4 80074DB4 2128C000 */  addu       $a1, $a2, $zero
    /* 655B8 80074DB8 12180000 */  mflo       $v1
    /* 655BC 80074DBC 0200A104 */  bgez       $a1, .L80074DC8
    /* 655C0 80074DC0 00000000 */   nop
    /* 655C4 80074DC4 FF00A524 */  addiu      $a1, $a1, 0xFF
  .L80074DC8:
    /* 655C8 80074DC8 0C01E28C */  lw         $v0, 0x10C($a3)
    /* 655CC 80074DCC 00000000 */  nop
    /* 655D0 80074DD0 02004104 */  bgez       $v0, .L80074DDC
    /* 655D4 80074DD4 032A0500 */   sra       $a1, $a1, 8
    /* 655D8 80074DD8 FF004224 */  addiu      $v0, $v0, 0xFF
  .L80074DDC:
    /* 655DC 80074DDC 03120200 */  sra        $v0, $v0, 8
    /* 655E0 80074DE0 1800A200 */  mult       $a1, $v0
    /* 655E4 80074DE4 21288000 */  addu       $a1, $a0, $zero
    /* 655E8 80074DE8 12400000 */  mflo       $t0
    /* 655EC 80074DEC 0200A104 */  bgez       $a1, .L80074DF8
    /* 655F0 80074DF0 21186800 */   addu      $v1, $v1, $t0
    /* 655F4 80074DF4 FF00A524 */  addiu      $a1, $a1, 0xFF
  .L80074DF8:
    /* 655F8 80074DF8 1001E28C */  lw         $v0, 0x110($a3)
    /* 655FC 80074DFC 00000000 */  nop
    /* 65600 80074E00 02004104 */  bgez       $v0, .L80074E0C
    /* 65604 80074E04 032A0500 */   sra       $a1, $a1, 8
    /* 65608 80074E08 FF004224 */  addiu      $v0, $v0, 0xFF
  .L80074E0C:
    /* 6560C 80074E0C 03120200 */  sra        $v0, $v0, 8
    /* 65610 80074E10 1800A200 */  mult       $a1, $v0
    /* 65614 80074E14 12400000 */  mflo       $t0
    /* 65618 80074E18 21106800 */  addu       $v0, $v1, $t0
    /* 6561C 80074E1C 0800E003 */  jr         $ra
    /* 65620 80074E20 1000BD27 */   addiu     $sp, $sp, 0x10
endlabel AudioClc_CalcCarDirection__FP17DRender_tCalcViewP8Car_tObj
