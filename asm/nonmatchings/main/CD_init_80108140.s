.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CD_init_80108140, 0x1E0

glabel CD_init_80108140
    /* F8940 80108140 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F8944 80108144 0580043C */  lui        $a0, %hi(D_80057868)
    /* F8948 80108148 68788424 */  addiu      $a0, $a0, %lo(D_80057868)
    /* F894C 8010814C 1000BFAF */  sw         $ra, 0x10($sp)
    /* F8950 80108150 33A0030C */  jal        puts
    /* F8954 80108154 00000000 */   nop
    /* F8958 80108158 0580043C */  lui        $a0, %hi(D_80057874)
    /* F895C 8010815C 74788424 */  addiu      $a0, $a0, %lo(D_80057874)
    /* F8960 80108160 1480053C */  lui        $a1, %hi(D_8013C228)
    /* F8964 80108164 2B0A040C */  jal        printf
    /* F8968 80108168 28C2A524 */   addiu     $a1, $a1, %lo(D_8013C228)
    /* F896C 8010816C 1480013C */  lui        $at, %hi(CD_com)
    /* F8970 80108170 65BF20A0 */  sb         $zero, %lo(CD_com)($at)
    /* F8974 80108174 1480013C */  lui        $at, %hi(CD_mode)
    /* F8978 80108178 64BF20A0 */  sb         $zero, %lo(CD_mode)($at)
    /* F897C 8010817C 1480013C */  lui        $at, %hi(CD_cbready)
    /* F8980 80108180 4CBF20AC */  sw         $zero, %lo(CD_cbready)($at)
    /* F8984 80108184 1480013C */  lui        $at, %hi(CD_cbsync)
    /* F8988 80108188 48BF20AC */  sw         $zero, %lo(CD_cbsync)($at)
    /* F898C 8010818C 1480013C */  lui        $at, %hi(CD_status1)
    /* F8990 80108190 58BF20AC */  sw         $zero, %lo(CD_status1)($at)
    /* F8994 80108194 1480013C */  lui        $at, %hi(CD_status)
    /* F8998 80108198 13CA030C */  jal        ResetCallback
    /* F899C 8010819C 54BF20AC */   sw        $zero, %lo(CD_status)($at)
    /* F89A0 801081A0 1180053C */  lui        $a1, %hi(func_80108680)
    /* F89A4 801081A4 8086A524 */  addiu      $a1, $a1, %lo(func_80108680)
    /* F89A8 801081A8 1FCA030C */  jal        InterruptCallback
    /* F89AC 801081AC 02000424 */   addiu     $a0, $zero, 0x2
    /* F89B0 801081B0 1480033C */  lui        $v1, %hi(D_8013C20C)
    /* F89B4 801081B4 0CC2638C */  lw         $v1, %lo(D_8013C20C)($v1)
    /* F89B8 801081B8 01000224 */  addiu      $v0, $zero, 0x1
    /* F89BC 801081BC 000062A0 */  sb         $v0, 0x0($v1)
    /* F89C0 801081C0 1480023C */  lui        $v0, %hi(D_8013C218)
    /* F89C4 801081C4 18C2428C */  lw         $v0, %lo(D_8013C218)($v0)
    /* F89C8 801081C8 00000000 */  nop
    /* F89CC 801081CC 00004290 */  lbu        $v0, 0x0($v0)
    /* F89D0 801081D0 00000000 */  nop
    /* F89D4 801081D4 07004230 */  andi       $v0, $v0, 0x7
    /* F89D8 801081D8 16004010 */  beqz       $v0, .L80108234
    /* F89DC 801081DC 01000424 */   addiu     $a0, $zero, 0x1
    /* F89E0 801081E0 07000324 */  addiu      $v1, $zero, 0x7
  .L801081E4:
    /* F89E4 801081E4 1480023C */  lui        $v0, %hi(D_8013C20C)
    /* F89E8 801081E8 0CC2428C */  lw         $v0, %lo(D_8013C20C)($v0)
    /* F89EC 801081EC 00000000 */  nop
    /* F89F0 801081F0 000044A0 */  sb         $a0, 0x0($v0)
    /* F89F4 801081F4 1480023C */  lui        $v0, %hi(D_8013C218)
    /* F89F8 801081F8 18C2428C */  lw         $v0, %lo(D_8013C218)($v0)
    /* F89FC 801081FC 00000000 */  nop
    /* F8A00 80108200 000043A0 */  sb         $v1, 0x0($v0)
    /* F8A04 80108204 1480023C */  lui        $v0, %hi(D_8013C214)
    /* F8A08 80108208 14C2428C */  lw         $v0, %lo(D_8013C214)($v0)
    /* F8A0C 8010820C 00000000 */  nop
    /* F8A10 80108210 000043A0 */  sb         $v1, 0x0($v0)
    /* F8A14 80108214 1480023C */  lui        $v0, %hi(D_8013C218)
    /* F8A18 80108218 18C2428C */  lw         $v0, %lo(D_8013C218)($v0)
    /* F8A1C 8010821C 00000000 */  nop
    /* F8A20 80108220 00004290 */  lbu        $v0, 0x0($v0)
    /* F8A24 80108224 00000000 */  nop
    /* F8A28 80108228 07004230 */  andi       $v0, $v0, 0x7
    /* F8A2C 8010822C EDFF4014 */  bnez       $v0, .L801081E4
    /* F8A30 80108230 00000000 */   nop
  .L80108234:
    /* F8A34 80108234 01000424 */  addiu      $a0, $zero, 0x1
    /* F8A38 80108238 21280000 */  addu       $a1, $zero, $zero
    /* F8A3C 8010823C 1480033C */  lui        $v1, %hi(D_8013C224)
    /* F8A40 80108240 24C26324 */  addiu      $v1, $v1, %lo(D_8013C224)
    /* F8A44 80108244 020060A0 */  sb         $zero, 0x2($v1)
    /* F8A48 80108248 02006290 */  lbu        $v0, 0x2($v1)
    /* F8A4C 8010824C 21300000 */  addu       $a2, $zero, $zero
    /* F8A50 80108250 010062A0 */  sb         $v0, 0x1($v1)
    /* F8A54 80108254 1480073C */  lui        $a3, %hi(D_8013C20C)
    /* F8A58 80108258 0CC2E78C */  lw         $a3, %lo(D_8013C20C)($a3)
    /* F8A5C 8010825C 02000224 */  addiu      $v0, $zero, 0x2
    /* F8A60 80108260 000062A0 */  sb         $v0, 0x0($v1)
    /* F8A64 80108264 0000E0A0 */  sb         $zero, 0x0($a3)
    /* F8A68 80108268 1480023C */  lui        $v0, %hi(D_8013C218)
    /* F8A6C 8010826C 18C2428C */  lw         $v0, %lo(D_8013C218)($v0)
    /* F8A70 80108270 21380000 */  addu       $a3, $zero, $zero
    /* F8A74 80108274 000040A0 */  sb         $zero, 0x0($v0)
    /* F8A78 80108278 1480033C */  lui        $v1, %hi(D_8013C21C)
    /* F8A7C 8010827C 1CC2638C */  lw         $v1, %lo(D_8013C21C)($v1)
    /* F8A80 80108280 25130224 */  addiu      $v0, $zero, 0x1325
    /* F8A84 80108284 C91E040C */  jal        CD_cw
    /* F8A88 80108288 000062AC */   sw        $v0, 0x0($v1)
    /* F8A8C 8010828C 1480023C */  lui        $v0, %hi(CD_status)
    /* F8A90 80108290 54BF428C */  lw         $v0, %lo(CD_status)($v0)
    /* F8A94 80108294 00000000 */  nop
    /* F8A98 80108298 10004230 */  andi       $v0, $v0, 0x10
    /* F8A9C 8010829C 05004010 */  beqz       $v0, .L801082B4
    /* F8AA0 801082A0 01000424 */   addiu     $a0, $zero, 0x1
    /* F8AA4 801082A4 21280000 */  addu       $a1, $zero, $zero
    /* F8AA8 801082A8 21300000 */  addu       $a2, $zero, $zero
    /* F8AAC 801082AC C91E040C */  jal        CD_cw
    /* F8AB0 801082B0 21380000 */   addu      $a3, $zero, $zero
  .L801082B4:
    /* F8AB4 801082B4 0A000424 */  addiu      $a0, $zero, 0xA
    /* F8AB8 801082B8 21280000 */  addu       $a1, $zero, $zero
    /* F8ABC 801082BC 21300000 */  addu       $a2, $zero, $zero
    /* F8AC0 801082C0 C91E040C */  jal        CD_cw
    /* F8AC4 801082C4 21380000 */   addu      $a3, $zero, $zero
    /* F8AC8 801082C8 11004014 */  bnez       $v0, .L80108310
    /* F8ACC 801082CC FFFF0224 */   addiu     $v0, $zero, -0x1
    /* F8AD0 801082D0 0C000424 */  addiu      $a0, $zero, 0xC
    /* F8AD4 801082D4 21280000 */  addu       $a1, $zero, $zero
    /* F8AD8 801082D8 21300000 */  addu       $a2, $zero, $zero
    /* F8ADC 801082DC C91E040C */  jal        CD_cw
    /* F8AE0 801082E0 21380000 */   addu      $a3, $zero, $zero
    /* F8AE4 801082E4 09004014 */  bnez       $v0, .L8010830C
    /* F8AE8 801082E8 21200000 */   addu      $a0, $zero, $zero
    /* F8AEC 801082EC 771D040C */  jal        CD_sync
    /* F8AF0 801082F0 21280000 */   addu      $a1, $zero, $zero
    /* F8AF4 801082F4 21204000 */  addu       $a0, $v0, $zero
    /* F8AF8 801082F8 02000324 */  addiu      $v1, $zero, 0x2
    /* F8AFC 801082FC 04008314 */  bne        $a0, $v1, .L80108310
    /* F8B00 80108300 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* F8B04 80108304 C4200408 */  j          .L80108310
    /* F8B08 80108308 21100000 */   addu      $v0, $zero, $zero
  .L8010830C:
    /* F8B0C 8010830C FFFF0224 */  addiu      $v0, $zero, -0x1
  .L80108310:
    /* F8B10 80108310 1000BF8F */  lw         $ra, 0x10($sp)
    /* F8B14 80108314 1800BD27 */  addiu      $sp, $sp, 0x18
    /* F8B18 80108318 0800E003 */  jr         $ra
    /* F8B1C 8010831C 00000000 */   nop
endlabel CD_init_80108140
