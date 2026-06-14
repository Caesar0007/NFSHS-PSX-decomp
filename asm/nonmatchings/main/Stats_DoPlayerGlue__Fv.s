.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Stats_DoPlayerGlue__Fv, 0x1BC

glabel Stats_DoPlayerGlue__Fv
    /* A8758 800B7F58 1480023C */  lui        $v0, %hi(Cars_gNumRaceCars)
    /* A875C 800B7F5C F8C7428C */  lw         $v0, %lo(Cars_gNumRaceCars)($v0)
    /* A8760 800B7F60 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* A8764 800B7F64 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* A8768 800B7F68 63001324 */  addiu      $s3, $zero, 0x63
    /* A876C 800B7F6C 1400B1AF */  sw         $s1, 0x14($sp)
    /* A8770 800B7F70 21880000 */  addu       $s1, $zero, $zero
    /* A8774 800B7F74 2000BFAF */  sw         $ra, 0x20($sp)
    /* A8778 800B7F78 1800B2AF */  sw         $s2, 0x18($sp)
    /* A877C 800B7F7C 19004018 */  blez       $v0, .L800B7FE4
    /* A8780 800B7F80 1000B0AF */   sw        $s0, 0x10($sp)
    /* A8784 800B7F84 1280023C */  lui        $v0, %hi(Stats_racePosition)
    /* A8788 800B7F88 E0E05224 */  addiu      $s2, $v0, %lo(Stats_racePosition)
    /* A878C 800B7F8C 1180023C */  lui        $v0, %hi(Cars_gRaceCarList)
    /* A8790 800B7F90 00FA5024 */  addiu      $s0, $v0, %lo(Cars_gRaceCarList)
  .L800B7F94:
    /* A8794 800B7F94 0000048E */  lw         $a0, 0x0($s0)
    /* A8798 800B7F98 55E0020C */  jal        Stats_GetPosition__FP8Car_tObj
    /* A879C 800B7F9C 00000000 */   nop
    /* A87A0 800B7FA0 0000038E */  lw         $v1, 0x0($s0)
    /* A87A4 800B7FA4 00000000 */  nop
    /* A87A8 800B7FA8 880362AC */  sw         $v0, 0x388($v1)
    /* A87AC 800B7FAC 0C00428E */  lw         $v0, 0xC($s2)
    /* A87B0 800B7FB0 00000000 */  nop
    /* A87B4 800B7FB4 04004010 */  beqz       $v0, .L800B7FC8
    /* A87B8 800B7FB8 63000224 */   addiu     $v0, $zero, 0x63
    /* A87BC 800B7FBC 02006216 */  bne        $s3, $v0, .L800B7FC8
    /* A87C0 800B7FC0 00000000 */   nop
    /* A87C4 800B7FC4 21982002 */  addu       $s3, $s1, $zero
  .L800B7FC8:
    /* A87C8 800B7FC8 10005226 */  addiu      $s2, $s2, 0x10
    /* A87CC 800B7FCC 1480023C */  lui        $v0, %hi(Cars_gNumRaceCars)
    /* A87D0 800B7FD0 F8C7428C */  lw         $v0, %lo(Cars_gNumRaceCars)($v0)
    /* A87D4 800B7FD4 01003126 */  addiu      $s1, $s1, 0x1
    /* A87D8 800B7FD8 2A102202 */  slt        $v0, $s1, $v0
    /* A87DC 800B7FDC EDFF4014 */  bnez       $v0, .L800B7F94
    /* A87E0 800B7FE0 04001026 */   addiu     $s0, $s0, 0x4
  .L800B7FE4:
    /* A87E4 800B7FE4 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* A87E8 800B7FE8 EC314324 */  addiu      $v1, $v0, %lo(GameSetup_gData)
    /* A87EC 800B7FEC 2000628C */  lw         $v0, 0x20($v1)
    /* A87F0 800B7FF0 00000000 */  nop
    /* A87F4 800B7FF4 40004010 */  beqz       $v0, .L800B80F8
    /* A87F8 800B7FF8 01000224 */   addiu     $v0, $zero, 0x1
    /* A87FC 800B7FFC 0C00638C */  lw         $v1, 0xC($v1)
    /* A8800 800B8000 00000000 */  nop
    /* A8804 800B8004 3C006214 */  bne        $v1, $v0, .L800B80F8
    /* A8808 800B8008 1180023C */   lui       $v0, %hi(Cars_gHumanRaceCarList)
    /* A880C 800B800C 48FA448C */  lw         $a0, %lo(Cars_gHumanRaceCarList)($v0)
    /* A8810 800B8010 48FA4524 */  addiu      $a1, $v0, %lo(Cars_gHumanRaceCarList)
    /* A8814 800B8014 9003828C */  lw         $v0, 0x390($a0)
    /* A8818 800B8018 02000324 */  addiu      $v1, $zero, 0x2
    /* A881C 800B801C 07004310 */  beq        $v0, $v1, .L800B803C
    /* A8820 800B8020 00000000 */   nop
    /* A8824 800B8024 0400A28C */  lw         $v0, 0x4($a1)
    /* A8828 800B8028 00000000 */  nop
    /* A882C 800B802C 9003428C */  lw         $v0, 0x390($v0)
    /* A8830 800B8030 00000000 */  nop
    /* A8834 800B8034 06004314 */  bne        $v0, $v1, .L800B8050
    /* A8838 800B8038 00000000 */   nop
  .L800B803C:
    /* A883C 800B803C 0100033C */  lui        $v1, (0x10000 >> 16)
    /* A8840 800B8040 700283AC */  sw         $v1, 0x270($a0)
    /* A8844 800B8044 0400A28C */  lw         $v0, 0x4($a1)
    /* A8848 800B8048 3EE00208 */  j          .L800B80F8
    /* A884C 800B804C 700243AC */   sw        $v1, 0x270($v0)
  .L800B8050:
    /* A8850 800B8050 1480023C */  lui        $v0, %hi(Cars_gNumHumanRaceCars)
    /* A8854 800B8054 00C8428C */  lw         $v0, %lo(Cars_gNumHumanRaceCars)($v0)
    /* A8858 800B8058 00000000 */  nop
    /* A885C 800B805C 26004018 */  blez       $v0, .L800B80F8
    /* A8860 800B8060 21880000 */   addu      $s1, $zero, $zero
    /* A8864 800B8064 1280023C */  lui        $v0, %hi(Stats_racePosition)
    /* A8868 800B8068 E0E04224 */  addiu      $v0, $v0, %lo(Stats_racePosition)
    /* A886C 800B806C 00191300 */  sll        $v1, $s3, 4
    /* A8870 800B8070 21306200 */  addu       $a2, $v1, $v0
    /* A8874 800B8074 0100073C */  lui        $a3, (0x10000 >> 16)
  .L800B8078:
    /* A8878 800B8078 0000A48C */  lw         $a0, 0x0($a1)
    /* A887C 800B807C 0400C28C */  lw         $v0, 0x4($a2)
    /* A8880 800B8080 5003838C */  lw         $v1, 0x350($a0)
    /* A8884 800B8084 00000000 */  nop
    /* A8888 800B8088 23184300 */  subu       $v1, $v0, $v1
    /* A888C 800B808C 05006228 */  slti       $v0, $v1, 0x5
    /* A8890 800B8090 03004010 */  beqz       $v0, .L800B80A0
    /* A8894 800B8094 0A006228 */   slti      $v0, $v1, 0xA
    /* A8898 800B8098 38E00208 */  j          .L800B80E0
    /* A889C 800B809C 700287AC */   sw        $a3, 0x270($a0)
  .L800B80A0:
    /* A88A0 800B80A0 03004010 */  beqz       $v0, .L800B80B0
    /* A88A4 800B80A4 0100023C */   lui       $v0, (0x10666 >> 16)
    /* A88A8 800B80A8 37E00208 */  j          .L800B80DC
    /* A88AC 800B80AC 66064234 */   ori       $v0, $v0, (0x10666 & 0xFFFF)
  .L800B80B0:
    /* A88B0 800B80B0 1E006228 */  slti       $v0, $v1, 0x1E
    /* A88B4 800B80B4 03004010 */  beqz       $v0, .L800B80C4
    /* A88B8 800B80B8 0100023C */   lui       $v0, (0x10CCC >> 16)
    /* A88BC 800B80BC 37E00208 */  j          .L800B80DC
    /* A88C0 800B80C0 CC0C4234 */   ori       $v0, $v0, (0x10CCC & 0xFFFF)
  .L800B80C4:
    /* A88C4 800B80C4 3C006228 */  slti       $v0, $v1, 0x3C
    /* A88C8 800B80C8 03004010 */  beqz       $v0, .L800B80D8
    /* A88CC 800B80CC 0100023C */   lui       $v0, (0x11333 >> 16)
    /* A88D0 800B80D0 37E00208 */  j          .L800B80DC
    /* A88D4 800B80D4 33134234 */   ori       $v0, $v0, (0x11333 & 0xFFFF)
  .L800B80D8:
    /* A88D8 800B80D8 99194234 */  ori        $v0, $v0, (0x11999 & 0xFFFF)
  .L800B80DC:
    /* A88DC 800B80DC 700282AC */  sw         $v0, 0x270($a0)
  .L800B80E0:
    /* A88E0 800B80E0 1480023C */  lui        $v0, %hi(Cars_gNumHumanRaceCars)
    /* A88E4 800B80E4 00C8428C */  lw         $v0, %lo(Cars_gNumHumanRaceCars)($v0)
    /* A88E8 800B80E8 01003126 */  addiu      $s1, $s1, 0x1
    /* A88EC 800B80EC 2A102202 */  slt        $v0, $s1, $v0
    /* A88F0 800B80F0 E1FF4014 */  bnez       $v0, .L800B8078
    /* A88F4 800B80F4 0400A524 */   addiu     $a1, $a1, 0x4
  .L800B80F8:
    /* A88F8 800B80F8 2000BF8F */  lw         $ra, 0x20($sp)
    /* A88FC 800B80FC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* A8900 800B8100 1800B28F */  lw         $s2, 0x18($sp)
    /* A8904 800B8104 1400B18F */  lw         $s1, 0x14($sp)
    /* A8908 800B8108 1000B08F */  lw         $s0, 0x10($sp)
    /* A890C 800B810C 0800E003 */  jr         $ra
    /* A8910 800B8110 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Stats_DoPlayerGlue__Fv
