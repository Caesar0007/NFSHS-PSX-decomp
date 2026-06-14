.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIInit_ClearAICar__FP8Car_tObj, 0x78

glabel AIInit_ClearAICar__FP8Car_tObj
    /* 57974 80067174 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 57978 80067178 2000B0AF */  sw         $s0, 0x20($sp)
    /* 5797C 8006717C 21808000 */  addu       $s0, $a0, $zero
    /* 57980 80067180 1000A427 */  addiu      $a0, $sp, 0x10
    /* 57984 80067184 21280000 */  addu       $a1, $zero, $zero
    /* 57988 80067188 2400BFAF */  sw         $ra, 0x24($sp)
    /* 5798C 8006718C C690030C */  jal        memset
    /* 57990 80067190 0C000624 */   addiu     $a2, $zero, 0xC
    /* 57994 80067194 01000224 */  addiu      $v0, $zero, 0x1
    /* 57998 80067198 1000A38F */  lw         $v1, 0x10($sp)
    /* 5799C 8006719C 1400A78F */  lw         $a3, 0x14($sp)
    /* 579A0 800671A0 1800A88F */  lw         $t0, 0x18($sp)
    /* 579A4 800671A4 140103AE */  sw         $v1, 0x114($s0)
    /* 579A8 800671A8 180107AE */  sw         $a3, 0x118($s0)
    /* 579AC 800671AC 1C0108AE */  sw         $t0, 0x11C($s0)
    /* 579B0 800671B0 7C0100A6 */  sh         $zero, 0x17C($s0)
    /* 579B4 800671B4 840400AE */  sw         $zero, 0x484($s0)
    /* 579B8 800671B8 880400AE */  sw         $zero, 0x488($s0)
    /* 579BC 800671BC 880500AE */  sw         $zero, 0x588($s0)
    /* 579C0 800671C0 800500AE */  sw         $zero, 0x580($s0)
    /* 579C4 800671C4 F00602AE */  sw         $v0, 0x6F0($s0)
    /* 579C8 800671C8 F40600AE */  sw         $zero, 0x6F4($s0)
    /* 579CC 800671CC EC0600AE */  sw         $zero, 0x6EC($s0)
    /* 579D0 800671D0 480700AE */  sw         $zero, 0x748($s0)
    /* 579D4 800671D4 440700AE */  sw         $zero, 0x744($s0)
    /* 579D8 800671D8 540700AE */  sw         $zero, 0x754($s0)
    /* 579DC 800671DC 2400BF8F */  lw         $ra, 0x24($sp)
    /* 579E0 800671E0 2000B08F */  lw         $s0, 0x20($sp)
    /* 579E4 800671E4 0800E003 */  jr         $ra
    /* 579E8 800671E8 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel AIInit_ClearAICar__FP8Car_tObj
