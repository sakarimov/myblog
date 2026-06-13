.PHONY: help setup sync preview render freeze clean deploy

BLOG_DIR := myblog

help: ## Show available commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

setup: ## First-time setup: install Python + R dependencies
	uv sync
	Rscript -e 'source("renv/activate.R"); renv::restore()'

sync: ## Reinstall Python deps after pulling changes (uv sync)
	uv sync

preview: ## Live preview (English). Open http://localhost:3333
	cd $(BLOG_DIR) && quarto preview

render: ## Full multilingual render to _site/ (EN + ID via babelquarto)
	Rscript -e 'source("renv/activate.R"); babelquarto::render_website(project_path = "$(BLOG_DIR)")'

freeze: ## Re-execute all posts and update _freeze/ cache
	cd $(BLOG_DIR) && quarto render --execute

clean: ## Remove _site/ and .quarto/ build artifacts
	quarto clean $(BLOG_DIR)

deploy: render ## Render multilingual + commit + push (triggers CI deploy)
	git add -A && git commit -m 'update' && git push
