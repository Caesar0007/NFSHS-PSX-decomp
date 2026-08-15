.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _bzero_w, 0x24

/* W67-A5: libetc INTR.OBJ's own file-local static copy of _bzero_w
   @0x800F2E70 (follows RestartCallback, ends flush against setfont
   @0x800F2E94 -- NO inter-obj pad word here, unlike the 0x80106924 copy).
   Byte-verified against rom/nfs4-f.exe @file-off 0xE3670: the 9-word
   instruction stream is identical to INTR_DMA's copy (same source, PsyQ
   compiled it into both objects).  Both src TUs previously INCLUDE_ASM'd
   the SAME _bzero_w.s (@0x80106924), exporting one global twice -> the
   `_bzero_w' REAL dup in tools/relink.py.  This copy is LOCAL (retail
   truth: SYM-static in both objects); INTR_DMA keeps the global in
   _bzero_w.s. */
    .type _bzero_w, @function
_bzero_w:
    /* E3670 800F2E70 0600A010 */  beqz       $a1, .L800F2E8C
    /* E3674 800F2E74 FFFFA224 */   addiu     $v0, $a1, -0x1
    /* E3678 800F2E78 FFFF0324 */  addiu      $v1, $zero, -0x1
  .L800F2E7C:
    /* E367C 800F2E7C 000080AC */  sw         $zero, 0x0($a0)
    /* E3680 800F2E80 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* E3684 800F2E84 FDFF4314 */  bne        $v0, $v1, .L800F2E7C
    /* E3688 800F2E88 04008424 */   addiu     $a0, $a0, 0x4
  .L800F2E8C:
    /* E368C 800F2E8C 0800E003 */  jr         $ra
    /* E3690 800F2E90 00000000 */   nop
endlabel _bzero_w
