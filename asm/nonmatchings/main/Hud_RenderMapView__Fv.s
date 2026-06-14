.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_RenderMapView__Fv, 0x284

glabel Hud_RenderMapView__Fv
    /* C8038 800D7838 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* C803C 800D783C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* C8040 800D7840 21980000 */  addu       $s3, $zero, $zero
    /* C8044 800D7844 1180023C */  lui        $v0, %hi(DashHUD_gInfo)
    /* C8048 800D7848 3000BEAF */  sw         $fp, 0x30($sp)
    /* C804C 800D784C 30275E24 */  addiu      $fp, $v0, %lo(DashHUD_gInfo)
    /* C8050 800D7850 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* C8054 800D7854 01001724 */  addiu      $s7, $zero, 0x1
    /* C8058 800D7858 1400B1AF */  sw         $s1, 0x14($sp)
    /* C805C 800D785C FF00113C */  lui        $s1, (0xFFFFFF >> 16)
    /* C8060 800D7860 FFFF3136 */  ori        $s1, $s1, (0xFFFFFF & 0xFFFF)
    /* C8064 800D7864 1800B2AF */  sw         $s2, 0x18($sp)
    /* C8068 800D7868 00FF123C */  lui        $s2, (0xFF000000 >> 16)
    /* C806C 800D786C 2000B4AF */  sw         $s4, 0x20($sp)
    /* C8070 800D7870 21A06002 */  addu       $s4, $s3, $zero
    /* C8074 800D7874 2800B6AF */  sw         $s6, 0x28($sp)
    /* C8078 800D7878 21B06002 */  addu       $s6, $s3, $zero
    /* C807C 800D787C 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* C8080 800D7880 2400B5AF */  sw         $s5, 0x24($sp)
    /* C8084 800D7884 EC315524 */  addiu      $s5, $v0, %lo(GameSetup_gData)
    /* C8088 800D7888 3400BFAF */  sw         $ra, 0x34($sp)
    /* C808C 800D788C 1000B0AF */  sw         $s0, 0x10($sp)
  .L800D7890:
    /* C8090 800D7890 1180023C */  lui        $v0, %hi(DashHUD_gInfo)
    /* C8094 800D7894 3027428C */  lw         $v0, %lo(DashHUD_gInfo)($v0)
    /* C8098 800D7898 00000000 */  nop
    /* C809C 800D789C 2A105300 */  slt        $v0, $v0, $s3
    /* C80A0 800D78A0 7A004014 */  bnez       $v0, .L800D7A8C
    /* C80A4 800D78A4 00000000 */   nop
    /* C80A8 800D78A8 5004A28E */  lw         $v0, 0x450($s5)
    /* C80AC 800D78AC 00000000 */  nop
    /* C80B0 800D78B0 71004010 */  beqz       $v0, .L800D7A78
    /* C80B4 800D78B4 21109E02 */   addu      $v0, $s4, $fp
    /* C80B8 800D78B8 1C00428C */  lw         $v0, 0x1C($v0)
    /* C80BC 800D78BC 00000000 */  nop
    /* C80C0 800D78C0 6D004010 */  beqz       $v0, .L800D7A78
    /* C80C4 800D78C4 00000000 */   nop
    /* C80C8 800D78C8 1480023C */  lui        $v0, %hi(Hud_gWingmanInterface)
    /* C80CC 800D78CC B0D84224 */  addiu      $v0, $v0, %lo(Hud_gWingmanInterface)
    /* C80D0 800D78D0 21106202 */  addu       $v0, $s3, $v0
    /* C80D4 800D78D4 00004290 */  lbu        $v0, 0x0($v0)
    /* C80D8 800D78D8 00000000 */  nop
    /* C80DC 800D78DC 66004014 */  bnez       $v0, .L800D7A78
    /* C80E0 800D78E0 1480023C */   lui       $v0, %hi(D_8013E5A0)
    /* C80E4 800D78E4 02006012 */  beqz       $s3, .L800D78F0
    /* C80E8 800D78E8 A0E55024 */   addiu     $s0, $v0, %lo(D_8013E5A0)
    /* C80EC 800D78EC C8001026 */  addiu      $s0, $s0, 0xC8
  .L800D78F0:
    /* C80F0 800D78F0 1480023C */  lui        $v0, %hi(Hud_gMapView)
    /* C80F4 800D78F4 58D94224 */  addiu      $v0, $v0, %lo(Hud_gMapView)
    /* C80F8 800D78F8 21108202 */  addu       $v0, $s4, $v0
    /* C80FC 800D78FC 0000448C */  lw         $a0, 0x0($v0)
    /* C8100 800D7900 18F8020C */  jal        Draw_StartRenderingView__Fi
    /* C8104 800D7904 00000000 */   nop
    /* C8108 800D7908 5004A28E */  lw         $v0, 0x450($s5)
    /* C810C 800D790C 00000000 */  nop
    /* C8110 800D7910 11005714 */  bne        $v0, $s7, .L800D7958
    /* C8114 800D7914 00000000 */   nop
    /* C8118 800D7918 BA56030C */  jal        Hud_BuildMapMarkers__Fi
    /* C811C 800D791C 21206002 */   addu      $a0, $s3, $zero
    /* C8120 800D7920 801F043C */  lui        $a0, (0x1F800000 >> 16)
    /* C8124 800D7924 0000848C */  lw         $a0, (0x1F800000 & 0xFFFF)($a0)
    /* C8128 800D7928 0000038E */  lw         $v1, 0x0($s0)
    /* C812C 800D792C 0000828C */  lw         $v0, 0x0($a0)
    /* C8130 800D7930 24187200 */  and        $v1, $v1, $s2
    /* C8134 800D7934 24105100 */  and        $v0, $v0, $s1
    /* C8138 800D7938 25186200 */  or         $v1, $v1, $v0
    /* C813C 800D793C 000003AE */  sw         $v1, 0x0($s0)
    /* C8140 800D7940 0000828C */  lw         $v0, 0x0($a0)
    /* C8144 800D7944 24181102 */  and        $v1, $s0, $s1
    /* C8148 800D7948 24105200 */  and        $v0, $v0, $s2
    /* C814C 800D794C 25104300 */  or         $v0, $v0, $v1
    /* C8150 800D7950 885E0308 */  j          .L800D7A20
    /* C8154 800D7954 000082AC */   sw        $v0, 0x0($a0)
  .L800D7958:
    /* C8158 800D7958 D25A030C */  jal        Hud_BuildRadar__Fi
    /* C815C 800D795C 21206002 */   addu      $a0, $s3, $zero
    /* C8160 800D7960 16005714 */  bne        $v0, $s7, .L800D79BC
    /* C8164 800D7964 00000000 */   nop
    /* C8168 800D7968 801F043C */  lui        $a0, (0x1F800000 >> 16)
    /* C816C 800D796C 0000848C */  lw         $a0, (0x1F800000 & 0xFFFF)($a0)
    /* C8170 800D7970 2800038E */  lw         $v1, 0x28($s0)
    /* C8174 800D7974 0000828C */  lw         $v0, 0x0($a0)
    /* C8178 800D7978 24187200 */  and        $v1, $v1, $s2
    /* C817C 800D797C 24105100 */  and        $v0, $v0, $s1
    /* C8180 800D7980 25186200 */  or         $v1, $v1, $v0
    /* C8184 800D7984 28000226 */  addiu      $v0, $s0, 0x28
    /* C8188 800D7988 280003AE */  sw         $v1, 0x28($s0)
    /* C818C 800D798C 0000838C */  lw         $v1, 0x0($a0)
    /* C8190 800D7990 24105100 */  and        $v0, $v0, $s1
    /* C8194 800D7994 24187200 */  and        $v1, $v1, $s2
    /* C8198 800D7998 25186200 */  or         $v1, $v1, $v0
    /* C819C 800D799C 000083AC */  sw         $v1, 0x0($a0)
    /* C81A0 800D79A0 5000028E */  lw         $v0, 0x50($s0)
    /* C81A4 800D79A4 24187100 */  and        $v1, $v1, $s1
    /* C81A8 800D79A8 24105200 */  and        $v0, $v0, $s2
    /* C81AC 800D79AC 25104300 */  or         $v0, $v0, $v1
    /* C81B0 800D79B0 500002AE */  sw         $v0, 0x50($s0)
    /* C81B4 800D79B4 835E0308 */  j          .L800D7A0C
    /* C81B8 800D79B8 50000226 */   addiu     $v0, $s0, 0x50
  .L800D79BC:
    /* C81BC 800D79BC 801F043C */  lui        $a0, (0x1F800000 >> 16)
    /* C81C0 800D79C0 0000848C */  lw         $a0, (0x1F800000 & 0xFFFF)($a0)
    /* C81C4 800D79C4 7800038E */  lw         $v1, 0x78($s0)
    /* C81C8 800D79C8 0000828C */  lw         $v0, 0x0($a0)
    /* C81CC 800D79CC 24187200 */  and        $v1, $v1, $s2
    /* C81D0 800D79D0 24105100 */  and        $v0, $v0, $s1
    /* C81D4 800D79D4 25186200 */  or         $v1, $v1, $v0
    /* C81D8 800D79D8 78000226 */  addiu      $v0, $s0, 0x78
    /* C81DC 800D79DC 780003AE */  sw         $v1, 0x78($s0)
    /* C81E0 800D79E0 0000838C */  lw         $v1, 0x0($a0)
    /* C81E4 800D79E4 24105100 */  and        $v0, $v0, $s1
    /* C81E8 800D79E8 24187200 */  and        $v1, $v1, $s2
    /* C81EC 800D79EC 25186200 */  or         $v1, $v1, $v0
    /* C81F0 800D79F0 000083AC */  sw         $v1, 0x0($a0)
    /* C81F4 800D79F4 A000028E */  lw         $v0, 0xA0($s0)
    /* C81F8 800D79F8 24187100 */  and        $v1, $v1, $s1
    /* C81FC 800D79FC 24105200 */  and        $v0, $v0, $s2
    /* C8200 800D7A00 25104300 */  or         $v0, $v0, $v1
    /* C8204 800D7A04 A00002AE */  sw         $v0, 0xA0($s0)
    /* C8208 800D7A08 A0000226 */  addiu      $v0, $s0, 0xA0
  .L800D7A0C:
    /* C820C 800D7A0C 0000838C */  lw         $v1, 0x0($a0)
    /* C8210 800D7A10 24105100 */  and        $v0, $v0, $s1
    /* C8214 800D7A14 24187200 */  and        $v1, $v1, $s2
    /* C8218 800D7A18 25186200 */  or         $v1, $v1, $v0
    /* C821C 800D7A1C 000083AC */  sw         $v1, 0x0($a0)
  .L800D7A20:
    /* C8220 800D7A20 1480043C */  lui        $a0, %hi(D_8013E3FC)
    /* C8224 800D7A24 FCE38424 */  addiu      $a0, $a0, %lo(D_8013E3FC)
    /* C8228 800D7A28 2120C402 */  addu       $a0, $s6, $a0
    /* C822C 800D7A2C 801F053C */  lui        $a1, (0x1F800000 >> 16)
    /* C8230 800D7A30 0000A58C */  lw         $a1, (0x1F800000 & 0xFFFF)($a1)
    /* C8234 800D7A34 0000838C */  lw         $v1, 0x0($a0)
    /* C8238 800D7A38 0000A28C */  lw         $v0, 0x0($a1)
    /* C823C 800D7A3C 24187200 */  and        $v1, $v1, $s2
    /* C8240 800D7A40 24105100 */  and        $v0, $v0, $s1
    /* C8244 800D7A44 25186200 */  or         $v1, $v1, $v0
    /* C8248 800D7A48 000083AC */  sw         $v1, 0x0($a0)
    /* C824C 800D7A4C 0000A28C */  lw         $v0, 0x0($a1)
    /* C8250 800D7A50 24209100 */  and        $a0, $a0, $s1
    /* C8254 800D7A54 24105200 */  and        $v0, $v0, $s2
    /* C8258 800D7A58 25104400 */  or         $v0, $v0, $a0
    /* C825C 800D7A5C 0000A2AC */  sw         $v0, 0x0($a1)
    /* C8260 800D7A60 1480023C */  lui        $v0, %hi(Hud_gMapView)
    /* C8264 800D7A64 58D94224 */  addiu      $v0, $v0, %lo(Hud_gMapView)
    /* C8268 800D7A68 21108202 */  addu       $v0, $s4, $v0
    /* C826C 800D7A6C 0000448C */  lw         $a0, 0x0($v0)
    /* C8270 800D7A70 46F8020C */  jal        Draw_StopRenderingView__Fi
    /* C8274 800D7A74 00000000 */   nop
  .L800D7A78:
    /* C8278 800D7A78 04009426 */  addiu      $s4, $s4, 0x4
    /* C827C 800D7A7C 3000D626 */  addiu      $s6, $s6, 0x30
    /* C8280 800D7A80 B400B526 */  addiu      $s5, $s5, 0xB4
    /* C8284 800D7A84 245E0308 */  j          .L800D7890
    /* C8288 800D7A88 01007326 */   addiu     $s3, $s3, 0x1
  .L800D7A8C:
    /* C828C 800D7A8C 3400BF8F */  lw         $ra, 0x34($sp)
    /* C8290 800D7A90 3000BE8F */  lw         $fp, 0x30($sp)
    /* C8294 800D7A94 2C00B78F */  lw         $s7, 0x2C($sp)
    /* C8298 800D7A98 2800B68F */  lw         $s6, 0x28($sp)
    /* C829C 800D7A9C 2400B58F */  lw         $s5, 0x24($sp)
    /* C82A0 800D7AA0 2000B48F */  lw         $s4, 0x20($sp)
    /* C82A4 800D7AA4 1C00B38F */  lw         $s3, 0x1C($sp)
    /* C82A8 800D7AA8 1800B28F */  lw         $s2, 0x18($sp)
    /* C82AC 800D7AAC 1400B18F */  lw         $s1, 0x14($sp)
    /* C82B0 800D7AB0 1000B08F */  lw         $s0, 0x10($sp)
    /* C82B4 800D7AB4 0800E003 */  jr         $ra
    /* C82B8 800D7AB8 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel Hud_RenderMapView__Fv
