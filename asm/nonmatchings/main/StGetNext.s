.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching StGetNext, 0xB8

glabel StGetNext
    /* EA228 800F9A28 21388000 */  addu       $a3, $a0, $zero
    /* EA22C 800F9A2C 1480023C */  lui        $v0, %hi(StRingIdx3)
    /* EA230 800F9A30 B86C428C */  lw         $v0, %lo(StRingIdx3)($v0)
    /* EA234 800F9A34 1480033C */  lui        $v1, %hi(StRingAddr)
    /* EA238 800F9A38 AC6C638C */  lw         $v1, %lo(StRingAddr)($v1)
    /* EA23C 800F9A3C 40110200 */  sll        $v0, $v0, 5
    /* EA240 800F9A40 21306200 */  addu       $a2, $v1, $v0
    /* EA244 800F9A44 0000C394 */  lhu        $v1, 0x0($a2)
    /* EA248 800F9A48 01000224 */  addiu      $v0, $zero, 0x1
    /* EA24C 800F9A4C 0D006214 */  bne        $v1, $v0, .L800F9A84
    /* EA250 800F9A50 2140A000 */   addu      $t0, $a1, $zero
    /* EA254 800F9A54 1480023C */  lui        $v0, %hi(StEndFrame)
    /* EA258 800F9A58 946C428C */  lw         $v0, %lo(StEndFrame)($v0)
    /* EA25C 800F9A5C 1480013C */  lui        $at, %hi(StRingIdx3)
    /* EA260 800F9A60 02004010 */  beqz       $v0, .L800F9A6C
    /* EA264 800F9A64 B86C20AC */   sw        $zero, %lo(StRingIdx3)($at)
    /* EA268 800F9A68 0000C0A4 */  sh         $zero, 0x0($a2)
  .L800F9A6C:
    /* EA26C 800F9A6C 1480023C */  lui        $v0, %hi(StRingIdx3)
    /* EA270 800F9A70 B86C428C */  lw         $v0, %lo(StRingIdx3)($v0)
    /* EA274 800F9A74 1480033C */  lui        $v1, %hi(StRingAddr)
    /* EA278 800F9A78 AC6C638C */  lw         $v1, %lo(StRingAddr)($v1)
    /* EA27C 800F9A7C 40110200 */  sll        $v0, $v0, 5
    /* EA280 800F9A80 21306200 */  addu       $a2, $v1, $v0
  .L800F9A84:
    /* EA284 800F9A84 0000C394 */  lhu        $v1, 0x0($a2)
    /* EA288 800F9A88 02000224 */  addiu      $v0, $zero, 0x2
    /* EA28C 800F9A8C 12006214 */  bne        $v1, $v0, .L800F9AD8
    /* EA290 800F9A90 01000224 */   addiu     $v0, $zero, 0x1
    /* EA294 800F9A94 04000224 */  addiu      $v0, $zero, 0x4
    /* EA298 800F9A98 0000C2A4 */  sh         $v0, 0x0($a2)
    /* EA29C 800F9A9C 21100000 */  addu       $v0, $zero, $zero
    /* EA2A0 800F9AA0 1480033C */  lui        $v1, %hi(StRingSize)
    /* EA2A4 800F9AA4 BC6C638C */  lw         $v1, %lo(StRingSize)($v1)
    /* EA2A8 800F9AA8 1480043C */  lui        $a0, %hi(StRingAddr)
    /* EA2AC 800F9AAC AC6C848C */  lw         $a0, %lo(StRingAddr)($a0)
    /* EA2B0 800F9AB0 1480053C */  lui        $a1, %hi(StRingIdx3)
    /* EA2B4 800F9AB4 B86CA58C */  lw         $a1, %lo(StRingIdx3)($a1)
    /* EA2B8 800F9AB8 40190300 */  sll        $v1, $v1, 5
    /* EA2BC 800F9ABC 21208300 */  addu       $a0, $a0, $v1
    /* EA2C0 800F9AC0 80190500 */  sll        $v1, $a1, 6
    /* EA2C4 800F9AC4 23186500 */  subu       $v1, $v1, $a1
    /* EA2C8 800F9AC8 40190300 */  sll        $v1, $v1, 5
    /* EA2CC 800F9ACC 21208300 */  addu       $a0, $a0, $v1
    /* EA2D0 800F9AD0 0000E4AC */  sw         $a0, 0x0($a3)
    /* EA2D4 800F9AD4 000006AD */  sw         $a2, 0x0($t0)
  .L800F9AD8:
    /* EA2D8 800F9AD8 0800E003 */  jr         $ra
    /* EA2DC 800F9ADC 00000000 */   nop
endlabel StGetNext
    /* EA2E0 800F9AE0 00000000 */  nop
    /* EA2E4 800F9AE4 00000000 */  nop
