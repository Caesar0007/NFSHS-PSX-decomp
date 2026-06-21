.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ShakeIt__23tScreenControllerConfig, 0x9C

glabel ShakeIt__23tScreenControllerConfig
    /* 339B4 800431B4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 339B8 800431B8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 339BC 800431BC 21888000 */  addu       $s1, $a0, $zero
    /* 339C0 800431C0 1800BFAF */  sw         $ra, 0x18($sp)
    /* 339C4 800431C4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 339C8 800431C8 7801228E */  lw         $v0, 0x178($s1)
    /* 339CC 800431CC 00000000 */  nop
    /* 339D0 800431D0 00810200 */  sll        $s0, $v0, 4
    /* 339D4 800431D4 A8BF030C */  jal        PadGetState
    /* 339D8 800431D8 21200002 */   addu      $a0, $s0, $zero
    /* 339DC 800431DC 21184000 */  addu       $v1, $v0, $zero
    /* 339E0 800431E0 06000224 */  addiu      $v0, $zero, 0x6
    /* 339E4 800431E4 08006210 */  beq        $v1, $v0, .L80043208
    /* 339E8 800431E8 04006228 */   slti      $v0, $v1, 0x4
    /* 339EC 800431EC 02004010 */  beqz       $v0, .L800431F8
    /* 339F0 800431F0 00000000 */   nop
    /* 339F4 800431F4 640020A2 */  sb         $zero, 0x64($s1)
  .L800431F8:
    /* 339F8 800431F8 460C010C */  jal        ClearActuators__23tScreenControllerConfig
    /* 339FC 800431FC 21202002 */   addu      $a0, $s1, $zero
    /* 33A00 80043200 8F0C0108 */  j          .L8004323C
    /* 33A04 80043204 00000000 */   nop
  .L80043208:
    /* 33A08 80043208 64002292 */  lbu        $v0, 0x64($s1)
    /* 33A0C 8004320C 00000000 */  nop
    /* 33A10 80043210 0A004014 */  bnez       $v0, .L8004323C
    /* 33A14 80043214 01000224 */   addiu     $v0, $zero, 0x1
    /* 33A18 80043218 640022A2 */  sb         $v0, 0x64($s1)
    /* 33A1C 8004321C 21200002 */  addu       $a0, $s0, $zero
    /* 33A20 80043220 6A002526 */  addiu      $a1, $s1, 0x6A
    /* 33A24 80043224 6BC0030C */  jal        PadSetAct
    /* 33A28 80043228 02000624 */   addiu     $a2, $zero, 0x2
    /* 33A2C 8004322C 21200002 */  addu       $a0, $s0, $zero
    /* 33A30 80043230 1480053C */  lui        $a1, %hi(Force_gActAlign)
    /* 33A34 80043234 4BC0030C */  jal        PadSetActAlign
    /* 33A38 80043238 40D8A524 */   addiu     $a1, $a1, %lo(Force_gActAlign)
  .L8004323C:
    /* 33A3C 8004323C 1800BF8F */  lw         $ra, 0x18($sp)
    /* 33A40 80043240 1400B18F */  lw         $s1, 0x14($sp)
    /* 33A44 80043244 1000B08F */  lw         $s0, 0x10($sp)
    /* 33A48 80043248 0800E003 */  jr         $ra
    /* 33A4C 8004324C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ShakeIt__23tScreenControllerConfig
