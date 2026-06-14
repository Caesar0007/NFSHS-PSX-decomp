.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BuildTimeString__FP4SPRTi, 0x150

glabel Hud_BuildTimeString__FP4SPRTi
    /* C4544 800D3D44 21408000 */  addu       $t0, $a0, $zero
    /* C4548 800D3D48 0200A104 */  bgez       $a1, .L800D3D54
    /* C454C 800D3D4C 00000000 */   nop
    /* C4550 800D3D50 23280500 */  negu       $a1, $a1
  .L800D3D54:
    /* C4554 800D3D54 0200A104 */  bgez       $a1, .L800D3D60
    /* C4558 800D3D58 2130A000 */   addu      $a2, $a1, $zero
    /* C455C 800D3D5C 3F00A524 */  addiu      $a1, $a1, 0x3F
  .L800D3D60:
    /* C4560 800D3D60 8888023C */  lui        $v0, (0x88888889 >> 16)
    /* C4564 800D3D64 89884234 */  ori        $v0, $v0, (0x88888889 & 0xFFFF)
    /* C4568 800D3D68 83210500 */  sra        $a0, $a1, 6
    /* C456C 800D3D6C 18008200 */  mult       $a0, $v0
    /* C4570 800D3D70 80190400 */  sll        $v1, $a0, 6
    /* C4574 800D3D74 2318C300 */  subu       $v1, $a2, $v1
    /* C4578 800D3D78 40100300 */  sll        $v0, $v1, 1
    /* C457C 800D3D7C 21104300 */  addu       $v0, $v0, $v1
    /* C4580 800D3D80 C0100200 */  sll        $v0, $v0, 3
    /* C4584 800D3D84 21104300 */  addu       $v0, $v0, $v1
    /* C4588 800D3D88 80500200 */  sll        $t2, $v0, 2
    /* C458C 800D3D8C C31F0500 */  sra        $v1, $a1, 31
    /* C4590 800D3D90 10580000 */  mfhi       $t3
    /* C4594 800D3D94 21106401 */  addu       $v0, $t3, $a0
    /* C4598 800D3D98 43110200 */  sra        $v0, $v0, 5
    /* C459C 800D3D9C 23484300 */  subu       $t1, $v0, $v1
    /* C45A0 800D3DA0 21282001 */  addu       $a1, $t1, $zero
    /* C45A4 800D3DA4 00110500 */  sll        $v0, $a1, 4
    /* C45A8 800D3DA8 23104500 */  subu       $v0, $v0, $a1
    /* C45AC 800D3DAC 80100200 */  sll        $v0, $v0, 2
    /* C45B0 800D3DB0 02004105 */  bgez       $t2, .L800D3DBC
    /* C45B4 800D3DB4 23488200 */   subu      $t1, $a0, $v0
    /* C45B8 800D3DB8 3F004A25 */  addiu      $t2, $t2, 0x3F
  .L800D3DBC:
    /* C45BC 800D3DBC 6666073C */  lui        $a3, (0x66666667 >> 16)
    /* C45C0 800D3DC0 6766E734 */  ori        $a3, $a3, (0x66666667 & 0xFFFF)
    /* C45C4 800D3DC4 1800A700 */  mult       $a1, $a3
    /* C45C8 800D3DC8 C3170500 */  sra        $v0, $a1, 31
    /* C45CC 800D3DCC 1180063C */  lui        $a2, %hi(HudPmx_gHudNumberUV)
    /* C45D0 800D3DD0 700CC624 */  addiu      $a2, $a2, %lo(HudPmx_gHudNumberUV)
    /* C45D4 800D3DD4 10580000 */  mfhi       $t3
    /* C45D8 800D3DD8 83180B00 */  sra        $v1, $t3, 2
    /* C45DC 800D3DDC 23186200 */  subu       $v1, $v1, $v0
    /* C45E0 800D3DE0 18002701 */  mult       $t1, $a3
    /* C45E4 800D3DE4 80100300 */  sll        $v0, $v1, 2
    /* C45E8 800D3DE8 21104300 */  addu       $v0, $v0, $v1
    /* C45EC 800D3DEC 40100200 */  sll        $v0, $v0, 1
    /* C45F0 800D3DF0 2310A200 */  subu       $v0, $a1, $v0
    /* C45F4 800D3DF4 80100200 */  sll        $v0, $v0, 2
    /* C45F8 800D3DF8 21104600 */  addu       $v0, $v0, $a2
    /* C45FC 800D3DFC 0000428C */  lw         $v0, 0x0($v0)
    /* C4600 800D3E00 83290A00 */  sra        $a1, $t2, 6
    /* C4604 800D3E04 0C0002AD */  sw         $v0, 0xC($t0)
    /* C4608 800D3E08 C3170900 */  sra        $v0, $t1, 31
    /* C460C 800D3E0C 28000825 */  addiu      $t0, $t0, 0x28
    /* C4610 800D3E10 10580000 */  mfhi       $t3
    /* C4614 800D3E14 83180B00 */  sra        $v1, $t3, 2
    /* C4618 800D3E18 23186200 */  subu       $v1, $v1, $v0
    /* C461C 800D3E1C 80100300 */  sll        $v0, $v1, 2
    /* C4620 800D3E20 21204600 */  addu       $a0, $v0, $a2
    /* C4624 800D3E24 21104300 */  addu       $v0, $v0, $v1
    /* C4628 800D3E28 1800A700 */  mult       $a1, $a3
    /* C462C 800D3E2C 40100200 */  sll        $v0, $v0, 1
    /* C4630 800D3E30 23102201 */  subu       $v0, $t1, $v0
    /* C4634 800D3E34 80100200 */  sll        $v0, $v0, 2
    /* C4638 800D3E38 0000848C */  lw         $a0, 0x0($a0)
    /* C463C 800D3E3C 21104600 */  addu       $v0, $v0, $a2
    /* C4640 800D3E40 0C0004AD */  sw         $a0, 0xC($t0)
    /* C4644 800D3E44 0000428C */  lw         $v0, 0x0($v0)
    /* C4648 800D3E48 14000825 */  addiu      $t0, $t0, 0x14
    /* C464C 800D3E4C 0C0002AD */  sw         $v0, 0xC($t0)
    /* C4650 800D3E50 C3170A00 */  sra        $v0, $t2, 31
    /* C4654 800D3E54 28000825 */  addiu      $t0, $t0, 0x28
    /* C4658 800D3E58 10580000 */  mfhi       $t3
    /* C465C 800D3E5C 83200B00 */  sra        $a0, $t3, 2
    /* C4660 800D3E60 23208200 */  subu       $a0, $a0, $v0
    /* C4664 800D3E64 80100400 */  sll        $v0, $a0, 2
    /* C4668 800D3E68 21184600 */  addu       $v1, $v0, $a2
    /* C466C 800D3E6C 21104400 */  addu       $v0, $v0, $a0
    /* C4670 800D3E70 40100200 */  sll        $v0, $v0, 1
    /* C4674 800D3E74 2328A200 */  subu       $a1, $a1, $v0
    /* C4678 800D3E78 80280500 */  sll        $a1, $a1, 2
    /* C467C 800D3E7C 0000638C */  lw         $v1, 0x0($v1)
    /* C4680 800D3E80 2128A600 */  addu       $a1, $a1, $a2
    /* C4684 800D3E84 0C0003AD */  sw         $v1, 0xC($t0)
    /* C4688 800D3E88 0000A28C */  lw         $v0, 0x0($a1)
    /* C468C 800D3E8C 0800E003 */  jr         $ra
    /* C4690 800D3E90 200002AD */   sw        $v0, 0x20($t0)
endlabel Hud_BuildTimeString__FP4SPRTi
