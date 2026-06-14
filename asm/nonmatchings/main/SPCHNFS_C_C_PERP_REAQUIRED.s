.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_C_PERP_REAQUIRED, 0x74

glabel SPCHNFS_C_C_PERP_REAQUIRED
    /* 84140 80093940 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 84144 80093944 4000BFAF */  sw         $ra, 0x40($sp)
    /* 84148 80093948 0B000824 */  addiu      $t0, $zero, 0xB
    /* 8414C 8009394C 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093950:
    /* 84150 80093950 000040AC */  sw         $zero, 0x0($v0)
    /* 84154 80093954 FFFF0825 */  addiu      $t0, $t0, -0x1
    /* 84158 80093958 FDFF0105 */  bgez       $t0, .L80093950
    /* 8415C 8009395C FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 84160 80093960 7C010224 */  addiu      $v0, $zero, 0x17C
    /* 84164 80093964 1000A2AF */  sw         $v0, 0x10($sp)
    /* 84168 80093968 0000828C */  lw         $v0, 0x0($a0)
    /* 8416C 8009396C 00000000 */  nop
    /* 84170 80093970 1400A2AF */  sw         $v0, 0x14($sp)
    /* 84174 80093974 0000A28C */  lw         $v0, 0x0($a1)
    /* 84178 80093978 1C00A6AF */  sw         $a2, 0x1C($sp)
    /* 8417C 8009397C 1800A2AF */  sw         $v0, 0x18($sp)
    /* 84180 80093980 5800A28F */  lw         $v0, 0x58($sp)
    /* 84184 80093984 0000E38C */  lw         $v1, 0x0($a3)
    /* 84188 80093988 2400A2AF */  sw         $v0, 0x24($sp)
    /* 8418C 8009398C 5C00A28F */  lw         $v0, 0x5C($sp)
    /* 84190 80093990 2000A3AF */  sw         $v1, 0x20($sp)
    /* 84194 80093994 0000428C */  lw         $v0, 0x0($v0)
    /* 84198 80093998 1000A427 */  addiu      $a0, $sp, 0x10
    /* 8419C 8009399C 6E9C030C */  jal        SPCH_AddEvent
    /* 841A0 800939A0 2800A2AF */   sw        $v0, 0x28($sp)
    /* 841A4 800939A4 4000BF8F */  lw         $ra, 0x40($sp)
    /* 841A8 800939A8 00000000 */  nop
    /* 841AC 800939AC 0800E003 */  jr         $ra
    /* 841B0 800939B0 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_C_PERP_REAQUIRED
