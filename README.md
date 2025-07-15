# Webshell Generator - Deployment

## Description

This repository contains the necessary files to quickly deploy all the necessary components for the
**Web Shell Generator**, including the [backend](https://github.com/david-gilarranz016/wonka-generator),
the [frontend](https://github.com/david-gilarranz016/wonka-front-end) and the `redis` cache server.

## Instructions for Users

### Installation and Deployment

In order to deploy the generator using the default configuration, the following steps must be performed:

1. Clone the repository:

```bash
git clone https://github.com/david-gilarranz016/wonka-deployment.git
cd wonka-deployment
```

2. Build the necessary images:

```bash
docker compose build
```

3. Deploy the application:

```bash
docker compose up -d
```

Once deployed, the application will be accessible via the following URL:

- [http://localhost:8081](http://localhost:8081)

If the predetermined ports are not suitable for the user's needs, the `docker-compose.yaml`
file can be modified to deploy the application with a different configuration.

## Instructions for Developers

This repository also contains the suite of acceptance tests used to verify the correct integration and
cooperation between all deployed components.

It is worth noting that the test suite requires `Ruby`, `PHP` and `python` to be installed locally. Furthermore,
testing has been done in a `Linux` host. The testing suite is not guarantied to work in other environments.

In order to run the acceptance tests, the following steps need to be performed:

1. Install all the necessary dependencies:

```bash
bundle install
```

2. Deploy the application using the predetermined configuration:

```bash
docker compose up -d
```

3. Stop the `redis` container to disable IP throttling. This is required to ensure that automated tests are not
rejected:

```bash
docker compose stop redis
```

4. Run the test suite. A delay of 1 second has been added to ensure smooth navigation between screens. Nonetheless,
this parameters may need to be adjusted depending on the host used for testing.

```bash
bundle exec cucumber
```
