.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDpsxeffectoff, 0x40

glabel iSNDpsxeffectoff
    /* EF9D0 800FF1D0 1480053C */  lui        $a1, %hi(sndpd)
    /* EF9D4 800FF1D4 1879A524 */  addiu      $a1, $a1, %lo(sndpd)
    /* EF9D8 800FF1D8 1405A68C */  lw         $a2, 0x514($a1)
    /* EF9DC 800FF1DC 00000000 */  nop
    /* EF9E0 800FF1E0 9801C294 */  lhu        $v0, 0x198($a2)
    /* EF9E4 800FF1E4 27180400 */  nor        $v1, $zero, $a0
    /* EF9E8 800FF1E8 24104300 */  and        $v0, $v0, $v1
    /* EF9EC 800FF1EC 9801C2A4 */  sh         $v0, 0x198($a2)
    /* EF9F0 800FF1F0 1405A38C */  lw         $v1, 0x514($a1)
    /* EF9F4 800FF1F4 03240400 */  sra        $a0, $a0, 16
    /* EF9F8 800FF1F8 9A016294 */  lhu        $v0, 0x19A($v1)
    /* EF9FC 800FF1FC 27200400 */  nor        $a0, $zero, $a0
    /* EFA00 800FF200 24104400 */  and        $v0, $v0, $a0
    /* EFA04 800FF204 9A0162A4 */  sh         $v0, 0x19A($v1)
    /* EFA08 800FF208 0800E003 */  jr         $ra
    /* EFA0C 800FF20C 00000000 */   nop
endlabel iSNDpsxeffectoff
