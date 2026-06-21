.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SavePinkSlipsCarsWithErrorDialogs__Fsss, 0x36C

glabel SavePinkSlipsCarsWithErrorDialogs__Fsss
    /* 25F78 80035778 00FABD27 */  addiu      $sp, $sp, -0x600
    /* 25F7C 8003577C E005B2AF */  sw         $s2, 0x5E0($sp)
    /* 25F80 80035780 21908000 */  addu       $s2, $a0, $zero
    /* 25F84 80035784 1000A427 */  addiu      $a0, $sp, 0x10
    /* 25F88 80035788 DC05B1AF */  sw         $s1, 0x5DC($sp)
    /* 25F8C 8003578C 2188C000 */  addu       $s1, $a2, $zero
    /* 25F90 80035790 F805BEAF */  sw         $fp, 0x5F8($sp)
    /* 25F94 80035794 21F0A000 */  addu       $fp, $a1, $zero
    /* 25F98 80035798 FC05BFAF */  sw         $ra, 0x5FC($sp)
    /* 25F9C 8003579C F405B7AF */  sw         $s7, 0x5F4($sp)
    /* 25FA0 800357A0 F005B6AF */  sw         $s6, 0x5F0($sp)
    /* 25FA4 800357A4 EC05B5AF */  sw         $s5, 0x5EC($sp)
    /* 25FA8 800357A8 E805B4AF */  sw         $s4, 0x5E8($sp)
    /* 25FAC 800357AC E405B3AF */  sw         $s3, 0x5E4($sp)
    /* 25FB0 800357B0 A366000C */  jal        __12tDialogYesNo
    /* 25FB4 800357B4 D805B0AF */   sw        $s0, 0x5D8($sp)
    /* 25FB8 800357B8 B800B027 */  addiu      $s0, $sp, 0xB8
    /* 25FBC 800357BC 0898000C */  jal        __7tScreen
    /* 25FC0 800357C0 21200002 */   addu      $a0, $s0, $zero
    /* 25FC4 800357C4 21B00000 */  addu       $s6, $zero, $zero
    /* 25FC8 800357C8 0580133C */  lui        $s3, %hi(FEApp)
    /* 25FCC 800357CC 4005B427 */  addiu      $s4, $sp, 0x540
    /* 25FD0 800357D0 00141200 */  sll        $v0, $s2, 16
    /* 25FD4 800357D4 03AC0200 */  sra        $s5, $v0, 16
    /* 25FD8 800357D8 00BC1100 */  sll        $s7, $s1, 16
    /* 25FDC 800357DC 0180023C */  lui        $v0, %hi(_vt_11tDialogBase)
    /* 25FE0 800357E0 B0054224 */  addiu      $v0, $v0, %lo(_vt_11tDialogBase)
    /* 25FE4 800357E4 1801A2AF */  sw         $v0, 0x118($sp)
    /* 25FE8 800357E8 20010224 */  addiu      $v0, $zero, 0x120
    /* 25FEC 800357EC 2801A0AF */  sw         $zero, 0x128($sp)
    /* 25FF0 800357F0 2601A0A7 */  sh         $zero, 0x126($sp)
    /* 25FF4 800357F4 3A01A0A7 */  sh         $zero, 0x13A($sp)
    /* 25FF8 800357F8 3601A0A7 */  sh         $zero, 0x136($sp)
    /* 25FFC 800357FC 3401A0A7 */  sh         $zero, 0x134($sp)
    /* 26000 80035800 2401A0A7 */  sh         $zero, 0x124($sp)
    /* 26004 80035804 2201A0A7 */  sh         $zero, 0x122($sp)
    /* 26008 80035808 2001A0A7 */  sh         $zero, 0x120($sp)
    /* 2600C 8003580C 1E01A0A7 */  sh         $zero, 0x11E($sp)
    /* 26010 80035810 800002A6 */  sh         $v0, 0x80($s0)
    /* 26014 80035814 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 26018 80035818 640002A6 */  sh         $v0, 0x64($s0)
    /* 2601C 8003581C 0180023C */  lui        $v0, %hi(_vt_20tDialogMessageString)
    /* 26020 80035820 F0044224 */  addiu      $v0, $v0, %lo(_vt_20tDialogMessageString)
    /* 26024 80035824 1801A2AF */  sw         $v0, 0x118($sp)
    /* 26028 80035828 80000224 */  addiu      $v0, $zero, 0x80
    /* 2602C 8003582C 4001A0A7 */  sh         $zero, 0x140($sp)
    /* 26030 80035830 3001A0AF */  sw         $zero, 0x130($sp)
    /* 26034 80035834 4C01A0AF */  sw         $zero, 0x14C($sp)
    /* 26038 80035838 3C01A0AF */  sw         $zero, 0x13C($sp)
    /* 2603C 8003583C 3001A0AF */  sw         $zero, 0x130($sp)
    /* 26040 80035840 8C0002AE */  sw         $v0, 0x8C($s0)
    /* 26044 80035844 0180023C */  lui        $v0, %hi(_vt_21tDialogNoInputMessage)
    /* 26048 80035848 30044224 */  addiu      $v0, $v0, %lo(_vt_21tDialogNoInputMessage)
    /* 2604C 8003584C 1000A327 */  addiu      $v1, $sp, 0x10
    /* 26050 80035850 1801A2AF */  sw         $v0, 0x118($sp)
    /* 26054 80035854 91020224 */  addiu      $v0, $zero, 0x291
    /* 26058 80035858 A00062AC */  sw         $v0, 0xA0($v1)
    /* 2605C 8003585C 92020224 */  addiu      $v0, $zero, 0x292
    /* 26060 80035860 A40062AC */  sw         $v0, 0xA4($v1)
    /* 26064 80035864 01000224 */  addiu      $v0, $zero, 0x1
    /* 26068 80035868 880062A4 */  sh         $v0, 0x88($v1)
    /* 2606C 8003586C 640072A4 */  sh         $s2, 0x64($v1)
  .L80035870:
    /* 26070 80035870 C014648E */  lw         $a0, %lo(FEApp)($s3)
    /* 26074 80035874 1062000C */  jal        Display__11tDialogBase
    /* 26078 80035878 D0028424 */   addiu     $a0, $a0, 0x2D0
  .L8003587C:
    /* 2607C 8003587C C014648E */  lw         $a0, %lo(FEApp)($s3)
    /* 26080 80035880 00000000 */  nop
    /* 26084 80035884 5403828C */  lw         $v0, 0x354($a0)
    /* 26088 80035888 00000000 */  nop
    /* 2608C 8003588C 01004238 */  xori       $v0, $v0, 0x1
    /* 26090 80035890 05004010 */  beqz       $v0, .L800358A8
    /* 26094 80035894 00000000 */   nop
    /* 26098 80035898 CF4D000C */  jal        Redraw__14tFEApplication
    /* 2609C 8003589C 00000000 */   nop
    /* 260A0 800358A0 1FD60008 */  j          .L8003587C
    /* 260A4 800358A4 00000000 */   nop
  .L800358A8:
    /* 260A8 800358A8 CF4D000C */  jal        Redraw__14tFEApplication
    /* 260AC 800358AC 21800000 */   addu      $s0, $zero, $zero
    /* 260B0 800358B0 0898000C */  jal        __7tScreen
    /* 260B4 800358B4 21208002 */   addu      $a0, $s4, $zero
    /* 260B8 800358B8 7602A426 */  addiu      $a0, $s5, 0x276
    /* 260BC 800358BC 0180023C */  lui        $v0, %hi(_vt_11tDialogBase)
    /* 260C0 800358C0 B0054224 */  addiu      $v0, $v0, %lo(_vt_11tDialogBase)
    /* 260C4 800358C4 A005A2AF */  sw         $v0, 0x5A0($sp)
    /* 260C8 800358C8 20010224 */  addiu      $v0, $zero, 0x120
    /* 260CC 800358CC B005A0AF */  sw         $zero, 0x5B0($sp)
    /* 260D0 800358D0 AE05A0A7 */  sh         $zero, 0x5AE($sp)
    /* 260D4 800358D4 C205A0A7 */  sh         $zero, 0x5C2($sp)
    /* 260D8 800358D8 BE05A0A7 */  sh         $zero, 0x5BE($sp)
    /* 260DC 800358DC BC05A0A7 */  sh         $zero, 0x5BC($sp)
    /* 260E0 800358E0 AC05A0A7 */  sh         $zero, 0x5AC($sp)
    /* 260E4 800358E4 AA05A0A7 */  sh         $zero, 0x5AA($sp)
    /* 260E8 800358E8 A805A0A7 */  sh         $zero, 0x5A8($sp)
    /* 260EC 800358EC A605A0A7 */  sh         $zero, 0x5A6($sp)
    /* 260F0 800358F0 800082A6 */  sh         $v0, 0x80($s4)
    /* 260F4 800358F4 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 260F8 800358F8 640082A6 */  sh         $v0, 0x64($s4)
    /* 260FC 800358FC 0180023C */  lui        $v0, %hi(_vt_20tDialogMessageString)
    /* 26100 80035900 F0044224 */  addiu      $v0, $v0, %lo(_vt_20tDialogMessageString)
    /* 26104 80035904 A005A2AF */  sw         $v0, 0x5A0($sp)
    /* 26108 80035908 80000224 */  addiu      $v0, $zero, 0x80
    /* 2610C 8003590C C805A0A7 */  sh         $zero, 0x5C8($sp)
    /* 26110 80035910 B805A0AF */  sw         $zero, 0x5B8($sp)
    /* 26114 80035914 D405A0AF */  sw         $zero, 0x5D4($sp)
    /* 26118 80035918 C405A0AF */  sw         $zero, 0x5C4($sp)
    /* 2611C 8003591C B805A0AF */  sw         $zero, 0x5B8($sp)
    /* 26120 80035920 8C0082AE */  sw         $v0, 0x8C($s4)
    /* 26124 80035924 0180023C */  lui        $v0, %hi(_vt_21tDialogNoInputMessage)
    /* 26128 80035928 30044224 */  addiu      $v0, $v0, %lo(_vt_21tDialogNoInputMessage)
    /* 2612C 8003592C 94E4020C */  jal        TextSys_Word__Fi
    /* 26130 80035930 A005A2AF */   sw        $v0, 0x5A0($sp)
    /* 26134 80035934 21208002 */  addu       $a0, $s4, $zero
    /* 26138 80035938 D005A2AF */  sw         $v0, 0x5D0($sp)
    /* 2613C 8003593C 32000224 */  addiu      $v0, $zero, 0x32
    /* 26140 80035940 BC05A0A7 */  sh         $zero, 0x5BC($sp)
    /* 26144 80035944 1062000C */  jal        Display__11tDialogBase
    /* 26148 80035948 BE05A2A7 */   sh        $v0, 0x5BE($sp)
  .L8003594C:
    /* 2614C 8003594C C405A28F */  lw         $v0, 0x5C4($sp)
    /* 26150 80035950 00000000 */  nop
    /* 26154 80035954 01004238 */  xori       $v0, $v0, 0x1
    /* 26158 80035958 06004010 */  beqz       $v0, .L80035974
    /* 2615C 8003595C 00000000 */   nop
    /* 26160 80035960 C014648E */  lw         $a0, %lo(FEApp)($s3)
    /* 26164 80035964 CF4D000C */  jal        Redraw__14tFEApplication
    /* 26168 80035968 00000000 */   nop
    /* 2616C 8003596C 53D60008 */  j          .L8003594C
    /* 26170 80035970 00000000 */   nop
  .L80035974:
    /* 26174 80035974 C014648E */  lw         $a0, %lo(FEApp)($s3)
    /* 26178 80035978 CF4D000C */  jal        Redraw__14tFEApplication
    /* 2617C 8003597C 00000000 */   nop
    /* 26180 80035980 2120A002 */  addu       $a0, $s5, $zero
  .L80035984:
    /* 26184 80035984 FCD4000C */  jal        SavePinkSlipsCars__Fss
    /* 26188 80035988 032C1700 */   sra       $a1, $s7, 16
    /* 2618C 8003598C 21904000 */  addu       $s2, $v0, $zero
    /* 26190 80035990 03004012 */  beqz       $s2, .L800359A0
    /* 26194 80035994 00000000 */   nop
    /* 26198 80035998 A1A0030C */  jal        timedwait
    /* 2619C 8003599C 05000424 */   addiu     $a0, $zero, 0x5
  .L800359A0:
    /* 261A0 800359A0 04004012 */  beqz       $s2, .L800359B4
    /* 261A4 800359A4 01001026 */   addiu     $s0, $s0, 0x1
    /* 261A8 800359A8 0300022A */  slti       $v0, $s0, 0x3
    /* 261AC 800359AC F5FF4014 */  bnez       $v0, .L80035984
    /* 261B0 800359B0 2120A002 */   addu      $a0, $s5, $zero
  .L800359B4:
    /* 261B4 800359B4 4162000C */  jal        Hide__11tDialogBase
    /* 261B8 800359B8 4005A427 */   addiu     $a0, $sp, 0x540
    /* 261BC 800359BC C014648E */  lw         $a0, %lo(FEApp)($s3)
    /* 261C0 800359C0 CF4D000C */  jal        Redraw__14tFEApplication
    /* 261C4 800359C4 00000000 */   nop
    /* 261C8 800359C8 2D004012 */  beqz       $s2, .L80035A80
    /* 261CC 800359CC 00000000 */   nop
    /* 261D0 800359D0 C014648E */  lw         $a0, %lo(FEApp)($s3)
    /* 261D4 800359D4 4162000C */  jal        Hide__11tDialogBase
    /* 261D8 800359D8 D0028424 */   addiu     $a0, $a0, 0x2D0
    /* 261DC 800359DC 0580033C */  lui        $v1, %hi(textSysMemCardFail_Index)
    /* 261E0 800359E0 841A6324 */  addiu      $v1, $v1, %lo(textSysMemCardFail_Index)
    /* 261E4 800359E4 80101200 */  sll        $v0, $s2, 2
    /* 261E8 800359E8 21104300 */  addu       $v0, $v0, $v1
    /* 261EC 800359EC 0000448C */  lw         $a0, 0x0($v0)
    /* 261F0 800359F0 94E4020C */  jal        TextSys_Word__Fi
    /* 261F4 800359F4 21209500 */   addu      $a0, $a0, $s5
    /* 261F8 800359F8 5001A427 */  addiu      $a0, $sp, 0x150
    /* 261FC 800359FC 2F91030C */  jal        sprintf
    /* 26200 80035A00 21284000 */   addu      $a1, $v0, $zero
    /* 26204 80035A04 00141E00 */  sll        $v0, $fp, 16
    /* 26208 80035A08 031C0200 */  sra        $v1, $v0, 16
    /* 2620C 80035A0C 14006010 */  beqz       $v1, .L80035A60
    /* 26210 80035A10 02000224 */   addiu     $v0, $zero, 0x2
    /* 26214 80035A14 02006214 */  bne        $v1, $v0, .L80035A20
    /* 26218 80035A18 98020424 */   addiu     $a0, $zero, 0x298
    /* 2621C 80035A1C 99020424 */  addiu      $a0, $zero, 0x299
  .L80035A20:
    /* 26220 80035A20 94E4020C */  jal        TextSys_Word__Fi
    /* 26224 80035A24 00000000 */   nop
    /* 26228 80035A28 2120A002 */  addu       $a0, $s5, $zero
    /* 2622C 80035A2C 7FAE000C */  jal        PlayerName__Fi
    /* 26230 80035A30 21804000 */   addu      $s0, $v0, $zero
    /* 26234 80035A34 4803B127 */  addiu      $s1, $sp, 0x348
    /* 26238 80035A38 21202002 */  addu       $a0, $s1, $zero
    /* 2623C 80035A3C 21280002 */  addu       $a1, $s0, $zero
    /* 26240 80035A40 2F91030C */  jal        sprintf
    /* 26244 80035A44 21304000 */   addu      $a2, $v0, $zero
    /* 26248 80035A48 B800A427 */  addiu      $a0, $sp, 0xB8
    /* 2624C 80035A4C C4FF0224 */  addiu      $v0, $zero, -0x3C
    /* 26250 80035A50 900091AC */  sw         $s1, 0x90($a0)
    /* 26254 80035A54 3401A0A7 */  sh         $zero, 0x134($sp)
    /* 26258 80035A58 1062000C */  jal        Display__11tDialogBase
    /* 2625C 80035A5C 3601A2A7 */   sh        $v0, 0x136($sp)
  .L80035A60:
    /* 26260 80035A60 1000A427 */  addiu      $a0, $sp, 0x10
    /* 26264 80035A64 5001A227 */  addiu      $v0, $sp, 0x150
    /* 26268 80035A68 FA65000C */  jal        Run__18tDialogInteractive
    /* 2626C 80035A6C 900082AC */   sw        $v0, 0x90($a0)
    /* 26270 80035A70 00140200 */  sll        $v0, $v0, 16
    /* 26274 80035A74 03B40200 */  sra        $s6, $v0, 16
    /* 26278 80035A78 4162000C */  jal        Hide__11tDialogBase
    /* 2627C 80035A7C B800A427 */   addiu     $a0, $sp, 0xB8
  .L80035A80:
    /* 26280 80035A80 4005A427 */  addiu      $a0, $sp, 0x540
    /* 26284 80035A84 1E98000C */  jal        ___7tScreen
    /* 26288 80035A88 02000524 */   addiu     $a1, $zero, 0x2
    /* 2628C 80035A8C 03004012 */  beqz       $s2, .L80035A9C
    /* 26290 80035A90 B800A427 */   addiu     $a0, $sp, 0xB8
    /* 26294 80035A94 76FFC016 */  bnez       $s6, .L80035870
    /* 26298 80035A98 00000000 */   nop
  .L80035A9C:
    /* 2629C 80035A9C 1E98000C */  jal        ___7tScreen
    /* 262A0 80035AA0 02000524 */   addiu     $a1, $zero, 0x2
    /* 262A4 80035AA4 1000A427 */  addiu      $a0, $sp, 0x10
    /* 262A8 80035AA8 1E98000C */  jal        ___7tScreen
    /* 262AC 80035AAC 02000524 */   addiu     $a1, $zero, 0x2
    /* 262B0 80035AB0 21104002 */  addu       $v0, $s2, $zero
    /* 262B4 80035AB4 FC05BF8F */  lw         $ra, 0x5FC($sp)
    /* 262B8 80035AB8 F805BE8F */  lw         $fp, 0x5F8($sp)
    /* 262BC 80035ABC F405B78F */  lw         $s7, 0x5F4($sp)
    /* 262C0 80035AC0 F005B68F */  lw         $s6, 0x5F0($sp)
    /* 262C4 80035AC4 EC05B58F */  lw         $s5, 0x5EC($sp)
    /* 262C8 80035AC8 E805B48F */  lw         $s4, 0x5E8($sp)
    /* 262CC 80035ACC E405B38F */  lw         $s3, 0x5E4($sp)
    /* 262D0 80035AD0 E005B28F */  lw         $s2, 0x5E0($sp)
    /* 262D4 80035AD4 DC05B18F */  lw         $s1, 0x5DC($sp)
    /* 262D8 80035AD8 D805B08F */  lw         $s0, 0x5D8($sp)
    /* 262DC 80035ADC 0800E003 */  jr         $ra
    /* 262E0 80035AE0 0006BD27 */   addiu     $sp, $sp, 0x600
endlabel SavePinkSlipsCarsWithErrorDialogs__Fsss
    /* 262E4 80035AE4 00000000 */  nop
