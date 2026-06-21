.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetShapeInfo__11tScreenMainRsT1PPcT3, 0x30

glabel GetShapeInfo__11tScreenMainRsT1PPcT3
    /* 28E98 80038698 1000A38F */  lw         $v1, 0x10($sp)
    /* 28E9C 8003869C 0B010224 */  addiu      $v0, $zero, 0x10B
    /* 28EA0 800386A0 0000A2A4 */  sh         $v0, 0x0($a1)
    /* 28EA4 800386A4 0580023C */  lui        $v0, %hi(D_80052BD0)
    /* 28EA8 800386A8 D02B4224 */  addiu      $v0, $v0, %lo(D_80052BD0)
    /* 28EAC 800386AC 0000E2AC */  sw         $v0, 0x0($a3)
    /* 28EB0 800386B0 0A000224 */  addiu      $v0, $zero, 0xA
    /* 28EB4 800386B4 0000C2A4 */  sh         $v0, 0x0($a2)
    /* 28EB8 800386B8 0580023C */  lui        $v0, %hi(D_80052BB0)
    /* 28EBC 800386BC B02B4224 */  addiu      $v0, $v0, %lo(D_80052BB0)
    /* 28EC0 800386C0 0800E003 */  jr         $ra
    /* 28EC4 800386C4 000062AC */   sw        $v0, 0x0($v1)
endlabel GetShapeInfo__11tScreenMainRsT1PPcT3
