.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Fog_MakeTrackPathName__FPc, 0x50

glabel Fog_MakeTrackPathName__FPc
    /* D16C4 800E0EC4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D16C8 800E0EC8 1800B0AF */  sw         $s0, 0x18($sp)
    /* D16CC 800E0ECC 1480103C */  lui        $s0, %hi(D_8013E85C)
    /* D16D0 800E0ED0 5CE81026 */  addiu      $s0, $s0, %lo(D_8013E85C)
    /* D16D4 800E0ED4 0580053C */  lui        $a1, %hi(D_80056AB8)
    /* D16D8 800E0ED8 1180033C */  lui        $v1, %hi(D_80116480)
    /* D16DC 800E0EDC 1180023C */  lui        $v0, %hi(D_80113228)
    /* D16E0 800E0EE0 1000A4AF */  sw         $a0, 0x10($sp)
    /* D16E4 800E0EE4 21200002 */  addu       $a0, $s0, $zero
    /* D16E8 800E0EE8 2832478C */  lw         $a3, %lo(D_80113228)($v0)
    /* D16EC 800E0EEC 8064668C */  lw         $a2, %lo(D_80116480)($v1)
    /* D16F0 800E0EF0 B86AA524 */  addiu      $a1, $a1, %lo(D_80056AB8)
    /* D16F4 800E0EF4 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* D16F8 800E0EF8 2F91030C */  jal        sprintf
    /* D16FC 800E0EFC 0F00E730 */   andi      $a3, $a3, 0xF
    /* D1700 800E0F00 21100002 */  addu       $v0, $s0, $zero
    /* D1704 800E0F04 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* D1708 800E0F08 1800B08F */  lw         $s0, 0x18($sp)
    /* D170C 800E0F0C 0800E003 */  jr         $ra
    /* D1710 800E0F10 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Fog_MakeTrackPathName__FPc
