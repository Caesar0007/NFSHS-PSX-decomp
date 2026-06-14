.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Flare_SingleColorHex__FP7DVECTORP7CVECTORiii, 0x114

glabel Flare_SingleColorHex__FP7DVECTORP7CVECTORiii
    /* BEF9C 800CE79C C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* BEFA0 800CE7A0 21408000 */  addu       $t0, $a0, $zero
    /* BEFA4 800CE7A4 2800B0AF */  sw         $s0, 0x28($sp)
    /* BEFA8 800CE7A8 2180A000 */  addu       $s0, $a1, $zero
    /* BEFAC 800CE7AC 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* BEFB0 800CE7B0 4800B18F */  lw         $s1, 0x48($sp)
    /* BEFB4 800CE7B4 2118C000 */  addu       $v1, $a2, $zero
    /* BEFB8 800CE7B8 0200C104 */  bgez       $a2, .L800CE7C4
    /* BEFBC 800CE7BC 3000BFAF */   sw        $ra, 0x30($sp)
    /* BEFC0 800CE7C0 0300C324 */  addiu      $v1, $a2, 0x3
  .L800CE7C4:
    /* BEFC4 800CE7C4 00000295 */  lhu        $v0, 0x0($t0)
    /* BEFC8 800CE7C8 83480300 */  sra        $t1, $v1, 2
    /* BEFCC 800CE7CC 23104900 */  subu       $v0, $v0, $t1
    /* BEFD0 800CE7D0 1000A2A7 */  sh         $v0, 0x10($sp)
    /* BEFD4 800CE7D4 C2170700 */  srl        $v0, $a3, 31
    /* BEFD8 800CE7D8 2110E200 */  addu       $v0, $a3, $v0
    /* BEFDC 800CE7DC 02000395 */  lhu        $v1, 0x2($t0)
    /* BEFE0 800CE7E0 43380200 */  sra        $a3, $v0, 1
    /* BEFE4 800CE7E4 21186700 */  addu       $v1, $v1, $a3
    /* BEFE8 800CE7E8 1200A3A7 */  sh         $v1, 0x12($sp)
    /* BEFEC 800CE7EC 00000295 */  lhu        $v0, 0x0($t0)
    /* BEFF0 800CE7F0 C21F0600 */  srl        $v1, $a2, 31
    /* BEFF4 800CE7F4 21104900 */  addu       $v0, $v0, $t1
    /* BEFF8 800CE7F8 1400A2A7 */  sh         $v0, 0x14($sp)
    /* BEFFC 800CE7FC 02000295 */  lhu        $v0, 0x2($t0)
    /* BF000 800CE800 2118C300 */  addu       $v1, $a2, $v1
    /* BF004 800CE804 21104700 */  addu       $v0, $v0, $a3
    /* BF008 800CE808 1600A2A7 */  sh         $v0, 0x16($sp)
    /* BF00C 800CE80C 00000295 */  lhu        $v0, 0x0($t0)
    /* BF010 800CE810 43180300 */  sra        $v1, $v1, 1
    /* BF014 800CE814 23104300 */  subu       $v0, $v0, $v1
    /* BF018 800CE818 1800A2A7 */  sh         $v0, 0x18($sp)
    /* BF01C 800CE81C 02000295 */  lhu        $v0, 0x2($t0)
    /* BF020 800CE820 00000000 */  nop
    /* BF024 800CE824 1A00A2A7 */  sh         $v0, 0x1A($sp)
    /* BF028 800CE828 00000295 */  lhu        $v0, 0x0($t0)
    /* BF02C 800CE82C 00000000 */  nop
    /* BF030 800CE830 21104300 */  addu       $v0, $v0, $v1
    /* BF034 800CE834 1C00A2A7 */  sh         $v0, 0x1C($sp)
    /* BF038 800CE838 02000295 */  lhu        $v0, 0x2($t0)
    /* BF03C 800CE83C 00000000 */  nop
    /* BF040 800CE840 1E00A2A7 */  sh         $v0, 0x1E($sp)
    /* BF044 800CE844 00000295 */  lhu        $v0, 0x0($t0)
    /* BF048 800CE848 00000000 */  nop
    /* BF04C 800CE84C 23104900 */  subu       $v0, $v0, $t1
    /* BF050 800CE850 2000A2A7 */  sh         $v0, 0x20($sp)
    /* BF054 800CE854 02000295 */  lhu        $v0, 0x2($t0)
    /* BF058 800CE858 00000000 */  nop
    /* BF05C 800CE85C 23104700 */  subu       $v0, $v0, $a3
    /* BF060 800CE860 2200A2A7 */  sh         $v0, 0x22($sp)
    /* BF064 800CE864 1000A427 */  addiu      $a0, $sp, 0x10
    /* BF068 800CE868 00000295 */  lhu        $v0, 0x0($t0)
    /* BF06C 800CE86C 21280002 */  addu       $a1, $s0, $zero
    /* BF070 800CE870 21104900 */  addu       $v0, $v0, $t1
    /* BF074 800CE874 2400A2A7 */  sh         $v0, 0x24($sp)
    /* BF078 800CE878 02000295 */  lhu        $v0, 0x2($t0)
    /* BF07C 800CE87C 21302002 */  addu       $a2, $s1, $zero
    /* BF080 800CE880 23104700 */  subu       $v0, $v0, $a3
    /* BF084 800CE884 0839030C */  jal        Flare_Quad__FPlP7CVECTORi
    /* BF088 800CE888 2600A2A7 */   sh        $v0, 0x26($sp)
    /* BF08C 800CE88C 1800A427 */  addiu      $a0, $sp, 0x18
    /* BF090 800CE890 21280002 */  addu       $a1, $s0, $zero
    /* BF094 800CE894 0839030C */  jal        Flare_Quad__FPlP7CVECTORi
    /* BF098 800CE898 21302002 */   addu      $a2, $s1, $zero
    /* BF09C 800CE89C 3000BF8F */  lw         $ra, 0x30($sp)
    /* BF0A0 800CE8A0 2C00B18F */  lw         $s1, 0x2C($sp)
    /* BF0A4 800CE8A4 2800B08F */  lw         $s0, 0x28($sp)
    /* BF0A8 800CE8A8 0800E003 */  jr         $ra
    /* BF0AC 800CE8AC 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel Flare_SingleColorHex__FP7DVECTORP7CVECTORiii
