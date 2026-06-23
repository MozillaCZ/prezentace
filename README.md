# Mozilla.cz - prezentace

[![Build Status](https://github.com/MozillaCZ/prezentace/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/MozillaCZ/prezentace/actions)

V tomto repositáři najdete naše prezentace z konferencí, setkání a dalších akcí.

## Úpravy obsahu

### 📋 Požadavky
* Na počítači nainstalovaný [Podman](https://podman.io/) nebo [Docker](https://www.docker.com/) a GNU Make.
* Před prvním spuštěním si nainstalujte potřebné moduly pomocí příkazu:
    ```bash
    make prepare
    ```
  Tento příkaz je potřeba spustit také po každé změně v souboru `Gemfile`.

### 🔧 Sestavení
Pro sestavení webu slouží tento příkaz.
```bash
make build # sestaví statický obsah stránek do adresáře `_site`
```

### 🔍 Lokální náhled
Při úpravách vzhledu i obsahu je dobré se rovnou podívat na výsledek. Níže uvedený příkaz web spustí a zpřístupní ho na lokální adrese http://localhost:4000/.
```bash
make run
```
Příkaz stačí spustit jednou v samostatném terminálu a nechat běžet. Změny provedené ve zdrojových souborech (vyjma `_config.yml`) spustí nové sestavení a stránku stačí obnovit v prohlížeči (*F5*).
