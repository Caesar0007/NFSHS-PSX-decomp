.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_UpdateRoadGeometry__FP13BO_tNewtonObj, 0x390

glabel Newton_UpdateRoadGeometry__FP13BO_tNewtonObj
    /* 8FFA0 8009F7A0 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 8FFA4 8009F7A4 3800B6AF */  sw         $s6, 0x38($sp)
    /* 8FFA8 8009F7A8 21B08000 */  addu       $s6, $a0, $zero
    /* 8FFAC 8009F7AC 4400BFAF */  sw         $ra, 0x44($sp)
    /* 8FFB0 8009F7B0 4000BEAF */  sw         $fp, 0x40($sp)
    /* 8FFB4 8009F7B4 3C00B7AF */  sw         $s7, 0x3C($sp)
    /* 8FFB8 8009F7B8 3400B5AF */  sw         $s5, 0x34($sp)
    /* 8FFBC 8009F7BC 3000B4AF */  sw         $s4, 0x30($sp)
    /* 8FFC0 8009F7C0 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* 8FFC4 8009F7C4 2800B2AF */  sw         $s2, 0x28($sp)
    /* 8FFC8 8009F7C8 2400B1AF */  sw         $s1, 0x24($sp)
    /* 8FFCC 8009F7CC 2000B0AF */  sw         $s0, 0x20($sp)
    /* 8FFD0 8009F7D0 9100C292 */  lbu        $v0, 0x91($s6)
    /* 8FFD4 8009F7D4 00000000 */  nop
    /* 8FFD8 8009F7D8 C9004010 */  beqz       $v0, .L8009FB00
    /* 8FFDC 8009F7DC 00000000 */   nop
    /* 8FFE0 8009F7E0 9000C292 */  lbu        $v0, 0x90($s6)
    /* 8FFE4 8009F7E4 0800DE86 */  lh         $fp, 0x8($s6)
    /* 8FFE8 8009F7E8 0200462C */  sltiu      $a2, $v0, 0x2
    /* 8FFEC 8009F7EC 4000C010 */  beqz       $a2, .L8009F8F0
    /* 8FFF0 8009F7F0 21280000 */   addu      $a1, $zero, $zero
    /* 8FFF4 8009F7F4 7001C0AE */  sw         $zero, 0x170($s6)
    /* 8FFF8 8009F7F8 6C01C0AE */  sw         $zero, 0x16C($s6)
    /* 8FFFC 8009F7FC 6801C0AE */  sw         $zero, 0x168($s6)
  .L8009F800:
    /* 90000 8009F800 0400A228 */  slti       $v0, $a1, 0x4
    /* 90004 8009F804 28004010 */  beqz       $v0, .L8009F8A8
    /* 90008 8009F808 00000000 */   nop
    /* 9000C 8009F80C 8000C28E */  lw         $v0, 0x80($s6)
    /* 90010 8009F810 00000000 */  nop
    /* 90014 8009F814 09004010 */  beqz       $v0, .L8009F83C
    /* 90018 8009F818 00000000 */   nop
    /* 9001C 8009F81C 1000878C */  lw         $a3, 0x10($a0)
    /* 90020 8009F820 1400888C */  lw         $t0, 0x14($a0)
    /* 90024 8009F824 1800898C */  lw         $t1, 0x18($a0)
    /* 90028 8009F828 1000A7AF */  sw         $a3, 0x10($sp)
    /* 9002C 8009F82C 1400A8AF */  sw         $t0, 0x14($sp)
    /* 90030 8009F830 1800A9AF */  sw         $t1, 0x18($sp)
    /* 90034 8009F834 1A7E0208 */  j          .L8009F868
    /* 90038 8009F838 00000000 */   nop
  .L8009F83C:
    /* 9003C 8009F83C 0800C286 */  lh         $v0, 0x8($s6)
    /* 90040 8009F840 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 90044 8009F844 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 90048 8009F848 40110200 */  sll        $v0, $v0, 5
    /* 9004C 8009F84C 21104300 */  addu       $v0, $v0, $v1
    /* 90050 8009F850 0000478C */  lw         $a3, 0x0($v0)
    /* 90054 8009F854 0400488C */  lw         $t0, 0x4($v0)
    /* 90058 8009F858 0800498C */  lw         $t1, 0x8($v0)
    /* 9005C 8009F85C 1000A7AF */  sw         $a3, 0x10($sp)
    /* 90060 8009F860 1400A8AF */  sw         $t0, 0x14($sp)
    /* 90064 8009F864 1800A9AF */  sw         $t1, 0x18($sp)
  .L8009F868:
    /* 90068 8009F868 6801C28E */  lw         $v0, 0x168($s6)
    /* 9006C 8009F86C 1000A38F */  lw         $v1, 0x10($sp)
    /* 90070 8009F870 00000000 */  nop
    /* 90074 8009F874 21104300 */  addu       $v0, $v0, $v1
    /* 90078 8009F878 6801C2AE */  sw         $v0, 0x168($s6)
    /* 9007C 8009F87C 6C01C28E */  lw         $v0, 0x16C($s6)
    /* 90080 8009F880 1400A38F */  lw         $v1, 0x14($sp)
    /* 90084 8009F884 0C008424 */  addiu      $a0, $a0, 0xC
    /* 90088 8009F888 21104300 */  addu       $v0, $v0, $v1
    /* 9008C 8009F88C 6C01C2AE */  sw         $v0, 0x16C($s6)
    /* 90090 8009F890 7001C28E */  lw         $v0, 0x170($s6)
    /* 90094 8009F894 1800A38F */  lw         $v1, 0x18($sp)
    /* 90098 8009F898 0100A524 */  addiu      $a1, $a1, 0x1
    /* 9009C 8009F89C 21104300 */  addu       $v0, $v0, $v1
    /* 900A0 8009F8A0 007E0208 */  j          .L8009F800
    /* 900A4 8009F8A4 7001C2AE */   sw        $v0, 0x170($s6)
  .L8009F8A8:
    /* 900A8 8009F8A8 6801C28E */  lw         $v0, 0x168($s6)
    /* 900AC 8009F8AC 00000000 */  nop
    /* 900B0 8009F8B0 02004104 */  bgez       $v0, .L8009F8BC
    /* 900B4 8009F8B4 00000000 */   nop
    /* 900B8 8009F8B8 03004224 */  addiu      $v0, $v0, 0x3
  .L8009F8BC:
    /* 900BC 8009F8BC 6C01C48E */  lw         $a0, 0x16C($s6)
    /* 900C0 8009F8C0 83100200 */  sra        $v0, $v0, 2
    /* 900C4 8009F8C4 02008104 */  bgez       $a0, .L8009F8D0
    /* 900C8 8009F8C8 6801C2AE */   sw        $v0, 0x168($s6)
    /* 900CC 8009F8CC 03008424 */  addiu      $a0, $a0, 0x3
  .L8009F8D0:
    /* 900D0 8009F8D0 7001C38E */  lw         $v1, 0x170($s6)
    /* 900D4 8009F8D4 83100400 */  sra        $v0, $a0, 2
    /* 900D8 8009F8D8 02006104 */  bgez       $v1, .L8009F8E4
    /* 900DC 8009F8DC 6C01C2AE */   sw        $v0, 0x16C($s6)
    /* 900E0 8009F8E0 03006324 */  addiu      $v1, $v1, 0x3
  .L8009F8E4:
    /* 900E4 8009F8E4 83100300 */  sra        $v0, $v1, 2
    /* 900E8 8009F8E8 527E0208 */  j          .L8009F948
    /* 900EC 8009F8EC 7001C2AE */   sw        $v0, 0x170($s6)
  .L8009F8F0:
    /* 900F0 8009F8F0 8000C28E */  lw         $v0, 0x80($s6)
    /* 900F4 8009F8F4 00000000 */  nop
    /* 900F8 8009F8F8 09004010 */  beqz       $v0, .L8009F920
    /* 900FC 8009F8FC 40111E00 */   sll       $v0, $fp, 5
    /* 90100 8009F900 1000C78E */  lw         $a3, 0x10($s6)
    /* 90104 8009F904 1400C88E */  lw         $t0, 0x14($s6)
    /* 90108 8009F908 1800C98E */  lw         $t1, 0x18($s6)
    /* 9010C 8009F90C 6801C7AE */  sw         $a3, 0x168($s6)
    /* 90110 8009F910 6C01C8AE */  sw         $t0, 0x16C($s6)
    /* 90114 8009F914 7001C9AE */  sw         $t1, 0x170($s6)
    /* 90118 8009F918 527E0208 */  j          .L8009F948
    /* 9011C 8009F91C 00000000 */   nop
  .L8009F920:
    /* 90120 8009F920 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 90124 8009F924 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 90128 8009F928 00000000 */  nop
    /* 9012C 8009F92C 21104300 */  addu       $v0, $v0, $v1
    /* 90130 8009F930 0000478C */  lw         $a3, 0x0($v0)
    /* 90134 8009F934 0400488C */  lw         $t0, 0x4($v0)
    /* 90138 8009F938 0800498C */  lw         $t1, 0x8($v0)
    /* 9013C 8009F93C 6801C7AE */  sw         $a3, 0x168($s6)
    /* 90140 8009F940 6C01C8AE */  sw         $t0, 0x16C($s6)
    /* 90144 8009F944 7001C9AE */  sw         $t1, 0x170($s6)
  .L8009F948:
    /* 90148 8009F948 3700C010 */  beqz       $a2, .L8009FA28
    /* 9014C 8009F94C 40191E00 */   sll       $v1, $fp, 5
    /* 90150 8009F950 6100C282 */  lb         $v0, 0x61($s6)
    /* 90154 8009F954 00000000 */  nop
    /* 90158 8009F958 53004010 */  beqz       $v0, .L8009FAA8
    /* 9015C 8009F95C 0800D026 */   addiu     $s0, $s6, 0x8
    /* 90160 8009F960 4801020C */  jal        BWorldSm_UNormal__FP12BWorldSm_Pos
    /* 90164 8009F964 21200002 */   addu      $a0, $s0, $zero
    /* 90168 8009F968 0000478C */  lw         $a3, 0x0($v0)
    /* 9016C 8009F96C 0400488C */  lw         $t0, 0x4($v0)
    /* 90170 8009F970 0800498C */  lw         $t1, 0x8($v0)
    /* 90174 8009F974 5001C7AE */  sw         $a3, 0x150($s6)
    /* 90178 8009F978 5401C8AE */  sw         $t0, 0x154($s6)
    /* 9017C 8009F97C 5801C9AE */  sw         $t1, 0x158($s6)
    /* 90180 8009F980 5201020C */  jal        BWorldSm_UForward__FP12BWorldSm_Pos
    /* 90184 8009F984 21200002 */   addu      $a0, $s0, $zero
    /* 90188 8009F988 0000478C */  lw         $a3, 0x0($v0)
    /* 9018C 8009F98C 0400488C */  lw         $t0, 0x4($v0)
    /* 90190 8009F990 0800498C */  lw         $t1, 0x8($v0)
    /* 90194 8009F994 5C01C7AE */  sw         $a3, 0x15C($s6)
    /* 90198 8009F998 6001C8AE */  sw         $t0, 0x160($s6)
    /* 9019C 8009F99C 6401C9AE */  sw         $t1, 0x164($s6)
    /* 901A0 8009F9A0 5401D58E */  lw         $s5, 0x154($s6)
    /* 901A4 8009F9A4 6401D38E */  lw         $s3, 0x164($s6)
    /* 901A8 8009F9A8 5001D28E */  lw         $s2, 0x150($s6)
    /* 901AC 8009F9AC 5801D08E */  lw         $s0, 0x158($s6)
    /* 901B0 8009F9B0 5C01D48E */  lw         $s4, 0x15C($s6)
    /* 901B4 8009F9B4 6001D18E */  lw         $s1, 0x160($s6)
    /* 901B8 8009F9B8 2120A002 */  addu       $a0, $s5, $zero
    /* 901BC 8009F9BC CA90030C */  jal        fixedmult
    /* 901C0 8009F9C0 21286002 */   addu      $a1, $s3, $zero
    /* 901C4 8009F9C4 21B84000 */  addu       $s7, $v0, $zero
    /* 901C8 8009F9C8 21200002 */  addu       $a0, $s0, $zero
    /* 901CC 8009F9CC CA90030C */  jal        fixedmult
    /* 901D0 8009F9D0 21282002 */   addu      $a1, $s1, $zero
    /* 901D4 8009F9D4 21200002 */  addu       $a0, $s0, $zero
    /* 901D8 8009F9D8 21288002 */  addu       $a1, $s4, $zero
    /* 901DC 8009F9DC 2310E202 */  subu       $v0, $s7, $v0
    /* 901E0 8009F9E0 CA90030C */  jal        fixedmult
    /* 901E4 8009F9E4 4401C2AE */   sw        $v0, 0x144($s6)
    /* 901E8 8009F9E8 21B84000 */  addu       $s7, $v0, $zero
    /* 901EC 8009F9EC 21204002 */  addu       $a0, $s2, $zero
    /* 901F0 8009F9F0 CA90030C */  jal        fixedmult
    /* 901F4 8009F9F4 21286002 */   addu      $a1, $s3, $zero
    /* 901F8 8009F9F8 21204002 */  addu       $a0, $s2, $zero
    /* 901FC 8009F9FC 21282002 */  addu       $a1, $s1, $zero
    /* 90200 8009FA00 2310E202 */  subu       $v0, $s7, $v0
    /* 90204 8009FA04 CA90030C */  jal        fixedmult
    /* 90208 8009FA08 4801C2AE */   sw        $v0, 0x148($s6)
    /* 9020C 8009FA0C 21B84000 */  addu       $s7, $v0, $zero
    /* 90210 8009FA10 2120A002 */  addu       $a0, $s5, $zero
    /* 90214 8009FA14 CA90030C */  jal        fixedmult
    /* 90218 8009FA18 21288002 */   addu      $a1, $s4, $zero
    /* 9021C 8009FA1C 2310E202 */  subu       $v0, $s7, $v0
    /* 90220 8009FA20 AA7E0208 */  j          .L8009FAA8
    /* 90224 8009FA24 4C01C2AE */   sw        $v0, 0x14C($s6)
  .L8009FA28:
    /* 90228 8009FA28 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* 9022C 8009FA2C C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* 90230 8009FA30 00000000 */  nop
    /* 90234 8009FA34 21186200 */  addu       $v1, $v1, $v0
    /* 90238 8009FA38 12006280 */  lb         $v0, 0x12($v1)
    /* 9023C 8009FA3C 14006480 */  lb         $a0, 0x14($v1)
    /* 90240 8009FA40 402A0200 */  sll        $a1, $v0, 9
    /* 90244 8009FA44 13006280 */  lb         $v0, 0x13($v1)
    /* 90248 8009FA48 40220400 */  sll        $a0, $a0, 9
    /* 9024C 8009FA4C 4401C5AE */  sw         $a1, 0x144($s6)
    /* 90250 8009FA50 4C01C4AE */  sw         $a0, 0x14C($s6)
    /* 90254 8009FA54 40120200 */  sll        $v0, $v0, 9
    /* 90258 8009FA58 4801C2AE */  sw         $v0, 0x148($s6)
    /* 9025C 8009FA5C 0C006280 */  lb         $v0, 0xC($v1)
    /* 90260 8009FA60 0E006480 */  lb         $a0, 0xE($v1)
    /* 90264 8009FA64 402A0200 */  sll        $a1, $v0, 9
    /* 90268 8009FA68 0D006280 */  lb         $v0, 0xD($v1)
    /* 9026C 8009FA6C 40220400 */  sll        $a0, $a0, 9
    /* 90270 8009FA70 5001C5AE */  sw         $a1, 0x150($s6)
    /* 90274 8009FA74 5801C4AE */  sw         $a0, 0x158($s6)
    /* 90278 8009FA78 40120200 */  sll        $v0, $v0, 9
    /* 9027C 8009FA7C 5401C2AE */  sw         $v0, 0x154($s6)
    /* 90280 8009FA80 0F006280 */  lb         $v0, 0xF($v1)
    /* 90284 8009FA84 00000000 */  nop
    /* 90288 8009FA88 402A0200 */  sll        $a1, $v0, 9
    /* 9028C 8009FA8C 10006280 */  lb         $v0, 0x10($v1)
    /* 90290 8009FA90 11006380 */  lb         $v1, 0x11($v1)
    /* 90294 8009FA94 5C01C5AE */  sw         $a1, 0x15C($s6)
    /* 90298 8009FA98 40120200 */  sll        $v0, $v0, 9
    /* 9029C 8009FA9C 40220300 */  sll        $a0, $v1, 9
    /* 902A0 8009FAA0 6001C2AE */  sw         $v0, 0x160($s6)
    /* 902A4 8009FAA4 6401C4AE */  sw         $a0, 0x164($s6)
  .L8009FAA8:
    /* 902A8 8009FAA8 1480043C */  lui        $a0, %hi(gNumSlices)
    /* 902AC 8009FAAC C8C7848C */  lw         $a0, %lo(gNumSlices)($a0)
    /* 902B0 8009FAB0 0100C327 */  addiu      $v1, $fp, 0x1
    /* 902B4 8009FAB4 2A106400 */  slt        $v0, $v1, $a0
    /* 902B8 8009FAB8 03004014 */  bnez       $v0, .L8009FAC8
    /* 902BC 8009FABC 21306000 */   addu      $a2, $v1, $zero
    /* 902C0 8009FAC0 FFFF8224 */  addiu      $v0, $a0, -0x1
    /* 902C4 8009FAC4 2330C203 */  subu       $a2, $fp, $v0
  .L8009FAC8:
    /* 902C8 8009FAC8 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 902CC 8009FACC C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 902D0 8009FAD0 40111E00 */  sll        $v0, $fp, 5
    /* 902D4 8009FAD4 21104300 */  addu       $v0, $v0, $v1
    /* 902D8 8009FAD8 0000448C */  lw         $a0, 0x0($v0)
    /* 902DC 8009FADC 0800458C */  lw         $a1, 0x8($v0)
    /* 902E0 8009FAE0 40110600 */  sll        $v0, $a2, 5
    /* 902E4 8009FAE4 21104300 */  addu       $v0, $v0, $v1
    /* 902E8 8009FAE8 0000438C */  lw         $v1, 0x0($v0)
    /* 902EC 8009FAEC 0800428C */  lw         $v0, 0x8($v0)
    /* 902F0 8009FAF0 23206400 */  subu       $a0, $v1, $a0
    /* 902F4 8009FAF4 CE96030C */  jal        intatan
    /* 902F8 8009FAF8 23284500 */   subu      $a1, $v0, $a1
    /* 902FC 8009FAFC 7801C2AE */  sw         $v0, 0x178($s6)
  .L8009FB00:
    /* 90300 8009FB00 4400BF8F */  lw         $ra, 0x44($sp)
    /* 90304 8009FB04 4000BE8F */  lw         $fp, 0x40($sp)
    /* 90308 8009FB08 3C00B78F */  lw         $s7, 0x3C($sp)
    /* 9030C 8009FB0C 3800B68F */  lw         $s6, 0x38($sp)
    /* 90310 8009FB10 3400B58F */  lw         $s5, 0x34($sp)
    /* 90314 8009FB14 3000B48F */  lw         $s4, 0x30($sp)
    /* 90318 8009FB18 2C00B38F */  lw         $s3, 0x2C($sp)
    /* 9031C 8009FB1C 2800B28F */  lw         $s2, 0x28($sp)
    /* 90320 8009FB20 2400B18F */  lw         $s1, 0x24($sp)
    /* 90324 8009FB24 2000B08F */  lw         $s0, 0x20($sp)
    /* 90328 8009FB28 0800E003 */  jr         $ra
    /* 9032C 8009FB2C 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel Newton_UpdateRoadGeometry__FP13BO_tNewtonObj
