.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_CalculateRoadPosition__FP8coorddefi, 0x120

glabel AIPhysic_CalculateRoadPosition__FP8coorddefi
    /* 5B31C 8006AB1C D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 5B320 8006AB20 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* 5B324 8006AB24 C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* 5B328 8006AB28 40290500 */  sll        $a1, $a1, 5
    /* 5B32C 8006AB2C 2110A200 */  addu       $v0, $a1, $v0
    /* 5B330 8006AB30 00004A8C */  lw         $t2, 0x0($v0)
    /* 5B334 8006AB34 04004B8C */  lw         $t3, 0x4($v0)
    /* 5B338 8006AB38 08004C8C */  lw         $t4, 0x8($v0)
    /* 5B33C 8006AB3C 0000AAAF */  sw         $t2, 0x0($sp)
    /* 5B340 8006AB40 0400ABAF */  sw         $t3, 0x4($sp)
    /* 5B344 8006AB44 0800ACAF */  sw         $t4, 0x8($sp)
    /* 5B348 8006AB48 0000838C */  lw         $v1, 0x0($a0)
    /* 5B34C 8006AB4C 0000A28F */  lw         $v0, 0x0($sp)
    /* 5B350 8006AB50 00000000 */  nop
    /* 5B354 8006AB54 23386200 */  subu       $a3, $v1, $v0
    /* 5B358 8006AB58 1000A7AF */  sw         $a3, 0x10($sp)
    /* 5B35C 8006AB5C 0400838C */  lw         $v1, 0x4($a0)
    /* 5B360 8006AB60 0400A28F */  lw         $v0, 0x4($sp)
    /* 5B364 8006AB64 00000000 */  nop
    /* 5B368 8006AB68 23406200 */  subu       $t0, $v1, $v0
    /* 5B36C 8006AB6C 1400A8AF */  sw         $t0, 0x14($sp)
    /* 5B370 8006AB70 0800838C */  lw         $v1, 0x8($a0)
    /* 5B374 8006AB74 0800A28F */  lw         $v0, 0x8($sp)
    /* 5B378 8006AB78 1480043C */  lui        $a0, %hi(BWorldSm_slices)
    /* 5B37C 8006AB7C C0C7848C */  lw         $a0, %lo(BWorldSm_slices)($a0)
    /* 5B380 8006AB80 23486200 */  subu       $t1, $v1, $v0
    /* 5B384 8006AB84 2128A400 */  addu       $a1, $a1, $a0
    /* 5B388 8006AB88 1800A9AF */  sw         $t1, 0x18($sp)
    /* 5B38C 8006AB8C 1200A380 */  lb         $v1, 0x12($a1)
    /* 5B390 8006AB90 00000000 */  nop
    /* 5B394 8006AB94 401A0300 */  sll        $v1, $v1, 9
    /* 5B398 8006AB98 2000A3AF */  sw         $v1, 0x20($sp)
    /* 5B39C 8006AB9C 1300A280 */  lb         $v0, 0x13($a1)
    /* 5B3A0 8006ABA0 00000000 */  nop
    /* 5B3A4 8006ABA4 40220200 */  sll        $a0, $v0, 9
    /* 5B3A8 8006ABA8 2400A4AF */  sw         $a0, 0x24($sp)
    /* 5B3AC 8006ABAC 1400A280 */  lb         $v0, 0x14($a1)
    /* 5B3B0 8006ABB0 00000000 */  nop
    /* 5B3B4 8006ABB4 40320200 */  sll        $a2, $v0, 9
    /* 5B3B8 8006ABB8 02006104 */  bgez       $v1, .L8006ABC4
    /* 5B3BC 8006ABBC 2800A6AF */   sw        $a2, 0x28($sp)
    /* 5B3C0 8006ABC0 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8006ABC4:
    /* 5B3C4 8006ABC4 2110E000 */  addu       $v0, $a3, $zero
    /* 5B3C8 8006ABC8 02004104 */  bgez       $v0, .L8006ABD4
    /* 5B3CC 8006ABCC 031A0300 */   sra       $v1, $v1, 8
    /* 5B3D0 8006ABD0 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006ABD4:
    /* 5B3D4 8006ABD4 03120200 */  sra        $v0, $v0, 8
    /* 5B3D8 8006ABD8 18006200 */  mult       $v1, $v0
    /* 5B3DC 8006ABDC 12280000 */  mflo       $a1
    /* 5B3E0 8006ABE0 02008104 */  bgez       $a0, .L8006ABEC
    /* 5B3E4 8006ABE4 21100001 */   addu      $v0, $t0, $zero
    /* 5B3E8 8006ABE8 FF008424 */  addiu      $a0, $a0, 0xFF
  .L8006ABEC:
    /* 5B3EC 8006ABEC 02004104 */  bgez       $v0, .L8006ABF8
    /* 5B3F0 8006ABF0 031A0400 */   sra       $v1, $a0, 8
    /* 5B3F4 8006ABF4 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006ABF8:
    /* 5B3F8 8006ABF8 03120200 */  sra        $v0, $v0, 8
    /* 5B3FC 8006ABFC 18006200 */  mult       $v1, $v0
    /* 5B400 8006AC00 2120C000 */  addu       $a0, $a2, $zero
    /* 5B404 8006AC04 12500000 */  mflo       $t2
    /* 5B408 8006AC08 02008104 */  bgez       $a0, .L8006AC14
    /* 5B40C 8006AC0C 2118AA00 */   addu      $v1, $a1, $t2
    /* 5B410 8006AC10 FF008424 */  addiu      $a0, $a0, 0xFF
  .L8006AC14:
    /* 5B414 8006AC14 21102001 */  addu       $v0, $t1, $zero
    /* 5B418 8006AC18 02004104 */  bgez       $v0, .L8006AC24
    /* 5B41C 8006AC1C 03220400 */   sra       $a0, $a0, 8
    /* 5B420 8006AC20 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006AC24:
    /* 5B424 8006AC24 03120200 */  sra        $v0, $v0, 8
    /* 5B428 8006AC28 18008200 */  mult       $a0, $v0
    /* 5B42C 8006AC2C 12500000 */  mflo       $t2
    /* 5B430 8006AC30 21106A00 */  addu       $v0, $v1, $t2
    /* 5B434 8006AC34 0800E003 */  jr         $ra
    /* 5B438 8006AC38 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel AIPhysic_CalculateRoadPosition__FP8coorddefi
