BLK = """  int sound = 0x15;
  int volume = 0x40;
  __asm__("" : "=r"(volume) : "0"(volume));
  __asm__("" : "=r"(sound) : "0"(sound));
  keyval = kInput_KeyType_AlreadyProcessed;
  AudioCmn_PlayFESFXVol(sound,volume);
"""

CASES = [
 ("Q0 baseline", []),
 ("Q1 no device, keyval store between the two decls",
  [(BLK, "  int sound = 0x15;\n  keyval = kInput_KeyType_AlreadyProcessed;\n  int volume = 0x40;\n  AudioCmn_PlayFESFXVol(sound,volume);\n")]),
 ("Q2 no device, keyval store first",
  [(BLK, "  keyval = kInput_KeyType_AlreadyProcessed;\n  {\n    int sound = 0x15;\n    int volume = 0x40;\n    AudioCmn_PlayFESFXVol(sound,volume);\n  }\n")]),
 ("Q3 no device, do{}while dial on keyval store",
  [(BLK, "  int sound = 0x15;\n  int volume = 0x40;\n  do { keyval = kInput_KeyType_AlreadyProcessed; } while (0);\n  AudioCmn_PlayFESFXVol(sound,volume);\n")]),
 ("Q4 no device, dial on both decls",
  [(BLK, "  int sound;\n  int volume;\n  do { volume = 0x40; sound = 0x15; } while (0);\n  keyval = kInput_KeyType_AlreadyProcessed;\n  AudioCmn_PlayFESFXVol(sound,volume);\n")]),
 ("Q5 no device, volume decl first",
  [(BLK, "  int volume = 0x40;\n  int sound = 0x15;\n  keyval = kInput_KeyType_AlreadyProcessed;\n  AudioCmn_PlayFESFXVol(sound,volume);\n")]),
 ("Q6 no device, keyval via a carrier",
  [(BLK, "  int sound = 0x15;\n  int volume = 0x40;\n  int kv = kInput_KeyType_AlreadyProcessed;\n  keyval = (tInputKeyType)kv;\n  AudioCmn_PlayFESFXVol(sound,volume);\n")]),
 ("Q7 no device, args as literals + keyval carrier",
  [(BLK, "  {\n    int kv = kInput_KeyType_AlreadyProcessed;\n    keyval = (tInputKeyType)kv;\n  }\n  AudioCmn_PlayFESFXVol(0x15,0x40);\n")]),
 ("Q8 no device, dial around the whole tail",
  [(BLK, "  do {\n    int sound = 0x15;\n    int volume = 0x40;\n    keyval = kInput_KeyType_AlreadyProcessed;\n    AudioCmn_PlayFESFXVol(sound,volume);\n  } while (0);\n")]),
]
