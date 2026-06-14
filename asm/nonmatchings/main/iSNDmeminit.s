.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDmeminit, 0x20

glabel iSNDmeminit
    /* F69D4 801061D4 1580023C */  lui        $v0, %hi(sndmm)
    /* F69D8 801061D8 808744AC */  sw         $a0, %lo(sndmm)($v0)
    /* F69DC 801061DC 80874224 */  addiu      $v0, $v0, %lo(sndmm)
    /* F69E0 801061E0 83280500 */  sra        $a1, $a1, 2
    /* F69E4 801061E4 040040A4 */  sh         $zero, 0x4($v0)
    /* F69E8 801061E8 060045A4 */  sh         $a1, 0x6($v0)
    /* F69EC 801061EC 0800E003 */  jr         $ra
    /* F69F0 801061F0 080040AC */   sw        $zero, 0x8($v0)
endlabel iSNDmeminit
