.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDmemrestore, 0x44

glabel iSNDmemrestore
    /* F69F4 801061F4 1580043C */  lui        $a0, %hi(sndmm)
    /* F69F8 801061F8 80878424 */  addiu      $a0, $a0, %lo(sndmm)
    /* F69FC 801061FC 0800838C */  lw         $v1, 0x8($a0)
    /* F6A00 80106200 00000000 */  nop
    /* F6A04 80106204 40100300 */  sll        $v0, $v1, 1
    /* F6A08 80106208 21104300 */  addu       $v0, $v0, $v1
    /* F6A0C 8010620C C0100200 */  sll        $v0, $v0, 3
    /* F6A10 80106210 21104300 */  addu       $v0, $v0, $v1
    /* F6A14 80106214 06008394 */  lhu        $v1, 0x6($a0)
    /* F6A18 80106218 80100200 */  sll        $v0, $v0, 2
    /* F6A1C 8010621C 1B004300 */  divu       $zero, $v0, $v1
    /* F6A20 80106220 02006014 */  bnez       $v1, .L8010622C
    /* F6A24 80106224 00000000 */   nop
    /* F6A28 80106228 0D000700 */  break      7
  .L8010622C:
    /* F6A2C 8010622C 12100000 */  mflo       $v0
    /* F6A30 80106230 0800E003 */  jr         $ra
    /* F6A34 80106234 00000000 */   nop
endlabel iSNDmemrestore
