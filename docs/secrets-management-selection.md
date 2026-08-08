# Secrets Management Selection

## Objective

The purpose of this document is to select the Secrets Management infrastructure for Project Kintsugi.

The selected implementation should provide standardized application credential storage while integrating naturally with Fedora KDE Plasma, Wayland, Hyprland, PAM, D-Bus, and the existing user session.

---

## Background

Desktop applications require secure storage for credentials and other sensitive information.

The evaluation focused on identifying:

* the standardized application interface;
* the active provider in the Fedora installation;
* KDE secret-storage infrastructure;
* D-Bus activation;
* PAM integration;
* compatibility with the existing Hyprland session.

---

## Evaluation Criteria

The selected infrastructure should provide:

* compatibility with FreeDesktop standards;
* Fedora compatibility;
* KDE Plasma compatibility;
* Wayland compatibility;
* Hyprland compatibility;
* application interoperability;
* PAM integration;
* D-Bus integration;
* modular architecture;
* active upstream maintenance;
* availability through official Fedora repositories.

---

## Evaluated Components

### FreeDesktop Secret Service API

The Secret Service API provides the standardized interface used by applications to access stored secrets.

The validated service name is:

```text
org.freedesktop.secrets
```

The API separates applications from the implementation responsible for storing secrets.

Validation confirmed that the service is available through the user D-Bus session.

Conclusion:

The Secret Service API is the appropriate application-facing standard for Project Kintsugi.

---

### libsecret

`libsecret` provides client-side access to the Secret Service API for compatible applications.

Validation confirmed that:

```text
libsecret
```

is installed on the system.

Applications can therefore interact with the standardized secret-storage interface without directly depending on a specific keyring implementation.

Conclusion:

`libsecret` is retained as the client-side integration layer.

---

### GNOME Keyring

GNOME Keyring provides the active Secret Service implementation in the validated session.

Validation confirmed:

```text
gnome-keyring
```

is installed and:

```text
gnome-keyring-daemon --start --foreground --components=secrets
```

is running.

The D-Bus service definition was also validated:

```text
/usr/share/dbus-1/services/org.freedesktop.secrets.service
```

containing:

```text
Name=org.freedesktop.secrets
Exec=/usr/bin/gnome-keyring-daemon --start --foreground --components=secrets
```

Conclusion:

GNOME Keyring is the currently active Secret Service provider and satisfies the project's requirements.

---

### KDE KWallet

KWallet is available as part of the Fedora KDE infrastructure.

Validation confirmed:

```text
kf5-kwallet
kf6-kwallet
kwalletmanager5
pam-kwallet
```

and D-Bus activatable services including:

```text
org.kde.kwalletd5
org.kde.kwalletd6
```

However, KWallet was not observed as the active provider of:

```text
org.freedesktop.secrets
```

Conclusion:

KWallet remains available as native KDE infrastructure but is not selected as the active Secret Service implementation.

No architectural benefit was identified that would justify replacing the currently functioning provider.

---

### KDE Secret Infrastructure

The session also contains KDE secret-related components.

Validation confirmed:

```text
ksecretd --pam-login
```

during session startup, as well as D-Bus activatable services including:

```text
org.kde.secretprompter
org.kde.secretservicecompat
org.freedesktop.impl.portal.Secret
```

These components demonstrate that KDE provides additional secret-management integration.

However, the investigation did not establish that these components replace GNOME Keyring as the active provider of `org.freedesktop.secrets`.

Conclusion:

The KDE secret infrastructure is retained as part of the existing Fedora KDE environment, but no replacement decision is made without a demonstrated architectural requirement.

---

### KeePassXC

KeePassXC is installed on the system.

It provides password-management functionality rather than being the foundational Secret Service infrastructure selected for the desktop session.

Its responsibility is application-level password management and is therefore separate from the system-wide Secret Service architecture.

Conclusion:

KeePassXC is not selected as the system Secret Service provider.

No architectural change is required.

---

## Decision

Project Kintsugi adopts the existing Fedora Secret Service infrastructure.

The selected architecture is:

```text
Applications
        │
        ▼
libsecret
        │
        ▼
org.freedesktop.secrets
        │
        ▼
D-Bus
        │
        ▼
gnome-keyring-daemon
        │
        ▼
Secret Storage
```

PAM provides authentication integration around the user session:

```text
SDDM
  │
  ▼
PAM
  │
  ├───────────────┐
  ▼               ▼
GNOME Keyring   KDE KWallet
```

The presence of both implementations does not imply that both should provide the same service simultaneously.

The validated active Secret Service provider is GNOME Keyring.

No additional secret-storage component is required.

---

## Trade-offs

Using GNOME Keyring as the active Secret Service provider preserves the existing working Fedora implementation and avoids introducing an additional provider.

This approach provides:

* standards-based application integration;
* compatibility with `libsecret`;
* D-Bus activation;
* compatibility with applications using the Secret Service API;
* minimal architectural changes.

The trade-off is that the system contains both GNOME and KDE secret-management infrastructure.

This coexistence reflects the Fedora KDE environment and does not, by itself, justify removing native components.

Automatic unlocking behavior remains a separate session-integration consideration and is not changed by this architectural decision.

---

## Validation

The selected architecture was validated through:

* verification of the installed `libsecret` package;
* verification of the installed GNOME Keyring packages;
* verification of the active `gnome-keyring-daemon` process;
* verification of `org.freedesktop.secrets` through D-Bus;
* verification of the D-Bus service definition;
* verification of KWallet packages;
* verification of KWallet D-Bus activatable services;
* verification of KDE secret-related services;
* verification of PAM integration;
* verification of the Hyprland Wayland session.

---

## Conclusion

Project Kintsugi standardizes on the existing Fedora implementation of the FreeDesktop Secret Service API using `libsecret` on the client side and GNOME Keyring as the active provider.

KWallet and other KDE secret infrastructure remain available as part of the Fedora KDE environment but are not selected as replacements because no architectural requirement was identified.

This approach preserves compatibility, minimizes unnecessary changes, and follows Project Kintsugi's principle of validating existing infrastructure before modifying it.
