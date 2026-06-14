.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching StSetRing, 0x2C

glabel StSetRing
    /* EA1F8 800F99F8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* EA1FC 800F99FC 1000BFAF */  sw         $ra, 0x10($sp)
    /* EA200 800F9A00 1480013C */  lui        $at, %hi(StRingAddr)
    /* EA204 800F9A04 AC6C24AC */  sw         $a0, %lo(StRingAddr)($at)
    /* EA208 800F9A08 1480013C */  lui        $at, %hi(StRingSize)
    /* EA20C 800F9A0C 5AE2030C */  jal        StClearRing
    /* EA210 800F9A10 BC6C25AC */   sw        $a1, %lo(StRingSize)($at)
    /* EA214 800F9A14 1000BF8F */  lw         $ra, 0x10($sp)
    /* EA218 800F9A18 1800BD27 */  addiu      $sp, $sp, 0x18
    /* EA21C 800F9A1C 0800E003 */  jr         $ra
    /* EA220 800F9A20 00000000 */   nop
endlabel StSetRing
    /* EA224 800F9A24 00000000 */  nop
