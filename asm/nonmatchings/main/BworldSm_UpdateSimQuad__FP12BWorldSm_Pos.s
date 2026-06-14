.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BworldSm_UpdateSimQuad__FP12BWorldSm_Pos, 0x88

glabel BworldSm_UpdateSimQuad__FP12BWorldSm_Pos
    /* 6F894 8007F094 8000858C */  lw         $a1, 0x80($a0)
    /* 6F898 8007F098 74008380 */  lb         $v1, 0x74($a0)
    /* 6F89C 8007F09C 0400A290 */  lbu        $v0, 0x4($a1)
    /* 6F8A0 8007F0A0 00000000 */  nop
    /* 6F8A4 8007F0A4 23306200 */  subu       $a2, $v1, $v0
    /* 6F8A8 8007F0A8 1800C004 */  bltz       $a2, .L8007F10C
    /* 6F8AC 8007F0AC 00000000 */   nop
    /* 6F8B0 8007F0B0 0300A290 */  lbu        $v0, 0x3($a1)
    /* 6F8B4 8007F0B4 00000000 */  nop
    /* 6F8B8 8007F0B8 2A10C200 */  slt        $v0, $a2, $v0
    /* 6F8BC 8007F0BC 13004010 */  beqz       $v0, .L8007F10C
    /* 6F8C0 8007F0C0 00000000 */   nop
    /* 6F8C4 8007F0C4 75008390 */  lbu        $v1, 0x75($a0)
    /* 6F8C8 8007F0C8 00000000 */  nop
    /* 6F8CC 8007F0CC C0100300 */  sll        $v0, $v1, 3
    /* 6F8D0 8007F0D0 23104300 */  subu       $v0, $v0, $v1
    /* 6F8D4 8007F0D4 1480033C */  lui        $v1, %hi(Track_chunkList)
    /* 6F8D8 8007F0D8 B8D4638C */  lw         $v1, %lo(Track_chunkList)($v1)
    /* 6F8DC 8007F0DC 00110200 */  sll        $v0, $v0, 4
    /* 6F8E0 8007F0E0 21104300 */  addu       $v0, $v0, $v1
    /* 6F8E4 8007F0E4 4C00438C */  lw         $v1, 0x4C($v0)
    /* 6F8E8 8007F0E8 2110A000 */  addu       $v0, $a1, $zero
    /* 6F8EC 8007F0EC 04006324 */  addiu      $v1, $v1, 0x4
    /* 6F8F0 8007F0F0 780083AC */  sw         $v1, 0x78($a0)
    /* 6F8F4 8007F0F4 02004290 */  lbu        $v0, 0x2($v0)
    /* 6F8F8 8007F0F8 00000000 */  nop
    /* 6F8FC 8007F0FC 21104600 */  addu       $v0, $v0, $a2
    /* 6F900 8007F100 21186200 */  addu       $v1, $v1, $v0
    /* 6F904 8007F104 0800E003 */  jr         $ra
    /* 6F908 8007F108 780083AC */   sw        $v1, 0x78($a0)
  .L8007F10C:
    /* 6F90C 8007F10C 1480023C */  lui        $v0, %hi(GlobalSimQuad)
    /* 6F910 8007F110 BCC74224 */  addiu      $v0, $v0, %lo(GlobalSimQuad)
    /* 6F914 8007F114 0800E003 */  jr         $ra
    /* 6F918 8007F118 780082AC */   sw        $v0, 0x78($a0)
endlabel BworldSm_UpdateSimQuad__FP12BWorldSm_Pos
