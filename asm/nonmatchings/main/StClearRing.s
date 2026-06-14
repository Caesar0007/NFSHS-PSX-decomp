.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching StClearRing, 0x60

glabel StClearRing
    /* E9168 800F8968 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E916C 800F896C 1480053C */  lui        $a1, %hi(StRingSize)
    /* E9170 800F8970 BC6CA58C */  lw         $a1, %lo(StRingSize)($a1)
    /* E9174 800F8974 1000BFAF */  sw         $ra, 0x10($sp)
    /* E9178 800F8978 1480013C */  lui        $at, %hi(StRingIdx3)
    /* E917C 800F897C B86C20AC */  sw         $zero, %lo(StRingIdx3)($at)
    /* E9180 800F8980 1480013C */  lui        $at, %hi(StRingIdx2)
    /* E9184 800F8984 B46C20AC */  sw         $zero, %lo(StRingIdx2)($at)
    /* E9188 800F8988 1480013C */  lui        $at, %hi(StRingIdx1)
    /* E918C 800F898C B06C20AC */  sw         $zero, %lo(StRingIdx1)($at)
    /* E9190 800F8990 1480013C */  lui        $at, %hi(StFinalSector)
    /* E9194 800F8994 A46C20AC */  sw         $zero, %lo(StFinalSector)($at)
    /* E9198 800F8998 D621040C */  jal        init_ring_status
    /* E919C 800F899C 21200000 */   addu      $a0, $zero, $zero
    /* E91A0 800F89A0 1480013C */  lui        $at, %hi(StCdIntrFlag)
    /* E91A4 800F89A4 806C20AC */  sw         $zero, %lo(StCdIntrFlag)($at)
    /* E91A8 800F89A8 1480013C */  lui        $at, %hi(Stsector_offset)
    /* E91AC 800F89AC A06C20A4 */  sh         $zero, %lo(Stsector_offset)($at)
    /* E91B0 800F89B0 1480013C */  lui        $at, %hi(Stframe_no)
    /* E91B4 800F89B4 8C6C20AC */  sw         $zero, %lo(Stframe_no)($at)
    /* E91B8 800F89B8 1000BF8F */  lw         $ra, 0x10($sp)
    /* E91BC 800F89BC 1800BD27 */  addiu      $sp, $sp, 0x18
    /* E91C0 800F89C0 0800E003 */  jr         $ra
    /* E91C4 800F89C4 00000000 */   nop
endlabel StClearRing
