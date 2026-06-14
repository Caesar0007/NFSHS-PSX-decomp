.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_HandleDirection__FP8Car_tObj, 0xE8

glabel AIPhysic_HandleDirection__FP8Car_tObj
    /* 5AFCC 8006A7CC 21288000 */  addu       $a1, $a0, $zero
    /* 5AFD0 8006A7D0 F006A38C */  lw         $v1, 0x6F0($a1)
    /* 5AFD4 8006A7D4 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 5AFD8 8006A7D8 34006214 */  bne        $v1, $v0, .L8006A8AC
    /* 5AFDC 8006A7DC F6FF023C */   lui       $v0, (0xFFF60000 >> 16)
    /* 5AFE0 8006A7E0 1807A38C */  lw         $v1, 0x718($a1)
    /* 5AFE4 8006A7E4 7405A48C */  lw         $a0, 0x574($a1)
    /* 5AFE8 8006A7E8 21106200 */  addu       $v0, $v1, $v0
    /* 5AFEC 8006A7EC 2A108200 */  slt        $v0, $a0, $v0
    /* 5AFF0 8006A7F0 06004010 */  beqz       $v0, .L8006A80C
    /* 5AFF4 8006A7F4 0A00023C */   lui       $v0, (0xA0000 >> 16)
    /* 5AFF8 8006A7F8 0407A28C */  lw         $v0, 0x704($a1)
    /* 5AFFC 8006A7FC 00000000 */  nop
    /* 5B000 8006A800 0B00401C */  bgtz       $v0, .L8006A830
    /* 5B004 8006A804 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* 5B008 8006A808 0A00023C */  lui        $v0, (0xA0000 >> 16)
  .L8006A80C:
    /* 5B00C 8006A80C 21106200 */  addu       $v0, $v1, $v0
    /* 5B010 8006A810 2A104400 */  slt        $v0, $v0, $a0
    /* 5B014 8006A814 0B004010 */  beqz       $v0, .L8006A844
    /* 5B018 8006A818 1280023C */   lui       $v0, %hi(simGlobal)
    /* 5B01C 8006A81C 0407A28C */  lw         $v0, 0x704($a1)
    /* 5B020 8006A820 00000000 */  nop
    /* 5B024 8006A824 07004104 */  bgez       $v0, .L8006A844
    /* 5B028 8006A828 1280023C */   lui       $v0, %hi(simGlobal)
    /* 5B02C 8006A82C 1280023C */  lui        $v0, %hi(D_8011E0B0)
  .L8006A830:
    /* 5B030 8006A830 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 5B034 8006A834 00000000 */  nop
    /* 5B038 8006A838 E8FF4224 */  addiu      $v0, $v0, -0x18
    /* 5B03C 8006A83C F406A2AC */  sw         $v0, 0x6F4($a1)
    /* 5B040 8006A840 1280023C */  lui        $v0, %hi(simGlobal)
  .L8006A844:
    /* 5B044 8006A844 ACE04624 */  addiu      $a2, $v0, %lo(simGlobal)
    /* 5B048 8006A848 0400C38C */  lw         $v1, 0x4($a2)
    /* 5B04C 8006A84C F406A48C */  lw         $a0, 0x6F4($a1)
    /* 5B050 8006A850 EC06A28C */  lw         $v0, 0x6EC($a1)
    /* 5B054 8006A854 23186400 */  subu       $v1, $v1, $a0
    /* 5B058 8006A858 2A104300 */  slt        $v0, $v0, $v1
    /* 5B05C 8006A85C 05004010 */  beqz       $v0, .L8006A874
    /* 5B060 8006A860 01000224 */   addiu     $v0, $zero, 0x1
    /* 5B064 8006A864 F006A2AC */  sw         $v0, 0x6F0($a1)
    /* 5B068 8006A868 0400C28C */  lw         $v0, 0x4($a2)
    /* 5B06C 8006A86C 00000000 */  nop
    /* 5B070 8006A870 F406A2AC */  sw         $v0, 0x6F4($a1)
  .L8006A874:
    /* 5B074 8006A874 5C05A28C */  lw         $v0, 0x55C($a1)
    /* 5B078 8006A878 1400033C */  lui        $v1, (0x140000 >> 16)
    /* 5B07C 8006A87C 2A106200 */  slt        $v0, $v1, $v0
    /* 5B080 8006A880 02004010 */  beqz       $v0, .L8006A88C
    /* 5B084 8006A884 00000000 */   nop
    /* 5B088 8006A888 5C05A3AC */  sw         $v1, 0x55C($a1)
  .L8006A88C:
    /* 5B08C 8006A88C 5C05A28C */  lw         $v0, 0x55C($a1)
    /* 5B090 8006A890 00000000 */  nop
    /* 5B094 8006A894 23100200 */  negu       $v0, $v0
    /* 5B098 8006A898 2A106200 */  slt        $v0, $v1, $v0
    /* 5B09C 8006A89C 02004010 */  beqz       $v0, .L8006A8A8
    /* 5B0A0 8006A8A0 ECFF023C */   lui       $v0, (0xFFEC0000 >> 16)
    /* 5B0A4 8006A8A4 5C05A2AC */  sw         $v0, 0x55C($a1)
  .L8006A8A8:
    /* 5B0A8 8006A8A8 1807A0AC */  sw         $zero, 0x718($a1)
  .L8006A8AC:
    /* 5B0AC 8006A8AC 0800E003 */  jr         $ra
    /* 5B0B0 8006A8B0 00000000 */   nop
endlabel AIPhysic_HandleDirection__FP8Car_tObj
