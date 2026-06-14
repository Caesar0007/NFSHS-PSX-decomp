.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_801088B0, 0x274

glabel func_801088B0
    /* F90B0 801088B0 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* F90B4 801088B4 2400B1AF */  sw         $s1, 0x24($sp)
    /* F90B8 801088B8 2188A000 */  addu       $s1, $a1, $zero
    /* F90BC 801088BC 1480033C */  lui        $v1, %hi(D_8013C290)
    /* F90C0 801088C0 90C26324 */  addiu      $v1, $v1, %lo(D_8013C290)
    /* F90C4 801088C4 FF008430 */  andi       $a0, $a0, 0xFF
    /* F90C8 801088C8 01000224 */  addiu      $v0, $zero, 0x1
    /* F90CC 801088CC 2800BFAF */  sw         $ra, 0x28($sp)
    /* F90D0 801088D0 2000B0AF */  sw         $s0, 0x20($sp)
    /* F90D4 801088D4 340071AC */  sw         $s1, 0x34($v1)
    /* F90D8 801088D8 4E008214 */  bne        $a0, $v0, .L80108A14
    /* F90DC 801088DC FFFF0224 */   addiu     $v0, $zero, -0x1
    /* F90E0 801088E0 1400628C */  lw         $v0, 0x14($v1)
    /* F90E4 801088E4 00000000 */  nop
    /* F90E8 801088E8 4B004018 */  blez       $v0, .L80108A18
    /* F90EC 801088EC 00000000 */   nop
    /* F90F0 801088F0 1000638C */  lw         $v1, 0x10($v1)
    /* F90F4 801088F4 00020224 */  addiu      $v0, $zero, 0x200
    /* F90F8 801088F8 23006214 */  bne        $v1, $v0, .L80108988
    /* F90FC 801088FC 00000000 */   nop
    /* F9100 80108900 1480023C */  lui        $v0, %hi(CD_read_dma_mode)
    /* F9104 80108904 D4C2428C */  lw         $v0, %lo(CD_read_dma_mode)($v0)
    /* F9108 80108908 00000000 */  nop
    /* F910C 8010890C 01004230 */  andi       $v0, $v0, 0x1
    /* F9110 80108910 0D004010 */  beqz       $v0, .L80108948
    /* F9114 80108914 1000A427 */   addiu     $a0, $sp, 0x10
    /* F9118 80108918 2CDF030C */  jal        CdDataCallback
    /* F911C 8010891C 21200000 */   addu      $a0, $zero, $zero
    /* F9120 80108920 1000A427 */  addiu      $a0, $sp, 0x10
    /* F9124 80108924 24DF030C */  jal        CdGetSector2
    /* F9128 80108928 03000524 */   addiu     $a1, $zero, 0x3
    /* F912C 8010892C 35DF030C */  jal        CdDataSync
    /* F9130 80108930 21200000 */   addu      $a0, $zero, $zero
    /* F9134 80108934 1180043C */  lui        $a0, %hi(func_80108B24)
    /* F9138 80108938 2CDF030C */  jal        CdDataCallback
    /* F913C 8010893C 248B8424 */   addiu     $a0, $a0, %lo(func_80108B24)
    /* F9140 80108940 54220408 */  j          .L80108950
    /* F9144 80108944 00000000 */   nop
  .L80108948:
    /* F9148 80108948 1CDF030C */  jal        CdGetSector
    /* F914C 8010894C 03000524 */   addiu     $a1, $zero, 0x3
  .L80108950:
    /* F9150 80108950 7EDF030C */  jal        CdPosToInt
    /* F9154 80108954 1000A427 */   addiu     $a0, $sp, 0x10
    /* F9158 80108958 1480103C */  lui        $s0, %hi(D_8013C2B0)
    /* F915C 8010895C B0C21026 */  addiu      $s0, $s0, %lo(D_8013C2B0)
    /* F9160 80108960 0000038E */  lw         $v1, 0x0($s0)
    /* F9164 80108964 00000000 */  nop
    /* F9168 80108968 07004310 */  beq        $v0, $v1, .L80108988
    /* F916C 8010896C 00000000 */   nop
    /* F9170 80108970 0580043C */  lui        $a0, %hi(D_80057898)
    /* F9174 80108974 33A0030C */  jal        puts
    /* F9178 80108978 98788424 */   addiu     $a0, $a0, %lo(D_80057898)
    /* F917C 8010897C E0FF0326 */  addiu      $v1, $s0, -0x20
    /* F9180 80108980 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* F9184 80108984 140062AC */  sw         $v0, 0x14($v1)
  .L80108988:
    /* F9188 80108988 1480023C */  lui        $v0, %hi(CD_read_dma_mode)
    /* F918C 8010898C D4C2428C */  lw         $v0, %lo(CD_read_dma_mode)($v0)
    /* F9190 80108990 00000000 */  nop
    /* F9194 80108994 01004230 */  andi       $v0, $v0, 0x1
    /* F9198 80108998 09004010 */  beqz       $v0, .L801089C0
    /* F919C 8010899C 00000000 */   nop
    /* F91A0 801089A0 1480023C */  lui        $v0, %hi(D_8013C298)
    /* F91A4 801089A4 98C24224 */  addiu      $v0, $v0, %lo(D_8013C298)
    /* F91A8 801089A8 0000448C */  lw         $a0, 0x0($v0)
    /* F91AC 801089AC 0800458C */  lw         $a1, 0x8($v0)
    /* F91B0 801089B0 24DF030C */  jal        CdGetSector2
    /* F91B4 801089B4 00000000 */   nop
    /* F91B8 801089B8 86220408 */  j          .L80108A18
    /* F91BC 801089BC 00000000 */   nop
  .L801089C0:
    /* F91C0 801089C0 1480103C */  lui        $s0, %hi(D_8013C298)
    /* F91C4 801089C4 98C21026 */  addiu      $s0, $s0, %lo(D_8013C298)
    /* F91C8 801089C8 0000048E */  lw         $a0, 0x0($s0)
    /* F91CC 801089CC 0800058E */  lw         $a1, 0x8($s0)
    /* F91D0 801089D0 1CDF030C */  jal        CdGetSector
    /* F91D4 801089D4 00000000 */   nop
    /* F91D8 801089D8 F8FF0426 */  addiu      $a0, $s0, -0x8
    /* F91DC 801089DC 0800028E */  lw         $v0, 0x8($s0)
    /* F91E0 801089E0 0000038E */  lw         $v1, 0x0($s0)
    /* F91E4 801089E4 80100200 */  sll        $v0, $v0, 2
    /* F91E8 801089E8 21186200 */  addu       $v1, $v1, $v0
    /* F91EC 801089EC 080083AC */  sw         $v1, 0x8($a0)
    /* F91F0 801089F0 1400828C */  lw         $v0, 0x14($a0)
    /* F91F4 801089F4 00000000 */  nop
    /* F91F8 801089F8 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* F91FC 801089FC 140082AC */  sw         $v0, 0x14($a0)
    /* F9200 80108A00 2000828C */  lw         $v0, 0x20($a0)
    /* F9204 80108A04 00000000 */  nop
    /* F9208 80108A08 01004224 */  addiu      $v0, $v0, 0x1
    /* F920C 80108A0C 86220408 */  j          .L80108A18
    /* F9210 80108A10 200082AC */   sw        $v0, 0x20($a0)
  .L80108A14:
    /* F9214 80108A14 140062AC */  sw         $v0, 0x14($v1)
  .L80108A18:
    /* F9218 80108A18 C7C8030C */  jal        VSync
    /* F921C 80108A1C FFFF0424 */   addiu     $a0, $zero, -0x1
    /* F9220 80108A20 1480103C */  lui        $s0, %hi(D_8013C290)
    /* F9224 80108A24 90C21026 */  addiu      $s0, $s0, %lo(D_8013C290)
    /* F9228 80108A28 180002AE */  sw         $v0, 0x18($s0)
    /* F922C 80108A2C 1400028E */  lw         $v0, 0x14($s0)
    /* F9230 80108A30 00000000 */  nop
    /* F9234 80108A34 03004104 */  bgez       $v0, .L80108A44
    /* F9238 80108A38 00000000 */   nop
    /* F923C 80108A3C FD22040C */  jal        func_80108BF4
    /* F9240 80108A40 01000424 */   addiu     $a0, $zero, 0x1
  .L80108A44:
    /* F9244 80108A44 C7C8030C */  jal        VSync
    /* F9248 80108A48 FFFF0424 */   addiu     $a0, $zero, -0x1
    /* F924C 80108A4C 1C00038E */  lw         $v1, 0x1C($s0)
    /* F9250 80108A50 00000000 */  nop
    /* F9254 80108A54 B0046324 */  addiu      $v1, $v1, 0x4B0
    /* F9258 80108A58 2A186200 */  slt        $v1, $v1, $v0
    /* F925C 80108A5C 02006010 */  beqz       $v1, .L80108A68
    /* F9260 80108A60 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* F9264 80108A64 140002AE */  sw         $v0, 0x14($s0)
  .L80108A68:
    /* F9268 80108A68 1400028E */  lw         $v0, 0x14($s0)
    /* F926C 80108A6C 00000000 */  nop
    /* F9270 80108A70 09004010 */  beqz       $v0, .L80108A98
    /* F9274 80108A74 00000000 */   nop
    /* F9278 80108A78 C7C8030C */  jal        VSync
    /* F927C 80108A7C FFFF0424 */   addiu     $a0, $zero, -0x1
    /* F9280 80108A80 1C00038E */  lw         $v1, 0x1C($s0)
    /* F9284 80108A84 00000000 */  nop
    /* F9288 80108A88 B0046324 */  addiu      $v1, $v1, 0x4B0
    /* F928C 80108A8C 2A186200 */  slt        $v1, $v1, $v0
    /* F9290 80108A90 1F006010 */  beqz       $v1, .L80108B10
    /* F9294 80108A94 00000000 */   nop
  .L80108A98:
    /* F9298 80108A98 2C00048E */  lw         $a0, 0x2C($s0)
    /* F929C 80108A9C 28DE030C */  jal        CdReadyCallback
    /* F92A0 80108AA0 00000000 */   nop
    /* F92A4 80108AA4 1480023C */  lui        $v0, %hi(CD_read_dma_mode)
    /* F92A8 80108AA8 D4C2428C */  lw         $v0, %lo(CD_read_dma_mode)($v0)
    /* F92AC 80108AAC 00000000 */  nop
    /* F92B0 80108AB0 01004230 */  andi       $v0, $v0, 0x1
    /* F92B4 80108AB4 04004010 */  beqz       $v0, .L80108AC8
    /* F92B8 80108AB8 00000000 */   nop
    /* F92BC 80108ABC 3000048E */  lw         $a0, 0x30($s0)
    /* F92C0 80108AC0 2CDF030C */  jal        CdDataCallback
    /* F92C4 80108AC4 00000000 */   nop
  .L80108AC8:
    /* F92C8 80108AC8 1180043C */  lui        $a0, %hi(func_8010887C)
    /* F92CC 80108ACC 23DE030C */  jal        CdSyncCallback
    /* F92D0 80108AD0 7C888424 */   addiu     $a0, $a0, %lo(func_8010887C)
    /* F92D4 80108AD4 09000424 */  addiu      $a0, $zero, 0x9
    /* F92D8 80108AD8 7CDE030C */  jal        CdControlF
    /* F92DC 80108ADC 21280000 */   addu      $a1, $zero, $zero
    /* F92E0 80108AE0 1480033C */  lui        $v1, %hi(CD_cbread)
    /* F92E4 80108AE4 D0C2638C */  lw         $v1, %lo(CD_cbread)($v1)
    /* F92E8 80108AE8 01000224 */  addiu      $v0, $zero, 0x1
    /* F92EC 80108AEC 08006010 */  beqz       $v1, .L80108B10
    /* F92F0 80108AF0 240002AE */   sw        $v0, 0x24($s0)
    /* F92F4 80108AF4 1400028E */  lw         $v0, 0x14($s0)
    /* F92F8 80108AF8 00000000 */  nop
    /* F92FC 80108AFC 02004014 */  bnez       $v0, .L80108B08
    /* F9300 80108B00 05000424 */   addiu     $a0, $zero, 0x5
    /* F9304 80108B04 02000424 */  addiu      $a0, $zero, 0x2
  .L80108B08:
    /* F9308 80108B08 09F86000 */  jalr       $v1
    /* F930C 80108B0C 21282002 */   addu      $a1, $s1, $zero
  .L80108B10:
    /* F9310 80108B10 2800BF8F */  lw         $ra, 0x28($sp)
    /* F9314 80108B14 2400B18F */  lw         $s1, 0x24($sp)
    /* F9318 80108B18 2000B08F */  lw         $s0, 0x20($sp)
    /* F931C 80108B1C 0800E003 */  jr         $ra
    /* F9320 80108B20 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel func_801088B0
