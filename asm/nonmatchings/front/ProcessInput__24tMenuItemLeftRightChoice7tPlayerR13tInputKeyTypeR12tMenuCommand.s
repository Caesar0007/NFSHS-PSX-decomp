.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__24tMenuItemLeftRightChoice7tPlayerR13tInputKeyTypeR12tMenuCommand, 0xB0

glabel ProcessInput__24tMenuItemLeftRightChoice7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* 1517C 8002497C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 15180 80024980 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 15184 80024984 1800B0AF */  sw         $s0, 0x18($sp)
    /* 15188 80024988 0000828C */  lw         $v0, 0x0($a0)
    /* 1518C 8002498C 00000000 */  nop
    /* 15190 80024990 01004230 */  andi       $v0, $v0, 0x1
    /* 15194 80024994 21004014 */  bnez       $v0, .L80024A1C
    /* 15198 80024998 2180C000 */   addu      $s0, $a2, $zero
    /* 1519C 8002499C 0000038E */  lw         $v1, 0x0($s0)
    /* 151A0 800249A0 00080224 */  addiu      $v0, $zero, 0x800
    /* 151A4 800249A4 05006210 */  beq        $v1, $v0, .L800249BC
    /* 151A8 800249A8 00100224 */   addiu     $v0, $zero, 0x1000
    /* 151AC 800249AC 0E006210 */  beq        $v1, $v0, .L800249E8
    /* 151B0 800249B0 00000000 */   nop
    /* 151B4 800249B4 87920008 */  j          .L80024A1C
    /* 151B8 800249B8 00000000 */   nop
  .L800249BC:
    /* 151BC 800249BC 1C00838C */  lw         $v1, 0x1C($a0)
    /* 151C0 800249C0 00000000 */  nop
    /* 151C4 800249C4 0C00628C */  lw         $v0, 0xC($v1)
    /* 151C8 800249C8 00000000 */  nop
    /* 151CC 800249CC 28004484 */  lh         $a0, 0x28($v0)
    /* 151D0 800249D0 2C00428C */  lw         $v0, 0x2C($v0)
    /* 151D4 800249D4 00000000 */  nop
    /* 151D8 800249D8 09F84000 */  jalr       $v0
    /* 151DC 800249DC 21206400 */   addu      $a0, $v1, $a0
    /* 151E0 800249E0 84920008 */  j          .L80024A10
    /* 151E4 800249E4 05000424 */   addiu     $a0, $zero, 0x5
  .L800249E8:
    /* 151E8 800249E8 1C00838C */  lw         $v1, 0x1C($a0)
    /* 151EC 800249EC 00000000 */  nop
    /* 151F0 800249F0 0C00628C */  lw         $v0, 0xC($v1)
    /* 151F4 800249F4 00000000 */  nop
    /* 151F8 800249F8 20004484 */  lh         $a0, 0x20($v0)
    /* 151FC 800249FC 2400428C */  lw         $v0, 0x24($v0)
    /* 15200 80024A00 00000000 */  nop
    /* 15204 80024A04 09F84000 */  jalr       $v0
    /* 15208 80024A08 21206400 */   addu      $a0, $v1, $a0
    /* 1520C 80024A0C 06000424 */  addiu      $a0, $zero, 0x6
  .L80024A10:
    /* 15210 80024A10 01000224 */  addiu      $v0, $zero, 0x1
    /* 15214 80024A14 81E5010C */  jal        AudioCmn_PlayFESFX__Fi
    /* 15218 80024A18 000002AE */   sw        $v0, 0x0($s0)
  .L80024A1C:
    /* 1521C 80024A1C 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 15220 80024A20 1800B08F */  lw         $s0, 0x18($sp)
    /* 15224 80024A24 0800E003 */  jr         $ra
    /* 15228 80024A28 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ProcessInput__24tMenuItemLeftRightChoice7tPlayerR13tInputKeyTypeR12tMenuCommand
