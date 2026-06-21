.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8002D9E8, 0x11C

glabel func_8002D9E8
    /* 1E1E8 8002D9E8 08FFBD27 */  addiu      $sp, $sp, -0xF8
    /* 1E1EC 8002D9EC EC00B3AF */  sw         $s3, 0xEC($sp)
    /* 1E1F0 8002D9F0 21980000 */  addu       $s3, $zero, $zero
    /* 1E1F4 8002D9F4 1180023C */  lui        $v0, %hi(carManager)
    /* 1E1F8 8002D9F8 E800B2AF */  sw         $s2, 0xE8($sp)
    /* 1E1FC 8002D9FC 74425224 */  addiu      $s2, $v0, %lo(carManager)
    /* 1E200 8002DA00 21204002 */  addu       $a0, $s2, $zero
    /* 1E204 8002DA04 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1E208 8002DA08 E400B1AF */  sw         $s1, 0xE4($sp)
    /* 1E20C 8002DA0C 00465124 */  addiu      $s1, $v0, %lo(frontEnd)
    /* 1E210 8002DA10 F000BFAF */  sw         $ra, 0xF0($sp)
    /* 1E214 8002DA14 E000B0AF */  sw         $s0, 0xE0($sp)
    /* 1E218 8002DA18 5C002592 */  lbu        $a1, 0x5C($s1)
    /* 1E21C 8002DA1C A45B000C */  jal        GetStockCar__11tCarManagersR8tCarInfo
    /* 1E220 8002DA20 1000A627 */   addiu     $a2, $sp, 0x10
    /* 1E224 8002DA24 1200A393 */  lbu        $v1, 0x12($sp)
    /* 1E228 8002DA28 07000224 */  addiu      $v0, $zero, 0x7
    /* 1E22C 8002DA2C 2E006214 */  bne        $v1, $v0, .L8002DAE8
    /* 1E230 8002DA30 21106002 */   addu      $v0, $s3, $zero
    /* 1E234 8002DA34 04002392 */  lbu        $v1, 0x4($s1)
    /* 1E238 8002DA38 01000224 */  addiu      $v0, $zero, 0x1
    /* 1E23C 8002DA3C 2A006214 */  bne        $v1, $v0, .L8002DAE8
    /* 1E240 8002DA40 21106002 */   addu      $v0, $s3, $zero
    /* 1E244 8002DA44 03002292 */  lbu        $v0, 0x3($s1)
    /* 1E248 8002DA48 00000000 */  nop
    /* 1E24C 8002DA4C 25004310 */  beq        $v0, $v1, .L8002DAE4
    /* 1E250 8002DA50 1180023C */   lui       $v0, %hi(GameSetup_gData)
    /* 1E254 8002DA54 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* 1E258 8002DA58 B801438C */  lw         $v1, 0x1B8($v0)
    /* 1E25C 8002DA5C AC01428C */  lw         $v0, 0x1AC($v0)
    /* 1E260 8002DA60 00000000 */  nop
    /* 1E264 8002DA64 2A104300 */  slt        $v0, $v0, $v1
    /* 1E268 8002DA68 1E004010 */  beqz       $v0, .L8002DAE4
    /* 1E26C 8002DA6C 0580053C */   lui       $a1, %hi(D_800519E0)
    /* 1E270 8002DA70 1000A383 */  lb         $v1, 0x10($sp)
    /* 1E274 8002DA74 E019A524 */  addiu      $a1, $a1, %lo(D_800519E0)
    /* 1E278 8002DA78 21207100 */  addu       $a0, $v1, $s1
    /* 1E27C 8002DA7C EAFF6324 */  addiu      $v1, $v1, -0x16
    /* 1E280 8002DA80 80100300 */  sll        $v0, $v1, 2
    /* 1E284 8002DA84 C0008480 */  lb         $a0, 0xC0($a0)
    /* 1E288 8002DA88 21104300 */  addu       $v0, $v0, $v1
    /* 1E28C 8002DA8C 21104400 */  addu       $v0, $v0, $a0
    /* 1E290 8002DA90 80100200 */  sll        $v0, $v0, 2
    /* 1E294 8002DA94 21104500 */  addu       $v0, $v0, $a1
    /* 1E298 8002DA98 00004584 */  lh         $a1, 0x0($v0)
    /* 1E29C 8002DA9C 9358000C */  jal        GetCarFromID__11tCarManagers
    /* 1E2A0 8002DAA0 21204002 */   addu      $a0, $s2, $zero
    /* 1E2A4 8002DAA4 21804000 */  addu       $s0, $v0, $zero
    /* 1E2A8 8002DAA8 07000292 */  lbu        $v0, 0x7($s0)
    /* 1E2AC 8002DAAC 00000000 */  nop
    /* 1E2B0 8002DAB0 0D004014 */  bnez       $v0, .L8002DAE8
    /* 1E2B4 8002DAB4 21106002 */   addu      $v0, $s3, $zero
    /* 1E2B8 8002DAB8 21204002 */  addu       $a0, $s2, $zero
    /* 1E2BC 8002DABC 00000582 */  lb         $a1, 0x0($s0)
    /* 1E2C0 8002DAC0 7B5B000C */  jal        SetCarAvailable__11tCarManager10tCarModelsb
    /* 1E2C4 8002DAC4 01000624 */   addiu     $a2, $zero, 0x1
    /* 1E2C8 8002DAC8 1000A383 */  lb         $v1, 0x10($sp)
    /* 1E2CC 8002DACC 00000292 */  lbu        $v0, 0x0($s0)
    /* 1E2D0 8002DAD0 21187100 */  addu       $v1, $v1, $s1
    /* 1E2D4 8002DAD4 2D0122A2 */  sb         $v0, 0x12D($s1)
    /* 1E2D8 8002DAD8 C0006290 */  lbu        $v0, 0xC0($v1)
    /* 1E2DC 8002DADC 01001324 */  addiu      $s3, $zero, 0x1
    /* 1E2E0 8002DAE0 2E0122A2 */  sb         $v0, 0x12E($s1)
  .L8002DAE4:
    /* 1E2E4 8002DAE4 21106002 */  addu       $v0, $s3, $zero
  .L8002DAE8:
    /* 1E2E8 8002DAE8 F000BF8F */  lw         $ra, 0xF0($sp)
    /* 1E2EC 8002DAEC EC00B38F */  lw         $s3, 0xEC($sp)
    /* 1E2F0 8002DAF0 E800B28F */  lw         $s2, 0xE8($sp)
    /* 1E2F4 8002DAF4 E400B18F */  lw         $s1, 0xE4($sp)
    /* 1E2F8 8002DAF8 E000B08F */  lw         $s0, 0xE0($sp)
    /* 1E2FC 8002DAFC 0800E003 */  jr         $ra
    /* 1E300 8002DB00 F800BD27 */   addiu     $sp, $sp, 0xF8
endlabel func_8002D9E8
