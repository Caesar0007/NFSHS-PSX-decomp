.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FECheat_ActivateCheat__FPc, 0x108

glabel FECheat_ActivateCheat__FPc
    /* 13E14 80023614 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 13E18 80023618 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 13E1C 8002361C 21880000 */  addu       $s1, $zero, $zero
    /* 13E20 80023620 1000A527 */  addiu      $a1, $sp, 0x10
    /* 13E24 80023624 2400BFAF */  sw         $ra, 0x24($sp)
    /* 13E28 80023628 2000B2AF */  sw         $s2, 0x20($sp)
    /* 13E2C 8002362C 048D000C */  jal        FECheat_EncodeString__FPcT0
    /* 13E30 80023630 1800B0AF */   sw        $s0, 0x18($sp)
    /* 13E34 80023634 21902002 */  addu       $s2, $s1, $zero
    /* 13E38 80023638 0580023C */  lui        $v0, %hi(D_80051628)
    /* 13E3C 8002363C 28164824 */  addiu      $t0, $v0, %lo(D_80051628)
    /* 13E40 80023640 1000A727 */  addiu      $a3, $sp, 0x10
    /* 13E44 80023644 21302002 */  addu       $a2, $s1, $zero
  .L80023648:
    /* 13E48 80023648 0A00422A */  slti       $v0, $s2, 0xA
    /* 13E4C 8002364C 2C004010 */  beqz       $v0, .L80023700
    /* 13E50 80023650 21280000 */   addu      $a1, $zero, $zero
    /* 13E54 80023654 2110A600 */  addu       $v0, $a1, $a2
  .L80023658:
    /* 13E58 80023658 21104800 */  addu       $v0, $v0, $t0
    /* 13E5C 8002365C 2118E500 */  addu       $v1, $a3, $a1
    /* 13E60 80023660 00004490 */  lbu        $a0, 0x0($v0)
    /* 13E64 80023664 00006290 */  lbu        $v0, 0x0($v1)
    /* 13E68 80023668 00000000 */  nop
    /* 13E6C 8002366C 06008214 */  bne        $a0, $v0, .L80023688
    /* 13E70 80023670 08000224 */   addiu     $v0, $zero, 0x8
    /* 13E74 80023674 0100A524 */  addiu      $a1, $a1, 0x1
    /* 13E78 80023678 0800A228 */  slti       $v0, $a1, 0x8
    /* 13E7C 8002367C F6FF4014 */  bnez       $v0, .L80023658
    /* 13E80 80023680 2110A600 */   addu      $v0, $a1, $a2
    /* 13E84 80023684 08000224 */  addiu      $v0, $zero, 0x8
  .L80023688:
    /* 13E88 80023688 0300A210 */  beq        $a1, $v0, .L80023698
    /* 13E8C 8002368C 0C00C624 */   addiu     $a2, $a2, 0xC
    /* 13E90 80023690 928D0008 */  j          .L80023648
    /* 13E94 80023694 01005226 */   addiu     $s2, $s2, 0x1
  .L80023698:
    /* 13E98 80023698 81E5010C */  jal        AudioCmn_PlayFESFX__Fi
    /* 13E9C 8002369C 1A000424 */   addiu     $a0, $zero, 0x1A
    /* 13EA0 800236A0 0580113C */  lui        $s1, %hi(FEApp)
    /* 13EA4 800236A4 C014308E */  lw         $s0, %lo(FEApp)($s1)
    /* 13EA8 800236A8 7A020424 */  addiu      $a0, $zero, 0x27A
    /* 13EAC 800236AC 94E4020C */  jal        TextSys_Word__Fi
    /* 13EB0 800236B0 38021026 */   addiu     $s0, $s0, 0x238
    /* 13EB4 800236B4 C014248E */  lw         $a0, %lo(FEApp)($s1)
    /* 13EB8 800236B8 900002AE */  sw         $v0, 0x90($s0)
    /* 13EBC 800236BC 1062000C */  jal        Display__11tDialogBase
    /* 13EC0 800236C0 38028424 */   addiu     $a0, $a0, 0x238
    /* 13EC4 800236C4 0580023C */  lui        $v0, %hi(D_80051628)
    /* 13EC8 800236C8 28164224 */  addiu      $v0, $v0, %lo(D_80051628)
    /* 13ECC 800236CC 40801200 */  sll        $s0, $s2, 1
    /* 13ED0 800236D0 21801202 */  addu       $s0, $s0, $s2
    /* 13ED4 800236D4 80801000 */  sll        $s0, $s0, 2
    /* 13ED8 800236D8 21800202 */  addu       $s0, $s0, $v0
    /* 13EDC 800236DC 0800048E */  lw         $a0, 0x8($s0)
    /* 13EE0 800236E0 908C000C */  jal        func_80023240
    /* 13EE4 800236E4 01001124 */   addiu     $s1, $zero, 0x1
    /* 13EE8 800236E8 1480043C */  lui        $a0, %hi(gFECheats)
    /* 13EEC 800236EC 0800028E */  lw         $v0, 0x8($s0)
    /* 13EF0 800236F0 78D2838C */  lw         $v1, %lo(gFECheats)($a0)
    /* 13EF4 800236F4 04105100 */  sllv       $v0, $s1, $v0
    /* 13EF8 800236F8 25186200 */  or         $v1, $v1, $v0
    /* 13EFC 800236FC 78D283AC */  sw         $v1, %lo(gFECheats)($a0)
  .L80023700:
    /* 13F00 80023700 21102002 */  addu       $v0, $s1, $zero
    /* 13F04 80023704 2400BF8F */  lw         $ra, 0x24($sp)
    /* 13F08 80023708 2000B28F */  lw         $s2, 0x20($sp)
    /* 13F0C 8002370C 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 13F10 80023710 1800B08F */  lw         $s0, 0x18($sp)
    /* 13F14 80023714 0800E003 */  jr         $ra
    /* 13F18 80023718 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel FECheat_ActivateCheat__FPc
