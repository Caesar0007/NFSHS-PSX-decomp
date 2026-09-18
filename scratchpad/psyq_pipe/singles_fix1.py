"""Single-word honest diffs that are SOURCE defects (relocat.py 2026-09-18):
 cars     Cars_DoExtraCarCollisionProcessing: camera row = (carObj == Cars_gHumanRaceCarList[1]) (retail lw 0x8010fa4c)
 femenudefs MenuExtended_FinishedPlayer1GetName: frontEnd.playerNameList[1] (retail +0x36c), not [4]
 textpsx  inittextdraw stores the text-draw hook at currentfont+0x94 (retail 0x80135c34), not +0x148
 MSC00    the handwritten InitGeom block follows a .data definition -> explicit .text (it linked in .data)"""
R = 'C:/Temp/nfs4-decomp/recon/'


def edit(f, a, b):
    s = open(R + f, encoding='utf-8').read()
    assert s.count(a) == 1, (f, s.count(a))
    open(R + f, 'w', encoding='utf-8', newline='').write(s.replace(a, b))
    print('ok', f)


edit('game/common/cars.cpp', '                player = carObj == Cars_gHumanRaceCarList[0];',
     '                player = carObj == Cars_gHumanRaceCarList[1];   /* retail lw 0x8010fa4c: row 1 only for the SECOND human */')
edit('frontend/common/femenudefs.cpp', '        1, frontEnd.playerNameList[4]);',
     '        1, frontEnd.playerNameList[1]);   /* retail frontEnd+0x36c (same defect as feapp MainLoop) */')
edit('game/psx/textpsx.c', '  *(void **)(currentfont + 0x148) = (void *)fortext4;',
     '  *(void **)(currentfont + 0x94) = (void *)fortext4;   /* retail 0x80135c34 = currentfont+0x94 (the slot restoretextdraw clears) */')
edit('syslib/psx/libgte/MSC00.c', '__asm__(\n    "\\t.set noreorder\\n"\n    "\\t.globl InitGeom\\n"',
     '__asm__(\n    "\\t.text\\n"   /* the ra-save word above left the assembler in .data: InitGeom linked at 0x80134a74 */\n'
     '    "\\t.set noreorder\\n"\n    "\\t.globl InitGeom\\n"')
