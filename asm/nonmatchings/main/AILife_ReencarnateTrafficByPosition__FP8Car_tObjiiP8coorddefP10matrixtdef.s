.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AILife_ReencarnateTrafficByPosition__FP8Car_tObjiiP8coorddefP10matrixtdef, 0x20C

glabel AILife_ReencarnateTrafficByPosition__FP8Car_tObjiiP8coorddefP10matrixtdef
    /* 58794 80067F94 B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* 58798 80067F98 3000B0AF */  sw         $s0, 0x30($sp)
    /* 5879C 80067F9C 21808000 */  addu       $s0, $a0, $zero
    /* 587A0 80067FA0 4000B4AF */  sw         $s4, 0x40($sp)
    /* 587A4 80067FA4 21A0A000 */  addu       $s4, $a1, $zero
    /* 587A8 80067FA8 3C00B3AF */  sw         $s3, 0x3C($sp)
    /* 587AC 80067FAC 2198C000 */  addu       $s3, $a2, $zero
    /* 587B0 80067FB0 4400B5AF */  sw         $s5, 0x44($sp)
    /* 587B4 80067FB4 21A8E000 */  addu       $s5, $a3, $zero
    /* 587B8 80067FB8 1000A427 */  addiu      $a0, $sp, 0x10
    /* 587BC 80067FBC 21280000 */  addu       $a1, $zero, $zero
    /* 587C0 80067FC0 3800B2AF */  sw         $s2, 0x38($sp)
    /* 587C4 80067FC4 6000B28F */  lw         $s2, 0x60($sp)
    /* 587C8 80067FC8 0C000624 */  addiu      $a2, $zero, 0xC
    /* 587CC 80067FCC 4800BFAF */  sw         $ra, 0x48($sp)
    /* 587D0 80067FD0 C690030C */  jal        memset
    /* 587D4 80067FD4 3400B1AF */   sw        $s1, 0x34($sp)
    /* 587D8 80067FD8 2000B127 */  addiu      $s1, $sp, 0x20
    /* 587DC 80067FDC 21202002 */  addu       $a0, $s1, $zero
    /* 587E0 80067FE0 21280000 */  addu       $a1, $zero, $zero
    /* 587E4 80067FE4 C690030C */  jal        memset
    /* 587E8 80067FE8 0C000624 */   addiu     $a2, $zero, 0xC
    /* 587EC 80067FEC 1480023C */  lui        $v0, %hi(fastRandom)
    /* 587F0 80067FF0 FCD0428C */  lw         $v0, %lo(fastRandom)($v0)
    /* 587F4 80067FF4 1480033C */  lui        $v1, %hi(randSeed)
    /* 587F8 80067FF8 04D1638C */  lw         $v1, %lo(randSeed)($v1)
    /* 587FC 80067FFC 00000000 */  nop
    /* 58800 80068000 18004300 */  mult       $v0, $v1
    /* 58804 80068004 12100000 */  mflo       $v0
    /* 58808 80068008 FFFF4330 */  andi       $v1, $v0, 0xFFFF
    /* 5880C 8006800C 1480013C */  lui        $at, %hi(randtemp)
    /* 58810 80068010 00D122AC */  sw         $v0, %lo(randtemp)($at)
    /* 58814 80068014 02120200 */  srl        $v0, $v0, 8
    /* 58818 80068018 FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* 5881C 8006801C 1480013C */  lui        $at, %hi(fastRandom)
    /* 58820 80068020 FCD023AC */  sw         $v1, %lo(fastRandom)($at)
    /* 58824 80068024 40180200 */  sll        $v1, $v0, 1
    /* 58828 80068028 21186200 */  addu       $v1, $v1, $v0
    /* 5882C 8006802C 6002028E */  lw         $v0, 0x260($s0)
    /* 58830 80068030 00000000 */  nop
    /* 58834 80068034 10004230 */  andi       $v0, $v0, 0x10
    /* 58838 80068038 03004010 */  beqz       $v0, .L80068048
    /* 5883C 8006803C 022C0300 */   srl       $a1, $v1, 16
    /* 58840 80068040 0BB7020C */  jal        R3DCar_ChangeTrafficColor__FP8Car_tObji
    /* 58844 80068044 21200002 */   addu      $a0, $s0, $zero
  .L80068048:
    /* 58848 80068048 776A010C */  jal        AI_ChooseNewLaneSlack__FP8Car_tObj
    /* 5884C 8006804C 21200002 */   addu      $a0, $s0, $zero
    /* 58850 80068050 CABB010C */  jal        AISpeeds_SetTrafficSpeedRandomFactor__FP8Car_tObj
    /* 58854 80068054 21200002 */   addu      $a0, $s0, $zero
    /* 58858 80068058 21200002 */  addu       $a0, $s0, $zero
    /* 5885C 8006805C 780500AE */  sw         $zero, 0x578($s0)
    /* 58860 80068060 540513AE */  sw         $s3, 0x554($s0)
    /* 58864 80068064 500513AE */  sw         $s3, 0x550($s0)
    /* 58868 80068068 AD9D010C */  jal        AILife_RCSetSpeeds__FP8Car_tObj
    /* 5886C 8006806C 080014A6 */   sh        $s4, 0x8($s0)
    /* 58870 80068070 21200002 */  addu       $a0, $s0, $zero
    /* 58874 80068074 08000586 */  lh         $a1, 0x8($s0)
    /* 58878 80068078 5405078E */  lw         $a3, 0x554($s0)
    /* 5887C 8006807C 21302002 */  addu       $a2, $s1, $zero
    /* 58880 80068080 E785020C */  jal        Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi
    /* 58884 80068084 640500AE */   sw        $zero, 0x564($s0)
    /* 58888 80068088 F0000326 */  addiu      $v1, $s0, 0xF0
    /* 5888C 8006808C 21104002 */  addu       $v0, $s2, $zero
    /* 58890 80068090 20004426 */  addiu      $a0, $s2, 0x20
    /* 58894 80068094 0000A88E */  lw         $t0, 0x0($s5)
    /* 58898 80068098 0400A98E */  lw         $t1, 0x4($s5)
    /* 5889C 8006809C 0800AA8E */  lw         $t2, 0x8($s5)
    /* 588A0 800680A0 A00008AE */  sw         $t0, 0xA0($s0)
    /* 588A4 800680A4 A40009AE */  sw         $t1, 0xA4($s0)
    /* 588A8 800680A8 A8000AAE */  sw         $t2, 0xA8($s0)
  .L800680AC:
    /* 588AC 800680AC 0000488C */  lw         $t0, 0x0($v0)
    /* 588B0 800680B0 0400498C */  lw         $t1, 0x4($v0)
    /* 588B4 800680B4 08004A8C */  lw         $t2, 0x8($v0)
    /* 588B8 800680B8 0C004B8C */  lw         $t3, 0xC($v0)
    /* 588BC 800680BC 000068AC */  sw         $t0, 0x0($v1)
    /* 588C0 800680C0 040069AC */  sw         $t1, 0x4($v1)
    /* 588C4 800680C4 08006AAC */  sw         $t2, 0x8($v1)
    /* 588C8 800680C8 0C006BAC */  sw         $t3, 0xC($v1)
    /* 588CC 800680CC 10004224 */  addiu      $v0, $v0, 0x10
    /* 588D0 800680D0 F6FF4414 */  bne        $v0, $a0, .L800680AC
    /* 588D4 800680D4 10006324 */   addiu     $v1, $v1, 0x10
    /* 588D8 800680D8 0000488C */  lw         $t0, 0x0($v0)
    /* 588DC 800680DC 00000000 */  nop
    /* 588E0 800680E0 000068AC */  sw         $t0, 0x0($v1)
    /* 588E4 800680E4 C4010326 */  addiu      $v1, $s0, 0x1C4
    /* 588E8 800680E8 21104002 */  addu       $v0, $s2, $zero
    /* 588EC 800680EC 20004424 */  addiu      $a0, $v0, 0x20
  .L800680F0:
    /* 588F0 800680F0 0000488C */  lw         $t0, 0x0($v0)
    /* 588F4 800680F4 0400498C */  lw         $t1, 0x4($v0)
    /* 588F8 800680F8 08004A8C */  lw         $t2, 0x8($v0)
    /* 588FC 800680FC 0C004B8C */  lw         $t3, 0xC($v0)
    /* 58900 80068100 000068AC */  sw         $t0, 0x0($v1)
    /* 58904 80068104 040069AC */  sw         $t1, 0x4($v1)
    /* 58908 80068108 08006AAC */  sw         $t2, 0x8($v1)
    /* 5890C 8006810C 0C006BAC */  sw         $t3, 0xC($v1)
    /* 58910 80068110 10004224 */  addiu      $v0, $v0, 0x10
    /* 58914 80068114 F6FF4414 */  bne        $v0, $a0, .L800680F0
    /* 58918 80068118 10006324 */   addiu     $v1, $v1, 0x10
    /* 5891C 8006811C 21200002 */  addu       $a0, $s0, $zero
    /* 58920 80068120 0000488C */  lw         $t0, 0x0($v0)
    /* 58924 80068124 00000000 */  nop
    /* 58928 80068128 000068AC */  sw         $t0, 0x0($v1)
    /* 5892C 8006812C 1000A88F */  lw         $t0, 0x10($sp)
    /* 58930 80068130 1400A98F */  lw         $t1, 0x14($sp)
    /* 58934 80068134 1800AA8F */  lw         $t2, 0x18($sp)
    /* 58938 80068138 AC0008AE */  sw         $t0, 0xAC($s0)
    /* 5893C 8006813C B00009AE */  sw         $t1, 0xB0($s0)
    /* 58940 80068140 B4000AAE */  sw         $t2, 0xB4($s0)
    /* 58944 80068144 5D9C010C */  jal        AIInit_ClearAICar__FP8Car_tObj
    /* 58948 80068148 C00000AE */   sw        $zero, 0xC0($s0)
    /* 5894C 8006814C B22B020C */  jal        Cars_CalculateRoadPosition__FP8Car_tObj
    /* 58950 80068150 21200002 */   addu      $a0, $s0, $zero
    /* 58954 80068154 21200002 */  addu       $a0, $s0, $zero
    /* 58958 80068158 180702AE */  sw         $v0, 0x718($s0)
    /* 5895C 8006815C 580502AE */  sw         $v0, 0x558($s0)
    /* 58960 80068160 202B020C */  jal        Cars_CalculateRoadSpan__FP8Car_tObj
    /* 58964 80068164 740502AE */   sw        $v0, 0x574($s0)
    /* 58968 80068168 21200002 */  addu       $a0, $s0, $zero
    /* 5896C 8006816C 65CD010C */  jal        AIWorld_CalculateLaneInfo__FP8Car_tObj
    /* 58970 80068170 6C0202AE */   sw        $v0, 0x26C($s0)
    /* 58974 80068174 C79E010C */  jal        AILife_RCPickDesiredLatPosition__FP8Car_tObj
    /* 58978 80068178 21200002 */   addu      $a0, $s0, $zero
    /* 5897C 8006817C 4800BF8F */  lw         $ra, 0x48($sp)
    /* 58980 80068180 4400B58F */  lw         $s5, 0x44($sp)
    /* 58984 80068184 4000B48F */  lw         $s4, 0x40($sp)
    /* 58988 80068188 3C00B38F */  lw         $s3, 0x3C($sp)
    /* 5898C 8006818C 3800B28F */  lw         $s2, 0x38($sp)
    /* 58990 80068190 3400B18F */  lw         $s1, 0x34($sp)
    /* 58994 80068194 3000B08F */  lw         $s0, 0x30($sp)
    /* 58998 80068198 0800E003 */  jr         $ra
    /* 5899C 8006819C 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel AILife_ReencarnateTrafficByPosition__FP8Car_tObjiiP8coorddefP10matrixtdef
