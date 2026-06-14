.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDenteraudio, 0x38

glabel iSNDenteraudio
    /* DAD34 800EA534 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DAD38 800EA538 1000BFAF */  sw         $ra, 0x10($sp)
    /* DAD3C 800EA53C 7F00040C */  jal        SNDI_mutexlock
    /* DAD40 800EA540 00000000 */   nop
    /* DAD44 800EA544 1480033C */  lui        $v1, %hi(sndgs)
    /* DAD48 800EA548 60786324 */  addiu      $v1, $v1, %lo(sndgs)
    /* DAD4C 800EA54C 3F006290 */  lbu        $v0, 0x3F($v1)
    /* DAD50 800EA550 00000000 */  nop
    /* DAD54 800EA554 01004224 */  addiu      $v0, $v0, 0x1
    /* DAD58 800EA558 3F0062A0 */  sb         $v0, 0x3F($v1)
    /* DAD5C 800EA55C 1000BF8F */  lw         $ra, 0x10($sp)
    /* DAD60 800EA560 00000000 */  nop
    /* DAD64 800EA564 0800E003 */  jr         $ra
    /* DAD68 800EA568 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iSNDenteraudio
