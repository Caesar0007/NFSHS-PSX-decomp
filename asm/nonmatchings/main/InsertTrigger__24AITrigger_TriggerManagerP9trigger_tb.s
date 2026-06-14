.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching InsertTrigger__24AITrigger_TriggerManagerP9trigger_tb, 0xFC

glabel InsertTrigger__24AITrigger_TriggerManagerP9trigger_tb
    /* 63148 80072948 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 6314C 8007294C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 63150 80072950 21908000 */  addu       $s2, $a0, $zero
    /* 63154 80072954 1400B1AF */  sw         $s1, 0x14($sp)
    /* 63158 80072958 2188A000 */  addu       $s1, $a1, $zero
    /* 6315C 8007295C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 63160 80072960 2198C000 */  addu       $s3, $a2, $zero
    /* 63164 80072964 1000B0AF */  sw         $s0, 0x10($sp)
    /* 63168 80072968 2000BFAF */  sw         $ra, 0x20($sp)
    /* 6316C 8007296C 84CB010C */  jal        DescribeTrigger__24AITrigger_TriggerManagerP9trigger_t
    /* 63170 80072970 21800000 */   addu      $s0, $zero, $zero
    /* 63174 80072974 0000238E */  lw         $v1, 0x0($s1)
    /* 63178 80072978 05000224 */  addiu      $v0, $zero, 0x5
    /* 6317C 8007297C 10006214 */  bne        $v1, $v0, .L800729C0
    /* 63180 80072980 02000224 */   addiu     $v0, $zero, 0x2
    /* 63184 80072984 02006012 */  beqz       $s3, .L80072990
    /* 63188 80072988 40002226 */   addiu     $v0, $s1, 0x40
    /* 6318C 8007298C 3C0022AE */  sw         $v0, 0x3C($s1)
  .L80072990:
    /* 63190 80072990 0000428E */  lw         $v0, 0x0($s2)
    /* 63194 80072994 00000000 */  nop
    /* 63198 80072998 80100200 */  sll        $v0, $v0, 2
    /* 6319C 8007299C 21104202 */  addu       $v0, $s2, $v0
    /* 631A0 800729A0 080051AC */  sw         $s1, 0x8($v0)
    /* 631A4 800729A4 3800238E */  lw         $v1, 0x38($s1)
    /* 631A8 800729A8 00000000 */  nop
    /* 631AC 800729AC 80100300 */  sll        $v0, $v1, 2
    /* 631B0 800729B0 21104300 */  addu       $v0, $v0, $v1
    /* 631B4 800729B4 80100200 */  sll        $v0, $v0, 2
    /* 631B8 800729B8 85CA0108 */  j          .L80072A14
    /* 631BC 800729BC 40005024 */   addiu     $s0, $v0, 0x40
  .L800729C0:
    /* 631C0 800729C0 0C006210 */  beq        $v1, $v0, .L800729F4
    /* 631C4 800729C4 03006228 */   slti      $v0, $v1, 0x3
    /* 631C8 800729C8 05004010 */  beqz       $v0, .L800729E0
    /* 631CC 800729CC 01000224 */   addiu     $v0, $zero, 0x1
    /* 631D0 800729D0 08006210 */  beq        $v1, $v0, .L800729F4
    /* 631D4 800729D4 00000000 */   nop
    /* 631D8 800729D8 80CA0108 */  j          .L80072A00
    /* 631DC 800729DC 00000000 */   nop
  .L800729E0:
    /* 631E0 800729E0 03000224 */  addiu      $v0, $zero, 0x3
    /* 631E4 800729E4 05006210 */  beq        $v1, $v0, .L800729FC
    /* 631E8 800729E8 00000000 */   nop
    /* 631EC 800729EC 80CA0108 */  j          .L80072A00
    /* 631F0 800729F0 00000000 */   nop
  .L800729F4:
    /* 631F4 800729F4 80CA0108 */  j          .L80072A00
    /* 631F8 800729F8 14001024 */   addiu     $s0, $zero, 0x14
  .L800729FC:
    /* 631FC 800729FC 48001024 */  addiu      $s0, $zero, 0x48
  .L80072A00:
    /* 63200 80072A00 0000428E */  lw         $v0, 0x0($s2)
    /* 63204 80072A04 00000000 */  nop
    /* 63208 80072A08 80100200 */  sll        $v0, $v0, 2
    /* 6320C 80072A0C 21104202 */  addu       $v0, $s2, $v0
    /* 63210 80072A10 080051AC */  sw         $s1, 0x8($v0)
  .L80072A14:
    /* 63214 80072A14 0000428E */  lw         $v0, 0x0($s2)
    /* 63218 80072A18 00000000 */  nop
    /* 6321C 80072A1C 01004224 */  addiu      $v0, $v0, 0x1
    /* 63220 80072A20 000042AE */  sw         $v0, 0x0($s2)
    /* 63224 80072A24 21100002 */  addu       $v0, $s0, $zero
    /* 63228 80072A28 2000BF8F */  lw         $ra, 0x20($sp)
    /* 6322C 80072A2C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 63230 80072A30 1800B28F */  lw         $s2, 0x18($sp)
    /* 63234 80072A34 1400B18F */  lw         $s1, 0x14($sp)
    /* 63238 80072A38 1000B08F */  lw         $s0, 0x10($sp)
    /* 6323C 80072A3C 0800E003 */  jr         $ra
    /* 63240 80072A40 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel InsertTrigger__24AITrigger_TriggerManagerP9trigger_tb
