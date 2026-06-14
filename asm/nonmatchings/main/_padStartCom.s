.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _padStartCom, 0xCC

glabel _padStartCom
    /* F541C 80104C1C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F5420 80104C20 1400BFAF */  sw         $ra, 0x14($sp)
    /* F5424 80104C24 1000B0AF */  sw         $s0, 0x10($sp)
    /* F5428 80104C28 1380013C */  lui        $at, %hi(_padIntExec)
    /* F542C 80104C2C 631A040C */  jal        EnterCriticalSection
    /* F5430 80104C30 B07C20AC */   sw        $zero, %lo(_padIntExec)($at)
    /* F5434 80104C34 02000424 */  addiu      $a0, $zero, 0x2
    /* F5438 80104C38 1580103C */  lui        $s0, %hi(D_8014857C)
    /* F543C 80104C3C 7C851026 */  addiu      $s0, $s0, %lo(D_8014857C)
    /* F5440 80104C40 F22F040C */  jal        SysDeqIntRP
    /* F5444 80104C44 21280002 */   addu      $a1, $s0, $zero
    /* F5448 80104C48 02000424 */  addiu      $a0, $zero, 0x2
    /* F544C 80104C4C F62F040C */  jal        SysEnqIntRP
    /* F5450 80104C50 21280002 */   addu      $a1, $s0, $zero
    /* F5454 80104C54 03000424 */  addiu      $a0, $zero, 0x3
    /* F5458 80104C58 1380033C */  lui        $v1, %hi(D_80137CD8)
    /* F545C 80104C5C D87C638C */  lw         $v1, %lo(D_80137CD8)($v1)
    /* F5460 80104C60 FEFF0224 */  addiu      $v0, $zero, -0x2
    /* F5464 80104C64 000062AC */  sw         $v0, 0x0($v1)
    /* F5468 80104C68 0400628C */  lw         $v0, 0x4($v1)
    /* F546C 80104C6C 21280000 */  addu       $a1, $zero, $zero
    /* F5470 80104C70 01004234 */  ori        $v0, $v0, 0x1
    /* F5474 80104C74 9919040C */  jal        ChangeClearRCnt
    /* F5478 80104C78 040062AC */   sw        $v0, 0x4($v1)
    /* F547C 80104C7C 5B1A040C */  jal        ExitCriticalSection
    /* F5480 80104C80 00000000 */   nop
    /* F5484 80104C84 1380043C */  lui        $a0, %hi(_padInfoDir)
    /* F5488 80104C88 AC7C848C */  lw         $a0, %lo(_padInfoDir)($a0)
    /* F548C 80104C8C 1380023C */  lui        $v0, %hi(_padFuncClrInfo)
    /* F5490 80104C90 7C7C428C */  lw         $v0, %lo(_padFuncClrInfo)($v0)
    /* F5494 80104C94 00000000 */  nop
    /* F5498 80104C98 09F84000 */  jalr       $v0
    /* F549C 80104C9C 00000000 */   nop
    /* F54A0 80104CA0 1380043C */  lui        $a0, %hi(_padInfoDir)
    /* F54A4 80104CA4 AC7C848C */  lw         $a0, %lo(_padInfoDir)($a0)
    /* F54A8 80104CA8 1380023C */  lui        $v0, %hi(_padFuncClrInfo)
    /* F54AC 80104CAC 7C7C428C */  lw         $v0, %lo(_padFuncClrInfo)($v0)
    /* F54B0 80104CB0 00000000 */  nop
    /* F54B4 80104CB4 09F84000 */  jalr       $v0
    /* F54B8 80104CB8 F0008424 */   addiu     $a0, $a0, 0xF0
    /* F54BC 80104CBC 1580023C */  lui        $v0, %hi(D_8014858C)
    /* F54C0 80104CC0 8C854224 */  addiu      $v0, $v0, %lo(D_8014858C)
    /* F54C4 80104CC4 040040AC */  sw         $zero, 0x4($v0)
    /* F54C8 80104CC8 000040AC */  sw         $zero, 0x0($v0)
    /* F54CC 80104CCC 01000224 */  addiu      $v0, $zero, 0x1
    /* F54D0 80104CD0 1380013C */  lui        $at, %hi(_padIntExec)
    /* F54D4 80104CD4 B07C22AC */  sw         $v0, %lo(_padIntExec)($at)
    /* F54D8 80104CD8 1400BF8F */  lw         $ra, 0x14($sp)
    /* F54DC 80104CDC 1000B08F */  lw         $s0, 0x10($sp)
    /* F54E0 80104CE0 0800E003 */  jr         $ra
    /* F54E4 80104CE4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel _padStartCom
