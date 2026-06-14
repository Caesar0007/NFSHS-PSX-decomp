.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AILife_ReencarnateCopBySlice__FP8Car_tObjiiii, 0x184

glabel AILife_ReencarnateCopBySlice__FP8Car_tObjiiii
    /* 589A0 800681A0 1480023C */  lui        $v0, %hi(AITune_oneWay)
    /* 589A4 800681A4 F0C5428C */  lw         $v0, %lo(AITune_oneWay)($v0)
    /* 589A8 800681A8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 589AC 800681AC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 589B0 800681B0 21808000 */  addu       $s0, $a0, $zero
    /* 589B4 800681B4 1400BFAF */  sw         $ra, 0x14($sp)
    /* 589B8 800681B8 080005A6 */  sh         $a1, 0x8($s0)
    /* 589BC 800681BC 2800A88F */  lw         $t0, 0x28($sp)
    /* 589C0 800681C0 06004010 */  beqz       $v0, .L800681DC
    /* 589C4 800681C4 1180023C */   lui       $v0, %hi(D_8011321C)
    /* 589C8 800681C8 1C32428C */  lw         $v0, %lo(D_8011321C)($v0)
    /* 589CC 800681CC 00000000 */  nop
    /* 589D0 800681D0 02004014 */  bnez       $v0, .L800681DC
    /* 589D4 800681D4 FFFF0624 */   addiu     $a2, $zero, -0x1
    /* 589D8 800681D8 01000624 */  addiu      $a2, $zero, 0x1
  .L800681DC:
    /* 589DC 800681DC 540506AE */  sw         $a2, 0x554($s0)
    /* 589E0 800681E0 1C000015 */  bnez       $t0, .L80068254
    /* 589E4 800681E4 500506AE */   sw        $a2, 0x550($s0)
    /* 589E8 800681E8 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 589EC 800681EC 0E00E214 */  bne        $a3, $v0, .L80068228
    /* 589F0 800681F0 00000000 */   nop
    /* 589F4 800681F4 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 589F8 800681F8 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 589FC 800681FC 40110500 */  sll        $v0, $a1, 5
    /* 58A00 80068200 21104300 */  addu       $v0, $v0, $v1
    /* 58A04 80068204 1E004390 */  lbu        $v1, 0x1E($v0)
    /* 58A08 80068208 1D004290 */  lbu        $v0, 0x1D($v0)
    /* 58A0C 8006820C C01B0300 */  sll        $v1, $v1, 15
    /* 58A10 80068210 02110200 */  srl        $v0, $v0, 4
    /* 58A14 80068214 18006200 */  mult       $v1, $v0
    /* 58A18 80068218 FEFF023C */  lui        $v0, (0xFFFE0000 >> 16)
    /* 58A1C 8006821C 12480000 */  mflo       $t1
    /* 58A20 80068220 B7A00108 */  j          .L800682DC
    /* 58A24 80068224 23104900 */   subu      $v0, $v0, $t1
  .L80068228:
    /* 58A28 80068228 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 58A2C 8006822C C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 58A30 80068230 40110500 */  sll        $v0, $a1, 5
    /* 58A34 80068234 21104300 */  addu       $v0, $v0, $v1
    /* 58A38 80068238 1F004390 */  lbu        $v1, 0x1F($v0)
    /* 58A3C 8006823C 1D004290 */  lbu        $v0, 0x1D($v0)
    /* 58A40 80068240 C01B0300 */  sll        $v1, $v1, 15
    /* 58A44 80068244 0F004230 */  andi       $v0, $v0, 0xF
    /* 58A48 80068248 18006200 */  mult       $v1, $v0
    /* 58A4C 8006824C B5A00108 */  j          .L800682D4
    /* 58A50 80068250 0200023C */   lui       $v0, (0x20000 >> 16)
  .L80068254:
    /* 58A54 80068254 5405038E */  lw         $v1, 0x554($s0)
    /* 58A58 80068258 01000224 */  addiu      $v0, $zero, 0x1
    /* 58A5C 8006825C 0A006210 */  beq        $v1, $v0, .L80068288
    /* 58A60 80068260 40190500 */   sll       $v1, $a1, 5
    /* 58A64 80068264 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* 58A68 80068268 C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* 58A6C 8006826C 00000000 */  nop
    /* 58A70 80068270 21186200 */  addu       $v1, $v1, $v0
    /* 58A74 80068274 1D006290 */  lbu        $v0, 0x1D($v1)
    /* 58A78 80068278 00000000 */  nop
    /* 58A7C 8006827C 02210200 */  srl        $a0, $v0, 4
    /* 58A80 80068280 0E008014 */  bnez       $a0, .L800682BC
    /* 58A84 80068284 00000000 */   nop
  .L80068288:
    /* 58A88 80068288 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* 58A8C 8006828C C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* 58A90 80068290 40190500 */  sll        $v1, $a1, 5
    /* 58A94 80068294 21186200 */  addu       $v1, $v1, $v0
    /* 58A98 80068298 1F006290 */  lbu        $v0, 0x1F($v1)
    /* 58A9C 8006829C 1D006390 */  lbu        $v1, 0x1D($v1)
    /* 58AA0 800682A0 C0130200 */  sll        $v0, $v0, 15
    /* 58AA4 800682A4 0F006330 */  andi       $v1, $v1, 0xF
    /* 58AA8 800682A8 18004300 */  mult       $v0, $v1
    /* 58AAC 800682AC 42100200 */  srl        $v0, $v0, 1
    /* 58AB0 800682B0 12480000 */  mflo       $t1
    /* 58AB4 800682B4 B7A00108 */  j          .L800682DC
    /* 58AB8 800682B8 23102201 */   subu      $v0, $t1, $v0
  .L800682BC:
    /* 58ABC 800682BC 1E006290 */  lbu        $v0, 0x1E($v1)
    /* 58AC0 800682C0 00000000 */  nop
    /* 58AC4 800682C4 C0130200 */  sll        $v0, $v0, 15
    /* 58AC8 800682C8 23180200 */  negu       $v1, $v0
    /* 58ACC 800682CC 18006400 */  mult       $v1, $a0
    /* 58AD0 800682D0 42100200 */  srl        $v0, $v0, 1
  .L800682D4:
    /* 58AD4 800682D4 12480000 */  mflo       $t1
    /* 58AD8 800682D8 21102201 */  addu       $v0, $t1, $v0
  .L800682DC:
    /* 58ADC 800682DC 05000011 */  beqz       $t0, .L800682F4
    /* 58AE0 800682E0 580502AE */   sw        $v0, 0x558($s0)
    /* 58AE4 800682E4 AD9D010C */  jal        AILife_RCSetSpeeds__FP8Car_tObj
    /* 58AE8 800682E8 21200002 */   addu      $a0, $s0, $zero
    /* 58AEC 800682EC C0A00108 */  j          .L80068300
    /* 58AF0 800682F0 21200002 */   addu      $a0, $s0, $zero
  .L800682F4:
    /* 58AF4 800682F4 5C0500AE */  sw         $zero, 0x55C($s0)
    /* 58AF8 800682F8 640500AE */  sw         $zero, 0x564($s0)
    /* 58AFC 800682FC 21200002 */  addu       $a0, $s0, $zero
  .L80068300:
    /* 58B00 80068300 5805028E */  lw         $v0, 0x558($s0)
    /* 58B04 80068304 21280000 */  addu       $a1, $zero, $zero
    /* 58B08 80068308 180782AC */  sw         $v0, 0x718($a0)
    /* 58B0C 8006830C 389F010C */  jal        AILife_PlaceCarAtLocation__FP8Car_tObji
    /* 58B10 80068310 740582AC */   sw        $v0, 0x574($a0)
    /* 58B14 80068314 1400BF8F */  lw         $ra, 0x14($sp)
    /* 58B18 80068318 1000B08F */  lw         $s0, 0x10($sp)
    /* 58B1C 8006831C 0800E003 */  jr         $ra
    /* 58B20 80068320 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AILife_ReencarnateCopBySlice__FP8Car_tObjiiii
