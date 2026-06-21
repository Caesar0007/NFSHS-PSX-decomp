.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PerformMenuInitialization__14tFEApplication, 0x68

glabel PerformMenuInitialization__14tFEApplication
    /* 3A34 80013234 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 3A38 80013238 1180023C */  lui        $v0, %hi(D_80114941)
    /* 3A3C 8001323C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 3A40 80013240 000080AC */  sw         $zero, 0x0($a0)
    /* 3A44 80013244 41494290 */  lbu        $v0, %lo(D_80114941)($v0)
    /* 3A48 80013248 00000000 */  nop
    /* 3A4C 8001324C C0200200 */  sll        $a0, $v0, 3
    /* 3A50 80013250 21208200 */  addu       $a0, $a0, $v0
    /* 3A54 80013254 80200400 */  sll        $a0, $a0, 2
    /* 3A58 80013258 23208200 */  subu       $a0, $a0, $v0
    /* 3A5C 8001325C ACEC010C */  jal        AudioMus_Volume__Fi
    /* 3A60 80013260 83210400 */   sra       $a0, $a0, 6
    /* 3A64 80013264 C061000C */  jal        InitializeClass__11tDialogBase
    /* 3A68 80013268 00000000 */   nop
    /* 3A6C 8001326C 792E020C */  jal        Clock_SystemStartUp__Fv
    /* 3A70 80013270 00000000 */   nop
    /* 3A74 80013274 21200000 */  addu       $a0, $zero, $zero
    /* 3A78 80013278 1480033C */  lui        $v1, %hi(Draw_gDoVSync)
    /* 3A7C 8001327C 01000224 */  addiu      $v0, $zero, 0x1
    /* 3A80 80013280 21288000 */  addu       $a1, $a0, $zero
    /* 3A84 80013284 7A86000C */  jal        FETextRender_SetABR__Fib
    /* 3A88 80013288 A8D762AC */   sw        $v0, %lo(Draw_gDoVSync)($v1)
    /* 3A8C 8001328C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 3A90 80013290 00000000 */  nop
    /* 3A94 80013294 0800E003 */  jr         $ra
    /* 3A98 80013298 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel PerformMenuInitialization__14tFEApplication
