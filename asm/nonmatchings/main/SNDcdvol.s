.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDcdvol, 0x68

glabel SNDcdvol
    /* EB244 800FAA44 1480023C */  lui        $v0, %hi(D_8014789D)
    /* EB248 800FAA48 9D784280 */  lb         $v0, %lo(D_8014789D)($v0)
    /* EB24C 800FAA4C 00000000 */  nop
    /* EB250 800FAA50 18008200 */  mult       $a0, $v0
    /* EB254 800FAA54 12200000 */  mflo       $a0
    /* EB258 800FAA58 0281023C */  lui        $v0, (0x81020409 >> 16)
    /* EB25C 800FAA5C 09044234 */  ori        $v0, $v0, (0x81020409 & 0xFFFF)
    /* EB260 800FAA60 18008200 */  mult       $a0, $v0
    /* EB264 800FAA64 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* EB268 800FAA68 1380033C */  lui        $v1, %hi(sndcdvs)
    /* EB26C 800FAA6C 1000BFAF */  sw         $ra, 0x10($sp)
    /* EB270 800FAA70 AC6C6224 */  addiu      $v0, $v1, %lo(sndcdvs)
    /* EB274 800FAA74 10380000 */  mfhi       $a3
    /* EB278 800FAA78 2128E400 */  addu       $a1, $a3, $a0
    /* EB27C 800FAA7C 83290500 */  sra        $a1, $a1, 6
    /* EB280 800FAA80 C3270400 */  sra        $a0, $a0, 31
    /* EB284 800FAA84 2328A400 */  subu       $a1, $a1, $a0
    /* EB288 800FAA88 020045A4 */  sh         $a1, 0x2($v0)
    /* EB28C 800FAA8C 002C0500 */  sll        $a1, $a1, 16
    /* EB290 800FAA90 AC6C6484 */  lh         $a0, %lo(sndcdvs)($v1)
    /* EB294 800FAA94 3B25040C */  jal        iSNDplatformcdpanvol
    /* EB298 800FAA98 032C0500 */   sra       $a1, $a1, 16
    /* EB29C 800FAA9C 1000BF8F */  lw         $ra, 0x10($sp)
    /* EB2A0 800FAAA0 21100000 */  addu       $v0, $zero, $zero
    /* EB2A4 800FAAA4 0800E003 */  jr         $ra
    /* EB2A8 800FAAA8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SNDcdvol
