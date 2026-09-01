.set noat
.set noreorder

glabel func_800E4D4C
/* 800E4D4C 27bdffe8 */  addiu    $sp,$sp,-24
/* 800E4D50 afb00010 */  sw       $s0,16($sp)
/* 800E4D54 3c108014 */  lui      $s0,0x8014
/* 800E4D58 8e02fbd0 */  lw       $v0,-1072($s0)
/* 800E4D5C 00000000 */  nop      
/* 800E4D60 10400007 */  beqz     $v0,.L800E4D80
/* 800E4D64 afbf0014 */  sw       $ra,20($sp)
/* 800E4D68 3c04800e */  lui      $a0,0x800e
/* 800E4D6C 0c03ae64 */  jal      func_800EB990
/* 800E4D70 24844df4 */  addiu    $a0,$a0,19956
/* 800E4D74 0c03c202 */  jal      func_800F0808
/* 800E4D78 00000000 */  nop      
/* 800E4D7C ae00fbd0 */  sw       $zero,-1072($s0)
.L800E4D80:
/* 800E4D80 8fbf0014 */  lw       $ra,20($sp)
/* 800E4D84 8fb00010 */  lw       $s0,16($sp)
/* 800E4D88 03e00008 */  jr       $ra
/* 800E4D8C 27bd0018 */  addiu    $sp,$sp,24
