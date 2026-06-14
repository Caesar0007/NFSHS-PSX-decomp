.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDsetslot, 0x38

glabel iSNDsetslot
    /* EFB94 800FF394 1480023C */  lui        $v0, %hi(D_80147E28)
    /* EFB98 800FF398 00210400 */  sll        $a0, $a0, 4
    /* EFB9C 800FF39C C3280500 */  sra        $a1, $a1, 3
    /* EFBA0 800FF3A0 287E428C */  lw         $v0, %lo(D_80147E28)($v0)
    /* EFBA4 800FF3A4 0F000324 */  addiu      $v1, $zero, 0xF
    /* EFBA8 800FF3A8 21104400 */  addu       $v0, $v0, $a0
    /* EFBAC 800FF3AC 080043A4 */  sh         $v1, 0x8($v0)
    /* EFBB0 800FF3B0 05000324 */  addiu      $v1, $zero, 0x5
    /* EFBB4 800FF3B4 0A0043A4 */  sh         $v1, 0xA($v0)
    /* EFBB8 800FF3B8 00020324 */  addiu      $v1, $zero, 0x200
    /* EFBBC 800FF3BC 040046A4 */  sh         $a2, 0x4($v0)
    /* EFBC0 800FF3C0 060045A4 */  sh         $a1, 0x6($v0)
    /* EFBC4 800FF3C4 0800E003 */  jr         $ra
    /* EFBC8 800FF3C8 0E0043A4 */   sh        $v1, 0xE($v0)
endlabel iSNDsetslot
