"""Pure source/command selection for the full-debug measurement lane.

2026-10-15: default scope stays game/frontend; explicit requests may select
main-tree C library sources too. No source or generated assembly is rewritten.
"""
from pathlib import Path


def select_debug_sources(root, fragments):
    root = Path(root)
    recon = root/'recon'
    bases = [recon] if fragments else [recon/'game', recon/'frontend']
    candidates = sorted({path for base in bases for path in base.rglob('*.c*')
        if path.suffix in ('.c', '.cpp') and
        path.relative_to(recon).parts[0] not in ('mod', 'game-mod', 'syslib-mod') and
        'tests' not in path.relative_to(recon).parts[:-1]})
    if not fragments:
        return candidates
    selected = set()
    for fragment in fragments:
        needle = fragment.replace('\\', '/').strip()
        hits = [path for path in candidates if needle and
                (needle in path.relative_to(root).as_posix() or needle in path.as_posix())]
        if not hits:
            raise ValueError('No reconstruction source matches: '+fragment)
        selected.update(hits)
    return sorted(selected)


def full_debug_command(command):
    """Request full debug on the real compiler input, never patch its output."""
    command = list(command)
    executable = str(command[0]).replace('\\', '/').rsplit('/', 1)[-1].upper()
    if not executable.startswith('CC1'):
        return command
    command = [command[0], *['-g' if str(flag) in ('-g0', '-g1') else flag
                            for flag in command[1:]]]
    if not any(str(flag) in ('-g', '-g2', '-g3') for flag in command[1:]):
        command.insert(1, '-g')
    return command
