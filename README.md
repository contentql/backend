# Local Development Setup

Follow this guide to setup a local instance for Hasura CMS backend setup

## Development Dependencies

- Docker Desktop
- NodeJS
- Hasura CLI
- NHost CLI

# More Info

## Sync Local with Cloud database using migrations

Use the following to get all the changes in a database to your local machine with a single migration

```
hasura migrate create "init" --from-server --endpoint https://yufwbfestdytkggauxqw.hasura.ap-south-1.nhost.run --admin-secret yoursecret
```

If for some reason the authentication was being failed, add the line `admin_secret: yoursecret` in the `nhost/config.yaml` file

## How to automatically create migrations and a Table via API

Create a `POST` request on the route `/apis/migrate` with the following body with `x-hasura-admin-secret` to create a migration automatically while creating a table.

> Note, there is no need to create a down sql, if we are dropping the table in the up sql

```json
{
  "dataSource": "default",
  "skip_execution": false,
  "name": "create_table_public_TABLE_NAME",
  "down": [
    {
      "type": "run_sql",
      "args": {
        "cascade": true,
        "read_only": false,
        "source": "default",
        "sql": "DROP TABLE IF EXISTS TABLE_NAME;"
      }
    }
  ],
  "up": [
    {
      "type": "run_sql",
      "args": {
        "cascade": true,
        "read_only": false,
        "source": "default",
        "sql": "CREATE TABLE TABLE_NAME (id uuid PRIMARY KEY DEFAULT gen_random_uuid(), task text NOT NULL, completed boolean DEFAULT false, created_at timestamp DEFAULT CURRENT_TIMESTAMP, updated_at timestamp DEFAULT CURRENT_TIMESTAMP);"
      }
    }
  ]
}
```

## Creating a Table without any migrations

Create a `POST` request on the route `/v2/query` with the following body with `x-hasura-admin-secret` to create a table on your database without migrations.

```json
{
  "type": "run_sql",
  "args": {
    "source": "default",
    "sql": "CREATE TABLE TABLE_NAME (id uuid PRIMARY KEY DEFAULT gen_random_uuid(), task text NOT NULL, completed boolean DEFAULT false, created_at timestamp DEFAULT CURRENT_TIMESTAMP, updated_at timestamp DEFAULT CURRENT_TIMESTAMP);"
  }
}
```

## Creating a GraphQL API based on a particular table

Create a `POST` request on the route `/v1/metadata` with the following body with `x-hasura-admin-secret` to track the existing untracked tables.

> Tracking tables is the way we tell Hasura to create GraphQL APIs on a specific table.

```json
{
  "type": "pg_track_table",
  "args": {
    "source": "default",
    "table": "TABLE_NAME"
  }
}
```
