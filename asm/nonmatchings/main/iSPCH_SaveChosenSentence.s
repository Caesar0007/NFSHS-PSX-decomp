.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_SaveChosenSentence, 0x48

glabel iSPCH_SaveChosenSentence
    /* F1E5C 8010165C 21480000 */  addu       $t1, $zero, $zero
    /* F1E60 80101660 1580033C */  lui        $v1, %hi(gSentenceChoice)
    /* F1E64 80101664 3C846224 */  addiu      $v0, $v1, %lo(gSentenceChoice)
    /* F1E68 80101668 21404000 */  addu       $t0, $v0, $zero
    /* F1E6C 8010166C 3C8464AC */  sw         $a0, %lo(gSentenceChoice)($v1)
    /* F1E70 80101670 040005AD */  sw         $a1, 0x4($t0)
    /* F1E74 80101674 080006AD */  sw         $a2, 0x8($t0)
  .L80101678:
    /* F1E78 80101678 0000E28C */  lw         $v0, 0x0($a3)
    /* F1E7C 8010167C 0400E724 */  addiu      $a3, $a3, 0x4
    /* F1E80 80101680 01002925 */  addiu      $t1, $t1, 0x1
    /* F1E84 80101684 100002AD */  sw         $v0, 0x10($t0)
    /* F1E88 80101688 0C002229 */  slti       $v0, $t1, 0xC
    /* F1E8C 8010168C FAFF4014 */  bnez       $v0, .L80101678
    /* F1E90 80101690 04000825 */   addiu     $t0, $t0, 0x4
    /* F1E94 80101694 1580033C */  lui        $v1, %hi(D_80148448)
    /* F1E98 80101698 01000224 */  addiu      $v0, $zero, 0x1
    /* F1E9C 8010169C 0800E003 */  jr         $ra
    /* F1EA0 801016A0 488462AC */   sw        $v0, %lo(D_80148448)($v1)
endlabel iSPCH_SaveChosenSentence
