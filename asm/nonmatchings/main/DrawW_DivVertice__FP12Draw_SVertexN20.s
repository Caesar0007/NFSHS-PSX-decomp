.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawW_DivVertice__FP12Draw_SVertexN20, 0xD8

glabel DrawW_DivVertice__FP12Draw_SVertexN20
    /* B5924 800C5124 0000A284 */  lh         $v0, 0x0($a1)
    /* B5928 800C5128 0000C384 */  lh         $v1, 0x0($a2)
    /* B592C 800C512C 00000000 */  nop
    /* B5930 800C5130 21104300 */  addu       $v0, $v0, $v1
    /* B5934 800C5134 01004224 */  addiu      $v0, $v0, 0x1
    /* B5938 800C5138 43100200 */  sra        $v0, $v0, 1
    /* B593C 800C513C 000082A4 */  sh         $v0, 0x0($a0)
    /* B5940 800C5140 0200A284 */  lh         $v0, 0x2($a1)
    /* B5944 800C5144 0200C384 */  lh         $v1, 0x2($a2)
    /* B5948 800C5148 00000000 */  nop
    /* B594C 800C514C 21104300 */  addu       $v0, $v0, $v1
    /* B5950 800C5150 01004224 */  addiu      $v0, $v0, 0x1
    /* B5954 800C5154 43100200 */  sra        $v0, $v0, 1
    /* B5958 800C5158 020082A4 */  sh         $v0, 0x2($a0)
    /* B595C 800C515C 0400A284 */  lh         $v0, 0x4($a1)
    /* B5960 800C5160 0400C384 */  lh         $v1, 0x4($a2)
    /* B5964 800C5164 00000000 */  nop
    /* B5968 800C5168 21104300 */  addu       $v0, $v0, $v1
    /* B596C 800C516C 01004224 */  addiu      $v0, $v0, 0x1
    /* B5970 800C5170 43100200 */  sra        $v0, $v0, 1
    /* B5974 800C5174 040082A4 */  sh         $v0, 0x4($a0)
    /* B5978 800C5178 0600A290 */  lbu        $v0, 0x6($a1)
    /* B597C 800C517C 0600C390 */  lbu        $v1, 0x6($a2)
    /* B5980 800C5180 00000000 */  nop
    /* B5984 800C5184 21104300 */  addu       $v0, $v0, $v1
    /* B5988 800C5188 01004224 */  addiu      $v0, $v0, 0x1
    /* B598C 800C518C 43100200 */  sra        $v0, $v0, 1
    /* B5990 800C5190 060082A0 */  sb         $v0, 0x6($a0)
    /* B5994 800C5194 0700A290 */  lbu        $v0, 0x7($a1)
    /* B5998 800C5198 0700C390 */  lbu        $v1, 0x7($a2)
    /* B599C 800C519C 00000000 */  nop
    /* B59A0 800C51A0 21104300 */  addu       $v0, $v0, $v1
    /* B59A4 800C51A4 01004224 */  addiu      $v0, $v0, 0x1
    /* B59A8 800C51A8 43100200 */  sra        $v0, $v0, 1
    /* B59AC 800C51AC 070082A0 */  sb         $v0, 0x7($a0)
    /* B59B0 800C51B0 0C00A290 */  lbu        $v0, 0xC($a1)
    /* B59B4 800C51B4 0C00C390 */  lbu        $v1, 0xC($a2)
    /* B59B8 800C51B8 00000000 */  nop
    /* B59BC 800C51BC 21104300 */  addu       $v0, $v0, $v1
    /* B59C0 800C51C0 43100200 */  sra        $v0, $v0, 1
    /* B59C4 800C51C4 0C0082A0 */  sb         $v0, 0xC($a0)
    /* B59C8 800C51C8 0D00A290 */  lbu        $v0, 0xD($a1)
    /* B59CC 800C51CC 0D00C390 */  lbu        $v1, 0xD($a2)
    /* B59D0 800C51D0 00000000 */  nop
    /* B59D4 800C51D4 21104300 */  addu       $v0, $v0, $v1
    /* B59D8 800C51D8 43100200 */  sra        $v0, $v0, 1
    /* B59DC 800C51DC 0D0082A0 */  sb         $v0, 0xD($a0)
    /* B59E0 800C51E0 0E00A290 */  lbu        $v0, 0xE($a1)
    /* B59E4 800C51E4 0E00C390 */  lbu        $v1, 0xE($a2)
    /* B59E8 800C51E8 00000000 */  nop
    /* B59EC 800C51EC 21104300 */  addu       $v0, $v0, $v1
    /* B59F0 800C51F0 43100200 */  sra        $v0, $v0, 1
    /* B59F4 800C51F4 0800E003 */  jr         $ra
    /* B59F8 800C51F8 0E0082A0 */   sb        $v0, 0xE($a0)
endlabel DrawW_DivVertice__FP12Draw_SVertexN20
