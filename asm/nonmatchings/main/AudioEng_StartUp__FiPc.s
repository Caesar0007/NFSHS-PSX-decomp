.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioEng_StartUp__FiPc, 0x5E0

glabel AudioEng_StartUp__FiPc
    /* 6C654 8007BE54 68FFBD27 */  addiu      $sp, $sp, -0x98
    /* 6C658 8007BE58 8C00B7AF */  sw         $s7, 0x8C($sp)
    /* 6C65C 8007BE5C 21B88000 */  addu       $s7, $a0, $zero
    /* 6C660 8007BE60 7C00B3AF */  sw         $s3, 0x7C($sp)
    /* 6C664 8007BE64 2198A000 */  addu       $s3, $a1, $zero
    /* 6C668 8007BE68 0200E22E */  sltiu      $v0, $s7, 0x2
    /* 6C66C 8007BE6C 9400BFAF */  sw         $ra, 0x94($sp)
    /* 6C670 8007BE70 9000BEAF */  sw         $fp, 0x90($sp)
    /* 6C674 8007BE74 8800B6AF */  sw         $s6, 0x88($sp)
    /* 6C678 8007BE78 8400B5AF */  sw         $s5, 0x84($sp)
    /* 6C67C 8007BE7C 8000B4AF */  sw         $s4, 0x80($sp)
    /* 6C680 8007BE80 7800B2AF */  sw         $s2, 0x78($sp)
    /* 6C684 8007BE84 7400B1AF */  sw         $s1, 0x74($sp)
    /* 6C688 8007BE88 09004010 */  beqz       $v0, .L8007BEB0
    /* 6C68C 8007BE8C 7000B0AF */   sw        $s0, 0x70($sp)
    /* 6C690 8007BE90 80101700 */  sll        $v0, $s7, 2
    /* 6C694 8007BE94 1480033C */  lui        $v1, %hi(AudioEng_g)
    /* 6C698 8007BE98 34C76324 */  addiu      $v1, $v1, %lo(AudioEng_g)
    /* 6C69C 8007BE9C 21804300 */  addu       $s0, $v0, $v1
    /* 6C6A0 8007BEA0 0000028E */  lw         $v0, 0x0($s0)
    /* 6C6A4 8007BEA4 00000000 */  nop
    /* 6C6A8 8007BEA8 03004010 */  beqz       $v0, .L8007BEB8
    /* 6C6AC 8007BEAC 21A80000 */   addu      $s5, $zero, $zero
  .L8007BEB0:
    /* 6C6B0 8007BEB0 01F10108 */  j          .L8007C404
    /* 6C6B4 8007BEB4 21100000 */   addu      $v0, $zero, $zero
  .L8007BEB8:
    /* 6C6B8 8007BEB8 21F0A002 */  addu       $fp, $s5, $zero
    /* 6C6BC 8007BEBC 0580043C */  lui        $a0, %hi(D_80055800)
    /* 6C6C0 8007BEC0 00588424 */  addiu      $a0, $a0, %lo(D_80055800)
    /* 6C6C4 8007BEC4 70030524 */  addiu      $a1, $zero, 0x370
    /* 6C6C8 8007BEC8 CF94030C */  jal        reservememadr
    /* 6C6CC 8007BECC 2130A002 */   addu      $a2, $s5, $zero
    /* 6C6D0 8007BED0 2188A002 */  addu       $s1, $s5, $zero
    /* 6C6D4 8007BED4 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 6C6D8 8007BED8 00020624 */  addiu      $a2, $zero, 0x200
    /* 6C6DC 8007BEDC 21904000 */  addu       $s2, $v0, $zero
    /* 6C6E0 8007BEE0 21184002 */  addu       $v1, $s2, $zero
    /* 6C6E4 8007BEE4 21204002 */  addu       $a0, $s2, $zero
    /* 6C6E8 8007BEE8 00100224 */  addiu      $v0, $zero, 0x1000
    /* 6C6EC 8007BEEC 000012AE */  sw         $s2, 0x0($s0)
    /* 6C6F0 8007BEF0 6C0340AE */  sw         $zero, 0x36C($s2)
    /* 6C6F4 8007BEF4 080040AE */  sw         $zero, 0x8($s2)
    /* 6C6F8 8007BEF8 4C0040AE */  sw         $zero, 0x4C($s2)
    /* 6C6FC 8007BEFC 500040AE */  sw         $zero, 0x50($s2)
    /* 6C700 8007BF00 540042AE */  sw         $v0, 0x54($s2)
  .L8007BF04:
    /* 6C704 8007BF04 0C0080AC */  sw         $zero, 0xC($a0)
    /* 6C708 8007BF08 E40165AC */  sw         $a1, 0x1E4($v1)
    /* 6C70C 8007BF0C A40265AC */  sw         $a1, 0x2A4($v1)
    /* 6C710 8007BF10 240165A0 */  sb         $a1, 0x124($v1)
    /* 6C714 8007BF14 1C0166A4 */  sh         $a2, 0x11C($v1)
    /* 6C718 8007BF18 1E0166A4 */  sh         $a2, 0x11E($v1)
    /* 6C71C 8007BF1C 200160AC */  sw         $zero, 0x120($v1)
    /* 6C720 8007BF20 0C006324 */  addiu      $v1, $v1, 0xC
    /* 6C724 8007BF24 01003126 */  addiu      $s1, $s1, 0x1
    /* 6C728 8007BF28 1000222A */  slti       $v0, $s1, 0x10
    /* 6C72C 8007BF2C F5FF4014 */  bnez       $v0, .L8007BF04
    /* 6C730 8007BF30 04008424 */   addiu     $a0, $a0, 0x4
    /* 6C734 8007BF34 32000224 */  addiu      $v0, $zero, 0x32
    /* 6C738 8007BF38 6800A0AF */  sw         $zero, 0x68($sp)
    /* 6C73C 8007BF3C 6400A0AF */  sw         $zero, 0x64($sp)
    /* 6C740 8007BF40 000042A2 */  sb         $v0, 0x0($s2)
    /* 6C744 8007BF44 1F000224 */  addiu      $v0, $zero, 0x1F
    /* 6C748 8007BF48 010042A2 */  sb         $v0, 0x1($s2)
    /* 6C74C 8007BF4C A6000224 */  addiu      $v0, $zero, 0xA6
    /* 6C750 8007BF50 050042A2 */  sb         $v0, 0x5($s2)
    /* 6C754 8007BF54 2B000224 */  addiu      $v0, $zero, 0x2B
    /* 6C758 8007BF58 020042A2 */  sb         $v0, 0x2($s2)
    /* 6C75C 8007BF5C 40000224 */  addiu      $v0, $zero, 0x40
    /* 6C760 8007BF60 030042A2 */  sb         $v0, 0x3($s2)
    /* 6C764 8007BF64 79000224 */  addiu      $v0, $zero, 0x79
    /* 6C768 8007BF68 040042A2 */  sb         $v0, 0x4($s2)
    /* 6C76C 8007BF6C 50000224 */  addiu      $v0, $zero, 0x50
    /* 6C770 8007BF70 060042A2 */  sb         $v0, 0x6($s2)
    /* 6C774 8007BF74 68000224 */  addiu      $v0, $zero, 0x68
    /* 6C778 8007BF78 070042A2 */  sb         $v0, 0x7($s2)
    /* 6C77C 8007BF7C 1180023C */  lui        $v0, %hi(D_801131F8)
    /* 6C780 8007BF80 1A0140A2 */  sb         $zero, 0x11A($s2)
    /* 6C784 8007BF84 1B0140A2 */  sb         $zero, 0x11B($s2)
    /* 6C788 8007BF88 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* 6C78C 8007BF8C 01000224 */  addiu      $v0, $zero, 0x1
    /* 6C790 8007BF90 05006214 */  bne        $v1, $v0, .L8007BFA8
    /* 6C794 8007BF94 21B00000 */   addu      $s6, $zero, $zero
    /* 6C798 8007BF98 1800A427 */  addiu      $a0, $sp, 0x18
    /* 6C79C 8007BF9C 0580053C */  lui        $a1, %hi(D_80055810)
    /* 6C7A0 8007BFA0 EDEF0108 */  j          .L8007BFB4
    /* 6C7A4 8007BFA4 1058A524 */   addiu     $a1, $a1, %lo(D_80055810)
  .L8007BFA8:
    /* 6C7A8 8007BFA8 1800A427 */  addiu      $a0, $sp, 0x18
    /* 6C7AC 8007BFAC 0580053C */  lui        $a1, %hi(D_8005581C)
    /* 6C7B0 8007BFB0 1C58A524 */  addiu      $a1, $a1, %lo(D_8005581C)
  .L8007BFB4:
    /* 6C7B4 8007BFB4 1180023C */  lui        $v0, %hi(D_801164D8)
    /* 6C7B8 8007BFB8 D864468C */  lw         $a2, %lo(D_801164D8)($v0)
    /* 6C7BC 8007BFBC 2F91030C */  jal        sprintf
    /* 6C7C0 8007BFC0 21386002 */   addu      $a3, $s3, $zero
    /* 6C7C4 8007BFC4 1800A427 */  addiu      $a0, $sp, 0x18
    /* 6C7C8 8007BFC8 9F96030C */  jal        loadbigfileheader
    /* 6C7CC 8007BFCC 10000524 */   addiu     $a1, $zero, 0x10
    /* 6C7D0 8007BFD0 21A04000 */  addu       $s4, $v0, $zero
    /* 6C7D4 8007BFD4 17008016 */  bnez       $s4, .L8007C034
    /* 6C7D8 8007BFD8 1800A427 */   addiu     $a0, $sp, 0x18
    /* 6C7DC 8007BFDC 1180023C */  lui        $v0, %hi(D_801131F8)
    /* 6C7E0 8007BFE0 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* 6C7E4 8007BFE4 01000224 */  addiu      $v0, $zero, 0x1
    /* 6C7E8 8007BFE8 06006214 */  bne        $v1, $v0, .L8007C004
    /* 6C7EC 8007BFEC 1180023C */   lui       $v0, %hi(D_801164D8)
    /* 6C7F0 8007BFF0 1800A427 */  addiu      $a0, $sp, 0x18
    /* 6C7F4 8007BFF4 D864468C */  lw         $a2, %lo(D_801164D8)($v0)
    /* 6C7F8 8007BFF8 0580053C */  lui        $a1, %hi(D_80055828)
    /* 6C7FC 8007BFFC 04F00108 */  j          .L8007C010
    /* 6C800 8007C000 2858A524 */   addiu     $a1, $a1, %lo(D_80055828)
  .L8007C004:
    /* 6C804 8007C004 D864468C */  lw         $a2, %lo(D_801164D8)($v0)
    /* 6C808 8007C008 0580053C */  lui        $a1, %hi(D_80055838)
    /* 6C80C 8007C00C 3858A524 */  addiu      $a1, $a1, %lo(D_80055838)
  .L8007C010:
    /* 6C810 8007C010 2F91030C */  jal        sprintf
    /* 6C814 8007C014 00000000 */   nop
    /* 6C818 8007C018 1800A427 */  addiu      $a0, $sp, 0x18
    /* 6C81C 8007C01C 9F96030C */  jal        loadbigfileheader
    /* 6C820 8007C020 10000524 */   addiu     $a1, $zero, 0x10
    /* 6C824 8007C024 21A04000 */  addu       $s4, $v0, $zero
    /* 6C828 8007C028 60008012 */  beqz       $s4, .L8007C1AC
    /* 6C82C 8007C02C 00000000 */   nop
    /* 6C830 8007C030 1800A427 */  addiu      $a0, $sp, 0x18
  .L8007C034:
    /* 6C834 8007C034 01000524 */  addiu      $a1, $zero, 0x1
    /* 6C838 8007C038 64000624 */  addiu      $a2, $zero, 0x64
    /* 6C83C 8007C03C 2AAA030C */  jal        FILE_opensync
    /* 6C840 8007C040 5800A727 */   addiu     $a3, $sp, 0x58
    /* 6C844 8007C044 21980000 */  addu       $s3, $zero, $zero
  .L8007C048:
    /* 6C848 8007C048 9698030C */  jal        bigcount
    /* 6C84C 8007C04C 21208002 */   addu      $a0, $s4, $zero
    /* 6C850 8007C050 2A106202 */  slt        $v0, $s3, $v0
    /* 6C854 8007C054 50004010 */  beqz       $v0, .L8007C198
    /* 6C858 8007C058 6000A227 */   addiu     $v0, $sp, 0x60
    /* 6C85C 8007C05C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 6C860 8007C060 21208002 */  addu       $a0, $s4, $zero
    /* 6C864 8007C064 21280000 */  addu       $a1, $zero, $zero
    /* 6C868 8007C068 21306002 */  addu       $a2, $s3, $zero
    /* 6C86C 8007C06C 6E98030C */  jal        locatebigentry
    /* 6C870 8007C070 5C00A727 */   addiu     $a3, $sp, 0x5C
    /* 6C874 8007C074 21884000 */  addu       $s1, $v0, $zero
    /* 6C878 8007C078 21202002 */  addu       $a0, $s1, $zero
    /* 6C87C 8007C07C 1480053C */  lui        $a1, %hi(D_8013C73C)
    /* 6C880 8007C080 6FA2030C */  jal        wildcard
    /* 6C884 8007C084 3CC7A524 */   addiu     $a1, $a1, %lo(D_8013C73C)
    /* 6C888 8007C088 20004010 */  beqz       $v0, .L8007C10C
    /* 6C88C 8007C08C 21202002 */   addu      $a0, $s1, $zero
    /* 6C890 8007C090 1F00C016 */  bnez       $s6, .L8007C110
    /* 6C894 8007C094 1480053C */   lui       $a1, %hi(D_8013C744)
    /* 6C898 8007C098 21202002 */  addu       $a0, $s1, $zero
    /* 6C89C 8007C09C 6000A58F */  lw         $a1, 0x60($sp)
    /* 6C8A0 8007C0A0 CF94030C */  jal        reservememadr
    /* 6C8A4 8007C0A4 10000624 */   addiu     $a2, $zero, 0x10
    /* 6C8A8 8007C0A8 21804000 */  addu       $s0, $v0, $zero
    /* 6C8AC 8007C0AC 38000012 */  beqz       $s0, .L8007C190
    /* 6C8B0 8007C0B0 21300002 */   addu      $a2, $s0, $zero
    /* 6C8B4 8007C0B4 01001624 */  addiu      $s6, $zero, 0x1
    /* 6C8B8 8007C0B8 5800A48F */  lw         $a0, 0x58($sp)
    /* 6C8BC 8007C0BC 5C00A58F */  lw         $a1, 0x5C($sp)
    /* 6C8C0 8007C0C0 6000A78F */  lw         $a3, 0x60($sp)
    /* 6C8C4 8007C0C4 64000224 */  addiu      $v0, $zero, 0x64
    /* 6C8C8 8007C0C8 48AA030C */  jal        FILE_readsync
    /* 6C8CC 8007C0CC 1000A2AF */   sw        $v0, 0x10($sp)
    /* 6C8D0 8007C0D0 21202002 */  addu       $a0, $s1, $zero
    /* 6C8D4 8007C0D4 21300002 */  addu       $a2, $s0, $zero
    /* 6C8D8 8007C0D8 6000A58F */  lw         $a1, 0x60($sp)
    /* 6C8DC 8007C0DC 59EF020C */  jal        AudioCmn_AddBank__FPciT0i
    /* 6C8E0 8007C0E0 2138E002 */   addu      $a3, $s7, $zero
    /* 6C8E4 8007C0E4 0418D702 */  sllv       $v1, $s7, $s6
    /* 6C8E8 8007C0E8 21187700 */  addu       $v1, $v1, $s7
    /* 6C8EC 8007C0EC 80180300 */  sll        $v1, $v1, 2
    /* 6C8F0 8007C0F0 11800D3C */  lui        $t5, %hi(gSndBnk)
    /* 6C8F4 8007C0F4 A8E8AD25 */  addiu      $t5, $t5, %lo(gSndBnk)
    /* 6C8F8 8007C0F8 21186D00 */  addu       $v1, $v1, $t5
    /* 6C8FC 8007C0FC 00006390 */  lbu        $v1, 0x0($v1)
    /* 6C900 8007C100 21F04000 */  addu       $fp, $v0, $zero
    /* 6C904 8007C104 64F00108 */  j          .L8007C190
    /* 6C908 8007C108 580043A2 */   sb        $v1, 0x58($s2)
  .L8007C10C:
    /* 6C90C 8007C10C 1480053C */  lui        $a1, %hi(D_8013C744)
  .L8007C110:
    /* 6C910 8007C110 6FA2030C */  jal        wildcard
    /* 6C914 8007C114 44C7A524 */   addiu     $a1, $a1, %lo(D_8013C744)
    /* 6C918 8007C118 0B004010 */  beqz       $v0, .L8007C148
    /* 6C91C 8007C11C 00000000 */   nop
    /* 6C920 8007C120 6400A28F */  lw         $v0, 0x64($sp)
    /* 6C924 8007C124 00000000 */  nop
    /* 6C928 8007C128 07004014 */  bnez       $v0, .L8007C148
    /* 6C92C 8007C12C 1800A427 */   addiu     $a0, $sp, 0x18
    /* 6C930 8007C130 21282002 */  addu       $a1, $s1, $zero
    /* 6C934 8007C134 5800A68F */  lw         $a2, 0x58($sp)
    /* 6C938 8007C138 5C00A78F */  lw         $a3, 0x5C($sp)
    /* 6C93C 8007C13C 6000A38F */  lw         $v1, 0x60($sp)
    /* 6C940 8007C140 61F00108 */  j          .L8007C184
    /* 6C944 8007C144 6400A227 */   addiu     $v0, $sp, 0x64
  .L8007C148:
    /* 6C948 8007C148 21202002 */  addu       $a0, $s1, $zero
    /* 6C94C 8007C14C 1480053C */  lui        $a1, %hi(D_8013C74C)
    /* 6C950 8007C150 6FA2030C */  jal        wildcard
    /* 6C954 8007C154 4CC7A524 */   addiu     $a1, $a1, %lo(D_8013C74C)
    /* 6C958 8007C158 0D004010 */  beqz       $v0, .L8007C190
    /* 6C95C 8007C15C 00000000 */   nop
    /* 6C960 8007C160 6800A28F */  lw         $v0, 0x68($sp)
    /* 6C964 8007C164 00000000 */  nop
    /* 6C968 8007C168 09004014 */  bnez       $v0, .L8007C190
    /* 6C96C 8007C16C 1800A427 */   addiu     $a0, $sp, 0x18
    /* 6C970 8007C170 21282002 */  addu       $a1, $s1, $zero
    /* 6C974 8007C174 5800A68F */  lw         $a2, 0x58($sp)
    /* 6C978 8007C178 5C00A78F */  lw         $a3, 0x5C($sp)
    /* 6C97C 8007C17C 6000A38F */  lw         $v1, 0x60($sp)
    /* 6C980 8007C180 6800A227 */  addiu      $v0, $sp, 0x68
  .L8007C184:
    /* 6C984 8007C184 1400A2AF */  sw         $v0, 0x14($sp)
    /* 6C988 8007C188 77EF010C */  jal        AudioEng_LoadDef__FPcT0illPP13AudioEng_tDef
    /* 6C98C 8007C18C 1000A3AF */   sw        $v1, 0x10($sp)
  .L8007C190:
    /* 6C990 8007C190 12F00108 */  j          .L8007C048
    /* 6C994 8007C194 01007326 */   addiu     $s3, $s3, 0x1
  .L8007C198:
    /* 6C998 8007C198 5800A48F */  lw         $a0, 0x58($sp)
    /* 6C99C 8007C19C 54AA030C */  jal        FILE_closesync
    /* 6C9A0 8007C1A0 64000524 */   addiu     $a1, $zero, 0x64
    /* 6C9A4 8007C1A4 5095030C */  jal        purgememadr
    /* 6C9A8 8007C1A8 21208002 */   addu      $a0, $s4, $zero
  .L8007C1AC:
    /* 6C9AC 8007C1AC 9500C012 */  beqz       $s6, .L8007C404
    /* 6C9B0 8007C1B0 2110C003 */   addu      $v0, $fp, $zero
    /* 6C9B4 8007C1B4 6800A28F */  lw         $v0, 0x68($sp)
    /* 6C9B8 8007C1B8 00000000 */  nop
    /* 6C9BC 8007C1BC 91004010 */  beqz       $v0, .L8007C404
    /* 6C9C0 8007C1C0 2110C003 */   addu      $v0, $fp, $zero
    /* 6C9C4 8007C1C4 6400A28F */  lw         $v0, 0x64($sp)
    /* 6C9C8 8007C1C8 00000000 */  nop
    /* 6C9CC 8007C1CC 8C004010 */  beqz       $v0, .L8007C400
    /* 6C9D0 8007C1D0 21580000 */   addu      $t3, $zero, $zero
    /* 6C9D4 8007C1D4 1C014C26 */  addiu      $t4, $s2, 0x11C
  .L8007C1D8:
    /* 6C9D8 8007C1D8 02006229 */  slti       $v0, $t3, 0x2
    /* 6C9DC 8007C1DC 56004010 */  beqz       $v0, .L8007C338
    /* 6C9E0 8007C1E0 2128A002 */   addu      $a1, $s5, $zero
    /* 6C9E4 8007C1E4 04006011 */  beqz       $t3, .L8007C1F8
    /* 6C9E8 8007C1E8 00000000 */   nop
    /* 6C9EC 8007C1EC 6400A78F */  lw         $a3, 0x64($sp)
    /* 6C9F0 8007C1F0 7FF00108 */  j          .L8007C1FC
    /* 6C9F4 8007C1F4 00000000 */   nop
  .L8007C1F8:
    /* 6C9F8 8007C1F8 6800A78F */  lw         $a3, 0x68($sp)
  .L8007C1FC:
    /* 6C9FC 8007C1FC 00000000 */  nop
    /* 6CA00 8007C200 0500E290 */  lbu        $v0, 0x5($a3)
    /* 6CA04 8007C204 00000000 */  nop
    /* 6CA08 8007C208 49004014 */  bnez       $v0, .L8007C330
    /* 6CA0C 8007C20C 21880000 */   addu      $s1, $zero, $zero
    /* 6CA10 8007C210 2130E000 */  addu       $a2, $a3, $zero
    /* 6CA14 8007C214 21502002 */  addu       $t2, $s1, $zero
    /* 6CA18 8007C218 48010924 */  addiu      $t1, $zero, 0x148
    /* 6CA1C 8007C21C 28010824 */  addiu      $t0, $zero, 0x128
  .L8007C220:
    /* 6CA20 8007C220 0800222A */  slti       $v0, $s1, 0x8
    /* 6CA24 8007C224 42004010 */  beqz       $v0, .L8007C330
    /* 6CA28 8007C228 2128F100 */   addu      $a1, $a3, $s1
    /* 6CA2C 8007C22C 2000A280 */  lb         $v0, 0x20($a1)
    /* 6CA30 8007C230 00000000 */  nop
    /* 6CA34 8007C234 36004004 */  bltz       $v0, .L8007C310
    /* 6CA38 8007C238 2110E800 */   addu      $v0, $a3, $t0
    /* 6CA3C 8007C23C 2801C38C */  lw         $v1, 0x128($a2)
    /* 6CA40 8007C240 00000000 */  nop
    /* 6CA44 8007C244 21104300 */  addu       $v0, $v0, $v1
    /* 6CA48 8007C248 4801C38C */  lw         $v1, 0x148($a2)
    /* 6CA4C 8007C24C 21208A01 */  addu       $a0, $t4, $t2
    /* 6CA50 8007C250 2801C2AC */  sw         $v0, 0x128($a2)
    /* 6CA54 8007C254 2110E900 */  addu       $v0, $a3, $t1
    /* 6CA58 8007C258 21104300 */  addu       $v0, $v0, $v1
    /* 6CA5C 8007C25C 02006011 */  beqz       $t3, .L8007C268
    /* 6CA60 8007C260 4801C2AC */   sw        $v0, 0x148($a2)
    /* 6CA64 8007C264 60008424 */  addiu      $a0, $a0, 0x60
  .L8007C268:
    /* 6CA68 8007C268 2000A290 */  lbu        $v0, 0x20($a1)
    /* 6CA6C 8007C26C 00000000 */  nop
    /* 6CA70 8007C270 080082A0 */  sb         $v0, 0x8($a0)
    /* 6CA74 8007C274 2801C28C */  lw         $v0, 0x128($a2)
    /* 6CA78 8007C278 00000000 */  nop
    /* 6CA7C 8007C27C 00004280 */  lb         $v0, 0x0($v0)
    /* 6CA80 8007C280 00000000 */  nop
    /* 6CA84 8007C284 0E004014 */  bnez       $v0, .L8007C2C0
    /* 6CA88 8007C288 21180000 */   addu      $v1, $zero, $zero
    /* 6CA8C 8007C28C 2128C000 */  addu       $a1, $a2, $zero
    /* 6CA90 8007C290 01006324 */  addiu      $v1, $v1, 0x1
  .L8007C294:
    /* 6CA94 8007C294 00026228 */  slti       $v0, $v1, 0x200
    /* 6CA98 8007C298 0A004010 */  beqz       $v0, .L8007C2C4
    /* 6CA9C 8007C29C 00000000 */   nop
    /* 6CAA0 8007C2A0 2801A28C */  lw         $v0, 0x128($a1)
    /* 6CAA4 8007C2A4 00000000 */  nop
    /* 6CAA8 8007C2A8 21104300 */  addu       $v0, $v0, $v1
    /* 6CAAC 8007C2AC 00004280 */  lb         $v0, 0x0($v0)
    /* 6CAB0 8007C2B0 00000000 */  nop
    /* 6CAB4 8007C2B4 F7FF4010 */  beqz       $v0, .L8007C294
    /* 6CAB8 8007C2B8 01006324 */   addiu     $v1, $v1, 0x1
    /* 6CABC 8007C2BC FFFF6324 */  addiu      $v1, $v1, -0x1
  .L8007C2C0:
    /* 6CAC0 8007C2C0 00026228 */  slti       $v0, $v1, 0x200
  .L8007C2C4:
    /* 6CAC4 8007C2C4 0C004010 */  beqz       $v0, .L8007C2F8
    /* 6CAC8 8007C2C8 000083A4 */   sh        $v1, 0x0($a0)
    /* 6CACC 8007C2CC 2801C58C */  lw         $a1, 0x128($a2)
    /* 6CAD0 8007C2D0 00000000 */  nop
    /* 6CAD4 8007C2D4 2110A300 */  addu       $v0, $a1, $v1
  .L8007C2D8:
    /* 6CAD8 8007C2D8 00004280 */  lb         $v0, 0x0($v0)
    /* 6CADC 8007C2DC 00000000 */  nop
    /* 6CAE0 8007C2E0 06004010 */  beqz       $v0, .L8007C2FC
    /* 6CAE4 8007C2E4 00140300 */   sll       $v0, $v1, 16
    /* 6CAE8 8007C2E8 01006324 */  addiu      $v1, $v1, 0x1
    /* 6CAEC 8007C2EC 00026228 */  slti       $v0, $v1, 0x200
    /* 6CAF0 8007C2F0 F9FF4014 */  bnez       $v0, .L8007C2D8
    /* 6CAF4 8007C2F4 2110A300 */   addu      $v0, $a1, $v1
  .L8007C2F8:
    /* 6CAF8 8007C2F8 00140300 */  sll        $v0, $v1, 16
  .L8007C2FC:
    /* 6CAFC 8007C2FC 020083A4 */  sh         $v1, 0x2($a0)
    /* 6CB00 8007C300 00008384 */  lh         $v1, 0x0($a0)
    /* 6CB04 8007C304 03140200 */  sra        $v0, $v0, 16
    /* 6CB08 8007C308 23104300 */  subu       $v0, $v0, $v1
    /* 6CB0C 8007C30C 21A8A202 */  addu       $s5, $s5, $v0
  .L8007C310:
    /* 6CB10 8007C310 01000224 */  addiu      $v0, $zero, 0x1
    /* 6CB14 8007C314 0500E2A0 */  sb         $v0, 0x5($a3)
    /* 6CB18 8007C318 0400C624 */  addiu      $a2, $a2, 0x4
    /* 6CB1C 8007C31C 0C004A25 */  addiu      $t2, $t2, 0xC
    /* 6CB20 8007C320 04002925 */  addiu      $t1, $t1, 0x4
    /* 6CB24 8007C324 04000825 */  addiu      $t0, $t0, 0x4
    /* 6CB28 8007C328 88F00108 */  j          .L8007C220
    /* 6CB2C 8007C32C 01003126 */   addiu     $s1, $s1, 0x1
  .L8007C330:
    /* 6CB30 8007C330 76F00108 */  j          .L8007C1D8
    /* 6CB34 8007C334 01006B25 */   addiu     $t3, $t3, 0x1
  .L8007C338:
    /* 6CB38 8007C338 0580043C */  lui        $a0, %hi(D_80055848)
    /* 6CB3C 8007C33C 48588424 */  addiu      $a0, $a0, %lo(D_80055848)
    /* 6CB40 8007C340 CF94030C */  jal        reservememadr
    /* 6CB44 8007C344 21300000 */   addu      $a2, $zero, $zero
    /* 6CB48 8007C348 6C0342AE */  sw         $v0, 0x36C($s2)
    /* 6CB4C 8007C34C 21984000 */  addu       $s3, $v0, $zero
    /* 6CB50 8007C350 21A00000 */  addu       $s4, $zero, $zero
    /* 6CB54 8007C354 1C015526 */  addiu      $s5, $s2, 0x11C
  .L8007C358:
    /* 6CB58 8007C358 0200822A */  slti       $v0, $s4, 0x2
    /* 6CB5C 8007C35C 22004010 */  beqz       $v0, .L8007C3E8
    /* 6CB60 8007C360 00000000 */   nop
    /* 6CB64 8007C364 04008012 */  beqz       $s4, .L8007C378
    /* 6CB68 8007C368 21880000 */   addu      $s1, $zero, $zero
    /* 6CB6C 8007C36C 6400A28F */  lw         $v0, 0x64($sp)
    /* 6CB70 8007C370 E1F00108 */  j          .L8007C384
    /* 6CB74 8007C374 21904000 */   addu      $s2, $v0, $zero
  .L8007C378:
    /* 6CB78 8007C378 6800A28F */  lw         $v0, 0x68($sp)
    /* 6CB7C 8007C37C 00000000 */  nop
    /* 6CB80 8007C380 21904000 */  addu       $s2, $v0, $zero
  .L8007C384:
    /* 6CB84 8007C384 21802002 */  addu       $s0, $s1, $zero
  .L8007C388:
    /* 6CB88 8007C388 0800222A */  slti       $v0, $s1, 0x8
    /* 6CB8C 8007C38C 14004010 */  beqz       $v0, .L8007C3E0
    /* 6CB90 8007C390 00000000 */   nop
    /* 6CB94 8007C394 02008012 */  beqz       $s4, .L8007C3A0
    /* 6CB98 8007C398 2110B002 */   addu      $v0, $s5, $s0
    /* 6CB9C 8007C39C 60004224 */  addiu      $v0, $v0, 0x60
  .L8007C3A0:
    /* 6CBA0 8007C3A0 02004684 */  lh         $a2, 0x2($v0)
    /* 6CBA4 8007C3A4 00004384 */  lh         $v1, 0x0($v0)
    /* 6CBA8 8007C3A8 00000000 */  nop
    /* 6CBAC 8007C3AC 0800C310 */  beq        $a2, $v1, .L8007C3D0
    /* 6CBB0 8007C3B0 21206002 */   addu      $a0, $s3, $zero
    /* 6CBB4 8007C3B4 2330C300 */  subu       $a2, $a2, $v1
    /* 6CBB8 8007C3B8 040053AC */  sw         $s3, 0x4($v0)
    /* 6CBBC 8007C3BC 21106000 */  addu       $v0, $v1, $zero
    /* 6CBC0 8007C3C0 2801458E */  lw         $a1, 0x128($s2)
    /* 6CBC4 8007C3C4 21986602 */  addu       $s3, $s3, $a2
    /* 6CBC8 8007C3C8 B1AA030C */  jal        memcpy
    /* 6CBCC 8007C3CC 2128A200 */   addu      $a1, $a1, $v0
  .L8007C3D0:
    /* 6CBD0 8007C3D0 04005226 */  addiu      $s2, $s2, 0x4
    /* 6CBD4 8007C3D4 0C001026 */  addiu      $s0, $s0, 0xC
    /* 6CBD8 8007C3D8 E2F00108 */  j          .L8007C388
    /* 6CBDC 8007C3DC 01003126 */   addiu     $s1, $s1, 0x1
  .L8007C3E0:
    /* 6CBE0 8007C3E0 D6F00108 */  j          .L8007C358
    /* 6CBE4 8007C3E4 01009426 */   addiu     $s4, $s4, 0x1
  .L8007C3E8:
    /* 6CBE8 8007C3E8 6400A48F */  lw         $a0, 0x64($sp)
    /* 6CBEC 8007C3EC 5095030C */  jal        purgememadr
    /* 6CBF0 8007C3F0 00000000 */   nop
    /* 6CBF4 8007C3F4 6800A48F */  lw         $a0, 0x68($sp)
    /* 6CBF8 8007C3F8 5095030C */  jal        purgememadr
    /* 6CBFC 8007C3FC 00000000 */   nop
  .L8007C400:
    /* 6CC00 8007C400 2110C003 */  addu       $v0, $fp, $zero
  .L8007C404:
    /* 6CC04 8007C404 9400BF8F */  lw         $ra, 0x94($sp)
    /* 6CC08 8007C408 9000BE8F */  lw         $fp, 0x90($sp)
    /* 6CC0C 8007C40C 8C00B78F */  lw         $s7, 0x8C($sp)
    /* 6CC10 8007C410 8800B68F */  lw         $s6, 0x88($sp)
    /* 6CC14 8007C414 8400B58F */  lw         $s5, 0x84($sp)
    /* 6CC18 8007C418 8000B48F */  lw         $s4, 0x80($sp)
    /* 6CC1C 8007C41C 7C00B38F */  lw         $s3, 0x7C($sp)
    /* 6CC20 8007C420 7800B28F */  lw         $s2, 0x78($sp)
    /* 6CC24 8007C424 7400B18F */  lw         $s1, 0x74($sp)
    /* 6CC28 8007C428 7000B08F */  lw         $s0, 0x70($sp)
    /* 6CC2C 8007C42C 0800E003 */  jr         $ra
    /* 6CC30 8007C430 9800BD27 */   addiu     $sp, $sp, 0x98
endlabel AudioEng_StartUp__FiPc
