.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CalculatePrizes__15tScreenCongrats, 0x74

glabel CalculatePrizes__15tScreenCongrats
    /* 391B8 800489B8 8040053C */  lui        $a1, (0x40800000 >> 16)
    /* 391BC 800489BC ECC0033C */  lui        $v1, (0xC0ECCCCD >> 16)
    /* 391C0 800489C0 CDCC6334 */  ori        $v1, $v1, (0xC0ECCCCD & 0xFFFF)
    /* 391C4 800489C4 04000224 */  addiu      $v0, $zero, 0x4
    /* 391C8 800489C8 680082AC */  sw         $v0, 0x68($a0)
    /* 391CC 800489CC FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 391D0 800489D0 800082AC */  sw         $v0, 0x80($a0)
    /* 391D4 800489D4 16010224 */  addiu      $v0, $zero, 0x116
    /* 391D8 800489D8 780182A4 */  sh         $v0, 0x178($a0)
    /* 391DC 800489DC 3F000224 */  addiu      $v0, $zero, 0x3F
    /* 391E0 800489E0 640080AC */  sw         $zero, 0x64($a0)
    /* 391E4 800489E4 7A0182A4 */  sh         $v0, 0x17A($a0)
    /* 391E8 800489E8 800183AC */  sw         $v1, 0x180($a0)
    /* 391EC 800489EC 6400838C */  lw         $v1, 0x64($a0)
    /* 391F0 800489F0 01000224 */  addiu      $v0, $zero, 0x1
    /* 391F4 800489F4 6C0080AC */  sw         $zero, 0x6C($a0)
    /* 391F8 800489F8 780080AC */  sw         $zero, 0x78($a0)
    /* 391FC 800489FC 7C0080AC */  sw         $zero, 0x7C($a0)
    /* 39200 80048A00 08006214 */  bne        $v1, $v0, .L80048A24
    /* 39204 80048A04 7C0185AC */   sw        $a1, 0x17C($a0)
    /* 39208 80048A08 03C1033C */  lui        $v1, (0xC1033333 >> 16)
    /* 3920C 80048A0C 33336334 */  ori        $v1, $v1, (0xC1033333 & 0xFFFF)
    /* 39210 80048A10 20010224 */  addiu      $v0, $zero, 0x120
    /* 39214 80048A14 780182A4 */  sh         $v0, 0x178($a0)
    /* 39218 80048A18 49000224 */  addiu      $v0, $zero, 0x49
    /* 3921C 80048A1C 7A0182A4 */  sh         $v0, 0x17A($a0)
    /* 39220 80048A20 800183AC */  sw         $v1, 0x180($a0)
  .L80048A24:
    /* 39224 80048A24 0800E003 */  jr         $ra
    /* 39228 80048A28 00000000 */   nop
endlabel CalculatePrizes__15tScreenCongrats
