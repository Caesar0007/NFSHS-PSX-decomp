.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_GetRuleID, 0x74

glabel iSPCH_GetRuleID
    /* FBA20 8010B220 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* FBA24 8010B224 2400B1AF */  sw         $s1, 0x24($sp)
    /* FBA28 8010B228 2188A000 */  addu       $s1, $a1, $zero
    /* FBA2C 8010B22C 2000B0AF */  sw         $s0, 0x20($sp)
    /* FBA30 8010B230 2800BFAF */  sw         $ra, 0x28($sp)
    /* FBA34 8010B234 502C040C */  jal        func_8010B140
    /* FBA38 8010B238 FFFF1024 */   addiu     $s0, $zero, -0x1
    /* FBA3C 8010B23C 21204000 */  addu       $a0, $v0, $zero
    /* FBA40 8010B240 0800222E */  sltiu      $v0, $s1, 0x8
    /* FBA44 8010B244 0D004010 */  beqz       $v0, .L8010B27C
    /* FBA48 8010B248 40181100 */   sll       $v1, $s1, 1
    /* FBA4C 8010B24C 21186400 */  addu       $v1, $v1, $a0
    /* FBA50 8010B250 00006490 */  lbu        $a0, 0x0($v1)
    /* FBA54 8010B254 00000000 */  nop
    /* FBA58 8010B258 1000A4AF */  sw         $a0, 0x10($sp)
    /* FBA5C 8010B25C 01006290 */  lbu        $v0, 0x1($v1)
    /* FBA60 8010B260 00000000 */  nop
    /* FBA64 8010B264 0F004230 */  andi       $v0, $v0, 0xF
    /* FBA68 8010B268 1400A2AF */  sw         $v0, 0x14($sp)
    /* FBA6C 8010B26C 01006290 */  lbu        $v0, 0x1($v1)
    /* FBA70 8010B270 21808000 */  addu       $s0, $a0, $zero
    /* FBA74 8010B274 02110200 */  srl        $v0, $v0, 4
    /* FBA78 8010B278 1800A2AF */  sw         $v0, 0x18($sp)
  .L8010B27C:
    /* FBA7C 8010B27C 21100002 */  addu       $v0, $s0, $zero
    /* FBA80 8010B280 2800BF8F */  lw         $ra, 0x28($sp)
    /* FBA84 8010B284 2400B18F */  lw         $s1, 0x24($sp)
    /* FBA88 8010B288 2000B08F */  lw         $s0, 0x20($sp)
    /* FBA8C 8010B28C 0800E003 */  jr         $ra
    /* FBA90 8010B290 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel iSPCH_GetRuleID
