.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_StopCar__FP8Car_tObjii, 0xC4

glabel AIPhysic_StopCar__FP8Car_tObjii
    /* 59A38 80069238 2118A000 */  addu       $v1, $a1, $zero
    /* 59A3C 8006923C FC0380AC */  sw         $zero, 0x3FC($a0)
    /* 59A40 80069240 F80380AC */  sw         $zero, 0x3F8($a0)
    /* 59A44 80069244 F40380AC */  sw         $zero, 0x3F4($a0)
    /* 59A48 80069248 140480AC */  sw         $zero, 0x414($a0)
    /* 59A4C 8006924C 100480AC */  sw         $zero, 0x410($a0)
    /* 59A50 80069250 0C0480AC */  sw         $zero, 0x40C($a0)
    /* 59A54 80069254 380480AC */  sw         $zero, 0x438($a0)
    /* 59A58 80069258 340480AC */  sw         $zero, 0x434($a0)
    /* 59A5C 8006925C 0200A104 */  bgez       $a1, .L80069268
    /* 59A60 80069260 300480AC */   sw        $zero, 0x430($a0)
    /* 59A64 80069264 FF00A324 */  addiu      $v1, $a1, 0xFF
  .L80069268:
    /* 59A68 80069268 AC00828C */  lw         $v0, 0xAC($a0)
    /* 59A6C 8006926C 03420300 */  sra        $t0, $v1, 8
    /* 59A70 80069270 18000201 */  mult       $t0, $v0
    /* 59A74 80069274 12180000 */  mflo       $v1
    /* 59A78 80069278 02006104 */  bgez       $v1, .L80069284
    /* 59A7C 8006927C 00000000 */   nop
    /* 59A80 80069280 FF006324 */  addiu      $v1, $v1, 0xFF
  .L80069284:
    /* 59A84 80069284 B000828C */  lw         $v0, 0xB0($a0)
    /* 59A88 80069288 00000000 */  nop
    /* 59A8C 8006928C 18000201 */  mult       $t0, $v0
    /* 59A90 80069290 03120300 */  sra        $v0, $v1, 8
    /* 59A94 80069294 12380000 */  mflo       $a3
    /* 59A98 80069298 0200E104 */  bgez       $a3, .L800692A4
    /* 59A9C 8006929C AC0082AC */   sw        $v0, 0xAC($a0)
    /* 59AA0 800692A0 FF00E724 */  addiu      $a3, $a3, 0xFF
  .L800692A4:
    /* 59AA4 800692A4 03120700 */  sra        $v0, $a3, 8
    /* 59AA8 800692A8 B00082AC */  sw         $v0, 0xB0($a0)
    /* 59AAC 800692AC B400828C */  lw         $v0, 0xB4($a0)
    /* 59AB0 800692B0 00000000 */  nop
    /* 59AB4 800692B4 18000201 */  mult       $t0, $v0
    /* 59AB8 800692B8 12100000 */  mflo       $v0
    /* 59ABC 800692BC 02004104 */  bgez       $v0, .L800692C8
    /* 59AC0 800692C0 00000000 */   nop
    /* 59AC4 800692C4 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800692C8:
    /* 59AC8 800692C8 1801838C */  lw         $v1, 0x118($a0)
    /* 59ACC 800692CC 03120200 */  sra        $v0, $v0, 8
    /* 59AD0 800692D0 02006104 */  bgez       $v1, .L800692DC
    /* 59AD4 800692D4 B40082AC */   sw        $v0, 0xB4($a0)
    /* 59AD8 800692D8 FF006324 */  addiu      $v1, $v1, 0xFF
  .L800692DC:
    /* 59ADC 800692DC 0200C104 */  bgez       $a2, .L800692E8
    /* 59AE0 800692E0 031A0300 */   sra       $v1, $v1, 8
    /* 59AE4 800692E4 FF00C624 */  addiu      $a2, $a2, 0xFF
  .L800692E8:
    /* 59AE8 800692E8 03120600 */  sra        $v0, $a2, 8
    /* 59AEC 800692EC 18006200 */  mult       $v1, $v0
    /* 59AF0 800692F0 12480000 */  mflo       $t1
    /* 59AF4 800692F4 0800E003 */  jr         $ra
    /* 59AF8 800692F8 180189AC */   sw        $t1, 0x118($a0)
endlabel AIPhysic_StopCar__FP8Car_tObjii
