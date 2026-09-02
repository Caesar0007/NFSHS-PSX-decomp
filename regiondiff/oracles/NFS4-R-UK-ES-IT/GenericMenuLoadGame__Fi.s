.set noat
.set noreorder

glabel func_8002D9A4
/* 8002D9A4 3c028005 */  lui      $v0,0x8005
/* 8002D9A8 8c42230c */  lw       $v0,8972($v0)
/* 8002D9AC 27bdffe0 */  addiu    $sp,$sp,-32
/* 8002D9B0 afb20018 */  sw       $s2,24($sp)
/* 8002D9B4 00809021 */  move     $s2,$a0
/* 8002D9B8 afbf001c */  sw       $ra,28($sp)
/* 8002D9BC afb10014 */  sw       $s1,20($sp)
/* 8002D9C0 14400013 */  bnez     $v0,.L8002DA10
/* 8002D9C4 afb00010 */  sw       $s0,16($sp)
/* 8002D9C8 3c108005 */  lui      $s0,0x8005
/* 8002D9CC 3c118005 */  lui      $s1,0x8005
/* 8002D9D0 8e041db0 */  lw       $a0,7600($s0)
/* 8002D9D4 8e233188 */  lw       $v1,12680($s1)
/* 8002D9D8 2402027e */  li       $v0,638
/* 8002D9DC 0c004e49 */  jal      func_80013924
/* 8002D9E0 ac620584 */  sw       $v0,1412($v1)
/* 8002D9E4 00122400 */  sll      $a0,$s2,0x10
/* 8002D9E8 00042403 */  sra      $a0,$a0,0x10
/* 8002D9EC 00002821 */  move     $a1,$zero
/* 8002D9F0 0c00d3fd */  jal      func_80034FF4
/* 8002D9F4 24060001 */  li       $a2,1
/* 8002D9F8 2402ffff */  li       $v0,-1
/* 8002D9FC 8e041db0 */  lw       $a0,7600($s0)
/* 8002DA00 8e233188 */  lw       $v1,12680($s1)
/* 8002DA04 248402d0 */  addiu    $a0,$a0,720
/* 8002DA08 0c0062b7 */  jal      func_80018ADC
/* 8002DA0C ac620584 */  sw       $v0,1412($v1)
.L8002DA10:
/* 8002DA10 3c028005 */  lui      $v0,0x8005
/* 8002DA14 8c441db0 */  lw       $a0,7600($v0)
/* 8002DA18 0c0062b7 */  jal      func_80018ADC
/* 8002DA1C 248402d0 */  addiu    $a0,$a0,720
/* 8002DA20 8fbf001c */  lw       $ra,28($sp)
/* 8002DA24 8fb20018 */  lw       $s2,24($sp)
/* 8002DA28 8fb10014 */  lw       $s1,20($sp)
/* 8002DA2C 8fb00010 */  lw       $s0,16($sp)
/* 8002DA30 03e00008 */  jr       $ra
/* 8002DA34 27bd0020 */  addiu    $sp,$sp,32
