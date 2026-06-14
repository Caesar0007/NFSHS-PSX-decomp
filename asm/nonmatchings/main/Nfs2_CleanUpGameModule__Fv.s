.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Nfs2_CleanUpGameModule__Fv, 0x1A4

glabel Nfs2_CleanUpGameModule__Fv
    /* 94B54 800A4354 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 94B58 800A4358 1000BFAF */  sw         $ra, 0x10($sp)
    /* 94B5C 800A435C 08CE020C */  jal        Render_KillTrackRender__Fv
    /* 94B60 800A4360 00000000 */   nop
    /* 94B64 800A4364 22CD020C */  jal        Render_KillPauseMenu__Fv
    /* 94B68 800A4368 00000000 */   nop
    /* 94B6C 800A436C 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 94B70 800A4370 EC314324 */  addiu      $v1, $v0, %lo(GameSetup_gData)
    /* 94B74 800A4374 C403628C */  lw         $v0, 0x3C4($v1)
    /* 94B78 800A4378 00000000 */  nop
    /* 94B7C 800A437C 3B004018 */  blez       $v0, .L800A446C
    /* 94B80 800A4380 21380000 */   addu      $a3, $zero, $zero
    /* 94B84 800A4384 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 94B88 800A4388 DCF94A24 */  addiu      $t2, $v0, %lo(Cars_gList)
    /* 94B8C 800A438C 1180023C */  lui        $v0, %hi(Cars_gNewCarStatsList)
    /* 94B90 800A4390 44FB4924 */  addiu      $t1, $v0, %lo(Cars_gNewCarStatsList)
    /* 94B94 800A4394 21406000 */  addu       $t0, $v1, $zero
    /* 94B98 800A4398 00340700 */  sll        $a2, $a3, 16
  .L800A439C:
    /* 94B9C 800A439C 03340600 */  sra        $a2, $a2, 16
    /* 94BA0 800A43A0 80200600 */  sll        $a0, $a2, 2
    /* 94BA4 800A43A4 21288A00 */  addu       $a1, $a0, $t2
    /* 94BA8 800A43A8 0000A38C */  lw         $v1, 0x0($a1)
    /* 94BAC 800A43AC 00000000 */  nop
    /* 94BB0 800A43B0 8802628C */  lw         $v0, 0x288($v1)
    /* 94BB4 800A43B4 00000000 */  nop
    /* 94BB8 800A43B8 0000428C */  lw         $v0, 0x0($v0)
    /* 94BBC 800A43BC 00000000 */  nop
    /* 94BC0 800A43C0 AC0362AC */  sw         $v0, 0x3AC($v1)
    /* 94BC4 800A43C4 0000A38C */  lw         $v1, 0x0($a1)
    /* 94BC8 800A43C8 00000000 */  nop
    /* 94BCC 800A43CC 8802628C */  lw         $v0, 0x288($v1)
    /* 94BD0 800A43D0 00000000 */  nop
    /* 94BD4 800A43D4 0400428C */  lw         $v0, 0x4($v0)
    /* 94BD8 800A43D8 00000000 */  nop
    /* 94BDC 800A43DC B00362AC */  sw         $v0, 0x3B0($v1)
    /* 94BE0 800A43E0 0000A38C */  lw         $v1, 0x0($a1)
    /* 94BE4 800A43E4 00000000 */  nop
    /* 94BE8 800A43E8 8802628C */  lw         $v0, 0x288($v1)
    /* 94BEC 800A43EC 00000000 */  nop
    /* 94BF0 800A43F0 5800428C */  lw         $v0, 0x58($v0)
    /* 94BF4 800A43F4 00000000 */  nop
    /* 94BF8 800A43F8 B40362AC */  sw         $v0, 0x3B4($v1)
    /* 94BFC 800A43FC 0000A38C */  lw         $v1, 0x0($a1)
    /* 94C00 800A4400 21208600 */  addu       $a0, $a0, $a2
    /* 94C04 800A4404 6002628C */  lw         $v0, 0x260($v1)
    /* 94C08 800A4408 40210400 */  sll        $a0, $a0, 5
    /* 94C0C 800A440C B80362AC */  sw         $v0, 0x3B8($v1)
    /* 94C10 800A4410 0000A28C */  lw         $v0, 0x0($a1)
    /* 94C14 800A4414 21208900 */  addu       $a0, $a0, $t1
    /* 94C18 800A4418 4C034324 */  addiu      $v1, $v0, 0x34C
    /* 94C1C 800A441C EC034224 */  addiu      $v0, $v0, 0x3EC
  .L800A4420:
    /* 94C20 800A4420 00006B8C */  lw         $t3, 0x0($v1)
    /* 94C24 800A4424 04006C8C */  lw         $t4, 0x4($v1)
    /* 94C28 800A4428 08006D8C */  lw         $t5, 0x8($v1)
    /* 94C2C 800A442C 0C006E8C */  lw         $t6, 0xC($v1)
    /* 94C30 800A4430 00008BAC */  sw         $t3, 0x0($a0)
    /* 94C34 800A4434 04008CAC */  sw         $t4, 0x4($a0)
    /* 94C38 800A4438 08008DAC */  sw         $t5, 0x8($a0)
    /* 94C3C 800A443C 0C008EAC */  sw         $t6, 0xC($a0)
    /* 94C40 800A4440 10006324 */  addiu      $v1, $v1, 0x10
    /* 94C44 800A4444 F6FF6214 */  bne        $v1, $v0, .L800A4420
    /* 94C48 800A4448 10008424 */   addiu     $a0, $a0, 0x10
    /* 94C4C 800A444C 0100E224 */  addiu      $v0, $a3, 0x1
    /* 94C50 800A4450 21384000 */  addu       $a3, $v0, $zero
    /* 94C54 800A4454 00140200 */  sll        $v0, $v0, 16
    /* 94C58 800A4458 C403038D */  lw         $v1, 0x3C4($t0)
    /* 94C5C 800A445C 03140200 */  sra        $v0, $v0, 16
    /* 94C60 800A4460 2A104300 */  slt        $v0, $v0, $v1
    /* 94C64 800A4464 CDFF4014 */  bnez       $v0, .L800A439C
    /* 94C68 800A4468 00340700 */   sll       $a2, $a3, 16
  .L800A446C:
    /* 94C6C 800A446C 27D0020C */  jal        Replay_StoringReplay__Fv
    /* 94C70 800A4470 00000000 */   nop
    /* 94C74 800A4474 D1DB010C */  jal        AudioCmn_DeInit__Fv
    /* 94C78 800A4478 00000000 */   nop
    /* 94C7C 800A447C 1480043C */  lui        $a0, %hi(_6Speech_fgSpeech)
    /* 94C80 800A4480 84CD848C */  lw         $a0, %lo(_6Speech_fgSpeech)($a0)
    /* 94C84 800A4484 00000000 */  nop
    /* 94C88 800A4488 05008010 */  beqz       $a0, .L800A44A0
    /* 94C8C 800A448C 00000000 */   nop
    /* 94C90 800A4490 CC56020C */  jal        ___6Speech
    /* 94C94 800A4494 03000524 */   addiu     $a1, $zero, 0x3
    /* 94C98 800A4498 1480013C */  lui        $at, %hi(_6Speech_fgSpeech)
    /* 94C9C 800A449C 84CD20AC */  sw         $zero, %lo(_6Speech_fgSpeech)($at)
  .L800A44A0:
    /* 94CA0 800A44A0 B766020C */  jal        CopSpeak_CleanUp__Fv
    /* 94CA4 800A44A4 00000000 */   nop
    /* 94CA8 800A44A8 902E020C */  jal        Clock_SystemCleanUp__Fv
    /* 94CAC 800A44AC 00000000 */   nop
    /* 94CB0 800A44B0 4870020C */  jal        GameSetup_CleanUp__Fv
    /* 94CB4 800A44B4 00000000 */   nop
    /* 94CB8 800A44B8 D5D9020C */  jal        Sim_CleanUp__Fv
    /* 94CBC 800A44BC 00000000 */   nop
    /* 94CC0 800A44C0 6140030C */  jal        Hrz_KillHorizon__Fv
    /* 94CC4 800A44C4 00000000 */   nop
    /* 94CC8 800A44C8 2DFA010C */  jal        BWorld_DeInit__Fv
    /* 94CCC 800A44CC 00000000 */   nop
    /* 94CD0 800A44D0 FB0E020C */  jal        Camera_Kill__Fv
    /* 94CD4 800A44D4 00000000 */   nop
    /* 94CD8 800A44D8 1F8A030C */  jal        Weather_DeInit__Fv
    /* 94CDC 800A44DC 00000000 */   nop
    /* 94CE0 800A44E0 19EF020C */  jal        Audio_DeInitDriver__Fv
    /* 94CE4 800A44E4 00000000 */   nop
    /* 94CE8 800A44E8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 94CEC 800A44EC 00000000 */  nop
    /* 94CF0 800A44F0 0800E003 */  jr         $ra
    /* 94CF4 800A44F4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Nfs2_CleanUpGameModule__Fv
