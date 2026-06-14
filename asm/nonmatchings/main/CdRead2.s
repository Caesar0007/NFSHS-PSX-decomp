.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdRead2, 0x84

glabel CdRead2
    /* E9748 800F8F48 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* E974C 800F8F4C 1800B0AF */  sw         $s0, 0x18($sp)
    /* E9750 800F8F50 21808000 */  addu       $s0, $a0, $zero
    /* E9754 800F8F54 0E000424 */  addiu      $a0, $zero, 0xE
    /* E9758 800F8F58 1000A527 */  addiu      $a1, $sp, 0x10
    /* E975C 800F8F5C 21300000 */  addu       $a2, $zero, $zero
    /* E9760 800F8F60 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* E9764 800F8F64 2DDE030C */  jal        CdControl
    /* E9768 800F8F68 1000B0A3 */   sb        $s0, 0x10($sp)
    /* E976C 800F8F6C 00010232 */  andi       $v0, $s0, 0x100
    /* E9770 800F8F70 0E004010 */  beqz       $v0, .L800F8FAC
    /* E9774 800F8F74 20000232 */   andi      $v0, $s0, 0x20
    /* E9778 800F8F78 04004010 */  beqz       $v0, .L800F8F8C
    /* E977C 800F8F7C 01000224 */   addiu     $v0, $zero, 0x1
    /* E9780 800F8F80 1580013C */  lui        $at, %hi(StMode)
    /* E9784 800F8F84 E5E30308 */  j          .L800F8F94
    /* E9788 800F8F88 CC8920AC */   sw        $zero, %lo(StMode)($at)
  .L800F8F8C:
    /* E978C 800F8F8C 1580013C */  lui        $at, %hi(StMode)
    /* E9790 800F8F90 CC8922AC */  sw         $v0, %lo(StMode)($at)
  .L800F8F94:
    /* E9794 800F8F94 1180043C */  lui        $a0, %hi(data_ready_callback)
    /* E9798 800F8F98 2CDF030C */  jal        CdDataCallback
    /* E979C 800F8F9C 98878424 */   addiu     $a0, $a0, %lo(data_ready_callback)
    /* E97A0 800F8FA0 1080043C */  lui        $a0, %hi(func_800F8FCC)
    /* E97A4 800F8FA4 28DE030C */  jal        CdReadyCallback
    /* E97A8 800F8FA8 CC8F8424 */   addiu     $a0, $a0, %lo(func_800F8FCC)
  .L800F8FAC:
    /* E97AC 800F8FAC 1B000424 */  addiu      $a0, $zero, 0x1B
    /* E97B0 800F8FB0 21280000 */  addu       $a1, $zero, $zero
    /* E97B4 800F8FB4 2DDE030C */  jal        CdControl
    /* E97B8 800F8FB8 21300000 */   addu      $a2, $zero, $zero
    /* E97BC 800F8FBC 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* E97C0 800F8FC0 1800B08F */  lw         $s0, 0x18($sp)
    /* E97C4 800F8FC4 0800E003 */  jr         $ra
    /* E97C8 800F8FC8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel CdRead2
