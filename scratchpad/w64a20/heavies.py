#!/usr/bin/env python3
"""w64-a20 mission 3: re-price the SHIM-MASKED rows on the production lane WITH
their build.py per-fn mechanism applied (via the new W64_PQ_TEXT_MOVES_FILE
hook) vs WITHOUT it.

WHY THIS IS THE RIGHT MEASUREMENT: the W63 ledger's residual for a shim-masked
row is psyqproof's raw number, taken with NO mechanism applied.  One displaced
instruction shifts every following word, so a ONE-LINE relocation reads as
hundreds of "diffs".  Applying the mechanism separates
    (a) rows whose entire residual IS the relocation      -> REAL goes to 0
    (b) rows with a genuine production divergence on top   -> REAL stays > 0
which is the honest gate<->production distance the ledger wants.
"""
import json
import os
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
PY = sys.executable
EMPTY = ROOT / "scratchpad" / "w64a20" / "moves_probe.json"

ROWS = [
    ("recon/game/psx/draww.cpp", "DrawW_DrawQuad__FP25Draw_tGiveShelbyMoreCacheP8Trk_Quad"),
    ("recon/game/psx/psxcontroller.cpp", "InGame_ResetPSXController__Fii"),
    ("recon/game/common/audiocmn.cpp", "AudioCmn_SoundCar__FP8Car_tObjiiiiiii"),
    ("recon/game/psx/draww.cpp", "DrawObjectSimple__FP13DRender_tViewP11Draw_DCacheP13Trk_ObjectDefP8coorddefi"),
    ("recon/game/common/camera.cpp", "Camera_UpdateTailCam__Fii"),
    ("recon/frontend/common/femenudefs.cpp", "MenuExtended_GoToTwoPlayerSingleRace__FR12tMenuCommand"),
    ("recon/game/psx/flare.cpp", "Flare_LensFlare__FP7DVECTORP15Draw_FlareCache"),
    ("recon/frontend/common/screencongrats.cpp", "CalculatePrizes__15tScreenCongrats"),
    ("recon/eaclib/psx/eacpsxz/unref.c", "unrefpack"),
    ("recon/frontend/common/fescreen.cpp", "GoNonInterlaced__7tScreen"),
    ("recon/game/common/audioeng.cpp", "AudioEng_Set__Fiiiiiiii"),
    ("recon/frontend/common/screentracks.cpp", "DrawBackground__18tScreenTrackSelect"),
    ("recon/game/common/speech.cpp", "Status__Q26Speech13MobileSpeaker"),
    ("recon/eaclib/psx/eacpsxz/trnsmult.c", "transmult"),
    ("recon/eaclib/psx/eacpsxz/vramfxya.c", "vramfxya"),
    ("recon/game/psx/drawc.cpp", "DrawC_NightHeadlight__FP8Car_tObj"),
    ("recon/game/common/speech.cpp", "LoadBankHeaders__6SpeechPcPQ26Speech11CarBankNamell"),
    ("recon/frontend/common/fefades.cpp", "CalcOnOffFade__F13tMenuTextTypesssRiT4"),
    ("recon/frontend/common/femenudefs.cpp", "MenuExtended_GoToDealer__FR12tMenuCommand"),
    ("recon/frontend/common/femenudefs.cpp", "MenuExtended_GoToSeller__FR12tMenuCommand"),
    ("recon/game/common/physics.cpp", "Physics_DoBarrierCheck__FP8Car_tObj"),
    ("recon/eaclib/psx/spchpsxz/spchpick.c", "iSPCH_ConstantRuleSet"),
    ("recon/frontend/common/femenudefs.cpp", "MenuExtended_GoToTournTrackInfo__FR12tMenuCommand"),
    ("recon/frontend/common/femenudefs.cpp", "MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand"),
    ("recon/frontend/common/femenuextended.cpp", "MenuNFS4_DrawTextBox__FiR4RECTissbT5"),
    ("recon/game/common/speech.cpp", "Roger__Q26Speech13MobileSpeaker"),
    ("recon/game/psx/flare.cpp", "Flare_2DHalo__Fiiiii"),
    ("recon/eaclib/psx/eacpsxz/nfile.c", "iFILE_ExecCommand"),
    ("recon/eaclib/psx/spchpsxz/spchinit.c", "SPCH_Init"),
    ("recon/frontend/common/femenudefs.cpp", "MenuExtended_SellCar__FR12tMenuCommand"),
    ("recon/game/common/aistate.cpp", "___17AIState_Purgatory"),
    ("recon/game/common/speech.cpp", "CheckLocationBank__6SpeechPQ26Speech12LocationBankPci"),
    ("recon/frontend/common/femenudefs.cpp", "MenuExtended_PurchaseUpgrade__Fi"),
]

RE = re.compile(r"REAL=(\d+) RELOP=(\d+) reloc-site diffs=(\d+)")


def run(tu, fn, moves):
    env = dict(os.environ)
    if moves:
        env["W64_PQ_TEXT_MOVES_FILE"] = str(EMPTY)
    else:
        env.pop("W64_PQ_TEXT_MOVES_FILE", None)
    r = subprocess.run([PY, str(ROOT / "tools" / "psyqproof.py"), tu, fn],
                       capture_output=True, text=True, cwd=ROOT, env=env)
    m = RE.search(r.stdout + r.stderr)
    if m:
        return int(m.group(1)), int(m.group(2))
    return None


def main():
    if not EMPTY.exists():
        EMPTY.write_text("{}")
    print(f"{'fn':<62}{'no-mech':>10}{'with-mech':>11}  verdict")
    out = []
    for tu, fn in ROWS:
        a = run(tu, fn, False)
        b = run(tu, fn, True)
        sa = "n/a" if a is None else f"{a[0]}+{a[1]}"
        sb = "n/a" if b is None else f"{b[0]}+{b[1]}"
        if b is not None and b[0] + b[1] == 0:
            v = "MECHANISM ACCOUNTS FOR ALL OF IT"
        elif a is not None and b is not None and sum(b) < sum(a):
            v = f"mechanism explains {sum(a)-sum(b)}; {sum(b)} genuine"
        elif a is None or b is None:
            v = "measurement failed"
        else:
            v = "NOT the mechanism -- genuine production divergence"
        print(f"{fn[:60]:<62}{sa:>10}{sb:>11}  {v}")
        out.append({"tu": tu, "fn": fn, "no_mech": a, "with_mech": b, "verdict": v})
        sys.stdout.flush()
    (ROOT / "scratchpad" / "w64a20" / "heavies.json").write_text(json.dumps(out, indent=1))


if __name__ == "__main__":
    main()
