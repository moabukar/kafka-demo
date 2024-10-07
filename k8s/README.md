# Kafka on K8s

## Setup & Testing

```bash
make kind-create
make strimzi-install
make kafka-create
make topics-create


## Create producer and consumer
make producer-create
make consumer-create

## Testing

make test
```

## Teardown

```bash
make clean
```
