# 🔐 Pourquoi `--no-verify` fonctionne-t-il, et quelle est la seule parade réellement efficace ?

## 📌 Fonctionnement des hooks Git

Les hooks Git (`pre-commit`, `commit-msg`, `pre-push`) sont de simples scripts stockés dans :

```text
.git/hooks/
```

sur la machine du développeur.

Ils ne font pas partie du protocole Git lui-même : ce sont des automatismes locaux, exécutés par le client, avant qu'aucune donnée ne soit envoyée au serveur.

Quiconque contrôle sa machine peut :

- ❌ désactiver les hooks (`--no-verify`) ;
- ❌ les modifier ;
- ❌ les supprimer ;
- ❌ ou simplement ne jamais les installer (`pre-commit install` n'est jamais imposé automatiquement au clone).

> ⚠️ **Un garde-fou purement côté client ne peut donc jamais être une garantie — seulement une aide au développeur de bonne volonté.**

---

# 🛡️ La seule parade réellement efficace

Déplacer le contrôle là où le développeur n'a pas la main : **côté serveur**.

Concrètement :

## 🖥️ Serveur Git auto-hébergé

- utiliser un hook `pre-receive` capable de rejeter un push entier si un secret est détecté dans les commits reçus.

## ☁️ GitHub / GitLab

- mettre en place des **Required Status Checks** ou des **règles de protection de branche** imposant la réussite d'un pipeline CI exécutant **Gitleaks** (ou un outil équivalent) avant toute fusion ;
- activer les fonctionnalités natives telles que le **Push Protection** pour les secrets.

> ✅ Dans ce cas, `--no-verify` reste utilisable localement, mais n'a plus aucun effet sur ce que le serveur accepte ou refuse.

---

# 🔑 Le secret purgé était-il, à un moment, présent sur le serveur distant ?

Dans la reproduction de ce TP, l'ensemble des opérations (création du fichier, commit forcé, purge) a été effectué localement, avant tout `push` : le secret n'a donc, dans cette exécution précise, **jamais transité par le serveur distant**.

Cependant, la séquence pédagogique du TP place le `git push` initial avant la création du faux secret.

Si le commit contenant la clé avait lui aussi été poussé avant la purge, la réponse serait **oui** : purger l'historique local ne suffirait alors plus.

---

# 🚨 Ce qu'il aurait fallu faire en premier

Si la clé avait été réelle, il aurait fallu :

1. 🔴 **Révoquer (rotate) immédiatement le secret** à la source.
2. 🔴 Désactiver puis supprimer la clé d'accès dans la console **AWS IAM**.
3. 🔵 Ensuite seulement, nettoyer l'historique Git.

> ⚠️ Dès l'instant où un secret réel est poussé sur un serveur distant, il faut le considérer comme compromis de façon définitive.

Il peut en effet avoir été :

- cloné ;
- forké ;
- mis en cache par la plateforme (recherche, diff de Pull Request, journaux CI, alertes de secret scanning...) ;
- récupéré par un tiers en quelques secondes.

La réécriture de l'historique avec `git filter-repo` suivie d'un `git push --force` constitue une mesure d'hygiène indispensable, mais **elle n'annule jamais une exposition déjà survenue**.

> 🔐 La seule mesure qui élimine réellement le risque est **la révocation du secret lui-même**.

---

# 🏷️ En quoi la mutabilité des tags Git explique-t-elle l'incident `tj-actions/changed-files` ?

En mars 2025, l'action GitHub **`tj-actions/changed-files`** a été compromise.

Des attaquants ayant obtenu un accès en écriture au dépôt ont :

1. poussé un commit malveillant ;
2. redirigé rétroactivement plusieurs tags de version existants (par exemple `v35` à `v46`) vers ce commit ;
3. sans publier de nouvelle version au sens habituel.

Or, un tag Git n'est — sauf s'il est explicitement signé et vérifié — qu'une simple référence mobile vers un commit, exactement comme une branche.

Rien n'empêche donc une personne disposant d'un accès en écriture de faire pointer un tag vers un autre commit après sa création.

---

## ⚠️ Conséquence

Les dizaines de milliers de workflows GitHub Actions qui utilisaient :

```yaml
uses: tj-actions/changed-files@v44
```

ont exécuté automatiquement le code malveillant lors de leur exécution suivante, alors même qu'aucune ligne de leur propre configuration n'avait changé.

> 💡 C'est exactement le même principe que celui observé en Exercice 2.2 : une référence non cryptographiquement immuable (tag, nom d'auteur déclaratif, etc.) ne constitue jamais une preuve d'intégrité.

---

# ✅ Bonne pratique recommandée

Depuis cet incident, la recommandation est de référencer les actions GitHub à l'aide de leur **SHA de commit** plutôt qu'avec un tag sémantique.

Exemple :

```yaml
uses: tj-actions/changed-files@<commit-sha>
```

Un **SHA de commit** est immuable et ne peut plus être redirigé après coup.

---

# ⚙️ Trois éléments du dépôt relevant de la gestion de configuration au sens ITIL

La gestion de configuration ITIL consiste à identifier, enregistrer, contrôler et vérifier les éléments de configuration (**Configuration Items – CI**) ainsi que leurs relations tout au long de leur cycle de vie.

Trois éléments de ce dépôt en relèvent directement.

---

# 1️⃣ Le code d'infrastructure

*(Fichiers Terraform, à venir dans ce dépôt.)*

Chaque ressource déclarée constitue un élément de configuration au sens strict :

- machine virtuelle ;
- réseau ;
- IAM ;
- stockage ;
- etc.

Il s'agit d'une description versionnée et vérifiable de l'état désiré d'une ressource réelle.

---

# 2️⃣ L'historique Git

Les commits, auteurs, dates et messages **Conventional Commits** jouent le rôle d'un registre d'audit comparable à une **CMDB**.

Pour chaque modification, il est possible de savoir :

- qui a effectué le changement ;
- quand il a été réalisé ;
- pourquoi il a été effectué.

C'est précisément l'objectif du processus ITIL de gestion des configurations.

---

# 3️⃣ Les fichiers de configuration des outils

Par exemple :

- `.pre-commit-config.yaml`
- `Makefile`
- `.gitattributes`
- `.gitignore`
- `.editorconfig`

Ces fichiers constituent eux-mêmes des éléments de configuration versionnés.

Ils définissent une **baseline** (configuration de référence) garantissant que :

- tous les environnements de développement appliquent les mêmes règles ;
- toutes les exécutions CI utilisent exactement les mêmes contrôles ;
- les comportements restent reproductibles et cohérents dans le temps.
