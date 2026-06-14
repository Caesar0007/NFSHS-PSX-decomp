.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __fixsfsi, 0xB4

glabel __fixsfsi
    /* E4138 800F3938 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E413C 800F393C FF7F023C */  lui        $v0, (0x7FFFFFFF >> 16)
    /* E4140 800F3940 FFFF4234 */  ori        $v0, $v0, (0x7FFFFFFF & 0xFFFF)
    /* E4144 800F3944 24108200 */  and        $v0, $a0, $v0
    /* E4148 800F3948 04004014 */  bnez       $v0, .L800F395C
    /* E414C 800F394C 1000BFAF */   sw        $ra, 0x10($sp)
    /* E4150 800F3950 0080023C */  lui        $v0, (0x80000000 >> 16)
    /* E4154 800F3954 77CE0308 */  j          .L800F39DC
    /* E4158 800F3958 24108200 */   and       $v0, $a0, $v0
  .L800F395C:
    /* E415C 800F395C C3150400 */  sra        $v0, $a0, 23
    /* E4160 800F3960 FF004530 */  andi       $a1, $v0, 0xFF
    /* E4164 800F3964 63FFA624 */  addiu      $a2, $a1, -0x9D
    /* E4168 800F3968 0A00C018 */  blez       $a2, .L800F3994
    /* E416C 800F396C 8000033C */   lui       $v1, (0x800000 >> 16)
    /* E4170 800F3970 06008004 */  bltz       $a0, .L800F398C
    /* E4174 800F3974 22000424 */   addiu     $a0, $zero, 0x22
    /* E4178 800F3978 951A040C */  jal        _err_math
    /* E417C 800F397C 12000524 */   addiu     $a1, $zero, 0x12
    /* E4180 800F3980 FF7F023C */  lui        $v0, (0x7FFFFFFF >> 16)
    /* E4184 800F3984 77CE0308 */  j          .L800F39DC
    /* E4188 800F3988 FFFF4234 */   ori       $v0, $v0, (0x7FFFFFFF & 0xFFFF)
  .L800F398C:
    /* E418C 800F398C 77CE0308 */  j          .L800F39DC
    /* E4190 800F3990 0080023C */   lui       $v0, (0x80000000 >> 16)
  .L800F3994:
    /* E4194 800F3994 7F00023C */  lui        $v0, (0x7FFFFF >> 16)
    /* E4198 800F3998 FFFF4234 */  ori        $v0, $v0, (0x7FFFFF & 0xFFFF)
    /* E419C 800F399C 24108200 */  and        $v0, $a0, $v0
    /* E41A0 800F39A0 25104300 */  or         $v0, $v0, $v1
    /* E41A4 800F39A4 C0190200 */  sll        $v1, $v0, 7
    /* E41A8 800F39A8 82FFA224 */  addiu      $v0, $a1, -0x7E
    /* E41AC 800F39AC 2000422C */  sltiu      $v0, $v0, 0x20
    /* E41B0 800F39B0 05004010 */  beqz       $v0, .L800F39C8
    /* E41B4 800F39B4 00000000 */   nop
    /* E41B8 800F39B8 03006010 */  beqz       $v1, .L800F39C8
    /* E41BC 800F39BC 23100600 */   negu      $v0, $a2
    /* E41C0 800F39C0 74CE0308 */  j          .L800F39D0
    /* E41C4 800F39C4 07184300 */   srav      $v1, $v1, $v0
  .L800F39C8:
    /* E41C8 800F39C8 77CE0308 */  j          .L800F39DC
    /* E41CC 800F39CC 21100000 */   addu      $v0, $zero, $zero
  .L800F39D0:
    /* E41D0 800F39D0 02008104 */  bgez       $a0, .L800F39DC
    /* E41D4 800F39D4 21106000 */   addu      $v0, $v1, $zero
    /* E41D8 800F39D8 23100200 */  negu       $v0, $v0
  .L800F39DC:
    /* E41DC 800F39DC 1000BF8F */  lw         $ra, 0x10($sp)
    /* E41E0 800F39E0 1800BD27 */  addiu      $sp, $sp, 0x18
    /* E41E4 800F39E4 0800E003 */  jr         $ra
    /* E41E8 800F39E8 00000000 */   nop
endlabel __fixsfsi
    /* E41EC 800F39EC 00000000 */  nop
    /* E41F0 800F39F0 00000000 */  nop
    /* E41F4 800F39F4 00000000 */  nop
