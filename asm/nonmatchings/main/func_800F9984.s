.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching cd_read, 0x68

glabel cd_read
    /* EA184 800F9984 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* EA188 800F9988 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* EA18C 800F998C 21888000 */  addu       $s1, $a0, $zero
    /* EA190 800F9990 2120A000 */  addu       $a0, $a1, $zero
    /* EA194 800F9994 1000A527 */  addiu      $a1, $sp, 0x10
    /* EA198 800F9998 1800B0AF */  sw         $s0, 0x18($sp)
    /* EA19C 800F999C 2000BFAF */  sw         $ra, 0x20($sp)
    /* EA1A0 800F99A0 3DDF030C */  jal        CdIntToPos
    /* EA1A4 800F99A4 2180C000 */   addu      $s0, $a2, $zero
    /* EA1A8 800F99A8 02000424 */  addiu      $a0, $zero, 0x2
    /* EA1AC 800F99AC 1000A527 */  addiu      $a1, $sp, 0x10
    /* EA1B0 800F99B0 2DDE030C */  jal        CdControl
    /* EA1B4 800F99B4 21300000 */   addu      $a2, $zero, $zero
    /* EA1B8 800F99B8 21202002 */  addu       $a0, $s1, $zero
    /* EA1BC 800F99BC 21280002 */  addu       $a1, $s0, $zero
    /* EA1C0 800F99C0 7723040C */  jal        CdRead
    /* EA1C4 800F99C4 80000624 */   addiu     $a2, $zero, 0x80
    /* EA1C8 800F99C8 21200000 */  addu       $a0, $zero, $zero
    /* EA1CC 800F99CC DE23040C */  jal        CdReadSync
    /* EA1D0 800F99D0 21280000 */   addu      $a1, $zero, $zero
    /* EA1D4 800F99D4 0100422C */  sltiu      $v0, $v0, 0x1
    /* EA1D8 800F99D8 2000BF8F */  lw         $ra, 0x20($sp)
    /* EA1DC 800F99DC 1C00B18F */  lw         $s1, 0x1C($sp)
    /* EA1E0 800F99E0 1800B08F */  lw         $s0, 0x18($sp)
    /* EA1E4 800F99E4 0800E003 */  jr         $ra
    /* EA1E8 800F99E8 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel cd_read
    /* EA1EC 800F99EC 00000000 */  nop
    /* EA1F0 800F99F0 00000000 */  nop
    /* EA1F4 800F99F4 00000000 */  nop
