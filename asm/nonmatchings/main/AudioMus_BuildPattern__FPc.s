.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioMus_BuildPattern__FPc, 0xD0

glabel AudioMus_BuildPattern__FPc
    /* 6B760 8007AF60 D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6B764 8007AF64 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 6B768 8007AF68 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 6B76C 8007AF6C 21888000 */  addu       $s1, $a0, $zero
    /* 6B770 8007AF70 2000BFAF */  sw         $ra, 0x20($sp)
    /* 6B774 8007AF74 29006010 */  beqz       $v1, .L8007B01C
    /* 6B778 8007AF78 1800B0AF */   sw        $s0, 0x18($sp)
    /* 6B77C 8007AF7C 0400628C */  lw         $v0, 0x4($v1)
    /* 6B780 8007AF80 21800000 */  addu       $s0, $zero, $zero
    /* 6B784 8007AF84 25004018 */  blez       $v0, .L8007B01C
    /* 6B788 8007AF88 080060AC */   sw        $zero, 0x8($v1)
  .L8007AF8C:
    /* 6B78C 8007AF8C D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6B790 8007AF90 00000000 */  nop
    /* 6B794 8007AF94 0800628C */  lw         $v0, 0x8($v1)
    /* 6B798 8007AF98 00000000 */  nop
    /* 6B79C 8007AF9C 20004228 */  slti       $v0, $v0, 0x20
    /* 6B7A0 8007AFA0 1E004010 */  beqz       $v0, .L8007B01C
    /* 6B7A4 8007AFA4 21300002 */   addu      $a2, $s0, $zero
    /* 6B7A8 8007AFA8 21280000 */  addu       $a1, $zero, $zero
    /* 6B7AC 8007AFAC 1000A0AF */  sw         $zero, 0x10($sp)
    /* 6B7B0 8007AFB0 8C00648C */  lw         $a0, 0x8C($v1)
    /* 6B7B4 8007AFB4 6E98030C */  jal        locatebigentry
    /* 6B7B8 8007AFB8 2138A000 */   addu      $a3, $a1, $zero
    /* 6B7BC 8007AFBC 21204000 */  addu       $a0, $v0, $zero
    /* 6B7C0 8007AFC0 6FA2030C */  jal        wildcard
    /* 6B7C4 8007AFC4 21282002 */   addu      $a1, $s1, $zero
    /* 6B7C8 8007AFC8 0D004010 */  beqz       $v0, .L8007B000
    /* 6B7CC 8007AFCC 00000000 */   nop
    /* 6B7D0 8007AFD0 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6B7D4 8007AFD4 00000000 */  nop
    /* 6B7D8 8007AFD8 0800438C */  lw         $v1, 0x8($v0)
    /* 6B7DC 8007AFDC 00000000 */  nop
    /* 6B7E0 8007AFE0 21104300 */  addu       $v0, $v0, $v1
    /* 6B7E4 8007AFE4 EC0050A0 */  sb         $s0, 0xEC($v0)
    /* 6B7E8 8007AFE8 D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6B7EC 8007AFEC 00000000 */  nop
    /* 6B7F0 8007AFF0 0800628C */  lw         $v0, 0x8($v1)
    /* 6B7F4 8007AFF4 00000000 */  nop
    /* 6B7F8 8007AFF8 01004224 */  addiu      $v0, $v0, 0x1
    /* 6B7FC 8007AFFC 080062AC */  sw         $v0, 0x8($v1)
  .L8007B000:
    /* 6B800 8007B000 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6B804 8007B004 00000000 */  nop
    /* 6B808 8007B008 0400428C */  lw         $v0, 0x4($v0)
    /* 6B80C 8007B00C 01001026 */  addiu      $s0, $s0, 0x1
    /* 6B810 8007B010 2A100202 */  slt        $v0, $s0, $v0
    /* 6B814 8007B014 DDFF4014 */  bnez       $v0, .L8007AF8C
    /* 6B818 8007B018 00000000 */   nop
  .L8007B01C:
    /* 6B81C 8007B01C 2000BF8F */  lw         $ra, 0x20($sp)
    /* 6B820 8007B020 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 6B824 8007B024 1800B08F */  lw         $s0, 0x18($sp)
    /* 6B828 8007B028 0800E003 */  jr         $ra
    /* 6B82C 8007B02C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel AudioMus_BuildPattern__FPc
