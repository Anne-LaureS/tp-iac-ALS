# TP1 — Infrastructure as Code

Dépôt du TP1 du module **IaC & Gestion des configurations** — Mastère Cybersécurité 4A, BC Design Systems.

Ce dépôt met en place un socle Infrastructure as Code avec Terraform, incluant les bonnes pratiques de qualité et de sécurité attendues en environnement professionnel : vérifications automatiques pré-commit, détection de secrets, et pipeline CI de scan de vulnérabilités.

## 📁 Structure du dépôt

```
tp-iac-ALS/
├── .github/workflows/       # Pipeline CI (scan Trivy)
├── docs/                     # Rapport du TP
│   └── tp1-rapport.md
├── terraform/                 # Code d'infrastructure
├── .pre-commit-config.yaml
├── .editorconfig
├── .gitattributes
├── .gitignore
├── Makefile
└── README.md
```

## ⚙️ Prérequis

- Terraform >= 1.7
- Git >= 2.40
- `make`, `pre-commit`, `gitleaks`

## 🚀 Démarrage

```bash
git clone <url-du-depot>
cd tp-iac-ALS
make help
```

## 🔒 Qualité et sécurité

Ce dépôt utilise **pre-commit** pour garantir la qualité du code avant chaque commit :

| Hook | Rôle |
|---|---|
| `trailing-whitespace` | Supprime les espaces superflus en fin de ligne |
| `end-of-file-fixer` | Vérifie la fin de fichier |
| `check-yaml` | Valide la syntaxe YAML |
| `mixed-line-ending` | Uniformise les fins de ligne |
| `gitleaks` | Détecte les secrets commités par erreur |

Une pipeline **GitHub Actions** (`.github/workflows/trivy.yaml`) exécute un scan **Trivy** à chaque push pour détecter les vulnérabilités dans le code et les dépendances.

## 📄 Documentation

Le rapport détaillé du TP se trouve dans [`docs/tp1-rapport.md`](docs/tp1-rapport.md).


```bash
git clone <url-du-depot>
cd tp-iac-ALS
make help
```
