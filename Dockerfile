FROM python:3.9

# Set up a separate working directory for easier debugging.
WORKDIR /app

# Create a virtual environment.
ENV VIRTUAL_ENV /app/.venv
RUN python -m venv $VIRTUAL_ENV
ENV PATH $VIRTUAL_ENV/bin:$PATH

# install sqlfluff as well as the dbt templater. Finally confirm installation of python packages.
RUN pip install --no-cache-dir --upgrade pip && \
    pip install sqlfluff && \
    pip install dbt-snowflake sqlfluff-templater-dbt

# Switch to non-root user.
USER 5000

# Switch to new working directory as default bind mount location.
# User can bind mount to /sql and not have to specify the full file path in the command:
# i.e. docker run --rm -it -v $PWD:/sql sqlfluff/sqlfluff:latest lint test.sql
WORKDIR /sql

# Set SQLFluff command as entry point for image.
ENTRYPOINT ["sqlfluff"]
CMD ["--help"]