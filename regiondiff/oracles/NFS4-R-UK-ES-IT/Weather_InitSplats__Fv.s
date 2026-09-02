.set noat
.set noreorder

glabel func_800E2C10
/* 800E2C10 27bdffd8 */  addiu    $sp,$sp,-40
/* 800E2C14 afb20018 */  sw       $s2,24($sp)
/* 800E2C18 00009021 */  move     $s2,$zero
/* 800E2C1C 3c028011 */  lui      $v0,0x8011
/* 800E2C20 afb40020 */  sw       $s4,32($sp)
/* 800E2C24 245444d0 */  addiu    $s4,$v0,17616
/* 800E2C28 afb3001c */  sw       $s3,28($sp)
/* 800E2C2C 24130001 */  li       $s3,1
/* 800E2C30 afbf0024 */  sw       $ra,36($sp)
/* 800E2C34 afb10014 */  sw       $s1,20($sp)
/* 800E2C38 afb00010 */  sw       $s0,16($sp)
.L800E2C3C:
/* 800E2C3C 2a420013 */  slti     $v0,$s2,19
/* 800E2C40 10400030 */  beqz     $v0,.L800E2D04
/* 800E2C44 00000000 */  nop      
/* 800E2C48 8e82000c */  lw       $v0,12($s4)
/* 800E2C4C 00000000 */  nop      
/* 800E2C50 14530002 */  bne      $v0,$s3,.L800E2C5C
/* 800E2C54 24110100 */  li       $s1,256
/* 800E2C58 24110080 */  li       $s1,128
.L800E2C5C:
/* 800E2C5C 0c03a0e0 */  jal      func_800E8380
/* 800E2C60 001280c0 */  sll      $s0,$s2,0x3
/* 800E2C64 3c03cccc */  lui      $v1,0xcccc
/* 800E2C68 3463cccd */  ori      $v1,$v1,0xcccd
/* 800E2C6C 00430019 */  multu    $v0,$v1
/* 800E2C70 8f851650 */  lw       $a1,5712($gp)
/* 800E2C74 00000000 */  nop      
/* 800E2C78 02052821 */  addu     $a1,$s0,$a1
/* 800E2C7C 00001810 */  mfhi     $v1
/* 800E2C80 00032202 */  srl      $a0,$v1,0x8
/* 800E2C84 00041880 */  sll      $v1,$a0,0x2
/* 800E2C88 00641821 */  addu     $v1,$v1,$a0
/* 800E2C8C 00031980 */  sll      $v1,$v1,0x6
/* 800E2C90 00431023 */  subu     $v0,$v0,$v1
/* 800E2C94 0c03a0e0 */  jal      func_800E8380
/* 800E2C98 a4a20000 */  sh       $v0,0($a1)
/* 800E2C9C 0051001b */  divu     $zero,$v0,$s1
/* 800E2CA0 16200002 */  bnez     $s1,.L800E2CAC
/* 800E2CA4 00000000 */  nop      
/* 800E2CA8 0007000d */  break    0x7
.L800E2CAC:
/* 800E2CAC 00001810 */  mfhi     $v1
/* 800E2CB0 8f821650 */  lw       $v0,5712($gp)
/* 800E2CB4 00000000 */  nop      
/* 800E2CB8 02021021 */  addu     $v0,$s0,$v0
/* 800E2CBC 0c03a0e0 */  jal      func_800E8380
/* 800E2CC0 a4430002 */  sh       $v1,2($v0)
/* 800E2CC4 3c031b4e */  lui      $v1,0x1b4e
/* 800E2CC8 346381b5 */  ori      $v1,$v1,0x81b5
/* 800E2CCC 00430019 */  multu    $v0,$v1
/* 800E2CD0 8f831650 */  lw       $v1,5712($gp)
/* 800E2CD4 26520001 */  addiu    $s2,$s2,1
/* 800E2CD8 02038021 */  addu     $s0,$s0,$v1
/* 800E2CDC 00002010 */  mfhi     $a0
/* 800E2CE0 00041942 */  srl      $v1,$a0,0x5
/* 800E2CE4 00032080 */  sll      $a0,$v1,0x2
/* 800E2CE8 00832021 */  addu     $a0,$a0,$v1
/* 800E2CEC 00041900 */  sll      $v1,$a0,0x4
/* 800E2CF0 00641823 */  subu     $v1,$v1,$a0
/* 800E2CF4 00031880 */  sll      $v1,$v1,0x2
/* 800E2CF8 00431023 */  subu     $v0,$v0,$v1
/* 800E2CFC 08038b0f */  j        .L800E2C3C
/* 800E2D00 ae020004 */  sw       $v0,4($s0)
.L800E2D04:
/* 800E2D04 8fbf0024 */  lw       $ra,36($sp)
/* 800E2D08 8fb40020 */  lw       $s4,32($sp)
/* 800E2D0C 8fb3001c */  lw       $s3,28($sp)
/* 800E2D10 8fb20018 */  lw       $s2,24($sp)
/* 800E2D14 8fb10014 */  lw       $s1,20($sp)
/* 800E2D18 8fb00010 */  lw       $s0,16($sp)
/* 800E2D1C 03e00008 */  jr       $ra
/* 800E2D20 27bd0028 */  addiu    $sp,$sp,40
