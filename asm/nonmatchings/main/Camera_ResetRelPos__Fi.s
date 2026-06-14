.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Camera_ResetRelPos__Fi, 0xB0

glabel Camera_ResetRelPos__Fi
    /* 764D4 80085CD4 21288000 */  addu       $a1, $a0, $zero
    /* 764D8 80085CD8 0100A230 */  andi       $v0, $a1, 0x1
    /* 764DC 80085CDC 12004010 */  beqz       $v0, .L80085D28
    /* 764E0 80085CE0 1180033C */   lui       $v1, %hi(Camera_gInfo)
    /* 764E4 80085CE4 ACF2648C */  lw         $a0, %lo(Camera_gInfo)($v1)
    /* 764E8 80085CE8 00000000 */  nop
    /* 764EC 80085CEC 0801828C */  lw         $v0, 0x108($a0)
    /* 764F0 80085CF0 ACF26324 */  addiu      $v1, $v1, %lo(Camera_gInfo)
    /* 764F4 80085CF4 80100200 */  sll        $v0, $v0, 2
    /* 764F8 80085CF8 23100200 */  negu       $v0, $v0
    /* 764FC 80085CFC 140062AC */  sw         $v0, 0x14($v1)
    /* 76500 80085D00 0C01828C */  lw         $v0, 0x10C($a0)
    /* 76504 80085D04 00000000 */  nop
    /* 76508 80085D08 80100200 */  sll        $v0, $v0, 2
    /* 7650C 80085D0C 23100200 */  negu       $v0, $v0
    /* 76510 80085D10 180062AC */  sw         $v0, 0x18($v1)
    /* 76514 80085D14 1001828C */  lw         $v0, 0x110($a0)
    /* 76518 80085D18 00000000 */  nop
    /* 7651C 80085D1C 80100200 */  sll        $v0, $v0, 2
    /* 76520 80085D20 23100200 */  negu       $v0, $v0
    /* 76524 80085D24 1C0062AC */  sw         $v0, 0x1C($v1)
  .L80085D28:
    /* 76528 80085D28 0200A230 */  andi       $v0, $a1, 0x2
    /* 7652C 80085D2C 13004010 */  beqz       $v0, .L80085D7C
    /* 76530 80085D30 1180033C */   lui       $v1, %hi(Camera_gInfo)
    /* 76534 80085D34 ACF26324 */  addiu      $v1, $v1, %lo(Camera_gInfo)
    /* 76538 80085D38 1001648C */  lw         $a0, 0x110($v1)
    /* 7653C 80085D3C 00000000 */  nop
    /* 76540 80085D40 0801828C */  lw         $v0, 0x108($a0)
    /* 76544 80085D44 00000000 */  nop
    /* 76548 80085D48 80100200 */  sll        $v0, $v0, 2
    /* 7654C 80085D4C 23100200 */  negu       $v0, $v0
    /* 76550 80085D50 240162AC */  sw         $v0, 0x124($v1)
    /* 76554 80085D54 0C01828C */  lw         $v0, 0x10C($a0)
    /* 76558 80085D58 00000000 */  nop
    /* 7655C 80085D5C 80100200 */  sll        $v0, $v0, 2
    /* 76560 80085D60 23100200 */  negu       $v0, $v0
    /* 76564 80085D64 280162AC */  sw         $v0, 0x128($v1)
    /* 76568 80085D68 1001828C */  lw         $v0, 0x110($a0)
    /* 7656C 80085D6C 00000000 */  nop
    /* 76570 80085D70 80100200 */  sll        $v0, $v0, 2
    /* 76574 80085D74 23100200 */  negu       $v0, $v0
    /* 76578 80085D78 2C0162AC */  sw         $v0, 0x12C($v1)
  .L80085D7C:
    /* 7657C 80085D7C 0800E003 */  jr         $ra
    /* 76580 80085D80 00000000 */   nop
endlabel Camera_ResetRelPos__Fi
