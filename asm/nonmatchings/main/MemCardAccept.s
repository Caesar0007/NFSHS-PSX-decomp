.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MemCardAccept, 0x68

glabel MemCardAccept
    /* EB5C4 800FADC4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* EB5C8 800FADC8 1480033C */  lui        $v1, %hi(D_80147518)
    /* EB5CC 800FADCC 18756324 */  addiu      $v1, $v1, %lo(D_80147518)
    /* EB5D0 800FADD0 1000BFAF */  sw         $ra, 0x10($sp)
    /* EB5D4 800FADD4 0000628C */  lw         $v0, 0x0($v1)
    /* EB5D8 800FADD8 00000000 */  nop
    /* EB5DC 800FADDC 0B00401C */  bgtz       $v0, .L800FAE0C
    /* EB5E0 800FADE0 21288000 */   addu      $a1, $a0, $zero
    /* EB5E4 800FADE4 1080043C */  lui        $a0, %hi(MemCardCmd_cb)
    /* EB5E8 800FADE8 2CAE8424 */  addiu      $a0, $a0, %lo(MemCardCmd_cb)
    /* EB5EC 800FADEC 02000224 */  addiu      $v0, $zero, 0x2
    /* EB5F0 800FADF0 000062AC */  sw         $v0, 0x0($v1)
    /* EB5F4 800FADF4 040060AC */  sw         $zero, 0x4($v1)
    /* EB5F8 800FADF8 080060AC */  sw         $zero, 0x8($v1)
    /* EB5FC 800FADFC 0427040C */  jal        UserFuncOpen
    /* EB600 800FAE00 0C0065AC */   sw        $a1, 0xC($v1)
    /* EB604 800FAE04 87EB0308 */  j          .L800FAE1C
    /* EB608 800FAE08 01000224 */   addiu     $v0, $zero, 0x1
  .L800FAE0C:
    /* EB60C 800FAE0C 0580043C */  lui        $a0, %hi(D_80057370)
    /* EB610 800FAE10 2B0A040C */  jal        printf
    /* EB614 800FAE14 70738424 */   addiu     $a0, $a0, %lo(D_80057370)
    /* EB618 800FAE18 21100000 */  addu       $v0, $zero, $zero
  .L800FAE1C:
    /* EB61C 800FAE1C 1000BF8F */  lw         $ra, 0x10($sp)
    /* EB620 800FAE20 1800BD27 */  addiu      $sp, $sp, 0x18
    /* EB624 800FAE24 0800E003 */  jr         $ra
    /* EB628 800FAE28 00000000 */   nop
endlabel MemCardAccept
