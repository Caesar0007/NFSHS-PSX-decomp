.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MemCardInit, 0x2C

glabel MemCardInit
    /* EB2AC 800FAAAC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* EB2B0 800FAAB0 1000BFAF */  sw         $ra, 0x10($sp)
    /* EB2B4 800FAAB4 1480013C */  lui        $at, %hi(D_80147514)
    /* EB2B8 800FAAB8 147520AC */  sw         $zero, %lo(D_80147514)($at)
    /* EB2BC 800FAABC 1480013C */  lui        $at, %hi(D_80147558)
    /* EB2C0 800FAAC0 7C25040C */  jal        _card_open
    /* EB2C4 800FAAC4 587520AC */   sw        $zero, %lo(D_80147558)($at)
    /* EB2C8 800FAAC8 1000BF8F */  lw         $ra, 0x10($sp)
    /* EB2CC 800FAACC 1800BD27 */  addiu      $sp, $sp, 0x18
    /* EB2D0 800FAAD0 0800E003 */  jr         $ra
    /* EB2D4 800FAAD4 00000000 */   nop
endlabel MemCardInit
