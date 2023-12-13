FROM python:3.8-slim-buster

WORKDIR /app

RUN pip3 install Flask==2.2.5
COPY app.py .

EXPOSE 80
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]
