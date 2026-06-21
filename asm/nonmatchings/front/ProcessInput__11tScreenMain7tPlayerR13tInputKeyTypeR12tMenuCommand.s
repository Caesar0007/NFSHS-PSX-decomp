.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__11tScreenMain7tPlayerR13tInputKeyTypeR12tMenuCommand, 0x6C

glabel ProcessInput__11tScreenMain7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* 27F98 80037798 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 27F9C 8003779C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 27FA0 800377A0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 27FA4 800377A4 0000C38C */  lw         $v1, 0x0($a2)
    /* 27FA8 800377A8 10000224 */  addiu      $v0, $zero, 0x10
    /* 27FAC 800377AC 11006214 */  bne        $v1, $v0, .L800377F4
    /* 27FB0 800377B0 0580103C */   lui       $s0, %hi(FEApp)
    /* 27FB4 800377B4 C014028E */  lw         $v0, %lo(FEApp)($s0)
    /* 27FB8 800377B8 00000000 */  nop
    /* 27FBC 800377BC 4401428C */  lw         $v0, 0x144($v0)
    /* 27FC0 800377C0 00000000 */  nop
    /* 27FC4 800377C4 0B004018 */  blez       $v0, .L800377F4
    /* 27FC8 800377C8 00000000 */   nop
    /* 27FCC 800377CC C8DB000C */  jal        SwapBackground__11tScreenMaini
    /* 27FD0 800377D0 FFFF0524 */   addiu     $a1, $zero, -0x1
    /* 27FD4 800377D4 0580023C */  lui        $v0, %hi(menuDefs)
    /* 27FD8 800377D8 C014038E */  lw         $v1, %lo(FEApp)($s0)
    /* 27FDC 800377DC 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 27FE0 800377E0 0400638C */  lw         $v1, 0x4($v1)
    /* 27FE4 800377E4 200A4224 */  addiu      $v0, $v0, 0xA20
    /* 27FE8 800377E8 02006214 */  bne        $v1, $v0, .L800377F4
    /* 27FEC 800377EC 1180023C */   lui       $v0, %hi(D_80114604)
    /* 27FF0 800377F0 044640A0 */  sb         $zero, %lo(D_80114604)($v0)
  .L800377F4:
    /* 27FF4 800377F4 1400BF8F */  lw         $ra, 0x14($sp)
    /* 27FF8 800377F8 1000B08F */  lw         $s0, 0x10($sp)
    /* 27FFC 800377FC 0800E003 */  jr         $ra
    /* 28000 80037800 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ProcessInput__11tScreenMain7tPlayerR13tInputKeyTypeR12tMenuCommand
