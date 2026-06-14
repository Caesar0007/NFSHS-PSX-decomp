.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDPKTPLAY_stop, 0xDC

glabel SNDPKTPLAY_stop
    /* F3918 80103118 1480023C */  lui        $v0, %hi(D_8014789C)
    /* F391C 8010311C 9C784280 */  lb         $v0, %lo(D_8014789C)($v0)
    /* F3920 80103120 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* F3924 80103124 1400B1AF */  sw         $s1, 0x14($sp)
    /* F3928 80103128 21888000 */  addu       $s1, $a0, $zero
    /* F392C 8010312C 1800BFAF */  sw         $ra, 0x18($sp)
    /* F3930 80103130 03004014 */  bnez       $v0, .L80103140
    /* F3934 80103134 1000B0AF */   sw        $s0, 0x10($sp)
    /* F3938 80103138 780C0408 */  j          .L801031E0
    /* F393C 8010313C F6FF0224 */   addiu     $v0, $zero, -0xA
  .L80103140:
    /* F3940 80103140 1580033C */  lui        $v1, %hi(sndpps)
    /* F3944 80103144 74856324 */  addiu      $v1, $v1, %lo(sndpps)
    /* F3948 80103148 80101100 */  sll        $v0, $s1, 2
    /* F394C 8010314C 21104300 */  addu       $v0, $v0, $v1
    /* F3950 80103150 0000508C */  lw         $s0, 0x0($v0)
    /* F3954 80103154 4DA9030C */  jal        iSNDenteraudio
    /* F3958 80103158 00000000 */   nop
    /* F395C 8010315C 0000048E */  lw         $a0, 0x0($s0)
    /* F3960 80103160 A09F030C */  jal        SNDstop
    /* F3964 80103164 00000000 */   nop
    /* F3968 80103168 21202002 */  addu       $a0, $s1, $zero
    /* F396C 8010316C FF7F063C */  lui        $a2, (0x7FFFFFFF >> 16)
    /* F3970 80103170 FFFFC634 */  ori        $a2, $a2, (0x7FFFFFFF & 0xFFFF)
    /* F3974 80103174 CF0B040C */  jal        SNDPKTPLAY_purge
    /* F3978 80103178 21280000 */   addu      $a1, $zero, $zero
    /* F397C 8010317C 1C00058E */  lw         $a1, 0x1C($s0)
    /* F3980 80103180 00000000 */  nop
    /* F3984 80103184 1200A010 */  beqz       $a1, .L801031D0
    /* F3988 80103188 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* F398C 8010318C 0C000296 */  lhu        $v0, 0xC($s0)
    /* F3990 80103190 00000000 */  nop
    /* F3994 80103194 00140200 */  sll        $v0, $v0, 16
    /* F3998 80103198 0D004004 */  bltz       $v0, .L801031D0
    /* F399C 8010319C FFFF0224 */   addiu     $v0, $zero, -0x1
    /* F39A0 801031A0 0C000396 */  lhu        $v1, 0xC($s0)
    /* F39A4 801031A4 00000000 */  nop
    /* F39A8 801031A8 001C0300 */  sll        $v1, $v1, 16
    /* F39AC 801031AC 031C0300 */  sra        $v1, $v1, 16
    /* F39B0 801031B0 40100300 */  sll        $v0, $v1, 1
    /* F39B4 801031B4 21104300 */  addu       $v0, $v0, $v1
    /* F39B8 801031B8 C0100200 */  sll        $v0, $v0, 3
    /* F39BC 801031BC 21105000 */  addu       $v0, $v0, $s0
    /* F39C0 801031C0 3000448C */  lw         $a0, 0x30($v0)
    /* F39C4 801031C4 09F8A000 */  jalr       $a1
    /* F39C8 801031C8 00000000 */   nop
    /* F39CC 801031CC FFFF0224 */  addiu      $v0, $zero, -0x1
  .L801031D0:
    /* F39D0 801031D0 000002AE */  sw         $v0, 0x0($s0)
    /* F39D4 801031D4 5BA9030C */  jal        iSNDleaveaudio
    /* F39D8 801031D8 00000000 */   nop
    /* F39DC 801031DC 21100000 */  addu       $v0, $zero, $zero
  .L801031E0:
    /* F39E0 801031E0 1800BF8F */  lw         $ra, 0x18($sp)
    /* F39E4 801031E4 1400B18F */  lw         $s1, 0x14($sp)
    /* F39E8 801031E8 1000B08F */  lw         $s0, 0x10($sp)
    /* F39EC 801031EC 0800E003 */  jr         $ra
    /* F39F0 801031F0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SNDPKTPLAY_stop
