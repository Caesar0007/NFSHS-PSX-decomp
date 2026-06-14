.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_AvoidObjects__FP8Car_tObj, 0x34

glabel AI_AvoidObjects__FP8Car_tObj
    /* 4A128 80059928 1480023C */  lui        $v0, %hi(Object_customObjInst)
    /* 4A12C 8005992C C8D2428C */  lw         $v0, %lo(Object_customObjInst)($v0)
    /* 4A130 80059930 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4A134 80059934 05004010 */  beqz       $v0, .L8005994C
    /* 4A138 80059938 1000BFAF */   sw        $ra, 0x10($sp)
    /* 4A13C 8005993C 1480053C */  lui        $a1, %hi(Object_customSimObjs)
    /* 4A140 80059940 CCD2A58C */  lw         $a1, %lo(Object_customSimObjs)($a1)
    /* 4A144 80059944 CB65010C */  jal        func_8005972C
    /* 4A148 80059948 00000000 */   nop
  .L8005994C:
    /* 4A14C 8005994C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 4A150 80059950 00000000 */  nop
    /* 4A154 80059954 0800E003 */  jr         $ra
    /* 4A158 80059958 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AI_AvoidObjects__FP8Car_tObj
