# todo-backend
Todo app backend on Jovy framework

### Environment variables
- `PORT`
- `DATABASE_URL`
- `PGSSLMODE` set 'no-verify' for Heroku

### How to use
Setup PostgreSQl DB:
```shell
psql -U postgres
create database todo;
\q
```

Prepare project
```shell
git clone git@github.com:IIPEKOLICT/todo-backend.git
cd safe-backend
npm i
```

Run in dev mode
```shell
npm run start:dev
```

Run in prod mode
```shell
npm run start:prod
```

[Jovy guide](https://github.com/IIPEKOLICT/jovy#readme)
