run-static-analysis:
   uv run black --check ./src ./tests
   uv run isort --check-only ./src
   uv run pylint ./src --jobs 0
   uv run mypy ./src
   uv run xenon ./src --max-absolute B --max-modules B --max-average A --ignore "data,docs" --exclude "src/fides/_version.py"
