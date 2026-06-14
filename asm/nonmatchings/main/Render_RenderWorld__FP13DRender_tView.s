.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Render_RenderWorld__FP13DRender_tView, 0xA4

glabel Render_RenderWorld__FP13DRender_tView
    /* A3AB8 800B32B8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* A3ABC 800B32BC 1000B0AF */  sw         $s0, 0x10($sp)
    /* A3AC0 800B32C0 21808000 */  addu       $s0, $a0, $zero
    /* A3AC4 800B32C4 1800BFAF */  sw         $ra, 0x18($sp)
    /* A3AC8 800B32C8 3DF8010C */  jal        BWorld_OnyxBuildFacets__FP13DRender_tView
    /* A3ACC 800B32CC 1400B1AF */   sw        $s1, 0x14($sp)
    /* A3AD0 800B32D0 801F043C */  lui        $a0, (0x1F8003FC >> 16)
    /* A3AD4 800B32D4 2B91030C */  jal        SetSp
    /* A3AD8 800B32D8 FC038434 */   ori       $a0, $a0, (0x1F8003FC & 0xFFFF)
    /* A3ADC 800B32DC 21884000 */  addu       $s1, $v0, $zero
    /* A3AE0 800B32E0 197D030C */  jal        Skidmark_OnyxBuildFacets__FP13DRender_tView
    /* A3AE4 800B32E4 21200002 */   addu      $a0, $s0, $zero
    /* A3AE8 800B32E8 2B91030C */  jal        SetSp
    /* A3AEC 800B32EC 21202002 */   addu      $a0, $s1, $zero
    /* A3AF0 800B32F0 801F043C */  lui        $a0, (0x1F8003FC >> 16)
    /* A3AF4 800B32F4 2B91030C */  jal        SetSp
    /* A3AF8 800B32F8 FC038434 */   ori       $a0, $a0, (0x1F8003FC & 0xFFFF)
    /* A3AFC 800B32FC 21884000 */  addu       $s1, $v0, $zero
    /* A3B00 800B3300 7ADF020C */  jal        Souffle_InsertFacet__FP13DRender_tView
    /* A3B04 800B3304 21200002 */   addu      $a0, $s0, $zero
    /* A3B08 800B3308 2B91030C */  jal        SetSp
    /* A3B0C 800B330C 21202002 */   addu      $a0, $s1, $zero
    /* A3B10 800B3310 FECA020C */  jal        R3DCar_InsertAllListFacet__FP13DRender_tView
    /* A3B14 800B3314 21200002 */   addu      $a0, $s0, $zero
    /* A3B18 800B3318 C744030C */  jal        Hrz_BuildHorizon__FP13DRender_tView
    /* A3B1C 800B331C 21200002 */   addu      $a0, $s0, $zero
    /* A3B20 800B3320 801F043C */  lui        $a0, (0x1F8003FC >> 16)
    /* A3B24 800B3324 2B91030C */  jal        SetSp
    /* A3B28 800B3328 FC038434 */   ori       $a0, $a0, (0x1F8003FC & 0xFFFF)
    /* A3B2C 800B332C 21884000 */  addu       $s1, $v0, $zero
    /* A3B30 800B3330 4C8F030C */  jal        Weather_BuildWeather__FP13DRender_tView
    /* A3B34 800B3334 21200002 */   addu      $a0, $s0, $zero
    /* A3B38 800B3338 2B91030C */  jal        SetSp
    /* A3B3C 800B333C 21202002 */   addu      $a0, $s1, $zero
    /* A3B40 800B3340 9BCE020C */  jal        Render_InsertDepthOfField__Fv
    /* A3B44 800B3344 00000000 */   nop
    /* A3B48 800B3348 1800BF8F */  lw         $ra, 0x18($sp)
    /* A3B4C 800B334C 1400B18F */  lw         $s1, 0x14($sp)
    /* A3B50 800B3350 1000B08F */  lw         $s0, 0x10($sp)
    /* A3B54 800B3354 0800E003 */  jr         $ra
    /* A3B58 800B3358 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Render_RenderWorld__FP13DRender_tView
