FROM python:3.11-slim

WORKDIR /app

# Копіюємо тільки конфіг
COPY pyproject.toml /app/

# Встановлюємо Poetry та залежності
RUN pip install --no-cache-dir poetry \
    && poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi --no-root

# Копіюємо код застосунку
COPY assistant /app/assistant

CMD ["python", "-m", "assistant.main"]
