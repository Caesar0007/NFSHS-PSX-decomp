.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Physics_CalcTractionCircleAcc__FP8Car_tObjP23Physics_tWheelAccStruct, 0x3A4

glabel Physics_CalcTractionCircleAcc__FP8Car_tObjP23Physics_tWheelAccStruct
    /* 9BE98 800AB698 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 9BE9C 800AB69C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 9BEA0 800AB6A0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 9BEA4 800AB6A4 2180A000 */  addu       $s0, $a1, $zero
    /* 9BEA8 800AB6A8 2400BFAF */  sw         $ra, 0x24($sp)
    /* 9BEAC 800AB6AC 2000B4AF */  sw         $s4, 0x20($sp)
    /* 9BEB0 800AB6B0 1800B2AF */  sw         $s2, 0x18($sp)
    /* 9BEB4 800AB6B4 1400B1AF */  sw         $s1, 0x14($sp)
    /* 9BEB8 800AB6B8 1C00028E */  lw         $v0, 0x1C($s0)
    /* 9BEBC 800AB6BC 2400038E */  lw         $v1, 0x24($s0)
    /* 9BEC0 800AB6C0 02004104 */  bgez       $v0, .L800AB6CC
    /* 9BEC4 800AB6C4 21284000 */   addu      $a1, $v0, $zero
    /* 9BEC8 800AB6C8 23280500 */  negu       $a1, $a1
  .L800AB6CC:
    /* 9BECC 800AB6CC 02006104 */  bgez       $v1, .L800AB6D8
    /* 9BED0 800AB6D0 00000000 */   nop
    /* 9BED4 800AB6D4 23180300 */  negu       $v1, $v1
  .L800AB6D8:
    /* 9BED8 800AB6D8 2A106500 */  slt        $v0, $v1, $a1
    /* 9BEDC 800AB6DC 04004010 */  beqz       $v0, .L800AB6F0
    /* 9BEE0 800AB6E0 21988000 */   addu      $s3, $a0, $zero
    /* 9BEE4 800AB6E4 83100300 */  sra        $v0, $v1, 2
    /* 9BEE8 800AB6E8 BEAD0208 */  j          .L800AB6F8
    /* 9BEEC 800AB6EC 21A0A200 */   addu      $s4, $a1, $v0
  .L800AB6F0:
    /* 9BEF0 800AB6F0 83100500 */  sra        $v0, $a1, 2
    /* 9BEF4 800AB6F4 21A06200 */  addu       $s4, $v1, $v0
  .L800AB6F8:
    /* 9BEF8 800AB6F8 2800028E */  lw         $v0, 0x28($s0)
    /* 9BEFC 800AB6FC 0400048E */  lw         $a0, 0x4($s0)
    /* 9BF00 800AB700 04004010 */  beqz       $v0, .L800AB714
    /* 9BF04 800AB704 00000000 */   nop
    /* 9BF08 800AB708 8404628E */  lw         $v0, 0x484($s3)
    /* 9BF0C 800AB70C D9AD0208 */  j          .L800AB764
    /* 9BF10 800AB710 2C0002AE */   sw        $v0, 0x2C($s0)
  .L800AB714:
    /* 9BF14 800AB714 2400028E */  lw         $v0, 0x24($s0)
    /* 9BF18 800AB718 8804638E */  lw         $v1, 0x488($s3)
    /* 9BF1C 800AB71C 02004104 */  bgez       $v0, .L800AB728
    /* 9BF20 800AB720 00000000 */   nop
    /* 9BF24 800AB724 23100200 */  negu       $v0, $v0
  .L800AB728:
    /* 9BF28 800AB728 2A108200 */  slt        $v0, $a0, $v0
    /* 9BF2C 800AB72C 06004010 */  beqz       $v0, .L800AB748
    /* 9BF30 800AB730 2C0003AE */   sw        $v1, 0x2C($s0)
    /* 9BF34 800AB734 3F046292 */  lbu        $v0, 0x43F($s3)
    /* 9BF38 800AB738 00000000 */  nop
    /* 9BF3C 800AB73C 8100422C */  sltiu      $v0, $v0, 0x81
    /* 9BF40 800AB740 05004010 */  beqz       $v0, .L800AB758
    /* 9BF44 800AB744 01000224 */   addiu     $v0, $zero, 0x1
  .L800AB748:
    /* 9BF48 800AB748 6C04638E */  lw         $v1, 0x46C($s3)
    /* 9BF4C 800AB74C 02000224 */  addiu      $v0, $zero, 0x2
    /* 9BF50 800AB750 03006214 */  bne        $v1, $v0, .L800AB760
    /* 9BF54 800AB754 01000224 */   addiu     $v0, $zero, 0x1
  .L800AB758:
    /* 9BF58 800AB758 D9AD0208 */  j          .L800AB764
    /* 9BF5C 800AB75C 6C0462AE */   sw        $v0, 0x46C($s3)
  .L800AB760:
    /* 9BF60 800AB760 6C0460AE */  sw         $zero, 0x46C($s3)
  .L800AB764:
    /* 9BF64 800AB764 CC0D828F */  lw         $v0, %gp_rel(slippery)($gp)
    /* 9BF68 800AB768 00000000 */  nop
    /* 9BF6C 800AB76C 06004010 */  beqz       $v0, .L800AB788
    /* 9BF70 800AB770 1180033C */   lui       $v1, %hi(gripLossTableWet)
    /* 9BF74 800AB774 8802628E */  lw         $v0, 0x288($s3)
    /* 9BF78 800AB778 00000000 */  nop
    /* 9BF7C 800AB77C 3800428C */  lw         $v0, 0x38($v0)
    /* 9BF80 800AB780 E6AD0208 */  j          .L800AB798
    /* 9BF84 800AB784 C8656324 */   addiu     $v1, $v1, %lo(gripLossTableWet)
  .L800AB788:
    /* 9BF88 800AB788 8802628E */  lw         $v0, 0x288($s3)
    /* 9BF8C 800AB78C 1180033C */  lui        $v1, %hi(gripLossTable)
    /* 9BF90 800AB790 3800428C */  lw         $v0, 0x38($v0)
    /* 9BF94 800AB794 BC656324 */  addiu      $v1, $v1, %lo(gripLossTable)
  .L800AB798:
    /* 9BF98 800AB798 80100200 */  sll        $v0, $v0, 2
    /* 9BF9C 800AB79C 21104300 */  addu       $v0, $v0, $v1
    /* 9BFA0 800AB7A0 0000458C */  lw         $a1, 0x0($v0)
    /* 9BFA4 800AB7A4 2A109400 */  slt        $v0, $a0, $s4
    /* 9BFA8 800AB7A8 66004010 */  beqz       $v0, .L800AB944
    /* 9BFAC 800AB7AC 00000000 */   nop
    /* 9BFB0 800AB7B0 8802628E */  lw         $v0, 0x288($s3)
    /* 9BFB4 800AB7B4 00000000 */  nop
    /* 9BFB8 800AB7B8 3000428C */  lw         $v0, 0x30($v0)
    /* 9BFBC 800AB7BC 00000000 */  nop
    /* 9BFC0 800AB7C0 1C004010 */  beqz       $v0, .L800AB834
    /* 9BFC4 800AB7C4 23888402 */   subu      $s1, $s4, $a0
    /* 9BFC8 800AB7C8 2800028E */  lw         $v0, 0x28($s0)
    /* 9BFCC 800AB7CC 00000000 */  nop
    /* 9BFD0 800AB7D0 18004014 */  bnez       $v0, .L800AB834
    /* 9BFD4 800AB7D4 00000000 */   nop
    /* 9BFD8 800AB7D8 7804628E */  lw         $v0, 0x478($s3)
    /* 9BFDC 800AB7DC 00000000 */  nop
    /* 9BFE0 800AB7E0 02004104 */  bgez       $v0, .L800AB7EC
    /* 9BFE4 800AB7E4 00000000 */   nop
    /* 9BFE8 800AB7E8 23100200 */  negu       $v0, $v0
  .L800AB7EC:
    /* 9BFEC 800AB7EC 66264228 */  slti       $v0, $v0, 0x2666
    /* 9BFF0 800AB7F0 10004010 */  beqz       $v0, .L800AB834
    /* 9BFF4 800AB7F4 00000000 */   nop
    /* 9BFF8 800AB7F8 0191030C */  jal        rdiv
    /* 9BFFC 800AB7FC 21288002 */   addu      $a1, $s4, $zero
    /* 9C000 800AB800 2C0000AE */  sw         $zero, 0x2C($s0)
    /* 9C004 800AB804 42046392 */  lbu        $v1, 0x442($s3)
    /* 9C008 800AB808 00000000 */  nop
    /* 9C00C 800AB80C 0300632C */  sltiu      $v1, $v1, 0x3
    /* 9C010 800AB810 05006014 */  bnez       $v1, .L800AB828
    /* 9C014 800AB814 21904000 */   addu      $s2, $v0, $zero
    /* 9C018 800AB818 1C00048E */  lw         $a0, 0x1C($s0)
    /* 9C01C 800AB81C CA90030C */  jal        fixedmult
    /* 9C020 800AB820 21284002 */   addu      $a1, $s2, $zero
    /* 9C024 800AB824 1C0002AE */  sw         $v0, 0x1C($s0)
  .L800AB828:
    /* 9C028 800AB828 2400048E */  lw         $a0, 0x24($s0)
    /* 9C02C 800AB82C 4DAE0208 */  j          .L800AB934
    /* 9C030 800AB830 21284002 */   addu      $a1, $s2, $zero
  .L800AB834:
    /* 9C034 800AB834 1A002502 */  div        $zero, $s1, $a1
    /* 9C038 800AB838 0200A014 */  bnez       $a1, .L800AB844
    /* 9C03C 800AB83C 00000000 */   nop
    /* 9C040 800AB840 0D000700 */  break      7
  .L800AB844:
    /* 9C044 800AB844 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 9C048 800AB848 0400A114 */  bne        $a1, $at, .L800AB85C
    /* 9C04C 800AB84C 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 9C050 800AB850 02002116 */  bne        $s1, $at, .L800AB85C
    /* 9C054 800AB854 00000000 */   nop
    /* 9C058 800AB858 0D000600 */  break      6
  .L800AB85C:
    /* 9C05C 800AB85C 12100000 */  mflo       $v0
    /* 9C060 800AB860 00000000 */  nop
    /* 9C064 800AB864 00000000 */  nop
    /* 9C068 800AB868 1A008500 */  div        $zero, $a0, $a1
    /* 9C06C 800AB86C 0200A014 */  bnez       $a1, .L800AB878
    /* 9C070 800AB870 00000000 */   nop
    /* 9C074 800AB874 0D000700 */  break      7
  .L800AB878:
    /* 9C078 800AB878 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 9C07C 800AB87C 0400A114 */  bne        $a1, $at, .L800AB890
    /* 9C080 800AB880 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 9C084 800AB884 02008114 */  bne        $a0, $at, .L800AB890
    /* 9C088 800AB888 00000000 */   nop
    /* 9C08C 800AB88C 0D000600 */  break      6
  .L800AB890:
    /* 9C090 800AB890 12280000 */  mflo       $a1
    /* 9C094 800AB894 21184000 */  addu       $v1, $v0, $zero
    /* 9C098 800AB898 2A106500 */  slt        $v0, $v1, $a1
    /* 9C09C 800AB89C 02004014 */  bnez       $v0, .L800AB8A8
    /* 9C0A0 800AB8A0 00000000 */   nop
    /* 9C0A4 800AB8A4 2118A000 */  addu       $v1, $a1, $zero
  .L800AB8A8:
    /* 9C0A8 800AB8A8 23208300 */  subu       $a0, $a0, $v1
    /* 9C0AC 800AB8AC 0191030C */  jal        rdiv
    /* 9C0B0 800AB8B0 21288002 */   addu      $a1, $s4, $zero
    /* 9C0B4 800AB8B4 8802638E */  lw         $v1, 0x288($s3)
    /* 9C0B8 800AB8B8 21904000 */  addu       $s2, $v0, $zero
    /* 9C0BC 800AB8BC 3800638C */  lw         $v1, 0x38($v1)
    /* 9C0C0 800AB8C0 02000224 */  addiu      $v0, $zero, 0x2
    /* 9C0C4 800AB8C4 0B006214 */  bne        $v1, $v0, .L800AB8F4
    /* 9C0C8 800AB8C8 00000000 */   nop
    /* 9C0CC 800AB8CC 2C00038E */  lw         $v1, 0x2C($s0)
    /* 9C0D0 800AB8D0 00000000 */  nop
    /* 9C0D4 800AB8D4 00110300 */  sll        $v0, $v1, 4
    /* 9C0D8 800AB8D8 23104300 */  subu       $v0, $v0, $v1
    /* 9C0DC 800AB8DC 21105100 */  addu       $v0, $v0, $s1
    /* 9C0E0 800AB8E0 02004104 */  bgez       $v0, .L800AB8EC
    /* 9C0E4 800AB8E4 00000000 */   nop
    /* 9C0E8 800AB8E8 0F004224 */  addiu      $v0, $v0, 0xF
  .L800AB8EC:
    /* 9C0EC 800AB8EC 46AE0208 */  j          .L800AB918
    /* 9C0F0 800AB8F0 03110200 */   sra       $v0, $v0, 4
  .L800AB8F4:
    /* 9C0F4 800AB8F4 2C00038E */  lw         $v1, 0x2C($s0)
    /* 9C0F8 800AB8F8 00000000 */  nop
    /* 9C0FC 800AB8FC 40100300 */  sll        $v0, $v1, 1
    /* 9C100 800AB900 21104300 */  addu       $v0, $v0, $v1
    /* 9C104 800AB904 21105100 */  addu       $v0, $v0, $s1
    /* 9C108 800AB908 02004104 */  bgez       $v0, .L800AB914
    /* 9C10C 800AB90C 00000000 */   nop
    /* 9C110 800AB910 03004224 */  addiu      $v0, $v0, 0x3
  .L800AB914:
    /* 9C114 800AB914 83100200 */  sra        $v0, $v0, 2
  .L800AB918:
    /* 9C118 800AB918 2C0002AE */  sw         $v0, 0x2C($s0)
    /* 9C11C 800AB91C 1C00048E */  lw         $a0, 0x1C($s0)
    /* 9C120 800AB920 CA90030C */  jal        fixedmult
    /* 9C124 800AB924 21284002 */   addu      $a1, $s2, $zero
    /* 9C128 800AB928 2400048E */  lw         $a0, 0x24($s0)
    /* 9C12C 800AB92C 21284002 */  addu       $a1, $s2, $zero
    /* 9C130 800AB930 1C0002AE */  sw         $v0, 0x1C($s0)
  .L800AB934:
    /* 9C134 800AB934 CA90030C */  jal        fixedmult
    /* 9C138 800AB938 00000000 */   nop
    /* 9C13C 800AB93C 52AE0208 */  j          .L800AB948
    /* 9C140 800AB940 240002AE */   sw        $v0, 0x24($s0)
  .L800AB944:
    /* 9C144 800AB944 2C0000AE */  sw         $zero, 0x2C($s0)
  .L800AB948:
    /* 9C148 800AB948 2800028E */  lw         $v0, 0x28($s0)
    /* 9C14C 800AB94C 00000000 */  nop
    /* 9C150 800AB950 12004014 */  bnez       $v0, .L800AB99C
    /* 9C154 800AB954 01000224 */   addiu     $v0, $zero, 0x1
    /* 9C158 800AB958 6C04638E */  lw         $v1, 0x46C($s3)
    /* 9C15C 800AB95C 00000000 */  nop
    /* 9C160 800AB960 0E006214 */  bne        $v1, $v0, .L800AB99C
    /* 9C164 800AB964 00000000 */   nop
    /* 9C168 800AB968 8802628E */  lw         $v0, 0x288($s3)
    /* 9C16C 800AB96C 00000000 */  nop
    /* 9C170 800AB970 3000428C */  lw         $v0, 0x30($v0)
    /* 9C174 800AB974 00000000 */  nop
    /* 9C178 800AB978 08004014 */  bnez       $v0, .L800AB99C
    /* 9C17C 800AB97C 00000000 */   nop
    /* 9C180 800AB980 2C0014AE */  sw         $s4, 0x2C($s0)
    /* 9C184 800AB984 42046292 */  lbu        $v0, 0x442($s3)
    /* 9C188 800AB988 00000000 */  nop
    /* 9C18C 800AB98C 0400422C */  sltiu      $v0, $v0, 0x4
    /* 9C190 800AB990 02004010 */  beqz       $v0, .L800AB99C
    /* 9C194 800AB994 80101400 */   sll       $v0, $s4, 2
    /* 9C198 800AB998 2C0002AE */  sw         $v0, 0x2C($s0)
  .L800AB99C:
    /* 9C19C 800AB99C 8802628E */  lw         $v0, 0x288($s3)
    /* 9C1A0 800AB9A0 00000000 */  nop
    /* 9C1A4 800AB9A4 3800438C */  lw         $v1, 0x38($v0)
    /* 9C1A8 800AB9A8 01000224 */  addiu      $v0, $zero, 0x1
    /* 9C1AC 800AB9AC 03006214 */  bne        $v1, $v0, .L800AB9BC
    /* 9C1B0 800AB9B0 02000224 */   addiu     $v0, $zero, 0x2
    /* 9C1B4 800AB9B4 71AE0208 */  j          .L800AB9C4
    /* 9C1B8 800AB9B8 0800043C */   lui       $a0, (0x80000 >> 16)
  .L800AB9BC:
    /* 9C1BC 800AB9BC 08006214 */  bne        $v1, $v0, .L800AB9E0
    /* 9C1C0 800AB9C0 0400043C */   lui       $a0, (0x40000 >> 16)
  .L800AB9C4:
    /* 9C1C4 800AB9C4 2C00038E */  lw         $v1, 0x2C($s0)
    /* 9C1C8 800AB9C8 21108000 */  addu       $v0, $a0, $zero
    /* 9C1CC 800AB9CC 2A104300 */  slt        $v0, $v0, $v1
    /* 9C1D0 800AB9D0 02004014 */  bnez       $v0, .L800AB9DC
    /* 9C1D4 800AB9D4 00000000 */   nop
    /* 9C1D8 800AB9D8 21206000 */  addu       $a0, $v1, $zero
  .L800AB9DC:
    /* 9C1DC 800AB9DC 2C0004AE */  sw         $a0, 0x2C($s0)
  .L800AB9E0:
    /* 9C1E0 800AB9E0 8802628E */  lw         $v0, 0x288($s3)
    /* 9C1E4 800AB9E4 00000000 */  nop
    /* 9C1E8 800AB9E8 3000428C */  lw         $v0, 0x30($v0)
    /* 9C1EC 800AB9EC 00000000 */  nop
    /* 9C1F0 800AB9F0 0A004010 */  beqz       $v0, .L800ABA1C
    /* 9C1F4 800AB9F4 00000000 */   nop
    /* 9C1F8 800AB9F8 2C00038E */  lw         $v1, 0x2C($s0)
    /* 9C1FC 800AB9FC 00000000 */  nop
    /* 9C200 800ABA00 40100300 */  sll        $v0, $v1, 1
    /* 9C204 800ABA04 21104300 */  addu       $v0, $v0, $v1
    /* 9C208 800ABA08 02004104 */  bgez       $v0, .L800ABA14
    /* 9C20C 800ABA0C 00000000 */   nop
    /* 9C210 800ABA10 03004224 */  addiu      $v0, $v0, 0x3
  .L800ABA14:
    /* 9C214 800ABA14 83100200 */  sra        $v0, $v0, 2
    /* 9C218 800ABA18 2C0002AE */  sw         $v0, 0x2C($s0)
  .L800ABA1C:
    /* 9C21C 800ABA1C 2400BF8F */  lw         $ra, 0x24($sp)
    /* 9C220 800ABA20 2000B48F */  lw         $s4, 0x20($sp)
    /* 9C224 800ABA24 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 9C228 800ABA28 1800B28F */  lw         $s2, 0x18($sp)
    /* 9C22C 800ABA2C 1400B18F */  lw         $s1, 0x14($sp)
    /* 9C230 800ABA30 1000B08F */  lw         $s0, 0x10($sp)
    /* 9C234 800ABA34 0800E003 */  jr         $ra
    /* 9C238 800ABA38 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Physics_CalcTractionCircleAcc__FP8Car_tObjP23Physics_tWheelAccStruct
