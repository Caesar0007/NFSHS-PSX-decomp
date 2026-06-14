.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DsReadyCallback, 0x14

glabel DsReadyCallback
    /* F9024 80108824 1580033C */  lui        $v1, %hi(D_801489E4)
    /* F9028 80108828 E4896324 */  addiu      $v1, $v1, %lo(D_801489E4)
    /* F902C 8010882C 0000628C */  lw         $v0, 0x0($v1)
    /* F9030 80108830 0800E003 */  jr         $ra
    /* F9034 80108834 000064AC */   sw        $a0, 0x0($v1)
endlabel DsReadyCallback
