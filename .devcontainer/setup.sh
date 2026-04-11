#!/bin/bash
set -e
echo "🚀 Setting up Git-Agent Runtime environment..."

# Install FLUX tools
pip install pytest 2>/dev/null

# Clone core repos
REPOS=(
  "SuperInstance/flux-runtime"
  "SuperInstance/oracle1-vessel"
  "SuperInstance/iron-to-iron"
  "SuperInstance/greenhorn-runtime"
  "SuperInstance/git-agent-standard"
  "SuperInstance/fleet-discovery"
)

for repo in "${REPOS[@]}"; do
  name=$(basename "$repo")
  if [ ! -d "$name" ]; then
    echo "Cloning $repo..."
    git clone "https://github.com/$repo.git" "$name" 2>/dev/null || echo "  (skipped)"
  fi
done

# Verify Python FLUX runtime
if [ -d "flux-runtime" ]; then
  cd flux-runtime
  PYTHONPATH=src python3 -m pytest tests/ -q --tb=no 2>/dev/null | tail -3
  cd ..
fi

echo "✅ Git-Agent Runtime ready!"
echo ""
echo "Quick start:"
echo "  cd flux-runtime && PYTHONPATH=src python3 -c 'from flux.vm.interpreter import FluxInterpreter; print(\"FLUX OK\")'"
echo "  cd greenhorn-runtime/go && go test ./pkg/flux/"
echo "  cd fleet-discovery && python3 -m pytest discovery.py -v"
