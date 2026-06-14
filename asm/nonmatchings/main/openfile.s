.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching openfile, 0x2A4

glabel openfile
    /* E43E0 800F3BE0 98FFBD27 */  addiu      $sp, $sp, -0x68
    /* E43E4 800F3BE4 5000B0AF */  sw         $s0, 0x50($sp)
    /* E43E8 800F3BE8 21808000 */  addu       $s0, $a0, $zero
    /* E43EC 800F3BEC 5C00B3AF */  sw         $s3, 0x5C($sp)
    /* E43F0 800F3BF0 2198A000 */  addu       $s3, $a1, $zero
    /* E43F4 800F3BF4 5400B1AF */  sw         $s1, 0x54($sp)
    /* E43F8 800F3BF8 2188C000 */  addu       $s1, $a2, $zero
    /* E43FC 800F3BFC 1000A427 */  addiu      $a0, $sp, 0x10
    /* E4400 800F3C00 21280000 */  addu       $a1, $zero, $zero
    /* E4404 800F3C04 40000624 */  addiu      $a2, $zero, 0x40
    /* E4408 800F3C08 6000BFAF */  sw         $ra, 0x60($sp)
    /* E440C 800F3C0C C690030C */  jal        memset
    /* E4410 800F3C10 5800B2AF */   sw        $s2, 0x58($sp)
    /* E4414 800F3C14 21200002 */  addu       $a0, $s0, $zero
    /* E4418 800F3C18 1480123C */  lui        $s2, %hi(currentfilesystem)
    /* E441C 800F3C1C 5CDC528E */  lw         $s2, %lo(currentfilesystem)($s2)
    /* E4420 800F3C20 85D8030C */  jal        strchr
    /* E4424 800F3C24 3A000524 */   addiu     $a1, $zero, 0x3A
    /* E4428 800F3C28 33004010 */  beqz       $v0, .L800F3CF8
    /* E442C 800F3C2C 21200002 */   addu      $a0, $s0, $zero
    /* E4430 800F3C30 E817858F */  lw         $a1, %gp_rel(D_8013DD34)($gp)
    /* E4434 800F3C34 74AC030C */  jal        strncmp
    /* E4438 800F3C38 06000624 */   addiu     $a2, $zero, 0x6
    /* E443C 800F3C3C 09004014 */  bnez       $v0, .L800F3C64
    /* E4440 800F3C40 21200002 */   addu      $a0, $s0, $zero
    /* E4444 800F3C44 1480023C */  lui        $v0, %hi(availablefilesystems)
    /* E4448 800F3C48 60DC428C */  lw         $v0, %lo(availablefilesystems)($v0)
    /* E444C 800F3C4C 00000000 */  nop
    /* E4450 800F3C50 01004230 */  andi       $v0, $v0, 0x1
    /* E4454 800F3C54 83004010 */  beqz       $v0, .L800F3E64
    /* E4458 800F3C58 01001224 */   addiu     $s2, $zero, 0x1
    /* E445C 800F3C5C 3ECF0308 */  j          .L800F3CF8
    /* E4460 800F3C60 06001026 */   addiu     $s0, $s0, 0x6
  .L800F3C64:
    /* E4464 800F3C64 F417858F */  lw         $a1, %gp_rel(D_8013DD40)($gp)
    /* E4468 800F3C68 74AC030C */  jal        strncmp
    /* E446C 800F3C6C 04000624 */   addiu     $a2, $zero, 0x4
    /* E4470 800F3C70 09004014 */  bnez       $v0, .L800F3C98
    /* E4474 800F3C74 01000224 */   addiu     $v0, $zero, 0x1
    /* E4478 800F3C78 1480023C */  lui        $v0, %hi(availablefilesystems)
    /* E447C 800F3C7C 60DC428C */  lw         $v0, %lo(availablefilesystems)($v0)
    /* E4480 800F3C80 00000000 */  nop
    /* E4484 800F3C84 02004230 */  andi       $v0, $v0, 0x2
    /* E4488 800F3C88 76004010 */  beqz       $v0, .L800F3E64
    /* E448C 800F3C8C 02001224 */   addiu     $s2, $zero, 0x2
    /* E4490 800F3C90 3ECF0308 */  j          .L800F3CF8
    /* E4494 800F3C94 04001026 */   addiu     $s0, $s0, 0x4
  .L800F3C98:
    /* E4498 800F3C98 1480033C */  lui        $v1, %hi(currentfilesystem)
    /* E449C 800F3C9C 5CDC638C */  lw         $v1, %lo(currentfilesystem)($v1)
    /* E44A0 800F3CA0 00000000 */  nop
    /* E44A4 800F3CA4 05006210 */  beq        $v1, $v0, .L800F3CBC
    /* E44A8 800F3CA8 3A000224 */   addiu     $v0, $zero, 0x3A
    /* E44AC 800F3CAC 01000392 */  lbu        $v1, 0x1($s0)
    /* E44B0 800F3CB0 00000000 */  nop
    /* E44B4 800F3CB4 11006210 */  beq        $v1, $v0, .L800F3CFC
    /* E44B8 800F3CB8 01000224 */   addiu     $v0, $zero, 0x1
  .L800F3CBC:
    /* E44BC 800F3CBC 21200002 */  addu       $a0, $s0, $zero
    /* E44C0 800F3CC0 85D8030C */  jal        strchr
    /* E44C4 800F3CC4 3A000524 */   addiu     $a1, $zero, 0x3A
    /* E44C8 800F3CC8 1000A427 */  addiu      $a0, $sp, 0x10
    /* E44CC 800F3CCC 21280002 */  addu       $a1, $s0, $zero
    /* E44D0 800F3CD0 23105000 */  subu       $v0, $v0, $s0
    /* E44D4 800F3CD4 41D8030C */  jal        strncpy
    /* E44D8 800F3CD8 01004624 */   addiu     $a2, $v0, 0x1
    /* E44DC 800F3CDC 21200002 */  addu       $a0, $s0, $zero
    /* E44E0 800F3CE0 85D8030C */  jal        strchr
    /* E44E4 800F3CE4 3A000524 */   addiu     $a1, $zero, 0x3A
    /* E44E8 800F3CE8 23105000 */  subu       $v0, $v0, $s0
    /* E44EC 800F3CEC 21105D00 */  addu       $v0, $v0, $sp
    /* E44F0 800F3CF0 120040A0 */  sb         $zero, 0x12($v0)
    /* E44F4 800F3CF4 21900000 */  addu       $s2, $zero, $zero
  .L800F3CF8:
    /* E44F8 800F3CF8 01000224 */  addiu      $v0, $zero, 0x1
  .L800F3CFC:
    /* E44FC 800F3CFC 0C004216 */  bne        $s2, $v0, .L800F3D30
    /* E4500 800F3D00 02000224 */   addiu     $v0, $zero, 0x2
    /* E4504 800F3D04 21200002 */  addu       $a0, $s0, $zero
    /* E4508 800F3D08 21286002 */  addu       $a1, $s3, $zero
    /* E450C 800F3D0C 55E9030C */  jal        CD_Open
    /* E4510 800F3D10 21302002 */   addu      $a2, $s1, $zero
    /* E4514 800F3D14 53004010 */  beqz       $v0, .L800F3E64
    /* E4518 800F3D18 01000224 */   addiu     $v0, $zero, 0x1
    /* E451C 800F3D1C 0000238E */  lw         $v1, 0x0($s1)
    /* E4520 800F3D20 0001043C */  lui        $a0, (0x1000000 >> 16)
    /* E4524 800F3D24 25186400 */  or         $v1, $v1, $a0
    /* E4528 800F3D28 9ACF0308 */  j          .L800F3E68
    /* E452C 800F3D2C 000023AE */   sw        $v1, 0x0($s1)
  .L800F3D30:
    /* E4530 800F3D30 4D004216 */  bne        $s2, $v0, .L800F3E68
    /* E4534 800F3D34 21100000 */   addu      $v0, $zero, $zero
    /* E4538 800F3D38 00000392 */  lbu        $v1, 0x0($s0)
    /* E453C 800F3D3C 5C000224 */  addiu      $v0, $zero, 0x5C
    /* E4540 800F3D40 06006210 */  beq        $v1, $v0, .L800F3D5C
    /* E4544 800F3D44 2F000224 */   addiu     $v0, $zero, 0x2F
    /* E4548 800F3D48 04006210 */  beq        $v1, $v0, .L800F3D5C
    /* E454C 800F3D4C 1000A427 */   addiu     $a0, $sp, 0x10
    /* E4550 800F3D50 1480053C */  lui        $a1, %hi(currentdirectory)
    /* E4554 800F3D54 CA96030C */  jal        strcpy
    /* E4558 800F3D58 1404A524 */   addiu     $a1, $a1, %lo(currentdirectory)
  .L800F3D5C:
    /* E455C 800F3D5C 1000A427 */  addiu      $a0, $sp, 0x10
    /* E4560 800F3D60 3A9E030C */  jal        strcat
    /* E4564 800F3D64 21280002 */   addu      $a1, $s0, $zero
    /* E4568 800F3D68 07006332 */  andi       $v1, $s3, 0x7
    /* E456C 800F3D6C 0700622C */  sltiu      $v0, $v1, 0x7
    /* E4570 800F3D70 31004010 */  beqz       $v0, .L800F3E38
    /* E4574 800F3D74 0580023C */   lui       $v0, %hi(jtbl_80056FBC)
    /* E4578 800F3D78 BC6F4224 */  addiu      $v0, $v0, %lo(jtbl_80056FBC)
    /* E457C 800F3D7C 80180300 */  sll        $v1, $v1, 2
    /* E4580 800F3D80 21186200 */  addu       $v1, $v1, $v0
    /* E4584 800F3D84 0000628C */  lw         $v0, 0x0($v1)
    /* E4588 800F3D88 00000000 */  nop
    /* E458C 800F3D8C 08004000 */  jr         $v0
    /* E4590 800F3D90 00000000 */   nop
  jlabel .L800F3D94
    /* E4594 800F3D94 1000A427 */  addiu      $a0, $sp, 0x10
    /* E4598 800F3D98 02000524 */  addiu      $a1, $zero, 0x2
    /* E459C 800F3D9C 291B040C */  jal        PCopen
    /* E45A0 800F3DA0 21300000 */   addu      $a2, $zero, $zero
    /* E45A4 800F3DA4 90CF0308 */  j          .L800F3E40
    /* E45A8 800F3DA8 000022AE */   sw        $v0, 0x0($s1)
  jlabel .L800F3DAC
    /* E45AC 800F3DAC 1000A427 */  addiu      $a0, $sp, 0x10
    /* E45B0 800F3DB0 21280000 */  addu       $a1, $zero, $zero
    /* E45B4 800F3DB4 291B040C */  jal        PCopen
    /* E45B8 800F3DB8 2130A000 */   addu      $a2, $a1, $zero
    /* E45BC 800F3DBC 90CF0308 */  j          .L800F3E40
    /* E45C0 800F3DC0 000022AE */   sw        $v0, 0x0($s1)
  jlabel .L800F3DC4
    /* E45C4 800F3DC4 1000A427 */  addiu      $a0, $sp, 0x10
    /* E45C8 800F3DC8 21280000 */  addu       $a1, $zero, $zero
    /* E45CC 800F3DCC 291B040C */  jal        PCopen
    /* E45D0 800F3DD0 2130A000 */   addu      $a2, $a1, $zero
    /* E45D4 800F3DD4 1A004104 */  bgez       $v0, .L800F3E40
    /* E45D8 800F3DD8 000022AE */   sw        $v0, 0x0($s1)
    /* E45DC 800F3DDC 1000A427 */  addiu      $a0, $sp, 0x10
    /* E45E0 800F3DE0 341B040C */  jal        PCcreat
    /* E45E4 800F3DE4 21280000 */   addu      $a1, $zero, $zero
    /* E45E8 800F3DE8 90CF0308 */  j          .L800F3E40
    /* E45EC 800F3DEC 000022AE */   sw        $v0, 0x0($s1)
  jlabel .L800F3DF0
    /* E45F0 800F3DF0 1000A427 */  addiu      $a0, $sp, 0x10
    /* E45F4 800F3DF4 21280000 */  addu       $a1, $zero, $zero
    /* E45F8 800F3DF8 291B040C */  jal        PCopen
    /* E45FC 800F3DFC 2130A000 */   addu      $a2, $a1, $zero
    /* E4600 800F3E00 17004004 */  bltz       $v0, .L800F3E60
    /* E4604 800F3E04 000022AE */   sw        $v0, 0x0($s1)
    /* E4608 800F3E08 501B040C */  jal        PCclose
    /* E460C 800F3E0C 21204000 */   addu      $a0, $v0, $zero
    /* E4610 800F3E10 1000A427 */  addiu      $a0, $sp, 0x10
    /* E4614 800F3E14 341B040C */  jal        PCcreat
    /* E4618 800F3E18 21280000 */   addu      $a1, $zero, $zero
    /* E461C 800F3E1C 90CF0308 */  j          .L800F3E40
    /* E4620 800F3E20 000022AE */   sw        $v0, 0x0($s1)
  jlabel .L800F3E24
    /* E4624 800F3E24 1000A427 */  addiu      $a0, $sp, 0x10
    /* E4628 800F3E28 341B040C */  jal        PCcreat
    /* E462C 800F3E2C 21280000 */   addu      $a1, $zero, $zero
    /* E4630 800F3E30 90CF0308 */  j          .L800F3E40
    /* E4634 800F3E34 000022AE */   sw        $v0, 0x0($s1)
  jlabel .L800F3E38
    /* E4638 800F3E38 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* E463C 800F3E3C 000022AE */  sw         $v0, 0x0($s1)
  .L800F3E40:
    /* E4640 800F3E40 0000238E */  lw         $v1, 0x0($s1)
    /* E4644 800F3E44 00000000 */  nop
    /* E4648 800F3E48 05006018 */  blez       $v1, .L800F3E60
    /* E464C 800F3E4C 00161200 */   sll       $v0, $s2, 24
    /* E4650 800F3E50 25106200 */  or         $v0, $v1, $v0
    /* E4654 800F3E54 000022AE */  sw         $v0, 0x0($s1)
    /* E4658 800F3E58 9ACF0308 */  j          .L800F3E68
    /* E465C 800F3E5C 01000224 */   addiu     $v0, $zero, 0x1
  .L800F3E60:
    /* E4660 800F3E60 000020AE */  sw         $zero, 0x0($s1)
  .L800F3E64:
    /* E4664 800F3E64 21100000 */  addu       $v0, $zero, $zero
  .L800F3E68:
    /* E4668 800F3E68 6000BF8F */  lw         $ra, 0x60($sp)
    /* E466C 800F3E6C 5C00B38F */  lw         $s3, 0x5C($sp)
    /* E4670 800F3E70 5800B28F */  lw         $s2, 0x58($sp)
    /* E4674 800F3E74 5400B18F */  lw         $s1, 0x54($sp)
    /* E4678 800F3E78 5000B08F */  lw         $s0, 0x50($sp)
    /* E467C 800F3E7C 0800E003 */  jr         $ra
    /* E4680 800F3E80 6800BD27 */   addiu     $sp, $sp, 0x68
endlabel openfile
