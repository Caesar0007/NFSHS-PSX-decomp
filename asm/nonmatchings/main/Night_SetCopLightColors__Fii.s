.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Night_SetCopLightColors__Fii, 0x80

glabel Night_SetCopLightColors__Fii
    /* CC1D0 800DB9D0 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* CC1D4 800DB9D4 1000B0AF */  sw         $s0, 0x10($sp)
    /* CC1D8 800DB9D8 21808000 */  addu       $s0, $a0, $zero
    /* CC1DC 800DB9DC 1400B1AF */  sw         $s1, 0x14($sp)
    /* CC1E0 800DB9E0 2188A000 */  addu       $s1, $a1, $zero
    /* CC1E4 800DB9E4 6000053C */  lui        $a1, (0x602020 >> 16)
    /* CC1E8 800DB9E8 2020A534 */  ori        $a1, $a1, (0x602020 & 0xFFFF)
    /* CC1EC 800DB9EC A014878F */  lw         $a3, %gp_rel(Night_gCopLightingTableBlue)($gp)
    /* CC1F0 800DB9F0 21302002 */  addu       $a2, $s1, $zero
    /* CC1F4 800DB9F4 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* CC1F8 800DB9F8 C0981000 */  sll        $s3, $s0, 3
    /* CC1FC 800DB9FC 1800B2AF */  sw         $s2, 0x18($sp)
    /* CC200 800DBA00 43901100 */  sra        $s2, $s1, 1
    /* CC204 800DBA04 2000BFAF */  sw         $ra, 0x20($sp)
    /* CC208 800DBA08 2138F300 */  addu       $a3, $a3, $s3
    /* CC20C 800DBA0C F86C030C */  jal        Night_CreateNightTableElement__FiliPUc
    /* CC210 800DBA10 2138F200 */   addu      $a3, $a3, $s2
    /* CC214 800DBA14 21200002 */  addu       $a0, $s0, $zero
    /* CC218 800DBA18 1000053C */  lui        $a1, (0x101054 >> 16)
    /* CC21C 800DBA1C 5410A534 */  ori        $a1, $a1, (0x101054 & 0xFFFF)
    /* CC220 800DBA20 9C14878F */  lw         $a3, %gp_rel(Night_gCopLightingTableRed)($gp)
    /* CC224 800DBA24 21302002 */  addu       $a2, $s1, $zero
    /* CC228 800DBA28 2138F300 */  addu       $a3, $a3, $s3
    /* CC22C 800DBA2C F86C030C */  jal        Night_CreateNightTableElement__FiliPUc
    /* CC230 800DBA30 2138F200 */   addu      $a3, $a3, $s2
    /* CC234 800DBA34 2000BF8F */  lw         $ra, 0x20($sp)
    /* CC238 800DBA38 1C00B38F */  lw         $s3, 0x1C($sp)
    /* CC23C 800DBA3C 1800B28F */  lw         $s2, 0x18($sp)
    /* CC240 800DBA40 1400B18F */  lw         $s1, 0x14($sp)
    /* CC244 800DBA44 1000B08F */  lw         $s0, 0x10($sp)
    /* CC248 800DBA48 0800E003 */  jr         $ra
    /* CC24C 800DBA4C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Night_SetCopLightColors__Fii
