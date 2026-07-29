# 🚀 TP1 — Infrastructure as Code (IaC)

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-232F3E?logo=amazonaws&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?logo=githubactions&logoColor=white)
![Trivy](https://img.shields.io/badge/Trivy-1904DA?logo=aqua&logoColor=white)
![Gitleaks](https://img.shields.io/badge/Gitleaks-FF4B4B)
![Git](https://img.shields.io/badge/Git-F05032?logo=git&logoColor=white)

---

## 📌 Description

Dépôt du **TP1 du module IaC & Gestion des configurations**
**Mastère Cybersécurité 4A — BC Design Systems**

Ce projet met en place un socle **Infrastructure as Code (IaC)** avec **Terraform**, en appliquant les bonnes pratiques de qualité et de sécurité attendues en environnement professionnel.

## Objectifs :

- ✅ Automatiser le déploiement d'infrastructure
- ✅ Garantir la reproductibilité des environnements
- ✅ Contrôler la qualité du code avant intégration
- ✅ Détecter les secrets exposés accidentellement
- ✅ Automatiser les contrôles de sécurité via CI/CD

---

## 📁 Structure du dépôt

```text
tp-iac-ALS/
├── .github/workflows/ # Pipeline CI (scan Trivy)
├── docs/ # Rapport du TP
│ └── tp1-rapport.md
├── terraform/ # Code d'infrastructure
├── .pre-commit-config.yaml
├── .editorconfig
├── .gitattributes
├── .gitignore
├── Makefile
└── README.md
```

## ⚙️ Prérequis

- 🏗️ Terraform >= 1.7
- 🔧 Git >= 2.40
- ⚡ Make
- 🔍 pre-commit
- 🔐 gitleaks

## 🚀 Démarrage rapide

```bash
git clone <url-du-depot>
cd tp-iac-ALS
make help
```

## 🔒 Qualité et sécurité DevSecOps

Ce dépôt utilise **pre-commit** pour garantir la qualité du code avant chaque commit :

| Hook | Rôle |
|---|---|
| `trailing-whitespace` | Supprime les espaces superflus en fin de ligne |
| `end-of-file-fixer` | Vérifie la fin de fichier |
| `check-yaml` | Valide la syntaxe YAML |
| `mixed-line-ending` | Uniformise les fins de ligne |
| `gitleaks` | Détecte les secrets commités par erreur |

## 🔍 Pipeline CI GitHub Actions

Une pipeline **GitHub Actions**

```text
.github/workflows/trivy.yaml
```

exécute automatiquement un scan :

## 🛡️ Trivy

afin de détecter :

- vulnérabilités connues ;
- dépendances vulnérables ;
- erreurs de configuration.

## 📄 Documentation

Le rapport détaillé du TP est disponible ici :

📘 [`docs/tp1-rapport.md`](docs/tp1-rapport.md).

## 🎯 Compétences mises en œuvre

- 🏗️ Infrastructure as Code (IaC)
- 🟣 Terraform
- ⚙️ Gestion de configuration
- 🌿 Git avancé
- 🔄 CI/CD sécurisé
- 🛡️ Analyse de vulnérabilités
- 🔐 Détection de secrets
- 🚀 Pratiques DevSecOps

## 👩‍💻 Auteur

**Anne-Laure S.**

Projet réalisé dans le cadre du Mastère Cybersécurité & Cloud Computing
