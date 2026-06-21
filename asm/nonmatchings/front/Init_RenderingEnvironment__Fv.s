.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Init_RenderingEnvironment__Fv, 0xEC

glabel Init_RenderingEnvironment__Fv
    /* 3E50C 8004DD0C C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 3E510 8004DD10 2800B0AF */  sw         $s0, 0x28($sp)
    /* 3E514 8004DD14 1280103C */  lui        $s0, %hi(gEnviro)
    /* 3E518 8004DD18 24F41026 */  addiu      $s0, $s0, %lo(gEnviro)
    /* 3E51C 8004DD1C 21200002 */  addu       $a0, $s0, $zero
    /* 3E520 8004DD20 21280000 */  addu       $a1, $zero, $zero
    /* 3E524 8004DD24 00010624 */  addiu      $a2, $zero, 0x100
    /* 3E528 8004DD28 00020724 */  addiu      $a3, $zero, 0x200
    /* 3E52C 8004DD2C 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* 3E530 8004DD30 F0001124 */  addiu      $s1, $zero, 0xF0
    /* 3E534 8004DD34 3400BFAF */  sw         $ra, 0x34($sp)
    /* 3E538 8004DD38 3000B2AF */  sw         $s2, 0x30($sp)
    /* 3E53C 8004DD3C B8C8030C */  jal        SetDefDispEnv
    /* 3E540 8004DD40 1000B1AF */   sw        $s1, 0x10($sp)
    /* 3E544 8004DD44 18000426 */  addiu      $a0, $s0, 0x18
    /* 3E548 8004DD48 21280000 */  addu       $a1, $zero, $zero
    /* 3E54C 8004DD4C 2130A000 */  addu       $a2, $a1, $zero
    /* 3E550 8004DD50 00020724 */  addiu      $a3, $zero, 0x200
    /* 3E554 8004DD54 B8C8030C */  jal        SetDefDispEnv
    /* 3E558 8004DD58 1000B1AF */   sw        $s1, 0x10($sp)
    /* 3E55C 8004DD5C F5F6020C */  jal        Draw_InitViews__Fv
    /* 3E560 8004DD60 01001224 */   addiu     $s2, $zero, 0x1
    /* 3E564 8004DD64 21200000 */  addu       $a0, $zero, $zero
    /* 3E568 8004DD68 21288000 */  addu       $a1, $a0, $zero
    /* 3E56C 8004DD6C 21308000 */  addu       $a2, $a0, $zero
    /* 3E570 8004DD70 00010724 */  addiu      $a3, $zero, 0x100
    /* 3E574 8004DD74 1480033C */  lui        $v1, %hi(Draw_gRearView)
    /* 3E578 8004DD78 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 3E57C 8004DD7C E0D362AC */  sw         $v0, %lo(Draw_gRearView)($v1)
    /* 3E580 8004DD80 00020224 */  addiu      $v0, $zero, 0x200
    /* 3E584 8004DD84 1000A2AF */  sw         $v0, 0x10($sp)
    /* 3E588 8004DD88 0A000224 */  addiu      $v0, $zero, 0xA
    /* 3E58C 8004DD8C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 3E590 8004DD90 1800A0AF */  sw         $zero, 0x18($sp)
    /* 3E594 8004DD94 1C00B2AF */  sw         $s2, 0x1C($sp)
    /* 3E598 8004DD98 B0F6020C */  jal        Draw_SetView__Fiiiiiiiii
    /* 3E59C 8004DD9C 2000A2AF */   sw        $v0, 0x20($sp)
    /* 3E5A0 8004DDA0 1180113C */  lui        $s1, %hi(gCView)
    /* 3E5A4 8004DDA4 7C6F2426 */  addiu      $a0, $s1, %lo(gCView)
    /* 3E5A8 8004DDA8 8C000524 */  addiu      $a1, $zero, 0x8C
    /* 3E5AC 8004DDAC 1480103C */  lui        $s0, %hi(Draw_gPlayer1View)
    /* 3E5B0 8004DDB0 E8C5030C */  jal        blockclear
    /* 3E5B4 8004DDB4 CCD302AE */   sw        $v0, %lo(Draw_gPlayer1View)($s0)
    /* 3E5B8 8004DDB8 CCD3028E */  lw         $v0, %lo(Draw_gPlayer1View)($s0)
    /* 3E5BC 8004DDBC EF35010C */  jal        PSXFront_AllocateDrawMemory__Fv
    /* 3E5C0 8004DDC0 7C6F22AE */   sw        $v0, %lo(gCView)($s1)
    /* 3E5C4 8004DDC4 21200000 */  addu       $a0, $zero, $zero
    /* 3E5C8 8004DDC8 21288000 */  addu       $a1, $a0, $zero
    /* 3E5CC 8004DDCC 1480023C */  lui        $v0, %hi(Draw_gDoVSync)
    /* 3E5D0 8004DDD0 7A86000C */  jal        FETextRender_SetABR__Fib
    /* 3E5D4 8004DDD4 A8D752AC */   sw        $s2, %lo(Draw_gDoVSync)($v0)
    /* 3E5D8 8004DDD8 3400BF8F */  lw         $ra, 0x34($sp)
    /* 3E5DC 8004DDDC 3000B28F */  lw         $s2, 0x30($sp)
    /* 3E5E0 8004DDE0 2C00B18F */  lw         $s1, 0x2C($sp)
    /* 3E5E4 8004DDE4 2800B08F */  lw         $s0, 0x28($sp)
    /* 3E5E8 8004DDE8 1480023C */  lui        $v0, %hi(gFlip)
    /* 3E5EC 8004DDEC B4D740AC */  sw         $zero, %lo(gFlip)($v0)
    /* 3E5F0 8004DDF0 0800E003 */  jr         $ra
    /* 3E5F4 8004DDF4 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel Init_RenderingEnvironment__Fv
