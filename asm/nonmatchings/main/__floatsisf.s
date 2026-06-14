.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __floatsisf, 0xB4

glabel __floatsisf
    /* E6A24 800F6224 21300000 */  addu       $a2, $zero, $zero
    /* E6A28 800F6228 03008014 */  bnez       $a0, .L800F6238
    /* E6A2C 800F622C 9D000324 */   addiu     $v1, $zero, 0x9D
    /* E6A30 800F6230 B4D80308 */  j          .L800F62D0
    /* E6A34 800F6234 21100000 */   addu      $v0, $zero, $zero
  .L800F6238:
    /* E6A38 800F6238 03008104 */  bgez       $a0, .L800F6248
    /* E6A3C 800F623C FF00023C */   lui       $v0, (0xFFFFFF >> 16)
    /* E6A40 800F6240 0080063C */  lui        $a2, (0x80000000 >> 16)
    /* E6A44 800F6244 23200400 */  negu       $a0, $a0
  .L800F6248:
    /* E6A48 800F6248 FFFF4234 */  ori        $v0, $v0, (0xFFFFFF & 0xFFFF)
    /* E6A4C 800F624C 2A104400 */  slt        $v0, $v0, $a0
    /* E6A50 800F6250 08004014 */  bnez       $v0, .L800F6274
    /* E6A54 800F6254 FF3F023C */   lui       $v0, (0x3FFFFFFF >> 16)
    /* E6A58 800F6258 FF00053C */  lui        $a1, (0xFFFFFF >> 16)
    /* E6A5C 800F625C FFFFA534 */  ori        $a1, $a1, (0xFFFFFF & 0xFFFF)
  .L800F6260:
    /* E6A60 800F6260 00210400 */  sll        $a0, $a0, 4
    /* E6A64 800F6264 2A10A400 */  slt        $v0, $a1, $a0
    /* E6A68 800F6268 FDFF4010 */  beqz       $v0, .L800F6260
    /* E6A6C 800F626C FCFF6324 */   addiu     $v1, $v1, -0x4
    /* E6A70 800F6270 FF3F023C */  lui        $v0, (0x3FFFFFFF >> 16)
  .L800F6274:
    /* E6A74 800F6274 FFFF4234 */  ori        $v0, $v0, (0x3FFFFFFF & 0xFFFF)
    /* E6A78 800F6278 2A104400 */  slt        $v0, $v0, $a0
    /* E6A7C 800F627C 07004014 */  bnez       $v0, .L800F629C
    /* E6A80 800F6280 00000000 */   nop
    /* E6A84 800F6284 FF3F053C */  lui        $a1, (0x3FFFFFFF >> 16)
    /* E6A88 800F6288 FFFFA534 */  ori        $a1, $a1, (0x3FFFFFFF & 0xFFFF)
  .L800F628C:
    /* E6A8C 800F628C 40200400 */  sll        $a0, $a0, 1
    /* E6A90 800F6290 2A10A400 */  slt        $v0, $a1, $a0
    /* E6A94 800F6294 FDFF4010 */  beqz       $v0, .L800F628C
    /* E6A98 800F6298 FFFF6324 */   addiu     $v1, $v1, -0x1
  .L800F629C:
    /* E6A9C 800F629C 40008424 */  addiu      $a0, $a0, 0x40
    /* E6AA0 800F62A0 04008104 */  bgez       $a0, .L800F62B4
    /* E6AA4 800F62A4 00000000 */   nop
    /* E6AA8 800F62A8 01006324 */  addiu      $v1, $v1, 0x1
    /* E6AAC 800F62AC AED80308 */  j          .L800F62B8
    /* E6AB0 800F62B0 02220400 */   srl       $a0, $a0, 8
  .L800F62B4:
    /* E6AB4 800F62B4 C2210400 */  srl        $a0, $a0, 7
  .L800F62B8:
    /* E6AB8 800F62B8 C0150300 */  sll        $v0, $v1, 23
    /* E6ABC 800F62BC 2518C200 */  or         $v1, $a2, $v0
    /* E6AC0 800F62C0 7FFF023C */  lui        $v0, (0xFF7FFFFF >> 16)
    /* E6AC4 800F62C4 FFFF4234 */  ori        $v0, $v0, (0xFF7FFFFF & 0xFFFF)
    /* E6AC8 800F62C8 24108200 */  and        $v0, $a0, $v0
    /* E6ACC 800F62CC 25106200 */  or         $v0, $v1, $v0
  .L800F62D0:
    /* E6AD0 800F62D0 0800E003 */  jr         $ra
    /* E6AD4 800F62D4 00000000 */   nop
endlabel __floatsisf
    /* E6AD8 800F62D8 00000000 */  nop
    /* E6ADC 800F62DC 00000000 */  nop
    /* E6AE0 800F62E0 00000000 */  nop
