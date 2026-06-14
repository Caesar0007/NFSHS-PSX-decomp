.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching NFS4_LoadingIcon__Fv, 0x124

glabel NFS4_LoadingIcon__Fv
    /* 94DB8 800A45B8 70FFBD27 */  addiu      $sp, $sp, -0x90
    /* 94DBC 800A45BC 2800A427 */  addiu      $a0, $sp, 0x28
    /* 94DC0 800A45C0 1180023C */  lui        $v0, %hi(D_801164FC)
    /* 94DC4 800A45C4 0580053C */  lui        $a1, %hi(D_8005603C)
    /* 94DC8 800A45C8 FC64468C */  lw         $a2, %lo(D_801164FC)($v0)
    /* 94DCC 800A45CC 3C60A524 */  addiu      $a1, $a1, %lo(D_8005603C)
    /* 94DD0 800A45D0 8800BFAF */  sw         $ra, 0x88($sp)
    /* 94DD4 800A45D4 8400B1AF */  sw         $s1, 0x84($sp)
    /* 94DD8 800A45D8 2F91030C */  jal        sprintf
    /* 94DDC 800A45DC 8000B0AF */   sw        $s0, 0x80($sp)
    /* 94DE0 800A45E0 2800A427 */  addiu      $a0, $sp, 0x28
    /* 94DE4 800A45E4 FA95030C */  jal        loadfileadr
    /* 94DE8 800A45E8 21280000 */   addu      $a1, $zero, $zero
    /* 94DEC 800A45EC 1180033C */  lui        $v1, %hi(D_80114940)
    /* 94DF0 800A45F0 40496590 */  lbu        $a1, %lo(D_80114940)($v1)
    /* 94DF4 800A45F4 21884000 */  addu       $s1, $v0, $zero
    /* 94DF8 800A45F8 0600A228 */  slti       $v0, $a1, 0x6
    /* 94DFC 800A45FC 02004014 */  bnez       $v0, .L800A4608
    /* 94E00 800A4600 00000000 */   nop
    /* 94E04 800A4604 21280000 */  addu       $a1, $zero, $zero
  .L800A4608:
    /* 94E08 800A4608 AEC2030C */  jal        shapepointer
    /* 94E0C 800A460C 21202002 */   addu      $a0, $s1, $zero
    /* 94E10 800A4610 7800A427 */  addiu      $a0, $sp, 0x78
    /* 94E14 800A4614 21280000 */  addu       $a1, $zero, $zero
    /* 94E18 800A4618 2130A000 */  addu       $a2, $a1, $zero
    /* 94E1C 800A461C 2138A000 */  addu       $a3, $a1, $zero
    /* 94E20 800A4620 00040324 */  addiu      $v1, $zero, 0x400
    /* 94E24 800A4624 7C00A3A7 */  sh         $v1, 0x7C($sp)
    /* 94E28 800A4628 00020324 */  addiu      $v1, $zero, 0x200
    /* 94E2C 800A462C 21804000 */  addu       $s0, $v0, $zero
    /* 94E30 800A4630 7800A0A7 */  sh         $zero, 0x78($sp)
    /* 94E34 800A4634 7A00A0A7 */  sh         $zero, 0x7A($sp)
    /* 94E38 800A4638 80B6030C */  jal        ClearImage
    /* 94E3C 800A463C 7E00A3A7 */   sh        $v1, 0x7E($sp)
    /* 94E40 800A4640 1FB6030C */  jal        DrawSync
    /* 94E44 800A4644 21200000 */   addu      $a0, $zero, $zero
    /* 94E48 800A4648 21200000 */  addu       $a0, $zero, $zero
    /* 94E4C 800A464C 64000524 */  addiu      $a1, $zero, 0x64
    /* 94E50 800A4650 7DC1030C */  jal        initlinkmode
    /* 94E54 800A4654 21308000 */   addu      $a2, $a0, $zero
    /* 94E58 800A4658 21200000 */  addu       $a0, $zero, $zero
    /* 94E5C 800A465C 21288000 */  addu       $a1, $a0, $zero
    /* 94E60 800A4660 00020624 */  addiu      $a2, $zero, 0x200
    /* 94E64 800A4664 F0000724 */  addiu      $a3, $zero, 0xF0
    /* 94E68 800A4668 01000224 */  addiu      $v0, $zero, 0x1
    /* 94E6C 800A466C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 94E70 800A4670 1400A2AF */  sw         $v0, 0x14($sp)
    /* 94E74 800A4674 1800A2AF */  sw         $v0, 0x18($sp)
    /* 94E78 800A4678 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* 94E7C 800A467C 2000A0AF */  sw         $zero, 0x20($sp)
    /* 94E80 800A4680 1EF9020C */  jal        Draw_DirectSetEnvironment__Fiiiiiiiiii
    /* 94E84 800A4684 2400A0AF */   sw        $zero, 0x24($sp)
    /* 94E88 800A4688 C3C1030C */  jal        settrans
    /* 94E8C 800A468C 21200000 */   addu      $a0, $zero, $zero
    /* 94E90 800A4690 21200002 */  addu       $a0, $s0, $zero
    /* 94E94 800A4694 D2000624 */  addiu      $a2, $zero, 0xD2
    /* 94E98 800A4698 04008284 */  lh         $v0, 0x4($a0)
    /* 94E9C 800A469C E2010524 */  addiu      $a1, $zero, 0x1E2
    /* 94EA0 800A46A0 CEC1030C */  jal        movfxya
    /* 94EA4 800A46A4 2328A200 */   subu      $a1, $a1, $v0
    /* 94EA8 800A46A8 1FB6030C */  jal        DrawSync
    /* 94EAC 800A46AC 21200000 */   addu      $a0, $zero, $zero
    /* 94EB0 800A46B0 5095030C */  jal        purgememadr
    /* 94EB4 800A46B4 21202002 */   addu      $a0, $s1, $zero
    /* 94EB8 800A46B8 21200000 */  addu       $a0, $zero, $zero
    /* 94EBC 800A46BC 01000524 */  addiu      $a1, $zero, 0x1
    /* 94EC0 800A46C0 7DC1030C */  jal        initlinkmode
    /* 94EC4 800A46C4 2130A000 */   addu      $a2, $a1, $zero
    /* 94EC8 800A46C8 8800BF8F */  lw         $ra, 0x88($sp)
    /* 94ECC 800A46CC 8400B18F */  lw         $s1, 0x84($sp)
    /* 94ED0 800A46D0 8000B08F */  lw         $s0, 0x80($sp)
    /* 94ED4 800A46D4 0800E003 */  jr         $ra
    /* 94ED8 800A46D8 9000BD27 */   addiu     $sp, $sp, 0x90
endlabel NFS4_LoadingIcon__Fv
