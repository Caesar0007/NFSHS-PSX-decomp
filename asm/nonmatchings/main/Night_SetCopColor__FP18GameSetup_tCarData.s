.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Night_SetCopColor__FP18GameSetup_tCarData, 0x94

glabel Night_SetCopColor__FP18GameSetup_tCarData
    /* CC048 800DB848 F0FFBD27 */  addiu      $sp, $sp, -0x10
    /* CC04C 800DB84C 1480033C */  lui        $v1, %hi(D_8013D9E2)
    /* CC050 800DB850 E2D96324 */  addiu      $v1, $v1, %lo(D_8013D9E2)
    /* CC054 800DB854 0000828C */  lw         $v0, 0x0($a0)
    /* CC058 800DB858 A000858C */  lw         $a1, 0xA0($a0)
    /* CC05C 800DB85C 21104300 */  addu       $v0, $v0, $v1
    /* CC060 800DB860 00004490 */  lbu        $a0, 0x0($v0)
    /* CC064 800DB864 9C14828F */  lw         $v0, %gp_rel(Night_gCopLightingTableRed)($gp)
    /* CC068 800DB868 A014838F */  lw         $v1, %gp_rel(Night_gCopLightingTableBlue)($gp)
    /* CC06C 800DB86C 0800A2AF */  sw         $v0, 0x8($sp)
    /* CC070 800DB870 1280023C */  lui        $v0, %hi(Night_gCopCountryLightTbl)
    /* CC074 800DB874 180D4224 */  addiu      $v0, $v0, %lo(Night_gCopCountryLightTbl)
    /* CC078 800DB878 0C00A3AF */  sw         $v1, 0xC($sp)
    /* CC07C 800DB87C 80180400 */  sll        $v1, $a0, 2
    /* CC080 800DB880 21186400 */  addu       $v1, $v1, $a0
    /* CC084 800DB884 21186500 */  addu       $v1, $v1, $a1
    /* CC088 800DB888 40180300 */  sll        $v1, $v1, 1
    /* CC08C 800DB88C 21186200 */  addu       $v1, $v1, $v0
    /* CC090 800DB890 0800A68F */  lw         $a2, 0x8($sp)
    /* CC094 800DB894 0C00A78F */  lw         $a3, 0xC($sp)
    /* CC098 800DB898 0000A6AF */  sw         $a2, 0x0($sp)
    /* CC09C 800DB89C 0400A7AF */  sw         $a3, 0x4($sp)
    /* CC0A0 800DB8A0 00006290 */  lbu        $v0, 0x0($v1)
    /* CC0A4 800DB8A4 00000000 */  nop
    /* CC0A8 800DB8A8 80100200 */  sll        $v0, $v0, 2
    /* CC0AC 800DB8AC 2110A203 */  addu       $v0, $sp, $v0
    /* CC0B0 800DB8B0 0000448C */  lw         $a0, 0x0($v0)
    /* CC0B4 800DB8B4 01006290 */  lbu        $v0, 0x1($v1)
    /* CC0B8 800DB8B8 00000000 */  nop
    /* CC0BC 800DB8BC 80100200 */  sll        $v0, $v0, 2
    /* CC0C0 800DB8C0 2110A203 */  addu       $v0, $sp, $v0
    /* CC0C4 800DB8C4 001584AF */  sw         $a0, %gp_rel(Night_gCopColor)($gp)
    /* CC0C8 800DB8C8 0000428C */  lw         $v0, 0x0($v0)
    /* CC0CC 800DB8CC 00000000 */  nop
    /* CC0D0 800DB8D0 041582AF */  sw         $v0, %gp_rel(D_8013DA50)($gp)
    /* CC0D4 800DB8D4 0800E003 */  jr         $ra
    /* CC0D8 800DB8D8 1000BD27 */   addiu     $sp, $sp, 0x10
endlabel Night_SetCopColor__FP18GameSetup_tCarData
