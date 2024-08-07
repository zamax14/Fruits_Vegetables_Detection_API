FROM python:3.8-slim-buster

RUN apt update

WORKDIR /food_api

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

ENV VIRTUAL_ENV=/opt/venv
RUN python -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN pip install -U -q --no-cache-dir \
    pip \
    wheel

COPY requirements.txt .

RUN pip install -q --no-cache-dir -r requirements.txt

ADD app/ app/

EXPOSE 8080

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]

