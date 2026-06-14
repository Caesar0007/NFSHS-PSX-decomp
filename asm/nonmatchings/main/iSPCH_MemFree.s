.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_MemFree, 0x2C

glabel iSPCH_MemFree
    /* DBDD4 800EB5D4 1380023C */  lui        $v0, %hi(gMemFree)
    /* DBDD8 800EB5D8 AC70428C */  lw         $v0, %lo(gMemFree)($v0)
    /* DBDDC 800EB5DC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DBDE0 800EB5E0 03004010 */  beqz       $v0, .L800EB5F0
    /* DBDE4 800EB5E4 1000BFAF */   sw        $ra, 0x10($sp)
    /* DBDE8 800EB5E8 09F84000 */  jalr       $v0
    /* DBDEC 800EB5EC 00000000 */   nop
  .L800EB5F0:
    /* DBDF0 800EB5F0 1000BF8F */  lw         $ra, 0x10($sp)
    /* DBDF4 800EB5F4 00000000 */  nop
    /* DBDF8 800EB5F8 0800E003 */  jr         $ra
    /* DBDFC 800EB5FC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iSPCH_MemFree
