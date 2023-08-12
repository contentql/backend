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

## How to automatically create migrations when creating a table

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
