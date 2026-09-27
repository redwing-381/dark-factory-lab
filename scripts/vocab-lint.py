"""Mandate lint: the harness's own gate-1/gate-4 mandate scan, plus a stricter scan.

Strict mode flags every identifier-shaped token (paths, snake_case, kebab-case), not just the
ones on the organizers' list: a generic mandate has no reason to contain any of them.
Usage: python scripts/vocab-lint.py [mandates-dir] [track]
"""
import pathlib
import sys
import tempfile

KIT = pathlib.Path.home() / "dark-factory" / "dark-factory-wearedevs"
sys.path.insert(0, str(KIT))
from harness import check, vocabulary  # noqa: E402

folder = pathlib.Path(sys.argv[1] if len(sys.argv) > 1 else "mandates").resolve()
track = sys.argv[2] if len(sys.argv) > 2 else "tablekeeper"
files = sorted(folder.glob("*.md"))

with tempfile.TemporaryDirectory() as tmp:
    root = pathlib.Path(tmp)
    (root / "mandates").mkdir()
    for f in files:
        (root / "mandates" / f.name).write_text(f.read_text())
    official = check._mandates(root, track)

strict = []
for f in files:
    for n, line in enumerate(f.read_text().splitlines(), 1):
        for kind, term in vocabulary.terms_in(line):
            strict.append(f"warn (not banned, review): {f.name}:{n} {kind} `{term}`")

# Skills are standing instructions too: hold them to the organizers' banned list.
skills_dir = folder.parent / "skills"
distinctive = set(vocabulary.for_track(track))
for f in sorted(skills_dir.glob("*/SKILL.md")):
    for n, line in enumerate(f.read_text().splitlines(), 1):
        for kind, term in vocabulary.terms_in(line):
            if term in distinctive:
                official.append(f"skill {f.parent.name}:{n} names the {track} {kind} `{term}`")

print(f"{len(files)} mandate(s) in {folder}; skills scanned in {skills_dir}")
for p in official:
    print("OFFICIAL", p)
for p in strict:
    print(p)
if not official and not strict:
    print("ok — no official or strict findings")
sys.exit(1 if official else 0)
