.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDpvtolrv, 0x4C

glabel iSNDpvtolrv
    /* FCF38 8010C738 40000224 */  addiu      $v0, $zero, 0x40
    /* FCF3C 8010C73C 0000C5AC */  sw         $a1, 0x0($a2)
    /* FCF40 8010C740 0E008210 */  beq        $a0, $v0, .L8010C77C
    /* FCF44 8010C744 0000E5AC */   sw        $a1, 0x0($a3)
    /* FCF48 8010C748 2A108200 */  slt        $v0, $a0, $v0
    /* FCF4C 8010C74C 06004010 */  beqz       $v0, .L8010C768
    /* FCF50 8010C750 7F000224 */   addiu     $v0, $zero, 0x7F
    /* FCF54 8010C754 1800A400 */  mult       $a1, $a0
    /* FCF58 8010C758 12180000 */  mflo       $v1
    /* FCF5C 8010C75C 83110300 */  sra        $v0, $v1, 6
    /* FCF60 8010C760 0800E003 */  jr         $ra
    /* FCF64 8010C764 0000E2AC */   sw        $v0, 0x0($a3)
  .L8010C768:
    /* FCF68 8010C768 23104400 */  subu       $v0, $v0, $a0
    /* FCF6C 8010C76C 1800A200 */  mult       $a1, $v0
    /* FCF70 8010C770 12180000 */  mflo       $v1
    /* FCF74 8010C774 83110300 */  sra        $v0, $v1, 6
    /* FCF78 8010C778 0000C2AC */  sw         $v0, 0x0($a2)
  .L8010C77C:
    /* FCF7C 8010C77C 0800E003 */  jr         $ra
    /* FCF80 8010C780 00000000 */   nop
endlabel iSNDpvtolrv
