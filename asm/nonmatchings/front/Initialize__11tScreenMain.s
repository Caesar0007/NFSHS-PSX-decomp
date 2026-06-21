.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Initialize__11tScreenMain, 0x204

glabel Initialize__11tScreenMain
    /* 290D4 800388D4 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 290D8 800388D8 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 290DC 800388DC 21888000 */  addu       $s1, $a0, $zero
    /* 290E0 800388E0 2800BFAF */  sw         $ra, 0x28($sp)
    /* 290E4 800388E4 2400B3AF */  sw         $s3, 0x24($sp)
    /* 290E8 800388E8 2000B2AF */  sw         $s2, 0x20($sp)
    /* 290EC 800388EC 2B98000C */  jal        Initialize__7tScreen
    /* 290F0 800388F0 1800B0AF */   sw        $s0, 0x18($sp)
    /* 290F4 800388F4 58053226 */  addiu      $s2, $s1, 0x558
    /* 290F8 800388F8 10001324 */  addiu      $s3, $zero, 0x10
  .L800388FC:
    /* 290FC 800388FC 5256000C */  jal        FeAudio_systemtask__Fi
    /* 29100 80038900 21200000 */   addu      $a0, $zero, $zero
    /* 29104 80038904 21202002 */  addu       $a0, $s1, $zero
    /* 29108 80038908 8397000C */  jal        IsShapeFileLoaded__7tScreenR17tShapeInformation
    /* 2910C 8003890C 21284002 */   addu      $a1, $s2, $zero
    /* 29110 80038910 5C05238E */  lw         $v1, 0x55C($s1)
    /* 29114 80038914 00000000 */  nop
    /* 29118 80038918 08006010 */  beqz       $v1, .L8003893C
    /* 2911C 8003891C 21804000 */   addu      $s0, $v0, $zero
    /* 29120 80038920 21202002 */  addu       $a0, $s1, $zero
    /* 29124 80038924 21284002 */  addu       $a1, $s2, $zero
    /* 29128 80038928 21300000 */  addu       $a2, $zero, $zero
    /* 2912C 8003892C 2138C000 */  addu       $a3, $a2, $zero
    /* 29130 80038930 1000B3AF */  sw         $s3, 0x10($sp)
    /* 29134 80038934 7D99000C */  jal        UploadShapes__7tScreenR17tShapeInformationssss
    /* 29138 80038938 1400A0AF */   sw        $zero, 0x14($sp)
  .L8003893C:
    /* 2913C 8003893C 05000012 */  beqz       $s0, .L80038954
    /* 29140 80038940 21180000 */   addu      $v1, $zero, $zero
    /* 29144 80038944 21202002 */  addu       $a0, $s1, $zero
    /* 29148 80038948 8397000C */  jal        IsShapeFileLoaded__7tScreenR17tShapeInformation
    /* 2914C 8003894C 80052526 */   addiu     $a1, $s1, 0x580
    /* 29150 80038950 2B180200 */  sltu       $v1, $zero, $v0
  .L80038954:
    /* 29154 80038954 8405228E */  lw         $v0, 0x584($s1)
    /* 29158 80038958 00000000 */  nop
    /* 2915C 8003895C 08004010 */  beqz       $v0, .L80038980
    /* 29160 80038960 21806000 */   addu      $s0, $v1, $zero
    /* 29164 80038964 21202002 */  addu       $a0, $s1, $zero
    /* 29168 80038968 80052526 */  addiu      $a1, $s1, 0x580
    /* 2916C 8003896C A6000624 */  addiu      $a2, $zero, 0xA6
    /* 29170 80038970 21380000 */  addu       $a3, $zero, $zero
    /* 29174 80038974 1000B3AF */  sw         $s3, 0x10($sp)
    /* 29178 80038978 7D99000C */  jal        UploadShapes__7tScreenR17tShapeInformationssss
    /* 2917C 8003897C 1400A0AF */   sw        $zero, 0x14($sp)
  .L80038980:
    /* 29180 80038980 DEFF0012 */  beqz       $s0, .L800388FC
    /* 29184 80038984 50000424 */   addiu     $a0, $zero, 0x50
    /* 29188 80038988 21288000 */  addu       $a1, $a0, $zero
    /* 2918C 8003898C 0F00063C */  lui        $a2, (0xF0000 >> 16)
    /* 29190 80038990 0200073C */  lui        $a3, (0x20000 >> 16)
    /* 29194 80038994 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 29198 80038998 4C0522A6 */  sh         $v0, 0x54C($s1)
    /* 2919C 8003899C 10000224 */  addiu      $v0, $zero, 0x10
    /* 291A0 800389A0 680020AE */  sw         $zero, 0x68($s1)
    /* 291A4 800389A4 3243010C */  jal        VIDEO_create__Fiiiii
    /* 291A8 800389A8 1000A2AF */   sw        $v0, 0x10($sp)
    /* 291AC 800389AC 21800000 */  addu       $s0, $zero, $zero
    /* 291B0 800389B0 640022AE */  sw         $v0, 0x64($s1)
    /* 291B4 800389B4 1480023C */  lui        $v0, %hi(ticks)
    /* 291B8 800389B8 ACDC448C */  lw         $a0, %lo(ticks)($v0)
    /* 291BC 800389BC ACDC438C */  lw         $v1, %lo(ticks)($v0)
    /* 291C0 800389C0 01000224 */  addiu      $v0, $zero, 0x1
    /* 291C4 800389C4 500520AE */  sw         $zero, 0x550($s1)
    /* 291C8 800389C8 400522A2 */  sb         $v0, 0x540($s1)
    /* 291CC 800389CC 440520AE */  sw         $zero, 0x544($s1)
    /* 291D0 800389D0 4A0520A6 */  sh         $zero, 0x54A($s1)
    /* 291D4 800389D4 B40520AE */  sw         $zero, 0x5B4($s1)
    /* 291D8 800389D8 A80520AE */  sw         $zero, 0x5A8($s1)
    /* 291DC 800389DC E0FC6324 */  addiu      $v1, $v1, -0x320
    /* 291E0 800389E0 6C0024AE */  sw         $a0, 0x6C($s1)
    /* 291E4 800389E4 700023AE */  sw         $v1, 0x70($s1)
    /* 291E8 800389E8 00341000 */  sll        $a2, $s0, 16
  .L800389EC:
    /* 291EC 800389EC 03340600 */  sra        $a2, $a2, 16
    /* 291F0 800389F0 40200600 */  sll        $a0, $a2, 1
    /* 291F4 800389F4 21208600 */  addu       $a0, $a0, $a2
    /* 291F8 800389F8 00210400 */  sll        $a0, $a0, 4
    /* 291FC 800389FC A805238E */  lw         $v1, 0x5A8($s1)
    /* 29200 80038A00 7C008424 */  addiu      $a0, $a0, 0x7C
    /* 29204 80038A04 80100300 */  sll        $v0, $v1, 2
    /* 29208 80038A08 21104300 */  addu       $v0, $v0, $v1
    /* 2920C 80038A0C C0100200 */  sll        $v0, $v0, 3
    /* 29210 80038A10 21102202 */  addu       $v0, $s1, $v0
    /* 29214 80038A14 5805458C */  lw         $a1, 0x558($v0)
    /* 29218 80038A18 028C000C */  jal        InitTV__FR9tTVConfigP18tTexture_ShapeInfos
    /* 2921C 80038A1C 21202402 */   addu      $a0, $s1, $a0
    /* 29220 80038A20 01000226 */  addiu      $v0, $s0, 0x1
    /* 29224 80038A24 21804000 */  addu       $s0, $v0, $zero
    /* 29228 80038A28 00140200 */  sll        $v0, $v0, 16
    /* 2922C 80038A2C 03140200 */  sra        $v0, $v0, 16
    /* 29230 80038A30 10004228 */  slti       $v0, $v0, 0x10
    /* 29234 80038A34 EDFF4014 */  bnez       $v0, .L800389EC
    /* 29238 80038A38 00341000 */   sll       $a2, $s0, 16
    /* 2923C 80038A3C 780020AE */  sw         $zero, 0x78($s1)
    /* 29240 80038A40 21202002 */  addu       $a0, $s1, $zero
    /* 29244 80038A44 56DC000C */  jal        SetState__11tScreenMain16tScreenMainState
    /* 29248 80038A48 01000524 */   addiu     $a1, $zero, 0x1
    /* 2924C 80038A4C 21800000 */  addu       $s0, $zero, $zero
    /* 29250 80038A50 00141000 */  sll        $v0, $s0, 16
  .L80038A54:
    /* 29254 80038A54 83130200 */  sra        $v0, $v0, 14
    /* 29258 80038A58 21102202 */  addu       $v0, $s1, $v0
    /* 2925C 80038A5C 7C0340AC */  sw         $zero, 0x37C($v0)
    /* 29260 80038A60 01000226 */  addiu      $v0, $s0, 0x1
    /* 29264 80038A64 21804000 */  addu       $s0, $v0, $zero
    /* 29268 80038A68 00140200 */  sll        $v0, $v0, 16
    /* 2926C 80038A6C 03140200 */  sra        $v0, $v0, 16
    /* 29270 80038A70 10004228 */  slti       $v0, $v0, 0x10
    /* 29274 80038A74 F7FF4014 */  bnez       $v0, .L80038A54
    /* 29278 80038A78 00141000 */   sll       $v0, $s0, 16
    /* 2927C 80038A7C 21800000 */  addu       $s0, $zero, $zero
    /* 29280 80038A80 0580023C */  lui        $v0, %hi(D_80052B90)
    /* 29284 80038A84 902B5124 */  addiu      $s1, $v0, %lo(D_80052B90)
  .L80038A88:
    /* 29288 80038A88 B5AA030C */  jal        rand
    /* 2928C 80038A8C 00000000 */   nop
    /* 29290 80038A90 001C1000 */  sll        $v1, $s0, 16
    /* 29294 80038A94 031C0300 */  sra        $v1, $v1, 16
    /* 29298 80038A98 21187100 */  addu       $v1, $v1, $s1
    /* 2929C 80038A9C 000062A0 */  sb         $v0, 0x0($v1)
    /* 292A0 80038AA0 01000226 */  addiu      $v0, $s0, 0x1
    /* 292A4 80038AA4 21804000 */  addu       $s0, $v0, $zero
    /* 292A8 80038AA8 00140200 */  sll        $v0, $v0, 16
    /* 292AC 80038AAC 03140200 */  sra        $v0, $v0, 16
    /* 292B0 80038AB0 19004228 */  slti       $v0, $v0, 0x19
    /* 292B4 80038AB4 F4FF4014 */  bnez       $v0, .L80038A88
    /* 292B8 80038AB8 00000000 */   nop
    /* 292BC 80038ABC 2800BF8F */  lw         $ra, 0x28($sp)
    /* 292C0 80038AC0 2400B38F */  lw         $s3, 0x24($sp)
    /* 292C4 80038AC4 2000B28F */  lw         $s2, 0x20($sp)
    /* 292C8 80038AC8 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 292CC 80038ACC 1800B08F */  lw         $s0, 0x18($sp)
    /* 292D0 80038AD0 0800E003 */  jr         $ra
    /* 292D4 80038AD4 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Initialize__11tScreenMain
