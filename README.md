# Git-Agent Codespace

A **one-click development environment template** for Git-Agent runtimes — providing a pre-configured Codespace with multi-language toolchains (Python 3.12, Go 1.24, Node.js 22), auto-cloned core repositories, and the FLUX VM tested and operational on creation.

## Why It Matters

Onboarding a new agent (a "greenhorn") to the Git-Agent ecosystem requires a consistent, reproducible environment across Python, Go, and Node.js runtimes. Manual setup takes 30–60 minutes and is error-prone: missing dependencies, wrong language versions, unlinked repositories. This Codespace template encodes the entire setup as a `devcontainer.json` configuration with a post-create script that clones required repos (flux-runtime, greenhorn-runtime, iron-to-iron, fleet-discovery), verifies the FLUX VM, and installs VS Code extensions. A new agent forks the template, clicks "Open in Codespace," and has a working development environment in 2–3 minutes.

## How It Works

**Codespace templates** leverage GitHub's `devcontainer.json` specification to define container environments. The setup process:

1. **Container build**: Docker image with base toolchains (Python, Go, Node.js) is pulled or built.
2. **Post-create lifecycle hook** (`setup.sh`): Runs after container creation. Clones core repositories into the workspace:
   ```
   git clone https://github.com/SuperInstance/flux-runtime.git
   git clone https://github.com/SuperInstance/greenhorn-runtime.git
   git clone https://github.com/SuperInstance/iron-to-iron.git
   git clone https://github.com/SuperInstance/fleet-discovery.git
   ```
3. **FLUX VM verification**: The setup script runs a smoke test on the FLUX virtual machine to ensure the agent runtime is operational.
4. **VS Code extensions**: Auto-installs language servers, debuggers, and formatter extensions for all three languages.

**Repository structure**:
```
.devcontainer/
├── devcontainer.json    # Container spec: image, features, extensions
└── setup.sh             # Post-create: clone, verify, configure
```

The template is itself a **vessel** in the fleet taxonomy — a structural repo whose purpose is to host other repos.

## Quick Start

1. Click **"Use this template"** → **"Open in Codespace"** on GitHub
2. Wait 2–3 minutes for setup completion
3. Verify: `python3 -c "import flux; print('FLUX OK')"`
4. Start building

## API

| Component | Description |
|-----------|-------------|
| `devcontainer.json` | Container configuration (image, features, VS Code extensions) |
| `setup.sh` | Post-create lifecycle hook (clones repos, verifies FLUX VM) |
| `AGENT.md` | Agent identity and duty log for this vessel |
| `CHARTER.md` | Mission statement, type (vessel), fleet integration status |

## Architecture Notes

Git-Agent Codespace is the **onboarding vessel** of the Git-Agent Standard v2.0. New agents (greenhorns) fork this template to bootstrap their environment. It implements the I2I (iron-to-iron) communication protocol and integrates with fleet discovery. The template itself is a static artifact — it doesn't execute, it *contains*. In the **γ + η = C** conservation law, this template compresses onboarding overhead (γ) into a reproducible artifact (η). See [Architecture](https://github.com/SuperInstance/SuperInstance/blob/main/ARCHITECTURE.md).

**Fleet neighbors**: The Codespace template connects to other vessels in the fleet taxonomy — `tminus-dispatcher` (temporal heartbeat), `fleet-bridge` (A2A transport), `symphony-runtime` (grammar conductor), `composite-headspace` (dual-shell mediator), and `i2i-bottle-agent` (bottle postmaster). Each vessel has a designated role in the Git-Agent Standard v2.0.

**The template IS the dojo**: New agents (greenhorns) fork this template as their first action, inheriting a working environment, the fleet discovery protocol, and I2I communication tools. The Codespace itself serves as the agent's training ground.

## References

- GitHub Codespaces Documentation: Development Container specification. https://docs.github.com/codespaces
- VS Code Dev Containers Spec: https://containers.dev/
- The Twelve-Factor App: Disposability and Reproducibility. https://12factor.net/disposability
- Kim, G. et al. *The DevOps Handbook*, 2nd ed., IT Revolution (2021). — Infrastructure as Code.

## License

MIT
