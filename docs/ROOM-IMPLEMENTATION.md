# Room Implementation: Git Agent Codespace

How `git-agent-codespace` uses the ternary-room trait for codespace-backed agent rooms.

## Room Configuration

```rust
use ternary_room::{Room, RoomBuilder, Door, DoorAccess};
use ternary_cell::CellGrid;

let agent_room = RoomBuilder::new("git-agent-workspace")
    .env("tier", "codespace")
    .env("backend", "codespace")
    .env("inference", "proxy")         // LLM via PLATO proxy
    .env("repo", "owner/repo-name")    // The git repo this room manages
    .initial_agent(captain_agent_id)
    .build();
```

## Codespace Room Characteristics

| Property | Value | Why |
|---|---|---|
| Tier | `codespace` | Full compute environment |
| Backend | `codespace` | Cloud-hosted, on-demand |
| Doors | `Open` | Bi-directional coordination with other rooms |
| Ensigns | Dynamic | Load/unload specialists as tasks require |
| Cell grid | Large | Plenty of memory — 1000+ cells |
| Tick rate | Heartbeat | One tick per heartbeat cycle (seconds, not ms) |

## The Codespace Room Lifecycle

1. **Birth**: Room created from repo template (the "room template" IS the repo)
2. **Hydrate**: Load repo state → agent struct, ensign registry, cell grid
3. **Live**: Heartbeat-driven tick cycles — read state, reason, act, commit
4. **Equip**: Load specialist ensigns for current task via `EnsignFactory`
5. **Coordinate**: Open doors to other rooms for fleet communication
6. **Sleep**: Suspend when idle; state persisted as git commits
7. **Wake**: Resume from last commit — the room IS its state

## Door Configuration for Fleet Coordination

```rust
// Open door to Oracle1's lobby room
let lobby_door = Door::new("git-agent-workspace", "oracle1-lobby")
    .access(DoorAccess::Open);

// One-way door to edge rooms — push knowledge, don't accept commands
let edge_door = Door::new("git-agent-workspace", "engine-monitor")
    .access(DoorAccess::OneWay("git-agent-workspace", "engine-monitor"));

// Locked door to other agents' private rooms
let private_door = Door::new("git-agent-workspace", "other-agent-private")
    .access(DoorAccess::Locked);
```

## Cell Grid for Task Management

```
┌──────────────────────────────────────────┐
│  CellGrid (git-agent-workspace)          │
│                                          │
│  ┌──────────┐  ┌──────────┐             │
│  │ Cell 0   │  │ Cell 1   │             │
│  │ Issue    │  │ PR       │             │
│  │ Triage   │  │ Review   │             │
│  └────┬─────┘  └────┬─────┘             │
│       │              │                   │
│       ▼              ▼                   │
│  ┌──────────────────────────┐           │
│  │  Cell 2                  │           │
│  │  Decision Engine         │           │
│  │  (quorum voting)         │           │
│  └────────────┬─────────────┘           │
│               │                          │
│       ┌───────┴───────┐                 │
│       ▼               ▼                 │
│  ┌──────────┐  ┌──────────┐             │
│  │ Cell 3   │  │ Cell 4   │             │
│  │ Delegator│  │ Logger   │             │
│  │ (assign) │  │ (commit) │             │
│  └──────────┘  └──────────┘             │
└──────────────────────────────────────────┘
```

## Heartbeat Tick Cycle

Each heartbeat = one `CellGrid::tick_all()`:

| Phase | Cell Action | Git Equivalent |
|---|---|---|
| Predict | What issues/PRs do I expect? | `git status` |
| Perceive | What's actually in the repo? | `git pull` + parse issues |
| Surprise | Delta between expected and actual | Diff analysis |
| Vibe | Update internal state based on surprise | Decision engine votes |
| GC | Clean up completed tasks | Close issues, merge PRs |
| Conservation | Energy check — should I keep running? | Resource limit check |

## Room History as Git Log

```rust
// Every room event becomes a commit
room.history().events().for_each(|event| {
    // event.tick, event.agent_id, event.kind, event.detail
    // → structured commit message
});
```

The room's `RoomHistory` IS the git log. Every agent enter/leave, every task assignment, every decision — all recorded and queryable. This is capitaine-1's "transparent memory" made concrete.

---

*Room implementation for git-agent-codespace, 2026-06-04*
