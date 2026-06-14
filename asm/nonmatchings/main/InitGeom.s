.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching InitGeom, 0x80

glabel InitGeom
    /* E29A4 800F21A4 1380013C */  lui        $at, %hi(D_80134A70)
    /* E29A8 800F21A8 704A3FAC */  sw         $ra, %lo(D_80134A70)($at)
    /* E29AC 800F21AC 1519040C */  jal        _patch_gte
    /* E29B0 800F21B0 00000000 */   nop
    /* E29B4 800F21B4 13801F3C */  lui        $ra, %hi(D_80134A70)
    /* E29B8 800F21B8 704AFF8F */  lw         $ra, %lo(D_80134A70)($ra)
    /* E29BC 800F21BC 00000000 */  nop
    /* E29C0 800F21C0 00600240 */  mfc0       $v0, $12 /* handwritten instruction */
    /* E29C4 800F21C4 0040033C */  lui        $v1, (0x40000000 >> 16)
    /* E29C8 800F21C8 25104300 */  or         $v0, $v0, $v1
    /* E29CC 800F21CC 00608240 */  mtc0       $v0, $12 /* handwritten instruction */
    /* E29D0 800F21D0 00000000 */  nop
    /* E29D4 800F21D4 55010824 */  addiu      $t0, $zero, 0x155
    /* E29D8 800F21D8 00E8C848 */  ctc2       $t0, $29 /* handwritten instruction */
    /* E29DC 800F21DC 00000000 */  nop
    /* E29E0 800F21E0 00010824 */  addiu      $t0, $zero, 0x100
    /* E29E4 800F21E4 00F0C848 */  ctc2       $t0, $30 /* handwritten instruction */
    /* E29E8 800F21E8 00000000 */  nop
    /* E29EC 800F21EC E8030824 */  addiu      $t0, $zero, 0x3E8
    /* E29F0 800F21F0 00D0C848 */  ctc2       $t0, $26 /* handwritten instruction */
    /* E29F4 800F21F4 00000000 */  nop
    /* E29F8 800F21F8 9EEF0824 */  addiu      $t0, $zero, -0x1062
    /* E29FC 800F21FC 00D8C848 */  ctc2       $t0, $27 /* handwritten instruction */
    /* E2A00 800F2200 00000000 */  nop
    /* E2A04 800F2204 4001083C */  lui        $t0, (0x1400000 >> 16)
    /* E2A08 800F2208 00E0C848 */  ctc2       $t0, $28 /* handwritten instruction */
    /* E2A0C 800F220C 00000000 */  nop
    /* E2A10 800F2210 00C0C048 */  ctc2       $zero, $24 /* handwritten instruction */
    /* E2A14 800F2214 00C8C048 */  ctc2       $zero, $25 /* handwritten instruction */
    /* E2A18 800F2218 00000000 */  nop
    /* E2A1C 800F221C 0800E003 */  jr         $ra
    /* E2A20 800F2220 00000000 */   nop
endlabel InitGeom
    /* E2A24 800F2224 00000000 */  nop
    /* E2A28 800F2228 00000000 */  nop
