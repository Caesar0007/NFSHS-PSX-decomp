.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorld_OpenContext__Fii, 0xB8

glabel BWorld_OpenContext__Fii
    /* 6ECAC 8007E4AC 21308000 */  addu       $a2, $a0, $zero
    /* 6ECB0 8007E4B0 1180043C */  lui        $a0, %hi(gContextMan)
    /* 6ECB4 8007E4B4 ACEE8424 */  addiu      $a0, $a0, %lo(gContextMan)
    /* 6ECB8 8007E4B8 0400838C */  lw         $v1, 0x4($a0)
    /* 6ECBC 8007E4BC 08008424 */  addiu      $a0, $a0, 0x8
    /* 6ECC0 8007E4C0 80100300 */  sll        $v0, $v1, 2
    /* 6ECC4 8007E4C4 21104300 */  addu       $v0, $v0, $v1
    /* 6ECC8 8007E4C8 C0100200 */  sll        $v0, $v0, 3
    /* 6ECCC 8007E4CC 23104300 */  subu       $v0, $v0, $v1
    /* 6ECD0 8007E4D0 80100200 */  sll        $v0, $v0, 2
    /* 6ECD4 8007E4D4 21204400 */  addu       $a0, $v0, $a0
    /* 6ECD8 8007E4D8 040080A4 */  sh         $zero, 0x4($a0)
    /* 6ECDC 8007E4DC 0600C010 */  beqz       $a2, .L8007E4F8
    /* 6ECE0 8007E4E0 000085AC */   sw        $a1, 0x0($a0)
    /* 6ECE4 8007E4E4 01000224 */  addiu      $v0, $zero, 0x1
    /* 6ECE8 8007E4E8 0C00C210 */  beq        $a2, $v0, .L8007E51C
    /* 6ECEC 8007E4EC 1180033C */   lui       $v1, %hi(gContextMan)
    /* 6ECF0 8007E4F0 53F90108 */  j          .L8007E54C
    /* 6ECF4 8007E4F4 ACEE6324 */   addiu     $v1, $v1, %lo(gContextMan)
  .L8007E4F8:
    /* 6ECF8 8007E4F8 0C00033C */  lui        $v1, (0xCEA40 >> 16)
    /* 6ECFC 8007E4FC 40EA6334 */  ori        $v1, $v1, (0xCEA40 & 0xFFFF)
    /* 6ED00 8007E500 0900023C */  lui        $v0, (0x9C400 >> 16)
    /* 6ED04 8007E504 00C44234 */  ori        $v0, $v0, (0x9C400 & 0xFFFF)
    /* 6ED08 8007E508 900082AC */  sw         $v0, 0x90($a0)
    /* 6ED0C 8007E50C 904C0224 */  addiu      $v0, $zero, 0x4C90
    /* 6ED10 8007E510 980082AC */  sw         $v0, 0x98($a0)
    /* 6ED14 8007E514 4FF90108 */  j          .L8007E53C
    /* 6ED18 8007E518 00E10234 */   ori       $v0, $zero, 0xE100
  .L8007E51C:
    /* 6ED1C 8007E51C 0500033C */  lui        $v1, (0x52210 >> 16)
    /* 6ED20 8007E520 10226334 */  ori        $v1, $v1, (0x52210 & 0xFFFF)
    /* 6ED24 8007E524 0400023C */  lui        $v0, (0x44944 >> 16)
    /* 6ED28 8007E528 44494234 */  ori        $v0, $v0, (0x44944 & 0xFFFF)
    /* 6ED2C 8007E52C 900082AC */  sw         $v0, 0x90($a0)
    /* 6ED30 8007E530 10270224 */  addiu      $v0, $zero, 0x2710
    /* 6ED34 8007E534 980082AC */  sw         $v0, 0x98($a0)
    /* 6ED38 8007E538 048D0234 */  ori        $v0, $zero, 0x8D04
  .L8007E53C:
    /* 6ED3C 8007E53C 8C0083AC */  sw         $v1, 0x8C($a0)
    /* 6ED40 8007E540 940082AC */  sw         $v0, 0x94($a0)
    /* 6ED44 8007E544 1180033C */  lui        $v1, %hi(gContextMan)
    /* 6ED48 8007E548 ACEE6324 */  addiu      $v1, $v1, %lo(gContextMan)
  .L8007E54C:
    /* 6ED4C 8007E54C 0400648C */  lw         $a0, 0x4($v1)
    /* 6ED50 8007E550 00000000 */  nop
    /* 6ED54 8007E554 21108000 */  addu       $v0, $a0, $zero
    /* 6ED58 8007E558 01008424 */  addiu      $a0, $a0, 0x1
    /* 6ED5C 8007E55C 0800E003 */  jr         $ra
    /* 6ED60 8007E560 040064AC */   sw        $a0, 0x4($v1)
endlabel BWorld_OpenContext__Fii
