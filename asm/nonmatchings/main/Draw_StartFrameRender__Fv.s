.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw_StartFrameRender__Fv, 0xA0

glabel Draw_StartFrameRender__Fv
    /* AEAC0 800BE2C0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* AEAC4 800BE2C4 1400B1AF */  sw         $s1, 0x14($sp)
    /* AEAC8 800BE2C8 21880000 */  addu       $s1, $zero, $zero
    /* AEACC 800BE2CC 1280023C */  lui        $v0, %hi(Draw_gView)
    /* AEAD0 800BE2D0 1000B0AF */  sw         $s0, 0x10($sp)
    /* AEAD4 800BE2D4 54EC5024 */  addiu      $s0, $v0, %lo(Draw_gView)
    /* AEAD8 800BE2D8 1800BFAF */  sw         $ra, 0x18($sp)
  .L800BE2DC:
    /* AEADC 800BE2DC 6012828F */  lw         $v0, %gp_rel(Draw_gNumView)($gp)
    /* AEAE0 800BE2E0 00000000 */  nop
    /* AEAE4 800BE2E4 2A102202 */  slt        $v0, $s1, $v0
    /* AEAE8 800BE2E8 0A004010 */  beqz       $v0, .L800BE314
    /* AEAEC 800BE2EC 01003126 */   addiu     $s1, $s1, 0x1
    /* AEAF0 800BE2F0 6812828F */  lw         $v0, %gp_rel(gFlip)($gp)
    /* AEAF4 800BE2F4 0000058E */  lw         $a1, 0x0($s0)
    /* AEAF8 800BE2F8 80100200 */  sll        $v0, $v0, 2
    /* AEAFC 800BE2FC 21100202 */  addu       $v0, $s0, $v0
    /* AEB00 800BE300 C000448C */  lw         $a0, 0xC0($v0)
    /* AEB04 800BE304 02B7030C */  jal        ClearOTagR
    /* AEB08 800BE308 C8001026 */   addiu     $s0, $s0, 0xC8
    /* AEB0C 800BE30C B7F80208 */  j          .L800BE2DC
    /* AEB10 800BE310 00000000 */   nop
  .L800BE314:
    /* AEB14 800BE314 1280033C */  lui        $v1, %hi(gEnviro)
    /* AEB18 800BE318 24F46324 */  addiu      $v1, $v1, %lo(gEnviro)
    /* AEB1C 800BE31C 6812848F */  lw         $a0, %gp_rel(gFlip)($gp)
    /* AEB20 800BE320 1800BF8F */  lw         $ra, 0x18($sp)
    /* AEB24 800BE324 1400B18F */  lw         $s1, 0x14($sp)
    /* AEB28 800BE328 40100400 */  sll        $v0, $a0, 1
    /* AEB2C 800BE32C 21104400 */  addu       $v0, $v0, $a0
    /* AEB30 800BE330 C0100200 */  sll        $v0, $v0, 3
    /* AEB34 800BE334 21104300 */  addu       $v0, $v0, $v1
    /* AEB38 800BE338 1400438C */  lw         $v1, 0x14($v0)
    /* AEB3C 800BE33C 801F013C */  lui        $at, (0x1F800004 >> 16)
    /* AEB40 800BE340 040023AC */  sw         $v1, (0x1F800004 & 0xFFFF)($at)
    /* AEB44 800BE344 1400428C */  lw         $v0, 0x14($v0)
    /* AEB48 800BE348 7812838F */  lw         $v1, %gp_rel(gTotalMem)($gp)
    /* AEB4C 800BE34C 1000B08F */  lw         $s0, 0x10($sp)
    /* AEB50 800BE350 21104300 */  addu       $v0, $v0, $v1
    /* AEB54 800BE354 741282AF */  sw         $v0, %gp_rel(Draw_gMaxPrim)($gp)
    /* AEB58 800BE358 0800E003 */  jr         $ra
    /* AEB5C 800BE35C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Draw_StartFrameRender__Fv
