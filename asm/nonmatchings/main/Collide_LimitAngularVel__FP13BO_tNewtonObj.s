.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Collide_LimitAngularVel__FP13BO_tNewtonObj, 0xF4

glabel Collide_LimitAngularVel__FP13BO_tNewtonObj
    /* 7E0B4 8008D8B4 1401838C */  lw         $v1, 0x114($a0)
    /* 7E0B8 8008D8B8 00000000 */  nop
    /* 7E0BC 8008D8BC 0A006104 */  bgez       $v1, .L8008D8E8
    /* 7E0C0 8008D8C0 0100023C */   lui       $v0, (0x18000 >> 16)
    /* 7E0C4 8008D8C4 FEFF023C */  lui        $v0, (0xFFFE8000 >> 16)
    /* 7E0C8 8008D8C8 00804234 */  ori        $v0, $v0, (0xFFFE8000 & 0xFFFF)
    /* 7E0CC 8008D8CC 2A106200 */  slt        $v0, $v1, $v0
    /* 7E0D0 8008D8D0 03004010 */  beqz       $v0, .L8008D8E0
    /* 7E0D4 8008D8D4 00000000 */   nop
    /* 7E0D8 8008D8D8 FEFF033C */  lui        $v1, (0xFFFE8000 >> 16)
    /* 7E0DC 8008D8DC 00806334 */  ori        $v1, $v1, (0xFFFE8000 & 0xFFFF)
  .L8008D8E0:
    /* 7E0E0 8008D8E0 41360208 */  j          .L8008D904
    /* 7E0E4 8008D8E4 140183AC */   sw        $v1, 0x114($a0)
  .L8008D8E8:
    /* 7E0E8 8008D8E8 00804234 */  ori        $v0, $v0, (0x18000 & 0xFFFF)
    /* 7E0EC 8008D8EC 0100053C */  lui        $a1, (0x18000 >> 16)
    /* 7E0F0 8008D8F0 2A104300 */  slt        $v0, $v0, $v1
    /* 7E0F4 8008D8F4 02004014 */  bnez       $v0, .L8008D900
    /* 7E0F8 8008D8F8 0080A534 */   ori       $a1, $a1, (0x18000 & 0xFFFF)
    /* 7E0FC 8008D8FC 21286000 */  addu       $a1, $v1, $zero
  .L8008D900:
    /* 7E100 8008D900 140185AC */  sw         $a1, 0x114($a0)
  .L8008D904:
    /* 7E104 8008D904 1801838C */  lw         $v1, 0x118($a0)
    /* 7E108 8008D908 00000000 */  nop
    /* 7E10C 8008D90C 0A006104 */  bgez       $v1, .L8008D938
    /* 7E110 8008D910 0100023C */   lui       $v0, (0x18000 >> 16)
    /* 7E114 8008D914 FEFF023C */  lui        $v0, (0xFFFE8000 >> 16)
    /* 7E118 8008D918 00804234 */  ori        $v0, $v0, (0xFFFE8000 & 0xFFFF)
    /* 7E11C 8008D91C 2A106200 */  slt        $v0, $v1, $v0
    /* 7E120 8008D920 03004010 */  beqz       $v0, .L8008D930
    /* 7E124 8008D924 00000000 */   nop
    /* 7E128 8008D928 FEFF033C */  lui        $v1, (0xFFFE8000 >> 16)
    /* 7E12C 8008D92C 00806334 */  ori        $v1, $v1, (0xFFFE8000 & 0xFFFF)
  .L8008D930:
    /* 7E130 8008D930 55360208 */  j          .L8008D954
    /* 7E134 8008D934 180183AC */   sw        $v1, 0x118($a0)
  .L8008D938:
    /* 7E138 8008D938 00804234 */  ori        $v0, $v0, (0x18000 & 0xFFFF)
    /* 7E13C 8008D93C 0100053C */  lui        $a1, (0x18000 >> 16)
    /* 7E140 8008D940 2A104300 */  slt        $v0, $v0, $v1
    /* 7E144 8008D944 02004014 */  bnez       $v0, .L8008D950
    /* 7E148 8008D948 0080A534 */   ori       $a1, $a1, (0x18000 & 0xFFFF)
    /* 7E14C 8008D94C 21286000 */  addu       $a1, $v1, $zero
  .L8008D950:
    /* 7E150 8008D950 180185AC */  sw         $a1, 0x118($a0)
  .L8008D954:
    /* 7E154 8008D954 1C01838C */  lw         $v1, 0x11C($a0)
    /* 7E158 8008D958 00000000 */  nop
    /* 7E15C 8008D95C 0A006104 */  bgez       $v1, .L8008D988
    /* 7E160 8008D960 0100023C */   lui       $v0, (0x18000 >> 16)
    /* 7E164 8008D964 FEFF023C */  lui        $v0, (0xFFFE8000 >> 16)
    /* 7E168 8008D968 00804234 */  ori        $v0, $v0, (0xFFFE8000 & 0xFFFF)
    /* 7E16C 8008D96C 2A106200 */  slt        $v0, $v1, $v0
    /* 7E170 8008D970 03004010 */  beqz       $v0, .L8008D980
    /* 7E174 8008D974 00000000 */   nop
    /* 7E178 8008D978 FEFF033C */  lui        $v1, (0xFFFE8000 >> 16)
    /* 7E17C 8008D97C 00806334 */  ori        $v1, $v1, (0xFFFE8000 & 0xFFFF)
  .L8008D980:
    /* 7E180 8008D980 0800E003 */  jr         $ra
    /* 7E184 8008D984 1C0183AC */   sw        $v1, 0x11C($a0)
  .L8008D988:
    /* 7E188 8008D988 00804234 */  ori        $v0, $v0, (0x18000 & 0xFFFF)
    /* 7E18C 8008D98C 0100053C */  lui        $a1, (0x18000 >> 16)
    /* 7E190 8008D990 2A104300 */  slt        $v0, $v0, $v1
    /* 7E194 8008D994 02004014 */  bnez       $v0, .L8008D9A0
    /* 7E198 8008D998 0080A534 */   ori       $a1, $a1, (0x18000 & 0xFFFF)
    /* 7E19C 8008D99C 21286000 */  addu       $a1, $v1, $zero
  .L8008D9A0:
    /* 7E1A0 8008D9A0 0800E003 */  jr         $ra
    /* 7E1A4 8008D9A4 1C0185AC */   sw        $a1, 0x11C($a0)
endlabel Collide_LimitAngularVel__FP13BO_tNewtonObj
