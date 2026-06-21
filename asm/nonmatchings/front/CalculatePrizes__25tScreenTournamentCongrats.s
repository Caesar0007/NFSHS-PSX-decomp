.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CalculatePrizes__25tScreenTournamentCongrats, 0x98

glabel CalculatePrizes__25tScreenTournamentCongrats
    /* 39E3C 8004963C 98FFBD27 */  addiu      $sp, $sp, -0x68
    /* 39E40 80049640 5C00B1AF */  sw         $s1, 0x5C($sp)
    /* 39E44 80049644 21888000 */  addu       $s1, $a0, $zero
    /* 39E48 80049648 5800B0AF */  sw         $s0, 0x58($sp)
    /* 39E4C 8004964C 1180103C */  lui        $s0, %hi(tournamentManager)
    /* 39E50 80049650 D84A1026 */  addiu      $s0, $s0, %lo(tournamentManager)
    /* 39E54 80049654 21200002 */  addu       $a0, $s0, $zero
    /* 39E58 80049658 6000BFAF */  sw         $ra, 0x60($sp)
    /* 39E5C 8004965C 35CE000C */  jal        GetAwardInformation__18tTournamentManagerR17tAwardInformation
    /* 39E60 80049660 1000A527 */   addiu     $a1, $sp, 0x10
    /* 39E64 80049664 6E22010C */  jal        CalculatePrizes__15tScreenCongrats
    /* 39E68 80049668 21202002 */   addu      $a0, $s1, $zero
    /* 39E6C 8004966C 03000224 */  addiu      $v0, $zero, 0x3
    /* 39E70 80049670 680022AE */  sw         $v0, 0x68($s1)
    /* 39E74 80049674 1400028E */  lw         $v0, 0x14($s0)
    /* 39E78 80049678 00000000 */  nop
    /* 39E7C 8004967C 7C0022AE */  sw         $v0, 0x7C($s1)
    /* 39E80 80049680 4C00A28F */  lw         $v0, 0x4C($sp)
    /* 39E84 80049684 00000000 */  nop
    /* 39E88 80049688 02004010 */  beqz       $v0, .L80049694
    /* 39E8C 8004968C FFFF0324 */   addiu     $v1, $zero, -0x1
    /* 39E90 80049690 5000A38F */  lw         $v1, 0x50($sp)
  .L80049694:
    /* 39E94 80049694 00000000 */  nop
    /* 39E98 80049698 800023AE */  sw         $v1, 0x80($s1)
    /* 39E9C 8004969C 8040033C */  lui        $v1, (0x40800000 >> 16)
    /* 39EA0 800496A0 ECC0043C */  lui        $a0, (0xC0ECCCCD >> 16)
    /* 39EA4 800496A4 CDCC8434 */  ori        $a0, $a0, (0xC0ECCCCD & 0xFFFF)
    /* 39EA8 800496A8 16010224 */  addiu      $v0, $zero, 0x116
    /* 39EAC 800496AC 780122A6 */  sh         $v0, 0x178($s1)
    /* 39EB0 800496B0 4B000224 */  addiu      $v0, $zero, 0x4B
    /* 39EB4 800496B4 7A0122A6 */  sh         $v0, 0x17A($s1)
    /* 39EB8 800496B8 7C0123AE */  sw         $v1, 0x17C($s1)
    /* 39EBC 800496BC 800124AE */  sw         $a0, 0x180($s1)
    /* 39EC0 800496C0 6000BF8F */  lw         $ra, 0x60($sp)
    /* 39EC4 800496C4 5C00B18F */  lw         $s1, 0x5C($sp)
    /* 39EC8 800496C8 5800B08F */  lw         $s0, 0x58($sp)
    /* 39ECC 800496CC 0800E003 */  jr         $ra
    /* 39ED0 800496D0 6800BD27 */   addiu     $sp, $sp, 0x68
endlabel CalculatePrizes__25tScreenTournamentCongrats
