# Disabled `CV_ColorTracks` post-compile rule

User policy on 2026-08-23 forbids post-recompile instruction rewrites.  Before
removal, `tools/build.py` contained this entry:

```python
PER_FN_RA_SINK = {
    "recon/game/psx/textureprocess.cpp": {
        "CV_ColorTracks__Fiii",   # FAIL 2 (130/130) -> PASS per the a6 receipt
    },
}
```

The generic mechanism is retained for historical users, but textureprocess is
removed from its table.  `CV_ColorTracks` must reach PASS through reconstructed
source/compiler inputs only.
