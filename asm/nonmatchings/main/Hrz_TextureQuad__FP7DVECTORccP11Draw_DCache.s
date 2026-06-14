.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hrz_TextureQuad__FP7DVECTORccP11Draw_DCache, 0x130

glabel Hrz_TextureQuad__FP7DVECTORccP11Draw_DCache
    /* C0C04 800D0404 801F0C3C */  lui        $t4, (0x1F800004 >> 16)
    /* C0C08 800D0408 04008C35 */  ori        $t4, $t4, (0x1F800004 & 0xFFFF)
    /* C0C0C 800D040C FF00093C */  lui        $t1, (0xFFFFFF >> 16)
    /* C0C10 800D0410 FFFF2935 */  ori        $t1, $t1, (0xFFFFFF & 0xFFFF)
    /* C0C14 800D0414 00FF0B3C */  lui        $t3, (0xFF000000 >> 16)
    /* C0C18 800D0418 9400E28C */  lw         $v0, 0x94($a3)
    /* C0C1C 800D041C 801F0A3C */  lui        $t2, (0x1F800000 >> 16)
    /* C0C20 800D0420 00004A8D */  lw         $t2, (0x1F800000 & 0xFFFF)($t2)
    /* C0C24 800D0424 0000888D */  lw         $t0, 0x0($t4)
    /* C0C28 800D0428 80100200 */  sll        $v0, $v0, 2
    /* C0C2C 800D042C 21104A00 */  addu       $v0, $v0, $t2
    /* C0C30 800D0430 0000038D */  lw         $v1, 0x0($t0)
    /* C0C34 800D0434 0000428C */  lw         $v0, 0x0($v0)
    /* C0C38 800D0438 24186B00 */  and        $v1, $v1, $t3
    /* C0C3C 800D043C 24104900 */  and        $v0, $v0, $t1
    /* C0C40 800D0440 25186200 */  or         $v1, $v1, $v0
    /* C0C44 800D0444 000003AD */  sw         $v1, 0x0($t0)
    /* C0C48 800D0448 9400E78C */  lw         $a3, 0x94($a3)
    /* C0C4C 800D044C 28000325 */  addiu      $v1, $t0, 0x28
    /* C0C50 800D0450 80380700 */  sll        $a3, $a3, 2
    /* C0C54 800D0454 2138EA00 */  addu       $a3, $a3, $t2
    /* C0C58 800D0458 0000E28C */  lw         $v0, 0x0($a3)
    /* C0C5C 800D045C 24480901 */  and        $t1, $t0, $t1
    /* C0C60 800D0460 000083AD */  sw         $v1, 0x0($t4)
    /* C0C64 800D0464 24104B00 */  and        $v0, $v0, $t3
    /* C0C68 800D0468 25104900 */  or         $v0, $v0, $t1
    /* C0C6C 800D046C 0000E2AC */  sw         $v0, 0x0($a3)
    /* C0C70 800D0470 09000224 */  addiu      $v0, $zero, 0x9
    /* C0C74 800D0474 030002A1 */  sb         $v0, 0x3($t0)
    /* C0C78 800D0478 2E000224 */  addiu      $v0, $zero, 0x2E
    /* C0C7C 800D047C 070002A1 */  sb         $v0, 0x7($t0)
    /* C0C80 800D0480 060006A1 */  sb         $a2, 0x6($t0)
    /* C0C84 800D0484 050006A1 */  sb         $a2, 0x5($t0)
    /* C0C88 800D0488 040006A1 */  sb         $a2, 0x4($t0)
    /* C0C8C 800D048C 00008294 */  lhu        $v0, 0x0($a0)
    /* C0C90 800D0490 00000000 */  nop
    /* C0C94 800D0494 080002A5 */  sh         $v0, 0x8($t0)
    /* C0C98 800D0498 02008294 */  lhu        $v0, 0x2($a0)
    /* C0C9C 800D049C 00000000 */  nop
    /* C0CA0 800D04A0 0A0002A5 */  sh         $v0, 0xA($t0)
    /* C0CA4 800D04A4 00008294 */  lhu        $v0, 0x0($a0)
    /* C0CA8 800D04A8 00000000 */  nop
    /* C0CAC 800D04AC 180002A5 */  sh         $v0, 0x18($t0)
    /* C0CB0 800D04B0 02008294 */  lhu        $v0, 0x2($a0)
    /* C0CB4 800D04B4 00000000 */  nop
    /* C0CB8 800D04B8 10004224 */  addiu      $v0, $v0, 0x10
    /* C0CBC 800D04BC 1A0002A5 */  sh         $v0, 0x1A($t0)
    /* C0CC0 800D04C0 00008294 */  lhu        $v0, 0x0($a0)
    /* C0CC4 800D04C4 00000000 */  nop
    /* C0CC8 800D04C8 10004224 */  addiu      $v0, $v0, 0x10
    /* C0CCC 800D04CC 100002A5 */  sh         $v0, 0x10($t0)
    /* C0CD0 800D04D0 02008294 */  lhu        $v0, 0x2($a0)
    /* C0CD4 800D04D4 00000000 */  nop
    /* C0CD8 800D04D8 120002A5 */  sh         $v0, 0x12($t0)
    /* C0CDC 800D04DC 00008294 */  lhu        $v0, 0x0($a0)
    /* C0CE0 800D04E0 FF00A530 */  andi       $a1, $a1, 0xFF
    /* C0CE4 800D04E4 10004224 */  addiu      $v0, $v0, 0x10
    /* C0CE8 800D04E8 200002A5 */  sh         $v0, 0x20($t0)
    /* C0CEC 800D04EC 02008294 */  lhu        $v0, 0x2($a0)
    /* C0CF0 800D04F0 80280500 */  sll        $a1, $a1, 2
    /* C0CF4 800D04F4 10004224 */  addiu      $v0, $v0, 0x10
    /* C0CF8 800D04F8 220002A5 */  sh         $v0, 0x22($t0)
    /* C0CFC 800D04FC 1180023C */  lui        $v0, %hi(gLightningPixmap)
    /* C0D00 800D0500 942B4224 */  addiu      $v0, $v0, %lo(gLightningPixmap)
    /* C0D04 800D0504 2128A200 */  addu       $a1, $a1, $v0
    /* C0D08 800D0508 0000A28C */  lw         $v0, 0x0($a1)
    /* C0D0C 800D050C 00000000 */  nop
    /* C0D10 800D0510 0000438C */  lw         $v1, 0x0($v0)
    /* C0D14 800D0514 0400448C */  lw         $a0, 0x4($v0)
    /* C0D18 800D0518 0800458C */  lw         $a1, 0x8($v0)
    /* C0D1C 800D051C 0C00428C */  lw         $v0, 0xC($v0)
    /* C0D20 800D0520 0C0003AD */  sw         $v1, 0xC($t0)
    /* C0D24 800D0524 140004AD */  sw         $a0, 0x14($t0)
    /* C0D28 800D0528 1C0005AD */  sw         $a1, 0x1C($t0)
    /* C0D2C 800D052C 0800E003 */  jr         $ra
    /* C0D30 800D0530 240002AD */   sw        $v0, 0x24($t0)
endlabel Hrz_TextureQuad__FP7DVECTORccP11Draw_DCache
