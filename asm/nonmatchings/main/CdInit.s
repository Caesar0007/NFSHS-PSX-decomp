.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdInit, 0x90

glabel CdInit
    /* F988C 8010908C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F9890 80109090 1000B0AF */  sw         $s0, 0x10($sp)
    /* F9894 80109094 04001024 */  addiu      $s0, $zero, 0x4
    /* F9898 80109098 1400BFAF */  sw         $ra, 0x14($sp)
  .L8010909C:
    /* F989C 8010909C 4724040C */  jal        func_8010911C
    /* F98A0 801090A0 00000000 */   nop
    /* F98A4 801090A4 01000324 */  addiu      $v1, $zero, 0x1
    /* F98A8 801090A8 10004314 */  bne        $v0, $v1, .L801090EC
    /* F98AC 801090AC 01000224 */   addiu     $v0, $zero, 0x1
    /* F98B0 801090B0 1180033C */  lui        $v1, %hi(func_80109158)
    /* F98B4 801090B4 58916324 */  addiu      $v1, $v1, %lo(func_80109158)
    /* F98B8 801090B8 1480013C */  lui        $at, %hi(CD_cbsync)
    /* F98BC 801090BC 48BF23AC */  sw         $v1, %lo(CD_cbsync)($at)
    /* F98C0 801090C0 1180033C */  lui        $v1, %hi(func_80109180)
    /* F98C4 801090C4 80916324 */  addiu      $v1, $v1, %lo(func_80109180)
    /* F98C8 801090C8 1480013C */  lui        $at, %hi(CD_cbready)
    /* F98CC 801090CC 4CBF23AC */  sw         $v1, %lo(CD_cbready)($at)
    /* F98D0 801090D0 1180033C */  lui        $v1, %hi(func_801091A8)
    /* F98D4 801090D4 A8916324 */  addiu      $v1, $v1, %lo(func_801091A8)
    /* F98D8 801090D8 1480013C */  lui        $at, %hi(CD_cbread)
    /* F98DC 801090DC D0C223AC */  sw         $v1, %lo(CD_cbread)($at)
    /* F98E0 801090E0 1480013C */  lui        $at, %hi(CD_read_dma_mode)
    /* F98E4 801090E4 43240408 */  j          .L8010910C
    /* F98E8 801090E8 D4C220AC */   sw        $zero, %lo(CD_read_dma_mode)($at)
  .L801090EC:
    /* F98EC 801090EC FFFF1026 */  addiu      $s0, $s0, -0x1
    /* F98F0 801090F0 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* F98F4 801090F4 E9FF0216 */  bne        $s0, $v0, .L8010909C
    /* F98F8 801090F8 00000000 */   nop
    /* F98FC 801090FC 0580043C */  lui        $a0, %hi(D_800578E8)
    /* F9900 80109100 2B0A040C */  jal        printf
    /* F9904 80109104 E8788424 */   addiu     $a0, $a0, %lo(D_800578E8)
    /* F9908 80109108 21100000 */  addu       $v0, $zero, $zero
  .L8010910C:
    /* F990C 8010910C 1400BF8F */  lw         $ra, 0x14($sp)
    /* F9910 80109110 1000B08F */  lw         $s0, 0x10($sp)
    /* F9914 80109114 0800E003 */  jr         $ra
    /* F9918 80109118 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CdInit
