.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GoNonInterlaced__7tScreen, 0xD0

glabel GoNonInterlaced__7tScreen
    /* 163F8 80025BF8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 163FC 80025BFC 1480083C */  lui        $t0, %hi(screenheight)
    /* 16400 80025C00 F0000224 */  addiu      $v0, $zero, 0xF0
    /* 16404 80025C04 8CDC02AD */  sw         $v0, %lo(screenheight)($t0)
    /* 16408 80025C08 1280023C */  lui        $v0, %hi(gEnviro)
    /* 1640C 80025C0C 24F44224 */  addiu      $v0, $v0, %lo(gEnviro)
    /* 16410 80025C10 00010724 */  addiu      $a3, $zero, 0x100
    /* 16414 80025C14 1280063C */  lui        $a2, %hi(Draw_gView)
    /* 16418 80025C18 8CDC0595 */  lhu        $a1, %lo(screenheight)($t0)
    /* 1641C 80025C1C 1480043C */  lui        $a0, %hi(Draw_gPlayer1View)
    /* 16420 80025C20 1000BFAF */  sw         $ra, 0x10($sp)
    /* 16424 80025C24 100040A0 */  sb         $zero, 0x10($v0)
    /* 16428 80025C28 280040A0 */  sb         $zero, 0x28($v0)
    /* 1642C 80025C2C CCD3838C */  lw         $v1, %lo(Draw_gPlayer1View)($a0)
    /* 16430 80025C30 54ECC624 */  addiu      $a2, $a2, %lo(Draw_gView)
    /* 16434 80025C34 020047A4 */  sh         $a3, 0x2($v0)
    /* 16438 80025C38 1A0040A4 */  sh         $zero, 0x1A($v0)
    /* 1643C 80025C3C 060045A4 */  sh         $a1, 0x6($v0)
    /* 16440 80025C40 0E0045A4 */  sh         $a1, 0xE($v0)
    /* 16444 80025C44 260045A4 */  sh         $a1, 0x26($v0)
    /* 16448 80025C48 40100300 */  sll        $v0, $v1, 1
    /* 1644C 80025C4C 21104300 */  addu       $v0, $v0, $v1
    /* 16450 80025C50 C0100200 */  sll        $v0, $v0, 3
    /* 16454 80025C54 21104300 */  addu       $v0, $v0, $v1
    /* 16458 80025C58 C0100200 */  sll        $v0, $v0, 3
    /* 1645C 80025C5C 21104600 */  addu       $v0, $v0, $a2
    /* 16460 80025C60 1F0040A0 */  sb         $zero, 0x1F($v0)
    /* 16464 80025C64 CCD3838C */  lw         $v1, %lo(Draw_gPlayer1View)($a0)
    /* 16468 80025C68 21200000 */  addu       $a0, $zero, $zero
    /* 1646C 80025C6C 0A0040A4 */  sh         $zero, 0xA($v0)
    /* 16470 80025C70 0E0045A4 */  sh         $a1, 0xE($v0)
    /* 16474 80025C74 100040A4 */  sh         $zero, 0x10($v0)
    /* 16478 80025C78 120040A4 */  sh         $zero, 0x12($v0)
    /* 1647C 80025C7C 40100300 */  sll        $v0, $v1, 1
    /* 16480 80025C80 21104300 */  addu       $v0, $v0, $v1
    /* 16484 80025C84 C0100200 */  sll        $v0, $v0, 3
    /* 16488 80025C88 21104300 */  addu       $v0, $v0, $v1
    /* 1648C 80025C8C C0100200 */  sll        $v0, $v0, 3
    /* 16490 80025C90 8CDC0395 */  lhu        $v1, %lo(screenheight)($t0)
    /* 16494 80025C94 21104600 */  addu       $v0, $v0, $a2
    /* 16498 80025C98 660047A4 */  sh         $a3, 0x66($v0)
    /* 1649C 80025C9C 6C0040A4 */  sh         $zero, 0x6C($v0)
    /* 164A0 80025CA0 6E0047A4 */  sh         $a3, 0x6E($v0)
    /* 164A4 80025CA4 7B0040A0 */  sb         $zero, 0x7B($v0)
    /* 164A8 80025CA8 1FB6030C */  jal        DrawSync
    /* 164AC 80025CAC 6A0043A4 */   sh        $v1, 0x6A($v0)
    /* 164B0 80025CB0 C7C8030C */  jal        VSync
    /* 164B4 80025CB4 21200000 */   addu      $a0, $zero, $zero
    /* 164B8 80025CB8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 164BC 80025CBC 00000000 */  nop
    /* 164C0 80025CC0 0800E003 */  jr         $ra
    /* 164C4 80025CC4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel GoNonInterlaced__7tScreen
