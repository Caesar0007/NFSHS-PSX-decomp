.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_InitMap__Fv, 0xA0

glabel Hud_InitMap__Fv
    /* C6248 800D5A48 1480063C */  lui        $a2, %hi(Cars_gNumRaceCars)
    /* C624C 800D5A4C F8C7C68C */  lw         $a2, %lo(Cars_gNumRaceCars)($a2)
    /* C6250 800D5A50 00000000 */  nop
    /* C6254 800D5A54 0F00C018 */  blez       $a2, .L800D5A94
    /* C6258 800D5A58 21180000 */   addu      $v1, $zero, $zero
    /* C625C 800D5A5C 1280023C */  lui        $v0, %hi(Hud_gMarkerColor)
    /* C6260 800D5A60 600B4524 */  addiu      $a1, $v0, %lo(Hud_gMarkerColor)
    /* C6264 800D5A64 1180023C */  lui        $v0, %hi(Cars_gRaceCarList)
    /* C6268 800D5A68 00FA4424 */  addiu      $a0, $v0, %lo(Cars_gRaceCarList)
  .L800D5A6C:
    /* C626C 800D5A6C 0000828C */  lw         $v0, 0x0($a0)
    /* C6270 800D5A70 00000000 */  nop
    /* C6274 800D5A74 8802428C */  lw         $v0, 0x288($v0)
    /* C6278 800D5A78 04008424 */  addiu      $a0, $a0, 0x4
    /* C627C 800D5A7C 9400428C */  lw         $v0, 0x94($v0)
    /* C6280 800D5A80 01006324 */  addiu      $v1, $v1, 0x1
    /* C6284 800D5A84 0000A2AC */  sw         $v0, 0x0($a1)
    /* C6288 800D5A88 2A106600 */  slt        $v0, $v1, $a2
    /* C628C 800D5A8C F7FF4014 */  bnez       $v0, .L800D5A6C
    /* C6290 800D5A90 0400A524 */   addiu     $a1, $a1, 0x4
  .L800D5A94:
    /* C6294 800D5A94 1480063C */  lui        $a2, %hi(Cars_gNumCopCars)
    /* C6298 800D5A98 0CC8C68C */  lw         $a2, %lo(Cars_gNumCopCars)($a2)
    /* C629C 800D5A9C 00000000 */  nop
    /* C62A0 800D5AA0 0F00C018 */  blez       $a2, .L800D5AE0
    /* C62A4 800D5AA4 21180000 */   addu      $v1, $zero, $zero
    /* C62A8 800D5AA8 1280023C */  lui        $v0, %hi(Hud_gCopMarkerColor)
    /* C62AC 800D5AAC 900B4524 */  addiu      $a1, $v0, %lo(Hud_gCopMarkerColor)
    /* C62B0 800D5AB0 1180023C */  lui        $v0, %hi(Cars_gCopCarList)
    /* C62B4 800D5AB4 B4FA4424 */  addiu      $a0, $v0, %lo(Cars_gCopCarList)
  .L800D5AB8:
    /* C62B8 800D5AB8 0000828C */  lw         $v0, 0x0($a0)
    /* C62BC 800D5ABC 00000000 */  nop
    /* C62C0 800D5AC0 8802428C */  lw         $v0, 0x288($v0)
    /* C62C4 800D5AC4 04008424 */  addiu      $a0, $a0, 0x4
    /* C62C8 800D5AC8 9400428C */  lw         $v0, 0x94($v0)
    /* C62CC 800D5ACC 01006324 */  addiu      $v1, $v1, 0x1
    /* C62D0 800D5AD0 0000A2AC */  sw         $v0, 0x0($a1)
    /* C62D4 800D5AD4 2A106600 */  slt        $v0, $v1, $a2
    /* C62D8 800D5AD8 F7FF4014 */  bnez       $v0, .L800D5AB8
    /* C62DC 800D5ADC 0400A524 */   addiu     $a1, $a1, 0x4
  .L800D5AE0:
    /* C62E0 800D5AE0 0800E003 */  jr         $ra
    /* C62E4 800D5AE4 00000000 */   nop
endlabel Hud_InitMap__Fv
