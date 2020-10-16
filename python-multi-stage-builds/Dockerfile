FROM python:3.8 AS development_build

ARG DJANGO_ENV

ENV DJANGO_ENV=${DJANGO_ENV} \
  POETRY_VERSION=1.0.9 \
  POETRY_VIRTUALENVS_CREATE=false \
  POETRY_CACHE_DIR="/var/cache/pypoetry"

RUN pip install "poetry==$POETRY_VERSION"

WORKDIR /app
COPY pyproject.toml poetry.lock /app/

# Project initialization:
RUN echo "$DJANGO_ENV" \
  && poetry install \
    $(if [ "$DJANGO_ENV" = "production" ]; then echo "--no-dev"; fi) \
    --no-interaction --no-ansi

FROM development_build AS production_build

# Setting up proper permissions:
RUN groupadd -g 999 appuser && useradd -d /app -r -u 999 -g appuser appuser \
  && chown appuser:appuser -R /app

# Running as non-root user:
USER appuser

# Setup codebase
COPY --chown=appuser:appuser . /app
