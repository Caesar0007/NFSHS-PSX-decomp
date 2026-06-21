.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetNumTourneyCars__11tCarManagers, 0xA8

glabel GetNumTourneyCars__11tCarManagers
    /* 7B78 80017378 08FFBD27 */  addiu      $sp, $sp, -0xF8
    /* 7B7C 8001737C EC00B3AF */  sw         $s3, 0xEC($sp)
    /* 7B80 80017380 21988000 */  addu       $s3, $a0, $zero
    /* 7B84 80017384 E800B2AF */  sw         $s2, 0xE8($sp)
    /* 7B88 80017388 21900000 */  addu       $s2, $zero, $zero
    /* 7B8C 8001738C E400B1AF */  sw         $s1, 0xE4($sp)
    /* 7B90 80017390 21880000 */  addu       $s1, $zero, $zero
    /* 7B94 80017394 002C0500 */  sll        $a1, $a1, 16
    /* 7B98 80017398 E000B0AF */  sw         $s0, 0xE0($sp)
    /* 7B9C 8001739C 43820500 */  sra        $s0, $a1, 9
    /* 7BA0 800173A0 F000BFAF */  sw         $ra, 0xF0($sp)
  .L800173A4:
    /* 7BA4 800173A4 21187002 */  addu       $v1, $s3, $s0
    /* 7BA8 800173A8 08006580 */  lb         $a1, 0x8($v1)
    /* 7BAC 800173AC 08006290 */  lbu        $v0, 0x8($v1)
    /* 7BB0 800173B0 0E00A004 */  bltz       $a1, .L800173EC
    /* 7BB4 800173B4 21206002 */   addu      $a0, $s3, $zero
    /* 7BB8 800173B8 1000A2A3 */  sb         $v0, 0x10($sp)
    /* 7BBC 800173BC 09006290 */  lbu        $v0, 0x9($v1)
    /* 7BC0 800173C0 9358000C */  jal        GetCarFromID__11tCarManagers
    /* 7BC4 800173C4 D400A2A3 */   sb        $v0, 0xD4($sp)
    /* 7BC8 800173C8 1180043C */  lui        $a0, %hi(tournamentManager)
    /* 7BCC 800173CC D84A8424 */  addiu      $a0, $a0, %lo(tournamentManager)
    /* 7BD0 800173D0 02004290 */  lbu        $v0, 0x2($v0)
    /* 7BD4 800173D4 1000A527 */  addiu      $a1, $sp, 0x10
    /* 7BD8 800173D8 09CF000C */  jal        ValidCar__18tTournamentManagerR8tCarInfo
    /* 7BDC 800173DC 1200A2A3 */   sb        $v0, 0x12($sp)
    /* 7BE0 800173E0 02004010 */  beqz       $v0, .L800173EC
    /* 7BE4 800173E4 00000000 */   nop
    /* 7BE8 800173E8 01005226 */  addiu      $s2, $s2, 0x1
  .L800173EC:
    /* 7BEC 800173EC 01003126 */  addiu      $s1, $s1, 0x1
    /* 7BF0 800173F0 2000222A */  slti       $v0, $s1, 0x20
    /* 7BF4 800173F4 EBFF4014 */  bnez       $v0, .L800173A4
    /* 7BF8 800173F8 04001026 */   addiu     $s0, $s0, 0x4
    /* 7BFC 800173FC 00141200 */  sll        $v0, $s2, 16
    /* 7C00 80017400 F000BF8F */  lw         $ra, 0xF0($sp)
    /* 7C04 80017404 EC00B38F */  lw         $s3, 0xEC($sp)
    /* 7C08 80017408 E800B28F */  lw         $s2, 0xE8($sp)
    /* 7C0C 8001740C E400B18F */  lw         $s1, 0xE4($sp)
    /* 7C10 80017410 E000B08F */  lw         $s0, 0xE0($sp)
    /* 7C14 80017414 03140200 */  sra        $v0, $v0, 16
    /* 7C18 80017418 0800E003 */  jr         $ra
    /* 7C1C 8001741C F800BD27 */   addiu     $sp, $sp, 0xF8
endlabel GetNumTourneyCars__11tCarManagers
