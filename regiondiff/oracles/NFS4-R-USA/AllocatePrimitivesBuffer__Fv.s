.set noat
.set noreorder

glabel func_800BEC4C
/* 800BEC4C 27bdffe8 */  addiu    $sp,$sp,-24
/* 800BEC50 3c028011 */  lui      $v0,0x8011
/* 800BEC54 8c4344b0 */  lw       $v1,17584($v0)
/* 800BEC58 24020001 */  li       $v0,1
/* 800BEC5C afbf0014 */  sw       $ra,20($sp)
/* 800BEC60 14620005 */  bne      $v1,$v0,.L800BEC78
/* 800BEC64 afb00010 */  sw       $s0,16($sp)
/* 800BEC68 0c02fa72 */  jal      func_800BE9C8
/* 800BEC6C 00000000 */  nop      
/* 800BEC70 0802fb21 */  j        .L800BEC84
/* 800BEC74 3c028011 */  lui      $v0,0x8011
.L800BEC78:
/* 800BEC78 0c02fa93 */  jal      func_800BEA4C
/* 800BEC7C 00000000 */  nop      
/* 800BEC80 3c028011 */  lui      $v0,0x8011
.L800BEC84:
/* 800BEC84 8c4344b0 */  lw       $v1,17584($v0)
/* 800BEC88 24020001 */  li       $v0,1
/* 800BEC8C 14620003 */  bne      $v1,$v0,.L800BEC9C
/* 800BEC90 3c020002 */  lui      $v0,0x2
/* 800BEC94 0802fb29 */  j        .L800BECA4
/* 800BEC98 344228e8 */  ori      $v0,$v0,0x28e8
.L800BEC9C:
/* 800BEC9C 3c020001 */  lui      $v0,0x1
/* 800BECA0 3442f9e8 */  ori      $v0,$v0,0xf9e8
.L800BECA4:
/* 800BECA4 af821270 */  sw       $v0,4720($gp)
/* 800BECA8 3c058014 */  lui      $a1,0x8014
/* 800BECAC 8f841270 */  lw       $a0,4720($gp)
/* 800BECB0 0c0373b9 */  jal      func_800DCEE4
/* 800BECB4 24a5ea88 */  addiu    $a1,$a1,-5496
/* 800BECB8 3c058014 */  lui      $a1,0x8014
/* 800BECBC 24a5ea8c */  addiu    $a1,$a1,-5492
/* 800BECC0 3c108012 */  lui      $s0,0x8012
/* 800BECC4 8f841270 */  lw       $a0,4720($gp)
/* 800BECC8 26100714 */  addiu    $s0,$s0,1812
/* 800BECCC 0c0373b9 */  jal      func_800DCEE4
/* 800BECD0 ae020014 */  sw       $v0,20($s0)
/* 800BECD4 ae02002c */  sw       $v0,44($s0)
/* 800BECD8 8fbf0014 */  lw       $ra,20($sp)
/* 800BECDC 8fb00010 */  lw       $s0,16($sp)
/* 800BECE0 03e00008 */  jr       $ra
/* 800BECE4 27bd0018 */  addiu    $sp,$sp,24
