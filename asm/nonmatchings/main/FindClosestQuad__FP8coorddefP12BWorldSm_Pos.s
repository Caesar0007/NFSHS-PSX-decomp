.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FindClosestQuad__FP8coorddefP12BWorldSm_Pos, 0x1CC

glabel FindClosestQuad__FP8coorddefP12BWorldSm_Pos
    /* 700F8 8007F8F8 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 700FC 8007F8FC 1800B2AF */  sw         $s2, 0x18($sp)
    /* 70100 8007F900 1000B0AF */  sw         $s0, 0x10($sp)
    /* 70104 8007F904 2180A000 */  addu       $s0, $a1, $zero
    /* 70108 8007F908 2800BFAF */  sw         $ra, 0x28($sp)
    /* 7010C 8007F90C 2400B5AF */  sw         $s5, 0x24($sp)
    /* 70110 8007F910 2000B4AF */  sw         $s4, 0x20($sp)
    /* 70114 8007F914 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 70118 8007F918 1400B1AF */  sw         $s1, 0x14($sp)
    /* 7011C 8007F91C 00001486 */  lh         $s4, 0x0($s0)
    /* 70120 8007F920 74001582 */  lb         $s5, 0x74($s0)
    /* 70124 8007F924 85FA010C */  jal        BWorldSm_FindClosestSlice__FP8coorddefP12BWorldSm_Pos
    /* 70128 8007F928 21908000 */   addu      $s2, $a0, $zero
    /* 7012C 8007F92C 21204002 */  addu       $a0, $s2, $zero
    /* 70130 8007F930 00001186 */  lh         $s1, 0x0($s0)
    /* 70134 8007F934 53FC010C */  jal        RawFindClosestQuad__FP8coorddefP12BWorldSm_Pos
    /* 70138 8007F938 21280002 */   addu      $a1, $s0, $zero
    /* 7013C 8007F93C 4D004014 */  bnez       $v0, .L8007FA74
    /* 70140 8007F940 21200000 */   addu      $a0, $zero, $zero
    /* 70144 8007F944 5A000282 */  lb         $v0, 0x5A($s0)
    /* 70148 8007F948 00000000 */  nop
    /* 7014C 8007F94C 1D004010 */  beqz       $v0, .L8007F9C4
    /* 70150 8007F950 21200002 */   addu      $a0, $s0, $zero
    /* 70154 8007F954 0DFC010C */  jal        BWorld_SetSimSlice__FP12BWorldSm_Pos
    /* 70158 8007F958 000011A6 */   sh        $s1, 0x0($s0)
    /* 7015C 8007F95C 5A000382 */  lb         $v1, 0x5A($s0)
    /* 70160 8007F960 01000224 */  addiu      $v0, $zero, 0x1
    /* 70164 8007F964 06006210 */  beq        $v1, $v0, .L8007F980
    /* 70168 8007F968 00000000 */   nop
    /* 7016C 8007F96C 8000028E */  lw         $v0, 0x80($s0)
    /* 70170 8007F970 00000000 */  nop
    /* 70174 8007F974 01004290 */  lbu        $v0, 0x1($v0)
    /* 70178 8007F978 61FE0108 */  j          .L8007F984
    /* 7017C 8007F97C FFFF4224 */   addiu     $v0, $v0, -0x1
  .L8007F980:
    /* 70180 8007F980 21100000 */  addu       $v0, $zero, $zero
  .L8007F984:
    /* 70184 8007F984 21200002 */  addu       $a0, $s0, $zero
    /* 70188 8007F988 25FC010C */  jal        BworldSm_UpdateSimQuad__FP12BWorldSm_Pos
    /* 7018C 8007F98C 740002A2 */   sb        $v0, 0x74($s0)
    /* 70190 8007F990 21200002 */  addu       $a0, $s0, $zero
    /* 70194 8007F994 02000224 */  addiu      $v0, $zero, 0x2
    /* 70198 8007F998 B8FB010C */  jal        SetStrip__FP12BWorldSm_Pos
    /* 7019C 8007F99C 770002A2 */   sb        $v0, 0x77($s0)
    /* 701A0 8007F9A0 75000292 */  lbu        $v0, 0x75($s0)
    /* 701A4 8007F9A4 21200002 */  addu       $a0, $s0, $zero
    /* 701A8 8007F9A8 40280200 */  sll        $a1, $v0, 1
    /* 701AC 8007F9AC 2128A200 */  addu       $a1, $a1, $v0
    /* 701B0 8007F9B0 1480023C */  lui        $v0, %hi(Chunk_chunkCenters)
    /* 701B4 8007F9B4 1CC8428C */  lw         $v0, %lo(Chunk_chunkCenters)($v0)
    /* 701B8 8007F9B8 80280500 */  sll        $a1, $a1, 2
    /* 701BC 8007F9BC 6EFB010C */  jal        GetStmQuadPts__FP12BWorldSm_PosP8coorddef
    /* 701C0 8007F9C0 21284500 */   addu      $a1, $v0, $a1
  .L8007F9C4:
    /* 701C4 8007F9C4 1480033C */  lui        $v1, %hi(D_8013DFC4)
    /* 701C8 8007F9C8 C4DF6924 */  addiu      $t1, $v1, %lo(D_8013DFC4)
    /* 701CC 8007F9CC 0000468E */  lw         $a2, 0x0($s2)
    /* 701D0 8007F9D0 0400478E */  lw         $a3, 0x4($s2)
    /* 701D4 8007F9D4 0800488E */  lw         $t0, 0x8($s2)
    /* 701D8 8007F9D8 000026AD */  sw         $a2, 0x0($t1)
    /* 701DC 8007F9DC 040027AD */  sw         $a3, 0x4($t1)
    /* 701E0 8007F9E0 080028AD */  sw         $t0, 0x8($t1)
    /* 701E4 8007F9E4 7800028E */  lw         $v0, 0x78($s0)
    /* 701E8 8007F9E8 00000000 */  nop
    /* 701EC 8007F9EC 20004014 */  bnez       $v0, .L8007FA70
    /* 701F0 8007F9F0 21880000 */   addu      $s1, $zero, $zero
    /* 701F4 8007F9F4 21986000 */  addu       $s3, $v1, $zero
    /* 701F8 8007F9F8 C4DF7226 */  addiu      $s2, $s3, %lo(D_8013DFC4)
  .L8007F9FC:
    /* 701FC 8007F9FC 0A00222A */  slti       $v0, $s1, 0xA
    /* 70200 8007FA00 1B004010 */  beqz       $v0, .L8007FA70
    /* 70204 8007FA04 21204002 */   addu      $a0, $s2, $zero
    /* 70208 8007FA08 00000286 */  lh         $v0, 0x0($s0)
    /* 7020C 8007FA0C 7402858F */  lw         $a1, %gp_rel(BWorldSm_slices)($gp)
    /* 70210 8007FA10 C4DF638E */  lw         $v1, %lo(D_8013DFC4)($s3)
    /* 70214 8007FA14 40110200 */  sll        $v0, $v0, 5
    /* 70218 8007FA18 21104500 */  addu       $v0, $v0, $a1
    /* 7021C 8007FA1C 0000428C */  lw         $v0, 0x0($v0)
    /* 70220 8007FA20 00000000 */  nop
    /* 70224 8007FA24 23104300 */  subu       $v0, $v0, $v1
    /* 70228 8007FA28 43110200 */  sra        $v0, $v0, 5
    /* 7022C 8007FA2C 21186200 */  addu       $v1, $v1, $v0
    /* 70230 8007FA30 C4DF63AE */  sw         $v1, %lo(D_8013DFC4)($s3)
    /* 70234 8007FA34 00000286 */  lh         $v0, 0x0($s0)
    /* 70238 8007FA38 0800438E */  lw         $v1, 0x8($s2)
    /* 7023C 8007FA3C 40110200 */  sll        $v0, $v0, 5
    /* 70240 8007FA40 21104500 */  addu       $v0, $v0, $a1
    /* 70244 8007FA44 0800428C */  lw         $v0, 0x8($v0)
    /* 70248 8007FA48 21280002 */  addu       $a1, $s0, $zero
    /* 7024C 8007FA4C 23104300 */  subu       $v0, $v0, $v1
    /* 70250 8007FA50 43110200 */  sra        $v0, $v0, 5
    /* 70254 8007FA54 21186200 */  addu       $v1, $v1, $v0
    /* 70258 8007FA58 53FC010C */  jal        RawFindClosestQuad__FP8coorddefP12BWorldSm_Pos
    /* 7025C 8007FA5C 080043AE */   sw        $v1, 0x8($s2)
    /* 70260 8007FA60 7800028E */  lw         $v0, 0x78($s0)
    /* 70264 8007FA64 00000000 */  nop
    /* 70268 8007FA68 E4FF4010 */  beqz       $v0, .L8007F9FC
    /* 7026C 8007FA6C 01003126 */   addiu     $s1, $s1, 0x1
  .L8007FA70:
    /* 70270 8007FA70 21200000 */  addu       $a0, $zero, $zero
  .L8007FA74:
    /* 70274 8007FA74 00000286 */  lh         $v0, 0x0($s0)
    /* 70278 8007FA78 74000382 */  lb         $v1, 0x74($s0)
    /* 7027C 8007FA7C 26108202 */  xor        $v0, $s4, $v0
    /* 70280 8007FA80 2B100200 */  sltu       $v0, $zero, $v0
    /* 70284 8007FA84 0300A316 */  bne        $s5, $v1, .L8007FA94
    /* 70288 8007FA88 580002A2 */   sb        $v0, 0x58($s0)
    /* 7028C 8007FA8C 02004010 */  beqz       $v0, .L8007FA98
    /* 70290 8007FA90 00000000 */   nop
  .L8007FA94:
    /* 70294 8007FA94 01000424 */  addiu      $a0, $zero, 0x1
  .L8007FA98:
    /* 70298 8007FA98 58000282 */  lb         $v0, 0x58($s0)
    /* 7029C 8007FA9C 590004A2 */  sb         $a0, 0x59($s0)
    /* 702A0 8007FAA0 2800BF8F */  lw         $ra, 0x28($sp)
    /* 702A4 8007FAA4 2400B58F */  lw         $s5, 0x24($sp)
    /* 702A8 8007FAA8 2000B48F */  lw         $s4, 0x20($sp)
    /* 702AC 8007FAAC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 702B0 8007FAB0 1800B28F */  lw         $s2, 0x18($sp)
    /* 702B4 8007FAB4 1400B18F */  lw         $s1, 0x14($sp)
    /* 702B8 8007FAB8 1000B08F */  lw         $s0, 0x10($sp)
    /* 702BC 8007FABC 0800E003 */  jr         $ra
    /* 702C0 8007FAC0 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel FindClosestQuad__FP8coorddefP12BWorldSm_Pos
