.set noat
.set noreorder

glabel func_800E4D60
/* 800E4D60 27bdffe8 */  addiu    $sp,$sp,-24
/* 800E4D64 afb00010 */  sw       $s0,16($sp)
/* 800E4D68 3c108014 */  lui      $s0,0x8014
/* 800E4D6C 8e02fba4 */  lw       $v0,-1116($s0)
/* 800E4D70 00000000 */  nop      
/* 800E4D74 10400007 */  beqz     $v0,.L800E4D94
/* 800E4D78 afbf0014 */  sw       $ra,20($sp)
/* 800E4D7C 3c04800e */  lui      $a0,0x800e
/* 800E4D80 0c03ae69 */  jal      func_800EB9A4
/* 800E4D84 24844e08 */  addiu    $a0,$a0,19976
/* 800E4D88 0c03c1f7 */  jal      func_800F07DC
/* 800E4D8C 00000000 */  nop      
/* 800E4D90 ae00fba4 */  sw       $zero,-1116($s0)
.L800E4D94:
/* 800E4D94 8fbf0014 */  lw       $ra,20($sp)
/* 800E4D98 8fb00010 */  lw       $s0,16($sp)
/* 800E4D9C 03e00008 */  jr       $ra
/* 800E4DA0 27bd0018 */  addiu    $sp,$sp,24
