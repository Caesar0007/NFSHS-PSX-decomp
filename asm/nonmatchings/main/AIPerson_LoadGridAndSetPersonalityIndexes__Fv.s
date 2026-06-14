.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPerson_LoadGridAndSetPersonalityIndexes__Fv, 0x4C

glabel AIPerson_LoadGridAndSetPersonalityIndexes__Fv
    /* 591E8 800689E8 1480073C */  lui        $a3, %hi(Cars_gNumCars)
    /* 591EC 800689EC F4C7E78C */  lw         $a3, %lo(Cars_gNumCars)($a3)
    /* 591F0 800689F0 00000000 */  nop
    /* 591F4 800689F4 0D00E018 */  blez       $a3, .L80068A2C
    /* 591F8 800689F8 21200000 */   addu      $a0, $zero, $zero
    /* 591FC 800689FC 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 59200 80068A00 EC314624 */  addiu      $a2, $v0, %lo(GameSetup_gData)
    /* 59204 80068A04 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 59208 80068A08 DCF94524 */  addiu      $a1, $v0, %lo(Cars_gList)
  .L80068A0C:
    /* 5920C 80068A0C 2404C38C */  lw         $v1, 0x424($a2)
    /* 59210 80068A10 B400C624 */  addiu      $a2, $a2, 0xB4
    /* 59214 80068A14 0000A28C */  lw         $v0, 0x0($a1)
    /* 59218 80068A18 01008424 */  addiu      $a0, $a0, 0x1
    /* 5921C 80068A1C EC0443AC */  sw         $v1, 0x4EC($v0)
    /* 59220 80068A20 2A108700 */  slt        $v0, $a0, $a3
    /* 59224 80068A24 F9FF4014 */  bnez       $v0, .L80068A0C
    /* 59228 80068A28 0400A524 */   addiu     $a1, $a1, 0x4
  .L80068A2C:
    /* 5922C 80068A2C 0800E003 */  jr         $ra
    /* 59230 80068A30 00000000 */   nop
endlabel AIPerson_LoadGridAndSetPersonalityIndexes__Fv
