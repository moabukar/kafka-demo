KIND_CLUSTER_NAME := kafka-cluster
KIND_CONFIG := kind-config.yaml
STRIMZI_INSTALL_URL := https://strimzi.io/install/latest?namespace=kafka
NAMESPACE := kafka
KUBECONFIG := $(HOME)/.kube/config

.PHONY: kind-create kind-delete strimzi-install kafka-create topics-create producer-create consumer-create

# Step 1: Create a kind cluster
kind-create:
	@echo "Creating a kind cluster"
	kind create cluster --name $(KIND_CLUSTER_NAME) --config $(KIND_CONFIG)

# Step 2: Delete kind cluster
kind-delete:
	@echo "Deleting the kind cluster"
	kind delete cluster --name $(KIND_CLUSTER_NAME)

# Step 3: Install Strimzi Operator (based on the provided document)
strimzi-install:
	@echo "Installing Strimzi Operator"
	kubectl get namespace $(NAMESPACE) || kubectl create namespace $(NAMESPACE)
	kubectl create -f '$(STRIMZI_INSTALL_URL)' -n $(NAMESPACE)

# Step 4: Create Kafka cluster
kafka-create:
	@echo "Creating Kafka cluster"
	kubectl apply -f kafka-cluster.yaml -n $(NAMESPACE)

# Step 5: Create Kafka topics
topics-create:
	@echo "Creating Kafka topics"
	kubectl apply -f kafka-topics.yaml -n $(NAMESPACE)

# Step 6: Create Kafka producer pod
producer-create:
	@echo "Creating Kafka producer pod"
	kubectl apply -f kafka-producer.yaml -n $(NAMESPACE)

# Step 7: Create Kafka consumer pod
consumer-create:
	@echo "Creating Kafka consumer pod"
	kubectl apply -f kafka-consumer.yaml -n $(NAMESPACE)

# Step 8: Run tests
test:
	@echo "Running tests"
	@make kafka-create
	@make topics-create
	@make producer-create
	@make consumer-create
	@kubectl get pods -n $(NAMESPACE)

# Full setup
setup: kind-create strimzi-install kafka-create topics-create producer-create consumer-create

# Clean up the cluster
clean: kind-delete
	@echo "Cluster deleted!"
