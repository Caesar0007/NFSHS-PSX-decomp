.set noat
.set noreorder

glabel func_8002DF20
/* 8002DF20 27bdff38 */  addiu    $sp,$sp,-200
/* 8002DF24 afb100bc */  sw       $s1,188($sp)
/* 8002DF28 00808821 */  move     $s1,$a0
/* 8002DF2C 27a40010 */  addiu    $a0,$sp,16
/* 8002DF30 afbf00c0 */  sw       $ra,192($sp)
/* 8002DF34 0c00664c */  jal      func_80019930
/* 8002DF38 afb000b8 */  sw       $s0,184($sp)
/* 8002DF3C 2404009e */  li       $a0,158
/* 8002DF40 27b00010 */  addiu    $s0,$sp,16
/* 8002DF44 24020322 */  li       $v0,802
/* 8002DF48 ae0200a0 */  sw       $v0,160($s0)
/* 8002DF4C 24020323 */  li       $v0,803
/* 8002DF50 ae0200a4 */  sw       $v0,164($s0)
/* 8002DF54 0c02e733 */  jal      func_800B9CCC
/* 8002DF58 a6000088 */  sh       $zero,136($s0)
/* 8002DF5C 02002021 */  move     $a0,$s0
/* 8002DF60 0c0065a3 */  jal      func_8001968C
/* 8002DF64 ac820090 */  sw       $v0,144($a0)
/* 8002DF68 00021400 */  sll      $v0,$v0,0x10
/* 8002DF6C 10400007 */  beqz     $v0,.L8002DF8C
/* 8002DF70 3c028005 */  lui      $v0,0x8005
/* 8002DF74 8c4219a8 */  lw       $v0,6568($v0)
/* 8002DF78 24030002 */  li       $v1,2
/* 8002DF7C ae230000 */  sw       $v1,0($s1)
/* 8002DF80 244200b0 */  addiu    $v0,$v0,176
/* 8002DF84 0800b7e4 */  j        .L8002DF90
/* 8002DF88 ae220004 */  sw       $v0,4($s1)
.L8002DF8C:
/* 8002DF8C ae200000 */  sw       $zero,0($s1)
.L8002DF90:
/* 8002DF90 27a40010 */  addiu    $a0,$sp,16
/* 8002DF94 0c009758 */  jal      func_80025D60
/* 8002DF98 24050002 */  li       $a1,2
/* 8002DF9C 8fbf00c0 */  lw       $ra,192($sp)
/* 8002DFA0 8fb100bc */  lw       $s1,188($sp)
/* 8002DFA4 8fb000b8 */  lw       $s0,184($sp)
/* 8002DFA8 03e00008 */  jr       $ra
/* 8002DFAC 27bd00c8 */  addiu    $sp,$sp,200
