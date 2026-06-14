.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioMus_QueueRequestedSong__Fv, 0xB0

glabel AudioMus_QueueRequestedSong__Fv
    /* 6AA58 8007A258 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6AA5C 8007A25C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 6AA60 8007A260 2000BFAF */  sw         $ra, 0x20($sp)
    /* 6AA64 8007A264 0C00438C */  lw         $v1, 0xC($v0)
    /* 6AA68 8007A268 00000000 */  nop
    /* 6AA6C 8007A26C 21184300 */  addu       $v1, $v0, $v1
    /* 6AA70 8007A270 EC006690 */  lbu        $a2, 0xEC($v1)
    /* 6AA74 8007A274 21280000 */  addu       $a1, $zero, $zero
    /* 6AA78 8007A278 1000A0AF */  sw         $zero, 0x10($sp)
    /* 6AA7C 8007A27C 8C00448C */  lw         $a0, 0x8C($v0)
    /* 6AA80 8007A280 6E98030C */  jal        locatebigentry
    /* 6AA84 8007A284 1800A727 */   addiu     $a3, $sp, 0x18
    /* 6AA88 8007A288 D401868F */  lw         $a2, %gp_rel(AudioMus_g)($gp)
    /* 6AA8C 8007A28C 00000000 */  nop
    /* 6AA90 8007A290 7400C48C */  lw         $a0, 0x74($a2)
    /* 6AA94 8007A294 00000000 */  nop
    /* 6AA98 8007A298 08008004 */  bltz       $a0, .L8007A2BC
    /* 6AA9C 8007A29C 2C00C2AC */   sw        $v0, 0x2C($a2)
    /* 6AAA0 8007A2A0 E8030524 */  addiu      $a1, $zero, 0x3E8
    /* 6AAA4 8007A2A4 1800A78F */  lw         $a3, 0x18($sp)
    /* 6AAA8 8007A2A8 0EA7030C */  jal        SNDSTRM_queuefile
    /* 6AAAC 8007A2AC AC00C624 */   addiu     $a2, $a2, 0xAC
    /* 6AAB0 8007A2B0 D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6AAB4 8007A2B4 00000000 */  nop
    /* 6AAB8 8007A2B8 780062AC */  sw         $v0, 0x78($v1)
  .L8007A2BC:
    /* 6AABC 8007A2BC D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6AAC0 8007A2C0 02000224 */  addiu      $v0, $zero, 0x2
    /* 6AAC4 8007A2C4 88A0030C */  jal        gettick
    /* 6AAC8 8007A2C8 140062AC */   sw        $v0, 0x14($v1)
    /* 6AACC 8007A2CC D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6AAD0 8007A2D0 80024224 */  addiu      $v0, $v0, 0x280
    /* 6AAD4 8007A2D4 1C0062AC */  sw         $v0, 0x1C($v1)
    /* 6AAD8 8007A2D8 18016224 */  addiu      $v0, $v1, 0x118
    /* 6AADC 8007A2DC 140160AC */  sw         $zero, 0x114($v1)
    /* 6AAE0 8007A2E0 180040AC */  sw         $zero, 0x18($v0)
    /* 6AAE4 8007A2E4 180160AC */  sw         $zero, 0x118($v1)
    /* 6AAE8 8007A2E8 040040AC */  sw         $zero, 0x4($v0)
    /* 6AAEC 8007A2EC 080040AC */  sw         $zero, 0x8($v0)
    /* 6AAF0 8007A2F0 0C0040AC */  sw         $zero, 0xC($v0)
    /* 6AAF4 8007A2F4 140040AC */  sw         $zero, 0x14($v0)
    /* 6AAF8 8007A2F8 2000BF8F */  lw         $ra, 0x20($sp)
    /* 6AAFC 8007A2FC 00000000 */  nop
    /* 6AB00 8007A300 0800E003 */  jr         $ra
    /* 6AB04 8007A304 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel AudioMus_QueueRequestedSong__Fv
