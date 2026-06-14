.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorld_InitSpikeBelt__Fv, 0xAC

glabel BWorld_InitSpikeBelt__Fv
    /* 6E018 8007D818 FF7F073C */  lui        $a3, (0x7FFFFFFF >> 16)
    /* 6E01C 8007D81C FFFFE734 */  ori        $a3, $a3, (0x7FFFFFFF & 0xFFFF)
    /* 6E020 8007D820 FFFF0924 */  addiu      $t1, $zero, -0x1
    /* 6E024 8007D824 21280000 */  addu       $a1, $zero, $zero
    /* 6E028 8007D828 14800A3C */  lui        $t2, %hi(Chunk_numLight)
    /* 6E02C 8007D82C ECD44A8D */  lw         $t2, %lo(Chunk_numLight)($t2)
    /* 6E030 8007D830 1480043C */  lui        $a0, %hi(Chunk_lightTable)
    /* 6E034 8007D834 18C8848C */  lw         $a0, %lo(Chunk_lightTable)($a0)
    /* 6E038 8007D838 80000824 */  addiu      $t0, $zero, 0x80
    /* 6E03C 8007D83C 480280AF */  sw         $zero, %gp_rel(gSpikeBelt)($gp)
    /* 6E040 8007D840 4C0280AF */  sw         $zero, %gp_rel(gSpikeBeltSlice)($gp)
    /* 6E044 8007D844 500280AF */  sw         $zero, %gp_rel(gSpikeBeltChunk)($gp)
  .L8007D848:
    /* 6E048 8007D848 2A10AA00 */  slt        $v0, $a1, $t2
    /* 6E04C 8007D84C 1A004010 */  beqz       $v0, .L8007D8B8
    /* 6E050 8007D850 00000000 */   nop
    /* 6E054 8007D854 00008290 */  lbu        $v0, 0x0($a0)
    /* 6E058 8007D858 00000000 */  nop
    /* 6E05C 8007D85C 23100201 */  subu       $v0, $t0, $v0
    /* 6E060 8007D860 18004200 */  mult       $v0, $v0
    /* 6E064 8007D864 01008290 */  lbu        $v0, 0x1($a0)
    /* 6E068 8007D868 12300000 */  mflo       $a2
    /* 6E06C 8007D86C 23100201 */  subu       $v0, $t0, $v0
    /* 6E070 8007D870 00000000 */  nop
    /* 6E074 8007D874 18004200 */  mult       $v0, $v0
    /* 6E078 8007D878 02008290 */  lbu        $v0, 0x2($a0)
    /* 6E07C 8007D87C 12180000 */  mflo       $v1
    /* 6E080 8007D880 23100201 */  subu       $v0, $t0, $v0
    /* 6E084 8007D884 00000000 */  nop
    /* 6E088 8007D888 18004200 */  mult       $v0, $v0
    /* 6E08C 8007D88C 2110C300 */  addu       $v0, $a2, $v1
    /* 6E090 8007D890 12600000 */  mflo       $t4
    /* 6E094 8007D894 21184C00 */  addu       $v1, $v0, $t4
    /* 6E098 8007D898 2A106700 */  slt        $v0, $v1, $a3
    /* 6E09C 8007D89C 03004010 */  beqz       $v0, .L8007D8AC
    /* 6E0A0 8007D8A0 00000000 */   nop
    /* 6E0A4 8007D8A4 21386000 */  addu       $a3, $v1, $zero
    /* 6E0A8 8007D8A8 2148A000 */  addu       $t1, $a1, $zero
  .L8007D8AC:
    /* 6E0AC 8007D8AC 04008424 */  addiu      $a0, $a0, 0x4
    /* 6E0B0 8007D8B0 12F60108 */  j          .L8007D848
    /* 6E0B4 8007D8B4 0100A524 */   addiu     $a1, $a1, 0x1
  .L8007D8B8:
    /* 6E0B8 8007D8B8 640289AF */  sw         $t1, %gp_rel(gSpikeBeltColourTableIndex)($gp)
    /* 6E0BC 8007D8BC 0800E003 */  jr         $ra
    /* 6E0C0 8007D8C0 00000000 */   nop
endlabel BWorld_InitSpikeBelt__Fv
