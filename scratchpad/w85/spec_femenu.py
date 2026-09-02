A = '  __asm__("" : "=r"(volume) : "0"(volume));\n'
B = '  __asm__("" : "=r"(sound) : "0"(sound));\n'
DECL = "  int sound = 0x15;\n  int volume = 0x40;\n"

CASES = [
 ("P0 baseline", []),
 ("P1 both fences out", [(A, ""), (B, "")]),
 ("P2 volume fence out", [(A, "")]),
 ("P3 sound fence out", [(B, "")]),
 ("P4 both out, literals at the call",
  [(A, ""), (B, ""), (DECL, ""),
   ("  AudioCmn_PlayFESFXVol(sound,volume);\n", "  AudioCmn_PlayFESFXVol(0x15,0x40);\n")]),
 ("P5 both out, do{}while dials",
  [(A, ""), (B, ""), (DECL, "  int sound;\n  int volume;\n  do { volume = 0x40; } while (0);\n  do { sound = 0x15; } while (0);\n")]),
 ("P6 both out, decl order swapped",
  [(A, ""), (B, ""), (DECL, "  int volume = 0x40;\n  int sound = 0x15;\n")]),
 ("P7 both out, assignments after keyval",
  [(A, ""), (B, ""), (DECL, "  int sound;\n  int volume;\n"),
   ("  keyval = kInput_KeyType_AlreadyProcessed;\n",
    "  keyval = kInput_KeyType_AlreadyProcessed;\n  volume = 0x40;\n  sound = 0x15;\n")]),
 ("P8 both out, keyval first then decls",
  [(A, ""), (B, ""), (DECL, ""),
   ("  keyval = kInput_KeyType_AlreadyProcessed;\n",
    "  keyval = kInput_KeyType_AlreadyProcessed;\n  {\n  int volume = 0x40;\n  int sound = 0x15;\n"),
   ("  AudioCmn_PlayFESFXVol(sound,volume);\n", "  AudioCmn_PlayFESFXVol(sound,volume);\n  }\n")]),
]
