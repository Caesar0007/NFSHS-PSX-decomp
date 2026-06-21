.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _pad_port_to_slot, 0x38

glabel _pad_port_to_slot
    /* EEB2C 800FE32C 21280000 */  addu       $a1, $zero, $zero
    /* EEB30 800FE330 10000624 */  addiu      $a2, $zero, 0x10
    /* EEB34 800FE334 1480033C */  lui        $v1, %hi(D_80147600)
    /* EEB38 800FE338 00766324 */  addiu      $v1, $v1, %lo(D_80147600)
  .L800FE33C:
    /* EEB3C 800FE33C 07008310 */  beq        $a0, $v1, .L800FE35C
    /* EEB40 800FE340 2110C000 */   addu      $v0, $a2, $zero
    /* EEB44 800FE344 1000C624 */  addiu      $a2, $a2, 0x10
    /* EEB48 800FE348 0100A524 */  addiu      $a1, $a1, 0x1
    /* EEB4C 800FE34C 0200A228 */  slti       $v0, $a1, 0x2
    /* EEB50 800FE350 FAFF4014 */  bnez       $v0, .L800FE33C
    /* EEB54 800FE354 F0006324 */   addiu     $v1, $v1, 0xF0
    /* EEB58 800FE358 FF000224 */  addiu      $v0, $zero, 0xFF
  .L800FE35C:
    /* EEB5C 800FE35C 0800E003 */  jr         $ra
    /* EEB60 800FE360 00000000 */   nop
endlabel _pad_port_to_slot
