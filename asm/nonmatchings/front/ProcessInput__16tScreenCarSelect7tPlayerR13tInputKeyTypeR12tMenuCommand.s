.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__16tScreenCarSelect7tPlayerR13tInputKeyTypeR12tMenuCommand, 0x188

glabel ProcessInput__16tScreenCarSelect7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* 2C790 8003BF90 10FFBD27 */  addiu      $sp, $sp, -0xF0
    /* 2C794 8003BF94 E000B0AF */  sw         $s0, 0xE0($sp)
    /* 2C798 8003BF98 E400B1AF */  sw         $s1, 0xE4($sp)
    /* 2C79C 8003BF9C 2188C000 */  addu       $s1, $a2, $zero
    /* 2C7A0 8003BFA0 E800BFAF */  sw         $ra, 0xE8($sp)
    /* 2C7A4 8003BFA4 0000238E */  lw         $v1, 0x0($s1)
    /* 2C7A8 8003BFA8 08000224 */  addiu      $v0, $zero, 0x8
    /* 2C7AC 8003BFAC 37006214 */  bne        $v1, $v0, .L8003C08C
    /* 2C7B0 8003BFB0 21808000 */   addu      $s0, $a0, $zero
    /* 2C7B4 8003BFB4 6000028E */  lw         $v0, 0x60($s0)
    /* 2C7B8 8003BFB8 1000A527 */  addiu      $a1, $sp, 0x10
    /* 2C7BC 8003BFBC 68004484 */  lh         $a0, 0x68($v0)
    /* 2C7C0 8003BFC0 6C00428C */  lw         $v0, 0x6C($v0)
    /* 2C7C4 8003BFC4 00000000 */  nop
    /* 2C7C8 8003BFC8 09F84000 */  jalr       $v0
    /* 2C7CC 8003BFCC 21200402 */   addu      $a0, $s0, $a0
    /* 2C7D0 8003BFD0 0580033C */  lui        $v1, %hi(FEApp)
    /* 2C7D4 8003BFD4 C014638C */  lw         $v1, %lo(FEApp)($v1)
    /* 2C7D8 8003BFD8 00000000 */  nop
    /* 2C7DC 8003BFDC 2C026390 */  lbu        $v1, 0x22C($v1)
    /* 2C7E0 8003BFE0 00000000 */  nop
    /* 2C7E4 8003BFE4 05006014 */  bnez       $v1, .L8003BFFC
    /* 2C7E8 8003BFE8 21284000 */   addu      $a1, $v0, $zero
    /* 2C7EC 8003BFEC 0580023C */  lui        $v0, %hi(menuDefs)
    /* 2C7F0 8003BFF0 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 2C7F4 8003BFF4 03F00008 */  j          .L8003C00C
    /* 2C7F8 8003BFF8 18204424 */   addiu     $a0, $v0, 0x2018
  .L8003BFFC:
    /* 2C7FC 8003BFFC 0580023C */  lui        $v0, %hi(menuDefs)
    /* 2C800 8003C000 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 2C804 8003C004 00000000 */  nop
    /* 2C808 8003C008 78204424 */  addiu      $a0, $v0, 0x2078
  .L8003C00C:
    /* 2C80C 8003C00C 0B010224 */  addiu      $v0, $zero, 0x10B
    /* 2C810 8003C010 0D00A010 */  beqz       $a1, .L8003C048
    /* 2C814 8003C014 040082AC */   sw        $v0, 0x4($a0)
    /* 2C818 8003C018 1000A383 */  lb         $v1, 0x10($sp)
    /* 2C81C 8003C01C 08000224 */  addiu      $v0, $zero, 0x8
    /* 2C820 8003C020 05006214 */  bne        $v1, $v0, .L8003C038
    /* 2C824 8003C024 01000224 */   addiu     $v0, $zero, 0x1
    /* 2C828 8003C028 0C010224 */  addiu      $v0, $zero, 0x10C
    /* 2C82C 8003C02C 040082AC */  sw         $v0, 0x4($a0)
    /* 2C830 8003C030 1000A383 */  lb         $v1, 0x10($sp)
    /* 2C834 8003C034 01000224 */  addiu      $v0, $zero, 0x1
  .L8003C038:
    /* 2C838 8003C038 04006214 */  bne        $v1, $v0, .L8003C04C
    /* 2C83C 8003C03C 1180023C */   lui       $v0, %hi(frontEnd)
    /* 2C840 8003C040 0D010224 */  addiu      $v0, $zero, 0x10D
    /* 2C844 8003C044 040082AC */  sw         $v0, 0x4($a0)
  .L8003C048:
    /* 2C848 8003C048 1180023C */  lui        $v0, %hi(frontEnd)
  .L8003C04C:
    /* 2C84C 8003C04C 00464424 */  addiu      $a0, $v0, %lo(frontEnd)
    /* 2C850 8003C050 1E038290 */  lbu        $v0, 0x31E($a0)
    /* 2C854 8003C054 01000324 */  addiu      $v1, $zero, 0x1
    /* 2C858 8003C058 05004310 */  beq        $v0, $v1, .L8003C070
    /* 2C85C 8003C05C 0580023C */   lui       $v0, %hi(menuDefs)
    /* 2C860 8003C060 03008290 */  lbu        $v0, 0x3($a0)
    /* 2C864 8003C064 00000000 */  nop
    /* 2C868 8003C068 07004314 */  bne        $v0, $v1, .L8003C088
    /* 2C86C 8003C06C 0580023C */   lui       $v0, %hi(menuDefs)
  .L8003C070:
    /* 2C870 8003C070 581A438C */  lw         $v1, %lo(menuDefs)($v0)
    /* 2C874 8003C074 00000000 */  nop
    /* 2C878 8003C078 B820628C */  lw         $v0, 0x20B8($v1)
    /* 2C87C 8003C07C 00000000 */  nop
    /* 2C880 8003C080 01004234 */  ori        $v0, $v0, 0x1
    /* 2C884 8003C084 B82062AC */  sw         $v0, 0x20B8($v1)
  .L8003C088:
    /* 2C888 8003C088 0000238E */  lw         $v1, 0x0($s1)
  .L8003C08C:
    /* 2C88C 8003C08C 10000224 */  addiu      $v0, $zero, 0x10
    /* 2C890 8003C090 1C006214 */  bne        $v1, $v0, .L8003C104
    /* 2C894 8003C094 05000224 */   addiu     $v0, $zero, 0x5
    /* 2C898 8003C098 1C010386 */  lh         $v1, 0x11C($s0)
    /* 2C89C 8003C09C 00000000 */  nop
    /* 2C8A0 8003C0A0 0C006210 */  beq        $v1, $v0, .L8003C0D4
    /* 2C8A4 8003C0A4 06006228 */   slti      $v0, $v1, 0x6
    /* 2C8A8 8003C0A8 05004010 */  beqz       $v0, .L8003C0C0
    /* 2C8AC 8003C0AC 02006228 */   slti      $v0, $v1, 0x2
    /* 2C8B0 8003C0B0 14004014 */  bnez       $v0, .L8003C104
    /* 2C8B4 8003C0B4 1180023C */   lui       $v0, %hi(D_80114603)
    /* 2C8B8 8003C0B8 3AF00008 */  j          .L8003C0E8
    /* 2C8BC 8003C0BC 00000000 */   nop
  .L8003C0C0:
    /* 2C8C0 8003C0C0 06000224 */  addiu      $v0, $zero, 0x6
    /* 2C8C4 8003C0C4 06006210 */  beq        $v1, $v0, .L8003C0E0
    /* 2C8C8 8003C0C8 21200002 */   addu      $a0, $s0, $zero
    /* 2C8CC 8003C0CC 41F00008 */  j          .L8003C104
    /* 2C8D0 8003C0D0 00000000 */   nop
  .L8003C0D4:
    /* 2C8D4 8003C0D4 21200002 */  addu       $a0, $s0, $zero
    /* 2C8D8 8003C0D8 3FF00008 */  j          .L8003C0FC
    /* 2C8DC 8003C0DC 21280000 */   addu      $a1, $zero, $zero
  .L8003C0E0:
    /* 2C8E0 8003C0E0 3FF00008 */  j          .L8003C0FC
    /* 2C8E4 8003C0E4 02000524 */   addiu     $a1, $zero, 0x2
  .L8003C0E8:
    /* 2C8E8 8003C0E8 03464390 */  lbu        $v1, %lo(D_80114603)($v0)
    /* 2C8EC 8003C0EC 01000224 */  addiu      $v0, $zero, 0x1
    /* 2C8F0 8003C0F0 04006210 */  beq        $v1, $v0, .L8003C104
    /* 2C8F4 8003C0F4 21200002 */   addu      $a0, $s0, $zero
    /* 2C8F8 8003C0F8 21284000 */  addu       $a1, $v0, $zero
  .L8003C0FC:
    /* 2C8FC 8003C0FC 67ED000C */  jal        SetState__16tScreenCarSelecti
    /* 2C900 8003C100 00000000 */   nop
  .L8003C104:
    /* 2C904 8003C104 E800BF8F */  lw         $ra, 0xE8($sp)
    /* 2C908 8003C108 E400B18F */  lw         $s1, 0xE4($sp)
    /* 2C90C 8003C10C E000B08F */  lw         $s0, 0xE0($sp)
    /* 2C910 8003C110 0800E003 */  jr         $ra
    /* 2C914 8003C114 F000BD27 */   addiu     $sp, $sp, 0xF0
endlabel ProcessInput__16tScreenCarSelect7tPlayerR13tInputKeyTypeR12tMenuCommand
