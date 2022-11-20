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
> - `AWS_ACCESS_KEY_ID` access key id for use AWS
> - `AWS_SECRET_ACCESS_KEY` secret access key for use AWS
> - `AWS_ENVIRONMENT_NAME` environment name on AWS
> - `AWS_S3_BUCKET_NAME` AWS S3 bucket name
> - `AWS_REGION` AWS region
> - `DATABASE_URL` used database url
> - `DATABASE_NAME` used database name
> - `JWT_SECRET` used jwt secret
> - `BCRYPT_STRENGTH` used for bcrypt library strength

> Frontend
> - `BACKEND_URL` deployed backend url
> - `KEYSTORE_GIT_REPOSITORY` name of git repository with keystore
> - `KEYSTORE_ACCESS_TOKEN` token for get access to keystore repository
> - `KEYSTORE_PASSWORD` password of used keystore
> - `RELEASE_SIGN_KEY_ALIAS` used alias for sign app using keystore
> - `RELEASE_SIGN_KEY_PASSWORD` used password for sign app using keystore

### Environment variables

>Required
>>Backend (local)
>> - `AWS_ACCESS_KEY_ID` access key id for use AWS
>> - `AWS_SECRET_ACCESS_KEY` secret access key for use AWS
>> - `AWS_S3_BUCKET_NAME` AWS S3 bucket name
>
>> Backend (production)
>> - `AWS_ACCESS_KEY_ID` access key id for use AWS
>> - `AWS_SECRET_ACCESS_KEY` secret access key for use AWS
>> - `AWS_S3_BUCKET_NAME` AWS S3 bucket name
>> - `PORT` used port by backend
>> - `DATABASE_URL` db url string
>> - `DATABASE_NAME` used database name
>
>> Frontend
>> - `BACKEND_URL` backend url used by frontend

> Optional
>> Backend (local)
>> - `AWS_REGION` AWS region
>> - `PORT` used port by backend
>> - `DATABASE_URL` db url string
>> - `DATABASE_NAME` used database name
>> - `JWT_SECRET` used jwt secret
>> - `BCRYPT_STRENGTH` used for bcrypt library strength
>
>> Backend (production)
>> - `AWS_REGION` AWS region
>> - `JWT_SECRET` used jwt secret
>> - `BCRYPT_STRENGTH` used for bcrypt library strength

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
eb deploy --staged $AWS_ENVIRONMENT_NAME
```
