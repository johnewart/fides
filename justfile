run-static-analysis:
   uv run black --check ./src ./tests
   uv run isort --check-only ./src
   uv run pylint ./src --jobs 0
   uv run mypy ./src
   #uv run xenon ./src --max-absolute B --max-modules B --max-average A --ignore "data,docs" --exclude "src/fides/_version.py"



run-not-external-tests:
   uv run pytest ./tests -m "not external"

run-integration-tests:
   uv run pytest ./tests -m "integration"

run-unit-tests:
   uv run pytest ./tests -m "unit"

run-saas-tests:
   uv run pytest ./tests -m "saas"

run-external-datastores-tests:
   uv run pytest ./tests -m "external_datastores"

run-safe-tests: run-not-external-tests run-integration-tests run-unit-tests

run-pytest:
   uv run pytest ./tests

check-fides-annotations:
   uv run fides --local -f tests/ctl/test_config.toml evaluate

check-migrations-db:
   uv run python -c "from fides.api.db.database import check_missing_migrations; from fides.config import get_config; config = get_config(); check_missing_migrations(config.database.sync_database_uri);"

[working-directory: 'docs/fides']
check-docs:
   uv run --group docs mkdocs build

run-misc-tests:
   uv run pytest