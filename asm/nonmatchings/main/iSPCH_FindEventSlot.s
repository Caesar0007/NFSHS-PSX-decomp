.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_FindEventSlot, 0x130

glabel iSPCH_FindEventSlot
    /* D7888 800E7088 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D788C 800E708C 1400B1AF */  sw         $s1, 0x14($sp)
    /* D7890 800E7090 21888000 */  addu       $s1, $a0, $zero
    /* D7894 800E7094 1580043C */  lui        $a0, %hi(gVoxEvents)
    /* D7898 800E7098 6080828C */  lw         $v0, %lo(gVoxEvents)($a0)
    /* D789C 800E709C 1000B0AF */  sw         $s0, 0x10($sp)
    /* D78A0 800E70A0 FFFF1024 */  addiu      $s0, $zero, -0x1
    /* D78A4 800E70A4 10004228 */  slti       $v0, $v0, 0x10
    /* D78A8 800E70A8 0D004010 */  beqz       $v0, .L800E70E0
    /* D78AC 800E70AC 1800BFAF */   sw        $ra, 0x18($sp)
    /* D78B0 800E70B0 21180000 */  addu       $v1, $zero, $zero
    /* D78B4 800E70B4 60808424 */  addiu      $a0, $a0, %lo(gVoxEvents)
  .L800E70B8:
    /* D78B8 800E70B8 08008294 */  lhu        $v0, 0x8($a0)
    /* D78BC 800E70BC 00000000 */  nop
    /* D78C0 800E70C0 03004014 */  bnez       $v0, .L800E70D0
    /* D78C4 800E70C4 00000000 */   nop
    /* D78C8 800E70C8 689C0308 */  j          .L800E71A0
    /* D78CC 800E70CC 21806000 */   addu      $s0, $v1, $zero
  .L800E70D0:
    /* D78D0 800E70D0 01006324 */  addiu      $v1, $v1, 0x1
    /* D78D4 800E70D4 10006228 */  slti       $v0, $v1, 0x10
    /* D78D8 800E70D8 F7FF4014 */  bnez       $v0, .L800E70B8
    /* D78DC 800E70DC 3C008424 */   addiu     $a0, $a0, 0x3C
  .L800E70E0:
    /* D78E0 800E70E0 88A0030C */  jal        gettick
    /* D78E4 800E70E4 00000000 */   nop
    /* D78E8 800E70E8 21384000 */  addu       $a3, $v0, $zero
    /* D78EC 800E70EC 21180000 */  addu       $v1, $zero, $zero
    /* D78F0 800E70F0 1580063C */  lui        $a2, %hi(gVoxEvents)
    /* D78F4 800E70F4 6080C424 */  addiu      $a0, $a2, %lo(gVoxEvents)
  .L800E70F8:
    /* D78F8 800E70F8 1000828C */  lw         $v0, 0x10($a0)
    /* D78FC 800E70FC 00000000 */  nop
    /* D7900 800E7100 02004594 */  lhu        $a1, 0x2($v0)
    /* D7904 800E7104 00000000 */  nop
    /* D7908 800E7108 0D00A010 */  beqz       $a1, .L800E7140
    /* D790C 800E710C 00000000 */   nop
    /* D7910 800E7110 0C00828C */  lw         $v0, 0xC($a0)
    /* D7914 800E7114 00000000 */  nop
    /* D7918 800E7118 2310E200 */  subu       $v0, $a3, $v0
    /* D791C 800E711C 2B10A200 */  sltu       $v0, $a1, $v0
    /* D7920 800E7120 07004010 */  beqz       $v0, .L800E7140
    /* D7924 800E7124 00000000 */   nop
    /* D7928 800E7128 080080A4 */  sh         $zero, 0x8($a0)
    /* D792C 800E712C 6080C28C */  lw         $v0, %lo(gVoxEvents)($a2)
    /* D7930 800E7130 21806000 */  addu       $s0, $v1, $zero
    /* D7934 800E7134 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* D7938 800E7138 689C0308 */  j          .L800E71A0
    /* D793C 800E713C 6080C2AC */   sw        $v0, %lo(gVoxEvents)($a2)
  .L800E7140:
    /* D7940 800E7140 01006324 */  addiu      $v1, $v1, 0x1
    /* D7944 800E7144 10006228 */  slti       $v0, $v1, 0x10
    /* D7948 800E7148 EBFF4014 */  bnez       $v0, .L800E70F8
    /* D794C 800E714C 3C008424 */   addiu     $a0, $a0, 0x3C
    /* D7950 800E7150 21180000 */  addu       $v1, $zero, $zero
    /* D7954 800E7154 1580053C */  lui        $a1, %hi(gVoxEvents)
    /* D7958 800E7158 6080A424 */  addiu      $a0, $a1, %lo(gVoxEvents)
  .L800E715C:
    /* D795C 800E715C 1000828C */  lw         $v0, 0x10($a0)
    /* D7960 800E7160 00000000 */  nop
    /* D7964 800E7164 04004294 */  lhu        $v0, 0x4($v0)
    /* D7968 800E7168 00000000 */  nop
    /* D796C 800E716C 2B102202 */  sltu       $v0, $s1, $v0
    /* D7970 800E7170 07004014 */  bnez       $v0, .L800E7190
    /* D7974 800E7174 00000000 */   nop
    /* D7978 800E7178 080080A4 */  sh         $zero, 0x8($a0)
    /* D797C 800E717C 6080A28C */  lw         $v0, %lo(gVoxEvents)($a1)
    /* D7980 800E7180 21806000 */  addu       $s0, $v1, $zero
    /* D7984 800E7184 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* D7988 800E7188 689C0308 */  j          .L800E71A0
    /* D798C 800E718C 6080A2AC */   sw        $v0, %lo(gVoxEvents)($a1)
  .L800E7190:
    /* D7990 800E7190 01006324 */  addiu      $v1, $v1, 0x1
    /* D7994 800E7194 10006228 */  slti       $v0, $v1, 0x10
    /* D7998 800E7198 F0FF4014 */  bnez       $v0, .L800E715C
    /* D799C 800E719C 3C008424 */   addiu     $a0, $a0, 0x3C
  .L800E71A0:
    /* D79A0 800E71A0 21100002 */  addu       $v0, $s0, $zero
    /* D79A4 800E71A4 1800BF8F */  lw         $ra, 0x18($sp)
    /* D79A8 800E71A8 1400B18F */  lw         $s1, 0x14($sp)
    /* D79AC 800E71AC 1000B08F */  lw         $s0, 0x10($sp)
    /* D79B0 800E71B0 0800E003 */  jr         $ra
    /* D79B4 800E71B4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel iSPCH_FindEventSlot
