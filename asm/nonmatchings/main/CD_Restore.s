.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CD_Restore, 0x30

glabel CD_Restore
    /* EAB64 800FA364 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* EAB68 800FA368 1000BFAF */  sw         $ra, 0x10($sp)
    /* EAB6C 800FA36C EBDD030C */  jal        CdReset
    /* EAB70 800FA370 21200000 */   addu      $a0, $zero, $zero
    /* EAB74 800FA374 1480043C */  lui        $a0, %hi(Cdinfo)
    /* EAB78 800FA378 C46C8424 */  addiu      $a0, $a0, %lo(Cdinfo)
    /* EAB7C 800FA37C E8C5030C */  jal        blockclear
    /* EAB80 800FA380 3C080524 */   addiu     $a1, $zero, 0x83C
    /* EAB84 800FA384 1000BF8F */  lw         $ra, 0x10($sp)
    /* EAB88 800FA388 00000000 */  nop
    /* EAB8C 800FA38C 0800E003 */  jr         $ra
    /* EAB90 800FA390 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CD_Restore
