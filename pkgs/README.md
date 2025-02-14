# 🚀 Custom Packages Packaged by Me

### A Collection of Custom-Packaged Tools

These are the custom packages I've packaged for personal use.
Most packages are compatible with all systems specified in `flake.nix`. If a package is system-specific, this will be noted in its description.

---

### 🔨 Installing a Package

To use the packages, add the flake as an input in your configuration:

```bash
inputs = {
    nikpkgs.url = "github:niksingh710/ndots";
    nikpkgs.inputs.nixpkgs.follows = "nixpkgs";
};
```

Once added, install the package using:

```bash
inputs.nikpkgs.packages.<package-name>
```

---

### ⚡ Quick Run

You can quickly run the package without installing it using:

```bash
nix run "github:niksingh710/ndots#<pkgname>"
```

Or bring the package into a shell environment with:

```bash
nix shell "github:niksingh710/ndots#<pkgname>"
```

---

### ✨ Minecraft: Custom Launcher

**SKLauncher** ([Official Site](https://skmedix.pl/)):
A custom Minecraft launcher that I've packaged for ease of use.

- **Binary Name:** `nminecraft`
- **Run with:** `steam-run` using **Java 21**, ensuring compatibility on any system.

Example:
```nix
{
    environment.systemPackages = [inputs.nikpkgs.packages.nminecraft];
}
```

### ✨ Wl-ocr

*Picked* from [fufexan config](https://github.com/fufexan)

Uses `grim` and `slurp` to select content from screen and then extract text from it.

---
