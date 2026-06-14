.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching locatebigoffset, 0x3C

glabel locatebigoffset
    /* D69DC 800E61DC D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D69E0 800E61E0 2000BFAF */  sw         $ra, 0x20($sp)
    /* D69E4 800E61E4 0700A010 */  beqz       $a1, .L800E6204
    /* D69E8 800E61E8 1800A0AF */   sw        $zero, 0x18($sp)
    /* D69EC 800E61EC 1480023C */  lui        $v0, %hi(biglen)
    /* D69F0 800E61F0 64DE4224 */  addiu      $v0, $v0, %lo(biglen)
    /* D69F4 800E61F4 1000A2AF */  sw         $v0, 0x10($sp)
    /* D69F8 800E61F8 21300000 */  addu       $a2, $zero, $zero
    /* D69FC 800E61FC 6E98030C */  jal        locatebigentry
    /* D6A00 800E6200 1800A727 */   addiu     $a3, $sp, 0x18
  .L800E6204:
    /* D6A04 800E6204 1800A28F */  lw         $v0, 0x18($sp)
    /* D6A08 800E6208 2000BF8F */  lw         $ra, 0x20($sp)
    /* D6A0C 800E620C 00000000 */  nop
    /* D6A10 800E6210 0800E003 */  jr         $ra
    /* D6A14 800E6214 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel locatebigoffset
