push:
	jupyter-book build mybook
	git add -A
	git commit -m 'update'
	git push
	ghp-import -n -p -f mybook/_build/html
