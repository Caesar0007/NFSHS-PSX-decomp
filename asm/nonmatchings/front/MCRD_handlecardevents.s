.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MCRD_handlecardevents, 0x34C

glabel MCRD_handlecardevents
    /* 40680 8004FE80 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 40684 8004FE84 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 40688 8004FE88 21888000 */  addu       $s1, $a0, $zero
    /* 4068C 8004FE8C 1800B0AF */  sw         $s0, 0x18($sp)
    /* 40690 8004FE90 17001024 */  addiu      $s0, $zero, 0x17
    /* 40694 8004FE94 2400BFAF */  sw         $ra, 0x24($sp)
    /* 40698 8004FE98 9140010C */  jal        MCRD_getcard
    /* 4069C 8004FE9C 2000B2AF */   sw        $s2, 0x20($sp)
    /* 406A0 8004FEA0 21200000 */  addu       $a0, $zero, $zero
    /* 406A4 8004FEA4 21904000 */  addu       $s2, $v0, $zero
    /* 406A8 8004FEA8 1000A527 */  addiu      $a1, $sp, 0x10
    /* 406AC 8004FEAC BFEE030C */  jal        MemCardSync
    /* 406B0 8004FEB0 1400A627 */   addiu     $a2, $sp, 0x14
    /* 406B4 8004FEB4 21184000 */  addu       $v1, $v0, $zero
    /* 406B8 8004FEB8 85006010 */  beqz       $v1, .L800500D0
    /* 406BC 8004FEBC 00000000 */   nop
    /* 406C0 8004FEC0 0600601C */  bgtz       $v1, .L8004FEDC
    /* 406C4 8004FEC4 01000224 */   addiu     $v0, $zero, 0x1
    /* 406C8 8004FEC8 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 406CC 8004FECC 64006210 */  beq        $v1, $v0, .L80050060
    /* 406D0 8004FED0 21100002 */   addu      $v0, $s0, $zero
    /* 406D4 8004FED4 6D400108 */  j          .L800501B4
    /* 406D8 8004FED8 00000000 */   nop
  .L8004FEDC:
    /* 406DC 8004FEDC B5006214 */  bne        $v1, $v0, .L800501B4
    /* 406E0 8004FEE0 21100002 */   addu      $v0, $s0, $zero
    /* 406E4 8004FEE4 1000A58F */  lw         $a1, 0x10($sp)
    /* 406E8 8004FEE8 00000000 */  nop
    /* 406EC 8004FEEC 0500A310 */  beq        $a1, $v1, .L8004FF04
    /* 406F0 8004FEF0 02000224 */   addiu     $v0, $zero, 0x2
    /* 406F4 8004FEF4 3900A210 */  beq        $a1, $v0, .L8004FFDC
    /* 406F8 8004FEF8 21100002 */   addu      $v0, $s0, $zero
    /* 406FC 8004FEFC 6D400108 */  j          .L800501B4
    /* 40700 8004FF00 00000000 */   nop
  .L8004FF04:
    /* 40704 8004FF04 1400A38F */  lw         $v1, 0x14($sp)
    /* 40708 8004FF08 00000000 */  nop
    /* 4070C 8004FF0C 1B006510 */  beq        $v1, $a1, .L8004FF7C
    /* 40710 8004FF10 02001024 */   addiu     $s0, $zero, 0x2
    /* 40714 8004FF14 07006010 */  beqz       $v1, .L8004FF34
    /* 40718 8004FF18 02000224 */   addiu     $v0, $zero, 0x2
    /* 4071C 8004FF1C 23006210 */  beq        $v1, $v0, .L8004FFAC
    /* 40720 8004FF20 03000224 */   addiu     $v0, $zero, 0x3
    /* 40724 8004FF24 27006210 */  beq        $v1, $v0, .L8004FFC4
    /* 40728 8004FF28 17001024 */   addiu     $s0, $zero, 0x17
    /* 4072C 8004FF2C 6D400108 */  j          .L800501B4
    /* 40730 8004FF30 21100002 */   addu      $v0, $s0, $zero
  .L8004FF34:
    /* 40734 8004FF34 0580023C */  lui        $v0, %hi(gMemCardInfo)
    /* 40738 8004FF38 682D4424 */  addiu      $a0, $v0, %lo(gMemCardInfo)
    /* 4073C 8004FF3C FFFF2226 */  addiu      $v0, $s1, -0x1
    /* 40740 8004FF40 80100200 */  sll        $v0, $v0, 2
    /* 40744 8004FF44 1480033C */  lui        $v1, %hi(timerhz)
    /* 40748 8004FF48 C4DC638C */  lw         $v1, %lo(timerhz)($v1)
    /* 4074C 8004FF4C 21104400 */  addu       $v0, $v0, $a0
    /* 40750 8004FF50 340085AC */  sw         $a1, 0x34($a0)
    /* 40754 8004FF54 400043AC */  sw         $v1, 0x40($v0)
    /* 40758 8004FF58 0000438E */  lw         $v1, 0x0($s2)
    /* 4075C 8004FF5C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 40760 8004FF60 5D006214 */  bne        $v1, $v0, .L800500D8
    /* 40764 8004FF64 16001024 */   addiu     $s0, $zero, 0x16
    /* 40768 8004FF68 3C00848C */  lw         $a0, 0x3C($a0)
    /* 4076C 8004FF6C 71EB030C */  jal        MemCardAccept
    /* 40770 8004FF70 00000000 */   nop
    /* 40774 8004FF74 6D400108 */  j          .L800501B4
    /* 40778 8004FF78 21100002 */   addu      $v0, $s0, $zero
  .L8004FF7C:
    /* 4077C 8004FF7C 0580043C */  lui        $a0, %hi(gMemCardInfo)
    /* 40780 8004FF80 682D8424 */  addiu      $a0, $a0, %lo(gMemCardInfo)
    /* 40784 8004FF84 FFFF2226 */  addiu      $v0, $s1, -0x1
    /* 40788 8004FF88 04100202 */  sllv       $v0, $v0, $s0
    /* 4078C 8004FF8C 1480033C */  lui        $v1, %hi(timerhz)
    /* 40790 8004FF90 C4DC638C */  lw         $v1, %lo(timerhz)($v1)
    /* 40794 8004FF94 21104400 */  addu       $v0, $v0, $a0
    /* 40798 8004FF98 340085AC */  sw         $a1, 0x34($a0)
    /* 4079C 8004FF9C 400043AC */  sw         $v1, 0x40($v0)
    /* 407A0 8004FFA0 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 407A4 8004FFA4 6C400108 */  j          .L800501B0
    /* 407A8 8004FFA8 000042AE */   sw        $v0, 0x0($s2)
  .L8004FFAC:
    /* 407AC 8004FFAC 03001024 */  addiu      $s0, $zero, 0x3
    /* 407B0 8004FFB0 0580023C */  lui        $v0, %hi(D_80052D9C)
    /* 407B4 8004FFB4 9C2D45AC */  sw         $a1, %lo(D_80052D9C)($v0)
    /* 407B8 8004FFB8 FCFF0224 */  addiu      $v0, $zero, -0x4
    /* 407BC 8004FFBC 6C400108 */  j          .L800501B0
    /* 407C0 8004FFC0 000042AE */   sw        $v0, 0x0($s2)
  .L8004FFC4:
    /* 407C4 8004FFC4 0580023C */  lui        $v0, %hi(D_80052DA4)
    /* 407C8 8004FFC8 A42D448C */  lw         $a0, %lo(D_80052DA4)($v0)
    /* 407CC 8004FFCC 71EB030C */  jal        MemCardAccept
    /* 407D0 8004FFD0 15001024 */   addiu     $s0, $zero, 0x15
    /* 407D4 8004FFD4 6D400108 */  j          .L800501B4
    /* 407D8 8004FFD8 21100002 */   addu      $v0, $s0, $zero
  .L8004FFDC:
    /* 407DC 8004FFDC 1400A38F */  lw         $v1, 0x14($sp)
    /* 407E0 8004FFE0 00000000 */  nop
    /* 407E4 8004FFE4 0500622C */  sltiu      $v0, $v1, 0x5
    /* 407E8 8004FFE8 71004010 */  beqz       $v0, .L800501B0
    /* 407EC 8004FFEC 0180023C */   lui       $v0, %hi(jtbl_80012858)
    /* 407F0 8004FFF0 58284224 */  addiu      $v0, $v0, %lo(jtbl_80012858)
    /* 407F4 8004FFF4 80180300 */  sll        $v1, $v1, 2
    /* 407F8 8004FFF8 21186200 */  addu       $v1, $v1, $v0
    /* 407FC 8004FFFC 0000628C */  lw         $v0, 0x0($v1)
    /* 40800 80050000 00000000 */  nop
    /* 40804 80050004 08004000 */  jr         $v0
    /* 40808 80050008 00000000 */   nop
  jlabel .L8005000C
    /* 4080C 8005000C 04001024 */  addiu      $s0, $zero, 0x4
    /* 40810 80050010 0580023C */  lui        $v0, %hi(gMemCardInfo)
    /* 40814 80050014 682D4224 */  addiu      $v0, $v0, %lo(gMemCardInfo)
    /* 40818 80050018 01000324 */  addiu      $v1, $zero, 0x1
    /* 4081C 8005001C 600251AC */  sw         $s1, 0x260($v0)
    /* 40820 80050020 6C400108 */  j          .L800501B0
    /* 40824 80050024 300043AC */   sw        $v1, 0x30($v0)
  jlabel .L80050028
    /* 40828 80050028 203D010C */  jal        iMCRD_InitCard
    /* 4082C 8005002C 21202002 */   addu      $a0, $s1, $zero
    /* 40830 80050030 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 40834 80050034 000042AE */  sw         $v0, 0x0($s2)
    /* 40838 80050038 6C400108 */  j          .L800501B0
    /* 4083C 8005003C 02001024 */   addiu     $s0, $zero, 0x2
  jlabel .L80050040
    /* 40840 80050040 203D010C */  jal        iMCRD_InitCard
    /* 40844 80050044 21202002 */   addu      $a0, $s1, $zero
    /* 40848 80050048 6C400108 */  j          .L800501B0
    /* 4084C 8005004C 03001024 */   addiu     $s0, $zero, 0x3
  jlabel .L80050050
    /* 40850 80050050 FEFF0224 */  addiu      $v0, $zero, -0x2
    /* 40854 80050054 000042AE */  sw         $v0, 0x0($s2)
    /* 40858 80050058 6C400108 */  j          .L800501B0
    /* 4085C 8005005C 05001024 */   addiu     $s0, $zero, 0x5
  .L80050060:
    /* 40860 80050060 0580023C */  lui        $v0, %hi(D_80052D98)
    /* 40864 80050064 982D438C */  lw         $v1, %lo(D_80052D98)($v0)
    /* 40868 80050068 00000000 */  nop
    /* 4086C 8005006C 0500622C */  sltiu      $v0, $v1, 0x5
    /* 40870 80050070 4F004010 */  beqz       $v0, .L800501B0
    /* 40874 80050074 0180023C */   lui       $v0, %hi(jtbl_80012870)
    /* 40878 80050078 70284224 */  addiu      $v0, $v0, %lo(jtbl_80012870)
    /* 4087C 8005007C 80180300 */  sll        $v1, $v1, 2
    /* 40880 80050080 21186200 */  addu       $v1, $v1, $v0
    /* 40884 80050084 0000628C */  lw         $v0, 0x0($v1)
    /* 40888 80050088 00000000 */  nop
    /* 4088C 8005008C 08004000 */  jr         $v0
    /* 40890 80050090 00000000 */   nop
  jlabel .L80050094
    /* 40894 80050094 0580023C */  lui        $v0, %hi(gMemCardInfo)
    /* 40898 80050098 682D4324 */  addiu      $v1, $v0, %lo(gMemCardInfo)
    /* 4089C 8005009C FFFF2226 */  addiu      $v0, $s1, -0x1
    /* 408A0 800500A0 80100200 */  sll        $v0, $v0, 2
    /* 408A4 800500A4 21104300 */  addu       $v0, $v0, $v1
    /* 408A8 800500A8 4000428C */  lw         $v0, 0x40($v0)
    /* 408AC 800500AC 00000000 */  nop
    /* 408B0 800500B0 09004104 */  bgez       $v0, .L800500D8
    /* 408B4 800500B4 16001024 */   addiu     $s0, $zero, 0x16
    /* 408B8 800500B8 3C00648C */  lw         $a0, 0x3C($v1)
    /* 408BC 800500BC 17001024 */  addiu      $s0, $zero, 0x17
    /* 408C0 800500C0 E2EA030C */  jal        MemCardExist
    /* 408C4 800500C4 340060AC */   sw        $zero, 0x34($v1)
    /* 408C8 800500C8 3A004010 */  beqz       $v0, .L800501B4
    /* 408CC 800500CC 21100002 */   addu      $v0, $s0, $zero
  .L800500D0:
    /* 408D0 800500D0 6C400108 */  j          .L800501B0
    /* 408D4 800500D4 15001024 */   addiu     $s0, $zero, 0x15
  .L800500D8:
    /* 408D8 800500D8 6D400108 */  j          .L800501B4
    /* 408DC 800500DC 21100002 */   addu      $v0, $s0, $zero
  jlabel .L800500E0
    /* 408E0 800500E0 0580023C */  lui        $v0, %hi(gMemCardInfo)
    /* 408E4 800500E4 682D4324 */  addiu      $v1, $v0, %lo(gMemCardInfo)
    /* 408E8 800500E8 6002628C */  lw         $v0, 0x260($v1)
    /* 408EC 800500EC 00000000 */  nop
    /* 408F0 800500F0 30002216 */  bne        $s1, $v0, .L800501B4
    /* 408F4 800500F4 21100002 */   addu      $v0, $s0, $zero
    /* 408F8 800500F8 21202002 */  addu       $a0, $s1, $zero
    /* 408FC 800500FC 040040AE */  sw         $zero, 0x4($s2)
    /* 40900 80050100 340060AC */  sw         $zero, 0x34($v1)
    /* 40904 80050104 D140010C */  jal        iMCRD_LoadCard
    /* 40908 80050108 300060AC */   sw        $zero, 0x30($v1)
    /* 4090C 8005010C 6D400108 */  j          .L800501B4
    /* 40910 80050110 00000000 */   nop
  jlabel .L80050114
    /* 40914 80050114 0580023C */  lui        $v0, %hi(gMemCardInfo)
    /* 40918 80050118 682D4324 */  addiu      $v1, $v0, %lo(gMemCardInfo)
    /* 4091C 8005011C 6002628C */  lw         $v0, 0x260($v1)
    /* 40920 80050120 00000000 */  nop
    /* 40924 80050124 23002216 */  bne        $s1, $v0, .L800501B4
    /* 40928 80050128 21100002 */   addu      $v0, $s0, $zero
    /* 4092C 8005012C 21202002 */  addu       $a0, $s1, $zero
    /* 40930 80050130 040040AE */  sw         $zero, 0x4($s2)
    /* 40934 80050134 340060AC */  sw         $zero, 0x34($v1)
    /* 40938 80050138 223F010C */  jal        iMCRD_DoFileWrite
    /* 4093C 8005013C 300060AC */   sw        $zero, 0x30($v1)
    /* 40940 80050140 6D400108 */  j          .L800501B4
    /* 40944 80050144 00000000 */   nop
  jlabel .L80050148
    /* 40948 80050148 0580023C */  lui        $v0, %hi(gMemCardInfo)
    /* 4094C 8005014C 682D4324 */  addiu      $v1, $v0, %lo(gMemCardInfo)
    /* 40950 80050150 6002628C */  lw         $v0, 0x260($v1)
    /* 40954 80050154 00000000 */  nop
    /* 40958 80050158 16002216 */  bne        $s1, $v0, .L800501B4
    /* 4095C 8005015C 21100002 */   addu      $v0, $s0, $zero
    /* 40960 80050160 21202002 */  addu       $a0, $s1, $zero
    /* 40964 80050164 040040AE */  sw         $zero, 0x4($s2)
    /* 40968 80050168 340060AC */  sw         $zero, 0x34($v1)
    /* 4096C 8005016C E93D010C */  jal        iMCRD_DoFileLoad
    /* 40970 80050170 300060AC */   sw        $zero, 0x30($v1)
    /* 40974 80050174 6D400108 */  j          .L800501B4
    /* 40978 80050178 00000000 */   nop
  jlabel .L8005017C
    /* 4097C 8005017C 0580023C */  lui        $v0, %hi(gMemCardInfo)
    /* 40980 80050180 682D4324 */  addiu      $v1, $v0, %lo(gMemCardInfo)
    /* 40984 80050184 6002628C */  lw         $v0, 0x260($v1)
    /* 40988 80050188 00000000 */  nop
    /* 4098C 8005018C 09002216 */  bne        $s1, $v0, .L800501B4
    /* 40990 80050190 21100002 */   addu      $v0, $s0, $zero
    /* 40994 80050194 21202002 */  addu       $a0, $s1, $zero
    /* 40998 80050198 040040AE */  sw         $zero, 0x4($s2)
    /* 4099C 8005019C 340060AC */  sw         $zero, 0x34($v1)
    /* 409A0 800501A0 7B3F010C */  jal        iMCRD_DoFileDelete
    /* 409A4 800501A4 300060AC */   sw        $zero, 0x30($v1)
    /* 409A8 800501A8 6D400108 */  j          .L800501B4
    /* 409AC 800501AC 00000000 */   nop
  .L800501B0:
    /* 409B0 800501B0 21100002 */  addu       $v0, $s0, $zero
  .L800501B4:
    /* 409B4 800501B4 2400BF8F */  lw         $ra, 0x24($sp)
    /* 409B8 800501B8 2000B28F */  lw         $s2, 0x20($sp)
    /* 409BC 800501BC 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 409C0 800501C0 1800B08F */  lw         $s0, 0x18($sp)
    /* 409C4 800501C4 0800E003 */  jr         $ra
    /* 409C8 800501C8 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel MCRD_handlecardevents
