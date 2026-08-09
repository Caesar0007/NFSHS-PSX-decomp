#!/usr/bin/env python3
"""EXTC sweep: give MCRD_getcard/MCRD_handlecardevents/textpixels extern "C"
typed decls everywhere (defs are C-linkage: mcrd.cpp extern"C" / textpix.c).
Binary-safe (CRLF preserved): operate on bytes, replace exact byte spans."""
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

# (file, old_bytes, new_bytes) -- exact, all unique in-file
EDITS = [
    ("recon/frontend/common/feapp_externs.h",
     b'int  textpixels(char *);', b'extern "C" int textpixels(char *);'),
    ("recon/frontend/common/fecredits_externs.h",
     b'int   textpixels(char*);', b'extern "C" int textpixels(char*);'),
    ("recon/frontend/common/femenuextended_externs.h",
     b'int textpixels(char*);', b'extern "C" int textpixels(char*);'),
    ("recon/frontend/common/femenuoptions_externs.h",
     b'int textpixels(char*);', b'extern "C" int textpixels(char*);'),
    ("recon/frontend/common/fescreen_externs.h",
     b'int   textpixels(char*);', b'extern "C" int textpixels(char*);'),
    ("recon/frontend/common/fetextrender_externs.h",
     b'int   textpixels(char *s);', b'extern "C" int textpixels(char *s);'),
    ("recon/frontend/common/screenaudio_externs.h",
     b'int  textpixels(char *str);', b'extern "C" int textpixels(char *str);'),
    ("recon/frontend/common/screencontroller_externs.h",
     b'int  textpixels(char *str);', b'extern "C" int textpixels(char *str);'),
    ("recon/frontend/common/screendisplay_externs.h",
     b'int  textpixels(char *str);', b'extern "C" int textpixels(char *str);'),
    ("recon/frontend/common/screentrackrecords_externs.h",
     b'int  textpixels(char *str);', b'extern "C" int textpixels(char *str);'),
    ("recon/game/common/copspeak_externs.h",
     b'extern int   textpixels(char *s);', b'extern "C" int textpixels(char *s);'),
    ("recon/game/common/pausemenu_externs.h",
     b'extern int   textpixels(char *s);', b'extern "C" int textpixels(char *s);'),
    ("recon/game/psx/hud_externs.h",
     b'extern int   textpixels(char *s);', b'extern "C" int textpixels(char *s);'),
    ("recon/game/psx/overlays_externs.h",
     b'extern int   textpixels(char *s);', b'extern "C" int textpixels(char *s);'),
    ("recon/frontend/common/fememcard_externs.h",
     b'int   MCRD_handlecardevents(int);', b'extern "C" int MCRD_handlecardevents(int);'),
    ("recon/frontend/common/fememcard_externs.h",
     b'CARDINFO_def *MCRD_getcard(int);', b'extern "C" CARDINFO_def *MCRD_getcard(int);'),
    ("recon/frontend/common/screenmemcard_externs.h",
     b'int MCRD_handlecardevents(int card);', b'extern "C" int MCRD_handlecardevents(int card);'),
    ("recon/frontend/common/screenmemcard_externs.h",
     b'CARDINFO_def * MCRD_getcard(int card);', b'extern "C" CARDINFO_def *MCRD_getcard(int card);'),
]
for h in ("aih_btccop", "aih_btcperp", "aih_cop", "aiinit", "aispeeds",
          "aitriger", "audioclc", "audiocmn", "camera", "cars"):
    EDITS.append((f"recon/game/common/{h}_externs.h",
                  b'CARDINFO_def *MCRD_getcard(...);',
                  b'extern "C" CARDINFO_def *MCRD_getcard(int);'))

fail = 0
for rel, old, new in EDITS:
    p = ROOT / rel
    data = p.read_bytes()
    n = data.count(old)
    if n != 1:
        print(f"SKIP {rel}: pattern count={n}")
        fail += 1
        continue
    p.write_bytes(data.replace(old, new))
    print(f"OK   {rel}")
sys.exit(1 if fail else 0)
