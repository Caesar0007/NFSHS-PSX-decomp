.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hrz_LightningFlicker__Fi, 0xDC

glabel Hrz_LightningFlicker__Fi
    /* C0F60 800D0760 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* C0F64 800D0764 2C008010 */  beqz       $a0, .L800D0818
    /* C0F68 800D0768 1000BFAF */   sw        $ra, 0x10($sp)
    /* C0F6C 800D076C 01000224 */  addiu      $v0, $zero, 0x1
    /* C0F70 800D0770 15008214 */  bne        $a0, $v0, .L800D07C8
    /* C0F74 800D0774 00000000 */   nop
    /* C0F78 800D0778 1480023C */  lui        $v0, %hi(Night_gShowForks)
    /* C0F7C 800D077C 78DA4290 */  lbu        $v0, %lo(Night_gShowForks)($v0)
    /* C0F80 800D0780 00000000 */  nop
    /* C0F84 800D0784 29004014 */  bnez       $v0, .L800D082C
    /* C0F88 800D0788 FF00023C */   lui       $v0, (0xFFC0C0 >> 16)
    /* C0F8C 800D078C C0C04234 */  ori        $v0, $v0, (0xFFC0C0 & 0xFFFF)
    /* C0F90 800D0790 FF00063C */  lui        $a2, (0xFFC0C0 >> 16)
    /* C0F94 800D0794 C0C0C634 */  ori        $a2, $a2, (0xFFC0C0 & 0xFFFF)
    /* C0F98 800D0798 54000524 */  addiu      $a1, $zero, 0x54
    /* C0F9C 800D079C 1280033C */  lui        $v1, %hi(gSkyColor)
    /* C0FA0 800D07A0 20066324 */  addiu      $v1, $v1, %lo(gSkyColor)
    /* C0FA4 800D07A4 4013848F */  lw         $a0, %gp_rel(Sky_gTrackSpec)($gp)
    /* C0FA8 800D07A8 50016324 */  addiu      $v1, $v1, 0x150
    /* C0FAC 800D07AC 080082AC */  sw         $v0, 0x8($a0)
  .L800D07B0:
    /* C0FB0 800D07B0 000066AC */  sw         $a2, 0x0($v1)
    /* C0FB4 800D07B4 FFFFA524 */  addiu      $a1, $a1, -0x1
    /* C0FB8 800D07B8 FDFFA104 */  bgez       $a1, .L800D07B0
    /* C0FBC 800D07BC FCFF6324 */   addiu     $v1, $v1, -0x4
    /* C0FC0 800D07C0 0B420308 */  j          .L800D082C
    /* C0FC4 800D07C4 00000000 */   nop
  .L800D07C8:
    /* C0FC8 800D07C8 1480023C */  lui        $v0, %hi(Night_gShowForks)
    /* C0FCC 800D07CC 78DA4290 */  lbu        $v0, %lo(Night_gShowForks)($v0)
    /* C0FD0 800D07D0 00000000 */  nop
    /* C0FD4 800D07D4 15004014 */  bnez       $v0, .L800D082C
    /* C0FD8 800D07D8 C000023C */   lui       $v0, (0xC02828 >> 16)
    /* C0FDC 800D07DC 28284234 */  ori        $v0, $v0, (0xC02828 & 0xFFFF)
    /* C0FE0 800D07E0 C000063C */  lui        $a2, (0xC02828 >> 16)
    /* C0FE4 800D07E4 2828C634 */  ori        $a2, $a2, (0xC02828 & 0xFFFF)
    /* C0FE8 800D07E8 54000524 */  addiu      $a1, $zero, 0x54
    /* C0FEC 800D07EC 1280033C */  lui        $v1, %hi(gSkyColor)
    /* C0FF0 800D07F0 20066324 */  addiu      $v1, $v1, %lo(gSkyColor)
    /* C0FF4 800D07F4 4013848F */  lw         $a0, %gp_rel(Sky_gTrackSpec)($gp)
    /* C0FF8 800D07F8 50016324 */  addiu      $v1, $v1, 0x150
    /* C0FFC 800D07FC 080082AC */  sw         $v0, 0x8($a0)
  .L800D0800:
    /* C1000 800D0800 000066AC */  sw         $a2, 0x0($v1)
    /* C1004 800D0804 FFFFA524 */  addiu      $a1, $a1, -0x1
    /* C1008 800D0808 FDFFA104 */  bgez       $a1, .L800D0800
    /* C100C 800D080C FCFF6324 */   addiu     $v1, $v1, -0x4
    /* C1010 800D0810 0B420308 */  j          .L800D082C
    /* C1014 800D0814 00000000 */   nop
  .L800D0818:
    /* C1018 800D0818 1480023C */  lui        $v0, %hi(D_8013E384)
    /* C101C 800D081C 4013838F */  lw         $v1, %gp_rel(Sky_gTrackSpec)($gp)
    /* C1020 800D0820 84E3428C */  lw         $v0, %lo(D_8013E384)($v0)
    /* C1024 800D0824 383E030C */  jal        Hrz_InitSkyColor__Fv
    /* C1028 800D0828 080062AC */   sw        $v0, 0x8($v1)
  .L800D082C:
    /* C102C 800D082C 1000BF8F */  lw         $ra, 0x10($sp)
    /* C1030 800D0830 00000000 */  nop
    /* C1034 800D0834 0800E003 */  jr         $ra
    /* C1038 800D0838 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Hrz_LightningFlicker__Fi
