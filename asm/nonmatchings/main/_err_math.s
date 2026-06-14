.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _err_math, 0x64

glabel _err_math
    /* F7254 80106A54 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F7258 80106A58 21000224 */  addiu      $v0, $zero, 0x21
    /* F725C 80106A5C 1000BFAF */  sw         $ra, 0x10($sp)
    /* F7260 80106A60 1480013C */  lui        $at, %hi(math_errno)
    /* F7264 80106A64 18BF24AC */  sw         $a0, %lo(math_errno)($at)
    /* F7268 80106A68 1480013C */  lui        $at, %hi(math_err_point)
    /* F726C 80106A6C 06008210 */  beq        $a0, $v0, .L80106A88
    /* F7270 80106A70 1CBF25AC */   sw        $a1, %lo(math_err_point)($at)
    /* F7274 80106A74 22000224 */  addiu      $v0, $zero, 0x22
    /* F7278 80106A78 07008210 */  beq        $a0, $v0, .L80106A98
    /* F727C 80106A7C 00F4043C */   lui       $a0, (0xF4000002 >> 16)
    /* F7280 80106A80 AA1A0408 */  j          .L80106AA8
    /* F7284 80106A84 00000000 */   nop
  .L80106A88:
    /* F7288 80106A88 00F4043C */  lui        $a0, (0xF4000002 >> 16)
    /* F728C 80106A8C 02008434 */  ori        $a0, $a0, (0xF4000002 & 0xFFFF)
    /* F7290 80106A90 A81A0408 */  j          .L80106AA0
    /* F7294 80106A94 01030524 */   addiu     $a1, $zero, 0x301
  .L80106A98:
    /* F7298 80106A98 02008434 */  ori        $a0, $a0, (0xF4000002 & 0xFFFF)
    /* F729C 80106A9C 02030524 */  addiu      $a1, $zero, 0x302
  .L80106AA0:
    /* F72A0 80106AA0 BE31040C */  jal        DeliverEvent
    /* F72A4 80106AA4 00000000 */   nop
  .L80106AA8:
    /* F72A8 80106AA8 1000BF8F */  lw         $ra, 0x10($sp)
    /* F72AC 80106AAC 21100000 */  addu       $v0, $zero, $zero
    /* F72B0 80106AB0 0800E003 */  jr         $ra
    /* F72B4 80106AB4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel _err_math
    /* F72B8 80106AB8 00000000 */  nop
    /* F72BC 80106ABC 00000000 */  nop
    /* F72C0 80106AC0 00000000 */  nop
