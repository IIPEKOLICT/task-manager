_todo_

# KNest + Flutter app

Cross-platform app for manage tasks (Main diploma in BSUIR)

### Backend tech stack

- Kotlin
- Gradle
- KNest
- KMongo ODM
- MongoDB
- Koin
- SwaggerUI

### Frontend tech stack

- Dart
- Flutter

### Repository secrets

> Backend
- `AWS_ACCESS_KEY_ID` access key id for use AWS
- `AWS_SECRET_ACCESS_KEY` secret access key for use AWS
- `AWS_ENVIRONMENT_NAME` environment name on AWS
- `AWS_DEFAULT_REGION` AWS region
- `DATABASE_URL` used database url
- `JWT_SECRET` used jwt secret
- `BCRYPT_STRENGTH` used for bcrypt library strength
> Frontend
- `BACKEND_URL` deployed backend url
- `KEYSTORE_GIT_REPOSITORY` name of git repository with keystore
- `KEYSTORE_ACCESS_TOKEN` token for get access to keystore repository
- `KEYSTORE_PASSWORD` password of used keystore
- `RELEASE_SIGN_KEY_ALIAS` used alias for sign app using keystore
- `RELEASE_SIGN_KEY_PASSWORD` used password for sign app using keystore

### Environment variables

> Backend
- `PORT` used port by backend
- `DATABASE_URL` db url string
- `JWT_SECRET` used jwt secret
- `BCRYPT_STRENGTH` used for bcrypt library strength
> Frontend
- `BACKEND_URL` backend url used by frontend

### Load project

```shell
git clone git@github.com:IIPEKOLICT/task-manager.git
cd task-manager
```

### Start backend locally (needed 11+ Java)

```shell
cd backend
./gradlew build
./gradlew bootRun
```

### Build backend fatJar (needed 11+ Java)

```shell
cd backend
./gradlew buildFatJar
```

### Deploy backend to AWS locally (needed Elastic Beanstalk CLI)

```shell
cd backend
deploy --staged $AWS_ENVIRONMENT_NAME
```
