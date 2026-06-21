.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_SellCar__FR12tMenuCommand, 0x158

glabel MenuExtended_SellCar__FR12tMenuCommand
    /* 1DBA0 8002D3A0 38FFBD27 */  addiu      $sp, $sp, -0xC8
    /* 1DBA4 8002D3A4 1180023C */  lui        $v0, %hi(carManager)
    /* 1DBA8 8002D3A8 BC00B1AF */  sw         $s1, 0xBC($sp)
    /* 1DBAC 8002D3AC 74425124 */  addiu      $s1, $v0, %lo(carManager)
    /* 1DBB0 8002D3B0 1180023C */  lui        $v0, %hi(D_80114723)
    /* 1DBB4 8002D3B4 23474590 */  lbu        $a1, %lo(D_80114723)($v0)
    /* 1DBB8 8002D3B8 1180023C */  lui        $v0, %hi(D_80114AEC)
    /* 1DBBC 8002D3BC B800B0AF */  sw         $s0, 0xB8($sp)
    /* 1DBC0 8002D3C0 EC4A508C */  lw         $s0, %lo(D_80114AEC)($v0)
    /* 1DBC4 8002D3C4 21202002 */  addu       $a0, $s1, $zero
    /* 1DBC8 8002D3C8 C000B2AF */  sw         $s2, 0xC0($sp)
    /* 1DBCC 8002D3CC C400BFAF */  sw         $ra, 0xC4($sp)
    /* 1DBD0 8002D3D0 D158000C */  jal        CalcUsedPrice__11tCarManagers
    /* 1DBD4 8002D3D4 21900000 */   addu      $s2, $zero, $zero
    /* 1DBD8 8002D3D8 21202002 */  addu       $a0, $s1, $zero
    /* 1DBDC 8002D3DC 21284002 */  addu       $a1, $s2, $zero
    /* 1DBE0 8002D3E0 CD5C000C */  jal        GetNumOwnedCars__11tCarManagers
    /* 1DBE4 8002D3E4 21800202 */   addu      $s0, $s0, $v0
    /* 1DBE8 8002D3E8 00140200 */  sll        $v0, $v0, 16
    /* 1DBEC 8002D3EC 03140200 */  sra        $v0, $v0, 16
    /* 1DBF0 8002D3F0 02004228 */  slti       $v0, $v0, 0x2
    /* 1DBF4 8002D3F4 06004010 */  beqz       $v0, .L8002D410
    /* 1DBF8 8002D3F8 00000000 */   nop
    /* 1DBFC 8002D3FC BB58000C */  jal        CheapestCarStockPrice__11tCarManager
    /* 1DC00 8002D400 21202002 */   addu      $a0, $s1, $zero
    /* 1DC04 8002D404 2A100202 */  slt        $v0, $s0, $v0
    /* 1DC08 8002D408 02004014 */  bnez       $v0, .L8002D414
    /* 1DC0C 8002D40C 00000000 */   nop
  .L8002D410:
    /* 1DC10 8002D410 01001224 */  addiu      $s2, $zero, 0x1
  .L8002D414:
    /* 1DC14 8002D414 2B004012 */  beqz       $s2, .L8002D4C4
    /* 1DC18 8002D418 0580023C */   lui       $v0, %hi(FEApp)
    /* 1DC1C 8002D41C A366000C */  jal        __12tDialogYesNo
    /* 1DC20 8002D420 1000A427 */   addiu     $a0, $sp, 0x10
    /* 1DC24 8002D424 94E4020C */  jal        TextSys_Word__Fi
    /* 1DC28 8002D428 A5000424 */   addiu     $a0, $zero, 0xA5
    /* 1DC2C 8002D42C 1000B127 */  addiu      $s1, $sp, 0x10
    /* 1DC30 8002D430 21202002 */  addu       $a0, $s1, $zero
    /* 1DC34 8002D434 900022AE */  sw         $v0, 0x90($s1)
    /* 1DC38 8002D438 21030224 */  addiu      $v0, $zero, 0x321
    /* 1DC3C 8002D43C A00022AE */  sw         $v0, 0xA0($s1)
    /* 1DC40 8002D440 22030224 */  addiu      $v0, $zero, 0x322
    /* 1DC44 8002D444 A40022AE */  sw         $v0, 0xA4($s1)
    /* 1DC48 8002D448 FA65000C */  jal        Run__18tDialogInteractive
    /* 1DC4C 8002D44C 880020A6 */   sh        $zero, 0x88($s1)
    /* 1DC50 8002D450 00140200 */  sll        $v0, $v0, 16
    /* 1DC54 8002D454 16004010 */  beqz       $v0, .L8002D4B0
    /* 1DC58 8002D458 1180043C */   lui       $a0, %hi(carManager)
    /* 1DC5C 8002D45C 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 1DC60 8002D460 1180023C */  lui        $v0, %hi(D_80114729)
    /* 1DC64 8002D464 29474590 */  lbu        $a1, %lo(D_80114729)($v0)
    /* 1DC68 8002D468 4B59000C */  jal        SellCar__11tCarManagerss
    /* 1DC6C 8002D46C 21300000 */   addu      $a2, $zero, $zero
    /* 1DC70 8002D470 21280000 */  addu       $a1, $zero, $zero
    /* 1DC74 8002D474 1180063C */  lui        $a2, %hi(tournamentManager)
    /* 1DC78 8002D478 D84AC624 */  addiu      $a2, $a2, %lo(tournamentManager)
    /* 1DC7C 8002D47C 0580103C */  lui        $s0, %hi(menuDefs)
    /* 1DC80 8002D480 581A048E */  lw         $a0, %lo(menuDefs)($s0)
    /* 1DC84 8002D484 1400C38C */  lw         $v1, 0x14($a2)
    /* 1DC88 8002D488 C41D8424 */  addiu      $a0, $a0, 0x1DC4
    /* 1DC8C 8002D48C 21186200 */  addu       $v1, $v1, $v0
    /* 1DC90 8002D490 2D60000C */  jal        Decrement__16tListIteratorCar7tPlayer
    /* 1DC94 8002D494 1400C3AC */   sw        $v1, 0x14($a2)
    /* 1DC98 8002D498 581A048E */  lw         $a0, %lo(menuDefs)($s0)
    /* 1DC9C 8002D49C 21280000 */  addu       $a1, $zero, $zero
    /* 1DCA0 8002D4A0 2560000C */  jal        Increment__16tListIteratorCar7tPlayer
    /* 1DCA4 8002D4A4 C41D8424 */   addiu     $a0, $a0, 0x1DC4
    /* 1DCA8 8002D4A8 81E5010C */  jal        AudioCmn_PlayFESFX__Fi
    /* 1DCAC 8002D4AC 1A000424 */   addiu     $a0, $zero, 0x1A
  .L8002D4B0:
    /* 1DCB0 8002D4B0 21202002 */  addu       $a0, $s1, $zero
    /* 1DCB4 8002D4B4 1E98000C */  jal        ___7tScreen
    /* 1DCB8 8002D4B8 02000524 */   addiu     $a1, $zero, 0x2
    /* 1DCBC 8002D4BC 38B50008 */  j          .L8002D4E0
    /* 1DCC0 8002D4C0 00000000 */   nop
  .L8002D4C4:
    /* 1DCC4 8002D4C4 C014508C */  lw         $s0, %lo(FEApp)($v0)
    /* 1DCC8 8002D4C8 A9000424 */  addiu      $a0, $zero, 0xA9
    /* 1DCCC 8002D4CC 94E4020C */  jal        TextSys_Word__Fi
    /* 1DCD0 8002D4D0 2C001026 */   addiu     $s0, $s0, 0x2C
    /* 1DCD4 8002D4D4 21200002 */  addu       $a0, $s0, $zero
    /* 1DCD8 8002D4D8 1062000C */  jal        Display__11tDialogBase
    /* 1DCDC 8002D4DC 900082AC */   sw        $v0, 0x90($a0)
  .L8002D4E0:
    /* 1DCE0 8002D4E0 C400BF8F */  lw         $ra, 0xC4($sp)
    /* 1DCE4 8002D4E4 C000B28F */  lw         $s2, 0xC0($sp)
    /* 1DCE8 8002D4E8 BC00B18F */  lw         $s1, 0xBC($sp)
    /* 1DCEC 8002D4EC B800B08F */  lw         $s0, 0xB8($sp)
    /* 1DCF0 8002D4F0 0800E003 */  jr         $ra
    /* 1DCF4 8002D4F4 C800BD27 */   addiu     $sp, $sp, 0xC8
endlabel MenuExtended_SellCar__FR12tMenuCommand
