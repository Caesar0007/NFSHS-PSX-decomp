.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BuildETimeString__FP4SPRTi, 0x18C

glabel Hud_BuildETimeString__FP4SPRTi
    /* C4218 800D3A18 0200A104 */  bgez       $a1, .L800D3A24
    /* C421C 800D3A1C 21408000 */   addu      $t0, $a0, $zero
    /* C4220 800D3A20 21280000 */  addu       $a1, $zero, $zero
  .L800D3A24:
    /* C4224 800D3A24 0200A104 */  bgez       $a1, .L800D3A30
    /* C4228 800D3A28 2110A000 */   addu      $v0, $a1, $zero
    /* C422C 800D3A2C 23100200 */  negu       $v0, $v0
  .L800D3A30:
    /* C4230 800D3A30 02004104 */  bgez       $v0, .L800D3A3C
    /* C4234 800D3A34 21304000 */   addu      $a2, $v0, $zero
    /* C4238 800D3A38 3F004224 */  addiu      $v0, $v0, 0x3F
  .L800D3A3C:
    /* C423C 800D3A3C 8888033C */  lui        $v1, (0x88888889 >> 16)
    /* C4240 800D3A40 89886334 */  ori        $v1, $v1, (0x88888889 & 0xFFFF)
    /* C4244 800D3A44 83290200 */  sra        $a1, $v0, 6
    /* C4248 800D3A48 1800A300 */  mult       $a1, $v1
    /* C424C 800D3A4C C3170200 */  sra        $v0, $v0, 31
    /* C4250 800D3A50 10600000 */  mfhi       $t4
    /* C4254 800D3A54 21208501 */  addu       $a0, $t4, $a1
    /* C4258 800D3A58 43210400 */  sra        $a0, $a0, 5
    /* C425C 800D3A5C 23208200 */  subu       $a0, $a0, $v0
    /* C4260 800D3A60 18008300 */  mult       $a0, $v1
    /* C4264 800D3A64 80190500 */  sll        $v1, $a1, 6
    /* C4268 800D3A68 2318C300 */  subu       $v1, $a2, $v1
    /* C426C 800D3A6C 40100300 */  sll        $v0, $v1, 1
    /* C4270 800D3A70 21104300 */  addu       $v0, $v0, $v1
    /* C4274 800D3A74 C0100200 */  sll        $v0, $v0, 3
    /* C4278 800D3A78 21104300 */  addu       $v0, $v0, $v1
    /* C427C 800D3A7C 80580200 */  sll        $t3, $v0, 2
    /* C4280 800D3A80 C31F0400 */  sra        $v1, $a0, 31
    /* C4284 800D3A84 10600000 */  mfhi       $t4
    /* C4288 800D3A88 21108401 */  addu       $v0, $t4, $a0
    /* C428C 800D3A8C 43110200 */  sra        $v0, $v0, 5
    /* C4290 800D3A90 23484300 */  subu       $t1, $v0, $v1
    /* C4294 800D3A94 00110900 */  sll        $v0, $t1, 4
    /* C4298 800D3A98 23104900 */  subu       $v0, $v0, $t1
    /* C429C 800D3A9C 80100200 */  sll        $v0, $v0, 2
    /* C42A0 800D3AA0 23488200 */  subu       $t1, $a0, $v0
    /* C42A4 800D3AA4 00110400 */  sll        $v0, $a0, 4
    /* C42A8 800D3AA8 23104400 */  subu       $v0, $v0, $a0
    /* C42AC 800D3AAC 80100200 */  sll        $v0, $v0, 2
    /* C42B0 800D3AB0 02006105 */  bgez       $t3, .L800D3ABC
    /* C42B4 800D3AB4 2350A200 */   subu      $t2, $a1, $v0
    /* C42B8 800D3AB8 3F006B25 */  addiu      $t3, $t3, 0x3F
  .L800D3ABC:
    /* C42BC 800D3ABC 6666073C */  lui        $a3, (0x66666667 >> 16)
    /* C42C0 800D3AC0 6766E734 */  ori        $a3, $a3, (0x66666667 & 0xFFFF)
    /* C42C4 800D3AC4 18002701 */  mult       $t1, $a3
    /* C42C8 800D3AC8 C3170900 */  sra        $v0, $t1, 31
    /* C42CC 800D3ACC 1180063C */  lui        $a2, %hi(HudPmx_gHudNumberUV)
    /* C42D0 800D3AD0 700CC624 */  addiu      $a2, $a2, %lo(HudPmx_gHudNumberUV)
    /* C42D4 800D3AD4 83290B00 */  sra        $a1, $t3, 6
    /* C42D8 800D3AD8 10600000 */  mfhi       $t4
    /* C42DC 800D3ADC 83200C00 */  sra        $a0, $t4, 2
    /* C42E0 800D3AE0 23208200 */  subu       $a0, $a0, $v0
    /* C42E4 800D3AE4 80100400 */  sll        $v0, $a0, 2
    /* C42E8 800D3AE8 21184600 */  addu       $v1, $v0, $a2
    /* C42EC 800D3AEC 21104400 */  addu       $v0, $v0, $a0
    /* C42F0 800D3AF0 18004701 */  mult       $t2, $a3
    /* C42F4 800D3AF4 40100200 */  sll        $v0, $v0, 1
    /* C42F8 800D3AF8 23102201 */  subu       $v0, $t1, $v0
    /* C42FC 800D3AFC 80100200 */  sll        $v0, $v0, 2
    /* C4300 800D3B00 0000638C */  lw         $v1, 0x0($v1)
    /* C4304 800D3B04 21104600 */  addu       $v0, $v0, $a2
    /* C4308 800D3B08 0C0003AD */  sw         $v1, 0xC($t0)
    /* C430C 800D3B0C 0000428C */  lw         $v0, 0x0($v0)
    /* C4310 800D3B10 14000825 */  addiu      $t0, $t0, 0x14
    /* C4314 800D3B14 0C0002AD */  sw         $v0, 0xC($t0)
    /* C4318 800D3B18 C3170A00 */  sra        $v0, $t2, 31
    /* C431C 800D3B1C 28000825 */  addiu      $t0, $t0, 0x28
    /* C4320 800D3B20 10600000 */  mfhi       $t4
    /* C4324 800D3B24 83180C00 */  sra        $v1, $t4, 2
    /* C4328 800D3B28 23186200 */  subu       $v1, $v1, $v0
    /* C432C 800D3B2C 80100300 */  sll        $v0, $v1, 2
    /* C4330 800D3B30 21204600 */  addu       $a0, $v0, $a2
    /* C4334 800D3B34 21104300 */  addu       $v0, $v0, $v1
    /* C4338 800D3B38 1800A700 */  mult       $a1, $a3
    /* C433C 800D3B3C 40100200 */  sll        $v0, $v0, 1
    /* C4340 800D3B40 23104201 */  subu       $v0, $t2, $v0
    /* C4344 800D3B44 80100200 */  sll        $v0, $v0, 2
    /* C4348 800D3B48 0000848C */  lw         $a0, 0x0($a0)
    /* C434C 800D3B4C 21104600 */  addu       $v0, $v0, $a2
    /* C4350 800D3B50 0C0004AD */  sw         $a0, 0xC($t0)
    /* C4354 800D3B54 0000428C */  lw         $v0, 0x0($v0)
    /* C4358 800D3B58 14000825 */  addiu      $t0, $t0, 0x14
    /* C435C 800D3B5C 0C0002AD */  sw         $v0, 0xC($t0)
    /* C4360 800D3B60 C3170B00 */  sra        $v0, $t3, 31
    /* C4364 800D3B64 28000825 */  addiu      $t0, $t0, 0x28
    /* C4368 800D3B68 10600000 */  mfhi       $t4
    /* C436C 800D3B6C 83200C00 */  sra        $a0, $t4, 2
    /* C4370 800D3B70 23208200 */  subu       $a0, $a0, $v0
    /* C4374 800D3B74 80100400 */  sll        $v0, $a0, 2
    /* C4378 800D3B78 21184600 */  addu       $v1, $v0, $a2
    /* C437C 800D3B7C 21104400 */  addu       $v0, $v0, $a0
    /* C4380 800D3B80 40100200 */  sll        $v0, $v0, 1
    /* C4384 800D3B84 2328A200 */  subu       $a1, $a1, $v0
    /* C4388 800D3B88 80280500 */  sll        $a1, $a1, 2
    /* C438C 800D3B8C 0000638C */  lw         $v1, 0x0($v1)
    /* C4390 800D3B90 2128A600 */  addu       $a1, $a1, $a2
    /* C4394 800D3B94 0C0003AD */  sw         $v1, 0xC($t0)
    /* C4398 800D3B98 0000A28C */  lw         $v0, 0x0($a1)
    /* C439C 800D3B9C 0800E003 */  jr         $ra
    /* C43A0 800D3BA0 200002AD */   sw        $v0, 0x20($t0)
endlabel Hud_BuildETimeString__FP4SPRTi
