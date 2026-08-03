TU = 'recon/game/psx/hud.cpp'
FNS = 'Hud_BustedOverlayOn__FiPcbs'

OLD = """    psVar3 = Hud_NextPerp + player;
    FinalBTC_Countdown = BTC_Countdown;
    sprintf(BTCPerpInfo[player][Hud_NextPerp[player]].name,name);
"""

VARIANTS = [
    ('Q1 FinalBTC first', [(OLD, """    FinalBTC_Countdown = BTC_Countdown;
    psVar3 = Hud_NextPerp + player;
    sprintf(BTCPerpInfo[player][Hud_NextPerp[player]].name,name);
""")]),
    ('Q2 sprintf before psVar3', [(OLD, """    FinalBTC_Countdown = BTC_Countdown;
    sprintf(BTCPerpInfo[player][Hud_NextPerp[player]].name,name);
    psVar3 = Hud_NextPerp + player;
""")]),
    ('Q3 row base local first', [(OLD, """    pcVar1 = (char *)BTCPerpInfo[player];
    psVar3 = Hud_NextPerp + player;
    FinalBTC_Countdown = BTC_Countdown;
    sprintf(((tBTCPerpInfo *)pcVar1)[Hud_NextPerp[player]].name,name);
""")]),
    ('Q4 psVar3 index in sprintf, NextPerp[] later', [(OLD, """    psVar3 = Hud_NextPerp + player;
    FinalBTC_Countdown = BTC_Countdown;
    sprintf(BTCPerpInfo[player][*psVar3].name,name);
""")]),
    ('Q5 both index reads via array', [(OLD, """    psVar3 = Hud_NextPerp + player;
    FinalBTC_Countdown = BTC_Countdown;
    sprintf(BTCPerpInfo[player][Hud_NextPerp[player]].name,name);
    iVar2 = 0;
""")]),
]
