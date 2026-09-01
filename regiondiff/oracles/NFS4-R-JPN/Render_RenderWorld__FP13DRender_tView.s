.set noat
.set noreorder

glabel func_800B3D34
/* 800B3D34 27bdffe0 */  addiu    $sp,$sp,-32
/* 800B3D38 afb00010 */  sw       $s0,16($sp)
/* 800B3D3C 00808021 */  move     $s0,$a0
/* 800B3D40 afbf0018 */  sw       $ra,24($sp)
/* 800B3D44 0c01fabc */  jal      func_8007EAF0
/* 800B3D48 afb10014 */  sw       $s1,20($sp)
/* 800B3D4C 0c03479a */  jal      func_800D1E68
/* 800B3D50 02002021 */  move     $a0,$s0
/* 800B3D54 3c041f80 */  lui      $a0,0x1f80
/* 800B3D58 0c0393a1 */  jal      func_800E4E84
/* 800B3D5C 348403fc */  ori      $a0,$a0,0x3fc
/* 800B3D60 00408821 */  move     $s1,$v0
/* 800B3D64 0c0391ca */  jal      func_800E4728
/* 800B3D68 02002021 */  move     $a0,$s0
/* 800B3D6C 0c0393a1 */  jal      func_800E4E84
/* 800B3D70 02202021 */  move     $a0,$s1
/* 800B3D74 0c02d13d */  jal      func_800B44F4
/* 800B3D78 00000000 */  nop      
/* 800B3D7C 3c041f80 */  lui      $a0,0x1f80
/* 800B3D80 0c0393a1 */  jal      func_800E4E84
/* 800B3D84 348403fc */  ori      $a0,$a0,0x3fc
/* 800B3D88 00408821 */  move     $s1,$v0
/* 800B3D8C 0c037f97 */  jal      func_800DFE5C
/* 800B3D90 02002021 */  move     $a0,$s0
/* 800B3D94 0c0393a1 */  jal      func_800E4E84
/* 800B3D98 02202021 */  move     $a0,$s1
/* 800B3D9C 3c041f80 */  lui      $a0,0x1f80
/* 800B3DA0 0c0393a1 */  jal      func_800E4E84
/* 800B3DA4 348403fc */  ori      $a0,$a0,0x3fc
/* 800B3DA8 00408821 */  move     $s1,$v0
/* 800B3DAC 0c02e21c */  jal      func_800B8870
/* 800B3DB0 02002021 */  move     $a0,$s0
/* 800B3DB4 0c0393a1 */  jal      func_800E4E84
/* 800B3DB8 02202021 */  move     $a0,$s1
/* 800B3DBC 0c02cd9d */  jal      func_800B3674
/* 800B3DC0 02002021 */  move     $a0,$s0
/* 800B3DC4 8fbf0018 */  lw       $ra,24($sp)
/* 800B3DC8 8fb10014 */  lw       $s1,20($sp)
/* 800B3DCC 8fb00010 */  lw       $s0,16($sp)
/* 800B3DD0 03e00008 */  jr       $ra
/* 800B3DD4 27bd0020 */  addiu    $sp,$sp,32
