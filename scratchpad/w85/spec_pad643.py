A_OLD = r"""      { int acc = player << 0x1e;
        __asm__("" : : "i"(0) : "$2","$3");
        return (acc |
                (0x7f - (byte)frontEnd.J1MIN[player]) * 0x10000 |
                (0x7f - (byte)frontEnd.J2MAX[player]) * 0x100) | 1; }"""

B_OLD = r"""      { int acc = player << 0x1e;
        __asm__("" : : "i"(0) : "$2","$3");
        return (acc |
                (0x7f - (byte)frontEnd.deadSpot[player]) * 0x10000 |
                (0x7f - (byte)frontEnd.steeringRange[player]) * 0x100) | 1; }"""

OLD = A_OLD  # sweep replaces arm A only; arm B is handled by the paired spec


def pair(a, b):
    """not used by S3_sweep (single-site); kept for reference"""
    return a, b


VARIANTS = [
 ("A0 baseline", A_OLD),
]
