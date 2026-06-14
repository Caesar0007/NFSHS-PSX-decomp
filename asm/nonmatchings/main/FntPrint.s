.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FntPrint, 0x3C0

glabel FntPrint
    /* E7834 800F7034 0000A4AF */  sw         $a0, 0x0($sp)
    /* E7838 800F7038 0400A5AF */  sw         $a1, 0x4($sp)
    /* E783C 800F703C 0800A6AF */  sw         $a2, 0x8($sp)
    /* E7840 800F7040 0C00A7AF */  sw         $a3, 0xC($sp)
    /* E7844 800F7044 C8FDBD27 */  addiu      $sp, $sp, -0x238
    /* E7848 800F7048 3C02A227 */  addiu      $v0, $sp, 0x23C
    /* E784C 800F704C 3002BFAF */  sw         $ra, 0x230($sp)
    /* E7850 800F7050 2C02B5AF */  sw         $s5, 0x22C($sp)
    /* E7854 800F7054 2802B4AF */  sw         $s4, 0x228($sp)
    /* E7858 800F7058 2402B3AF */  sw         $s3, 0x224($sp)
    /* E785C 800F705C 2002B2AF */  sw         $s2, 0x220($sp)
    /* E7860 800F7060 1C02B1AF */  sw         $s1, 0x21C($sp)
    /* E7864 800F7064 1802B0AF */  sw         $s0, 0x218($sp)
    /* E7868 800F7068 3802A4AF */  sw         $a0, 0x238($sp)
    /* E786C 800F706C 07008004 */  bltz       $a0, .L800F708C
    /* E7870 800F7070 1002A2AF */   sw        $v0, 0x210($sp)
    /* E7874 800F7074 1380023C */  lui        $v0, %hi(D_80135FD8)
    /* E7878 800F7078 D85F428C */  lw         $v0, %lo(D_80135FD8)($v0)
    /* E787C 800F707C 00000000 */  nop
    /* E7880 800F7080 2A108200 */  slt        $v0, $a0, $v0
    /* E7884 800F7084 0F004014 */  bnez       $v0, .L800F70C4
    /* E7888 800F7088 4002A227 */   addiu     $v0, $sp, 0x240
  .L800F708C:
    /* E788C 800F708C 1380023C */  lui        $v0, %hi(D_80135FDC)
    /* E7890 800F7090 DC5F428C */  lw         $v0, %lo(D_80135FDC)($v0)
    /* E7894 800F7094 00000000 */  nop
    /* E7898 800F7098 40180200 */  sll        $v1, $v0, 1
    /* E789C 800F709C 21186200 */  addu       $v1, $v1, $v0
    /* E78A0 800F70A0 00190300 */  sll        $v1, $v1, 4
    /* E78A4 800F70A4 1380013C */  lui        $at, %hi(D_80135E7C)
    /* E78A8 800F70A8 21082300 */  addu       $at, $at, $v1
    /* E78AC 800F70AC 7C5E238C */  lw         $v1, %lo(D_80135E7C)($at)
    /* E78B0 800F70B0 21988000 */  addu       $s3, $a0, $zero
    /* E78B4 800F70B4 05006014 */  bnez       $v1, .L800F70CC
    /* E78B8 800F70B8 3802A2AF */   sw        $v0, 0x238($sp)
  .L800F70BC:
    /* E78BC 800F70BC F4DC0308 */  j          .L800F73D0
    /* E78C0 800F70C0 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L800F70C4:
    /* E78C4 800F70C4 3C02B38F */  lw         $s3, 0x23C($sp)
    /* E78C8 800F70C8 1002A2AF */  sw         $v0, 0x210($sp)
  .L800F70CC:
    /* E78CC 800F70CC 3802A38F */  lw         $v1, 0x238($sp)
    /* E78D0 800F70D0 00000000 */  nop
    /* E78D4 800F70D4 40100300 */  sll        $v0, $v1, 1
    /* E78D8 800F70D8 21104300 */  addu       $v0, $v0, $v1
    /* E78DC 800F70DC 00110200 */  sll        $v0, $v0, 4
    /* E78E0 800F70E0 1380033C */  lui        $v1, %hi(Font)
    /* E78E4 800F70E4 585E6324 */  addiu      $v1, $v1, %lo(Font)
    /* E78E8 800F70E8 21884300 */  addu       $s1, $v0, $v1
    /* E78EC 800F70EC 2800238E */  lw         $v1, 0x28($s1)
    /* E78F0 800F70F0 1C00228E */  lw         $v0, 0x1C($s1)
    /* E78F4 800F70F4 00000000 */  nop
    /* E78F8 800F70F8 2A104300 */  slt        $v0, $v0, $v1
    /* E78FC 800F70FC EFFF4014 */  bnez       $v0, .L800F70BC
    /* E7900 800F7100 00000000 */   nop
    /* E7904 800F7104 00006482 */  lb         $a0, 0x0($s3)
    /* E7908 800F7108 00000000 */  nop
    /* E790C 800F710C AA008010 */  beqz       $a0, .L800F73B8
    /* E7910 800F7110 00000000 */   nop
    /* E7914 800F7114 25001424 */  addiu      $s4, $zero, 0x25
    /* E7918 800F7118 CCCC153C */  lui        $s5, (0xCCCCCCCD >> 16)
    /* E791C 800F711C CDCCB536 */  ori        $s5, $s5, (0xCCCCCCCD & 0xFFFF)
  .L800F7120:
    /* E7920 800F7120 06009414 */  bne        $a0, $s4, .L800F713C
    /* E7924 800F7124 00000000 */   nop
    /* E7928 800F7128 01007326 */  addiu      $s3, $s3, 0x1
    /* E792C 800F712C 00006482 */  lb         $a0, 0x0($s3)
    /* E7930 800F7130 00000000 */  nop
    /* E7934 800F7134 0D009414 */  bne        $a0, $s4, .L800F716C
    /* E7938 800F7138 21900000 */   addu      $s2, $zero, $zero
  .L800F713C:
    /* E793C 800F713C 2800228E */  lw         $v0, 0x28($s1)
    /* E7940 800F7140 2400238E */  lw         $v1, 0x24($s1)
    /* E7944 800F7144 00000000 */  nop
    /* E7948 800F7148 21186200 */  addu       $v1, $v1, $v0
    /* E794C 800F714C 000064A0 */  sb         $a0, 0x0($v1)
    /* E7950 800F7150 1C00238E */  lw         $v1, 0x1C($s1)
    /* E7954 800F7154 01004224 */  addiu      $v0, $v0, 0x1
    /* E7958 800F7158 2A186200 */  slt        $v1, $v1, $v0
    /* E795C 800F715C 91006010 */  beqz       $v1, .L800F73A4
    /* E7960 800F7160 280022AE */   sw        $v0, 0x28($s1)
    /* E7964 800F7164 F4DC0308 */  j          .L800F73D0
    /* E7968 800F7168 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L800F716C:
    /* E796C 800F716C 30008238 */  xori       $v0, $a0, 0x30
    /* E7970 800F7170 0100422C */  sltiu      $v0, $v0, 0x1
    /* E7974 800F7174 66DC0308 */  j          .L800F7198
    /* E7978 800F7178 21304000 */   addu      $a2, $v0, $zero
  .L800F717C:
    /* E797C 800F717C 21105200 */  addu       $v0, $v0, $s2
    /* E7980 800F7180 40100200 */  sll        $v0, $v0, 1
    /* E7984 800F7184 D0FF4224 */  addiu      $v0, $v0, -0x30
    /* E7988 800F7188 21904400 */  addu       $s2, $v0, $a0
    /* E798C 800F718C 01007326 */  addiu      $s3, $s3, 0x1
    /* E7990 800F7190 00006482 */  lb         $a0, 0x0($s3)
    /* E7994 800F7194 00000000 */  nop
  .L800F7198:
    /* E7998 800F7198 D0FF8224 */  addiu      $v0, $a0, -0x30
    /* E799C 800F719C 0A00422C */  sltiu      $v0, $v0, 0xA
    /* E79A0 800F71A0 F6FF4014 */  bnez       $v0, .L800F717C
    /* E79A4 800F71A4 80101200 */   sll       $v0, $s2, 2
    /* E79A8 800F71A8 0200401E */  bgtz       $s2, .L800F71B4
    /* E79AC 800F71AC A8FF8324 */   addiu     $v1, $a0, -0x58
    /* E79B0 800F71B0 01001224 */  addiu      $s2, $zero, 0x1
  .L800F71B4:
    /* E79B4 800F71B4 2100622C */  sltiu      $v0, $v1, 0x21
    /* E79B8 800F71B8 56004010 */  beqz       $v0, .L800F7314
    /* E79BC 800F71BC 1002B027 */   addiu     $s0, $sp, 0x210
    /* E79C0 800F71C0 80100300 */  sll        $v0, $v1, 2
    /* E79C4 800F71C4 0580013C */  lui        $at, %hi(jtbl_80057078)
    /* E79C8 800F71C8 21082200 */  addu       $at, $at, $v0
    /* E79CC 800F71CC 7870228C */  lw         $v0, %lo(jtbl_80057078)($at)
    /* E79D0 800F71D0 00000000 */  nop
    /* E79D4 800F71D4 08004000 */  jr         $v0
    /* E79D8 800F71D8 00000000 */   nop
  jlabel .L800F71DC
    /* E79DC 800F71DC 1002A28F */  lw         $v0, 0x210($sp)
    /* E79E0 800F71E0 00000000 */  nop
    /* E79E4 800F71E4 0000448C */  lw         $a0, 0x0($v0)
    /* E79E8 800F71E8 04004224 */  addiu      $v0, $v0, 0x4
    /* E79EC 800F71EC 04008104 */  bgez       $a0, .L800F7200
    /* E79F0 800F71F0 1002A2AF */   sw        $v0, 0x210($sp)
    /* E79F4 800F71F4 23200400 */  negu       $a0, $a0
    /* E79F8 800F71F8 81DC0308 */  j          .L800F7204
    /* E79FC 800F71FC 2D000624 */   addiu     $a2, $zero, 0x2D
  .L800F7200:
    /* E7A00 800F7200 21300000 */  addu       $a2, $zero, $zero
  .L800F7204:
    /* E7A04 800F7204 21280000 */  addu       $a1, $zero, $zero
  .L800F7208:
    /* E7A08 800F7208 19009500 */  multu      $a0, $s5
    /* E7A0C 800F720C FFFF1026 */  addiu      $s0, $s0, -0x1
    /* E7A10 800F7210 0100A524 */  addiu      $a1, $a1, 0x1
    /* E7A14 800F7214 10380000 */  mfhi       $a3
    /* E7A18 800F7218 C2180700 */  srl        $v1, $a3, 3
    /* E7A1C 800F721C 80100300 */  sll        $v0, $v1, 2
    /* E7A20 800F7220 21104300 */  addu       $v0, $v0, $v1
    /* E7A24 800F7224 40100200 */  sll        $v0, $v0, 1
    /* E7A28 800F7228 23108200 */  subu       $v0, $a0, $v0
    /* E7A2C 800F722C 30004224 */  addiu      $v0, $v0, 0x30
    /* E7A30 800F7230 000002A2 */  sb         $v0, 0x0($s0)
    /* E7A34 800F7234 F4FFA010 */  beqz       $a1, .L800F7208
    /* E7A38 800F7238 21206000 */   addu      $a0, $v1, $zero
    /* E7A3C 800F723C F2FF8014 */  bnez       $a0, .L800F7208
    /* E7A40 800F7240 00000000 */   nop
    /* E7A44 800F7244 3400C010 */  beqz       $a2, .L800F7318
    /* E7A48 800F7248 2A10B200 */   slt       $v0, $a1, $s2
    /* E7A4C 800F724C FFFF1026 */  addiu      $s0, $s0, -0x1
    /* E7A50 800F7250 000006A2 */  sb         $a2, 0x0($s0)
    /* E7A54 800F7254 C5DC0308 */  j          .L800F7314
    /* E7A58 800F7258 0100A524 */   addiu     $a1, $a1, 0x1
  jlabel .L800F725C
    /* E7A5C 800F725C 1002A28F */  lw         $v0, 0x210($sp)
    /* E7A60 800F7260 21280000 */  addu       $a1, $zero, $zero
    /* E7A64 800F7264 0000448C */  lw         $a0, 0x0($v0)
    /* E7A68 800F7268 04004224 */  addiu      $v0, $v0, 0x4
    /* E7A6C 800F726C 1002A2AF */  sw         $v0, 0x210($sp)
  .L800F7270:
    /* E7A70 800F7270 FFFF1026 */  addiu      $s0, $s0, -0x1
  .L800F7274:
    /* E7A74 800F7274 0F008230 */  andi       $v0, $a0, 0xF
    /* E7A78 800F7278 1380033C */  lui        $v1, %hi(D_801369E4)
    /* E7A7C 800F727C E469638C */  lw         $v1, %lo(D_801369E4)($v1)
    /* E7A80 800F7280 02210400 */  srl        $a0, $a0, 4
    /* E7A84 800F7284 21186200 */  addu       $v1, $v1, $v0
    /* E7A88 800F7288 00006290 */  lbu        $v0, 0x0($v1)
    /* E7A8C 800F728C 0100A524 */  addiu      $a1, $a1, 0x1
    /* E7A90 800F7290 F7FFA010 */  beqz       $a1, .L800F7270
    /* E7A94 800F7294 000002A2 */   sb        $v0, 0x0($s0)
    /* E7A98 800F7298 F6FF8014 */  bnez       $a0, .L800F7274
    /* E7A9C 800F729C FFFF1026 */   addiu     $s0, $s0, -0x1
    /* E7AA0 800F72A0 01001026 */  addiu      $s0, $s0, 0x1
    /* E7AA4 800F72A4 2110C000 */  addu       $v0, $a2, $zero
    /* E7AA8 800F72A8 1A004010 */  beqz       $v0, .L800F7314
    /* E7AAC 800F72AC 2A10B200 */   slt       $v0, $a1, $s2
    /* E7AB0 800F72B0 29004010 */  beqz       $v0, .L800F7358
    /* E7AB4 800F72B4 30000324 */   addiu     $v1, $zero, 0x30
  .L800F72B8:
    /* E7AB8 800F72B8 FFFF1026 */  addiu      $s0, $s0, -0x1
    /* E7ABC 800F72BC 0100A524 */  addiu      $a1, $a1, 0x1
    /* E7AC0 800F72C0 2A10B200 */  slt        $v0, $a1, $s2
    /* E7AC4 800F72C4 FCFF4014 */  bnez       $v0, .L800F72B8
    /* E7AC8 800F72C8 000003A2 */   sb        $v1, 0x0($s0)
    /* E7ACC 800F72CC C6DC0308 */  j          .L800F7318
    /* E7AD0 800F72D0 00000000 */   nop
  jlabel .L800F72D4
    /* E7AD4 800F72D4 FFFF1026 */  addiu      $s0, $s0, -0x1
    /* E7AD8 800F72D8 1002A28F */  lw         $v0, 0x210($sp)
    /* E7ADC 800F72DC 01000524 */  addiu      $a1, $zero, 0x1
    /* E7AE0 800F72E0 00004390 */  lbu        $v1, 0x0($v0)
    /* E7AE4 800F72E4 04004224 */  addiu      $v0, $v0, 0x4
    /* E7AE8 800F72E8 000003A2 */  sb         $v1, 0x0($s0)
    /* E7AEC 800F72EC C5DC0308 */  j          .L800F7314
    /* E7AF0 800F72F0 1002A2AF */   sw        $v0, 0x210($sp)
  jlabel .L800F72F4
    /* E7AF4 800F72F4 1002A28F */  lw         $v0, 0x210($sp)
    /* E7AF8 800F72F8 00000000 */  nop
    /* E7AFC 800F72FC 0000508C */  lw         $s0, 0x0($v0)
    /* E7B00 800F7300 04004224 */  addiu      $v0, $v0, 0x4
    /* E7B04 800F7304 1002A2AF */  sw         $v0, 0x210($sp)
    /* E7B08 800F7308 DDA7030C */  jal        strlen
    /* E7B0C 800F730C 21200002 */   addu      $a0, $s0, $zero
    /* E7B10 800F7310 21284000 */  addu       $a1, $v0, $zero
  jlabel .L800F7314
    /* E7B14 800F7314 2A10B200 */  slt        $v0, $a1, $s2
  .L800F7318:
    /* E7B18 800F7318 0F004010 */  beqz       $v0, .L800F7358
    /* E7B1C 800F731C 20000424 */   addiu     $a0, $zero, 0x20
  .L800F7320:
    /* E7B20 800F7320 2800228E */  lw         $v0, 0x28($s1)
    /* E7B24 800F7324 2400238E */  lw         $v1, 0x24($s1)
    /* E7B28 800F7328 00000000 */  nop
    /* E7B2C 800F732C 21186200 */  addu       $v1, $v1, $v0
    /* E7B30 800F7330 000064A0 */  sb         $a0, 0x0($v1)
    /* E7B34 800F7334 1C00238E */  lw         $v1, 0x1C($s1)
    /* E7B38 800F7338 01004224 */  addiu      $v0, $v0, 0x1
    /* E7B3C 800F733C 2A186200 */  slt        $v1, $v1, $v0
    /* E7B40 800F7340 5EFF6014 */  bnez       $v1, .L800F70BC
    /* E7B44 800F7344 280022AE */   sw        $v0, 0x28($s1)
    /* E7B48 800F7348 FFFF5226 */  addiu      $s2, $s2, -0x1
    /* E7B4C 800F734C 2A10B200 */  slt        $v0, $a1, $s2
    /* E7B50 800F7350 F3FF4014 */  bnez       $v0, .L800F7320
    /* E7B54 800F7354 00000000 */   nop
  .L800F7358:
    /* E7B58 800F7358 FFFFA524 */  addiu      $a1, $a1, -0x1
    /* E7B5C 800F735C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* E7B60 800F7360 1000A210 */  beq        $a1, $v0, .L800F73A4
    /* E7B64 800F7364 00000000 */   nop
    /* E7B68 800F7368 FFFF0624 */  addiu      $a2, $zero, -0x1
  .L800F736C:
    /* E7B6C 800F736C 2800238E */  lw         $v1, 0x28($s1)
    /* E7B70 800F7370 2400228E */  lw         $v0, 0x24($s1)
    /* E7B74 800F7374 00000492 */  lbu        $a0, 0x0($s0)
    /* E7B78 800F7378 01001026 */  addiu      $s0, $s0, 0x1
    /* E7B7C 800F737C 21104300 */  addu       $v0, $v0, $v1
    /* E7B80 800F7380 000044A0 */  sb         $a0, 0x0($v0)
    /* E7B84 800F7384 1C00228E */  lw         $v0, 0x1C($s1)
    /* E7B88 800F7388 01006324 */  addiu      $v1, $v1, 0x1
    /* E7B8C 800F738C 2A104300 */  slt        $v0, $v0, $v1
    /* E7B90 800F7390 4AFF4014 */  bnez       $v0, .L800F70BC
    /* E7B94 800F7394 280023AE */   sw        $v1, 0x28($s1)
    /* E7B98 800F7398 FFFFA524 */  addiu      $a1, $a1, -0x1
    /* E7B9C 800F739C F3FFA614 */  bne        $a1, $a2, .L800F736C
    /* E7BA0 800F73A0 00000000 */   nop
  .L800F73A4:
    /* E7BA4 800F73A4 01007326 */  addiu      $s3, $s3, 0x1
    /* E7BA8 800F73A8 00006482 */  lb         $a0, 0x0($s3)
    /* E7BAC 800F73AC 00000000 */  nop
    /* E7BB0 800F73B0 5BFF8014 */  bnez       $a0, .L800F7120
    /* E7BB4 800F73B4 00000000 */   nop
  .L800F73B8:
    /* E7BB8 800F73B8 2400228E */  lw         $v0, 0x24($s1)
    /* E7BBC 800F73BC 2800238E */  lw         $v1, 0x28($s1)
    /* E7BC0 800F73C0 00000000 */  nop
    /* E7BC4 800F73C4 21104300 */  addu       $v0, $v0, $v1
    /* E7BC8 800F73C8 000040A0 */  sb         $zero, 0x0($v0)
    /* E7BCC 800F73CC 2800228E */  lw         $v0, 0x28($s1)
  .L800F73D0:
    /* E7BD0 800F73D0 3002BF8F */  lw         $ra, 0x230($sp)
    /* E7BD4 800F73D4 2C02B58F */  lw         $s5, 0x22C($sp)
    /* E7BD8 800F73D8 2802B48F */  lw         $s4, 0x228($sp)
    /* E7BDC 800F73DC 2402B38F */  lw         $s3, 0x224($sp)
    /* E7BE0 800F73E0 2002B28F */  lw         $s2, 0x220($sp)
    /* E7BE4 800F73E4 1C02B18F */  lw         $s1, 0x21C($sp)
    /* E7BE8 800F73E8 1802B08F */  lw         $s0, 0x218($sp)
    /* E7BEC 800F73EC 0800E003 */  jr         $ra
    /* E7BF0 800F73F0 3802BD27 */   addiu     $sp, $sp, 0x238
endlabel FntPrint
    /* E7BF4 800F73F4 00000000 */  nop
    /* E7BF8 800F73F8 00000000 */  nop
    /* E7BFC 800F73FC 00000000 */  nop
