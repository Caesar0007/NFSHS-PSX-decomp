.set noat
.set noreorder

glabel func_800BEC50
/* 800BEC50 27bdffe8 */  addiu    $sp,$sp,-24
/* 800BEC54 3c028011 */  lui      $v0,0x8011
/* 800BEC58 8c4344dc */  lw       $v1,17628($v0)
/* 800BEC5C 24020001 */  li       $v0,1
/* 800BEC60 afbf0014 */  sw       $ra,20($sp)
/* 800BEC64 14620005 */  bne      $v1,$v0,.L800BEC7C
/* 800BEC68 afb00010 */  sw       $s0,16($sp)
/* 800BEC6C 0c02fa73 */  jal      func_800BE9CC
/* 800BEC70 00000000 */  nop      
/* 800BEC74 0802fb22 */  j        .L800BEC88
/* 800BEC78 3c028011 */  lui      $v0,0x8011
.L800BEC7C:
/* 800BEC7C 0c02fa94 */  jal      func_800BEA50
/* 800BEC80 00000000 */  nop      
/* 800BEC84 3c028011 */  lui      $v0,0x8011
.L800BEC88:
/* 800BEC88 8c4344dc */  lw       $v1,17628($v0)
/* 800BEC8C 24020001 */  li       $v0,1
/* 800BEC90 14620003 */  bne      $v1,$v0,.L800BECA0
/* 800BEC94 3c020002 */  lui      $v0,0x2
/* 800BEC98 0802fb2a */  j        .L800BECA8
/* 800BEC9C 344228e8 */  ori      $v0,$v0,0x28e8
.L800BECA0:
/* 800BECA0 3c020001 */  lui      $v0,0x1
/* 800BECA4 3442f9e8 */  ori      $v0,$v0,0xf9e8
.L800BECA8:
/* 800BECA8 af821270 */  sw       $v0,4720($gp)
/* 800BECAC 3c058014 */  lui      $a1,0x8014
/* 800BECB0 8f841270 */  lw       $a0,4720($gp)
/* 800BECB4 0c0373c4 */  jal      func_800DCF10
/* 800BECB8 24a5eab4 */  addiu    $a1,$a1,-5452
/* 800BECBC 3c058014 */  lui      $a1,0x8014
/* 800BECC0 24a5eab8 */  addiu    $a1,$a1,-5448
/* 800BECC4 3c108012 */  lui      $s0,0x8012
/* 800BECC8 8f841270 */  lw       $a0,4720($gp)
/* 800BECCC 26100740 */  addiu    $s0,$s0,1856
/* 800BECD0 0c0373c4 */  jal      func_800DCF10
/* 800BECD4 ae020014 */  sw       $v0,20($s0)
/* 800BECD8 ae02002c */  sw       $v0,44($s0)
/* 800BECDC 8fbf0014 */  lw       $ra,20($sp)
/* 800BECE0 8fb00010 */  lw       $s0,16($sp)
/* 800BECE4 03e00008 */  jr       $ra
/* 800BECE8 27bd0018 */  addiu    $sp,$sp,24
