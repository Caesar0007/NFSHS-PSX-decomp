.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PadInitDirect, 0x160

glabel PadInitDirect
    /* EE528 800FDD28 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* EE52C 800FDD2C 1400B1AF */  sw         $s1, 0x14($sp)
    /* EE530 800FDD30 21888000 */  addu       $s1, $a0, $zero
    /* EE534 800FDD34 1800B2AF */  sw         $s2, 0x18($sp)
    /* EE538 800FDD38 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* EE53C 800FDD3C 1000B0AF */  sw         $s0, 0x10($sp)
    /* EE540 800FDD40 1380013C */  lui        $at, %hi(_padIntExec)
    /* EE544 800FDD44 B07C20AC */  sw         $zero, %lo(_padIntExec)($at)
    /* EE548 800FDD48 1380013C */  lui        $at, %hi(_padModeMtap)
    /* EE54C 800FDD4C C47C20AC */  sw         $zero, %lo(_padModeMtap)($at)
    /* EE550 800FDD50 2C28040C */  jal        _padInitDirSeq
    /* EE554 800FDD54 2190A000 */   addu      $s2, $a1, $zero
    /* EE558 800FDD58 1480103C */  lui        $s0, %hi(D_80147600)
    /* EE55C 800FDD5C 00761026 */  addiu      $s0, $s0, %lo(D_80147600)
    /* EE560 800FDD60 1080023C */  lui        $v0, %hi(func_800FDEF0)
    /* EE564 800FDD64 F0DE4224 */  addiu      $v0, $v0, %lo(func_800FDEF0)
    /* EE568 800FDD68 1380013C */  lui        $at, %hi(_padFuncNextPort)
    /* EE56C 800FDD6C 787C22AC */  sw         $v0, %lo(_padFuncNextPort)($at)
    /* EE570 800FDD70 1080023C */  lui        $v0, %hi(func_800FDE88)
    /* EE574 800FDD74 88DE4224 */  addiu      $v0, $v0, %lo(func_800FDE88)
    /* EE578 800FDD78 1380013C */  lui        $at, %hi(_padFuncClrInfo)
    /* EE57C 800FDD7C 7C7C22AC */  sw         $v0, %lo(_padFuncClrInfo)($at)
    /* EE580 800FDD80 1080023C */  lui        $v0, %hi(func_800FDFF4)
    /* EE584 800FDD84 F4DF4224 */  addiu      $v0, $v0, %lo(func_800FDFF4)
    /* EE588 800FDD88 1380013C */  lui        $at, %hi(_padFuncGetTxd)
    /* EE58C 800FDD8C 807C22AC */  sw         $v0, %lo(_padFuncGetTxd)($at)
    /* EE590 800FDD90 1080023C */  lui        $v0, %hi(func_800FE0B0)
    /* EE594 800FDD94 B0E04224 */  addiu      $v0, $v0, %lo(func_800FE0B0)
    /* EE598 800FDD98 1380013C */  lui        $at, %hi(_padFuncCurrLimit)
    /* EE59C 800FDD9C 847C22AC */  sw         $v0, %lo(_padFuncCurrLimit)($at)
    /* EE5A0 800FDDA0 1080023C */  lui        $v0, %hi(func_800FE32C)
    /* EE5A4 800FDDA4 2CE34224 */  addiu      $v0, $v0, %lo(func_800FE32C)
    /* EE5A8 800FDDA8 1380013C */  lui        $at, %hi(_padFuncPtr2Port)
    /* EE5AC 800FDDAC 887C22AC */  sw         $v0, %lo(_padFuncPtr2Port)($at)
    /* EE5B0 800FDDB0 1080023C */  lui        $v0, %hi(func_800FE364)
    /* EE5B4 800FDDB4 64E34224 */  addiu      $v0, $v0, %lo(func_800FE364)
    /* EE5B8 800FDDB8 1380013C */  lui        $at, %hi(_padFuncPort2Info)
    /* EE5BC 800FDDBC 8C7C22AC */  sw         $v0, %lo(_padFuncPort2Info)($at)
    /* EE5C0 800FDDC0 1080023C */  lui        $v0, %hi(func_800FDFE4)
    /* EE5C4 800FDDC4 E4DF4224 */  addiu      $v0, $v0, %lo(func_800FDFE4)
    /* EE5C8 800FDDC8 21200002 */  addu       $a0, $s0, $zero
    /* EE5CC 800FDDCC 1380013C */  lui        $at, %hi(_padInfoDir)
    /* EE5D0 800FDDD0 AC7C30AC */  sw         $s0, %lo(_padInfoDir)($at)
    /* EE5D4 800FDDD4 1380013C */  lui        $at, %hi(_padFuncClrCmdNo)
    /* EE5D8 800FDDD8 9C7C22AC */  sw         $v0, %lo(_padFuncClrCmdNo)($at)
    /* EE5DC 800FDDDC 5029040C */  jal        bzero
    /* EE5E0 800FDDE0 E0010524 */   addiu     $a1, $zero, 0x1E0
    /* EE5E4 800FDDE4 21400000 */  addu       $t0, $zero, $zero
    /* EE5E8 800FDDE8 FF000924 */  addiu      $t1, $zero, 0xFF
    /* EE5EC 800FDDEC 40000426 */  addiu      $a0, $s0, 0x40
    /* EE5F0 800FDDF0 1480073C */  lui        $a3, %hi(D_801475B8)
    /* EE5F4 800FDDF4 B875E724 */  addiu      $a3, $a3, %lo(D_801475B8)
    /* EE5F8 800FDDF8 1480063C */  lui        $a2, %hi(D_80147570)
    /* EE5FC 800FDDFC 7075C624 */  addiu      $a2, $a2, %lo(D_80147570)
    /* EE600 800FDE00 300011AE */  sw         $s1, 0x30($s0)
    /* EE604 800FDE04 200112AE */  sw         $s2, 0x120($s0)
  .L800FDE08:
    /* EE608 800FDE08 F0FF828C */  lw         $v0, -0x10($a0)
    /* EE60C 800FDE0C 5D000526 */  addiu      $a1, $s0, 0x5D
    /* EE610 800FDE10 CCFF80AC */  sw         $zero, -0x34($a0)
    /* EE614 800FDE14 D0FF90AC */  sw         $s0, -0x30($a0)
    /* EE618 800FDE18 000049A0 */  sb         $t1, 0x0($v0)
    /* EE61C 800FDE1C F0FF828C */  lw         $v0, -0x10($a0)
    /* EE620 800FDE20 05000324 */  addiu      $v1, $zero, 0x5
    /* EE624 800FDE24 010040A0 */  sb         $zero, 0x1($v0)
    /* EE628 800FDE28 FCFF86AC */  sw         $a2, -0x4($a0)
    /* EE62C 800FDE2C 000087AC */  sw         $a3, 0x0($a0)
  .L800FDE30:
    /* EE630 800FDE30 0000A9A0 */  sb         $t1, 0x0($a1)
    /* EE634 800FDE34 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* EE638 800FDE38 FDFF6104 */  bgez       $v1, .L800FDE30
    /* EE63C 800FDE3C 0100A524 */   addiu     $a1, $a1, 0x1
    /* EE640 800FDE40 2300E724 */  addiu      $a3, $a3, 0x23
    /* EE644 800FDE44 2300C624 */  addiu      $a2, $a2, 0x23
    /* EE648 800FDE48 01000825 */  addiu      $t0, $t0, 0x1
    /* EE64C 800FDE4C F0008424 */  addiu      $a0, $a0, 0xF0
    /* EE650 800FDE50 02000229 */  slti       $v0, $t0, 0x2
    /* EE654 800FDE54 ECFF4014 */  bnez       $v0, .L800FDE08
    /* EE658 800FDE58 F0001026 */   addiu     $s0, $s0, 0xF0
    /* EE65C 800FDE5C 8712040C */  jal        _padSetVsyncParam
    /* EE660 800FDE60 00000000 */   nop
    /* EE664 800FDE64 01000224 */  addiu      $v0, $zero, 0x1
    /* EE668 800FDE68 1380013C */  lui        $at, %hi(_padIntExec)
    /* EE66C 800FDE6C B07C22AC */  sw         $v0, %lo(_padIntExec)($at)
    /* EE670 800FDE70 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* EE674 800FDE74 1800B28F */  lw         $s2, 0x18($sp)
    /* EE678 800FDE78 1400B18F */  lw         $s1, 0x14($sp)
    /* EE67C 800FDE7C 1000B08F */  lw         $s0, 0x10($sp)
    /* EE680 800FDE80 0800E003 */  jr         $ra
    /* EE684 800FDE84 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel PadInitDirect
