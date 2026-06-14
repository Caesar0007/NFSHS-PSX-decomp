.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Alloc__9SimpleMemii, 0x4C

glabel Alloc__9SimpleMemii
    /* A7A50 800B7250 0300A524 */  addiu      $a1, $a1, 0x3
    /* A7A54 800B7254 FCFF0224 */  addiu      $v0, $zero, -0x4
    /* A7A58 800B7258 2428A200 */  and        $a1, $a1, $v0
    /* A7A5C 800B725C 0800828C */  lw         $v0, 0x8($a0)
    /* A7A60 800B7260 00000000 */  nop
    /* A7A64 800B7264 2A104500 */  slt        $v0, $v0, $a1
    /* A7A68 800B7268 0A004014 */  bnez       $v0, .L800B7294
    /* A7A6C 800B726C 21100000 */   addu      $v0, $zero, $zero
    /* A7A70 800B7270 0400878C */  lw         $a3, 0x4($a0)
    /* A7A74 800B7274 0500C014 */  bnez       $a2, .L800B728C
    /* A7A78 800B7278 2118E500 */   addu      $v1, $a3, $a1
    /* A7A7C 800B727C 0800828C */  lw         $v0, 0x8($a0)
    /* A7A80 800B7280 040083AC */  sw         $v1, 0x4($a0)
    /* A7A84 800B7284 23104500 */  subu       $v0, $v0, $a1
    /* A7A88 800B7288 080082AC */  sw         $v0, 0x8($a0)
  .L800B728C:
    /* A7A8C 800B728C 0800E003 */  jr         $ra
    /* A7A90 800B7290 2110E000 */   addu      $v0, $a3, $zero
  .L800B7294:
    /* A7A94 800B7294 0800E003 */  jr         $ra
    /* A7A98 800B7298 00000000 */   nop
endlabel Alloc__9SimpleMemii
