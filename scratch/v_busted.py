TU = 'recon/game/psx/hud.cpp'
FNS = 'Hud_BustedOverlayOn__FiPcbs'

OLD = """    psVar3 = Hud_NextPerp + player;
    FinalBTC_Countdown = BTC_Countdown;
    sprintf(BTCPerpInfo[player][*psVar3].name,name);
"""

VARIANTS = [
    ('P1 FinalBTC first', [(OLD, """    FinalBTC_Countdown = BTC_Countdown;
    psVar3 = Hud_NextPerp + player;
    sprintf(BTCPerpInfo[player][*psVar3].name,name);
""")]),
    ('P2 FinalBTC after sprintf', [(OLD, """    psVar3 = Hud_NextPerp + player;
    sprintf(BTCPerpInfo[player][*psVar3].name,name);
    FinalBTC_Countdown = BTC_Countdown;
""")]),
    ('P3 index via psVar3 deref hoisted', [(OLD, """    psVar3 = Hud_NextPerp + player;
    FinalBTC_Countdown = BTC_Countdown;
    sprintf(BTCPerpInfo[player][(int)*psVar3].name,name);
""")]),
    ('P4 no psVar3 for the sprintf index', [(OLD, """    psVar3 = Hud_NextPerp + player;
    FinalBTC_Countdown = BTC_Countdown;
    sprintf(BTCPerpInfo[player][Hud_NextPerp[player]].name,name);
""")]),
]
