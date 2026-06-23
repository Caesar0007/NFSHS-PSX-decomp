.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FECheat_HandleActivation__F10tCheatCode, 0x1D0

glabel FECheat_HandleActivation__F10tCheatCode
    /* 13A40 80023240 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 13A44 80023244 21288000 */  addu       $a1, $a0, $zero
    /* 13A48 80023248 1F00A22C */  sltiu      $v0, $a1, 0x1F
    /* 13A4C 8002324C 1800BFAF */  sw         $ra, 0x18($sp)
    /* 13A50 80023250 1400B1AF */  sw         $s1, 0x14($sp)
    /* 13A54 80023254 69004010 */  beqz       $v0, .L800233FC
    /* 13A58 80023258 1000B0AF */   sw        $s0, 0x10($sp)
    /* 13A5C 8002325C 0180023C */  lui        $v0, %hi(jtbl_80011028)
    /* 13A60 80023260 28104224 */  addiu      $v0, $v0, %lo(jtbl_80011028)
    /* 13A64 80023264 80180500 */  sll        $v1, $a1, 2
    /* 13A68 80023268 21186200 */  addu       $v1, $v1, $v0
    /* 13A6C 8002326C 0000628C */  lw         $v0, 0x0($v1)
    /* 13A70 80023270 00000000 */  nop
    /* 13A74 80023274 08004000 */  jr         $v0
    /* 13A78 80023278 00000000 */   nop
  jlabel .L8002327C
    /* 13A7C 8002327C 1180043C */  lui        $a0, %hi(carManager)
    /* 13A80 80023280 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 13A84 80023284 5A5B000C */  jal        SetClassAvailable__11tCarManager13tCarClassTypeb
    /* 13A88 80023288 01000624 */   addiu     $a2, $zero, 0x1
    /* 13A8C 8002328C FF8C0008 */  j          .L800233FC
    /* 13A90 80023290 00000000 */   nop
  jlabel .L80023294
    /* 13A94 80023294 21800000 */  addu       $s0, $zero, $zero
    /* 13A98 80023298 00241000 */  sll        $a0, $s0, 16
  .L8002329C:
    /* 13A9C 8002329C 908C000C */  jal        FECheat_HandleActivation__F10tCheatCode
    /* 13AA0 800232A0 03240400 */   sra       $a0, $a0, 16
    /* 13AA4 800232A4 01000226 */  addiu      $v0, $s0, 0x1
    /* 13AA8 800232A8 21804000 */  addu       $s0, $v0, $zero
    /* 13AAC 800232AC 00140200 */  sll        $v0, $v0, 16
    /* 13AB0 800232B0 03140200 */  sra        $v0, $v0, 16
    /* 13AB4 800232B4 07004228 */  slti       $v0, $v0, 0x7
    /* 13AB8 800232B8 F8FF4014 */  bnez       $v0, .L8002329C
    /* 13ABC 800232BC 00241000 */   sll       $a0, $s0, 16
    /* 13AC0 800232C0 FF8C0008 */  j          .L800233FC
    /* 13AC4 800232C4 00000000 */   nop
  jlabel .L800232C8
    /* 13AC8 800232C8 1180103C */  lui        $s0, %hi(trackManager)
    /* 13ACC 800232CC 504A1026 */  addiu      $s0, $s0, %lo(trackManager)
    /* 13AD0 800232D0 21200002 */  addu       $a0, $s0, $zero
    /* 13AD4 800232D4 21280000 */  addu       $a1, $zero, $zero
    /* 13AD8 800232D8 2887000C */  jal        SetClassAvailable__13tTrackManager15tTrackClassTypeb
    /* 13ADC 800232DC 01000624 */   addiu     $a2, $zero, 0x1
    /* 13AE0 800232E0 21200002 */  addu       $a0, $s0, $zero
    /* 13AE4 800232E4 01000524 */  addiu      $a1, $zero, 0x1
    /* 13AE8 800232E8 2887000C */  jal        SetClassAvailable__13tTrackManager15tTrackClassTypeb
    /* 13AEC 800232EC 2130A000 */   addu      $a2, $a1, $zero
    /* 13AF0 800232F0 21200002 */  addu       $a0, $s0, $zero
    /* 13AF4 800232F4 02000524 */  addiu      $a1, $zero, 0x2
    /* 13AF8 800232F8 2887000C */  jal        SetClassAvailable__13tTrackManager15tTrackClassTypeb
    /* 13AFC 800232FC 01000624 */   addiu     $a2, $zero, 0x1
    /* 13B00 80023300 21200002 */  addu       $a0, $s0, $zero
    /* 13B04 80023304 03000524 */  addiu      $a1, $zero, 0x3
    /* 13B08 80023308 2887000C */  jal        SetClassAvailable__13tTrackManager15tTrackClassTypeb
    /* 13B0C 8002330C 01000624 */   addiu     $a2, $zero, 0x1
    /* 13B10 80023310 21200002 */  addu       $a0, $s0, $zero
    /* 13B14 80023314 04000524 */  addiu      $a1, $zero, 0x4
    /* 13B18 80023318 2887000C */  jal        SetClassAvailable__13tTrackManager15tTrackClassTypeb
    /* 13B1C 8002331C 01000624 */   addiu     $a2, $zero, 0x1
    /* 13B20 80023320 FF8C0008 */  j          .L800233FC
    /* 13B24 80023324 00000000 */   nop
  jlabel .L80023328
    /* 13B28 80023328 1180023C */  lui        $v0, %hi(tournamentManager)
    /* 13B2C 8002332C D84A4224 */  addiu      $v0, $v0, %lo(tournamentManager)
    /* 13B30 80023330 1400438C */  lw         $v1, 0x14($v0)
    /* 13B34 80023334 50C30434 */  ori        $a0, $zero, 0xC350
    /* 13B38 80023338 21186400 */  addu       $v1, $v1, $a0
    /* 13B3C 8002333C FF8C0008 */  j          .L800233FC
    /* 13B40 80023340 140043AC */   sw        $v1, 0x14($v0)
  jlabel .L80023344
    /* 13B44 80023344 F505043C */  lui        $a0, (0x5F5E100 >> 16)
    /* 13B48 80023348 1180033C */  lui        $v1, %hi(tournamentManager)
    /* 13B4C 8002334C D84A6324 */  addiu      $v1, $v1, %lo(tournamentManager)
    /* 13B50 80023350 1400628C */  lw         $v0, 0x14($v1)
    /* 13B54 80023354 00E18434 */  ori        $a0, $a0, (0x5F5E100 & 0xFFFF)
    /* 13B58 80023358 21104400 */  addu       $v0, $v0, $a0
    /* 13B5C 8002335C FF8C0008 */  j          .L800233FC
    /* 13B60 80023360 140062AC */   sw        $v0, 0x14($v1)
  jlabel .L80023364
    /* 13B64 80023364 1180043C */  lui        $a0, %hi(Stats_gTrackRecords)
    /* 13B68 80023368 944D8424 */  addiu      $a0, $a0, %lo(Stats_gTrackRecords)
    /* 13B6C 8002336C 262B010C */  jal        Stattool_GetAllDefaultRecords__FP13tRecordBufferb
    /* 13B70 80023370 01000524 */   addiu     $a1, $zero, 0x1
    /* 13B74 80023374 FF8C0008 */  j          .L800233FC
    /* 13B78 80023378 00000000 */   nop
  jlabel .L8002337C
    /* 13B7C 8002337C 1480033C */  lui        $v1, %hi(gFECheats)
    /* 13B80 80023380 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 13B84 80023384 78D262AC */  sw         $v0, %lo(gFECheats)($v1)
    /* 13B88 80023388 21800000 */  addu       $s0, $zero, $zero
    /* 13B8C 8002338C 13001124 */  addiu      $s1, $zero, 0x13
    /* 13B90 80023390 00141000 */  sll        $v0, $s0, 16
  .L80023394:
    /* 13B94 80023394 03240200 */  sra        $a0, $v0, 16
    /* 13B98 80023398 04009110 */  beq        $a0, $s1, .L800233AC
    /* 13B9C 8002339C 01000226 */   addiu     $v0, $s0, 0x1
    /* 13BA0 800233A0 908C000C */  jal        FECheat_HandleActivation__F10tCheatCode
    /* 13BA4 800233A4 00000000 */   nop
    /* 13BA8 800233A8 01000226 */  addiu      $v0, $s0, 0x1
  .L800233AC:
    /* 13BAC 800233AC 21804000 */  addu       $s0, $v0, $zero
    /* 13BB0 800233B0 00140200 */  sll        $v0, $v0, 16
    /* 13BB4 800233B4 03140200 */  sra        $v0, $v0, 16
    /* 13BB8 800233B8 1F004228 */  slti       $v0, $v0, 0x1F
    /* 13BBC 800233BC F5FF4014 */  bnez       $v0, .L80023394
    /* 13BC0 800233C0 00141000 */   sll       $v0, $s0, 16
    /* 13BC4 800233C4 FF8C0008 */  j          .L800233FC
    /* 13BC8 800233C8 00000000 */   nop
  jlabel .L800233CC
    /* 13BCC 800233CC 21800000 */  addu       $s0, $zero, $zero
    /* 13BD0 800233D0 E5FFA424 */  addiu      $a0, $a1, -0x1B
    /* 13BD4 800233D4 1180023C */  lui        $v0, %hi(tournamentManager)
    /* 13BD8 800233D8 D84A4524 */  addiu      $a1, $v0, %lo(tournamentManager)
  .L800233DC:
    /* 13BDC 800233DC 00141000 */  sll        $v0, $s0, 16
    /* 13BE0 800233E0 031C0200 */  sra        $v1, $v0, 16
    /* 13BE4 800233E4 40006228 */  slti       $v0, $v1, 0x40
    /* 13BE8 800233E8 04004010 */  beqz       $v0, .L800233FC
    /* 13BEC 800233EC 21106500 */   addu      $v0, $v1, $a1
    /* 13BF0 800233F0 F00144A0 */  sb         $a0, 0x1F0($v0)
    /* 13BF4 800233F4 F78C0008 */  j          .L800233DC
    /* 13BF8 800233F8 01001026 */   addiu     $s0, $s0, 0x1
  jlabel .L800233FC
    /* 13BFC 800233FC 1800BF8F */  lw         $ra, 0x18($sp)
    /* 13C00 80023400 1400B18F */  lw         $s1, 0x14($sp)
    /* 13C04 80023404 1000B08F */  lw         $s0, 0x10($sp)
    /* 13C08 80023408 0800E003 */  jr         $ra
    /* 13C0C 8002340C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel FECheat_HandleActivation__F10tCheatCode
