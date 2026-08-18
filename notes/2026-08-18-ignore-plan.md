# MATH201 `.gitignore` Plan

The repository publishes tracked HTML and image assets, so the ignore rules should exclude local tooling and transient build products without hiding course material.

## Keep tracked

- `docs/index.html`
- `docs/MATH_201_CH*.html`
- `docs/assets/**`
- `imgs/**`
- `src/MATH_201_CH*.jl`
- `Project.toml`
- `scripts/**`

These are source or published deliverables, not disposable build output.

## Add to `.gitignore`

```gitignore
# Operating-system and editor noise
.DS_Store
Thumbs.db
*.swp
*.swo

# Local Julia/Pluto state
.julia/
.pluto/
*.jl.cov
*.jl.*.cov
*.jl.mem

# Local logs and temporary exports
*.log
*.tmp
*.bak
*.orig

# Python helper caches, if local helpers are run
__pycache__/
*.py[cod]
.pytest_cache/

# Notebook/editor checkpoints
.ipynb_checkpoints/
```

## Do not ignore globally

- `Manifest.toml`: decide per environment. If reproducible Julia exports are important, commit it; otherwise retain the existing ignore rule.
- `docs/`: the static site is intentionally versioned.
- `refs/`: archived notebooks, syllabi, and references are deliberate project inputs.
- `.vscode/`: keep the existing shared settings file; ignore only machine-specific additions if they appear.
- MP4 animation artifacts were removed with their generators; no animation-specific ignore rule is needed.

## Recommended implementation

The OS/editor, local Julia state, logs, and cache rules have been added. Docker and animation artifacts were retired rather than ignored. `Manifest.toml` remains a separate policy decision.
