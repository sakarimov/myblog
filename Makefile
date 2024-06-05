push:
	jupyter-book toc from-project mybook -f jb-book --extension .ipynb -e .md > mybook/_toc.yml
	jupyter-book config sphinx mybook
	jupyter-book build mybook
	git add -A
	git commit -m 'update'
	git push
	ghp-import -n -p -f mybook/_build/html
