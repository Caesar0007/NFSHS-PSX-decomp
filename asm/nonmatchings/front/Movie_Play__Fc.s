.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Movie_Play__Fc, 0x210

glabel Movie_Play__Fc
    /* 3D4E4 8004CCE4 1480023C */  lui        $v0, %hi(gMasterMusicLevel)
    /* 3D4E8 8004CCE8 50C6428C */  lw         $v0, %lo(gMasterMusicLevel)($v0)
    /* 3D4EC 8004CCEC 48FFBD27 */  addiu      $sp, $sp, -0xB8
    /* 3D4F0 8004CCF0 A000B0AF */  sw         $s0, 0xA0($sp)
    /* 3D4F4 8004CCF4 21808000 */  addu       $s0, $a0, $zero
    /* 3D4F8 8004CCF8 A400B1AF */  sw         $s1, 0xA4($sp)
    /* 3D4FC 8004CCFC 3000B127 */  addiu      $s1, $sp, 0x30
    /* 3D500 8004CD00 B000B4AF */  sw         $s4, 0xB0($sp)
    /* 3D504 8004CD04 0580143C */  lui        $s4, %hi(D_80052D04)
    /* 3D508 8004CD08 AC00B3AF */  sw         $s3, 0xAC($sp)
    /* 3D50C 8004CD0C 01001324 */  addiu      $s3, $zero, 0x1
    /* 3D510 8004CD10 B400BFAF */  sw         $ra, 0xB4($sp)
    /* 3D514 8004CD14 A800B2AF */  sw         $s2, 0xA8($sp)
    /* 3D518 8004CD18 C0210200 */  sll        $a0, $v0, 7
    /* 3D51C 8004CD1C 23208200 */  subu       $a0, $a0, $v0
    /* 3D520 8004CD20 91EA030C */  jal        SNDcdvol
    /* 3D524 8004CD24 C3210400 */   sra       $a0, $a0, 7
    /* 3D528 8004CD28 FF001032 */  andi       $s0, $s0, 0xFF
    /* 3D52C 8004CD2C 8231010C */  jal        Movie_Init__Fc
    /* 3D530 8004CD30 21200002 */   addu      $a0, $s0, $zero
    /* 3D534 8004CD34 6132010C */  jal        Movie_Load__Fc
    /* 3D538 8004CD38 21200002 */   addu      $a0, $s0, $zero
    /* 3D53C 8004CD3C 0580023C */  lui        $v0, %hi(D_80052D28)
    /* 3D540 8004CD40 282D5224 */  addiu      $s2, $v0, %lo(D_80052D28)
  .L8004CD44:
    /* 3D544 8004CD44 2133010C */  jal        Movie_Finished__Fv
    /* 3D548 8004CD48 00000000 */   nop
    /* 3D54C 8004CD4C 01004238 */  xori       $v0, $v0, 0x1
    /* 3D550 8004CD50 4F004010 */  beqz       $v0, .L8004CE90
    /* 3D554 8004CD54 00000000 */   nop
    /* 3D558 8004CD58 CC32010C */  jal        Movie_NextFrame__Fv
    /* 3D55C 8004CD5C 00000000 */   nop
    /* 3D560 8004CD60 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 3D564 8004CD64 4A004310 */  beq        $v0, $v1, .L8004CE90
    /* 3D568 8004CD68 00000000 */   nop
    /* 3D56C 8004CD6C 2000508E */  lw         $s0, 0x20($s2)
    /* 3D570 8004CD70 00000000 */  nop
    /* 3D574 8004CD74 0100102E */  sltiu      $s0, $s0, 0x1
    /* 3D578 8004CD78 C0801000 */  sll        $s0, $s0, 3
    /* 3D57C 8004CD7C 21801202 */  addu       $s0, $s0, $s2
    /* 3D580 8004CD80 10000586 */  lh         $a1, 0x10($s0)
    /* 3D584 8004CD84 12000686 */  lh         $a2, 0x12($s0)
    /* 3D588 8004CD88 14000786 */  lh         $a3, 0x14($s0)
    /* 3D58C 8004CD8C 16000286 */  lh         $v0, 0x16($s0)
    /* 3D590 8004CD90 1800A427 */  addiu      $a0, $sp, 0x18
    /* 3D594 8004CD94 B8C8030C */  jal        SetDefDispEnv
    /* 3D598 8004CD98 1000A2AF */   sw        $v0, 0x10($sp)
    /* 3D59C 8004CD9C F0000224 */  addiu      $v0, $zero, 0xF0
    /* 3D5A0 8004CDA0 2600A2A7 */  sh         $v0, 0x26($sp)
    /* 3D5A4 8004CDA4 10000586 */  lh         $a1, 0x10($s0)
    /* 3D5A8 8004CDA8 12000686 */  lh         $a2, 0x12($s0)
    /* 3D5AC 8004CDAC 14000786 */  lh         $a3, 0x14($s0)
    /* 3D5B0 8004CDB0 16000286 */  lh         $v0, 0x16($s0)
    /* 3D5B4 8004CDB4 21202002 */  addu       $a0, $s1, $zero
    /* 3D5B8 8004CDB8 8BC8030C */  jal        SetDefDrawEnv
    /* 3D5BC 8004CDBC 1000A2AF */   sw        $v0, 0x10($sp)
    /* 3D5C0 8004CDC0 042D828E */  lw         $v0, %lo(D_80052D04)($s4)
    /* 3D5C4 8004CDC4 00000000 */  nop
    /* 3D5C8 8004CDC8 0B004010 */  beqz       $v0, .L8004CDF8
    /* 3D5CC 8004CDCC 5555033C */   lui       $v1, (0x55555556 >> 16)
    /* 3D5D0 8004CDD0 1C00A287 */  lh         $v0, 0x1C($sp)
    /* 3D5D4 8004CDD4 56556334 */  ori        $v1, $v1, (0x55555556 & 0xFFFF)
    /* 3D5D8 8004CDD8 40100200 */  sll        $v0, $v0, 1
    /* 3D5DC 8004CDDC 18004300 */  mult       $v0, $v1
    /* 3D5E0 8004CDE0 01000324 */  addiu      $v1, $zero, 0x1
    /* 3D5E4 8004CDE4 C3170200 */  sra        $v0, $v0, 31
    /* 3D5E8 8004CDE8 2900A3A3 */  sb         $v1, 0x29($sp)
    /* 3D5EC 8004CDEC 10400000 */  mfhi       $t0
    /* 3D5F0 8004CDF0 23100201 */  subu       $v0, $t0, $v0
    /* 3D5F4 8004CDF4 1C00A2A7 */  sh         $v0, 0x1C($sp)
  .L8004CDF8:
    /* 3D5F8 8004CDF8 79B7030C */  jal        PutDispEnv
    /* 3D5FC 8004CDFC 1800A427 */   addiu     $a0, $sp, 0x18
    /* 3D600 8004CE00 49B7030C */  jal        PutDrawEnv
    /* 3D604 8004CE04 21202002 */   addu      $a0, $s1, $zero
    /* 3D608 8004CE08 F9B5030C */  jal        SetDispMask
    /* 3D60C 8004CE0C 01000424 */   addiu     $a0, $zero, 0x1
    /* 3D610 8004CE10 042D828E */  lw         $v0, %lo(D_80052D04)($s4)
    /* 3D614 8004CE14 00000000 */  nop
    /* 3D618 8004CE18 03004014 */  bnez       $v0, .L8004CE28
    /* 3D61C 8004CE1C 00000000 */   nop
    /* 3D620 8004CE20 46DB030C */  jal        FntFlush
    /* 3D624 8004CE24 FFFF0424 */   addiu     $a0, $zero, -0x1
  .L8004CE28:
    /* 3D628 8004CE28 1933010C */  jal        Movie_DownloadFrame__Fv
    /* 3D62C 8004CE2C 00000000 */   nop
    /* 3D630 8004CE30 0580023C */  lui        $v0, %hi(download)
    /* 3D634 8004CE34 8490030C */  jal        PAD_update
    /* 3D638 8004CE38 302A53A4 */   sh        $s3, %lo(download)($v0)
    /* 3D63C 8004CE3C 6B90030C */  jal        PAD_state
    /* 3D640 8004CE40 21200000 */   addu      $a0, $zero, $zero
    /* 3D644 8004CE44 04000424 */  addiu      $a0, $zero, 0x4
    /* 3D648 8004CE48 6B90030C */  jal        PAD_state
    /* 3D64C 8004CE4C 21804000 */   addu      $s0, $v0, $zero
    /* 3D650 8004CE50 25800202 */  or         $s0, $s0, $v0
    /* 3D654 8004CE54 FFFF1032 */  andi       $s0, $s0, 0xFFFF
    /* 3D658 8004CE58 BAFF0012 */  beqz       $s0, .L8004CD44
    /* 3D65C 8004CE5C 00000000 */   nop
    /* 3D660 8004CE60 1D33010C */  jal        Movie_Stop__Fv
    /* 3D664 8004CE64 00000000 */   nop
    /* 3D668 8004CE68 0580023C */  lui        $v0, %hi(skip_all)
    /* 3D66C 8004CE6C 2E2A4290 */  lbu        $v0, %lo(skip_all)($v0)
    /* 3D670 8004CE70 00000000 */  nop
    /* 3D674 8004CE74 04004014 */  bnez       $v0, .L8004CE88
    /* 3D678 8004CE78 0580023C */   lui       $v0, %hi(user_exit)
    /* 3D67C 8004CE7C 08000224 */  addiu      $v0, $zero, 0x8
    /* 3D680 8004CE80 B0FF0216 */  bne        $s0, $v0, .L8004CD44
    /* 3D684 8004CE84 0580023C */   lui       $v0, %hi(user_exit)
  .L8004CE88:
    /* 3D688 8004CE88 51330108 */  j          .L8004CD44
    /* 3D68C 8004CE8C 2C2A53A4 */   sh        $s3, %lo(user_exit)($v0)
  .L8004CE90:
    /* 3D690 8004CE90 F631010C */  jal        Movie_DeInit__Fv
    /* 3D694 8004CE94 0580103C */   lui       $s0, %hi(D_80052D38)
    /* 3D698 8004CE98 382D1026 */  addiu      $s0, $s0, %lo(D_80052D38)
    /* 3D69C 8004CE9C 21200002 */  addu       $a0, $s0, $zero
    /* 3D6A0 8004CEA0 21280000 */  addu       $a1, $zero, $zero
    /* 3D6A4 8004CEA4 2130A000 */  addu       $a2, $a1, $zero
    /* 3D6A8 8004CEA8 80B6030C */  jal        ClearImage
    /* 3D6AC 8004CEAC 2138A000 */   addu      $a3, $a1, $zero
    /* 3D6B0 8004CEB0 08000426 */  addiu      $a0, $s0, 0x8
    /* 3D6B4 8004CEB4 21280000 */  addu       $a1, $zero, $zero
    /* 3D6B8 8004CEB8 2130A000 */  addu       $a2, $a1, $zero
    /* 3D6BC 8004CEBC 80B6030C */  jal        ClearImage
    /* 3D6C0 8004CEC0 2138A000 */   addu      $a3, $a1, $zero
    /* 3D6C4 8004CEC4 1FB6030C */  jal        DrawSync
    /* 3D6C8 8004CEC8 21200000 */   addu      $a0, $zero, $zero
    /* 3D6CC 8004CECC 0580023C */  lui        $v0, %hi(user_exit)
    /* 3D6D0 8004CED0 2C2A4284 */  lh         $v0, %lo(user_exit)($v0)
    /* 3D6D4 8004CED4 B400BF8F */  lw         $ra, 0xB4($sp)
    /* 3D6D8 8004CED8 B000B48F */  lw         $s4, 0xB0($sp)
    /* 3D6DC 8004CEDC AC00B38F */  lw         $s3, 0xAC($sp)
    /* 3D6E0 8004CEE0 A800B28F */  lw         $s2, 0xA8($sp)
    /* 3D6E4 8004CEE4 A400B18F */  lw         $s1, 0xA4($sp)
    /* 3D6E8 8004CEE8 A000B08F */  lw         $s0, 0xA0($sp)
    /* 3D6EC 8004CEEC 0800E003 */  jr         $ra
    /* 3D6F0 8004CEF0 B800BD27 */   addiu     $sp, $sp, 0xB8
endlabel Movie_Play__Fc
