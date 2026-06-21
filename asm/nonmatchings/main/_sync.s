.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _sync, 0x13C

glabel _sync
    /* E01BC 800EF9BC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E01C0 800EF9C0 1400BFAF */  sw         $ra, 0x14($sp)
    /* E01C4 800EF9C4 2A008014 */  bnez       $a0, .L800EFA70
    /* E01C8 800EF9C8 1000B0AF */   sw        $s0, 0x10($sp)
    /* E01CC 800EF9CC BEBE030C */  jal        _gpu_arm_timeout
    /* E01D0 800EF9D0 00000000 */   nop
    /* E01D4 800EF9D4 7DBE0308 */  j          .L800EF9F4
    /* E01D8 800EF9D8 00000000 */   nop
  .L800EF9DC:
    /* E01DC 800EF9DC 83BD030C */  jal        _gpu_que_drain
    /* E01E0 800EF9E0 00000000 */   nop
    /* E01E4 800EF9E4 CBBE030C */  jal        _gpu_check_timeout
    /* E01E8 800EF9E8 00000000 */   nop
    /* E01EC 800EF9EC 3E004014 */  bnez       $v0, .L800EFAE8
    /* E01F0 800EF9F0 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L800EF9F4:
    /* E01F4 800EF9F4 1280033C */  lui        $v1, %hi(_qin)
    /* E01F8 800EF9F8 C437638C */  lw         $v1, %lo(_qin)($v1)
    /* E01FC 800EF9FC 1280023C */  lui        $v0, %hi(_qout)
    /* E0200 800EFA00 C837428C */  lw         $v0, %lo(_qout)($v0)
    /* E0204 800EFA04 00000000 */  nop
    /* E0208 800EFA08 07006210 */  beq        $v1, $v0, .L800EFA28
    /* E020C 800EFA0C 00000000 */   nop
    /* E0210 800EFA10 77BE0308 */  j          .L800EF9DC
    /* E0214 800EFA14 00000000 */   nop
  .L800EFA18:
    /* E0218 800EFA18 CBBE030C */  jal        _gpu_check_timeout
    /* E021C 800EFA1C 00000000 */   nop
    /* E0220 800EFA20 31004014 */  bnez       $v0, .L800EFAE8
    /* E0224 800EFA24 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L800EFA28:
    /* E0228 800EFA28 1280023C */  lui        $v0, %hi(D_801237B0)
    /* E022C 800EFA2C B037428C */  lw         $v0, %lo(D_801237B0)($v0)
    /* E0230 800EFA30 00000000 */  nop
    /* E0234 800EFA34 0000428C */  lw         $v0, 0x0($v0)
    /* E0238 800EFA38 0001033C */  lui        $v1, (0x1000000 >> 16)
    /* E023C 800EFA3C 24104300 */  and        $v0, $v0, $v1
    /* E0240 800EFA40 F5FF4014 */  bnez       $v0, .L800EFA18
    /* E0244 800EFA44 00000000 */   nop
    /* E0248 800EFA48 1280023C */  lui        $v0, %hi(D_801237A4)
    /* E024C 800EFA4C A437428C */  lw         $v0, %lo(D_801237A4)($v0)
    /* E0250 800EFA50 00000000 */  nop
    /* E0254 800EFA54 0000428C */  lw         $v0, 0x0($v0)
    /* E0258 800EFA58 0004033C */  lui        $v1, (0x4000000 >> 16)
    /* E025C 800EFA5C 24104300 */  and        $v0, $v0, $v1
    /* E0260 800EFA60 EDFF4010 */  beqz       $v0, .L800EFA18
    /* E0264 800EFA64 21100000 */   addu      $v0, $zero, $zero
    /* E0268 800EFA68 BABE0308 */  j          .L800EFAE8
    /* E026C 800EFA6C 00000000 */   nop
  .L800EFA70:
    /* E0270 800EFA70 1280023C */  lui        $v0, %hi(_qin)
    /* E0274 800EFA74 C437428C */  lw         $v0, %lo(_qin)($v0)
    /* E0278 800EFA78 1280033C */  lui        $v1, %hi(_qout)
    /* E027C 800EFA7C C837638C */  lw         $v1, %lo(_qout)($v1)
    /* E0280 800EFA80 00000000 */  nop
    /* E0284 800EFA84 23104300 */  subu       $v0, $v0, $v1
    /* E0288 800EFA88 3F005030 */  andi       $s0, $v0, 0x3F
    /* E028C 800EFA8C 03000012 */  beqz       $s0, .L800EFA9C
    /* E0290 800EFA90 00000000 */   nop
    /* E0294 800EFA94 83BD030C */  jal        _gpu_que_drain
    /* E0298 800EFA98 00000000 */   nop
  .L800EFA9C:
    /* E029C 800EFA9C 1280023C */  lui        $v0, %hi(D_801237B0)
    /* E02A0 800EFAA0 B037428C */  lw         $v0, %lo(D_801237B0)($v0)
    /* E02A4 800EFAA4 00000000 */  nop
    /* E02A8 800EFAA8 0000428C */  lw         $v0, 0x0($v0)
    /* E02AC 800EFAAC 0001033C */  lui        $v1, (0x1000000 >> 16)
    /* E02B0 800EFAB0 24104300 */  and        $v0, $v0, $v1
    /* E02B4 800EFAB4 09004014 */  bnez       $v0, .L800EFADC
    /* E02B8 800EFAB8 00000000 */   nop
    /* E02BC 800EFABC 1280023C */  lui        $v0, %hi(D_801237A4)
    /* E02C0 800EFAC0 A437428C */  lw         $v0, %lo(D_801237A4)($v0)
    /* E02C4 800EFAC4 00000000 */  nop
    /* E02C8 800EFAC8 0000428C */  lw         $v0, 0x0($v0)
    /* E02CC 800EFACC 0004033C */  lui        $v1, (0x4000000 >> 16)
    /* E02D0 800EFAD0 24104300 */  and        $v0, $v0, $v1
    /* E02D4 800EFAD4 04004014 */  bnez       $v0, .L800EFAE8
    /* E02D8 800EFAD8 21100002 */   addu      $v0, $s0, $zero
  .L800EFADC:
    /* E02DC 800EFADC 02000016 */  bnez       $s0, .L800EFAE8
    /* E02E0 800EFAE0 21100002 */   addu      $v0, $s0, $zero
    /* E02E4 800EFAE4 01000224 */  addiu      $v0, $zero, 0x1
  .L800EFAE8:
    /* E02E8 800EFAE8 1400BF8F */  lw         $ra, 0x14($sp)
    /* E02EC 800EFAEC 1000B08F */  lw         $s0, 0x10($sp)
    /* E02F0 800EFAF0 0800E003 */  jr         $ra
    /* E02F4 800EFAF4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel _sync
