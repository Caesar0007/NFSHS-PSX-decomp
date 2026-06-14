.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Replay_InitReplay__Fv, 0x1A4

glabel Replay_InitReplay__Fv
    /* A45A0 800B3DA0 18FFBD27 */  addiu      $sp, $sp, -0xE8
    /* A45A4 800B3DA4 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* A45A8 800B3DA8 E000B0AF */  sw         $s0, 0xE0($sp)
    /* A45AC 800B3DAC EC315024 */  addiu      $s0, $v0, %lo(GameSetup_gData)
    /* A45B0 800B3DB0 E400BFAF */  sw         $ra, 0xE4($sp)
    /* A45B4 800B3DB4 2400028E */  lw         $v0, 0x24($s0)
    /* A45B8 800B3DB8 00000000 */  nop
    /* A45BC 800B3DBC A80E82AF */  sw         $v0, %gp_rel(Replay_ReplayMode)($gp)
    /* A45C0 800B3DC0 40D5020C */  jal        Replay_LoadCameraFile__Fv
    /* A45C4 800B3DC4 00000000 */   nop
    /* A45C8 800B3DC8 A80E838F */  lw         $v1, %gp_rel(Replay_ReplayMode)($gp)
    /* A45CC 800B3DCC 02000224 */  addiu      $v0, $zero, 0x2
    /* A45D0 800B3DD0 46006214 */  bne        $v1, $v0, .L800B3EEC
    /* A45D4 800B3DD4 1180023C */   lui       $v0, %hi(Replay_ReplayBuffer)
    /* A45D8 800B3DD8 1000A427 */  addiu      $a0, $sp, 0x10
    /* A45DC 800B3DDC E0000326 */  addiu      $v1, $s0, 0xE0
    /* A45E0 800B3DE0 A0010226 */  addiu      $v0, $s0, 0x1A0
  .L800B3DE4:
    /* A45E4 800B3DE4 0000658C */  lw         $a1, 0x0($v1)
    /* A45E8 800B3DE8 0400668C */  lw         $a2, 0x4($v1)
    /* A45EC 800B3DEC 0800678C */  lw         $a3, 0x8($v1)
    /* A45F0 800B3DF0 0C00688C */  lw         $t0, 0xC($v1)
    /* A45F4 800B3DF4 000085AC */  sw         $a1, 0x0($a0)
    /* A45F8 800B3DF8 040086AC */  sw         $a2, 0x4($a0)
    /* A45FC 800B3DFC 080087AC */  sw         $a3, 0x8($a0)
    /* A4600 800B3E00 0C0088AC */  sw         $t0, 0xC($a0)
    /* A4604 800B3E04 10006324 */  addiu      $v1, $v1, 0x10
    /* A4608 800B3E08 F6FF6214 */  bne        $v1, $v0, .L800B3DE4
    /* A460C 800B3E0C 10008424 */   addiu     $a0, $a0, 0x10
    /* A4610 800B3E10 0000658C */  lw         $a1, 0x0($v1)
    /* A4614 800B3E14 0400668C */  lw         $a2, 0x4($v1)
    /* A4618 800B3E18 0800678C */  lw         $a3, 0x8($v1)
    /* A461C 800B3E1C 000085AC */  sw         $a1, 0x0($a0)
    /* A4620 800B3E20 040086AC */  sw         $a2, 0x4($a0)
    /* A4624 800B3E24 09D4020C */  jal        Replay_LoadReplay__Fv
    /* A4628 800B3E28 080087AC */   sw        $a3, 0x8($a0)
    /* A462C 800B3E2C 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* A4630 800B3E30 EC314324 */  addiu      $v1, $v0, %lo(GameSetup_gData)
    /* A4634 800B3E34 1180023C */  lui        $v0, %hi(Replay_ReplayBuffer)
    /* A4638 800B3E38 6C714224 */  addiu      $v0, $v0, %lo(Replay_ReplayBuffer)
    /* A463C 800B3E3C 200A4424 */  addiu      $a0, $v0, 0xA20
  .L800B3E40:
    /* A4640 800B3E40 0000458C */  lw         $a1, 0x0($v0)
    /* A4644 800B3E44 0400468C */  lw         $a2, 0x4($v0)
    /* A4648 800B3E48 0800478C */  lw         $a3, 0x8($v0)
    /* A464C 800B3E4C 0C00488C */  lw         $t0, 0xC($v0)
    /* A4650 800B3E50 000065AC */  sw         $a1, 0x0($v1)
    /* A4654 800B3E54 040066AC */  sw         $a2, 0x4($v1)
    /* A4658 800B3E58 080067AC */  sw         $a3, 0x8($v1)
    /* A465C 800B3E5C 0C0068AC */  sw         $t0, 0xC($v1)
    /* A4660 800B3E60 10004224 */  addiu      $v0, $v0, 0x10
    /* A4664 800B3E64 F6FF4414 */  bne        $v0, $a0, .L800B3E40
    /* A4668 800B3E68 10006324 */   addiu     $v1, $v1, 0x10
    /* A466C 800B3E6C 0000458C */  lw         $a1, 0x0($v0)
    /* A4670 800B3E70 0400468C */  lw         $a2, 0x4($v0)
    /* A4674 800B3E74 000065AC */  sw         $a1, 0x0($v1)
    /* A4678 800B3E78 040066AC */  sw         $a2, 0x4($v1)
    /* A467C 800B3E7C 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* A4680 800B3E80 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* A4684 800B3E84 E0004224 */  addiu      $v0, $v0, 0xE0
    /* A4688 800B3E88 1000A327 */  addiu      $v1, $sp, 0x10
    /* A468C 800B3E8C D000A427 */  addiu      $a0, $sp, 0xD0
  .L800B3E90:
    /* A4690 800B3E90 0000658C */  lw         $a1, 0x0($v1)
    /* A4694 800B3E94 0400668C */  lw         $a2, 0x4($v1)
    /* A4698 800B3E98 0800678C */  lw         $a3, 0x8($v1)
    /* A469C 800B3E9C 0C00688C */  lw         $t0, 0xC($v1)
    /* A46A0 800B3EA0 000045AC */  sw         $a1, 0x0($v0)
    /* A46A4 800B3EA4 040046AC */  sw         $a2, 0x4($v0)
    /* A46A8 800B3EA8 080047AC */  sw         $a3, 0x8($v0)
    /* A46AC 800B3EAC 0C0048AC */  sw         $t0, 0xC($v0)
    /* A46B0 800B3EB0 10006324 */  addiu      $v1, $v1, 0x10
    /* A46B4 800B3EB4 F6FF6414 */  bne        $v1, $a0, .L800B3E90
    /* A46B8 800B3EB8 10004224 */   addiu     $v0, $v0, 0x10
    /* A46BC 800B3EBC 0000658C */  lw         $a1, 0x0($v1)
    /* A46C0 800B3EC0 0400668C */  lw         $a2, 0x4($v1)
    /* A46C4 800B3EC4 0800678C */  lw         $a3, 0x8($v1)
    /* A46C8 800B3EC8 000045AC */  sw         $a1, 0x0($v0)
    /* A46CC 800B3ECC 040046AC */  sw         $a2, 0x4($v0)
    /* A46D0 800B3ED0 080047AC */  sw         $a3, 0x8($v0)
    /* A46D4 800B3ED4 1180023C */  lui        $v0, %hi(D_80117B94)
    /* A46D8 800B3ED8 947B428C */  lw         $v0, %lo(D_80117B94)($v0)
    /* A46DC 800B3EDC B00E80AF */  sw         $zero, %gp_rel(Replay_ReplayGetPtr)($gp)
    /* A46E0 800B3EE0 A00E82AF */  sw         $v0, %gp_rel(Replay_Size)($gp)
    /* A46E4 800B3EE4 CDCF0208 */  j          .L800B3F34
    /* A46E8 800B3EE8 00000000 */   nop
  .L800B3EEC:
    /* A46EC 800B3EEC 6C714324 */  addiu      $v1, $v0, %lo(Replay_ReplayBuffer)
    /* A46F0 800B3EF0 21100002 */  addu       $v0, $s0, $zero
    /* A46F4 800B3EF4 200A4424 */  addiu      $a0, $v0, 0xA20
  .L800B3EF8:
    /* A46F8 800B3EF8 0000458C */  lw         $a1, 0x0($v0)
    /* A46FC 800B3EFC 0400468C */  lw         $a2, 0x4($v0)
    /* A4700 800B3F00 0800478C */  lw         $a3, 0x8($v0)
    /* A4704 800B3F04 0C00488C */  lw         $t0, 0xC($v0)
    /* A4708 800B3F08 000065AC */  sw         $a1, 0x0($v1)
    /* A470C 800B3F0C 040066AC */  sw         $a2, 0x4($v1)
    /* A4710 800B3F10 080067AC */  sw         $a3, 0x8($v1)
    /* A4714 800B3F14 0C0068AC */  sw         $t0, 0xC($v1)
    /* A4718 800B3F18 10004224 */  addiu      $v0, $v0, 0x10
    /* A471C 800B3F1C F6FF4414 */  bne        $v0, $a0, .L800B3EF8
    /* A4720 800B3F20 10006324 */   addiu     $v1, $v1, 0x10
    /* A4724 800B3F24 0000458C */  lw         $a1, 0x0($v0)
    /* A4728 800B3F28 0400468C */  lw         $a2, 0x4($v0)
    /* A472C 800B3F2C 000065AC */  sw         $a1, 0x0($v1)
    /* A4730 800B3F30 040066AC */  sw         $a2, 0x4($v1)
  .L800B3F34:
    /* A4734 800B3F34 E400BF8F */  lw         $ra, 0xE4($sp)
    /* A4738 800B3F38 E000B08F */  lw         $s0, 0xE0($sp)
    /* A473C 800B3F3C 0800E003 */  jr         $ra
    /* A4740 800B3F40 E800BD27 */   addiu     $sp, $sp, 0xE8
endlabel Replay_InitReplay__Fv
