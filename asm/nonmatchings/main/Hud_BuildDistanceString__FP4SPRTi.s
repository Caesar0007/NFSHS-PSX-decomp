.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BuildDistanceString__FP4SPRTi, 0x1A0

glabel Hud_BuildDistanceString__FP4SPRTi
    /* C43A4 800D3BA4 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* C43A8 800D3BA8 48FA4224 */  addiu      $v0, $v0, %lo(Cars_gHumanRaceCarList)
    /* C43AC 800D3BAC 80280500 */  sll        $a1, $a1, 2
    /* C43B0 800D3BB0 2110A200 */  addu       $v0, $a1, $v0
    /* C43B4 800D3BB4 0000428C */  lw         $v0, 0x0($v0)
    /* C43B8 800D3BB8 00000000 */  nop
    /* C43BC 800D3BBC 9803438C */  lw         $v1, 0x398($v0)
    /* C43C0 800D3BC0 00000000 */  nop
    /* C43C4 800D3BC4 40100300 */  sll        $v0, $v1, 1
    /* C43C8 800D3BC8 21104300 */  addu       $v0, $v0, $v1
    /* C43CC 800D3BCC 40100200 */  sll        $v0, $v0, 1
    /* C43D0 800D3BD0 02004104 */  bgez       $v0, .L800D3BDC
    /* C43D4 800D3BD4 21484000 */   addu      $t1, $v0, $zero
    /* C43D8 800D3BD8 23480900 */  negu       $t1, $t1
  .L800D3BDC:
    /* C43DC 800D3BDC 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* C43E0 800D3BE0 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* C43E4 800D3BE4 2128A200 */  addu       $a1, $a1, $v0
    /* C43E8 800D3BE8 C000A38C */  lw         $v1, 0xC0($a1)
    /* C43EC 800D3BEC 02000224 */  addiu      $v0, $zero, 0x2
    /* C43F0 800D3BF0 0D006214 */  bne        $v1, $v0, .L800D3C28
    /* C43F4 800D3BF4 21508000 */   addu      $t2, $a0, $zero
    /* C43F8 800D3BF8 9051033C */  lui        $v1, (0x51902B55 >> 16)
    /* C43FC 800D3BFC 552B6334 */  ori        $v1, $v1, (0x51902B55 & 0xFFFF)
    /* C4400 800D3C00 40110900 */  sll        $v0, $t1, 5
    /* C4404 800D3C04 23104900 */  subu       $v0, $v0, $t1
    /* C4408 800D3C08 80100200 */  sll        $v0, $v0, 2
    /* C440C 800D3C0C 21104900 */  addu       $v0, $v0, $t1
    /* C4410 800D3C10 C0100200 */  sll        $v0, $v0, 3
    /* C4414 800D3C14 18004300 */  mult       $v0, $v1
    /* C4418 800D3C18 C3170200 */  sra        $v0, $v0, 31
    /* C441C 800D3C1C 10600000 */  mfhi       $t4
    /* C4420 800D3C20 431A0C00 */  sra        $v1, $t4, 9
    /* C4424 800D3C24 23486200 */  subu       $t1, $v1, $v0
  .L800D3C28:
    /* C4428 800D3C28 10272229 */  slti       $v0, $t1, 0x2710
    /* C442C 800D3C2C 43004010 */  beqz       $v0, .L800D3D3C
    /* C4430 800D3C30 6210023C */   lui       $v0, (0x10624DD3 >> 16)
    /* C4434 800D3C34 D34D4234 */  ori        $v0, $v0, (0x10624DD3 & 0xFFFF)
    /* C4438 800D3C38 18002201 */  mult       $t1, $v0
    /* C443C 800D3C3C 10300000 */  mfhi       $a2
    /* C4440 800D3C40 EB51023C */  lui        $v0, (0x51EB851F >> 16)
    /* C4444 800D3C44 1F854234 */  ori        $v0, $v0, (0x51EB851F & 0xFFFF)
    /* C4448 800D3C48 18002201 */  mult       $t1, $v0
    /* C444C 800D3C4C C33F0900 */  sra        $a3, $t1, 31
    /* C4450 800D3C50 83290600 */  sra        $a1, $a2, 6
    /* C4454 800D3C54 2328A700 */  subu       $a1, $a1, $a3
    /* C4458 800D3C58 40210500 */  sll        $a0, $a1, 5
    /* C445C 800D3C5C 23208500 */  subu       $a0, $a0, $a1
    /* C4460 800D3C60 80200400 */  sll        $a0, $a0, 2
    /* C4464 800D3C64 21208500 */  addu       $a0, $a0, $a1
    /* C4468 800D3C68 10180000 */  mfhi       $v1
    /* C446C 800D3C6C C0200400 */  sll        $a0, $a0, 3
    /* C4470 800D3C70 23202401 */  subu       $a0, $t1, $a0
    /* C4474 800D3C74 18008200 */  mult       $a0, $v0
    /* C4478 800D3C78 6666083C */  lui        $t0, (0x66666667 >> 16)
    /* C447C 800D3C7C 67660835 */  ori        $t0, $t0, (0x66666667 & 0xFFFF)
    /* C4480 800D3C80 43110300 */  sra        $v0, $v1, 5
    /* C4484 800D3C84 23104700 */  subu       $v0, $v0, $a3
    /* C4488 800D3C88 40180200 */  sll        $v1, $v0, 1
    /* C448C 800D3C8C 21186200 */  addu       $v1, $v1, $v0
    /* C4490 800D3C90 C0180300 */  sll        $v1, $v1, 3
    /* C4494 800D3C94 21186200 */  addu       $v1, $v1, $v0
    /* C4498 800D3C98 10680000 */  mfhi       $t5
    /* C449C 800D3C9C 80180300 */  sll        $v1, $v1, 2
    /* C44A0 800D3CA0 23182301 */  subu       $v1, $t1, $v1
    /* C44A4 800D3CA4 18006800 */  mult       $v1, $t0
    /* C44A8 800D3CA8 1180063C */  lui        $a2, %hi(HudPmx_gHudNumberUV)
    /* C44AC 800D3CAC 700CC624 */  addiu      $a2, $a2, %lo(HudPmx_gHudNumberUV)
    /* C44B0 800D3CB0 80280500 */  sll        $a1, $a1, 2
    /* C44B4 800D3CB4 2128A600 */  addu       $a1, $a1, $a2
    /* C44B8 800D3CB8 0000A28C */  lw         $v0, 0x0($a1)
    /* C44BC 800D3CBC C3270400 */  sra        $a0, $a0, 31
    /* C44C0 800D3CC0 0C0042AD */  sw         $v0, 0xC($t2)
    /* C44C4 800D3CC4 28004A25 */  addiu      $t2, $t2, 0x28
    /* C44C8 800D3CC8 43110D00 */  sra        $v0, $t5, 5
    /* C44CC 800D3CCC 10580000 */  mfhi       $t3
    /* C44D0 800D3CD0 23104400 */  subu       $v0, $v0, $a0
    /* C44D4 800D3CD4 80100200 */  sll        $v0, $v0, 2
    /* C44D8 800D3CD8 18002801 */  mult       $t1, $t0
    /* C44DC 800D3CDC 21104600 */  addu       $v0, $v0, $a2
    /* C44E0 800D3CE0 0000428C */  lw         $v0, 0x0($v0)
    /* C44E4 800D3CE4 C31F0300 */  sra        $v1, $v1, 31
    /* C44E8 800D3CE8 0C0042AD */  sw         $v0, 0xC($t2)
    /* C44EC 800D3CEC 83100B00 */  sra        $v0, $t3, 2
    /* C44F0 800D3CF0 23104300 */  subu       $v0, $v0, $v1
    /* C44F4 800D3CF4 80100200 */  sll        $v0, $v0, 2
    /* C44F8 800D3CF8 21104600 */  addu       $v0, $v0, $a2
    /* C44FC 800D3CFC 0000428C */  lw         $v0, 0x0($v0)
    /* C4500 800D3D00 14004A25 */  addiu      $t2, $t2, 0x14
    /* C4504 800D3D04 0C0042AD */  sw         $v0, 0xC($t2)
    /* C4508 800D3D08 10400000 */  mfhi       $t0
    /* C450C 800D3D0C 83180800 */  sra        $v1, $t0, 2
    /* C4510 800D3D10 23186700 */  subu       $v1, $v1, $a3
    /* C4514 800D3D14 80100300 */  sll        $v0, $v1, 2
    /* C4518 800D3D18 21104300 */  addu       $v0, $v0, $v1
    /* C451C 800D3D1C 40100200 */  sll        $v0, $v0, 1
    /* C4520 800D3D20 23102201 */  subu       $v0, $t1, $v0
    /* C4524 800D3D24 80100200 */  sll        $v0, $v0, 2
    /* C4528 800D3D28 21104600 */  addu       $v0, $v0, $a2
    /* C452C 800D3D2C 0000438C */  lw         $v1, 0x0($v0)
    /* C4530 800D3D30 01000224 */  addiu      $v0, $zero, 0x1
    /* C4534 800D3D34 0800E003 */  jr         $ra
    /* C4538 800D3D38 200043AD */   sw        $v1, 0x20($t2)
  .L800D3D3C:
    /* C453C 800D3D3C 0800E003 */  jr         $ra
    /* C4540 800D3D40 21100000 */   addu      $v0, $zero, $zero
endlabel Hud_BuildDistanceString__FP4SPRTi
