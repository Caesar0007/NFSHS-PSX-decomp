.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _padSetVsyncParam, 0x2C

glabel _padSetVsyncParam
    /* F521C 80104A1C 1580023C */  lui        $v0, %hi(D_80148580)
    /* F5220 80104A20 80854224 */  addiu      $v0, $v0, %lo(D_80148580)
    /* F5224 80104A24 1080033C */  lui        $v1, %hi(_padVbCallback0)
    /* F5228 80104A28 B04A6324 */  addiu      $v1, $v1, %lo(_padVbCallback0)
    /* F522C 80104A2C 000043AC */  sw         $v1, 0x0($v0)
    /* F5230 80104A30 1080033C */  lui        $v1, %hi(_padVbCallback1)
    /* F5234 80104A34 484A6324 */  addiu      $v1, $v1, %lo(_padVbCallback1)
    /* F5238 80104A38 040043AC */  sw         $v1, 0x4($v0)
    /* F523C 80104A3C FCFF40AC */  sw         $zero, -0x4($v0)
    /* F5240 80104A40 0800E003 */  jr         $ra
    /* F5244 80104A44 080040AC */   sw        $zero, 0x8($v0)
endlabel _padSetVsyncParam
