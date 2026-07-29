SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
 
.DEFAULT_GOAL := help
 
.PHONY: help lint secrets clean
 
help: ## Affiche cette aide (liste des cibles disponibles)
	@echo "Cibles disponibles :"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  %-10s %s\n", $$1, $$2}'
 
lint: ## Exécute pre-commit sur l'ensemble du dépôt
	pre-commit run --all-files
 
secrets: ## Recherche des secrets exposés avec gitleaks
	gitleaks detect --source . --verbose
 
clean: ## Supprime les artefacts locaux (cache Terraform, etc.)
	rm -rf .terraform out/
