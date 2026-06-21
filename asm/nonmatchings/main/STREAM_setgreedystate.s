.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching STREAM_setgreedystate, 0x60

glabel STREAM_setgreedystate
    /* EDAB4 800FD2B4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* EDAB8 800FD2B8 1800B0AF */  sw         $s0, 0x18($sp)
    /* EDABC 800FD2BC 2180A000 */  addu       $s0, $a1, $zero
    /* EDAC0 800FD2C0 1000A527 */  addiu      $a1, $sp, 0x10
    /* EDAC4 800FD2C4 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* EDAC8 800FD2C8 BEF0030C */  jal        validatehandle
    /* EDACC 800FD2CC 1400A627 */   addiu     $a2, $sp, 0x14
    /* EDAD0 800FD2D0 0C004014 */  bnez       $v0, .L800FD304
    /* EDAD4 800FD2D4 00000000 */   nop
    /* EDAD8 800FD2D8 1000A58F */  lw         $a1, 0x10($sp)
    /* EDADC 800FD2DC 09000012 */  beqz       $s0, .L800FD304
    /* EDAE0 800FD2E0 3800B0AC */   sw        $s0, 0x38($a1)
    /* EDAE4 800FD2E4 2800A38C */  lw         $v1, 0x28($a1)
    /* EDAE8 800FD2E8 01000224 */  addiu      $v0, $zero, 0x1
    /* EDAEC 800FD2EC 05006214 */  bne        $v1, $v0, .L800FD304
    /* EDAF0 800FD2F0 00000000 */   nop
    /* EDAF4 800FD2F4 A400A48C */  lw         $a0, 0xA4($a1)
    /* EDAF8 800FD2F8 3000A58C */  lw         $a1, 0x30($a1)
    /* EDAFC 800FD2FC B3AF030C */  jal        FILE_priorityop
    /* EDB00 800FD300 00000000 */   nop
  .L800FD304:
    /* EDB04 800FD304 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* EDB08 800FD308 1800B08F */  lw         $s0, 0x18($sp)
    /* EDB0C 800FD30C 0800E003 */  jr         $ra
    /* EDB10 800FD310 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel STREAM_setgreedystate
