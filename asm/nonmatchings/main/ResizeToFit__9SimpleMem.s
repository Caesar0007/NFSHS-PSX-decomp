.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ResizeToFit__9SimpleMem, 0x30

glabel ResizeToFit__9SimpleMem
    /* A7ABC 800B72BC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A7AC0 800B72C0 1000BFAF */  sw         $ra, 0x10($sp)
    /* A7AC4 800B72C4 0400858C */  lw         $a1, 0x4($a0)
    /* A7AC8 800B72C8 0000828C */  lw         $v0, 0x0($a0)
    /* A7ACC 800B72CC 040080AC */  sw         $zero, 0x4($a0)
    /* A7AD0 800B72D0 21204000 */  addu       $a0, $v0, $zero
    /* A7AD4 800B72D4 54C6030C */  jal        resizememadr
    /* A7AD8 800B72D8 2328A200 */   subu      $a1, $a1, $v0
    /* A7ADC 800B72DC 1000BF8F */  lw         $ra, 0x10($sp)
    /* A7AE0 800B72E0 00000000 */  nop
    /* A7AE4 800B72E4 0800E003 */  jr         $ra
    /* A7AE8 800B72E8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ResizeToFit__9SimpleMem
