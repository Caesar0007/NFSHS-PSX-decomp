.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_MemAlloc, 0x30

glabel iSPCH_MemAlloc
    /* DBDA4 800EB5A4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DBDA8 800EB5A8 1380023C */  lui        $v0, %hi(gMemAlloc)
    /* DBDAC 800EB5AC A870438C */  lw         $v1, %lo(gMemAlloc)($v0)
    /* DBDB0 800EB5B0 21100000 */  addu       $v0, $zero, $zero
    /* DBDB4 800EB5B4 03006010 */  beqz       $v1, .L800EB5C4
    /* DBDB8 800EB5B8 1000BFAF */   sw        $ra, 0x10($sp)
    /* DBDBC 800EB5BC 09F86000 */  jalr       $v1
    /* DBDC0 800EB5C0 00000000 */   nop
  .L800EB5C4:
    /* DBDC4 800EB5C4 1000BF8F */  lw         $ra, 0x10($sp)
    /* DBDC8 800EB5C8 00000000 */  nop
    /* DBDCC 800EB5CC 0800E003 */  jr         $ra
    /* DBDD0 800EB5D0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iSPCH_MemAlloc
