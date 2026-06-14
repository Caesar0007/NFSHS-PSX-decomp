.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PickVoice__6SpeechP8Car_tObj, 0x9C

glabel PickVoice__6SpeechP8Car_tObj
    /* 87D5C 8009755C 6002A38C */  lw         $v1, 0x260($a1)
    /* 87D60 80097560 00000000 */  nop
    /* 87D64 80097564 40006230 */  andi       $v0, $v1, 0x40
    /* 87D68 80097568 10004010 */  beqz       $v0, .L800975AC
    /* 87D6C 8009756C 21308000 */   addu      $a2, $a0, $zero
    /* 87D70 80097570 AA2A023C */  lui        $v0, (0x2AAAAAAB >> 16)
    /* 87D74 80097574 8403C38C */  lw         $v1, 0x384($a2)
    /* 87D78 80097578 ABAA4234 */  ori        $v0, $v0, (0x2AAAAAAB & 0xFFFF)
    /* 87D7C 8009757C 18006200 */  mult       $v1, $v0
    /* 87D80 80097580 C3170300 */  sra        $v0, $v1, 31
    /* 87D84 80097584 10380000 */  mfhi       $a3
    /* 87D88 80097588 2320E200 */  subu       $a0, $a3, $v0
    /* 87D8C 8009758C 40100400 */  sll        $v0, $a0, 1
    /* 87D90 80097590 21104400 */  addu       $v0, $v0, $a0
    /* 87D94 80097594 40100200 */  sll        $v0, $v0, 1
    /* 87D98 80097598 23206200 */  subu       $a0, $v1, $v0
    /* 87D9C 8009759C 01006324 */  addiu      $v1, $v1, 0x1
    /* 87DA0 800975A0 21108000 */  addu       $v0, $a0, $zero
    /* 87DA4 800975A4 0800E003 */  jr         $ra
    /* 87DA8 800975A8 8403C3AC */   sw        $v1, 0x384($a2)
  .L800975AC:
    /* 87DAC 800975AC 80006230 */  andi       $v0, $v1, 0x80
    /* 87DB0 800975B0 0F004014 */  bnez       $v0, .L800975F0
    /* 87DB4 800975B4 E338023C */   lui       $v0, (0x38E38E39 >> 16)
    /* 87DB8 800975B8 8003C38C */  lw         $v1, 0x380($a2)
    /* 87DBC 800975BC 398E4234 */  ori        $v0, $v0, (0x38E38E39 & 0xFFFF)
    /* 87DC0 800975C0 18006200 */  mult       $v1, $v0
    /* 87DC4 800975C4 C3170300 */  sra        $v0, $v1, 31
    /* 87DC8 800975C8 10380000 */  mfhi       $a3
    /* 87DCC 800975CC 43200700 */  sra        $a0, $a3, 1
    /* 87DD0 800975D0 23208200 */  subu       $a0, $a0, $v0
    /* 87DD4 800975D4 C0100400 */  sll        $v0, $a0, 3
    /* 87DD8 800975D8 21104400 */  addu       $v0, $v0, $a0
    /* 87DDC 800975DC 23206200 */  subu       $a0, $v1, $v0
    /* 87DE0 800975E0 01006324 */  addiu      $v1, $v1, 0x1
    /* 87DE4 800975E4 21108000 */  addu       $v0, $a0, $zero
    /* 87DE8 800975E8 0800E003 */  jr         $ra
    /* 87DEC 800975EC 8003C3AC */   sw        $v1, 0x380($a2)
  .L800975F0:
    /* 87DF0 800975F0 0800E003 */  jr         $ra
    /* 87DF4 800975F4 21100000 */   addu      $v0, $zero, $zero
endlabel PickVoice__6SpeechP8Car_tObj
