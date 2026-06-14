.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopSpeak_Server__Fv, 0x2CC

glabel CopSpeak_Server__Fv
    /* 8B194 8009A994 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 8B198 8009A998 840B828F */  lw         $v0, %gp_rel(CopSpeak_gSpchHandle)($gp)
    /* 8B19C 8009A99C FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 8B1A0 8009A9A0 1800BFAF */  sw         $ra, 0x18($sp)
    /* 8B1A4 8009A9A4 1400B1AF */  sw         $s1, 0x14($sp)
    /* 8B1A8 8009A9A8 30004310 */  beq        $v0, $v1, .L8009AA6C
    /* 8B1AC 8009A9AC 1000B0AF */   sw        $s0, 0x10($sp)
    /* 8B1B0 8009A9B0 1180023C */  lui        $v0, %hi(CopSpeak_gCurrent)
    /* 8B1B4 8009A9B4 041F4224 */  addiu      $v0, $v0, %lo(CopSpeak_gCurrent)
    /* 8B1B8 8009A9B8 1800458C */  lw         $a1, 0x18($v0)
    /* 8B1BC 8009A9BC 00000000 */  nop
    /* 8B1C0 8009A9C0 0500A314 */  bne        $a1, $v1, .L8009A9D8
    /* 8B1C4 8009A9C4 01000624 */   addiu     $a2, $zero, 0x1
    /* 8B1C8 8009A9C8 0800458C */  lw         $a1, 0x8($v0)
    /* 8B1CC 8009A9CC 1E004480 */  lb         $a0, 0x1E($v0)
    /* 8B1D0 8009A9D0 776A0208 */  j          .L8009A9DC
    /* 8B1D4 8009A9D4 0040A524 */   addiu     $a1, $a1, 0x4000
  .L8009A9D8:
    /* 8B1D8 8009A9D8 1E004480 */  lb         $a0, 0x1E($v0)
  .L8009A9DC:
    /* 8B1DC 8009A9DC 40DA010C */  jal        AudioCmn_GetAsyncSfx__Fiib
    /* 8B1E0 8009A9E0 00000000 */   nop
    /* 8B1E4 8009A9E4 840B848F */  lw         $a0, %gp_rel(CopSpeak_gSpchHandle)($gp)
    /* 8B1E8 8009A9E8 CEB4030C */  jal        SNDtimeremaining
    /* 8B1EC 8009A9EC 00000000 */   nop
    /* 8B1F0 8009A9F0 05004228 */  slti       $v0, $v0, 0x5
    /* 8B1F4 8009A9F4 1D004010 */  beqz       $v0, .L8009AA6C
    /* 8B1F8 8009A9F8 00000000 */   nop
    /* 8B1FC 8009A9FC 800B838F */  lw         $v1, %gp_rel(CopSpeak_gQueuePlay)($gp)
    /* 8B200 8009AA00 7C0B828F */  lw         $v0, %gp_rel(CopSpeak_gQueueHead)($gp)
    /* 8B204 8009AA04 00000000 */  nop
    /* 8B208 8009AA08 13006210 */  beq        $v1, $v0, .L8009AA58
    /* 8B20C 8009AA0C 40190300 */   sll       $v1, $v1, 5
    /* 8B210 8009AA10 1180023C */  lui        $v0, %hi(CopSpeak_gQueue)
    /* 8B214 8009AA14 241F4224 */  addiu      $v0, $v0, %lo(CopSpeak_gQueue)
    /* 8B218 8009AA18 21206200 */  addu       $a0, $v1, $v0
    /* 8B21C 8009AA1C 1E008380 */  lb         $v1, 0x1E($a0)
    /* 8B220 8009AA20 03000224 */  addiu      $v0, $zero, 0x3
    /* 8B224 8009AA24 0D006214 */  bne        $v1, $v0, .L8009AA5C
    /* 8B228 8009AA28 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 8B22C 8009AA2C 1800838C */  lw         $v1, 0x18($a0)
    /* 8B230 8009AA30 13000224 */  addiu      $v0, $zero, 0x13
    /* 8B234 8009AA34 09006214 */  bne        $v1, $v0, .L8009AA5C
    /* 8B238 8009AA38 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 8B23C 8009AA3C 1180023C */  lui        $v0, %hi(CopSpeak_gCurrent)
    /* 8B240 8009AA40 041F428C */  lw         $v0, %lo(CopSpeak_gCurrent)($v0)
    /* 8B244 8009AA44 00000000 */  nop
    /* 8B248 8009AA48 04004014 */  bnez       $v0, .L8009AA5C
    /* 8B24C 8009AA4C FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 8B250 8009AA50 14000224 */  addiu      $v0, $zero, 0x14
    /* 8B254 8009AA54 180082AC */  sw         $v0, 0x18($a0)
  .L8009AA58:
    /* 8B258 8009AA58 FFFF0224 */  addiu      $v0, $zero, -0x1
  .L8009AA5C:
    /* 8B25C 8009AA5C 840B82AF */  sw         $v0, %gp_rel(CopSpeak_gSpchHandle)($gp)
    /* 8B260 8009AA60 1180043C */  lui        $a0, %hi(CopSpeak_gCurrent)
    /* 8B264 8009AA64 7C65020C */  jal        CopSpeak_InitRequest__FP17CopSpeak_tRequest
    /* 8B268 8009AA68 041F8424 */   addiu     $a0, $a0, %lo(CopSpeak_gCurrent)
  .L8009AA6C:
    /* 8B26C 8009AA6C 800B908F */  lw         $s0, %gp_rel(CopSpeak_gQueuePlay)($gp)
    /* 8B270 8009AA70 7C0B828F */  lw         $v0, %gp_rel(CopSpeak_gQueueHead)($gp)
    /* 8B274 8009AA74 00000000 */  nop
    /* 8B278 8009AA78 1F000212 */  beq        $s0, $v0, .L8009AAF8
    /* 8B27C 8009AA7C 1180023C */   lui       $v0, %hi(CopSpeak_gQueue)
    /* 8B280 8009AA80 241F5124 */  addiu      $s1, $v0, %lo(CopSpeak_gQueue)
    /* 8B284 8009AA84 40111000 */  sll        $v0, $s0, 5
  .L8009AA88:
    /* 8B288 8009AA88 21185100 */  addu       $v1, $v0, $s1
    /* 8B28C 8009AA8C 1D006290 */  lbu        $v0, 0x1D($v1)
    /* 8B290 8009AA90 00000000 */  nop
    /* 8B294 8009AA94 11004014 */  bnez       $v0, .L8009AADC
    /* 8B298 8009AA98 3F00022A */   slti      $v0, $s0, 0x3F
    /* 8B29C 8009AA9C 1E006480 */  lb         $a0, 0x1E($v1)
    /* 8B2A0 8009AAA0 03000224 */  addiu      $v0, $zero, 0x3
    /* 8B2A4 8009AAA4 0D008210 */  beq        $a0, $v0, .L8009AADC
    /* 8B2A8 8009AAA8 3F00022A */   slti      $v0, $s0, 0x3F
    /* 8B2AC 8009AAAC 0A008004 */  bltz       $a0, .L8009AAD8
    /* 8B2B0 8009AAB0 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 8B2B4 8009AAB4 1800658C */  lw         $a1, 0x18($v1)
    /* 8B2B8 8009AAB8 00000000 */  nop
    /* 8B2BC 8009AABC 0400A214 */  bne        $a1, $v0, .L8009AAD0
    /* 8B2C0 8009AAC0 01000624 */   addiu     $a2, $zero, 0x1
    /* 8B2C4 8009AAC4 0800658C */  lw         $a1, 0x8($v1)
    /* 8B2C8 8009AAC8 00000000 */  nop
    /* 8B2CC 8009AACC 0040A524 */  addiu      $a1, $a1, 0x4000
  .L8009AAD0:
    /* 8B2D0 8009AAD0 40DA010C */  jal        AudioCmn_GetAsyncSfx__Fiib
    /* 8B2D4 8009AAD4 00000000 */   nop
  .L8009AAD8:
    /* 8B2D8 8009AAD8 3F00022A */  slti       $v0, $s0, 0x3F
  .L8009AADC:
    /* 8B2DC 8009AADC 02004010 */  beqz       $v0, .L8009AAE8
    /* 8B2E0 8009AAE0 21180000 */   addu      $v1, $zero, $zero
    /* 8B2E4 8009AAE4 01000326 */  addiu      $v1, $s0, 0x1
  .L8009AAE8:
    /* 8B2E8 8009AAE8 7C0B828F */  lw         $v0, %gp_rel(CopSpeak_gQueueHead)($gp)
    /* 8B2EC 8009AAEC 21806000 */  addu       $s0, $v1, $zero
    /* 8B2F0 8009AAF0 E5FF0216 */  bne        $s0, $v0, .L8009AA88
    /* 8B2F4 8009AAF4 40111000 */   sll       $v0, $s0, 5
  .L8009AAF8:
    /* 8B2F8 8009AAF8 900B838F */  lw         $v1, %gp_rel(CopSpeak_gQueueReady)($gp)
    /* 8B2FC 8009AAFC 8C0B828F */  lw         $v0, %gp_rel(CopSpeak_gQueueLoad)($gp)
    /* 8B300 8009AB00 00000000 */  nop
    /* 8B304 8009AB04 03006210 */  beq        $v1, $v0, .L8009AB14
    /* 8B308 8009AB08 00000000 */   nop
    /* 8B30C 8009AB0C EB65020C */  jal        CopSpeak_ReadyNextRequest__Fv
    /* 8B310 8009AB10 00000000 */   nop
  .L8009AB14:
    /* 8B314 8009AB14 840B838F */  lw         $v1, %gp_rel(CopSpeak_gSpchHandle)($gp)
    /* 8B318 8009AB18 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 8B31C 8009AB1C 04006210 */  beq        $v1, $v0, .L8009AB30
    /* 8B320 8009AB20 21200000 */   addu      $a0, $zero, $zero
    /* 8B324 8009AB24 1180023C */  lui        $v0, %hi(CopSpeak_gCurrent)
    /* 8B328 8009AB28 DB6A0208 */  j          .L8009AB6C
    /* 8B32C 8009AB2C 041F4424 */   addiu     $a0, $v0, %lo(CopSpeak_gCurrent)
  .L8009AB30:
    /* 8B330 8009AB30 800B838F */  lw         $v1, %gp_rel(CopSpeak_gQueuePlay)($gp)
    /* 8B334 8009AB34 900B828F */  lw         $v0, %gp_rel(CopSpeak_gQueueReady)($gp)
    /* 8B338 8009AB38 00000000 */  nop
    /* 8B33C 8009AB3C 0B006210 */  beq        $v1, $v0, .L8009AB6C
    /* 8B340 8009AB40 00000000 */   nop
    /* 8B344 8009AB44 7C0B828F */  lw         $v0, %gp_rel(CopSpeak_gQueueHead)($gp)
    /* 8B348 8009AB48 00000000 */  nop
    /* 8B34C 8009AB4C 07006210 */  beq        $v1, $v0, .L8009AB6C
    /* 8B350 8009AB50 1180023C */   lui       $v0, %hi(CopSpeak_gQueue)
    /* 8B354 8009AB54 241F4424 */  addiu      $a0, $v0, %lo(CopSpeak_gQueue)
    /* 8B358 8009AB58 3F006228 */  slti       $v0, $v1, 0x3F
    /* 8B35C 8009AB5C 03004010 */  beqz       $v0, .L8009AB6C
    /* 8B360 8009AB60 01006224 */   addiu     $v0, $v1, 0x1
    /* 8B364 8009AB64 40110200 */  sll        $v0, $v0, 5
    /* 8B368 8009AB68 21204400 */  addu       $a0, $v0, $a0
  .L8009AB6C:
    /* 8B36C 8009AB6C 14008010 */  beqz       $a0, .L8009ABC0
    /* 8B370 8009AB70 00000000 */   nop
    /* 8B374 8009AB74 1F008290 */  lbu        $v0, 0x1F($a0)
    /* 8B378 8009AB78 00000000 */  nop
    /* 8B37C 8009AB7C 10004010 */  beqz       $v0, .L8009ABC0
    /* 8B380 8009AB80 00000000 */   nop
    /* 8B384 8009AB84 0000828C */  lw         $v0, 0x0($a0)
    /* 8B388 8009AB88 00000000 */  nop
    /* 8B38C 8009AB8C 08004010 */  beqz       $v0, .L8009ABB0
    /* 8B390 8009AB90 30000424 */   addiu     $a0, $zero, 0x30
    /* 8B394 8009AB94 8E004284 */  lh         $v0, 0x8E($v0)
    /* 8B398 8009AB98 00000000 */  nop
    /* 8B39C 8009AB9C 20004324 */  addiu      $v1, $v0, 0x20
    /* 8B3A0 8009ABA0 80006228 */  slti       $v0, $v1, 0x80
    /* 8B3A4 8009ABA4 02004010 */  beqz       $v0, .L8009ABB0
    /* 8B3A8 8009ABA8 7F000424 */   addiu     $a0, $zero, 0x7F
    /* 8B3AC 8009ABAC 21206000 */  addu       $a0, $v1, $zero
  .L8009ABB0:
    /* 8B3B0 8009ABB0 0665020C */  jal        CopSpeak_RadioStaticActive__Fi
    /* 8B3B4 8009ABB4 00000000 */   nop
    /* 8B3B8 8009ABB8 F26A0208 */  j          .L8009ABC8
    /* 8B3BC 8009ABBC 00000000 */   nop
  .L8009ABC0:
    /* 8B3C0 8009ABC0 6265020C */  jal        CopSpeak_RadioStaticSquelch__Fv
    /* 8B3C4 8009ABC4 00000000 */   nop
  .L8009ABC8:
    /* 8B3C8 8009ABC8 900B838F */  lw         $v1, %gp_rel(CopSpeak_gQueueReady)($gp)
    /* 8B3CC 8009ABCC 7C0B828F */  lw         $v0, %gp_rel(CopSpeak_gQueueHead)($gp)
    /* 8B3D0 8009ABD0 00000000 */  nop
    /* 8B3D4 8009ABD4 10006210 */  beq        $v1, $v0, .L8009AC18
    /* 8B3D8 8009ABD8 1180023C */   lui       $v0, %hi(CopSpeak_gQueue)
    /* 8B3DC 8009ABDC 241F4424 */  addiu      $a0, $v0, %lo(CopSpeak_gQueue)
    /* 8B3E0 8009ABE0 40110300 */  sll        $v0, $v1, 5
    /* 8B3E4 8009ABE4 21184400 */  addu       $v1, $v0, $a0
    /* 8B3E8 8009ABE8 1D006290 */  lbu        $v0, 0x1D($v1)
    /* 8B3EC 8009ABEC 00000000 */  nop
    /* 8B3F0 8009ABF0 09004014 */  bnez       $v0, .L8009AC18
    /* 8B3F4 8009ABF4 00000000 */   nop
    /* 8B3F8 8009ABF8 800B828F */  lw         $v0, %gp_rel(CopSpeak_gQueuePlay)($gp)
    /* 8B3FC 8009ABFC 0000638C */  lw         $v1, 0x0($v1)
    /* 8B400 8009AC00 40110200 */  sll        $v0, $v0, 5
    /* 8B404 8009AC04 21104400 */  addu       $v0, $v0, $a0
    /* 8B408 8009AC08 0000428C */  lw         $v0, 0x0($v0)
    /* 8B40C 8009AC0C 00000000 */  nop
    /* 8B410 8009AC10 0C006210 */  beq        $v1, $v0, .L8009AC44
    /* 8B414 8009AC14 00000000 */   nop
  .L8009AC18:
    /* 8B418 8009AC18 800B838F */  lw         $v1, %gp_rel(CopSpeak_gQueuePlay)($gp)
    /* 8B41C 8009AC1C 900B828F */  lw         $v0, %gp_rel(CopSpeak_gQueueReady)($gp)
    /* 8B420 8009AC20 00000000 */  nop
    /* 8B424 8009AC24 07006210 */  beq        $v1, $v0, .L8009AC44
    /* 8B428 8009AC28 00000000 */   nop
    /* 8B42C 8009AC2C 7C0B828F */  lw         $v0, %gp_rel(CopSpeak_gQueueHead)($gp)
    /* 8B430 8009AC30 00000000 */  nop
    /* 8B434 8009AC34 03006210 */  beq        $v1, $v0, .L8009AC44
    /* 8B438 8009AC38 00000000 */   nop
    /* 8B43C 8009AC3C 0A6A020C */  jal        CopSpeak_PlayNextRequest__Fv
    /* 8B440 8009AC40 00000000 */   nop
  .L8009AC44:
    /* 8B444 8009AC44 8D69020C */  jal        CopSpeak_LoadNextRequest__Fv
    /* 8B448 8009AC48 00000000 */   nop
    /* 8B44C 8009AC4C 1800BF8F */  lw         $ra, 0x18($sp)
    /* 8B450 8009AC50 1400B18F */  lw         $s1, 0x14($sp)
    /* 8B454 8009AC54 1000B08F */  lw         $s0, 0x10($sp)
    /* 8B458 8009AC58 0800E003 */  jr         $ra
    /* 8B45C 8009AC5C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel CopSpeak_Server__Fv
