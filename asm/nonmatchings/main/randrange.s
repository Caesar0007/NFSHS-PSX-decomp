.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching randrange, 0x5C

glabel randrange
    /* FC4F4 8010BCF4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* FC4F8 8010BCF8 1000B0AF */  sw         $s0, 0x10($sp)
    /* FC4FC 8010BCFC 21808000 */  addu       $s0, $a0, $zero
    /* FC500 8010BD00 0100023C */  lui        $v0, (0x10000 >> 16)
    /* FC504 8010BD04 2A105000 */  slt        $v0, $v0, $s0
    /* FC508 8010BD08 03004010 */  beqz       $v0, .L8010BD18
    /* FC50C 8010BD0C 1400BFAF */   sw        $ra, 0x14($sp)
    /* FC510 8010BD10 492F0408 */  j          .L8010BD24
    /* FC514 8010BD14 0100103C */   lui       $s0, (0x10000 >> 16)
  .L8010BD18:
    /* FC518 8010BD18 02000106 */  bgez       $s0, .L8010BD24
    /* FC51C 8010BD1C 00000000 */   nop
    /* FC520 8010BD20 21800000 */  addu       $s0, $zero, $zero
  .L8010BD24:
    /* FC524 8010BD24 A02F040C */  jal        iSNDrandom
    /* FC528 8010BD28 00000000 */   nop
    /* FC52C 8010BD2C FF7F4230 */  andi       $v0, $v0, 0x7FFF
    /* FC530 8010BD30 00C04224 */  addiu      $v0, $v0, -0x4000
    /* FC534 8010BD34 18005000 */  mult       $v0, $s0
    /* FC538 8010BD38 1400BF8F */  lw         $ra, 0x14($sp)
    /* FC53C 8010BD3C 1000B08F */  lw         $s0, 0x10($sp)
    /* FC540 8010BD40 12180000 */  mflo       $v1
    /* FC544 8010BD44 83130300 */  sra        $v0, $v1, 14
    /* FC548 8010BD48 0800E003 */  jr         $ra
    /* FC54C 8010BD4C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel randrange
