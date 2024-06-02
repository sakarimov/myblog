push:
	jupyter-book toc from-project mybook -f jb-book
	jupyter-book config sphinx mybook
	sphinx-build mybook mybook/_build/html -b html
	git add -A
	git commit -m 'update'
	git push
	ghp-import -n -p -f mybook/_build/html
