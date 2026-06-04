# Future Integration: git-agent-codespace

## Current State
A one-click development environment template for git-agent runtimes. Provides Python 3.12, Go 1.24, Node.js 22, auto-clones core repos (flux-runtime, greenhorn-runtime, iron-to-iron, fleet-discovery, oracle1-vessel), and configures VS Code extensions. The Ensign factory.

## Integration Opportunities

### With room-as-codespace Ensign pattern
git-agent-codespace IS the Ensign factory template. When a room needs a specialist ensign, it instantiates a Codespace from this template with room-specific configurations. The setup.sh post-create script installs the room's required skills, clones the room's domain crates, and boots the ensign. The Ensign pattern (load on enter, unload on exit) maps to Codespace lifecycle: create on room-enter, suspend on room-exit.

### With construct-coordination
The auto-cloned repos represent the agent's base knowledge. With construct-coordination's I2I protocol, the Codespace can discover additional repos based on the room's needs — not just the pre-configured set, but any fleet repo that the room's ensign requires.

### With agent-template
git-agent-codespace provides the Codespace infrastructure; agent-template provides the agent structure. Together: fork agent-template for identity, create Codespace from git-agent-codespace for environment, and you have a fully operational fleet member in 2-3 minutes.

## Dormant Ideas Now Unlockable
The template was fixed — always the same repos, always the same tools. Now with construct-core's dynamic skill loading and ternary-registry's capability discovery, the template can be parameterized: different rooms get different repos, different tools, different ensign configurations.

## Potential in Mature Systems
Every new fleet member starts here. Click "Use this template" → select room type → Codespace boots with the right tools, right repos, right ensign. From zero to operational in 3 minutes. This is the fleet's factory floor.

## Cross-Pollination Ideas
- **codespace-edge-rd**: Yoke-out from this Codespace to edge hardware
- **oracle1-vessel**: Oracle1 manages which Codespaces are running
- **forgemaster**: GPU Codespace variant with CUDA toolchain pre-installed

## Dependencies for Next Steps
- Parameterized setup.sh based on room type
- construct-core skill discovery integration
- Ensign lifecycle management (create/suspend/resume)
