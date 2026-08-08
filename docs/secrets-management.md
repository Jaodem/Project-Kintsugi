# Secrets Management

## Introduction

Secrets Management provides the infrastructure required to securely store and retrieve sensitive application credentials within a desktop session.

Typical secrets include:

* application credentials;
* authentication tokens;
* stored passwords;
* network credentials;
* other sensitive application data.

Project Kintsugi treats Secrets Management as desktop infrastructure independent from the graphical compositor.

The implementation relies on the FreeDesktop Secret Service API and the native Fedora components available in the validated session.

---

## Why This Component Matters

Modern desktop applications require a secure mechanism for storing credentials without requiring each application to implement its own encrypted credential storage.

A standardized secrets infrastructure provides:

* secure credential storage;
* application interoperability;
* session-based access control;
* integration with desktop authentication;
* compatibility between applications and different desktop environments.

Without a common secrets interface, applications would require independent credential storage implementations.

---

## Responsibilities

Secrets Management is responsible for:

* providing secure storage for application secrets;
* exposing secrets through a standardized service interface;
* controlling access to stored credentials;
* integrating secret storage with the desktop session;
* allowing compatible applications to retrieve previously stored credentials.

Application-specific credential handling, browser session management, and password-manager functionality are separate responsibilities.

---

## Relationship with the Secret Service API

Project Kintsugi relies on the `org.freedesktop.secrets` D-Bus service as the standardized interface used by compatible applications.

The validated service is provided through:

```text
org.freedesktop.secrets
```

Applications can access the service through client libraries such as `libsecret`.

The Secret Service API separates applications from the implementation responsible for storing and protecting the actual secrets.

---

## Relationship with D-Bus

D-Bus provides the service discovery and activation mechanism for the Secret Service implementation.

The validated service definition is:

```text
/usr/share/dbus-1/services/org.freedesktop.secrets.service
```

The service definition contains:

```text
[D-BUS Service]
Name=org.freedesktop.secrets
Exec=/usr/bin/gnome-keyring-daemon --start --foreground --components=secrets
```

This establishes the relationship between the standardized D-Bus service name and the selected implementation.

---

## Relationship with GNOME Keyring

GNOME Keyring provides the active implementation of the Secret Service API in the validated Project Kintsugi session.

The active process is:

```text
/usr/bin/gnome-keyring-daemon --start --foreground --components=secrets
```

The service is activated through D-Bus and exposes:

```text
org.freedesktop.secrets
```

Project Kintsugi therefore uses GNOME Keyring as the currently validated Secret Service provider.

---

## Relationship with KDE / Desktop Environment

KDE provides its own secrets infrastructure through KWallet and related KDE Frameworks components.

The validated system contains:

```text
kf5-kwallet
kf6-kwallet
kwalletmanager5
pam-kwallet
```

KDE Secret infrastructure was also observed during session startup, including:

```text
ksecretd --pam-login
```

and D-Bus activatable services such as:

```text
org.kde.kwalletd5
org.kde.kwalletd6
org.kde.secretprompter
org.kde.secretservicecompat
```

However, validation confirmed that KWallet is not the active provider of `org.freedesktop.secrets` in the evaluated session.

Project Kintsugi therefore does not replace GNOME Keyring with KWallet solely because KDE components are installed.

---

## Relationship with PAM

PAM provides the authentication integration used during graphical login.

The validated SDDM configuration contains both:

```text
pam_gnome_keyring.so
```

and:

```text
pam_kwallet.so
pam_kwallet5.so
```

This demonstrates that Fedora KDE provides integration paths for both secret-storage implementations.

The presence of PAM modules does not by itself determine which Secret Service provider is active.

The active provider was determined through D-Bus and process validation.

---

## Relationship with systemd

The validated Secret Service process is managed within the user session and can be activated through the D-Bus service infrastructure.

The active service was observed as a transient user service:

```text
dbus-:[1.1-org.freedesktop.secrets@0.service
```

with:

```text
gnome-keyring-daemon
```

as its main process.

This allows Secrets Management to participate in the existing user-session infrastructure without requiring the compositor to manage the service.

---

## Relationship with Hyprland

Hyprland does not implement Secrets Management.

It does not provide:

* secret storage;
* credential encryption;
* Secret Service API implementation;
* D-Bus secret-service activation;
* keyring management.

Applications running inside the Hyprland session use the existing desktop and operating-system infrastructure.

This preserves the separation between the compositor and desktop services.

---

## Relationship with Applications

Applications compatible with the Secret Service API can use libraries such as `libsecret` to store and retrieve credentials.

The validated architecture is:

```text
Application
        │
        ▼
libsecret
        │
        ▼
Secret Service API
        │
        ▼
D-Bus
        │
        ▼
GNOME Keyring
        │
        ▼
Secret Storage
```

Applications do not need to depend directly on GNOME Keyring.

This preserves implementation independence and allows the Secret Service provider to change without requiring applications to change their credential-storage interface.

---

## Design Considerations

Project Kintsugi evaluates Secrets Management using the following criteria:

* standards compliance;
* Fedora compatibility;
* KDE Plasma compatibility;
* Wayland compatibility;
* Hyprland compatibility;
* application interoperability;
* integration with PAM;
* integration with D-Bus;
* modular architecture;
* upstream maintenance;
* availability through official Fedora repositories.

Preference is given to existing infrastructure whenever it satisfies the required functionality.

---

## Separation of Concerns

Secrets Management is not:

* a password manager;
* a web browser credential database;
* a session manager;
* an authentication agent;
* a compositor feature;
* an application-specific credential store.

Its responsibility is to provide secure, standardized access to application secrets.

Automatic unlocking behavior is an integration and session-policy concern rather than a separate Secret Service implementation.

---

## Project Kintsugi Perspective

Project Kintsugi considers Secrets Management a foundational desktop infrastructure component.

The validated architecture uses the FreeDesktop Secret Service API with GNOME Keyring as its active provider.

KWallet remains part of the installed KDE infrastructure but is not selected as the active Secret Service implementation because no architectural requirement was identified to replace the currently functioning provider.

This decision follows the project's principle of validating existing infrastructure before introducing changes.

---

## Next Step

The next document evaluates the available Secrets Management implementations and explains the architecture selected for Project Kintsugi.
