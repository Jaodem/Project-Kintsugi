# 26 - Backup and Disaster Recovery Strategy

## Objective

The objective of this document is to define the backup and recovery mechanisms for Project Kintsugi, ensuring that both the system infrastructure and critical personal data are protected against loss.

## System Recovery (Local)

The underlying Fedora system utilizes the **BTRFS** file system by default. BTRFS provides native snapshot capabilities, allowing the system state to be frozen and rolled back in the event of a catastrophic system update. 

System configurations (dotfiles) are version-controlled via Git and GNU Stow, and the complete environment can be rebuilt from scratch using the `bootstrap.sh` script.

## Development Data

The `~/projects/` directory is explicitly **excluded** from automated cloud synchronization. Following standard software engineering practices, source code and project data are version-controlled using Git. `git push` remains the primary backup mechanism for development workloads.

## Personal Data (Cloud)

Personal data and academic documents are managed through a selective, on-demand strategy.

* **Scope:** Only files explicitly placed inside `~/Documents/Important/` are backed up.
* **Tool:** `rclone` is used to synchronize the local directory with a remote MEGA account.
* **Execution:** Synchronization is performed manually via the `scripts/backup.sh` executable. `rclone sync` ensures the cloud remote acts as an exact mirror of the local directory, transferring only modified data without relying on background daemons.