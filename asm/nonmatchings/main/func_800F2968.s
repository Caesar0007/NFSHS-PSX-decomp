.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800F2968, 0xD8

glabel func_800F2968
    /* E3168 800F2968 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E316C 800F296C 1000B0AF */  sw         $s0, 0x10($sp)
    /* E3170 800F2970 1380103C */  lui        $s0, %hi(D_80134AF8)
    /* E3174 800F2974 F84A1026 */  addiu      $s0, $s0, %lo(D_80134AF8)
    /* E3178 800F2978 1400BFAF */  sw         $ra, 0x14($sp)
    /* E317C 800F297C 00000296 */  lhu        $v0, 0x0($s0)
    /* E3180 800F2980 00000000 */  nop
    /* E3184 800F2984 2A004014 */  bnez       $v0, .L800F2A30
    /* E3188 800F2988 21100000 */   addu      $v0, $zero, $zero
    /* E318C 800F298C 1380033C */  lui        $v1, %hi(D_80135B84)
    /* E3190 800F2990 845B638C */  lw         $v1, %lo(D_80135B84)($v1)
    /* E3194 800F2994 1380023C */  lui        $v0, %hi(D_80135B88)
    /* E3198 800F2998 885B428C */  lw         $v0, %lo(D_80135B88)($v0)
    /* E319C 800F299C 3333053C */  lui        $a1, (0x33333333 >> 16)
    /* E31A0 800F29A0 000040A4 */  sh         $zero, 0x0($v0)
    /* E31A4 800F29A4 00004294 */  lhu        $v0, 0x0($v0)
    /* E31A8 800F29A8 3333A534 */  ori        $a1, $a1, (0x33333333 & 0xFFFF)
    /* E31AC 800F29AC 000062A4 */  sh         $v0, 0x0($v1)
    /* E31B0 800F29B0 1380023C */  lui        $v0, %hi(D_80135B8C)
    /* E31B4 800F29B4 8C5B428C */  lw         $v0, %lo(D_80135B8C)($v0)
    /* E31B8 800F29B8 21200002 */  addu       $a0, $s0, $zero
    /* E31BC 800F29BC 000045AC */  sw         $a1, 0x0($v0)
    /* E31C0 800F29C0 9CCB030C */  jal        func_800F2E70
    /* E31C4 800F29C4 1A040524 */   addiu     $a1, $zero, 0x41A
    /* E31C8 800F29C8 A319040C */  jal        setjmp
    /* E31CC 800F29CC 38000426 */   addiu     $a0, $s0, 0x38
    /* E31D0 800F29D0 03004010 */  beqz       $v0, .L800F29E0
    /* E31D4 800F29D4 00000000 */   nop
    /* E31D8 800F29D8 90CA030C */  jal        func_800F2A40
    /* E31DC 800F29DC 00000000 */   nop
  .L800F29E0:
    /* E31E0 800F29E0 1380103C */  lui        $s0, %hi(D_80134B34)
    /* E31E4 800F29E4 344B1026 */  addiu      $s0, $s0, %lo(D_80134B34)
    /* E31E8 800F29E8 FCFF0426 */  addiu      $a0, $s0, -0x4
    /* E31EC 800F29EC DC0F0226 */  addiu      $v0, $s0, 0xFDC
    /* E31F0 800F29F0 A719040C */  jal        HookEntryInt
    /* E31F4 800F29F4 000002AE */   sw        $v0, 0x0($s0)
    /* E31F8 800F29F8 01000224 */  addiu      $v0, $zero, 0x1
    /* E31FC 800F29FC 4D19040C */  jal        startIntrVSync
    /* E3200 800F2A00 C4FF02A6 */   sh        $v0, -0x3C($s0)
    /* E3204 800F2A04 1380033C */  lui        $v1, %hi(D_80135B80)
    /* E3208 800F2A08 805B638C */  lw         $v1, %lo(D_80135B80)($v1)
    /* E320C 800F2A0C AB19040C */  jal        startIntrDMA
    /* E3210 800F2A10 140062AC */   sw        $v0, 0x14($v1)
    /* E3214 800F2A14 1380043C */  lui        $a0, %hi(D_80135B80)
    /* E3218 800F2A18 805B848C */  lw         $a0, %lo(D_80135B80)($a0)
    /* E321C 800F2A1C 551A040C */  jal        _96_remove
    /* E3220 800F2A20 040082AC */   sw        $v0, 0x4($a0)
    /* E3224 800F2A24 5B1A040C */  jal        ExitCriticalSection
    /* E3228 800F2A28 C4FF1026 */   addiu     $s0, $s0, -0x3C
    /* E322C 800F2A2C 21100002 */  addu       $v0, $s0, $zero
  .L800F2A30:
    /* E3230 800F2A30 1400BF8F */  lw         $ra, 0x14($sp)
    /* E3234 800F2A34 1000B08F */  lw         $s0, 0x10($sp)
    /* E3238 800F2A38 0800E003 */  jr         $ra
    /* E323C 800F2A3C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_800F2968
