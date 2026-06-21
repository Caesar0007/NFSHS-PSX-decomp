.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Initialize__11tCarManager, 0x9C

glabel Initialize__11tCarManager
    /* 69B0 800161B0 21380000 */  addu       $a3, $zero, $zero
    /* 69B4 800161B4 FFFF0824 */  addiu      $t0, $zero, -0x1
    /* 69B8 800161B8 000080AC */  sw         $zero, 0x0($a0)
    /* 69BC 800161BC 040080AC */  sw         $zero, 0x4($a0)
    /* 69C0 800161C0 21280000 */  addu       $a1, $zero, $zero
  .L800161C4:
    /* 69C4 800161C4 00140700 */  sll        $v0, $a3, 16
    /* 69C8 800161C8 43320200 */  sra        $a2, $v0, 9
  .L800161CC:
    /* 69CC 800161CC 00140500 */  sll        $v0, $a1, 16
    /* 69D0 800161D0 0100A324 */  addiu      $v1, $a1, 0x1
    /* 69D4 800161D4 21286000 */  addu       $a1, $v1, $zero
    /* 69D8 800161D8 83130200 */  sra        $v0, $v0, 14
    /* 69DC 800161DC 21104600 */  addu       $v0, $v0, $a2
    /* 69E0 800161E0 21108200 */  addu       $v0, $a0, $v0
    /* 69E4 800161E4 001C0300 */  sll        $v1, $v1, 16
    /* 69E8 800161E8 031C0300 */  sra        $v1, $v1, 16
    /* 69EC 800161EC 20006328 */  slti       $v1, $v1, 0x20
    /* 69F0 800161F0 080048A0 */  sb         $t0, 0x8($v0)
    /* 69F4 800161F4 F5FF6014 */  bnez       $v1, .L800161CC
    /* 69F8 800161F8 080148A0 */   sb        $t0, 0x108($v0)
    /* 69FC 800161FC 0100E224 */  addiu      $v0, $a3, 0x1
    /* 6A00 80016200 21384000 */  addu       $a3, $v0, $zero
    /* 6A04 80016204 00140200 */  sll        $v0, $v0, 16
    /* 6A08 80016208 03140200 */  sra        $v0, $v0, 16
    /* 6A0C 8001620C 02004228 */  slti       $v0, $v0, 0x2
    /* 6A10 80016210 ECFF4014 */  bnez       $v0, .L800161C4
    /* 6A14 80016214 21280000 */   addu      $a1, $zero, $zero
  .L80016218:
    /* 6A18 80016218 001C0500 */  sll        $v1, $a1, 16
    /* 6A1C 8001621C 0100A224 */  addiu      $v0, $a1, 0x1
    /* 6A20 80016220 21284000 */  addu       $a1, $v0, $zero
    /* 6A24 80016224 031C0300 */  sra        $v1, $v1, 16
    /* 6A28 80016228 21188300 */  addu       $v1, $a0, $v1
    /* 6A2C 8001622C 00140200 */  sll        $v0, $v0, 16
    /* 6A30 80016230 03140200 */  sra        $v0, $v0, 16
    /* 6A34 80016234 30004228 */  slti       $v0, $v0, 0x30
    /* 6A38 80016238 080260A0 */  sb         $zero, 0x208($v1)
    /* 6A3C 8001623C F6FF4014 */  bnez       $v0, .L80016218
    /* 6A40 80016240 380260A0 */   sb        $zero, 0x238($v1)
    /* 6A44 80016244 0800E003 */  jr         $ra
    /* 6A48 80016248 00000000 */   nop
endlabel Initialize__11tCarManager
