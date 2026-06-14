.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Scene_LoadSceneFile__Fi, 0x90

glabel Scene_LoadSceneFile__Fi
    /* A6884 800B6084 60FFBD27 */  addiu      $sp, $sp, -0xA0
    /* A6888 800B6088 9800B0AF */  sw         $s0, 0x98($sp)
    /* A688C 800B608C 9C00BFAF */  sw         $ra, 0x9C($sp)
    /* A6890 800B6090 9B95020C */  jal        Object_ClearCustomObjects__Fv
    /* A6894 800B6094 21808000 */   addu      $s0, $a0, $zero
    /* A6898 800B6098 1000A427 */  addiu      $a0, $sp, 0x10
    /* A689C 800B609C 1180023C */  lui        $v0, %hi(D_80116480)
    /* A68A0 800B60A0 0580053C */  lui        $a1, %hi(D_80056598)
    /* A68A4 800B60A4 8064468C */  lw         $a2, %lo(D_80116480)($v0)
    /* A68A8 800B60A8 9865A524 */  addiu      $a1, $a1, %lo(D_80056598)
    /* A68AC 800B60AC 2F91030C */  jal        sprintf
    /* A68B0 800B60B0 9000A0AF */   sw        $zero, 0x90($sp)
    /* A68B4 800B60B4 1000A427 */  addiu      $a0, $sp, 0x10
    /* A68B8 800B60B8 10000524 */  addiu      $a1, $zero, 0x10
    /* A68BC 800B60BC 64000624 */  addiu      $a2, $zero, 0x64
    /* A68C0 800B60C0 7EAA030C */  jal        FILE_addbigsync
    /* A68C4 800B60C4 9000A727 */   addiu     $a3, $sp, 0x90
    /* A68C8 800B60C8 1000A427 */  addiu      $a0, $sp, 0x10
    /* A68CC 800B60CC 0580053C */  lui        $a1, %hi(D_800565A4)
    /* A68D0 800B60D0 A465A524 */  addiu      $a1, $a1, %lo(D_800565A4)
    /* A68D4 800B60D4 1180023C */  lui        $v0, %hi(D_80113228)
    /* A68D8 800B60D8 2832468C */  lw         $a2, %lo(D_80113228)($v0)
    /* A68DC 800B60DC 2F91030C */  jal        sprintf
    /* A68E0 800B60E0 21380002 */   addu      $a3, $s0, $zero
    /* A68E4 800B60E4 1000A427 */  addiu      $a0, $sp, 0x10
    /* A68E8 800B60E8 BC0E80AF */  sw         $zero, %gp_rel(gGameSceneList)($gp)
    /* A68EC 800B60EC FA95030C */  jal        loadfileadr
    /* A68F0 800B60F0 21280000 */   addu      $a1, $zero, $zero
    /* A68F4 800B60F4 9000A48F */  lw         $a0, 0x90($sp)
    /* A68F8 800B60F8 BC0E82AF */  sw         $v0, %gp_rel(gGameSceneList)($gp)
    /* A68FC 800B60FC 9CAA030C */  jal        FILE_delbigsync
    /* A6900 800B6100 64000524 */   addiu     $a1, $zero, 0x64
    /* A6904 800B6104 9C00BF8F */  lw         $ra, 0x9C($sp)
    /* A6908 800B6108 9800B08F */  lw         $s0, 0x98($sp)
    /* A690C 800B610C 0800E003 */  jr         $ra
    /* A6910 800B6110 A000BD27 */   addiu     $sp, $sp, 0xA0
endlabel Scene_LoadSceneFile__Fi
