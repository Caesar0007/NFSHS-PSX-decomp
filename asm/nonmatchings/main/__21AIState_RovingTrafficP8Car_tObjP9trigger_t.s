.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __21AIState_RovingTrafficP8Car_tObjP9trigger_t, 0x68

glabel __21AIState_RovingTrafficP8Car_tObjP9trigger_t
    /* 6204C 8007184C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 62050 80071850 1000B0AF */  sw         $s0, 0x10($sp)
    /* 62054 80071854 21808000 */  addu       $s0, $a0, $zero
    /* 62058 80071858 1400B1AF */  sw         $s1, 0x14($sp)
    /* 6205C 8007185C 1800BFAF */  sw         $ra, 0x18($sp)
    /* 62060 80071860 9DBE010C */  jal        __12AIState_BaseP8Car_tObj
    /* 62064 80071864 2188C000 */   addu      $s1, $a2, $zero
    /* 62068 80071868 0580023C */  lui        $v0, %hi(_vt_21AIState_RovingTraffic)
    /* 6206C 8007186C 60554224 */  addiu      $v0, $v0, %lo(_vt_21AIState_RovingTraffic)
    /* 62070 80071870 040002AE */  sw         $v0, 0x4($s0)
    /* 62074 80071874 3C00228E */  lw         $v0, 0x3C($s1)
    /* 62078 80071878 0000048E */  lw         $a0, 0x0($s0)
    /* 6207C 8007187C 080002AE */  sw         $v0, 0x8($s0)
    /* 62080 80071880 3800228E */  lw         $v0, 0x38($s1)
    /* 62084 80071884 100000AE */  sw         $zero, 0x10($s0)
    /* 62088 80071888 140000AE */  sw         $zero, 0x14($s0)
    /* 6208C 8007188C 0C0002AE */  sw         $v0, 0xC($s0)
    /* 62090 80071890 6002838C */  lw         $v1, 0x260($a0)
    /* 62094 80071894 21100002 */  addu       $v0, $s0, $zero
    /* 62098 80071898 00086334 */  ori        $v1, $v1, 0x800
    /* 6209C 8007189C 600283AC */  sw         $v1, 0x260($a0)
    /* 620A0 800718A0 1800BF8F */  lw         $ra, 0x18($sp)
    /* 620A4 800718A4 1400B18F */  lw         $s1, 0x14($sp)
    /* 620A8 800718A8 1000B08F */  lw         $s0, 0x10($sp)
    /* 620AC 800718AC 0800E003 */  jr         $ra
    /* 620B0 800718B0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __21AIState_RovingTrafficP8Car_tObjP9trigger_t
