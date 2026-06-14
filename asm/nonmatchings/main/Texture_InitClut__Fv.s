.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Texture_InitClut__Fv, 0x104

glabel Texture_InitClut__Fv
    /* D0034 800DF834 E015888F */  lw         $t0, %gp_rel(gFreePal4)($gp)
    /* D0038 800DF838 21380000 */  addu       $a3, $zero, $zero
    /* D003C 800DF83C E41580AF */  sw         $zero, %gp_rel(gNbFreePal4)($gp)
    /* D0040 800DF840 21280000 */  addu       $a1, $zero, $zero
  .L800DF844:
    /* D0044 800DF844 03110700 */  sra        $v0, $a3, 4
    /* D0048 800DF848 3F004630 */  andi       $a2, $v0, 0x3F
    /* D004C 800DF84C 80190500 */  sll        $v1, $a1, 6
  .L800DF850:
    /* D0050 800DF850 0100A524 */  addiu      $a1, $a1, 0x1
    /* D0054 800DF854 E415848F */  lw         $a0, %gp_rel(gNbFreePal4)($gp)
    /* D0058 800DF858 25186600 */  or         $v1, $v1, $a2
    /* D005C 800DF85C 40100400 */  sll        $v0, $a0, 1
    /* D0060 800DF860 01008424 */  addiu      $a0, $a0, 0x1
    /* D0064 800DF864 21104800 */  addu       $v0, $v0, $t0
    /* D0068 800DF868 000043A4 */  sh         $v1, 0x0($v0)
    /* D006C 800DF86C 7800A228 */  slti       $v0, $a1, 0x78
    /* D0070 800DF870 E41584AF */  sw         $a0, %gp_rel(gNbFreePal4)($gp)
    /* D0074 800DF874 F6FF4014 */  bnez       $v0, .L800DF850
    /* D0078 800DF878 80190500 */   sll       $v1, $a1, 6
    /* D007C 800DF87C 1000E724 */  addiu      $a3, $a3, 0x10
    /* D0080 800DF880 0001E228 */  slti       $v0, $a3, 0x100
    /* D0084 800DF884 EFFF4014 */  bnez       $v0, .L800DF844
    /* D0088 800DF888 21280000 */   addu      $a1, $zero, $zero
    /* D008C 800DF88C 21380000 */  addu       $a3, $zero, $zero
    /* D0090 800DF890 E015898F */  lw         $t1, %gp_rel(gFreePal4)($gp)
  .L800DF894:
    /* D0094 800DF894 03110700 */  sra        $v0, $a3, 4
    /* D0098 800DF898 3F004830 */  andi       $t0, $v0, 0x3F
    /* D009C 800DF89C 00200624 */  addiu      $a2, $zero, 0x2000
  .L800DF8A0:
    /* D00A0 800DF8A0 2520C800 */  or         $a0, $a2, $t0
    /* D00A4 800DF8A4 E415838F */  lw         $v1, %gp_rel(gNbFreePal4)($gp)
    /* D00A8 800DF8A8 0100A524 */  addiu      $a1, $a1, 0x1
    /* D00AC 800DF8AC 40100300 */  sll        $v0, $v1, 1
    /* D00B0 800DF8B0 01006324 */  addiu      $v1, $v1, 0x1
    /* D00B4 800DF8B4 21104900 */  addu       $v0, $v0, $t1
    /* D00B8 800DF8B8 000044A4 */  sh         $a0, 0x0($v0)
    /* D00BC 800DF8BC 2000A228 */  slti       $v0, $a1, 0x20
    /* D00C0 800DF8C0 E41583AF */  sw         $v1, %gp_rel(gNbFreePal4)($gp)
    /* D00C4 800DF8C4 F6FF4014 */  bnez       $v0, .L800DF8A0
    /* D00C8 800DF8C8 4000C624 */   addiu     $a2, $a2, 0x40
    /* D00CC 800DF8CC 1000E724 */  addiu      $a3, $a3, 0x10
    /* D00D0 800DF8D0 8000E228 */  slti       $v0, $a3, 0x80
    /* D00D4 800DF8D4 EFFF4014 */  bnez       $v0, .L800DF894
    /* D00D8 800DF8D8 21280000 */   addu      $a1, $zero, $zero
    /* D00DC 800DF8DC E815898F */  lw         $t1, %gp_rel(gFreePal8)($gp)
    /* D00E0 800DF8E0 21380000 */  addu       $a3, $zero, $zero
    /* D00E4 800DF8E4 EC1580AF */  sw         $zero, %gp_rel(gNbFreePal8)($gp)
  .L800DF8E8:
    /* D00E8 800DF8E8 03110700 */  sra        $v0, $a3, 4
    /* D00EC 800DF8EC 3F004830 */  andi       $t0, $v0, 0x3F
    /* D00F0 800DF8F0 001E0624 */  addiu      $a2, $zero, 0x1E00
  .L800DF8F4:
    /* D00F4 800DF8F4 2520C800 */  or         $a0, $a2, $t0
    /* D00F8 800DF8F8 EC15838F */  lw         $v1, %gp_rel(gNbFreePal8)($gp)
    /* D00FC 800DF8FC 0100A524 */  addiu      $a1, $a1, 0x1
    /* D0100 800DF900 40100300 */  sll        $v0, $v1, 1
    /* D0104 800DF904 01006324 */  addiu      $v1, $v1, 0x1
    /* D0108 800DF908 21104900 */  addu       $v0, $v0, $t1
    /* D010C 800DF90C 000044A4 */  sh         $a0, 0x0($v0)
    /* D0110 800DF910 0800A228 */  slti       $v0, $a1, 0x8
    /* D0114 800DF914 EC1583AF */  sw         $v1, %gp_rel(gNbFreePal8)($gp)
    /* D0118 800DF918 F6FF4014 */  bnez       $v0, .L800DF8F4
    /* D011C 800DF91C 4000C624 */   addiu     $a2, $a2, 0x40
    /* D0120 800DF920 0001E724 */  addiu      $a3, $a3, 0x100
    /* D0124 800DF924 0001E228 */  slti       $v0, $a3, 0x100
    /* D0128 800DF928 EFFF4014 */  bnez       $v0, .L800DF8E8
    /* D012C 800DF92C 21280000 */   addu      $a1, $zero, $zero
    /* D0130 800DF930 0800E003 */  jr         $ra
    /* D0134 800DF934 00000000 */   nop
endlabel Texture_InitClut__Fv
