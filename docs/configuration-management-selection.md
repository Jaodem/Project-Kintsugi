# Configuration Management Selection

## Objective

The objective of this document is to evaluate and select a strategy for managing dotfiles and system configurations for Project Kintsugi.

## Requirements

The selected strategy must align with the project's engineering principles:
* It must not introduce unnecessary abstraction layers.
* It must not require background daemons.
* It must support standard version control (Git).
* It must keep the live system configuration synchronized with the repository without requiring manual file copying.

## Candidates

### 1. Bare Git Repository
A technique using a Git repository initialized directly in the `$HOME` directory, using a distinct Git directory and working tree to track `.config` files.
* **Pros:** Uses Git natively; no additional tools required.
* **Cons:** Can make the entire home directory behave as a Git repository, increasing the risk of accidentally committing unintended personal files; requires a specific alias for interaction.

### 2. GNU Stow
A symlink farm manager that mirrors a target directory structure using native UNIX symbolic links.
* **Pros:** Purely symlink-based; no daemons; highly modular (treats directories as separate packages); allows the repository to remain cleanly isolated from the `$HOME` directory.
* **Cons:** Requires the repository directory structure to exactly mirror the target system structure.

### 3. Dedicated Dotfile Managers (e.g., Chezmoi)
Complex managers that template files and maintain state databases.
* **Pros:** Extremely feature-rich; handles secrets natively.
* **Cons:** Violates the project's minimalist philosophy by introducing a heavy abstraction layer, a templating language, and state databases to solve a problem that can be handled natively.

## Decision

**GNU Stow** was selected as the configuration management tool.

### Rationale

Stow provides the most direct, UNIX-native approach to dotfile management. By utilizing symbolic links, the live system reads the configurations directly from the version-controlled repository. It requires no background processes, keeps the repository isolated in its own directory, and fulfills all project requirements without introducing the complexity of dedicated dotfile managers.