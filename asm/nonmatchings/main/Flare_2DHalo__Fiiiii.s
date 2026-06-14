.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Flare_2DHalo__Fiiiii, 0x3DC

glabel Flare_2DHalo__Fiiiii
    /* BE770 800CDF70 90FFBD27 */  addiu      $sp, $sp, -0x70
    /* BE774 800CDF74 6400B5AF */  sw         $s5, 0x64($sp)
    /* BE778 800CDF78 21A88000 */  addu       $s5, $a0, $zero
    /* BE77C 800CDF7C 6800B6AF */  sw         $s6, 0x68($sp)
    /* BE780 800CDF80 21B0A000 */  addu       $s6, $a1, $zero
    /* BE784 800CDF84 5000B0AF */  sw         $s0, 0x50($sp)
    /* BE788 800CDF88 2180C000 */  addu       $s0, $a2, $zero
    /* BE78C 800CDF8C 5400B1AF */  sw         $s1, 0x54($sp)
    /* BE790 800CDF90 2188E000 */  addu       $s1, $a3, $zero
    /* BE794 800CDF94 5C00B3AF */  sw         $s3, 0x5C($sp)
    /* BE798 800CDF98 801F083C */  lui        $t0, (0x1F800000 >> 16)
    /* BE79C 800CDF9C 6C00BFAF */  sw         $ra, 0x6C($sp)
    /* BE7A0 800CDFA0 6000B4AF */  sw         $s4, 0x60($sp)
    /* BE7A4 800CDFA4 5800B2AF */  sw         $s2, 0x58($sp)
    /* BE7A8 800CDFA8 1800B5A7 */  sh         $s5, 0x18($sp)
    /* BE7AC 800CDFAC 1A00B6A7 */  sh         $s6, 0x1A($sp)
    /* BE7B0 800CDFB0 0800028D */  lw         $v0, (0x1F800008 & 0xFFFF)($t0)
    /* BE7B4 800CDFB4 0400038D */  lw         $v1, (0x1F800004 & 0xFFFF)($t0)
    /* BE7B8 800CDFB8 00F04224 */  addiu      $v0, $v0, -0x1000
    /* BE7BC 800CDFBC 2B186200 */  sltu       $v1, $v1, $v0
    /* BE7C0 800CDFC0 D8006010 */  beqz       $v1, .L800CE324
    /* BE7C4 800CDFC4 1800B327 */   addiu     $s3, $sp, 0x18
    /* BE7C8 800CDFC8 21A00000 */  addu       $s4, $zero, $zero
    /* BE7CC 800CDFCC 21580001 */  addu       $t3, $t0, $zero
    /* BE7D0 800CDFD0 04006B35 */  ori        $t3, $t3, (0x1F800004 & 0xFFFF)
    /* BE7D4 800CDFD4 FF00093C */  lui        $t1, (0xFFFFFF >> 16)
    /* BE7D8 800CDFD8 FFFF2935 */  ori        $t1, $t1, (0xFFFFFF & 0xFFFF)
    /* BE7DC 800CDFDC 21288002 */  addu       $a1, $s4, $zero
    /* BE7E0 800CDFE0 21308002 */  addu       $a2, $s4, $zero
    /* BE7E4 800CDFE4 1280033C */  lui        $v1, %hi(Flare_gType)
    /* BE7E8 800CDFE8 8000A28F */  lw         $v0, 0x80($sp)
    /* BE7EC 800CDFEC 68FF6324 */  addiu      $v1, $v1, %lo(Flare_gType)
    /* BE7F0 800CDFF0 FF004230 */  andi       $v0, $v0, 0xFF
    /* BE7F4 800CDFF4 00110200 */  sll        $v0, $v0, 4
    /* BE7F8 800CDFF8 21104300 */  addu       $v0, $v0, $v1
    /* BE7FC 800CDFFC 0000438C */  lw         $v1, 0x0($v0)
    /* BE800 800CE000 20010724 */  addiu      $a3, $zero, 0x120
    /* BE804 800CE004 201383AF */  sw         $v1, %gp_rel(gfrgb)($gp)
    /* BE808 800CE008 0000648D */  lw         $a0, 0x0($t3)
    /* BE80C 800CE00C 0400428C */  lw         $v0, 0x4($v0)
    /* BE810 800CE010 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* BE814 800CE014 241382AF */  sw         $v0, %gp_rel(gfrgb2)($gp)
    /* BE818 800CE018 0000088D */  lw         $t0, (0x1F800000 & 0xFFFF)($t0)
    /* BE81C 800CE01C 0000838C */  lw         $v1, 0x0($a0)
    /* BE820 800CE020 0000028D */  lw         $v0, 0x0($t0)
    /* BE824 800CE024 24186A00 */  and        $v1, $v1, $t2
    /* BE828 800CE028 24104900 */  and        $v0, $v0, $t1
    /* BE82C 800CE02C 25186200 */  or         $v1, $v1, $v0
    /* BE830 800CE030 000083AC */  sw         $v1, 0x0($a0)
    /* BE834 800CE034 0000028D */  lw         $v0, 0x0($t0)
    /* BE838 800CE038 0C008324 */  addiu      $v1, $a0, 0xC
    /* BE83C 800CE03C 000063AD */  sw         $v1, 0x0($t3)
    /* BE840 800CE040 24188900 */  and        $v1, $a0, $t1
    /* BE844 800CE044 24104A00 */  and        $v0, $v0, $t2
    /* BE848 800CE048 25104300 */  or         $v0, $v0, $v1
    /* BE84C 800CE04C 000002AD */  sw         $v0, 0x0($t0)
    /* BE850 800CE050 EFB8030C */  jal        SetDrawMode
    /* BE854 800CE054 1000A0AF */   sw        $zero, 0x10($sp)
    /* BE858 800CE058 21288002 */  addu       $a1, $s4, $zero
    /* BE85C 800CE05C FFFF0634 */  ori        $a2, $zero, 0xFFFF
    /* BE860 800CE060 3000A427 */  addiu      $a0, $sp, 0x30
    /* BE864 800CE064 1280023C */  lui        $v0, %hi(Flare_gOct)
    /* BE868 800CE068 68FE4324 */  addiu      $v1, $v0, %lo(Flare_gOct)
  .L800CE06C:
    /* BE86C 800CE06C 00006284 */  lh         $v0, 0x0($v1)
    /* BE870 800CE070 00000000 */  nop
    /* BE874 800CE074 18005000 */  mult       $v0, $s0
    /* BE878 800CE078 12100000 */  mflo       $v0
    /* BE87C 800CE07C 02004104 */  bgez       $v0, .L800CE088
    /* BE880 800CE080 00000000 */   nop
    /* BE884 800CE084 21104600 */  addu       $v0, $v0, $a2
  .L800CE088:
    /* BE888 800CE088 03140200 */  sra        $v0, $v0, 16
    /* BE88C 800CE08C 000082A4 */  sh         $v0, 0x0($a0)
    /* BE890 800CE090 02006284 */  lh         $v0, 0x2($v1)
    /* BE894 800CE094 00000000 */  nop
    /* BE898 800CE098 18005100 */  mult       $v0, $s1
    /* BE89C 800CE09C 12100000 */  mflo       $v0
    /* BE8A0 800CE0A0 02004104 */  bgez       $v0, .L800CE0AC
    /* BE8A4 800CE0A4 00000000 */   nop
    /* BE8A8 800CE0A8 21104600 */  addu       $v0, $v0, $a2
  .L800CE0AC:
    /* BE8AC 800CE0AC 03140200 */  sra        $v0, $v0, 16
    /* BE8B0 800CE0B0 020082A4 */  sh         $v0, 0x2($a0)
    /* BE8B4 800CE0B4 04008424 */  addiu      $a0, $a0, 0x4
    /* BE8B8 800CE0B8 0100A524 */  addiu      $a1, $a1, 0x1
    /* BE8BC 800CE0BC 0800A228 */  slti       $v0, $a1, 0x8
    /* BE8C0 800CE0C0 EAFF4014 */  bnez       $v0, .L800CE06C
    /* BE8C4 800CE0C4 08006324 */   addiu     $v1, $v1, 0x8
    /* BE8C8 800CE0C8 21206002 */  addu       $a0, $s3, $zero
    /* BE8CC 800CE0CC 2800B227 */  addiu      $s2, $sp, 0x28
    /* BE8D0 800CE0D0 21284002 */  addu       $a1, $s2, $zero
    /* BE8D4 800CE0D4 2400B127 */  addiu      $s1, $sp, 0x24
    /* BE8D8 800CE0D8 21302002 */  addu       $a2, $s1, $zero
    /* BE8DC 800CE0DC 21388002 */  addu       $a3, $s4, $zero
    /* BE8E0 800CE0E0 3000A297 */  lhu        $v0, 0x30($sp)
    /* BE8E4 800CE0E4 3200A397 */  lhu        $v1, 0x32($sp)
    /* BE8E8 800CE0E8 21105500 */  addu       $v0, $v0, $s5
    /* BE8EC 800CE0EC 2800A2A7 */  sh         $v0, 0x28($sp)
    /* BE8F0 800CE0F0 3400A297 */  lhu        $v0, 0x34($sp)
    /* BE8F4 800CE0F4 21187600 */  addu       $v1, $v1, $s6
    /* BE8F8 800CE0F8 2A00A3A7 */  sh         $v1, 0x2A($sp)
    /* BE8FC 800CE0FC 3600A397 */  lhu        $v1, 0x36($sp)
    /* BE900 800CE100 21105500 */  addu       $v0, $v0, $s5
    /* BE904 800CE104 21187600 */  addu       $v1, $v1, $s6
    /* BE908 800CE108 2400A2A7 */  sh         $v0, 0x24($sp)
    /* BE90C 800CE10C 2C2F030C */  jal        Flare_Tri__FPlN20i
    /* BE910 800CE110 2600A3A7 */   sh        $v1, 0x26($sp)
    /* BE914 800CE114 21206002 */  addu       $a0, $s3, $zero
    /* BE918 800CE118 21282002 */  addu       $a1, $s1, $zero
    /* BE91C 800CE11C B137030C */  jal        Flare_2DSpike__FPlT0i
    /* BE920 800CE120 21308002 */   addu      $a2, $s4, $zero
    /* BE924 800CE124 21206002 */  addu       $a0, $s3, $zero
    /* BE928 800CE128 21282002 */  addu       $a1, $s1, $zero
    /* BE92C 800CE12C 2000B027 */  addiu      $s0, $sp, 0x20
    /* BE930 800CE130 21300002 */  addu       $a2, $s0, $zero
    /* BE934 800CE134 21388002 */  addu       $a3, $s4, $zero
    /* BE938 800CE138 3800A297 */  lhu        $v0, 0x38($sp)
    /* BE93C 800CE13C 3A00A397 */  lhu        $v1, 0x3A($sp)
    /* BE940 800CE140 21105500 */  addu       $v0, $v0, $s5
    /* BE944 800CE144 21187600 */  addu       $v1, $v1, $s6
    /* BE948 800CE148 2000A2A7 */  sh         $v0, 0x20($sp)
    /* BE94C 800CE14C 2C2F030C */  jal        Flare_Tri__FPlN20i
    /* BE950 800CE150 2200A3A7 */   sh        $v1, 0x22($sp)
    /* BE954 800CE154 21206002 */  addu       $a0, $s3, $zero
    /* BE958 800CE158 21280002 */  addu       $a1, $s0, $zero
    /* BE95C 800CE15C B137030C */  jal        Flare_2DSpike__FPlT0i
    /* BE960 800CE160 21308002 */   addu      $a2, $s4, $zero
    /* BE964 800CE164 21206002 */  addu       $a0, $s3, $zero
    /* BE968 800CE168 21280002 */  addu       $a1, $s0, $zero
    /* BE96C 800CE16C 21302002 */  addu       $a2, $s1, $zero
    /* BE970 800CE170 21388002 */  addu       $a3, $s4, $zero
    /* BE974 800CE174 3C00A297 */  lhu        $v0, 0x3C($sp)
    /* BE978 800CE178 3E00A397 */  lhu        $v1, 0x3E($sp)
    /* BE97C 800CE17C 21105500 */  addu       $v0, $v0, $s5
    /* BE980 800CE180 21187600 */  addu       $v1, $v1, $s6
    /* BE984 800CE184 2400A2A7 */  sh         $v0, 0x24($sp)
    /* BE988 800CE188 2C2F030C */  jal        Flare_Tri__FPlN20i
    /* BE98C 800CE18C 2600A3A7 */   sh        $v1, 0x26($sp)
    /* BE990 800CE190 21206002 */  addu       $a0, $s3, $zero
    /* BE994 800CE194 21282002 */  addu       $a1, $s1, $zero
    /* BE998 800CE198 B137030C */  jal        Flare_2DSpike__FPlT0i
    /* BE99C 800CE19C 21308002 */   addu      $a2, $s4, $zero
    /* BE9A0 800CE1A0 21206002 */  addu       $a0, $s3, $zero
    /* BE9A4 800CE1A4 21282002 */  addu       $a1, $s1, $zero
    /* BE9A8 800CE1A8 21300002 */  addu       $a2, $s0, $zero
    /* BE9AC 800CE1AC 21388002 */  addu       $a3, $s4, $zero
    /* BE9B0 800CE1B0 4000A297 */  lhu        $v0, 0x40($sp)
    /* BE9B4 800CE1B4 4200A397 */  lhu        $v1, 0x42($sp)
    /* BE9B8 800CE1B8 21105500 */  addu       $v0, $v0, $s5
    /* BE9BC 800CE1BC 21187600 */  addu       $v1, $v1, $s6
    /* BE9C0 800CE1C0 2000A2A7 */  sh         $v0, 0x20($sp)
    /* BE9C4 800CE1C4 2C2F030C */  jal        Flare_Tri__FPlN20i
    /* BE9C8 800CE1C8 2200A3A7 */   sh        $v1, 0x22($sp)
    /* BE9CC 800CE1CC 21206002 */  addu       $a0, $s3, $zero
    /* BE9D0 800CE1D0 21280002 */  addu       $a1, $s0, $zero
    /* BE9D4 800CE1D4 B137030C */  jal        Flare_2DSpike__FPlT0i
    /* BE9D8 800CE1D8 21308002 */   addu      $a2, $s4, $zero
    /* BE9DC 800CE1DC 21206002 */  addu       $a0, $s3, $zero
    /* BE9E0 800CE1E0 21280002 */  addu       $a1, $s0, $zero
    /* BE9E4 800CE1E4 21302002 */  addu       $a2, $s1, $zero
    /* BE9E8 800CE1E8 21388002 */  addu       $a3, $s4, $zero
    /* BE9EC 800CE1EC 4400A297 */  lhu        $v0, 0x44($sp)
    /* BE9F0 800CE1F0 4600A397 */  lhu        $v1, 0x46($sp)
    /* BE9F4 800CE1F4 21105500 */  addu       $v0, $v0, $s5
    /* BE9F8 800CE1F8 21187600 */  addu       $v1, $v1, $s6
    /* BE9FC 800CE1FC 2400A2A7 */  sh         $v0, 0x24($sp)
    /* BEA00 800CE200 2C2F030C */  jal        Flare_Tri__FPlN20i
    /* BEA04 800CE204 2600A3A7 */   sh        $v1, 0x26($sp)
    /* BEA08 800CE208 21206002 */  addu       $a0, $s3, $zero
    /* BEA0C 800CE20C 21282002 */  addu       $a1, $s1, $zero
    /* BEA10 800CE210 B137030C */  jal        Flare_2DSpike__FPlT0i
    /* BEA14 800CE214 21308002 */   addu      $a2, $s4, $zero
    /* BEA18 800CE218 21206002 */  addu       $a0, $s3, $zero
    /* BEA1C 800CE21C 21282002 */  addu       $a1, $s1, $zero
    /* BEA20 800CE220 21300002 */  addu       $a2, $s0, $zero
    /* BEA24 800CE224 21388002 */  addu       $a3, $s4, $zero
    /* BEA28 800CE228 4800A297 */  lhu        $v0, 0x48($sp)
    /* BEA2C 800CE22C 4A00A397 */  lhu        $v1, 0x4A($sp)
    /* BEA30 800CE230 21105500 */  addu       $v0, $v0, $s5
    /* BEA34 800CE234 21187600 */  addu       $v1, $v1, $s6
    /* BEA38 800CE238 2000A2A7 */  sh         $v0, 0x20($sp)
    /* BEA3C 800CE23C 2C2F030C */  jal        Flare_Tri__FPlN20i
    /* BEA40 800CE240 2200A3A7 */   sh        $v1, 0x22($sp)
    /* BEA44 800CE244 21206002 */  addu       $a0, $s3, $zero
    /* BEA48 800CE248 21280002 */  addu       $a1, $s0, $zero
    /* BEA4C 800CE24C B137030C */  jal        Flare_2DSpike__FPlT0i
    /* BEA50 800CE250 21308002 */   addu      $a2, $s4, $zero
    /* BEA54 800CE254 21206002 */  addu       $a0, $s3, $zero
    /* BEA58 800CE258 21280002 */  addu       $a1, $s0, $zero
    /* BEA5C 800CE25C 21302002 */  addu       $a2, $s1, $zero
    /* BEA60 800CE260 21388002 */  addu       $a3, $s4, $zero
    /* BEA64 800CE264 4C00A297 */  lhu        $v0, 0x4C($sp)
    /* BEA68 800CE268 4E00A397 */  lhu        $v1, 0x4E($sp)
    /* BEA6C 800CE26C 21105500 */  addu       $v0, $v0, $s5
    /* BEA70 800CE270 21187600 */  addu       $v1, $v1, $s6
    /* BEA74 800CE274 2400A2A7 */  sh         $v0, 0x24($sp)
    /* BEA78 800CE278 2C2F030C */  jal        Flare_Tri__FPlN20i
    /* BEA7C 800CE27C 2600A3A7 */   sh        $v1, 0x26($sp)
    /* BEA80 800CE280 21206002 */  addu       $a0, $s3, $zero
    /* BEA84 800CE284 21282002 */  addu       $a1, $s1, $zero
    /* BEA88 800CE288 B137030C */  jal        Flare_2DSpike__FPlT0i
    /* BEA8C 800CE28C 21308002 */   addu      $a2, $s4, $zero
    /* BEA90 800CE290 21206002 */  addu       $a0, $s3, $zero
    /* BEA94 800CE294 21282002 */  addu       $a1, $s1, $zero
    /* BEA98 800CE298 21304002 */  addu       $a2, $s2, $zero
    /* BEA9C 800CE29C 2C2F030C */  jal        Flare_Tri__FPlN20i
    /* BEAA0 800CE2A0 21388002 */   addu      $a3, $s4, $zero
    /* BEAA4 800CE2A4 21206002 */  addu       $a0, $s3, $zero
    /* BEAA8 800CE2A8 21284002 */  addu       $a1, $s2, $zero
    /* BEAAC 800CE2AC B137030C */  jal        Flare_2DSpike__FPlT0i
    /* BEAB0 800CE2B0 21308002 */   addu      $a2, $s4, $zero
    /* BEAB4 800CE2B4 801F0B3C */  lui        $t3, (0x1F800004 >> 16)
    /* BEAB8 800CE2B8 04006B35 */  ori        $t3, $t3, (0x1F800004 & 0xFFFF)
    /* BEABC 800CE2BC FF00093C */  lui        $t1, (0xFFFFFF >> 16)
    /* BEAC0 800CE2C0 FFFF2935 */  ori        $t1, $t1, (0xFFFFFF & 0xFFFF)
    /* BEAC4 800CE2C4 21280000 */  addu       $a1, $zero, $zero
    /* BEAC8 800CE2C8 01000624 */  addiu      $a2, $zero, 0x1
    /* BEACC 800CE2CC 20010724 */  addiu      $a3, $zero, 0x120
    /* BEAD0 800CE2D0 80401400 */  sll        $t0, $s4, 2
    /* BEAD4 800CE2D4 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* BEAD8 800CE2D8 801F023C */  lui        $v0, (0x1F800000 >> 16)
    /* BEADC 800CE2DC 0000428C */  lw         $v0, (0x1F800000 & 0xFFFF)($v0)
    /* BEAE0 800CE2E0 0000648D */  lw         $a0, 0x0($t3)
    /* BEAE4 800CE2E4 21400201 */  addu       $t0, $t0, $v0
    /* BEAE8 800CE2E8 0000838C */  lw         $v1, 0x0($a0)
    /* BEAEC 800CE2EC 0000028D */  lw         $v0, 0x0($t0)
    /* BEAF0 800CE2F0 24186A00 */  and        $v1, $v1, $t2
    /* BEAF4 800CE2F4 24104900 */  and        $v0, $v0, $t1
    /* BEAF8 800CE2F8 25186200 */  or         $v1, $v1, $v0
    /* BEAFC 800CE2FC 000083AC */  sw         $v1, 0x0($a0)
    /* BEB00 800CE300 0000028D */  lw         $v0, 0x0($t0)
    /* BEB04 800CE304 0C008324 */  addiu      $v1, $a0, 0xC
    /* BEB08 800CE308 000063AD */  sw         $v1, 0x0($t3)
    /* BEB0C 800CE30C 24188900 */  and        $v1, $a0, $t1
    /* BEB10 800CE310 24104A00 */  and        $v0, $v0, $t2
    /* BEB14 800CE314 25104300 */  or         $v0, $v0, $v1
    /* BEB18 800CE318 000002AD */  sw         $v0, 0x0($t0)
    /* BEB1C 800CE31C EFB8030C */  jal        SetDrawMode
    /* BEB20 800CE320 1000A0AF */   sw        $zero, 0x10($sp)
  .L800CE324:
    /* BEB24 800CE324 6C00BF8F */  lw         $ra, 0x6C($sp)
    /* BEB28 800CE328 6800B68F */  lw         $s6, 0x68($sp)
    /* BEB2C 800CE32C 6400B58F */  lw         $s5, 0x64($sp)
    /* BEB30 800CE330 6000B48F */  lw         $s4, 0x60($sp)
    /* BEB34 800CE334 5C00B38F */  lw         $s3, 0x5C($sp)
    /* BEB38 800CE338 5800B28F */  lw         $s2, 0x58($sp)
    /* BEB3C 800CE33C 5400B18F */  lw         $s1, 0x54($sp)
    /* BEB40 800CE340 5000B08F */  lw         $s0, 0x50($sp)
    /* BEB44 800CE344 0800E003 */  jr         $ra
    /* BEB48 800CE348 7000BD27 */   addiu     $sp, $sp, 0x70
endlabel Flare_2DHalo__Fiiiii
