import pathlib

OLD = ('          if ((Replay_ReplayMode != 2) ||\n'
       '              (Replay_ReplayInterface.speed == 2) ||\n'
       '              ((Replay_ReplayInterface.speed == one) &&\n'
       '               ((simVar.currentClockTicks & 1U) == 0)) ||\n'
       '              ((Replay_ReplayInterface.speed == 0) &&\n'
       '               ((simVar.currentClockTicks & 3U) == 0)))\n'
       '            goto SimMainLoop_processSchedules;\n')

SW_OLD = '          switch (*(volatile int *)&Replay_ReplayInterface.speed) {\n'
SW_PLAIN = '          switch (Replay_ReplayInterface.speed) {\n'

INV = ('          if (!((Replay_ReplayMode != 2) ||\n'
       '              (Replay_ReplayInterface.speed == 2) ||\n'
       '              ((Replay_ReplayInterface.speed == one) &&\n'
       '               ((simVar.currentClockTicks & 1U) == 0)) ||\n'
       '              ((Replay_ReplayInterface.speed == 0) &&\n'
       '               ((simVar.currentClockTicks & 3U) == 0))))\n'
       '            goto SimMainLoop_doSwitch;\n'
       '          goto SimMainLoop_processSchedules;\n'
       '          SimMainLoop_doSwitch:;\n')

ABSORB = ('          one = (u_long)((unsigned int)one | ((unsigned int)one & 3u));\n')

variants = [
    ('plain read (control)', [(SW_OLD, SW_PLAIN)]),
    ('plain + inverted guard w/ explicit switch label',
     [(OLD, INV), (SW_OLD, SW_PLAIN)]),
    ('plain + absorption on `one` before the switch',
     [(SW_OLD, ABSORB + SW_PLAIN)]),
    ('volatile kept + inverted guard', [(OLD, INV)]),
]
pathlib.Path('scratchpad/w86/D2_s1.txt').write_text(repr(variants))
print(len(variants))
