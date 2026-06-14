.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Device_SetHardCodedKeys__Fv, 0x64

glabel Device_SetHardCodedKeys__Fv
    /* ADDE0 800BD5E0 4000063C */  lui        $a2, (0x400003 >> 16)
    /* ADDE4 800BD5E4 0300C634 */  ori        $a2, $a2, (0x400003 & 0xFFFF)
    /* ADDE8 800BD5E8 1000053C */  lui        $a1, (0x100003 >> 16)
    /* ADDEC 800BD5EC 0300A534 */  ori        $a1, $a1, (0x100003 & 0xFFFF)
    /* ADDF0 800BD5F0 8000043C */  lui        $a0, (0x800003 >> 16)
    /* ADDF4 800BD5F4 03008434 */  ori        $a0, $a0, (0x800003 & 0xFFFF)
    /* ADDF8 800BD5F8 1180023C */  lui        $v0, %hi(Input_gHandler)
    /* ADDFC 800BD5FC 143C4224 */  addiu      $v0, $v0, %lo(Input_gHandler)
    /* ADE00 800BD600 03100324 */  addiu      $v1, $zero, 0x1003
    /* ADE04 800BD604 640243AC */  sw         $v1, 0x264($v0)
    /* ADE08 800BD608 03400324 */  addiu      $v1, $zero, 0x4003
    /* ADE0C 800BD60C 680243AC */  sw         $v1, 0x268($v0)
    /* ADE10 800BD610 03800334 */  ori        $v1, $zero, 0x8003
    /* ADE14 800BD614 6C0243AC */  sw         $v1, 0x26C($v0)
    /* ADE18 800BD618 03200324 */  addiu      $v1, $zero, 0x2003
    /* ADE1C 800BD61C 700243AC */  sw         $v1, 0x270($v0)
    /* ADE20 800BD620 03080324 */  addiu      $v1, $zero, 0x803
    /* ADE24 800BD624 780243AC */  sw         $v1, 0x278($v0)
    /* ADE28 800BD628 03010324 */  addiu      $v1, $zero, 0x103
    /* ADE2C 800BD62C 740246AC */  sw         $a2, 0x274($v0)
    /* ADE30 800BD630 C00245AC */  sw         $a1, 0x2C0($v0)
    /* ADE34 800BD634 C40244AC */  sw         $a0, 0x2C4($v0)
    /* ADE38 800BD638 800243AC */  sw         $v1, 0x280($v0)
    /* ADE3C 800BD63C 0800E003 */  jr         $ra
    /* ADE40 800BD640 600240AC */   sw        $zero, 0x260($v0)
endlabel Device_SetHardCodedKeys__Fv
