.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DepthCue_Init__Fv, 0x48

glabel DepthCue_Init__Fv
    /* BB150 800CA950 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* BB154 800CA954 1000B0AF */  sw         $s0, 0x10($sp)
    /* BB158 800CA958 1280103C */  lui        $s0, %hi(TrackSpec_gSpec)
    /* BB15C 800CA95C 7C321026 */  addiu      $s0, $s0, %lo(TrackSpec_gSpec)
    /* BB160 800CA960 1400BFAF */  sw         $ra, 0x14($sp)
    /* BB164 800CA964 F400048E */  lw         $a0, 0xF4($s0)
    /* BB168 800CA968 A0000524 */  addiu      $a1, $zero, 0xA0
    /* BB16C 800CA96C F7C9030C */  jal        SetFogNear
    /* BB170 800CA970 80210400 */   sll       $a0, $a0, 6
    /* BB174 800CA974 F0000492 */  lbu        $a0, 0xF0($s0)
    /* BB178 800CA978 F1000592 */  lbu        $a1, 0xF1($s0)
    /* BB17C 800CA97C F2000692 */  lbu        $a2, 0xF2($s0)
    /* BB180 800CA980 EFC9030C */  jal        SetFarColor
    /* BB184 800CA984 00000000 */   nop
    /* BB188 800CA988 1400BF8F */  lw         $ra, 0x14($sp)
    /* BB18C 800CA98C 1000B08F */  lw         $s0, 0x10($sp)
    /* BB190 800CA990 0800E003 */  jr         $ra
    /* BB194 800CA994 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel DepthCue_Init__Fv
