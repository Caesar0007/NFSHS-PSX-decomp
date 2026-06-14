.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GameSetup_StartUp__FPi, 0x384

glabel GameSetup_StartUp__FPi
    /* 8C59C 8009BD9C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 8C5A0 8009BDA0 1800B2AF */  sw         $s2, 0x18($sp)
    /* 8C5A4 8009BDA4 21908000 */  addu       $s2, $a0, $zero
    /* 8C5A8 8009BDA8 2400BFAF */  sw         $ra, 0x24($sp)
    /* 8C5AC 8009BDAC 2000B4AF */  sw         $s4, 0x20($sp)
    /* 8C5B0 8009BDB0 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 8C5B4 8009BDB4 1400B1AF */  sw         $s1, 0x14($sp)
    /* 8C5B8 8009BDB8 D170020C */  jal        Input_StartUp__Fv
    /* 8C5BC 8009BDBC 1000B0AF */   sw        $s0, 0x10($sp)
    /* 8C5C0 8009BDC0 21804002 */  addu       $s0, $s2, $zero
    /* 8C5C4 8009BDC4 1180023C */  lui        $v0, %hi(Input_gHandler)
    /* 8C5C8 8009BDC8 0000438E */  lw         $v1, 0x0($s2)
    /* 8C5CC 8009BDCC 00000000 */  nop
    /* 8C5D0 8009BDD0 71006010 */  beqz       $v1, .L8009BF98
    /* 8C5D4 8009BDD4 143C5424 */   addiu     $s4, $v0, %lo(Input_gHandler)
    /* 8C5D8 8009BDD8 1180113C */  lui        $s1, %hi(FEI_gList)
    /* 8C5DC 8009BDDC 1280023C */  lui        $v0, %hi(Device_gDeviceList)
    /* 8C5E0 8009BDE0 18EC5324 */  addiu      $s3, $v0, %lo(Device_gDeviceList)
  .L8009BDE4:
    /* 8C5E4 8009BDE4 0000058E */  lw         $a1, 0x0($s0)
    /* 8C5E8 8009BDE8 00000000 */  nop
    /* 8C5EC 8009BDEC 0301A228 */  slti       $v0, $a1, 0x103
    /* 8C5F0 8009BDF0 1E004014 */  bnez       $v0, .L8009BE6C
    /* 8C5F4 8009BDF4 4D00A228 */   slti      $v0, $a1, 0x4D
    /* 8C5F8 8009BDF8 9C272326 */  addiu      $v1, $s1, %lo(FEI_gList)
    /* 8C5FC 8009BDFC 9C27228E */  lw         $v0, %lo(FEI_gList)($s1)
    /* 8C600 8009BE00 00000000 */  nop
    /* 8C604 8009BE04 0B004010 */  beqz       $v0, .L8009BE34
    /* 8C608 8009BE08 21200000 */   addu      $a0, $zero, $zero
    /* 8C60C 8009BE0C 0000628C */  lw         $v0, 0x0($v1)
  .L8009BE10:
    /* 8C610 8009BE10 00000000 */  nop
    /* 8C614 8009BE14 02004514 */  bne        $v0, $a1, .L8009BE20
    /* 8C618 8009BE18 00000000 */   nop
    /* 8C61C 8009BE1C 0400648C */  lw         $a0, 0x4($v1)
  .L8009BE20:
    /* 8C620 8009BE20 08006324 */  addiu      $v1, $v1, 0x8
    /* 8C624 8009BE24 0000628C */  lw         $v0, 0x0($v1)
    /* 8C628 8009BE28 00000000 */  nop
    /* 8C62C 8009BE2C F8FF4014 */  bnez       $v0, .L8009BE10
    /* 8C630 8009BE30 00000000 */   nop
  .L8009BE34:
    /* 8C634 8009BE34 0B008010 */  beqz       $a0, .L8009BE64
    /* 8C638 8009BE38 00000000 */   nop
    /* 8C63C 8009BE3C 0400038E */  lw         $v1, 0x4($s0)
    /* 8C640 8009BE40 00000000 */  nop
    /* 8C644 8009BE44 40100300 */  sll        $v0, $v1, 1
    /* 8C648 8009BE48 21104300 */  addu       $v0, $v0, $v1
    /* 8C64C 8009BE4C 00190200 */  sll        $v1, $v0, 4
    /* 8C650 8009BE50 23186200 */  subu       $v1, $v1, $v0
    /* 8C654 8009BE54 80180300 */  sll        $v1, $v1, 2
    /* 8C658 8009BE58 0800028E */  lw         $v0, 0x8($s0)
    /* 8C65C 8009BE5C 21208300 */  addu       $a0, $a0, $v1
    /* 8C660 8009BE60 000082AC */  sw         $v0, 0x0($a0)
  .L8009BE64:
    /* 8C664 8009BE64 E26F0208 */  j          .L8009BF88
    /* 8C668 8009BE68 0C001026 */   addiu     $s0, $s0, 0xC
  .L8009BE6C:
    /* 8C66C 8009BE6C 14004014 */  bnez       $v0, .L8009BEC0
    /* 8C670 8009BE70 9C272326 */   addiu     $v1, $s1, %lo(FEI_gList)
    /* 8C674 8009BE74 80100500 */  sll        $v0, $a1, 2
    /* 8C678 8009BE78 0400038E */  lw         $v1, 0x4($s0)
    /* 8C67C 8009BE7C 21105400 */  addu       $v0, $v0, $s4
    /* 8C680 8009BE80 CCFE43AC */  sw         $v1, -0x134($v0)
    /* 8C684 8009BE84 0400048E */  lw         $a0, 0x4($s0)
    /* 8C688 8009BE88 00000000 */  nop
    /* 8C68C 8009BE8C FF008330 */  andi       $v1, $a0, 0xFF
    /* 8C690 8009BE90 40100300 */  sll        $v0, $v1, 1
    /* 8C694 8009BE94 21104300 */  addu       $v0, $v0, $v1
    /* 8C698 8009BE98 80100200 */  sll        $v0, $v0, 2
    /* 8C69C 8009BE9C 21105300 */  addu       $v0, $v0, $s3
    /* 8C6A0 8009BEA0 0800428C */  lw         $v0, 0x8($v0)
    /* 8C6A4 8009BEA4 00000000 */  nop
    /* 8C6A8 8009BEA8 36004010 */  beqz       $v0, .L8009BF84
    /* 8C6AC 8009BEAC 00000000 */   nop
    /* 8C6B0 8009BEB0 09F84000 */  jalr       $v0
    /* 8C6B4 8009BEB4 03220400 */   sra       $a0, $a0, 8
    /* 8C6B8 8009BEB8 E26F0208 */  j          .L8009BF88
    /* 8C6BC 8009BEBC 08001026 */   addiu     $s0, $s0, 0x8
  .L8009BEC0:
    /* 8C6C0 8009BEC0 9C27228E */  lw         $v0, %lo(FEI_gList)($s1)
    /* 8C6C4 8009BEC4 00000000 */  nop
    /* 8C6C8 8009BEC8 0B004010 */  beqz       $v0, .L8009BEF8
    /* 8C6CC 8009BECC 21200000 */   addu      $a0, $zero, $zero
    /* 8C6D0 8009BED0 0000628C */  lw         $v0, 0x0($v1)
  .L8009BED4:
    /* 8C6D4 8009BED4 00000000 */  nop
    /* 8C6D8 8009BED8 02004514 */  bne        $v0, $a1, .L8009BEE4
    /* 8C6DC 8009BEDC 00000000 */   nop
    /* 8C6E0 8009BEE0 0400648C */  lw         $a0, 0x4($v1)
  .L8009BEE4:
    /* 8C6E4 8009BEE4 08006324 */  addiu      $v1, $v1, 0x8
    /* 8C6E8 8009BEE8 0000628C */  lw         $v0, 0x0($v1)
    /* 8C6EC 8009BEEC 00000000 */  nop
    /* 8C6F0 8009BEF0 F8FF4014 */  bnez       $v0, .L8009BED4
    /* 8C6F4 8009BEF4 00000000 */   nop
  .L8009BEF8:
    /* 8C6F8 8009BEF8 19008010 */  beqz       $a0, .L8009BF60
    /* 8C6FC 8009BEFC 00000000 */   nop
    /* 8C700 8009BF00 0000028E */  lw         $v0, 0x0($s0)
    /* 8C704 8009BF04 00000000 */  nop
    /* 8C708 8009BF08 4B004228 */  slti       $v0, $v0, 0x4B
    /* 8C70C 8009BF0C 11004014 */  bnez       $v0, .L8009BF54
    /* 8C710 8009BF10 00000000 */   nop
    /* 8C714 8009BF14 0400028E */  lw         $v0, 0x4($s0)
    /* 8C718 8009BF18 00000000 */  nop
    /* 8C71C 8009BF1C 10004018 */  blez       $v0, .L8009BF60
    /* 8C720 8009BF20 21280000 */   addu      $a1, $zero, $zero
    /* 8C724 8009BF24 21180002 */  addu       $v1, $s0, $zero
  .L8009BF28:
    /* 8C728 8009BF28 0800628C */  lw         $v0, 0x8($v1)
    /* 8C72C 8009BF2C 04006324 */  addiu      $v1, $v1, 0x4
    /* 8C730 8009BF30 0100A524 */  addiu      $a1, $a1, 0x1
    /* 8C734 8009BF34 000082AC */  sw         $v0, 0x0($a0)
    /* 8C738 8009BF38 0400028E */  lw         $v0, 0x4($s0)
    /* 8C73C 8009BF3C 00000000 */  nop
    /* 8C740 8009BF40 2A10A200 */  slt        $v0, $a1, $v0
    /* 8C744 8009BF44 F8FF4014 */  bnez       $v0, .L8009BF28
    /* 8C748 8009BF48 04008424 */   addiu     $a0, $a0, 0x4
    /* 8C74C 8009BF4C D86F0208 */  j          .L8009BF60
    /* 8C750 8009BF50 00000000 */   nop
  .L8009BF54:
    /* 8C754 8009BF54 0400028E */  lw         $v0, 0x4($s0)
    /* 8C758 8009BF58 00000000 */  nop
    /* 8C75C 8009BF5C 000082AC */  sw         $v0, 0x0($a0)
  .L8009BF60:
    /* 8C760 8009BF60 0000028E */  lw         $v0, 0x0($s0)
    /* 8C764 8009BF64 00000000 */  nop
    /* 8C768 8009BF68 4B004228 */  slti       $v0, $v0, 0x4B
    /* 8C76C 8009BF6C 05004014 */  bnez       $v0, .L8009BF84
    /* 8C770 8009BF70 00000000 */   nop
    /* 8C774 8009BF74 0400028E */  lw         $v0, 0x4($s0)
    /* 8C778 8009BF78 00000000 */  nop
    /* 8C77C 8009BF7C 80100200 */  sll        $v0, $v0, 2
    /* 8C780 8009BF80 21800202 */  addu       $s0, $s0, $v0
  .L8009BF84:
    /* 8C784 8009BF84 08001026 */  addiu      $s0, $s0, 0x8
  .L8009BF88:
    /* 8C788 8009BF88 0000028E */  lw         $v0, 0x0($s0)
    /* 8C78C 8009BF8C 00000000 */  nop
    /* 8C790 8009BF90 94FF4014 */  bnez       $v0, .L8009BDE4
    /* 8C794 8009BF94 00000000 */   nop
  .L8009BF98:
    /* 8C798 8009BF98 5095030C */  jal        purgememadr
    /* 8C79C 8009BF9C 21204002 */   addu      $a0, $s2, $zero
    /* 8C7A0 8009BFA0 A1A0030C */  jal        timedwait
    /* 8C7A4 8009BFA4 64000424 */   addiu     $a0, $zero, 0x64
    /* 8C7A8 8009BFA8 8490030C */  jal        PAD_update
    /* 8C7AC 8009BFAC 00000000 */   nop
    /* 8C7B0 8009BFB0 6B90030C */  jal        PAD_state
    /* 8C7B4 8009BFB4 21200000 */   addu      $a0, $zero, $zero
    /* 8C7B8 8009BFB8 FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* 8C7BC 8009BFBC 09090324 */  addiu      $v1, $zero, 0x909
    /* 8C7C0 8009BFC0 03004314 */  bne        $v0, $v1, .L8009BFD0
    /* 8C7C4 8009BFC4 1180033C */   lui       $v1, %hi(D_80113224)
    /* 8C7C8 8009BFC8 08000224 */  addiu      $v0, $zero, 0x8
    /* 8C7CC 8009BFCC 243262AC */  sw         $v0, %lo(D_80113224)($v1)
  .L8009BFD0:
    /* 8C7D0 8009BFD0 6B90030C */  jal        PAD_state
    /* 8C7D4 8009BFD4 21200000 */   addu      $a0, $zero, $zero
    /* 8C7D8 8009BFD8 FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* 8C7DC 8009BFDC 80A00334 */  ori        $v1, $zero, 0xA080
    /* 8C7E0 8009BFE0 03004314 */  bne        $v0, $v1, .L8009BFF0
    /* 8C7E4 8009BFE4 1180033C */   lui       $v1, %hi(D_80113224)
    /* 8C7E8 8009BFE8 02000224 */  addiu      $v0, $zero, 0x2
    /* 8C7EC 8009BFEC 243262AC */  sw         $v0, %lo(D_80113224)($v1)
  .L8009BFF0:
    /* 8C7F0 8009BFF0 6B90030C */  jal        PAD_state
    /* 8C7F4 8009BFF4 21200000 */   addu      $a0, $zero, $zero
    /* 8C7F8 8009BFF8 FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* 8C7FC 8009BFFC 01C00334 */  ori        $v1, $zero, 0xC001
    /* 8C800 8009C000 03004314 */  bne        $v0, $v1, .L8009C010
    /* 8C804 8009C004 1180033C */   lui       $v1, %hi(D_80113224)
    /* 8C808 8009C008 04000224 */  addiu      $v0, $zero, 0x4
    /* 8C80C 8009C00C 243262AC */  sw         $v0, %lo(D_80113224)($v1)
  .L8009C010:
    /* 8C810 8009C010 6B90030C */  jal        PAD_state
    /* 8C814 8009C014 21200000 */   addu      $a0, $zero, $zero
    /* 8C818 8009C018 FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* 8C81C 8009C01C 40060324 */  addiu      $v1, $zero, 0x640
    /* 8C820 8009C020 03004314 */  bne        $v0, $v1, .L8009C030
    /* 8C824 8009C024 1180033C */   lui       $v1, %hi(D_80113224)
    /* 8C828 8009C028 10000224 */  addiu      $v0, $zero, 0x10
    /* 8C82C 8009C02C 243262AC */  sw         $v0, %lo(D_80113224)($v1)
  .L8009C030:
    /* 8C830 8009C030 6B90030C */  jal        PAD_state
    /* 8C834 8009C034 21200000 */   addu      $a0, $zero, $zero
    /* 8C838 8009C038 FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* 8C83C 8009C03C 10060324 */  addiu      $v1, $zero, 0x610
    /* 8C840 8009C040 03004314 */  bne        $v0, $v1, .L8009C050
    /* 8C844 8009C044 1180033C */   lui       $v1, %hi(D_80113224)
    /* 8C848 8009C048 20000224 */  addiu      $v0, $zero, 0x20
    /* 8C84C 8009C04C 243262AC */  sw         $v0, %lo(D_80113224)($v1)
  .L8009C050:
    /* 8C850 8009C050 6B90030C */  jal        PAD_state
    /* 8C854 8009C054 21200000 */   addu      $a0, $zero, $zero
    /* 8C858 8009C058 FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* 8C85C 8009C05C 10090324 */  addiu      $v1, $zero, 0x910
    /* 8C860 8009C060 03004314 */  bne        $v0, $v1, .L8009C070
    /* 8C864 8009C064 1180033C */   lui       $v1, %hi(D_80113224)
    /* 8C868 8009C068 40000224 */  addiu      $v0, $zero, 0x40
    /* 8C86C 8009C06C 243262AC */  sw         $v0, %lo(D_80113224)($v1)
  .L8009C070:
    /* 8C870 8009C070 6B90030C */  jal        PAD_state
    /* 8C874 8009C074 21200000 */   addu      $a0, $zero, $zero
    /* 8C878 8009C078 FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* 8C87C 8009C07C 10500324 */  addiu      $v1, $zero, 0x5010
    /* 8C880 8009C080 03004314 */  bne        $v0, $v1, .L8009C090
    /* 8C884 8009C084 1180033C */   lui       $v1, %hi(D_80113224)
    /* 8C888 8009C088 80000224 */  addiu      $v0, $zero, 0x80
    /* 8C88C 8009C08C 243262AC */  sw         $v0, %lo(D_80113224)($v1)
  .L8009C090:
    /* 8C890 8009C090 6B90030C */  jal        PAD_state
    /* 8C894 8009C094 21200000 */   addu      $a0, $zero, $zero
    /* 8C898 8009C098 FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* 8C89C 8009C09C 20060324 */  addiu      $v1, $zero, 0x620
    /* 8C8A0 8009C0A0 05004314 */  bne        $v0, $v1, .L8009C0B8
    /* 8C8A4 8009C0A4 1180023C */   lui       $v0, %hi(GameSetup_gData)
    /* 8C8A8 8009C0A8 1180033C */  lui        $v1, %hi(D_80113224)
    /* 8C8AC 8009C0AC 00010224 */  addiu      $v0, $zero, 0x100
    /* 8C8B0 8009C0B0 243262AC */  sw         $v0, %lo(D_80113224)($v1)
    /* 8C8B4 8009C0B4 1180023C */  lui        $v0, %hi(GameSetup_gData)
  .L8009C0B8:
    /* 8C8B8 8009C0B8 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* 8C8BC 8009C0BC F000438C */  lw         $v1, 0xF0($v0)
    /* 8C8C0 8009C0C0 F400448C */  lw         $a0, 0xF4($v0)
    /* 8C8C4 8009C0C4 FC00458C */  lw         $a1, 0xFC($v0)
    /* 8C8C8 8009C0C8 F800468C */  lw         $a2, 0xF8($v0)
    /* 8C8CC 8009C0CC 0001428C */  lw         $v0, 0x100($v0)
    /* 8C8D0 8009C0D0 1480013C */  lui        $at, %hi(gMasterMusicLevel)
    /* 8C8D4 8009C0D4 50C623AC */  sw         $v1, %lo(gMasterMusicLevel)($at)
    /* 8C8D8 8009C0D8 1480013C */  lui        $at, %hi(gMasterSFXLevel)
    /* 8C8DC 8009C0DC 54C624AC */  sw         $a0, %lo(gMasterSFXLevel)($at)
    /* 8C8E0 8009C0E0 1480013C */  lui        $at, %hi(gMasterFENarrationLevel)
    /* 8C8E4 8009C0E4 5CC625AC */  sw         $a1, %lo(gMasterFENarrationLevel)($at)
    /* 8C8E8 8009C0E8 1480013C */  lui        $at, %hi(gMasterEngineLevel)
    /* 8C8EC 8009C0EC 58C626AC */  sw         $a2, %lo(gMasterEngineLevel)($at)
    /* 8C8F0 8009C0F0 1480013C */  lui        $at, %hi(gMasterAmbientLevel)
    /* 8C8F4 8009C0F4 60C622AC */  sw         $v0, %lo(gMasterAmbientLevel)($at)
    /* 8C8F8 8009C0F8 78F5020C */  jal        Device_SetHardCodedKeys__Fv
    /* 8C8FC 8009C0FC 00000000 */   nop
    /* 8C900 8009C100 2400BF8F */  lw         $ra, 0x24($sp)
    /* 8C904 8009C104 2000B48F */  lw         $s4, 0x20($sp)
    /* 8C908 8009C108 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 8C90C 8009C10C 1800B28F */  lw         $s2, 0x18($sp)
    /* 8C910 8009C110 1400B18F */  lw         $s1, 0x14($sp)
    /* 8C914 8009C114 1000B08F */  lw         $s0, 0x10($sp)
    /* 8C918 8009C118 0800E003 */  jr         $ra
    /* 8C91C 8009C11C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel GameSetup_StartUp__FPi
