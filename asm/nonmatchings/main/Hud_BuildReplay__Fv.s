.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BuildReplay__Fv, 0x2FC

glabel Hud_BuildReplay__Fv
    /* C7A50 800D7250 F8FFBD27 */  addiu      $sp, $sp, -0x8
    /* C7A54 800D7254 1480023C */  lui        $v0, %hi(D_8013D914)
    /* C7A58 800D7258 14D94F24 */  addiu      $t7, $v0, %lo(D_8013D914)
    /* C7A5C 800D725C 0300EC89 */  lwl        $t4, 0x3($t7)
    /* C7A60 800D7260 0000EC99 */  lwr        $t4, 0x0($t7)
    /* C7A64 800D7264 0400ED81 */  lb         $t5, 0x4($t7)
    /* C7A68 800D7268 0300ACAB */  swl        $t4, 0x3($sp)
    /* C7A6C 800D726C 0000ACBB */  swr        $t4, 0x0($sp)
    /* C7A70 800D7270 0400ADA3 */  sb         $t5, 0x4($sp)
    /* C7A74 800D7274 33000924 */  addiu      $t1, $zero, 0x33
    /* C7A78 800D7278 8066053C */  lui        $a1, (0x66808080 >> 16)
    /* C7A7C 800D727C 8080A534 */  ori        $a1, $a1, (0x66808080 & 0xFFFF)
    /* C7A80 800D7280 FC030324 */  addiu      $v1, $zero, 0x3FC
  .L800D7284:
    /* C7A84 800D7284 BC18848F */  lw         $a0, %gp_rel(D_8013DE08)($gp)
    /* C7A88 800D7288 01002925 */  addiu      $t1, $t1, 0x1
    /* C7A8C 800D728C 21106400 */  addu       $v0, $v1, $a0
    /* C7A90 800D7290 040045AC */  sw         $a1, 0x4($v0)
    /* C7A94 800D7294 3F002229 */  slti       $v0, $t1, 0x3F
    /* C7A98 800D7298 FAFF4014 */  bnez       $v0, .L800D7284
    /* C7A9C 800D729C 14006324 */   addiu     $v1, $v1, 0x14
    /* C7AA0 800D72A0 1180073C */  lui        $a3, %hi(Replay_ReplayInterface)
    /* C7AA4 800D72A4 2C70E624 */  addiu      $a2, $a3, %lo(Replay_ReplayInterface)
    /* C7AA8 800D72A8 1000C28C */  lw         $v0, 0x10($a2)
    /* C7AAC 800D72AC 0066053C */  lui        $a1, (0x6600BEBE >> 16)
    /* C7AB0 800D72B0 2110A203 */  addu       $v0, $sp, $v0
    /* C7AB4 800D72B4 00004390 */  lbu        $v1, 0x0($v0)
    /* C7AB8 800D72B8 BEBEA534 */  ori        $a1, $a1, (0x6600BEBE & 0xFFFF)
    /* C7ABC 800D72BC 80100300 */  sll        $v0, $v1, 2
    /* C7AC0 800D72C0 21104300 */  addu       $v0, $v0, $v1
    /* C7AC4 800D72C4 80100200 */  sll        $v0, $v0, 2
    /* C7AC8 800D72C8 21104400 */  addu       $v0, $v0, $a0
    /* C7ACC 800D72CC 000445AC */  sw         $a1, 0x400($v0)
    /* C7AD0 800D72D0 1000C38C */  lw         $v1, 0x10($a2)
    /* C7AD4 800D72D4 03000224 */  addiu      $v0, $zero, 0x3
    /* C7AD8 800D72D8 02006214 */  bne        $v1, $v0, .L800D72E4
    /* C7ADC 800D72DC 00000000 */   nop
    /* C7AE0 800D72E0 640485AC */  sw         $a1, 0x464($a0)
  .L800D72E4:
    /* C7AE4 800D72E4 2C70E28C */  lw         $v0, %lo(Replay_ReplayInterface)($a3)
    /* C7AE8 800D72E8 00000000 */  nop
    /* C7AEC 800D72EC 80180200 */  sll        $v1, $v0, 2
    /* C7AF0 800D72F0 21186200 */  addu       $v1, $v1, $v0
    /* C7AF4 800D72F4 80180300 */  sll        $v1, $v1, 2
    /* C7AF8 800D72F8 1180023C */  lui        $v0, %hi(D_80111530)
    /* C7AFC 800D72FC 30154224 */  addiu      $v0, $v0, %lo(D_80111530)
    /* C7B00 800D7300 23104300 */  subu       $v0, $v0, $v1
    /* C7B04 800D7304 BC18838F */  lw         $v1, %gp_rel(D_8013DE08)($gp)
    /* C7B08 800D7308 0000428C */  lw         $v0, 0x0($v0)
    /* C7B0C 800D730C 00000000 */  nop
    /* C7B10 800D7310 1C0462AC */  sw         $v0, 0x41C($v1)
    /* C7B14 800D7314 0400C38C */  lw         $v1, 0x4($a2)
    /* C7B18 800D7318 01000224 */  addiu      $v0, $zero, 0x1
    /* C7B1C 800D731C 0D006210 */  beq        $v1, $v0, .L800D7354
    /* C7B20 800D7320 02006228 */   slti      $v0, $v1, 0x2
    /* C7B24 800D7324 05004010 */  beqz       $v0, .L800D733C
    /* C7B28 800D7328 02000224 */   addiu     $v0, $zero, 0x2
    /* C7B2C 800D732C 07006010 */  beqz       $v1, .L800D734C
    /* C7B30 800D7330 74000324 */   addiu     $v1, $zero, 0x74
    /* C7B34 800D7334 D95C0308 */  j          .L800D7364
    /* C7B38 800D7338 1180053C */   lui       $a1, %hi(HudPmx_gShapes)
  .L800D733C:
    /* C7B3C 800D733C 07006210 */  beq        $v1, $v0, .L800D735C
    /* C7B40 800D7340 74000324 */   addiu     $v1, $zero, 0x74
    /* C7B44 800D7344 D95C0308 */  j          .L800D7364
    /* C7B48 800D7348 1180053C */   lui       $a1, %hi(HudPmx_gShapes)
  .L800D734C:
    /* C7B4C 800D734C D85C0308 */  j          .L800D7360
    /* C7B50 800D7350 72000324 */   addiu     $v1, $zero, 0x72
  .L800D7354:
    /* C7B54 800D7354 D85C0308 */  j          .L800D7360
    /* C7B58 800D7358 73000324 */   addiu     $v1, $zero, 0x73
  .L800D735C:
    /* C7B5C 800D735C 75000324 */  addiu      $v1, $zero, 0x75
  .L800D7360:
    /* C7B60 800D7360 1180053C */  lui        $a1, %hi(HudPmx_gShapes)
  .L800D7364:
    /* C7B64 800D7364 980CA524 */  addiu      $a1, $a1, %lo(HudPmx_gShapes)
    /* C7B68 800D7368 80100300 */  sll        $v0, $v1, 2
    /* C7B6C 800D736C 21104300 */  addu       $v0, $v0, $v1
    /* C7B70 800D7370 80100200 */  sll        $v0, $v0, 2
    /* C7B74 800D7374 21104500 */  addu       $v0, $v0, $a1
    /* C7B78 800D7378 BC18848F */  lw         $a0, %gp_rel(D_8013DE08)($gp)
    /* C7B7C 800D737C 00004390 */  lbu        $v1, 0x0($v0)
    /* C7B80 800D7380 00000000 */  nop
    /* C7B84 800D7384 6C0483A0 */  sb         $v1, 0x46C($a0)
    /* C7B88 800D7388 1180043C */  lui        $a0, %hi(Replay_ReplayInterface)
    /* C7B8C 800D738C BC18838F */  lw         $v1, %gp_rel(D_8013DE08)($gp)
    /* C7B90 800D7390 01004290 */  lbu        $v0, 0x1($v0)
    /* C7B94 800D7394 2C708424 */  addiu      $a0, $a0, %lo(Replay_ReplayInterface)
    /* C7B98 800D7398 6D0462A0 */  sb         $v0, 0x46D($v1)
    /* C7B9C 800D739C 0C00838C */  lw         $v1, 0xC($a0)
    /* C7BA0 800D73A0 BC18868F */  lw         $a2, %gp_rel(D_8013DE08)($gp)
    /* C7BA4 800D73A4 80100300 */  sll        $v0, $v1, 2
    /* C7BA8 800D73A8 21104300 */  addu       $v0, $v0, $v1
    /* C7BAC 800D73AC 80100200 */  sll        $v0, $v0, 2
    /* C7BB0 800D73B0 2128A200 */  addu       $a1, $a1, $v0
    /* C7BB4 800D73B4 2800A28C */  lw         $v0, 0x28($a1)
    /* C7BB8 800D73B8 00000000 */  nop
    /* C7BBC 800D73BC 8004C2AC */  sw         $v0, 0x480($a2)
    /* C7BC0 800D73C0 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C7BC4 800D73C4 00000000 */  nop
    /* C7BC8 800D73C8 34004294 */  lhu        $v0, 0x34($v0)
    /* C7BCC 800D73CC 00000000 */  nop
    /* C7BD0 800D73D0 75004224 */  addiu      $v0, $v0, 0x75
    /* C7BD4 800D73D4 7C04C2A4 */  sh         $v0, 0x47C($a2)
    /* C7BD8 800D73D8 1000838C */  lw         $v1, 0x10($a0)
    /* C7BDC 800D73DC 04000224 */  addiu      $v0, $zero, 0x4
    /* C7BE0 800D73E0 03006214 */  bne        $v1, $v0, .L800D73F0
    /* C7BE4 800D73E4 0066023C */   lui       $v0, (0x6600BEBE >> 16)
    /* C7BE8 800D73E8 FE5C0308 */  j          .L800D73F8
    /* C7BEC 800D73EC BEBE4234 */   ori       $v0, $v0, (0x6600BEBE & 0xFFFF)
  .L800D73F0:
    /* C7BF0 800D73F0 8066023C */  lui        $v0, (0x66808080 >> 16)
    /* C7BF4 800D73F4 80804234 */  ori        $v0, $v0, (0x66808080 & 0xFFFF)
  .L800D73F8:
    /* C7BF8 800D73F8 7804C2AC */  sw         $v0, 0x478($a2)
    /* C7BFC 800D73FC FF00053C */  lui        $a1, (0xFFFFFF >> 16)
    /* C7C00 800D7400 FFFFA534 */  ori        $a1, $a1, (0xFFFFFF & 0xFFFF)
    /* C7C04 800D7404 33000924 */  addiu      $t1, $zero, 0x33
    /* C7C08 800D7408 FF000A3C */  lui        $t2, (0xFFFFFF >> 16)
    /* C7C0C 800D740C FFFF4A35 */  ori        $t2, $t2, (0xFFFFFF & 0xFFFF)
    /* C7C10 800D7410 00FF0B3C */  lui        $t3, (0xFF000000 >> 16)
    /* C7C14 800D7414 21306001 */  addu       $a2, $t3, $zero
    /* C7C18 800D7418 801F023C */  lui        $v0, (0x1F800000 >> 16)
    /* C7C1C 800D741C 0000428C */  lw         $v0, (0x1F800000 & 0xFFFF)($v0)
    /* C7C20 800D7420 BC18848F */  lw         $a0, %gp_rel(D_8013DE08)($gp)
    /* C7C24 800D7424 21404000 */  addu       $t0, $v0, $zero
    /* C7C28 800D7428 FC038724 */  addiu      $a3, $a0, 0x3FC
    /* C7C2C 800D742C 7404838C */  lw         $v1, 0x474($a0)
    /* C7C30 800D7430 0000028D */  lw         $v0, 0x0($t0)
    /* C7C34 800D7434 24186600 */  and        $v1, $v1, $a2
    /* C7C38 800D7438 24104500 */  and        $v0, $v0, $a1
    /* C7C3C 800D743C 25186200 */  or         $v1, $v1, $v0
    /* C7C40 800D7440 740483AC */  sw         $v1, 0x474($a0)
    /* C7C44 800D7444 74048424 */  addiu      $a0, $a0, 0x474
    /* C7C48 800D7448 0000028D */  lw         $v0, 0x0($t0)
    /* C7C4C 800D744C 24208500 */  and        $a0, $a0, $a1
    /* C7C50 800D7450 24104600 */  and        $v0, $v0, $a2
    /* C7C54 800D7454 25104400 */  or         $v0, $v0, $a0
    /* C7C58 800D7458 000002AD */  sw         $v0, 0x0($t0)
  .L800D745C:
    /* C7C5C 800D745C 01002925 */  addiu      $t1, $t1, 0x1
    /* C7C60 800D7460 0000E38C */  lw         $v1, 0x0($a3)
    /* C7C64 800D7464 0000028D */  lw         $v0, 0x0($t0)
    /* C7C68 800D7468 24186B00 */  and        $v1, $v1, $t3
    /* C7C6C 800D746C 24104A00 */  and        $v0, $v0, $t2
    /* C7C70 800D7470 25186200 */  or         $v1, $v1, $v0
    /* C7C74 800D7474 0000E3AC */  sw         $v1, 0x0($a3)
    /* C7C78 800D7478 2418EA00 */  and        $v1, $a3, $t2
    /* C7C7C 800D747C 0000028D */  lw         $v0, 0x0($t0)
    /* C7C80 800D7480 00000000 */  nop
    /* C7C84 800D7484 24104B00 */  and        $v0, $v0, $t3
    /* C7C88 800D7488 25104300 */  or         $v0, $v0, $v1
    /* C7C8C 800D748C 000002AD */  sw         $v0, 0x0($t0)
    /* C7C90 800D7490 38002229 */  slti       $v0, $t1, 0x38
    /* C7C94 800D7494 F1FF4014 */  bnez       $v0, .L800D745C
    /* C7C98 800D7498 1400E724 */   addiu     $a3, $a3, 0x14
    /* C7C9C 800D749C FF00053C */  lui        $a1, (0xFFFFFF >> 16)
    /* C7CA0 800D74A0 FFFFA534 */  ori        $a1, $a1, (0xFFFFFF & 0xFFFF)
    /* C7CA4 800D74A4 00FF073C */  lui        $a3, (0xFF000000 >> 16)
    /* C7CA8 800D74A8 BC18848F */  lw         $a0, %gp_rel(D_8013DE08)($gp)
    /* C7CAC 800D74AC 801F063C */  lui        $a2, (0x1F800000 >> 16)
    /* C7CB0 800D74B0 0000C68C */  lw         $a2, (0x1F800000 & 0xFFFF)($a2)
    /* C7CB4 800D74B4 6004838C */  lw         $v1, 0x460($a0)
    /* C7CB8 800D74B8 0000C28C */  lw         $v0, 0x0($a2)
    /* C7CBC 800D74BC 24186700 */  and        $v1, $v1, $a3
    /* C7CC0 800D74C0 24104500 */  and        $v0, $v0, $a1
    /* C7CC4 800D74C4 25186200 */  or         $v1, $v1, $v0
    /* C7CC8 800D74C8 600483AC */  sw         $v1, 0x460($a0)
    /* C7CCC 800D74CC 60048424 */  addiu      $a0, $a0, 0x460
    /* C7CD0 800D74D0 0000C38C */  lw         $v1, 0x0($a2)
    /* C7CD4 800D74D4 24208500 */  and        $a0, $a0, $a1
    /* C7CD8 800D74D8 24186700 */  and        $v1, $v1, $a3
    /* C7CDC 800D74DC 25186400 */  or         $v1, $v1, $a0
    /* C7CE0 800D74E0 1480043C */  lui        $a0, %hi(D_8013E414)
    /* C7CE4 800D74E4 0000C3AC */  sw         $v1, 0x0($a2)
    /* C7CE8 800D74E8 14E4828C */  lw         $v0, %lo(D_8013E414)($a0)
    /* C7CEC 800D74EC 24186500 */  and        $v1, $v1, $a1
    /* C7CF0 800D74F0 24104700 */  and        $v0, $v0, $a3
    /* C7CF4 800D74F4 25104300 */  or         $v0, $v0, $v1
    /* C7CF8 800D74F8 14E482AC */  sw         $v0, %lo(D_8013E414)($a0)
    /* C7CFC 800D74FC 14E48424 */  addiu      $a0, $a0, %lo(D_8013E414)
    /* C7D00 800D7500 0000C38C */  lw         $v1, 0x0($a2)
    /* C7D04 800D7504 24208500 */  and        $a0, $a0, $a1
    /* C7D08 800D7508 24186700 */  and        $v1, $v1, $a3
    /* C7D0C 800D750C 25186400 */  or         $v1, $v1, $a0
    /* C7D10 800D7510 1480043C */  lui        $a0, %hi(D_8013E3B4)
    /* C7D14 800D7514 0000C3AC */  sw         $v1, 0x0($a2)
    /* C7D18 800D7518 B4E3828C */  lw         $v0, %lo(D_8013E3B4)($a0)
    /* C7D1C 800D751C 24186500 */  and        $v1, $v1, $a1
    /* C7D20 800D7520 24104700 */  and        $v0, $v0, $a3
    /* C7D24 800D7524 25104300 */  or         $v0, $v0, $v1
    /* C7D28 800D7528 B4E382AC */  sw         $v0, %lo(D_8013E3B4)($a0)
    /* C7D2C 800D752C B4E38424 */  addiu      $a0, $a0, %lo(D_8013E3B4)
    /* C7D30 800D7530 0000C28C */  lw         $v0, 0x0($a2)
    /* C7D34 800D7534 24208500 */  and        $a0, $a0, $a1
    /* C7D38 800D7538 24104700 */  and        $v0, $v0, $a3
    /* C7D3C 800D753C 25104400 */  or         $v0, $v0, $a0
    /* C7D40 800D7540 0000C2AC */  sw         $v0, 0x0($a2)
    /* C7D44 800D7544 0800E003 */  jr         $ra
    /* C7D48 800D7548 0800BD27 */   addiu     $sp, $sp, 0x8
endlabel Hud_BuildReplay__Fv
