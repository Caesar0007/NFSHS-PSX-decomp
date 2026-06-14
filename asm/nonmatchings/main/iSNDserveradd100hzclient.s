.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDserveradd100hzclient, 0x30

glabel iSNDserveradd100hzclient
    /* DADF0 800EA5F0 1480023C */  lui        $v0, %hi(sndgs)
    /* DADF4 800EA5F4 60784224 */  addiu      $v0, $v0, %lo(sndgs)
    /* DADF8 800EA5F8 40004380 */  lb         $v1, 0x40($v0)
    /* DADFC 800EA5FC 00000000 */  nop
    /* DAE00 800EA600 80180300 */  sll        $v1, $v1, 2
    /* DAE04 800EA604 21186200 */  addu       $v1, $v1, $v0
    /* DAE08 800EA608 4C0064AC */  sw         $a0, 0x4C($v1)
    /* DAE0C 800EA60C 40004390 */  lbu        $v1, 0x40($v0)
    /* DAE10 800EA610 00000000 */  nop
    /* DAE14 800EA614 01006324 */  addiu      $v1, $v1, 0x1
    /* DAE18 800EA618 0800E003 */  jr         $ra
    /* DAE1C 800EA61C 400043A0 */   sb        $v1, 0x40($v0)
endlabel iSNDserveradd100hzclient
