.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCH_InitBankMem, 0x58

glabel SPCH_InitBankMem
    /* DBEF0 800EB6F0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DBEF4 800EB6F4 21380000 */  addu       $a3, $zero, $zero
    /* DBEF8 800EB6F8 7801023C */  lui        $v0, (0x1789A34 >> 16)
    /* DBEFC 800EB6FC 1380033C */  lui        $v1, %hi(gSPCH_Initialized)
    /* DBF00 800EB700 B070638C */  lw         $v1, %lo(gSPCH_Initialized)($v1)
    /* DBF04 800EB704 349A4234 */  ori        $v0, $v0, (0x1789A34 & 0xFFFF)
    /* DBF08 800EB708 0B006214 */  bne        $v1, $v0, .L800EB738
    /* DBF0C 800EB70C 1000BFAF */   sw        $ra, 0x10($sp)
    /* DBF10 800EB710 09008010 */  beqz       $a0, .L800EB738
    /* DBF14 800EB714 00000000 */   nop
    /* DBF18 800EB718 0700A010 */  beqz       $a1, .L800EB738
    /* DBF1C 800EB71C 1380023C */   lui       $v0, %hi(gMemAlloc)
    /* DBF20 800EB720 A87044AC */  sw         $a0, %lo(gMemAlloc)($v0)
    /* DBF24 800EB724 1380023C */  lui        $v0, %hi(gMemFree)
    /* DBF28 800EB728 2120C000 */  addu       $a0, $a2, $zero
    /* DBF2C 800EB72C 8DAC030C */  jal        iSPCH_BankMemAlloc
    /* DBF30 800EB730 AC7045AC */   sw        $a1, %lo(gMemFree)($v0)
    /* DBF34 800EB734 21384000 */  addu       $a3, $v0, $zero
  .L800EB738:
    /* DBF38 800EB738 1000BF8F */  lw         $ra, 0x10($sp)
    /* DBF3C 800EB73C 2110E000 */  addu       $v0, $a3, $zero
    /* DBF40 800EB740 0800E003 */  jr         $ra
    /* DBF44 800EB744 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SPCH_InitBankMem
