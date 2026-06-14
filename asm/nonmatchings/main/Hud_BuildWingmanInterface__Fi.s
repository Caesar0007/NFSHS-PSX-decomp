.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BuildWingmanInterface__Fi, 0x34C

glabel Hud_BuildWingmanInterface__Fi
    /* C686C 800D606C B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* C6870 800D6070 2800B2AF */  sw         $s2, 0x28($sp)
    /* C6874 800D6074 21908000 */  addu       $s2, $a0, $zero
    /* C6878 800D6078 21400000 */  addu       $t0, $zero, $zero
    /* C687C 800D607C 4000BFAF */  sw         $ra, 0x40($sp)
    /* C6880 800D6080 3C00B7AF */  sw         $s7, 0x3C($sp)
    /* C6884 800D6084 3800B6AF */  sw         $s6, 0x38($sp)
    /* C6888 800D6088 3400B5AF */  sw         $s5, 0x34($sp)
    /* C688C 800D608C 3000B4AF */  sw         $s4, 0x30($sp)
    /* C6890 800D6090 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* C6894 800D6094 2400B1AF */  sw         $s1, 0x24($sp)
    /* C6898 800D6098 02004012 */  beqz       $s2, .L800D60A4
    /* C689C 800D609C 2000B0AF */   sw        $s0, 0x20($sp)
    /* C68A0 800D60A0 F1FF0824 */  addiu      $t0, $zero, -0xF
  .L800D60A4:
    /* C68A4 800D60A4 29000424 */  addiu      $a0, $zero, 0x29
    /* C68A8 800D60A8 80181200 */  sll        $v1, $s2, 2
    /* C68AC 800D60AC 1480023C */  lui        $v0, %hi(Hud_gWingmanFlashTicks)
    /* C68B0 800D60B0 B8D84224 */  addiu      $v0, $v0, %lo(Hud_gWingmanFlashTicks)
    /* C68B4 800D60B4 21186200 */  addu       $v1, $v1, $v0
    /* C68B8 800D60B8 1480063C */  lui        $a2, %hi(ticks)
    /* C68BC 800D60BC ACDCC68C */  lw         $a2, %lo(ticks)($a2)
    /* C68C0 800D60C0 B818878F */  lw         $a3, %gp_rel(D_8013DE04)($gp)
    /* C68C4 800D60C4 0000658C */  lw         $a1, 0x0($v1)
    /* C68C8 800D60C8 2014828F */  lw         $v0, %gp_rel(HudMapOffsetY)($gp)
    /* C68CC 800D60CC 2398A600 */  subu       $s3, $a1, $a2
    /* C68D0 800D60D0 3A00E384 */  lh         $v1, 0x3A($a3)
    /* C68D4 800D60D4 3800F184 */  lh         $s1, 0x38($a3)
    /* C68D8 800D60D8 21186200 */  addu       $v1, $v1, $v0
    /* C68DC 800D60DC 02000225 */  addiu      $v0, $t0, 0x2
    /* C68E0 800D60E0 94E4020C */  jal        TextSys_Word__Fi
    /* C68E4 800D60E4 21A06200 */   addu      $s4, $v1, $v0
    /* C68E8 800D60E8 21204000 */  addu       $a0, $v0, $zero
    /* C68EC 800D60EC E5FF3026 */  addiu      $s0, $s1, -0x1B
    /* C68F0 800D60F0 21280002 */  addu       $a1, $s0, $zero
    /* C68F4 800D60F4 03008626 */  addiu      $a2, $s4, 0x3
    /* C68F8 800D60F8 8000073C */  lui        $a3, (0x808080 >> 16)
    /* C68FC 800D60FC 8080E734 */  ori        $a3, $a3, (0x808080 & 0xFFFF)
    /* C6900 800D6100 1000A0AF */  sw         $zero, 0x10($sp)
    /* C6904 800D6104 B250030C */  jal        Hud_BuildString__FPciiiib
    /* C6908 800D6108 1400A0AF */   sw        $zero, 0x14($sp)
    /* C690C 800D610C 94E4020C */  jal        TextSys_Word__Fi
    /* C6910 800D6110 2A000424 */   addiu     $a0, $zero, 0x2A
    /* C6914 800D6114 21204000 */  addu       $a0, $v0, $zero
    /* C6918 800D6118 21280002 */  addu       $a1, $s0, $zero
    /* C691C 800D611C 0C008626 */  addiu      $a2, $s4, 0xC
    /* C6920 800D6120 8000073C */  lui        $a3, (0x808080 >> 16)
    /* C6924 800D6124 8080E734 */  ori        $a3, $a3, (0x808080 & 0xFFFF)
    /* C6928 800D6128 1000B2AF */  sw         $s2, 0x10($sp)
    /* C692C 800D612C B250030C */  jal        Hud_BuildString__FPciiiib
    /* C6930 800D6130 1400A0AF */   sw        $zero, 0x14($sp)
    /* C6934 800D6134 94E4020C */  jal        TextSys_Word__Fi
    /* C6938 800D6138 2B000424 */   addiu     $a0, $zero, 0x2B
    /* C693C 800D613C 21204000 */  addu       $a0, $v0, $zero
    /* C6940 800D6140 21280002 */  addu       $a1, $s0, $zero
    /* C6944 800D6144 15008626 */  addiu      $a2, $s4, 0x15
    /* C6948 800D6148 8000073C */  lui        $a3, (0x808080 >> 16)
    /* C694C 800D614C 8080E734 */  ori        $a3, $a3, (0x808080 & 0xFFFF)
    /* C6950 800D6150 1000B2AF */  sw         $s2, 0x10($sp)
    /* C6954 800D6154 B250030C */  jal        Hud_BuildString__FPciiiib
    /* C6958 800D6158 1400A0AF */   sw        $zero, 0x14($sp)
    /* C695C 800D615C 94E4020C */  jal        TextSys_Word__Fi
    /* C6960 800D6160 2C000424 */   addiu     $a0, $zero, 0x2C
    /* C6964 800D6164 21204000 */  addu       $a0, $v0, $zero
    /* C6968 800D6168 21280002 */  addu       $a1, $s0, $zero
    /* C696C 800D616C 1E008626 */  addiu      $a2, $s4, 0x1E
    /* C6970 800D6170 8000073C */  lui        $a3, (0x808080 >> 16)
    /* C6974 800D6174 8080E734 */  ori        $a3, $a3, (0x808080 & 0xFFFF)
    /* C6978 800D6178 1000B2AF */  sw         $s2, 0x10($sp)
    /* C697C 800D617C B250030C */  jal        Hud_BuildString__FPciiiib
    /* C6980 800D6180 1400A0AF */   sw        $zero, 0x14($sp)
    /* C6984 800D6184 94E4020C */  jal        TextSys_Word__Fi
    /* C6988 800D6188 2D000424 */   addiu     $a0, $zero, 0x2D
    /* C698C 800D618C 21204000 */  addu       $a0, $v0, $zero
    /* C6990 800D6190 21280002 */  addu       $a1, $s0, $zero
    /* C6994 800D6194 27008626 */  addiu      $a2, $s4, 0x27
    /* C6998 800D6198 8000073C */  lui        $a3, (0x808080 >> 16)
    /* C699C 800D619C 8080E734 */  ori        $a3, $a3, (0x808080 & 0xFFFF)
    /* C69A0 800D61A0 E4FF3726 */  addiu      $s7, $s1, -0x1C
    /* C69A4 800D61A4 1000B2AF */  sw         $s2, 0x10($sp)
    /* C69A8 800D61A8 B250030C */  jal        Hud_BuildString__FPciiiib
    /* C69AC 800D61AC 1400A0AF */   sw        $zero, 0x14($sp)
    /* C69B0 800D61B0 3400601A */  blez       $s3, .L800D6284
    /* C69B4 800D61B4 66660B3C */   lui       $t3, (0x66666667 >> 16)
    /* C69B8 800D61B8 67666B35 */  ori        $t3, $t3, (0x66666667 & 0xFFFF)
    /* C69BC 800D61BC 801F0A3C */  lui        $t2, (0x1F800004 >> 16)
    /* C69C0 800D61C0 04004A35 */  ori        $t2, $t2, (0x1F800004 & 0xFFFF)
    /* C69C4 800D61C4 FF00083C */  lui        $t0, (0xFFFFFF >> 16)
    /* C69C8 800D61C8 FFFF0835 */  ori        $t0, $t0, (0xFFFFFF & 0xFFFF)
    /* C69CC 800D61CC 21280000 */  addu       $a1, $zero, $zero
    /* C69D0 800D61D0 F0FF2626 */  addiu      $a2, $s1, -0x10
    /* C69D4 800D61D4 00FF093C */  lui        $t1, (0xFF000000 >> 16)
    /* C69D8 800D61D8 18006B02 */  mult       $s3, $t3
    /* C69DC 800D61DC 0000448D */  lw         $a0, 0x0($t2)
    /* C69E0 800D61E0 801F073C */  lui        $a3, (0x1F800000 >> 16)
    /* C69E4 800D61E4 0000E78C */  lw         $a3, (0x1F800000 & 0xFFFF)($a3)
    /* C69E8 800D61E8 0000838C */  lw         $v1, 0x0($a0)
    /* C69EC 800D61EC 0000E28C */  lw         $v0, 0x0($a3)
    /* C69F0 800D61F0 24186900 */  and        $v1, $v1, $t1
    /* C69F4 800D61F4 24104800 */  and        $v0, $v0, $t0
    /* C69F8 800D61F8 25186200 */  or         $v1, $v1, $v0
    /* C69FC 800D61FC 000083AC */  sw         $v1, 0x0($a0)
    /* C6A00 800D6200 0000E28C */  lw         $v0, 0x0($a3)
    /* C6A04 800D6204 18008324 */  addiu      $v1, $a0, 0x18
    /* C6A08 800D6208 000043AD */  sw         $v1, 0x0($t2)
    /* C6A0C 800D620C 24188800 */  and        $v1, $a0, $t0
    /* C6A10 800D6210 24104900 */  and        $v0, $v0, $t1
    /* C6A14 800D6214 25104300 */  or         $v0, $v0, $v1
    /* C6A18 800D6218 0000E2AC */  sw         $v0, 0x0($a3)
    /* C6A1C 800D621C 1480023C */  lui        $v0, %hi(Hud_gWingmanFlashIcon)
    /* C6A20 800D6220 B4D84224 */  addiu      $v0, $v0, %lo(Hud_gWingmanFlashIcon)
    /* C6A24 800D6224 21104202 */  addu       $v0, $s2, $v0
    /* C6A28 800D6228 00004390 */  lbu        $v1, 0x0($v0)
    /* C6A2C 800D622C 3F000224 */  addiu      $v0, $zero, 0x3F
    /* C6A30 800D6230 1000A2AF */  sw         $v0, 0x10($sp)
    /* C6A34 800D6234 08000224 */  addiu      $v0, $zero, 0x8
    /* C6A38 800D6238 1400A2AF */  sw         $v0, 0x14($sp)
    /* C6A3C 800D623C C3171300 */  sra        $v0, $s3, 31
    /* C6A40 800D6240 01006324 */  addiu      $v1, $v1, 0x1
    /* C6A44 800D6244 C0380300 */  sll        $a3, $v1, 3
    /* C6A48 800D6248 2138E300 */  addu       $a3, $a3, $v1
    /* C6A4C 800D624C 0200E724 */  addiu      $a3, $a3, 0x2
    /* C6A50 800D6250 21388702 */  addu       $a3, $s4, $a3
    /* C6A54 800D6254 10600000 */  mfhi       $t4
    /* C6A58 800D6258 C3180C00 */  sra        $v1, $t4, 3
    /* C6A5C 800D625C 23186200 */  subu       $v1, $v1, $v0
    /* C6A60 800D6260 80100300 */  sll        $v0, $v1, 2
    /* C6A64 800D6264 21104300 */  addu       $v0, $v0, $v1
    /* C6A68 800D6268 80100200 */  sll        $v0, $v0, 2
    /* C6A6C 800D626C 23106202 */  subu       $v0, $s3, $v0
    /* C6A70 800D6270 80180200 */  sll        $v1, $v0, 2
    /* C6A74 800D6274 21186200 */  addu       $v1, $v1, $v0
    /* C6A78 800D6278 40180300 */  sll        $v1, $v1, 1
    /* C6A7C 800D627C 8D49030C */  jal        Hud_BuildF4__FP7POLY_F4iiiiiUl
    /* C6A80 800D6280 1800A3AF */   sw        $v1, 0x18($sp)
  .L800D6284:
    /* C6A84 800D6284 21900000 */  addu       $s2, $zero, $zero
    /* C6A88 800D6288 801F133C */  lui        $s3, (0x1F800004 >> 16)
    /* C6A8C 800D628C 04007336 */  ori        $s3, $s3, (0x1F800004 & 0xFFFF)
    /* C6A90 800D6290 FF00113C */  lui        $s1, (0xFFFFFF >> 16)
    /* C6A94 800D6294 FFFF3136 */  ori        $s1, $s1, (0xFFFFFF & 0xFFFF)
    /* C6A98 800D6298 00FF153C */  lui        $s5, (0xFF000000 >> 16)
    /* C6A9C 800D629C 02001024 */  addiu      $s0, $zero, 0x2
    /* C6AA0 800D62A0 21280000 */  addu       $a1, $zero, $zero
  .L800D62A4:
    /* C6AA4 800D62A4 2130E002 */  addu       $a2, $s7, $zero
    /* C6AA8 800D62A8 21389002 */  addu       $a3, $s4, $s0
    /* C6AAC 800D62AC 09001026 */  addiu      $s0, $s0, 0x9
    /* C6AB0 800D62B0 01005226 */  addiu      $s2, $s2, 0x1
    /* C6AB4 800D62B4 4B001624 */  addiu      $s6, $zero, 0x4B
    /* C6AB8 800D62B8 0000648E */  lw         $a0, 0x0($s3)
    /* C6ABC 800D62BC 801F083C */  lui        $t0, (0x1F800000 >> 16)
    /* C6AC0 800D62C0 0000088D */  lw         $t0, (0x1F800000 & 0xFFFF)($t0)
    /* C6AC4 800D62C4 0000838C */  lw         $v1, 0x0($a0)
    /* C6AC8 800D62C8 0000028D */  lw         $v0, 0x0($t0)
    /* C6ACC 800D62CC 24187500 */  and        $v1, $v1, $s5
    /* C6AD0 800D62D0 24105100 */  and        $v0, $v0, $s1
    /* C6AD4 800D62D4 25186200 */  or         $v1, $v1, $v0
    /* C6AD8 800D62D8 000083AC */  sw         $v1, 0x0($a0)
    /* C6ADC 800D62DC 0000038D */  lw         $v1, 0x0($t0)
    /* C6AE0 800D62E0 18008224 */  addiu      $v0, $a0, 0x18
    /* C6AE4 800D62E4 000062AE */  sw         $v0, 0x0($s3)
    /* C6AE8 800D62E8 24109100 */  and        $v0, $a0, $s1
    /* C6AEC 800D62EC 24187500 */  and        $v1, $v1, $s5
    /* C6AF0 800D62F0 25186200 */  or         $v1, $v1, $v0
    /* C6AF4 800D62F4 07000224 */  addiu      $v0, $zero, 0x7
    /* C6AF8 800D62F8 000003AD */  sw         $v1, 0x0($t0)
    /* C6AFC 800D62FC 1000B6AF */  sw         $s6, 0x10($sp)
    /* C6B00 800D6300 1400A2AF */  sw         $v0, 0x14($sp)
    /* C6B04 800D6304 8D49030C */  jal        Hud_BuildF4__FP7POLY_F4iiiiiUl
    /* C6B08 800D6308 1800A0AF */   sw        $zero, 0x18($sp)
    /* C6B0C 800D630C 0500422A */  slti       $v0, $s2, 0x5
    /* C6B10 800D6310 E4FF4014 */  bnez       $v0, .L800D62A4
    /* C6B14 800D6314 21280000 */   addu      $a1, $zero, $zero
    /* C6B18 800D6318 801F0B3C */  lui        $t3, (0x1F800004 >> 16)
    /* C6B1C 800D631C 04006B35 */  ori        $t3, $t3, (0x1F800004 & 0xFFFF)
    /* C6B20 800D6320 FF00093C */  lui        $t1, (0xFFFFFF >> 16)
    /* C6B24 800D6324 FFFF2935 */  ori        $t1, $t1, (0xFFFFFF & 0xFFFF)
    /* C6B28 800D6328 01000524 */  addiu      $a1, $zero, 0x1
    /* C6B2C 800D632C 2130E002 */  addu       $a2, $s7, $zero
    /* C6B30 800D6330 21388002 */  addu       $a3, $s4, $zero
    /* C6B34 800D6334 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* C6B38 800D6338 0000648D */  lw         $a0, 0x0($t3)
    /* C6B3C 800D633C 801F083C */  lui        $t0, (0x1F800000 >> 16)
    /* C6B40 800D6340 0000088D */  lw         $t0, (0x1F800000 & 0xFFFF)($t0)
    /* C6B44 800D6344 0000838C */  lw         $v1, 0x0($a0)
    /* C6B48 800D6348 0000028D */  lw         $v0, 0x0($t0)
    /* C6B4C 800D634C 24186A00 */  and        $v1, $v1, $t2
    /* C6B50 800D6350 24104900 */  and        $v0, $v0, $t1
    /* C6B54 800D6354 25186200 */  or         $v1, $v1, $v0
    /* C6B58 800D6358 000083AC */  sw         $v1, 0x0($a0)
    /* C6B5C 800D635C 0000028D */  lw         $v0, 0x0($t0)
    /* C6B60 800D6360 18008324 */  addiu      $v1, $a0, 0x18
    /* C6B64 800D6364 000063AD */  sw         $v1, 0x0($t3)
    /* C6B68 800D6368 24188900 */  and        $v1, $a0, $t1
    /* C6B6C 800D636C 24104A00 */  and        $v0, $v0, $t2
    /* C6B70 800D6370 25104300 */  or         $v0, $v0, $v1
    /* C6B74 800D6374 000002AD */  sw         $v0, 0x0($t0)
    /* C6B78 800D6378 30000224 */  addiu      $v0, $zero, 0x30
    /* C6B7C 800D637C 1000B6AF */  sw         $s6, 0x10($sp)
    /* C6B80 800D6380 1400A2AF */  sw         $v0, 0x14($sp)
    /* C6B84 800D6384 8D49030C */  jal        Hud_BuildF4__FP7POLY_F4iiiiiUl
    /* C6B88 800D6388 1800A0AF */   sw        $zero, 0x18($sp)
    /* C6B8C 800D638C 4000BF8F */  lw         $ra, 0x40($sp)
    /* C6B90 800D6390 3C00B78F */  lw         $s7, 0x3C($sp)
    /* C6B94 800D6394 3800B68F */  lw         $s6, 0x38($sp)
    /* C6B98 800D6398 3400B58F */  lw         $s5, 0x34($sp)
    /* C6B9C 800D639C 3000B48F */  lw         $s4, 0x30($sp)
    /* C6BA0 800D63A0 2C00B38F */  lw         $s3, 0x2C($sp)
    /* C6BA4 800D63A4 2800B28F */  lw         $s2, 0x28($sp)
    /* C6BA8 800D63A8 2400B18F */  lw         $s1, 0x24($sp)
    /* C6BAC 800D63AC 2000B08F */  lw         $s0, 0x20($sp)
    /* C6BB0 800D63B0 0800E003 */  jr         $ra
    /* C6BB4 800D63B4 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel Hud_BuildWingmanInterface__Fi
