.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_ProcessBarrierCollision__FP8Car_tObj, 0x54

glabel AIPhysic_ProcessBarrierCollision__FP8Car_tObj
    /* 5D120 8006C920 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5D124 8006C924 1000BFAF */  sw         $ra, 0x10($sp)
    /* 5D128 8006C928 6002828C */  lw         $v0, 0x260($a0)
    /* 5D12C 8006C92C 00000000 */  nop
    /* 5D130 8006C930 04004230 */  andi       $v0, $v0, 0x4
    /* 5D134 8006C934 0B004014 */  bnez       $v0, .L8006C964
    /* 5D138 8006C938 0900033C */   lui       $v1, (0x9FFFF >> 16)
    /* 5D13C 8006C93C 6405828C */  lw         $v0, 0x564($a0)
    /* 5D140 8006C940 FFFF6334 */  ori        $v1, $v1, (0x9FFFF & 0xFFFF)
    /* 5D144 8006C944 02004104 */  bgez       $v0, .L8006C950
    /* 5D148 8006C948 00000000 */   nop
    /* 5D14C 8006C94C 23100200 */  negu       $v0, $v0
  .L8006C950:
    /* 5D150 8006C950 2A186200 */  slt        $v1, $v1, $v0
    /* 5D154 8006C954 03006014 */  bnez       $v1, .L8006C964
    /* 5D158 8006C958 00000000 */   nop
    /* 5D15C 8006C95C 7CB2010C */  jal        AIPhysic_ChangeDirection__FP8Car_tObji
    /* 5D160 8006C960 60000524 */   addiu     $a1, $zero, 0x60
  .L8006C964:
    /* 5D164 8006C964 1000BF8F */  lw         $ra, 0x10($sp)
    /* 5D168 8006C968 00000000 */  nop
    /* 5D16C 8006C96C 0800E003 */  jr         $ra
    /* 5D170 8006C970 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AIPhysic_ProcessBarrierCollision__FP8Car_tObj
