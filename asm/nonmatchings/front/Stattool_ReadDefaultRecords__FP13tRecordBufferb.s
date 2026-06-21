.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Stattool_ReadDefaultRecords__FP13tRecordBufferb, 0x88

glabel Stattool_ReadDefaultRecords__FP13tRecordBufferb
    /* 3B590 8004AD90 98FFBD27 */  addiu      $sp, $sp, -0x68
    /* 3B594 8004AD94 6000B0AF */  sw         $s0, 0x60($sp)
    /* 3B598 8004AD98 21808000 */  addu       $s0, $a0, $zero
    /* 3B59C 8004AD9C 0700A010 */  beqz       $a1, .L8004ADBC
    /* 3B5A0 8004ADA0 6400BFAF */   sw        $ra, 0x64($sp)
    /* 3B5A4 8004ADA4 1000A427 */  addiu      $a0, $sp, 0x10
    /* 3B5A8 8004ADA8 1180023C */  lui        $v0, %hi(D_801164F8)
    /* 3B5AC 8004ADAC F864468C */  lw         $a2, %lo(D_801164F8)($v0)
    /* 3B5B0 8004ADB0 0180053C */  lui        $a1, %hi(D_800125B4)
    /* 3B5B4 8004ADB4 742B0108 */  j          .L8004ADD0
    /* 3B5B8 8004ADB8 B425A524 */   addiu     $a1, $a1, %lo(D_800125B4)
  .L8004ADBC:
    /* 3B5BC 8004ADBC 1000A427 */  addiu      $a0, $sp, 0x10
    /* 3B5C0 8004ADC0 1180023C */  lui        $v0, %hi(D_801164F8)
    /* 3B5C4 8004ADC4 F864468C */  lw         $a2, %lo(D_801164F8)($v0)
    /* 3B5C8 8004ADC8 0180053C */  lui        $a1, %hi(D_800125C4)
    /* 3B5CC 8004ADCC C425A524 */  addiu      $a1, $a1, %lo(D_800125C4)
  .L8004ADD0:
    /* 3B5D0 8004ADD0 2F91030C */  jal        sprintf
    /* 3B5D4 8004ADD4 00000000 */   nop
    /* 3B5D8 8004ADD8 9B95030C */  jal        filesize
    /* 3B5DC 8004ADDC 1000A427 */   addiu     $a0, $sp, 0x10
    /* 3B5E0 8004ADE0 9C0E0324 */  addiu      $v1, $zero, 0xE9C
    /* 3B5E4 8004ADE4 06004314 */  bne        $v0, $v1, .L8004AE00
    /* 3B5E8 8004ADE8 21200002 */   addu      $a0, $s0, $zero
    /* 3B5EC 8004ADEC 1000A427 */  addiu      $a0, $sp, 0x10
    /* 3B5F0 8004ADF0 2C96030C */  jal        loadfileatadrz
    /* 3B5F4 8004ADF4 21280002 */   addu      $a1, $s0, $zero
    /* 3B5F8 8004ADF8 822B0108 */  j          .L8004AE08
    /* 3B5FC 8004ADFC 00000000 */   nop
  .L8004AE00:
    /* 3B600 8004AE00 E8C5030C */  jal        blockclear
    /* 3B604 8004AE04 9C0E0524 */   addiu     $a1, $zero, 0xE9C
  .L8004AE08:
    /* 3B608 8004AE08 6400BF8F */  lw         $ra, 0x64($sp)
    /* 3B60C 8004AE0C 6000B08F */  lw         $s0, 0x60($sp)
    /* 3B610 8004AE10 0800E003 */  jr         $ra
    /* 3B614 8004AE14 6800BD27 */   addiu     $sp, $sp, 0x68
endlabel Stattool_ReadDefaultRecords__FP13tRecordBufferb
