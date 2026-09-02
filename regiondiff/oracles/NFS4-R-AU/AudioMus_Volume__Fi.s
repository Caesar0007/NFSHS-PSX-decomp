.set noat
.set noreorder

glabel func_8007BC44
/* 8007BC44 27bdffe0 */  addiu    $sp,$sp,-32
/* 8007BC48 afb10014 */  sw       $s1,20($sp)
/* 8007BC4C 00808821 */  move     $s1,$a0
/* 8007BC50 8f8401d8 */  lw       $a0,472($gp)
/* 8007BC54 afbf0018 */  sw       $ra,24($sp)
/* 8007BC58 10800064 */  beqz     $a0,.L8007BDEC
/* 8007BC5C afb00010 */  sw       $s0,16($sp)
/* 8007BC60 8c820000 */  lw       $v0,0($a0)
/* 8007BC64 00000000 */  nop      
/* 8007BC68 10510060 */  beq      $v0,$s1,.L8007BDEC
/* 8007BC6C 00000000 */  nop      
/* 8007BC70 16200006 */  bnez     $s1,.L8007BC8C
/* 8007BC74 00008021 */  move     $s0,$zero
/* 8007BC78 ac800000 */  sw       $zero,0($a0)
/* 8007BC7C 0c01ede6 */  jal      func_8007B798
/* 8007BC80 02002021 */  move     $a0,$s0
/* 8007BC84 0801ef7b */  j        .L8007BDEC
/* 8007BC88 00000000 */  nop      
.L8007BC8C:
/* 8007BC8C 8c820020 */  lw       $v0,32($a0)
/* 8007BC90 00000000 */  nop      
/* 8007BC94 10400021 */  beqz     $v0,.L8007BD1C
/* 8007BC98 00000000 */  nop      
/* 8007BC9C 8c840070 */  lw       $a0,112($a0)
/* 8007BCA0 00000000 */  nop      
/* 8007BCA4 0480001d */  bltz     $a0,.L8007BD1C
/* 8007BCA8 00000000 */  nop      
/* 8007BCAC 0c03a3f1 */  jal      func_800E8FC4
/* 8007BCB0 00000000 */  nop      
/* 8007BCB4 00402021 */  move     $a0,$v0
/* 8007BCB8 18800018 */  blez     $a0,.L8007BD1C
/* 8007BCBC 00000000 */  nop      
/* 8007BCC0 8f8201d8 */  lw       $v0,472($gp)
/* 8007BCC4 00000000 */  nop      
/* 8007BCC8 8c430000 */  lw       $v1,0($v0)
/* 8007BCCC 00000000 */  nop      
/* 8007BCD0 18600012 */  blez     $v1,.L8007BD1C
/* 8007BCD4 00000000 */  nop      
/* 8007BCD8 8c420020 */  lw       $v0,32($v0)
/* 8007BCDC 00000000 */  nop      
/* 8007BCE0 00440018 */  mult     $v0,$a0
/* 8007BCE4 00004012 */  mflo     $t0
/* 8007BCE8 00000000 */  nop      
/* 8007BCEC 00000000 */  nop      
/* 8007BCF0 0103001a */  div      $zero,$t0,$v1
/* 8007BCF4 14600002 */  bnez     $v1,.L8007BD00
/* 8007BCF8 00000000 */  nop      
/* 8007BCFC 0007000d */  break    0x7
.L8007BD00:
/* 8007BD00 2401ffff */  li       $at,-1
/* 8007BD04 14610004 */  bne      $v1,$at,.L8007BD18
/* 8007BD08 3c018000 */  lui      $at,0x8000
/* 8007BD0C 15010002 */  bne      $t0,$at,.L8007BD18
/* 8007BD10 00000000 */  nop      
/* 8007BD14 0006000d */  break    0x6
.L8007BD18:
/* 8007BD18 00008012 */  mflo     $s0
.L8007BD1C:
/* 8007BD1C 00000000 */  nop      
/* 8007BD20 1200001a */  beqz     $s0,.L8007BD8C
/* 8007BD24 02300018 */  mult     $s1,$s0
/* 8007BD28 8f8201d8 */  lw       $v0,472($gp)
/* 8007BD2C 00001812 */  mflo     $v1
/* 8007BD30 8c450020 */  lw       $a1,32($v0)
/* 8007BD34 00000000 */  nop      
/* 8007BD38 0065001a */  div      $zero,$v1,$a1
/* 8007BD3C 14a00002 */  bnez     $a1,.L8007BD48
/* 8007BD40 00000000 */  nop      
/* 8007BD44 0007000d */  break    0x7
.L8007BD48:
/* 8007BD48 2401ffff */  li       $at,-1
/* 8007BD4C 14a10004 */  bne      $a1,$at,.L8007BD60
/* 8007BD50 3c018000 */  lui      $at,0x8000
/* 8007BD54 14610002 */  bne      $v1,$at,.L8007BD60
/* 8007BD58 00000000 */  nop      
/* 8007BD5C 0006000d */  break    0x6
.L8007BD60:
/* 8007BD60 00002812 */  mflo     $a1
/* 8007BD64 8c440070 */  lw       $a0,112($v0)
/* 8007BD68 0c03aa88 */  jal      func_800EAA20
/* 8007BD6C 00000000 */  nop      
/* 8007BD70 8f8201d8 */  lw       $v0,472($gp)
/* 8007BD74 02002821 */  move     $a1,$s0
/* 8007BD78 8c440070 */  lw       $a0,112($v0)
/* 8007BD7C 0c03a9cc */  jal      func_800EA730
/* 8007BD80 00003021 */  move     $a2,$zero
/* 8007BD84 0801ef6f */  j        .L8007BDBC
/* 8007BD88 00000000 */  nop      
.L8007BD8C:
/* 8007BD8C 8f8201d8 */  lw       $v0,472($gp)
/* 8007BD90 00000000 */  nop      
/* 8007BD94 8c440070 */  lw       $a0,112($v0)
/* 8007BD98 00000000 */  nop      
/* 8007BD9C 04800007 */  bltz     $a0,.L8007BDBC
/* 8007BDA0 00000000 */  nop      
/* 8007BDA4 8c430014 */  lw       $v1,20($v0)
/* 8007BDA8 24020002 */  li       $v0,2
/* 8007BDAC 10620003 */  beq      $v1,$v0,.L8007BDBC
/* 8007BDB0 00000000 */  nop      
/* 8007BDB4 0c03aa88 */  jal      func_800EAA20
/* 8007BDB8 02202821 */  move     $a1,$s1
.L8007BDBC:
/* 8007BDBC 8f8301d8 */  lw       $v1,472($gp)
/* 8007BDC0 00000000 */  nop      
/* 8007BDC4 8c620000 */  lw       $v0,0($v1)
/* 8007BDC8 00000000 */  nop      
/* 8007BDCC 14400006 */  bnez     $v0,.L8007BDE8
/* 8007BDD0 00000000 */  nop      
/* 8007BDD4 ac710000 */  sw       $s1,0($v1)
/* 8007BDD8 0c01ee71 */  jal      func_8007B9C4
/* 8007BDDC 00002021 */  move     $a0,$zero
/* 8007BDE0 0801ef7b */  j        .L8007BDEC
/* 8007BDE4 00000000 */  nop      
.L8007BDE8:
/* 8007BDE8 ac710000 */  sw       $s1,0($v1)
.L8007BDEC:
/* 8007BDEC 8fbf0018 */  lw       $ra,24($sp)
/* 8007BDF0 8fb10014 */  lw       $s1,20($sp)
/* 8007BDF4 8fb00010 */  lw       $s0,16($sp)
/* 8007BDF8 03e00008 */  jr       $ra
/* 8007BDFC 27bd0020 */  addiu    $sp,$sp,32
