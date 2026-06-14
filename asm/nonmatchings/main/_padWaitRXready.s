.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _padWaitRXready, 0x28

glabel _padWaitRXready
    /* F5DC8 801055C8 1380033C */  lui        $v1, %hi(D_80137CDC)
    /* F5DCC 801055CC DC7C638C */  lw         $v1, %lo(D_80137CDC)($v1)
    /* F5DD0 801055D0 00000000 */  nop
  .L801055D4:
    /* F5DD4 801055D4 04006294 */  lhu        $v0, 0x4($v1)
    /* F5DD8 801055D8 00000000 */  nop
    /* F5DDC 801055DC 02004230 */  andi       $v0, $v0, 0x2
    /* F5DE0 801055E0 FCFF4010 */  beqz       $v0, .L801055D4
    /* F5DE4 801055E4 00000000 */   nop
    /* F5DE8 801055E8 0800E003 */  jr         $ra
    /* F5DEC 801055EC 00000000 */   nop
endlabel _padWaitRXready
