TU = 'recon/game/psx/hud.cpp'
FNS = 'Hud_BustedOverlayOn__FiPcbs'

OLD = """    psVar3 = Hud_NextPerp + player;
    FinalBTC_Countdown = BTC_Countdown;
    sprintf(BTCPerpInfo[player][Hud_NextPerp[player]].name,name);
"""

VARIANTS = [
    ('R1 name ptr local first', [(OLD, """    pcVar1 = BTCPerpInfo[player][Hud_NextPerp[player]].name;
    psVar3 = Hud_NextPerp + player;
    FinalBTC_Countdown = BTC_Countdown;
    sprintf(pcVar1,name);
""")]),
    ('R2 int copy of player', [(OLD, """    iVar4 = player;
    psVar3 = Hud_NextPerp + iVar4;
    FinalBTC_Countdown = BTC_Countdown;
    sprintf(BTCPerpInfo[iVar4][Hud_NextPerp[iVar4]].name,name);
""")]),
    ('R3 row local first, used everywhere in the head', [(OLD, """    iVar2 = player;
    psVar3 = &Hud_NextPerp[iVar2];
    FinalBTC_Countdown = BTC_Countdown;
    sprintf(BTCPerpInfo[iVar2][*psVar3].name,name);
""")]),
    ('R4 NextPerp addr after the sprintf arg is built', [(OLD, """    FinalBTC_Countdown = BTC_Countdown;
    pcVar1 = BTCPerpInfo[player][Hud_NextPerp[player]].name;
    psVar3 = Hud_NextPerp + player;
    sprintf(pcVar1,name);
""")]),
]
