dev:
	hugo serve -D --disableFastRender

build-prod:
	HUGO_ENVIRONMENT=production HUGO_ENV=production hugo --minify --baseURL "miata.dumitruvulpe.com" 

build-dev:
	hugo -D 
