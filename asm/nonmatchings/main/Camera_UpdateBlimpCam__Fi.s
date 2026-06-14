.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Camera_UpdateBlimpCam__Fi, 0x144

glabel Camera_UpdateBlimpCam__Fi
    /* 72B7C 8008237C C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 72B80 80082380 1180023C */  lui        $v0, %hi(Camera_gInfo)
    /* 72B84 80082384 ACF24224 */  addiu      $v0, $v0, %lo(Camera_gInfo)
    /* 72B88 80082388 3000B0AF */  sw         $s0, 0x30($sp)
    /* 72B8C 8008238C 00810400 */  sll        $s0, $a0, 4
    /* 72B90 80082390 21800402 */  addu       $s0, $s0, $a0
    /* 72B94 80082394 00811000 */  sll        $s0, $s0, 4
    /* 72B98 80082398 21800202 */  addu       $s0, $s0, $v0
    /* 72B9C 8008239C 1180033C */  lui        $v1, %hi(Camera_gFlags)
    /* 72BA0 800823A0 3400BFAF */  sw         $ra, 0x34($sp)
    /* 72BA4 800823A4 70000286 */  lh         $v0, 0x70($s0)
    /* 72BA8 800823A8 50F56324 */  addiu      $v1, $v1, %lo(Camera_gFlags)
    /* 72BAC 800823AC 00110200 */  sll        $v0, $v0, 4
    /* 72BB0 800823B0 21104300 */  addu       $v0, $v0, $v1
    /* 72BB4 800823B4 0000478C */  lw         $a3, 0x0($v0)
    /* 72BB8 800823B8 0400488C */  lw         $t0, 0x4($v0)
    /* 72BBC 800823BC 0800498C */  lw         $t1, 0x8($v0)
    /* 72BC0 800823C0 1000A7AF */  sw         $a3, 0x10($sp)
    /* 72BC4 800823C4 1400A8AF */  sw         $t0, 0x14($sp)
    /* 72BC8 800823C8 1800A9AF */  sw         $t1, 0x18($sp)
    /* 72BCC 800823CC F101020C */  jal        Camera_TunnelLimit__FiPi
    /* 72BD0 800823D0 1400A527 */   addiu     $a1, $sp, 0x14
    /* 72BD4 800823D4 0000028E */  lw         $v0, 0x0($s0)
    /* 72BD8 800823D8 0800068E */  lw         $a2, 0x8($s0)
    /* 72BDC 800823DC A000428C */  lw         $v0, 0xA0($v0)
    /* 72BE0 800823E0 99190524 */  addiu      $a1, $zero, 0x1999
    /* 72BE4 800823E4 2330C200 */  subu       $a2, $a2, $v0
    /* 72BE8 800823E8 2000A6AF */  sw         $a2, 0x20($sp)
    /* 72BEC 800823EC 0000038E */  lw         $v1, 0x0($s0)
    /* 72BF0 800823F0 0C00028E */  lw         $v0, 0xC($s0)
    /* 72BF4 800823F4 A400638C */  lw         $v1, 0xA4($v1)
    /* 72BF8 800823F8 1000A48F */  lw         $a0, 0x10($sp)
    /* 72BFC 800823FC 23104300 */  subu       $v0, $v0, $v1
    /* 72C00 80082400 2400A2AF */  sw         $v0, 0x24($sp)
    /* 72C04 80082404 0000038E */  lw         $v1, 0x0($s0)
    /* 72C08 80082408 1000028E */  lw         $v0, 0x10($s0)
    /* 72C0C 8008240C A800638C */  lw         $v1, 0xA8($v1)
    /* 72C10 80082410 23208600 */  subu       $a0, $a0, $a2
    /* 72C14 80082414 23104300 */  subu       $v0, $v0, $v1
    /* 72C18 80082418 CA90030C */  jal        fixedmult
    /* 72C1C 8008241C 2800A2AF */   sw        $v0, 0x28($sp)
    /* 72C20 80082420 99190524 */  addiu      $a1, $zero, 0x1999
    /* 72C24 80082424 1400A68F */  lw         $a2, 0x14($sp)
    /* 72C28 80082428 2400A48F */  lw         $a0, 0x24($sp)
    /* 72C2C 8008242C 2000A38F */  lw         $v1, 0x20($sp)
    /* 72C30 80082430 2320C400 */  subu       $a0, $a2, $a0
    /* 72C34 80082434 21186200 */  addu       $v1, $v1, $v0
    /* 72C38 80082438 CA90030C */  jal        fixedmult
    /* 72C3C 8008243C 2000A3AF */   sw        $v1, 0x20($sp)
    /* 72C40 80082440 99190524 */  addiu      $a1, $zero, 0x1999
    /* 72C44 80082444 1800A68F */  lw         $a2, 0x18($sp)
    /* 72C48 80082448 2800A48F */  lw         $a0, 0x28($sp)
    /* 72C4C 8008244C 2400A38F */  lw         $v1, 0x24($sp)
    /* 72C50 80082450 2320C400 */  subu       $a0, $a2, $a0
    /* 72C54 80082454 21186200 */  addu       $v1, $v1, $v0
    /* 72C58 80082458 CA90030C */  jal        fixedmult
    /* 72C5C 8008245C 2400A3AF */   sw        $v1, 0x24($sp)
    /* 72C60 80082460 2800A38F */  lw         $v1, 0x28($sp)
    /* 72C64 80082464 00000000 */  nop
    /* 72C68 80082468 21186200 */  addu       $v1, $v1, $v0
    /* 72C6C 8008246C 2800A3AF */  sw         $v1, 0x28($sp)
    /* 72C70 80082470 0000028E */  lw         $v0, 0x0($s0)
    /* 72C74 80082474 2000A38F */  lw         $v1, 0x20($sp)
    /* 72C78 80082478 A000428C */  lw         $v0, 0xA0($v0)
    /* 72C7C 8008247C 0000048E */  lw         $a0, 0x0($s0)
    /* 72C80 80082480 21104300 */  addu       $v0, $v0, $v1
    /* 72C84 80082484 080002AE */  sw         $v0, 0x8($s0)
    /* 72C88 80082488 A400828C */  lw         $v0, 0xA4($a0)
    /* 72C8C 8008248C 2400A38F */  lw         $v1, 0x24($sp)
    /* 72C90 80082490 00000000 */  nop
    /* 72C94 80082494 21104300 */  addu       $v0, $v0, $v1
    /* 72C98 80082498 0C0002AE */  sw         $v0, 0xC($s0)
    /* 72C9C 8008249C A800828C */  lw         $v0, 0xA8($a0)
    /* 72CA0 800824A0 2800A38F */  lw         $v1, 0x28($sp)
    /* 72CA4 800824A4 00000000 */  nop
    /* 72CA8 800824A8 21104300 */  addu       $v0, $v0, $v1
    /* 72CAC 800824AC 100002AE */  sw         $v0, 0x10($s0)
    /* 72CB0 800824B0 3400BF8F */  lw         $ra, 0x34($sp)
    /* 72CB4 800824B4 3000B08F */  lw         $s0, 0x30($sp)
    /* 72CB8 800824B8 0800E003 */  jr         $ra
    /* 72CBC 800824BC 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel Camera_UpdateBlimpCam__Fi
