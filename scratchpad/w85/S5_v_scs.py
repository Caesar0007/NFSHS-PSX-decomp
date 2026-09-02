OLD = '      FETextRender_MenuTextPositionedJustify\n                (*(volatile int *)&menuDefs->menuCarUpgrades.fCurrentItem + 0x96,\n                 pos.x + (pos.w >> 1),pos.y + 0x18,2,\n                 textState_Hilighted,textType_FramedInfo);'
VARIANTS = [
  ('C1 plain int cast', OLD, '      FETextRender_MenuTextPositionedJustify\n                (*(int *)&menuDefs->menuCarUpgrades.fCurrentItem + 0x96,\n                 pos.x + (pos.w >> 1),pos.y + 0x18,2,\n                 textState_Hilighted,textType_FramedInfo);'),
  ('C2 int local', OLD, '      {\n        int curItem = menuDefs->menuCarUpgrades.fCurrentItem;\n\n        FETextRender_MenuTextPositionedJustify\n                  (curItem + 0x96,\n                   pos.x + (pos.w >> 1),pos.y + 0x18,2,\n                   textState_Hilighted,textType_FramedInfo);\n      }'),
  ('C3 direct field', OLD, '      FETextRender_MenuTextPositionedJustify\n                (menuDefs->menuCarUpgrades.fCurrentItem + 0x96,\n                 pos.x + (pos.w >> 1),pos.y + 0x18,2,\n                 textState_Hilighted,textType_FramedInfo);'),
]
