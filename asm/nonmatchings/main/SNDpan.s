.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDpan, 0x14C

glabel SNDpan
    /* D7084 800E6884 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D7088 800E6888 1800B0AF */  sw         $s0, 0x18($sp)
    /* D708C 800E688C 21808000 */  addu       $s0, $a0, $zero
    /* D7090 800E6890 1480023C */  lui        $v0, %hi(sndgs)
    /* D7094 800E6894 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* D7098 800E6898 60785124 */  addiu      $s1, $v0, %lo(sndgs)
    /* D709C 800E689C 2400BFAF */  sw         $ra, 0x24($sp)
    /* D70A0 800E68A0 2000B2AF */  sw         $s2, 0x20($sp)
    /* D70A4 800E68A4 3C002282 */  lb         $v0, 0x3C($s1)
    /* D70A8 800E68A8 00000000 */  nop
    /* D70AC 800E68AC 03004014 */  bnez       $v0, .L800E68BC
    /* D70B0 800E68B0 2190A000 */   addu      $s2, $a1, $zero
    /* D70B4 800E68B4 6E9A0308 */  j          .L800E69B8
    /* D70B8 800E68B8 F6FF0224 */   addiu     $v0, $zero, -0xA
  .L800E68BC:
    /* D70BC 800E68BC 4DA9030C */  jal        iSNDenteraudio
    /* D70C0 800E68C0 00000000 */   nop
    /* D70C4 800E68C4 71FB030C */  jal        iSNDgetchan
    /* D70C8 800E68C8 21200002 */   addu      $a0, $s0, $zero
    /* D70CC 800E68CC 21804000 */  addu       $s0, $v0, $zero
    /* D70D0 800E68D0 36000006 */  bltz       $s0, .L800E69AC
    /* D70D4 800E68D4 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* D70D8 800E68D8 1000A2AF */  sw         $v0, 0x10($sp)
    /* D70DC 800E68DC 21200002 */  addu       $a0, $s0, $zero
  .L800E68E0:
    /* D70E0 800E68E0 D3FB030C */  jal        iSNDpatchkey
    /* D70E4 800E68E4 1000A527 */   addiu     $a1, $sp, 0x10
    /* D70E8 800E68E8 30004010 */  beqz       $v0, .L800E69AC
    /* D70EC 800E68EC 00000000 */   nop
    /* D70F0 800E68F0 1000A38F */  lw         $v1, 0x10($sp)
    /* D70F4 800E68F4 00000000 */  nop
    /* D70F8 800E68F8 40100300 */  sll        $v0, $v1, 1
    /* D70FC 800E68FC 21104300 */  addu       $v0, $v0, $v1
    /* D7100 800E6900 C0100200 */  sll        $v0, $v0, 3
    /* D7104 800E6904 21104300 */  addu       $v0, $v0, $v1
    /* D7108 800E6908 9400238E */  lw         $v1, 0x94($s1)
    /* D710C 800E690C 80100200 */  sll        $v0, $v0, 2
    /* D7110 800E6910 21186200 */  addu       $v1, $v1, $v0
    /* D7114 800E6914 3D006280 */  lb         $v0, 0x3D($v1)
    /* D7118 800E6918 00000000 */  nop
    /* D711C 800E691C 23005210 */  beq        $v0, $s2, .L800E69AC
    /* D7120 800E6920 21284002 */   addu      $a1, $s2, $zero
    /* D7124 800E6924 33006480 */  lb         $a0, 0x33($v1)
    /* D7128 800E6928 01000224 */  addiu      $v0, $zero, 0x1
    /* D712C 800E692C 05008210 */  beq        $a0, $v0, .L800E6944
    /* D7130 800E6930 3D0072A0 */   sb        $s2, 0x3D($v1)
    /* D7134 800E6934 C0FFA224 */  addiu      $v0, $a1, -0x40
    /* D7138 800E6938 18004400 */  mult       $v0, $a0
    /* D713C 800E693C 12380000 */  mflo       $a3
    /* D7140 800E6940 4000E524 */  addiu      $a1, $a3, 0x40
  .L800E6944:
    /* D7144 800E6944 2E006280 */  lb         $v0, 0x2E($v1)
    /* D7148 800E6948 00000000 */  nop
    /* D714C 800E694C 21104500 */  addu       $v0, $v0, $a1
    /* D7150 800E6950 C0FF4524 */  addiu      $a1, $v0, -0x40
    /* D7154 800E6954 8000A228 */  slti       $v0, $a1, 0x80
    /* D7158 800E6958 03004014 */  bnez       $v0, .L800E6968
    /* D715C 800E695C 00000000 */   nop
    /* D7160 800E6960 5D9A0308 */  j          .L800E6974
    /* D7164 800E6964 7F000524 */   addiu     $a1, $zero, 0x7F
  .L800E6968:
    /* D7168 800E6968 0200A104 */  bgez       $a1, .L800E6974
    /* D716C 800E696C 00000000 */   nop
    /* D7170 800E6970 21280000 */  addu       $a1, $zero, $zero
  .L800E6974:
    /* D7174 800E6974 4800628C */  lw         $v0, 0x48($v1)
    /* D7178 800E6978 00000000 */  nop
    /* D717C 800E697C 02004010 */  beqz       $v0, .L800E6988
    /* D7180 800E6980 21104500 */   addu      $v0, $v0, $a1
    /* D7184 800E6984 00004580 */  lb         $a1, 0x0($v0)
  .L800E6988:
    /* D7188 800E6988 00000000 */  nop
    /* D718C 800E698C C0FFA524 */  addiu      $a1, $a1, -0x40
    /* D7190 800E6990 002A0500 */  sll        $a1, $a1, 8
    /* D7194 800E6994 1000A48F */  lw         $a0, 0x10($sp)
    /* D7198 800E6998 00FFA530 */  andi       $a1, $a1, 0xFF00
    /* D719C 800E699C 8CFB030C */  jal        iSNDplatform3dpos
    /* D71A0 800E69A0 21300000 */   addu      $a2, $zero, $zero
    /* D71A4 800E69A4 389A0308 */  j          .L800E68E0
    /* D71A8 800E69A8 21200002 */   addu      $a0, $s0, $zero
  .L800E69AC:
    /* D71AC 800E69AC 5BA9030C */  jal        iSNDleaveaudio
    /* D71B0 800E69B0 00000000 */   nop
    /* D71B4 800E69B4 21100002 */  addu       $v0, $s0, $zero
  .L800E69B8:
    /* D71B8 800E69B8 2400BF8F */  lw         $ra, 0x24($sp)
    /* D71BC 800E69BC 2000B28F */  lw         $s2, 0x20($sp)
    /* D71C0 800E69C0 1C00B18F */  lw         $s1, 0x1C($sp)
    /* D71C4 800E69C4 1800B08F */  lw         $s0, 0x18($sp)
    /* D71C8 800E69C8 0800E003 */  jr         $ra
    /* D71CC 800E69CC 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel SNDpan
