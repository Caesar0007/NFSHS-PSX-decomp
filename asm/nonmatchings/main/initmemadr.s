.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching initmemadr, 0x70

glabel initmemadr
    /* E4980 800F4180 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* E4984 800F4184 21308000 */  addu       $a2, $a0, $zero
    /* E4988 800F4188 2138A000 */  addu       $a3, $a1, $zero
    /* E498C 800F418C 08000224 */  addiu      $v0, $zero, 0x8
    /* E4990 800F4190 1000A2AF */  sw         $v0, 0x10($sp)
    /* E4994 800F4194 20000224 */  addiu      $v0, $zero, 0x20
    /* E4998 800F4198 1400A2AF */  sw         $v0, 0x14($sp)
    /* E499C 800F419C 0F80023C */  lui        $v0, %hi(MEM_defaultevent)
    /* E49A0 800F41A0 78414224 */  addiu      $v0, $v0, %lo(MEM_defaultevent)
    /* E49A4 800F41A4 1480053C */  lui        $a1, %hi(D_8013DD48)
    /* E49A8 800F41A8 21200000 */  addu       $a0, $zero, $zero
    /* E49AC 800F41AC 48DDA524 */  addiu      $a1, $a1, %lo(D_8013DD48)
    /* E49B0 800F41B0 3000BFAF */  sw         $ra, 0x30($sp)
    /* E49B4 800F41B4 1800A0AF */  sw         $zero, 0x18($sp)
    /* E49B8 800F41B8 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* E49BC 800F41BC 2000A0AF */  sw         $zero, 0x20($sp)
    /* E49C0 800F41C0 2400A0AF */  sw         $zero, 0x24($sp)
    /* E49C4 800F41C4 2800A0AF */  sw         $zero, 0x28($sp)
    /* E49C8 800F41C8 2594030C */  jal        creatememclass
    /* E49CC 800F41CC 2C00A2AF */   sw        $v0, 0x2C($sp)
    /* E49D0 800F41D0 1480033C */  lui        $v1, %hi(memclass)
    /* E49D4 800F41D4 00E9648C */  lw         $a0, %lo(memclass)($v1)
    /* E49D8 800F41D8 00E96324 */  addiu      $v1, $v1, %lo(memclass)
    /* E49DC 800F41DC 040064AC */  sw         $a0, 0x4($v1)
    /* E49E0 800F41E0 3000BF8F */  lw         $ra, 0x30($sp)
    /* E49E4 800F41E4 00000000 */  nop
    /* E49E8 800F41E8 0800E003 */  jr         $ra
    /* E49EC 800F41EC 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel initmemadr
