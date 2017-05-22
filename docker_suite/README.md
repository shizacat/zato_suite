# Docker

## Получить tag ака версия Zato

```
./scripts/print_version.py
```

## Base

```
docker build -t shizacat/zato_base:<tag> .
docker push shizacat/zato_base:<tag>
```


## Load-balancer

### Volume

- /opt/zato/code/conf - Конфигурация zato
- /opt/zato/code/cert - папка с сертификатами

### Environment

### Ports

- 11223
- 20151

### Build

```
docker build -t shizacat/zato_load_balancer:<tag>  .
```

### Run

```
docker run --name test \
	-v /conf:/opt/zato/code/conf \
	-v /cert:/opt/zato/code/cert \
	-p 11223:11223 \
	-p 20151:20151 \
	zato_load_balancer
```


## Web-admin

### Volume

- /opt/zato/code/conf - Конфигурация zato
- /opt/zato/code/cert - папка с сертификатами

### Ports

- 8183

### Environmets

- ODB_TYPE
- ODB_HOST
- ODB_PORT
- ODB_USER
- ODB_DB_NAME
- ODB_PASSWORD
- TECH_ACCOUNT_NAME
- TECH_ACCOUNT_PASSWORD
- ADMIN_PASSWORD

### Build

```
docker build -t shizacat/zato_web_admin:<tag> .
```


## Server

### Ports
- 17010

### Volume

- /opt/zato/code/conf - Конфигурация zato
- /opt/zato/code/cert - папка с сертификатами

### Environmets

- ODB_TYPE
- ODB_HOST
- ODB_PORT
- ODB_USER
- ODB_DB_NAME
- ODB_PASSWORD

- KVDB_HOST
- KVDB_PORT
- KVDB_PASSWORD

- CLUSTER_NAME
- SERVER_NAME
- JWT_SECRET

### Build

```
docker build -t shizacat/zato_server:<tag> .
```
