.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Weather_CreateSnow__FP7SVECTOR, 0x1B0

glabel Weather_CreateSnow__FP7SVECTOR
    /* D3BBC 800E33BC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D3BC0 800E33C0 1800AA27 */  addiu      $t2, $sp, 0x18
    /* D3BC4 800E33C4 03008B88 */  lwl        $t3, 0x3($a0)
    /* D3BC8 800E33C8 00008B98 */  lwr        $t3, 0x0($a0)
    /* D3BCC 800E33CC 07008C88 */  lwl        $t4, 0x7($a0)
    /* D3BD0 800E33D0 04008C98 */  lwr        $t4, 0x4($a0)
    /* D3BD4 800E33D4 0300ABAB */  swl        $t3, 0x3($sp)
    /* D3BD8 800E33D8 0000ABBB */  swr        $t3, 0x0($sp)
    /* D3BDC 800E33DC 0700ACAB */  swl        $t4, 0x7($sp)
    /* D3BE0 800E33E0 0400ACBB */  swr        $t4, 0x4($sp)
    /* D3BE4 800E33E4 0300AB8B */  lwl        $t3, 0x3($sp)
    /* D3BE8 800E33E8 0000AB9B */  lwr        $t3, 0x0($sp)
    /* D3BEC 800E33EC 0700AC8B */  lwl        $t4, 0x7($sp)
    /* D3BF0 800E33F0 0400AC9B */  lwr        $t4, 0x4($sp)
    /* D3BF4 800E33F4 0B00ABAB */  swl        $t3, 0xB($sp)
    /* D3BF8 800E33F8 0800ABBB */  swr        $t3, 0x8($sp)
    /* D3BFC 800E33FC 0F00ACAB */  swl        $t4, 0xF($sp)
    /* D3C00 800E3400 0C00ACBB */  swr        $t4, 0xC($sp)
    /* D3C04 800E3404 0B00AB8B */  lwl        $t3, 0xB($sp)
    /* D3C08 800E3408 0800AB9B */  lwr        $t3, 0x8($sp)
    /* D3C0C 800E340C 0F00AC8B */  lwl        $t4, 0xF($sp)
    /* D3C10 800E3410 0C00AC9B */  lwr        $t4, 0xC($sp)
    /* D3C14 800E3414 1300ABAB */  swl        $t3, 0x13($sp)
    /* D3C18 800E3418 1000ABBB */  swr        $t3, 0x10($sp)
    /* D3C1C 800E341C 1700ACAB */  swl        $t4, 0x17($sp)
    /* D3C20 800E3420 1400ACBB */  swr        $t4, 0x14($sp)
    /* D3C24 800E3424 0800A297 */  lhu        $v0, 0x8($sp)
    /* D3C28 800E3428 1200A397 */  lhu        $v1, 0x12($sp)
    /* D3C2C 800E342C 0A004224 */  addiu      $v0, $v0, 0xA
    /* D3C30 800E3430 F6FF6324 */  addiu      $v1, $v1, -0xA
    /* D3C34 800E3434 0800A2A7 */  sh         $v0, 0x8($sp)
    /* D3C38 800E3438 1200A3A7 */  sh         $v1, 0x12($sp)
    /* D3C3C 800E343C 0B00AB8B */  lwl        $t3, 0xB($sp)
    /* D3C40 800E3440 0800AB9B */  lwr        $t3, 0x8($sp)
    /* D3C44 800E3444 0F00AC8B */  lwl        $t4, 0xF($sp)
    /* D3C48 800E3448 0C00AC9B */  lwr        $t4, 0xC($sp)
    /* D3C4C 800E344C 1B00ABAB */  swl        $t3, 0x1B($sp)
    /* D3C50 800E3450 1800ABBB */  swr        $t3, 0x18($sp)
    /* D3C54 800E3454 1F00ACAB */  swl        $t4, 0x1F($sp)
    /* D3C58 800E3458 1C00ACBB */  swr        $t4, 0x1C($sp)
    /* D3C5C 800E345C 1200A297 */  lhu        $v0, 0x12($sp)
    /* D3C60 800E3460 0800A327 */  addiu      $v1, $sp, 0x8
    /* D3C64 800E3464 1A00A2A7 */  sh         $v0, 0x1A($sp)
    /* D3C68 800E3468 1000A227 */  addiu      $v0, $sp, 0x10
    /* D3C6C 800E346C 0000A0CB */  lwc2       $0, 0x0($sp)
    /* D3C70 800E3470 0400A1CB */  lwc2       $1, 0x4($sp)
    /* D3C74 800E3474 000062C8 */  lwc2       $2, 0x0($v1)
    /* D3C78 800E3478 040063C8 */  lwc2       $3, 0x4($v1)
    /* D3C7C 800E347C 000044C8 */  lwc2       $4, 0x0($v0)
    /* D3C80 800E3480 040045C8 */  lwc2       $5, 0x4($v0)
    /* D3C84 800E3484 00000000 */  nop
    /* D3C88 800E3488 00000000 */  nop
    /* D3C8C 800E348C 3000284A */  .word 0x4A280030  /* rtpt */
    /* D3C90 800E3490 801F093C */  lui        $t1, (0x1F800004 >> 16)
    /* D3C94 800E3494 04002935 */  ori        $t1, $t1, (0x1F800004 & 0xFFFF)
    /* D3C98 800E3498 FF00063C */  lui        $a2, (0xFFFFFF >> 16)
    /* D3C9C 800E349C FFFFC634 */  ori        $a2, $a2, (0xFFFFFF & 0xFFFF)
    /* D3CA0 800E34A0 00FF083C */  lui        $t0, (0xFF000000 >> 16)
    /* D3CA4 800E34A4 0000258D */  lw         $a1, 0x0($t1)
    /* D3CA8 800E34A8 801F073C */  lui        $a3, (0x1F800000 >> 16)
    /* D3CAC 800E34AC 0000E78C */  lw         $a3, (0x1F800000 & 0xFFFF)($a3)
    /* D3CB0 800E34B0 0000A38C */  lw         $v1, 0x0($a1)
    /* D3CB4 800E34B4 0000E28C */  lw         $v0, 0x0($a3)
    /* D3CB8 800E34B8 24186800 */  and        $v1, $v1, $t0
    /* D3CBC 800E34BC 24104600 */  and        $v0, $v0, $a2
    /* D3CC0 800E34C0 25186200 */  or         $v1, $v1, $v0
    /* D3CC4 800E34C4 0000A3AC */  sw         $v1, 0x0($a1)
    /* D3CC8 800E34C8 2800A324 */  addiu      $v1, $a1, 0x28
    /* D3CCC 800E34CC 0000E28C */  lw         $v0, 0x0($a3)
    /* D3CD0 800E34D0 2430A600 */  and        $a2, $a1, $a2
    /* D3CD4 800E34D4 000023AD */  sw         $v1, 0x0($t1)
    /* D3CD8 800E34D8 1000A324 */  addiu      $v1, $a1, 0x10
    /* D3CDC 800E34DC 24104800 */  and        $v0, $v0, $t0
    /* D3CE0 800E34E0 25104600 */  or         $v0, $v0, $a2
    /* D3CE4 800E34E4 0000E2AC */  sw         $v0, 0x0($a3)
    /* D3CE8 800E34E8 09000224 */  addiu      $v0, $zero, 0x9
    /* D3CEC 800E34EC 0800A624 */  addiu      $a2, $a1, 0x8
    /* D3CF0 800E34F0 0300A2A0 */  sb         $v0, 0x3($a1)
    /* D3CF4 800E34F4 1800A224 */  addiu      $v0, $a1, 0x18
    /* D3CF8 800E34F8 0000CCE8 */  swc2       $12, 0x0($a2)
    /* D3CFC 800E34FC 00006DE8 */  swc2       $13, 0x0($v1)
    /* D3D00 800E3500 00004EE8 */  swc2       $14, 0x0($v0)
    /* D3D04 800E3504 000040C9 */  lwc2       $0, 0x0($t2)
    /* D3D08 800E3508 040041C9 */  lwc2       $1, 0x4($t2)
    /* D3D0C 800E350C 00000000 */  nop
    /* D3D10 800E3510 00000000 */  nop
    /* D3D14 800E3514 0100184A */  .word 0x4A180001  /* rtps */
    /* D3D18 800E3518 202E023C */  lui        $v0, (0x2E202020 >> 16)
    /* D3D1C 800E351C 20204234 */  ori        $v0, $v0, (0x2E202020 & 0xFFFF)
    /* D3D20 800E3520 0400A2AC */  sw         $v0, 0x4($a1)
    /* D3D24 800E3524 2000A224 */  addiu      $v0, $a1, 0x20
    /* D3D28 800E3528 00004EE8 */  swc2       $14, 0x0($v0)
    /* D3D2C 800E352C 1180023C */  lui        $v0, %hi(gWeatherPixmap)
    /* D3D30 800E3530 7C2B4224 */  addiu      $v0, $v0, %lo(gWeatherPixmap)
    /* D3D34 800E3534 04008430 */  andi       $a0, $a0, 0x4
    /* D3D38 800E3538 21208200 */  addu       $a0, $a0, $v0
    /* D3D3C 800E353C 0000828C */  lw         $v0, 0x0($a0)
    /* D3D40 800E3540 00000000 */  nop
    /* D3D44 800E3544 0000438C */  lw         $v1, 0x0($v0)
    /* D3D48 800E3548 0400448C */  lw         $a0, 0x4($v0)
    /* D3D4C 800E354C 0800468C */  lw         $a2, 0x8($v0)
    /* D3D50 800E3550 0C00428C */  lw         $v0, 0xC($v0)
    /* D3D54 800E3554 0C00A3AC */  sw         $v1, 0xC($a1)
    /* D3D58 800E3558 1400A4AC */  sw         $a0, 0x14($a1)
    /* D3D5C 800E355C 1C00A6AC */  sw         $a2, 0x1C($a1)
    /* D3D60 800E3560 2400A2AC */  sw         $v0, 0x24($a1)
    /* D3D64 800E3564 0800E003 */  jr         $ra
    /* D3D68 800E3568 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Weather_CreateSnow__FP7SVECTOR
