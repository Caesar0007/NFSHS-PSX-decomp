.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDserveraddclient, 0x30

glabel iSNDserveraddclient
    /* F4F9C 8010479C 1480023C */  lui        $v0, %hi(sndgs)
    /* F4FA0 801047A0 60784224 */  addiu      $v0, $v0, %lo(sndgs)
    /* F4FA4 801047A4 41004380 */  lb         $v1, 0x41($v0)
    /* F4FA8 801047A8 00000000 */  nop
    /* F4FAC 801047AC 80180300 */  sll        $v1, $v1, 2
    /* F4FB0 801047B0 21186200 */  addu       $v1, $v1, $v0
    /* F4FB4 801047B4 640064AC */  sw         $a0, 0x64($v1)
    /* F4FB8 801047B8 41004390 */  lbu        $v1, 0x41($v0)
    /* F4FBC 801047BC 00000000 */  nop
    /* F4FC0 801047C0 01006324 */  addiu      $v1, $v1, 0x1
    /* F4FC4 801047C4 0800E003 */  jr         $ra
    /* F4FC8 801047C8 410043A0 */   sb        $v1, 0x41($v0)
endlabel iSNDserveraddclient
