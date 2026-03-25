#!/usr/bin/env python3
import argparse
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
TASKS_IN = ROOT / "tasks" / "incoming"
TASKS_ACTIVE = ROOT / "tasks" / "active"


def bootstrap_task(task_file: Path):
    data = json.loads(task_file.read_text(encoding="utf-8"))
    data.setdefault("state", "NEW")
    out = TASKS_ACTIVE / task_file.name
    out.write_text(json.dumps(data, ensure_ascii=False, indent=2), encoding="utf-8")
    return out


def main():
    parser = argparse.ArgumentParser(description="Supervisor entrypoint (skeleton)")
    parser.add_argument("--ingest", type=str, help="Path to task json in tasks/incoming")
    args = parser.parse_args()

    if args.ingest:
        p = Path(args.ingest)
        out = bootstrap_task(p)
        print(f"[ok] ingested -> {out}")
    else:
        print("[todo] implement router/state machine loop")


if __name__ == "__main__":
    main()
