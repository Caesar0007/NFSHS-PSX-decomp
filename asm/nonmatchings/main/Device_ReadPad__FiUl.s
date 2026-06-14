.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Device_ReadPad__FiUl, 0x230

glabel Device_ReadPad__FiUl
    /* ADEAC 800BD6AC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* ADEB0 800BD6B0 1000B0AF */  sw         $s0, 0x10($sp)
    /* ADEB4 800BD6B4 21808000 */  addu       $s0, $a0, $zero
    /* ADEB8 800BD6B8 1400B1AF */  sw         $s1, 0x14($sp)
    /* ADEBC 800BD6BC 1800BFAF */  sw         $ra, 0x18($sp)
    /* ADEC0 800BD6C0 F0F4020C */  jal        Device_VerifyType__Fi
    /* ADEC4 800BD6C4 2188A000 */   addu      $s1, $a1, $zero
    /* ADEC8 800BD6C8 03004014 */  bnez       $v0, .L800BD6D8
    /* ADECC 800BD6CC 1480023C */   lui       $v0, %hi(gPadinfo)
    /* ADED0 800BD6D0 32F60208 */  j          .L800BD8C8
    /* ADED4 800BD6D4 21100000 */   addu      $v0, $zero, $zero
  .L800BD6D8:
    /* ADED8 800BD6D8 9CE84224 */  addiu      $v0, $v0, %lo(gPadinfo)
    /* ADEDC 800BD6DC C0181000 */  sll        $v1, $s0, 3
    /* ADEE0 800BD6E0 21206200 */  addu       $a0, $v1, $v0
    /* ADEE4 800BD6E4 05008390 */  lbu        $v1, 0x5($a0)
    /* ADEE8 800BD6E8 23000224 */  addiu      $v0, $zero, 0x23
    /* ADEEC 800BD6EC 1A006214 */  bne        $v1, $v0, .L800BD758
    /* ADEF0 800BD6F0 C0181000 */   sll       $v1, $s0, 3
    /* ADEF4 800BD6F4 FFFF2332 */  andi       $v1, $s1, 0xFFFF
    /* ADEF8 800BD6F8 00400224 */  addiu      $v0, $zero, 0x4000
    /* ADEFC 800BD6FC 06006214 */  bne        $v1, $v0, .L800BD718
    /* ADF00 800BD700 1480023C */   lui       $v0, %hi(gPadinfo)
    /* ADF04 800BD704 09008290 */  lbu        $v0, 0x9($a0)
    /* ADF08 800BD708 00000000 */  nop
    /* ADF0C 800BD70C 4000422C */  sltiu      $v0, $v0, 0x40
    /* ADF10 800BD710 22004010 */  beqz       $v0, .L800BD79C
    /* ADF14 800BD714 1480023C */   lui       $v0, %hi(gPadinfo)
  .L800BD718:
    /* ADF18 800BD718 9CE84224 */  addiu      $v0, $v0, %lo(gPadinfo)
    /* ADF1C 800BD71C C0181000 */  sll        $v1, $s0, 3
    /* ADF20 800BD720 21206200 */  addu       $a0, $v1, $v0
    /* ADF24 800BD724 05008390 */  lbu        $v1, 0x5($a0)
    /* ADF28 800BD728 23000224 */  addiu      $v0, $zero, 0x23
    /* ADF2C 800BD72C 0A006214 */  bne        $v1, $v0, .L800BD758
    /* ADF30 800BD730 C0181000 */   sll       $v1, $s0, 3
    /* ADF34 800BD734 FFFF2332 */  andi       $v1, $s1, 0xFFFF
    /* ADF38 800BD738 00800234 */  ori        $v0, $zero, 0x8000
    /* ADF3C 800BD73C 06006214 */  bne        $v1, $v0, .L800BD758
    /* ADF40 800BD740 C0181000 */   sll       $v1, $s0, 3
    /* ADF44 800BD744 0A008290 */  lbu        $v0, 0xA($a0)
    /* ADF48 800BD748 00000000 */  nop
    /* ADF4C 800BD74C 4000422C */  sltiu      $v0, $v0, 0x40
    /* ADF50 800BD750 5D004010 */  beqz       $v0, .L800BD8C8
    /* ADF54 800BD754 01000224 */   addiu     $v0, $zero, 0x1
  .L800BD758:
    /* ADF58 800BD758 1480023C */  lui        $v0, %hi(D_8013E8A2)
    /* ADF5C 800BD75C A2E84224 */  addiu      $v0, $v0, %lo(D_8013E8A2)
    /* ADF60 800BD760 21286200 */  addu       $a1, $v1, $v0
    /* ADF64 800BD764 21104300 */  addu       $v0, $v0, $v1
    /* ADF68 800BD768 FFFF4390 */  lbu        $v1, -0x1($v0)
    /* ADF6C 800BD76C 73000224 */  addiu      $v0, $zero, 0x73
    /* ADF70 800BD770 50006214 */  bne        $v1, $v0, .L800BD8B4
    /* ADF74 800BD774 0200A424 */   addiu     $a0, $a1, 0x2
    /* ADF78 800BD778 FFFF2332 */  andi       $v1, $s1, 0xFFFF
    /* ADF7C 800BD77C 80000224 */  addiu      $v0, $zero, 0x80
    /* ADF80 800BD780 0D006214 */  bne        $v1, $v0, .L800BD7B8
    /* ADF84 800BD784 00000000 */   nop
    /* ADF88 800BD788 0200A290 */  lbu        $v0, 0x2($a1)
    /* ADF8C 800BD78C 00000000 */  nop
    /* ADF90 800BD790 4100422C */  sltiu      $v0, $v0, 0x41
    /* ADF94 800BD794 03004010 */  beqz       $v0, .L800BD7A4
    /* ADF98 800BD798 00000000 */   nop
  .L800BD79C:
    /* ADF9C 800BD79C 32F60208 */  j          .L800BD8C8
    /* ADFA0 800BD7A0 01000224 */   addiu     $v0, $zero, 0x1
  .L800BD7A4:
    /* ADFA4 800BD7A4 02008290 */  lbu        $v0, 0x2($a0)
    /* ADFA8 800BD7A8 00000000 */  nop
    /* ADFAC 800BD7AC 4100422C */  sltiu      $v0, $v0, 0x41
    /* ADFB0 800BD7B0 45004014 */  bnez       $v0, .L800BD8C8
    /* ADFB4 800BD7B4 01000224 */   addiu     $v0, $zero, 0x1
  .L800BD7B8:
    /* ADFB8 800BD7B8 1480033C */  lui        $v1, %hi(gPadinfo)
    /* ADFBC 800BD7BC 9CE86324 */  addiu      $v1, $v1, %lo(gPadinfo)
    /* ADFC0 800BD7C0 C0101000 */  sll        $v0, $s0, 3
    /* ADFC4 800BD7C4 21104300 */  addu       $v0, $v0, $v1
    /* ADFC8 800BD7C8 05004390 */  lbu        $v1, 0x5($v0)
    /* ADFCC 800BD7CC 73000224 */  addiu      $v0, $zero, 0x73
    /* ADFD0 800BD7D0 38006214 */  bne        $v1, $v0, .L800BD8B4
    /* ADFD4 800BD7D4 FFFF2332 */   andi      $v1, $s1, 0xFFFF
    /* ADFD8 800BD7D8 20000224 */  addiu      $v0, $zero, 0x20
    /* ADFDC 800BD7DC 0B006214 */  bne        $v1, $v0, .L800BD80C
    /* ADFE0 800BD7E0 00000000 */   nop
    /* ADFE4 800BD7E4 00008290 */  lbu        $v0, 0x0($a0)
    /* ADFE8 800BD7E8 00000000 */  nop
    /* ADFEC 800BD7EC C000422C */  sltiu      $v0, $v0, 0xC0
    /* ADFF0 800BD7F0 35004010 */  beqz       $v0, .L800BD8C8
    /* ADFF4 800BD7F4 01000224 */   addiu     $v0, $zero, 0x1
    /* ADFF8 800BD7F8 02008290 */  lbu        $v0, 0x2($a0)
    /* ADFFC 800BD7FC 00000000 */  nop
    /* AE000 800BD800 C000422C */  sltiu      $v0, $v0, 0xC0
    /* AE004 800BD804 30004010 */  beqz       $v0, .L800BD8C8
    /* AE008 800BD808 01000224 */   addiu     $v0, $zero, 0x1
  .L800BD80C:
    /* AE00C 800BD80C 1480033C */  lui        $v1, %hi(gPadinfo)
    /* AE010 800BD810 9CE86324 */  addiu      $v1, $v1, %lo(gPadinfo)
    /* AE014 800BD814 C0101000 */  sll        $v0, $s0, 3
    /* AE018 800BD818 21104300 */  addu       $v0, $v0, $v1
    /* AE01C 800BD81C 05004390 */  lbu        $v1, 0x5($v0)
    /* AE020 800BD820 73000224 */  addiu      $v0, $zero, 0x73
    /* AE024 800BD824 23006214 */  bne        $v1, $v0, .L800BD8B4
    /* AE028 800BD828 FFFF2332 */   andi      $v1, $s1, 0xFFFF
    /* AE02C 800BD82C 10000224 */  addiu      $v0, $zero, 0x10
    /* AE030 800BD830 0B006214 */  bne        $v1, $v0, .L800BD860
    /* AE034 800BD834 00000000 */   nop
    /* AE038 800BD838 03008290 */  lbu        $v0, 0x3($a0)
    /* AE03C 800BD83C 00000000 */  nop
    /* AE040 800BD840 4100422C */  sltiu      $v0, $v0, 0x41
    /* AE044 800BD844 20004014 */  bnez       $v0, .L800BD8C8
    /* AE048 800BD848 01000224 */   addiu     $v0, $zero, 0x1
    /* AE04C 800BD84C 01008290 */  lbu        $v0, 0x1($a0)
    /* AE050 800BD850 00000000 */  nop
    /* AE054 800BD854 4100422C */  sltiu      $v0, $v0, 0x41
    /* AE058 800BD858 1B004014 */  bnez       $v0, .L800BD8C8
    /* AE05C 800BD85C 01000224 */   addiu     $v0, $zero, 0x1
  .L800BD860:
    /* AE060 800BD860 1480033C */  lui        $v1, %hi(gPadinfo)
    /* AE064 800BD864 9CE86324 */  addiu      $v1, $v1, %lo(gPadinfo)
    /* AE068 800BD868 C0101000 */  sll        $v0, $s0, 3
    /* AE06C 800BD86C 21104300 */  addu       $v0, $v0, $v1
    /* AE070 800BD870 05004390 */  lbu        $v1, 0x5($v0)
    /* AE074 800BD874 73000224 */  addiu      $v0, $zero, 0x73
    /* AE078 800BD878 0E006214 */  bne        $v1, $v0, .L800BD8B4
    /* AE07C 800BD87C FFFF2332 */   andi      $v1, $s1, 0xFFFF
    /* AE080 800BD880 40000224 */  addiu      $v0, $zero, 0x40
    /* AE084 800BD884 0B006214 */  bne        $v1, $v0, .L800BD8B4
    /* AE088 800BD888 00000000 */   nop
    /* AE08C 800BD88C 03008290 */  lbu        $v0, 0x3($a0)
    /* AE090 800BD890 00000000 */  nop
    /* AE094 800BD894 C000422C */  sltiu      $v0, $v0, 0xC0
    /* AE098 800BD898 0B004010 */  beqz       $v0, .L800BD8C8
    /* AE09C 800BD89C 01000224 */   addiu     $v0, $zero, 0x1
    /* AE0A0 800BD8A0 01008290 */  lbu        $v0, 0x1($a0)
    /* AE0A4 800BD8A4 00000000 */  nop
    /* AE0A8 800BD8A8 C000422C */  sltiu      $v0, $v0, 0xC0
    /* AE0AC 800BD8AC 06004010 */  beqz       $v0, .L800BD8C8
    /* AE0B0 800BD8B0 01000224 */   addiu     $v0, $zero, 0x1
  .L800BD8B4:
    /* AE0B4 800BD8B4 6B90030C */  jal        PAD_state
    /* AE0B8 800BD8B8 21200002 */   addu      $a0, $s0, $zero
    /* AE0BC 800BD8BC FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* AE0C0 800BD8C0 24105100 */  and        $v0, $v0, $s1
    /* AE0C4 800BD8C4 2B100200 */  sltu       $v0, $zero, $v0
  .L800BD8C8:
    /* AE0C8 800BD8C8 1800BF8F */  lw         $ra, 0x18($sp)
    /* AE0CC 800BD8CC 1400B18F */  lw         $s1, 0x14($sp)
    /* AE0D0 800BD8D0 1000B08F */  lw         $s0, 0x10($sp)
    /* AE0D4 800BD8D4 0800E003 */  jr         $ra
    /* AE0D8 800BD8D8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Device_ReadPad__FiUl
