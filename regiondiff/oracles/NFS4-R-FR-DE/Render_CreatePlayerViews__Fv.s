.set noat
.set noreorder

glabel func_800B3D78
/* 800B3D78 3c028011 */  lui      $v0,0x8011
/* 800B3D7C 8c4244dc */  lw       $v0,17628($v0)
/* 800B3D80 27bdffc0 */  addiu    $sp,$sp,-64
/* 800B3D84 afb30034 */  sw       $s3,52($sp)
/* 800B3D88 24130001 */  li       $s3,1
/* 800B3D8C afbf0038 */  sw       $ra,56($sp)
/* 800B3D90 afb20030 */  sw       $s2,48($sp)
/* 800B3D94 afb1002c */  sw       $s1,44($sp)
/* 800B3D98 1453001b */  bne      $v0,$s3,.L800B3E08
/* 800B3D9C afb00028 */  sw       $s0,40($sp)
/* 800B3DA0 00002021 */  move     $a0,$zero
/* 800B3DA4 24050100 */  li       $a1,256
/* 800B3DA8 24060140 */  li       $a2,320
/* 800B3DAC 00a03821 */  move     $a3,$a1
/* 800B3DB0 00c09021 */  move     $s2,$a2
/* 800B3DB4 24110080 */  li       $s1,128
/* 800B3DB8 241007d0 */  li       $s0,2000
/* 800B3DBC afb20010 */  sw       $s2,16($sp)
/* 800B3DC0 afb10014 */  sw       $s1,20($sp)
/* 800B3DC4 afa00018 */  sw       $zero,24($sp)
/* 800B3DC8 afb3001c */  sw       $s3,28($sp)
/* 800B3DCC 0c02fa2b */  jal      func_800BE8AC
/* 800B3DD0 afb00020 */  sw       $s0,32($sp)
/* 800B3DD4 00002021 */  move     $a0,$zero
/* 800B3DD8 24050180 */  li       $a1,384
/* 800B3DDC 24060140 */  li       $a2,320
/* 800B3DE0 00a03821 */  move     $a3,$a1
/* 800B3DE4 af820e74 */  sw       $v0,3700($gp)
/* 800B3DE8 afb20010 */  sw       $s2,16($sp)
/* 800B3DEC afb10014 */  sw       $s1,20($sp)
/* 800B3DF0 afa00018 */  sw       $zero,24($sp)
/* 800B3DF4 afb3001c */  sw       $s3,28($sp)
/* 800B3DF8 0c02fa2b */  jal      func_800BE8AC
/* 800B3DFC afb00020 */  sw       $s0,32($sp)
/* 800B3E00 0802cf91 */  j        .L800B3E44
/* 800B3E04 00000000 */  nop      
.L800B3E08:
/* 800B3E08 00002021 */  move     $a0,$zero
/* 800B3E0C 24050100 */  li       $a1,256
/* 800B3E10 24060140 */  li       $a2,320
/* 800B3E14 00a03821 */  move     $a3,$a1
/* 800B3E18 00c01021 */  move     $v0,$a2
/* 800B3E1C afa20010 */  sw       $v0,16($sp)
/* 800B3E20 00a01021 */  move     $v0,$a1
/* 800B3E24 afa20014 */  sw       $v0,20($sp)
/* 800B3E28 24020bb8 */  li       $v0,3000
/* 800B3E2C afa00018 */  sw       $zero,24($sp)
/* 800B3E30 afb3001c */  sw       $s3,28($sp)
/* 800B3E34 0c02fa2b */  jal      func_800BE8AC
/* 800B3E38 afa20020 */  sw       $v0,32($sp)
/* 800B3E3C af820e74 */  sw       $v0,3700($gp)
/* 800B3E40 2402ffff */  li       $v0,-1
.L800B3E44:
/* 800B3E44 af820e78 */  sw       $v0,3704($gp)
/* 800B3E48 8fbf0038 */  lw       $ra,56($sp)
/* 800B3E4C 8fb30034 */  lw       $s3,52($sp)
/* 800B3E50 8fb20030 */  lw       $s2,48($sp)
/* 800B3E54 8fb1002c */  lw       $s1,44($sp)
/* 800B3E58 8fb00028 */  lw       $s0,40($sp)
/* 800B3E5C 03e00008 */  jr       $ra
/* 800B3E60 27bd0040 */  addiu    $sp,$sp,64
