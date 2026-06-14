.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Clear__16AIHigh_BasicPerp, 0x3C

glabel Clear__16AIHigh_BasicPerp
    /* 4C8B8 8005C0B8 21280000 */  addu       $a1, $zero, $zero
    /* 4C8BC 8005C0BC FFFF0624 */  addiu      $a2, $zero, -0x1
    /* 4C8C0 8005C0C0 21188000 */  addu       $v1, $a0, $zero
  .L8005C0C4:
    /* 4C8C4 8005C0C4 1C0066AC */  sw         $a2, 0x1C($v1)
    /* 4C8C8 8005C0C8 200066AC */  sw         $a2, 0x20($v1)
    /* 4C8CC 8005C0CC 0100A524 */  addiu      $a1, $a1, 0x1
    /* 4C8D0 8005C0D0 0600A228 */  slti       $v0, $a1, 0x6
    /* 4C8D4 8005C0D4 FBFF4014 */  bnez       $v0, .L8005C0C4
    /* 4C8D8 8005C0D8 08006324 */   addiu     $v1, $v1, 0x8
    /* 4C8DC 8005C0DC 80FD0224 */  addiu      $v0, $zero, -0x280
    /* 4C8E0 8005C0E0 180080AC */  sw         $zero, 0x18($a0)
    /* 4C8E4 8005C0E4 640080AC */  sw         $zero, 0x64($a0)
    /* 4C8E8 8005C0E8 680082AC */  sw         $v0, 0x68($a0)
    /* 4C8EC 8005C0EC 0800E003 */  jr         $ra
    /* 4C8F0 8005C0F0 6C0080AC */   sw        $zero, 0x6C($a0)
endlabel Clear__16AIHigh_BasicPerp
