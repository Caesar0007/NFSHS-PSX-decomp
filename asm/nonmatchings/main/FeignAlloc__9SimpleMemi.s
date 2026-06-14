.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FeignAlloc__9SimpleMemi, 0x20

glabel FeignAlloc__9SimpleMemi
    /* A7A9C 800B729C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A7AA0 800B72A0 1000BFAF */  sw         $ra, 0x10($sp)
    /* A7AA4 800B72A4 94DC020C */  jal        Alloc__9SimpleMemii
    /* A7AA8 800B72A8 01000624 */   addiu     $a2, $zero, 0x1
    /* A7AAC 800B72AC 1000BF8F */  lw         $ra, 0x10($sp)
    /* A7AB0 800B72B0 00000000 */  nop
    /* A7AB4 800B72B4 0800E003 */  jr         $ra
    /* A7AB8 800B72B8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel FeignAlloc__9SimpleMemi
