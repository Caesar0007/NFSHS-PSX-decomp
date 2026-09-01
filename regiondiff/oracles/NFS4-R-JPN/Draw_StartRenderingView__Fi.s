.set noat
.set noreorder

glabel func_800BEB98
/* 800BEB98 00804021 */  move     $t0,$a0
/* 800BEB9C 00081040 */  sll      $v0,$t0,0x1
/* 800BEBA0 00481021 */  addu     $v0,$v0,$t0
/* 800BEBA4 000210c0 */  sll      $v0,$v0,0x3
/* 800BEBA8 00481021 */  addu     $v0,$v0,$t0
/* 800BEBAC 000210c0 */  sll      $v0,$v0,0x3
/* 800BEBB0 3c038012 */  lui      $v1,0x8012
/* 800BEBB4 2463fd30 */  addiu    $v1,$v1,-720
/* 800BEBB8 00433021 */  addu     $a2,$v0,$v1
/* 800BEBBC 8cc20000 */  lw       $v0,0($a2)
/* 800BEBC0 00000000 */  nop      
/* 800BEBC4 000218c0 */  sll      $v1,$v0,0x3
/* 800BEBC8 00622823 */  subu     $a1,$v1,$v0
/* 800BEBCC af82125c */  sw       $v0,4700($gp)
/* 800BEBD0 04a10002 */  bgez     $a1,.L800BEBDC
/* 800BEBD4 3c071f80 */  lui      $a3,0x1f80
/* 800BEBD8 24a50007 */  addiu    $a1,$a1,7
.L800BEBDC:
/* 800BEBDC 94c2000c */  lhu      $v0,12($a2)
/* 800BEBE0 3c048014 */  lui      $a0,0x8014
/* 800BEBE4 8c84e3f4 */  lw       $a0,-7180($a0)
/* 800BEBE8 a4e20010 */  sh       $v0,16($a3)
/* 800BEBEC 8f821260 */  lw       $v0,4704($gp)
/* 800BEBF0 94c3000e */  lhu      $v1,14($a2)
/* 800BEBF4 00021080 */  sll      $v0,$v0,0x2
/* 800BEBF8 00c21021 */  addu     $v0,$a2,$v0
/* 800BEBFC a4e30012 */  sh       $v1,18($a3)
/* 800BEC00 8c4300c0 */  lw       $v1,192($v0)
/* 800BEC04 000510c3 */  sra      $v0,$a1,0x3
/* 800BEC08 af821268 */  sw       $v0,4712($gp)
/* 800BEC0C 10800007 */  beqz     $a0,.L800BEC2C
/* 800BEC10 ace30000 */  sw       $v1,0($a3)
/* 800BEC14 8ce20004 */  lw       $v0,4($a3)
/* 800BEC18 8cc30004 */  lw       $v1,4($a2)
/* 800BEC1C 00000000 */  nop      
/* 800BEC20 00431021 */  addu     $v0,$v0,$v1
/* 800BEC24 0802fb20 */  j        .L800BEC80
/* 800BEC28 ace20008 */  sw       $v0,8($a3)
.L800BEC2C:
/* 800BEC2C 8f82126c */  lw       $v0,4716($gp)
/* 800BEC30 00000000 */  nop      
/* 800BEC34 2444fe60 */  addiu    $a0,$v0,-416
/* 800BEC38 3c028011 */  lui      $v0,0x8011
/* 800BEC3C 8c43429c */  lw       $v1,17052($v0)
/* 800BEC40 24020001 */  li       $v0,1
/* 800BEC44 1462000d */  bne      $v1,$v0,.L800BEC7C
/* 800BEC48 00000000 */  nop      
/* 800BEC4C 3c028014 */  lui      $v0,0x8014
/* 800BEC50 8c42e49c */  lw       $v0,-7012($v0)
/* 800BEC54 00000000 */  nop      
/* 800BEC58 15020008 */  bne      $t0,$v0,.L800BEC7C
/* 800BEC5C 00000000 */  nop      
/* 800BEC60 8ce30004 */  lw       $v1,4($a3)
/* 800BEC64 00000000 */  nop      
/* 800BEC68 00831023 */  subu     $v0,$a0,$v1
/* 800BEC6C 00021043 */  sra      $v0,$v0,0x1
/* 800BEC70 00621821 */  addu     $v1,$v1,$v0
/* 800BEC74 0802fb20 */  j        .L800BEC80
/* 800BEC78 ace30008 */  sw       $v1,8($a3)
.L800BEC7C:
/* 800BEC7C ace40008 */  sw       $a0,8($a3)
.L800BEC80:
/* 800BEC80 03e00008 */  jr       $ra
/* 800BEC84 ace0000c */  sw       $zero,12($a3)
