.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_FBuildF4__FiiiiiUlcc, 0xC0

glabel Hud_FBuildF4__FiiiiiUlcc
    /* C3184 800D2984 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* C3188 800D2988 21708000 */  addu       $t6, $a0, $zero
    /* C318C 800D298C 2178A000 */  addu       $t7, $a1, $zero
    /* C3190 800D2990 2800B0AF */  sw         $s0, 0x28($sp)
    /* C3194 800D2994 2180C000 */  addu       $s0, $a2, $zero
    /* C3198 800D2998 801F0D3C */  lui        $t5, (0x1F800004 >> 16)
    /* C319C 800D299C 0400AD35 */  ori        $t5, $t5, (0x1F800004 & 0xFFFF)
    /* C31A0 800D29A0 FF00083C */  lui        $t0, (0xFFFFFF >> 16)
    /* C31A4 800D29A4 FFFF0835 */  ori        $t0, $t0, (0xFFFFFF & 0xFFFF)
    /* C31A8 800D29A8 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* C31AC 800D29AC 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* C31B0 800D29B0 0000A48D */  lw         $a0, 0x0($t5)
    /* C31B4 800D29B4 801F093C */  lui        $t1, (0x1F800000 >> 16)
    /* C31B8 800D29B8 0000298D */  lw         $t1, (0x1F800000 & 0xFFFF)($t1)
    /* C31BC 800D29BC 0000838C */  lw         $v1, 0x0($a0)
    /* C31C0 800D29C0 0000228D */  lw         $v0, 0x0($t1)
    /* C31C4 800D29C4 24186A00 */  and        $v1, $v1, $t2
    /* C31C8 800D29C8 24104800 */  and        $v0, $v0, $t0
    /* C31CC 800D29CC 25186200 */  or         $v1, $v1, $v0
    /* C31D0 800D29D0 000083AC */  sw         $v1, 0x0($a0)
    /* C31D4 800D29D4 18008324 */  addiu      $v1, $a0, 0x18
    /* C31D8 800D29D8 4000AB8F */  lw         $t3, 0x40($sp)
    /* C31DC 800D29DC 4400AC8F */  lw         $t4, 0x44($sp)
    /* C31E0 800D29E0 4800A58F */  lw         $a1, 0x48($sp)
    /* C31E4 800D29E4 4C00A68F */  lw         $a2, 0x4C($sp)
    /* C31E8 800D29E8 0000228D */  lw         $v0, 0x0($t1)
    /* C31EC 800D29EC 24408800 */  and        $t0, $a0, $t0
    /* C31F0 800D29F0 0000A3AD */  sw         $v1, 0x0($t5)
    /* C31F4 800D29F4 24104A00 */  and        $v0, $v0, $t2
    /* C31F8 800D29F8 25104800 */  or         $v0, $v0, $t0
    /* C31FC 800D29FC 002E0500 */  sll        $a1, $a1, 24
    /* C3200 800D2A00 032E0500 */  sra        $a1, $a1, 24
    /* C3204 800D2A04 00360600 */  sll        $a2, $a2, 24
    /* C3208 800D2A08 03360600 */  sra        $a2, $a2, 24
    /* C320C 800D2A0C 000022AD */  sw         $v0, 0x0($t1)
    /* C3210 800D2A10 1C00A5AF */  sw         $a1, 0x1C($sp)
    /* C3214 800D2A14 2128C001 */  addu       $a1, $t6, $zero
    /* C3218 800D2A18 2000A6AF */  sw         $a2, 0x20($sp)
    /* C321C 800D2A1C 2130E001 */  addu       $a2, $t7, $zero
    /* C3220 800D2A20 1000A7AF */  sw         $a3, 0x10($sp)
    /* C3224 800D2A24 21380002 */  addu       $a3, $s0, $zero
    /* C3228 800D2A28 1400ABAF */  sw         $t3, 0x14($sp)
    /* C322C 800D2A2C E549030C */  jal        Hud_BuildF4o__FP7POLY_F4iiiiiUlScSc
    /* C3230 800D2A30 1800ACAF */   sw        $t4, 0x18($sp)
    /* C3234 800D2A34 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* C3238 800D2A38 2800B08F */  lw         $s0, 0x28($sp)
    /* C323C 800D2A3C 0800E003 */  jr         $ra
    /* C3240 800D2A40 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Hud_FBuildF4__FiiiiiUlcc
