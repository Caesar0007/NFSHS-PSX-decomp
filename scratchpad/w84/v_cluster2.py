BASE = """    flash = 0;
    Quick_DD(1, 1, 1);
    settrans(0);
    shapeBase = shapes;
    movfxya(shapes[0], flash, flash);
    key = 0;"""

VARIANTS = [
    ('1 between settrans/movfxya (cur)', BASE),
    ('2 after movfxya', """    flash = 0;
    Quick_DD(1, 1, 1);
    settrans(0);
    movfxya(shapes[0], flash, flash);
    shapeBase = shapes;
    key = 0;"""),
    ('3 before settrans', """    flash = 0;
    Quick_DD(1, 1, 1);
    shapeBase = shapes;
    settrans(0);
    movfxya(shapes[0], flash, flash);
    key = 0;"""),
    ('4 before Quick_DD', """    flash = 0;
    shapeBase = shapes;
    Quick_DD(1, 1, 1);
    settrans(0);
    movfxya(shapes[0], flash, flash);
    key = 0;"""),
    ('5 after key=0', """    flash = 0;
    Quick_DD(1, 1, 1);
    settrans(0);
    movfxya(shapes[0], flash, flash);
    key = 0;
    shapeBase = shapes;"""),
    ('6 addr-of-elem', """    flash = 0;
    Quick_DD(1, 1, 1);
    settrans(0);
    shapeBase = &shapes[0];
    movfxya(shapes[0], flash, flash);
    key = 0;"""),
    ('7 movfxya via shapeBase[0] after set', """    flash = 0;
    Quick_DD(1, 1, 1);
    settrans(0);
    movfxya(shapes[0], flash, flash);
    key = 0;
    shapeBase = shapes;
    goto language_frame_top;
language_frame_top:;"""),
]
