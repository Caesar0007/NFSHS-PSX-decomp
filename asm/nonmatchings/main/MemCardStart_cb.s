.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MemCardStart_cb, 0x84

glabel MemCardStart_cb
    /* EC970 800FC170 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* EC974 800FC174 1000BFAF */  sw         $ra, 0x10($sp)
    /* EC978 800FC178 3E27040C */  jal        UserFuncComplete
    /* EC97C 800FC17C 00000000 */   nop
    /* EC980 800FC180 18004014 */  bnez       $v0, .L800FC1E4
    /* EC984 800FC184 00000000 */   nop
    /* EC988 800FC188 2327040C */  jal        UserFuncExecute
    /* EC98C 800FC18C 00000000 */   nop
    /* EC990 800FC190 3E27040C */  jal        UserFuncComplete
    /* EC994 800FC194 00000000 */   nop
    /* EC998 800FC198 12004010 */  beqz       $v0, .L800FC1E4
    /* EC99C 800FC19C 01000224 */   addiu     $v0, $zero, 0x1
    /* EC9A0 800FC1A0 1480033C */  lui        $v1, %hi(D_80147518)
    /* EC9A4 800FC1A4 18756324 */  addiu      $v1, $v1, %lo(D_80147518)
    /* EC9A8 800FC1A8 080062AC */  sw         $v0, 0x8($v1)
    /* EC9AC 800FC1AC 0000628C */  lw         $v0, 0x0($v1)
    /* EC9B0 800FC1B0 1480053C */  lui        $a1, %hi(D_80147560)
    /* EC9B4 800FC1B4 6075A524 */  addiu      $a1, $a1, %lo(D_80147560)
    /* EC9B8 800FC1B8 0000A2AC */  sw         $v0, 0x0($a1)
    /* EC9BC 800FC1BC 0400628C */  lw         $v0, 0x4($v1)
    /* EC9C0 800FC1C0 4000668C */  lw         $a2, 0x40($v1)
    /* EC9C4 800FC1C4 0400A2AC */  sw         $v0, 0x4($a1)
    /* EC9C8 800FC1C8 000060AC */  sw         $zero, 0x0($v1)
    /* EC9CC 800FC1CC 0500C010 */  beqz       $a2, .L800FC1E4
    /* EC9D0 800FC1D0 040060AC */   sw        $zero, 0x4($v1)
    /* EC9D4 800FC1D4 0000A48C */  lw         $a0, 0x0($a1)
    /* EC9D8 800FC1D8 0400A58C */  lw         $a1, 0x4($a1)
    /* EC9DC 800FC1DC 09F8C000 */  jalr       $a2
    /* EC9E0 800FC1E0 00000000 */   nop
  .L800FC1E4:
    /* EC9E4 800FC1E4 1000BF8F */  lw         $ra, 0x10($sp)
    /* EC9E8 800FC1E8 1800BD27 */  addiu      $sp, $sp, 0x18
    /* EC9EC 800FC1EC 0800E003 */  jr         $ra
    /* EC9F0 800FC1F0 00000000 */   nop
endlabel MemCardStart_cb
