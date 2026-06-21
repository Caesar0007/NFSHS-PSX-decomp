.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetTrophyName__18tTournamentManagerP12tTourneyInfo11tTrophySizePci, 0xC0

glabel GetTrophyName__18tTournamentManagerP12tTourneyInfo11tTrophySizePci
    /* 24364 80033B64 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 24368 80033B68 2120E000 */  addu       $a0, $a3, $zero
    /* 2436C 80033B6C 0180023C */  lui        $v0, %hi(D_80011658)
    /* 24370 80033B70 2800BFAF */  sw         $ra, 0x28($sp)
    /* 24374 80033B74 58164B24 */  addiu      $t3, $v0, %lo(D_80011658)
    /* 24378 80033B78 00006881 */  lb         $t0, 0x0($t3)
    /* 2437C 80033B7C 01006981 */  lb         $t1, 0x1($t3)
    /* 24380 80033B80 02006A81 */  lb         $t2, 0x2($t3)
    /* 24384 80033B84 1800A8A3 */  sb         $t0, 0x18($sp)
    /* 24388 80033B88 1900A9A3 */  sb         $t1, 0x19($sp)
    /* 2438C 80033B8C 1A00AAA3 */  sb         $t2, 0x1A($sp)
    /* 24390 80033B90 1180023C */  lui        $v0, %hi(tournamentManager)
    /* 24394 80033B94 0000A380 */  lb         $v1, 0x0($a1)
    /* 24398 80033B98 D84A4224 */  addiu      $v0, $v0, %lo(tournamentManager)
    /* 2439C 80033B9C 21186200 */  addu       $v1, $v1, $v0
    /* 243A0 80033BA0 F0016780 */  lb         $a3, 0x1F0($v1)
    /* 243A4 80033BA4 0180023C */  lui        $v0, %hi(D_8001165C)
    /* 243A8 80033BA8 5C164B24 */  addiu      $t3, $v0, %lo(D_8001165C)
    /* 243AC 80033BAC 03006889 */  lwl        $t0, 0x3($t3)
    /* 243B0 80033BB0 00006899 */  lwr        $t0, 0x0($t3)
    /* 243B4 80033BB4 00000000 */  nop
    /* 243B8 80033BB8 2300A8AB */  swl        $t0, 0x23($sp)
    /* 243BC 80033BBC 2000A8BB */  swr        $t0, 0x20($sp)
    /* 243C0 80033BC0 4000A38F */  lw         $v1, 0x40($sp)
    /* 243C4 80033BC4 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 243C8 80033BC8 08006214 */  bne        $v1, $v0, .L80033BEC
    /* 243CC 80033BCC 2110E200 */   addu      $v0, $a3, $v0
    /* 243D0 80033BD0 0300422C */  sltiu      $v0, $v0, 0x3
    /* 243D4 80033BD4 02004010 */  beqz       $v0, .L80033BE0
    /* 243D8 80033BD8 21180000 */   addu      $v1, $zero, $zero
    /* 243DC 80033BDC 2118E000 */  addu       $v1, $a3, $zero
  .L80033BE0:
    /* 243E0 80033BE0 00140300 */  sll        $v0, $v1, 16
    /* 243E4 80033BE4 FCCE0008 */  j          .L80033BF0
    /* 243E8 80033BE8 03140200 */   sra       $v0, $v0, 16
  .L80033BEC:
    /* 243EC 80033BEC 21106000 */  addu       $v0, $v1, $zero
  .L80033BF0:
    /* 243F0 80033BF0 2118A603 */  addu       $v1, $sp, $a2
    /* 243F4 80033BF4 2110A203 */  addu       $v0, $sp, $v0
    /* 243F8 80033BF8 1600A790 */  lbu        $a3, 0x16($a1)
    /* 243FC 80033BFC 0180053C */  lui        $a1, %hi(D_80011660)
    /* 24400 80033C00 20004290 */  lbu        $v0, 0x20($v0)
    /* 24404 80033C04 18006690 */  lbu        $a2, 0x18($v1)
    /* 24408 80033C08 6016A524 */  addiu      $a1, $a1, %lo(D_80011660)
    /* 2440C 80033C0C 2F91030C */  jal        sprintf
    /* 24410 80033C10 1000A2AF */   sw        $v0, 0x10($sp)
    /* 24414 80033C14 2800BF8F */  lw         $ra, 0x28($sp)
    /* 24418 80033C18 00000000 */  nop
    /* 2441C 80033C1C 0800E003 */  jr         $ra
    /* 24420 80033C20 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel GetTrophyName__18tTournamentManagerP12tTourneyInfo11tTrophySizePci
