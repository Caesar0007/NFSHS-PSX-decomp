.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDpsxeffecton, 0x40

glabel iSNDpsxeffecton
    /* EF990 800FF190 1480033C */  lui        $v1, %hi(sndpd)
    /* EF994 800FF194 18796324 */  addiu      $v1, $v1, %lo(sndpd)
    /* EF998 800FF198 1405658C */  lw         $a1, 0x514($v1)
    /* EF99C 800FF19C 00000000 */  nop
    /* EF9A0 800FF1A0 9801A294 */  lhu        $v0, 0x198($a1)
    /* EF9A4 800FF1A4 00000000 */  nop
    /* EF9A8 800FF1A8 25104400 */  or         $v0, $v0, $a0
    /* EF9AC 800FF1AC 9801A2A4 */  sh         $v0, 0x198($a1)
    /* EF9B0 800FF1B0 1405638C */  lw         $v1, 0x514($v1)
    /* EF9B4 800FF1B4 00000000 */  nop
    /* EF9B8 800FF1B8 9A016294 */  lhu        $v0, 0x19A($v1)
    /* EF9BC 800FF1BC 03240400 */  sra        $a0, $a0, 16
    /* EF9C0 800FF1C0 25104400 */  or         $v0, $v0, $a0
    /* EF9C4 800FF1C4 9A0162A4 */  sh         $v0, 0x19A($v1)
    /* EF9C8 800FF1C8 0800E003 */  jr         $ra
    /* EF9CC 800FF1CC 00000000 */   nop
endlabel iSNDpsxeffecton
