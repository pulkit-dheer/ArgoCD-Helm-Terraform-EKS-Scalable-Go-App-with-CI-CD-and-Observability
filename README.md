## ArgoCD, Helm, Terraform, EKS: Scalable Go App with CI/CD and Observability

### 🎯 1. **Objective**

The goal of this project is to design and implement a scalable Go web application that leverages modern cloud-native technologies for deployment and management. By containerizing the application with Docker, establishing a robust CI/CD pipeline, and deploying on a Kubernetes cluster via Amazon EKS (Elastic Kubernetes Service), we aim to create a streamlined application delivery process. This project incorporates best practices in DevOps, ensuring that the application can be efficiently developed, tested, and deployed with minimal manual intervention.

### 🗂️ 2. **Project Structure**


![project-structure.png](https://github.com/pulkit-dheer/ArgoCD-Helm-Terraform-EKS-Scalable-Go-App-with-CI-CD-and-Observability/blob/main/static/images/project-structure.png)


- **Source Code**: `static/`
    - Contains the Go web application codebase.
- **Docker Configuration**: `Dockerfile`
    - Dockerfile to build a Docker image of the Go app.
- **Helm Chart**: `helm/`
    - Helm chart for deploying the application to the Kubernetes cluster.
- **CI/CD Pipeline**: `.github/workflows/` (or similar CI/CD pipeline directory)
    - GitHub Actions or another CI/CD tool configuration files.

### ⚙️ 3.  **Technologies Used**

- **Programming Language**: Go
- **Containerization**: Docker
- **CI/CD**: GitHub Actions (or alternative CI/CD tool)
- **Orchestration**: Kubernetes (EKS)
- **Deployment Management**: Helm and Argo CD


### 🐳 Step 1: **Dockerize the Go Application**

```bash
FROM golang:1.22.5 AS base

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o main

# FINAL STAGE (Distroless Image)

FROM gcr.io/distroless/base 

COPY --from=base /app/main .

COPY --from=base /app/static/ ./static

EXPOSE 8080

CMD ["./main"]
```


- Create a Dockerfile for the Go application to define the image build process.
    ```bash
    docker build -t my-go-app .
    ```
- Build and test the Docker image locally.
    ```bash
    docker run -p 8080:8080 my-go-app
    ```

### Step 2: **Set Up CI/CD Pipeline**

![cicd_stages.png](https://github.com/pulkit-dheer/ArgoCD-Helm-Terraform-EKS-Scalable-Go-App-with-CI-CD-and-Observability/blob/main/static/images/cicd_stages.png)


- Use GitHub Actions (or another CI/CD platform) to automate the following tasks:
    - **Build**: Build Docker image from source.
    - **Test**: Run application tests to ensure functionality.
    - **Push**: Push Docker image to a container registry (e.g., Docker Hub, AWS ECR).
    - **Deploy**: Use Helm and Argo CD to deploy the application to the EKS cluster.

### Step 3: **Deploy on EKS with Helm and Argo CD**

![deployement_file.png](https://github.com/pulkit-dheer/ArgoCD-Helm-Terraform-EKS-Scalable-Go-App-with-CI-CD-and-Observability/blob/main/static/images/deployement_file.png)

- **Helm**:
    Create a Helm chart that defines Kubernetes manifests for deployment, services, config maps, and other resources.


### Step 4: **Argo CD**

![argocd_deployment.png](https://github.com/pulkit-dheer/ArgoCD-Helm-Terraform-EKS-Scalable-Go-App-with-CI-CD-and-Observability/blob/main/static/images/argocd_deployment.png)


### Step 5. Monitoring with prometheus and grafana

![monitoring_with_prometheus_grafana.png](https://github.com/pulkit-dheer/ArgoCD-Helm-Terraform-EKS-Scalable-Go-App-with-CI-CD-and-Observability/blob/main/static/images/monitoring_with_prometheus_grafana.png)

### Result Interpretation

![about_page.png](https://github.com/pulkit-dheer/ArgoCD-Helm-Terraform-EKS-Scalable-Go-App-with-CI-CD-and-Observability/blob/main/static/images/about_page.png)

- **Successful Image Build**: The successful build indicates that the Dockerfile and Go application are correctly set up. If there are issues, Docker will provide error messages to help us troubleshoot problems with your code or configuration.
- **Running Application**: The ability to run the container without errors suggests that our application is correctly configured to handle requests. If we encounter errors during runtime, these may stem from application logic issues or misconfigured environment settings.
- **Accessing Application Locally**: Successfully accessing the application through a browser or API tool means that the application is not only running but also properly serving requests. This validates that the container networking and port mappings are correctly established.

### 🎉 Conclusion

Successfully Dockerizing the Go application and running it in a container is a significant step in developing scalable applications. It allows for consistent deployments across various environments and simplifies the integration of Continuous Integration and Continuous Deployment (CI/CD) practices.
