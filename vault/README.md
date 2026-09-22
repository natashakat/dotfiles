# Obsidian Vault

This is an Obsidian vault for personal notes and project documentation.

## Structure

```
vault/
├── .obsidian/         # Obsidian configuration
│   ├── app.json       # App settings
│   ├── appearance.json # Theme settings
│   └── core-plugins.json # Enabled core plugins
├── notes/             # Note files
└── README.md          # This file
```

## Configuration

- **Theme**: Dark
- **Core Plugins**: backlink, page-preview, tag-pane, graph, daily-notes, editor-status, file-explorer, word-count, outline
- **Default App**: VSCodium

## Notes Directory

`vault/notes/` contains all personal and project notes.

## Integration

This vault is managed by Home Manager via `programs.obsidian.vaults.main`.
