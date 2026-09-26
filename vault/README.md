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
- **Core Plugins**: starred, page-preview, backlink, tag-pane, outgoing-links, word-count, mousewheel-zoom, editor-emoticons, local-resources, page-stats, bookmarks, file-explorer, global-search, switcher, graph, canvas, properties, daily-notes, templates, note-composer, command-palette, editor-status, outline, file-recovery, sync, bases
- **Default App**: VSCodium (`defaultSettings.app = "vscodium-fhs"`)

## Notes Directory

`vault/notes/` contains all personal and project notes.

## Integration

This vault is managed by Home Manager via `programs.obsidian.vaults.main` (`target = "Documents/dotfiles/vault"`) in `hosts/pratum/modules/home.nix`.
