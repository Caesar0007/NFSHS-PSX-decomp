.set noat
.set noreorder

glabel func_800E4B4C
/* 800E4B4C 27bdffe8 */  addiu    $sp,$sp,-24
/* 800E4B50 afb00010 */  sw       $s0,16($sp)
/* 800E4B54 3c108014 */  lui      $s0,0x8014
/* 800E4B58 8e02f990 */  lw       $v0,-1648($s0)
/* 800E4B5C 00000000 */  nop      
/* 800E4B60 10400007 */  beqz     $v0,.L800E4B80
/* 800E4B64 afbf0014 */  sw       $ra,20($sp)
/* 800E4B68 3c04800e */  lui      $a0,0x800e
/* 800E4B6C 0c03ade4 */  jal      func_800EB790
/* 800E4B70 24844bf4 */  addiu    $a0,$a0,19444
/* 800E4B74 0c03c172 */  jal      func_800F05C8
/* 800E4B78 00000000 */  nop      
/* 800E4B7C ae00f990 */  sw       $zero,-1648($s0)
.L800E4B80:
/* 800E4B80 8fbf0014 */  lw       $ra,20($sp)
/* 800E4B84 8fb00010 */  lw       $s0,16($sp)
/* 800E4B88 03e00008 */  jr       $ra
/* 800E4B8C 27bd0018 */  addiu    $sp,$sp,24
