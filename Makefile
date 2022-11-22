install:
	pip install --upgrade pip &&\
		pip install -r requirements.txt

format:
	black *.py

run:
	python main.py

run-uvicorn:
	uvicorn main:app --reload

killweb:
	sudo killall uvicorn

lint:
	pylint --disable=R,C main.py

	
build:
	docker build -t fastapi_news .

deploy:
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 561744971673.dkr.ecr.us-east-1.amazonaws.com
	docker build -t fastapi_news .
	docker tag fastapi_news:latest 563280966170.dkr.ecr.us-east-1.amazonaws.com/fastapi_news:latest
	docker push 563280966170.dkr.ecr.us-east-1.amazonaws.com/fastapi_news:latest

all: install format lint test run build deploy