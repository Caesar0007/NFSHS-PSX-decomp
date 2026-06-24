.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MemCardGetDirentry, 0x260

glabel MemCardGetDirentry
    /* EC088 800FB888 70FFBD27 */  addiu      $sp, $sp, -0x90
    /* EC08C 800FB88C 8400B7AF */  sw         $s7, 0x84($sp)
    /* EC090 800FB890 21B88000 */  addu       $s7, $a0, $zero
    /* EC094 800FB894 6800B0AF */  sw         $s0, 0x68($sp)
    /* EC098 800FB898 2180A000 */  addu       $s0, $a1, $zero
    /* EC09C 800FB89C 8000B6AF */  sw         $s6, 0x80($sp)
    /* EC0A0 800FB8A0 21B0C000 */  addu       $s6, $a2, $zero
    /* EC0A4 800FB8A4 7400B3AF */  sw         $s3, 0x74($sp)
    /* EC0A8 800FB8A8 1480133C */  lui        $s3, %hi(D_80147518)
    /* EC0AC 800FB8AC 18757326 */  addiu      $s3, $s3, %lo(D_80147518)
    /* EC0B0 800FB8B0 8C00BFAF */  sw         $ra, 0x8C($sp)
    /* EC0B4 800FB8B4 8800BEAF */  sw         $fp, 0x88($sp)
    /* EC0B8 800FB8B8 7C00B5AF */  sw         $s5, 0x7C($sp)
    /* EC0BC 800FB8BC 7800B4AF */  sw         $s4, 0x78($sp)
    /* EC0C0 800FB8C0 7000B2AF */  sw         $s2, 0x70($sp)
    /* EC0C4 800FB8C4 6C00B1AF */  sw         $s1, 0x6C($sp)
    /* EC0C8 800FB8C8 5C00A7AF */  sw         $a3, 0x5C($sp)
    /* EC0CC 800FB8CC 0000628E */  lw         $v0, 0x0($s3)
    /* EC0D0 800FB8D0 A000BE8F */  lw         $fp, 0xA0($sp)
    /* EC0D4 800FB8D4 06004010 */  beqz       $v0, .L800FB8F0
    /* EC0D8 800FB8D8 2120E002 */   addu      $a0, $s7, $zero
    /* EC0DC 800FB8DC 0580043C */  lui        $a0, %hi(D_800574C0)
    /* EC0E0 800FB8E0 2B0A040C */  jal        printf
    /* EC0E4 800FB8E4 C0748424 */   addiu     $a0, $a0, %lo(D_800574C0)
    /* EC0E8 800FB8E8 AEEE0308 */  j          .L800FBAB8
    /* EC0EC 800FB8EC FFFF0224 */   addiu     $v0, $zero, -0x1
  .L800FB8F0:
    /* EC0F0 800FB8F0 7DF0030C */  jal        MemCardMakeDevname
    /* EC0F4 800FB8F4 1000A527 */   addiu     $a1, $sp, 0x10
    /* EC0F8 800FB8F8 1000A427 */  addiu      $a0, $sp, 0x10
    /* EC0FC 800FB8FC 3A9E030C */  jal        strcat
    /* EC100 800FB900 21280002 */   addu      $a1, $s0, $zero
    /* EC104 800FB904 21900000 */  addu       $s2, $zero, $zero
    /* EC108 800FB908 21880000 */  addu       $s1, $zero, $zero
    /* EC10C 800FB90C 01000324 */  addiu      $v1, $zero, 0x1
    /* EC110 800FB910 5800A0AF */  sw         $zero, 0x58($sp)
    /* EC114 800FB914 0C00648E */  lw         $a0, 0xC($s3)
    /* EC118 800FB918 1480023C */  lui        $v0, %hi(D_80147514)
    /* EC11C 800FB91C 1475428C */  lw         $v0, %lo(D_80147514)($v0)
    /* EC120 800FB920 A400A88F */  lw         $t0, 0xA4($sp)
    /* EC124 800FB924 04188300 */  sllv       $v1, $v1, $a0
    /* EC128 800FB928 25104300 */  or         $v0, $v0, $v1
    /* EC12C 800FB92C 1480013C */  lui        $at, %hi(D_80147514)
    /* EC130 800FB930 147522AC */  sw         $v0, %lo(D_80147514)($at)
    /* EC134 800FB934 2110C803 */  addu       $v0, $fp, $t0
    /* EC138 800FB938 5A004018 */  blez       $v0, .L800FBAA4
    /* EC13C 800FB93C 21A80000 */   addu      $s5, $zero, $zero
    /* EC140 800FB940 5000A827 */  addiu      $t0, $sp, 0x50
    /* EC144 800FB944 6000A8AF */  sw         $t0, 0x60($sp)
    /* EC148 800FB948 21A00000 */  addu       $s4, $zero, $zero
  .L800FB94C:
    /* EC14C 800FB94C 32002016 */  bnez       $s1, .L800FBA18
    /* EC150 800FB950 00000000 */   nop
  .L800FB954:
    /* EC154 800FB954 3426040C */  jal        _clr_card_event
    /* EC158 800FB958 00000000 */   nop
    /* EC15C 800FB95C 1000A427 */  addiu      $a0, $sp, 0x10
    /* EC160 800FB960 7027040C */  jal        firstfile
    /* EC164 800FB964 3000A527 */   addiu     $a1, $sp, 0x30
    /* EC168 800FB968 21804000 */  addu       $s0, $v0, $zero
    /* EC16C 800FB96C 2F000016 */  bnez       $s0, .L800FBA2C
    /* EC170 800FB970 2A103E02 */   slt       $v0, $s1, $fp
    /* EC174 800FB974 AC26040C */  jal        _get_card_event_x
    /* EC178 800FB978 00000000 */   nop
    /* EC17C 800FB97C 47F0030C */  jal        MemCardEventToRslt
    /* EC180 800FB980 21204000 */   addu      $a0, $v0, $zero
    /* EC184 800FB984 27004010 */  beqz       $v0, .L800FBA24
    /* EC188 800FB988 5800A2AF */   sw        $v0, 0x58($sp)
    /* EC18C 800FB98C 01005226 */  addiu      $s2, $s2, 0x1
    /* EC190 800FB990 0400422A */  slti       $v0, $s2, 0x4
    /* EC194 800FB994 EFFF4014 */  bnez       $v0, .L800FB954
    /* EC198 800FB998 00000000 */   nop
    /* EC19C 800FB99C BAEE030C */  jal        MemCardCallback
    /* EC1A0 800FB9A0 21200000 */   addu      $a0, $zero, $zero
    /* EC1A4 800FB9A4 0000638E */  lw         $v1, 0x0($s3)
    /* EC1A8 800FB9A8 1480013C */  lui        $at, %hi(D_8014756C)
    /* EC1AC 800FB9AC 6C7522AC */  sw         $v0, %lo(D_8014756C)($at)
    /* EC1B0 800FB9B0 06006018 */  blez       $v1, .L800FB9CC
    /* EC1B4 800FB9B4 02000824 */   addiu     $t0, $zero, 0x2
    /* EC1B8 800FB9B8 0580043C */  lui        $a0, %hi(D_80057370)
    /* EC1BC 800FB9BC 2B0A040C */  jal        printf
    /* EC1C0 800FB9C0 70738424 */   addiu     $a0, $a0, %lo(D_80057370)
    /* EC1C4 800FB9C4 7CEE0308 */  j          .L800FB9F0
    /* EC1C8 800FB9C8 21200000 */   addu      $a0, $zero, $zero
  .L800FB9CC:
    /* EC1CC 800FB9CC 1080043C */  lui        $a0, %hi(MemCardCmd_cb)
    /* EC1D0 800FB9D0 2CAE8424 */  addiu      $a0, $a0, %lo(MemCardCmd_cb)
    /* EC1D4 800FB9D4 000068AE */  sw         $t0, 0x0($s3)
    /* EC1D8 800FB9D8 040060AE */  sw         $zero, 0x4($s3)
    /* EC1DC 800FB9DC 080060AE */  sw         $zero, 0x8($s3)
    /* EC1E0 800FB9E0 1480013C */  lui        $at, %hi(D_80147524)
    /* EC1E4 800FB9E4 0427040C */  jal        UserFuncOpen
    /* EC1E8 800FB9E8 247537AC */   sw        $s7, %lo(D_80147524)($at)
    /* EC1EC 800FB9EC 21200000 */  addu       $a0, $zero, $zero
  .L800FB9F0:
    /* EC1F0 800FB9F0 21280000 */  addu       $a1, $zero, $zero
    /* EC1F4 800FB9F4 BFEE030C */  jal        MemCardSync
    /* EC1F8 800FB9F8 5800A627 */   addiu     $a2, $sp, 0x58
    /* EC1FC 800FB9FC 1480043C */  lui        $a0, %hi(D_8014756C)
    /* EC200 800FBA00 6C75848C */  lw         $a0, %lo(D_8014756C)($a0)
    /* EC204 800FBA04 BAEE030C */  jal        MemCardCallback
    /* EC208 800FBA08 00000000 */   nop
    /* EC20C 800FBA0C 5800A28F */  lw         $v0, 0x58($sp)
    /* EC210 800FBA10 AEEE0308 */  j          .L800FBAB8
    /* EC214 800FBA14 00000000 */   nop
  .L800FBA18:
    /* EC218 800FBA18 1828040C */  jal        nextfile
    /* EC21C 800FBA1C 3000A427 */   addiu     $a0, $sp, 0x30
    /* EC220 800FBA20 21804000 */  addu       $s0, $v0, $zero
  .L800FBA24:
    /* EC224 800FBA24 1F000012 */  beqz       $s0, .L800FBAA4
    /* EC228 800FBA28 2A103E02 */   slt       $v0, $s1, $fp
  .L800FBA2C:
    /* EC22C 800FBA2C 17004014 */  bnez       $v0, .L800FBA8C
    /* EC230 800FBA30 00000000 */   nop
    /* EC234 800FBA34 1500C012 */  beqz       $s6, .L800FBA8C
    /* EC238 800FBA38 21389602 */   addu      $a3, $s4, $s6
    /* EC23C 800FBA3C 3000A627 */  addiu      $a2, $sp, 0x30
  .L800FBA40:
    /* EC240 800FBA40 0000C28C */  lw         $v0, 0x0($a2)
    /* EC244 800FBA44 0400C38C */  lw         $v1, 0x4($a2)
    /* EC248 800FBA48 0800C48C */  lw         $a0, 0x8($a2)
    /* EC24C 800FBA4C 0C00C58C */  lw         $a1, 0xC($a2)
    /* EC250 800FBA50 0000E2AC */  sw         $v0, 0x0($a3)
    /* EC254 800FBA54 0400E3AC */  sw         $v1, 0x4($a3)
    /* EC258 800FBA58 0800E4AC */  sw         $a0, 0x8($a3)
    /* EC25C 800FBA5C 0C00E5AC */  sw         $a1, 0xC($a3)
    /* EC260 800FBA60 1000C624 */  addiu      $a2, $a2, 0x10
    /* EC264 800FBA64 6000A88F */  lw         $t0, 0x60($sp)
    /* EC268 800FBA68 00000000 */  nop
    /* EC26C 800FBA6C F4FFC814 */  bne        $a2, $t0, .L800FBA40
    /* EC270 800FBA70 1000E724 */   addiu     $a3, $a3, 0x10
    /* EC274 800FBA74 0000C28C */  lw         $v0, 0x0($a2)
    /* EC278 800FBA78 0400C38C */  lw         $v1, 0x4($a2)
    /* EC27C 800FBA7C 0000E2AC */  sw         $v0, 0x0($a3)
    /* EC280 800FBA80 0400E3AC */  sw         $v1, 0x4($a3)
    /* EC284 800FBA84 28009426 */  addiu      $s4, $s4, 0x28
    /* EC288 800FBA88 0100B526 */  addiu      $s5, $s5, 0x1
  .L800FBA8C:
    /* EC28C 800FBA8C A400A88F */  lw         $t0, 0xA4($sp)
    /* EC290 800FBA90 01003126 */  addiu      $s1, $s1, 0x1
    /* EC294 800FBA94 2110C803 */  addu       $v0, $fp, $t0
    /* EC298 800FBA98 2A102202 */  slt        $v0, $s1, $v0
    /* EC29C 800FBA9C ABFF4014 */  bnez       $v0, .L800FB94C
    /* EC2A0 800FBAA0 00000000 */   nop
  .L800FBAA4:
    /* EC2A4 800FBAA4 5C00A88F */  lw         $t0, 0x5C($sp)
    /* EC2A8 800FBAA8 00000000 */  nop
    /* EC2AC 800FBAAC 02000011 */  beqz       $t0, .L800FBAB8
    /* EC2B0 800FBAB0 21100000 */   addu      $v0, $zero, $zero
    /* EC2B4 800FBAB4 000015AD */  sw         $s5, 0x0($t0)
  .L800FBAB8:
    /* EC2B8 800FBAB8 8C00BF8F */  lw         $ra, 0x8C($sp)
    /* EC2BC 800FBABC 8800BE8F */  lw         $fp, 0x88($sp)
    /* EC2C0 800FBAC0 8400B78F */  lw         $s7, 0x84($sp)
    /* EC2C4 800FBAC4 8000B68F */  lw         $s6, 0x80($sp)
    /* EC2C8 800FBAC8 7C00B58F */  lw         $s5, 0x7C($sp)
    /* EC2CC 800FBACC 7800B48F */  lw         $s4, 0x78($sp)
    /* EC2D0 800FBAD0 7400B38F */  lw         $s3, 0x74($sp)
    /* EC2D4 800FBAD4 7000B28F */  lw         $s2, 0x70($sp)
    /* EC2D8 800FBAD8 6C00B18F */  lw         $s1, 0x6C($sp)
    /* EC2DC 800FBADC 6800B08F */  lw         $s0, 0x68($sp)
    /* EC2E0 800FBAE0 0800E003 */  jr         $ra
    /* EC2E4 800FBAE4 9000BD27 */   addiu     $sp, $sp, 0x90
endlabel MemCardGetDirentry
