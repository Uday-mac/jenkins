pipeline {
    agent any
    environment {
        IMAGE="docker.io/udaydevmac/python-jf"
        TAG="${BUILD_NUMBER}"
        IMAGE_NAME="test"
    }
    stages {
        // stage('Cloning the repo') {
        //     steps {
        //         sh 'echo "Cloning the repo"'
        //         git branch: 'python-flask', url: 'https://github.com/Uday-mac/jenkins.git'
        //     }
        // }
        stage('Login into doker') {
            steps {
               withCredentials([usernamePassword(credentialsId: 'docker-cred', passwordVariable: 'DOCKERHUB_PWD', usernameVariable: 'DOCKERHUB_USR')]) {
                  sh 'echo "$DOCKERHUB_PWD" | docker login -u "$DOCKERHUB_USR" --password-stdin'
               }
            }
        }
        stage('Building the image') {
            steps {
                sh 'docker build -t "$IMAGE:$TAG" -t "$IMAGE:latest" .'
            }
        }
        stage('pushing the image') {
            steps {
                sh 'docker push "$IMAGE:$TAG"'
                sh 'docker push "$IMAGE:latest"'
            }
        }
        stage('deploying image') {
            steps {
                sh '''echo "Deploying the image..."
                    docker pull "$IMAGE:latest"
                    docker rm -f "$IMAGE_NAME" || true
                    docker run -d -p 5000:5000 --name "$IMAGE_NAME" "$IMAGE:latest"'''

                sh '''echo "Deployment-file..."
                   cat > deploy-info-${BUILD_NUMBER}.txt <<EOF 
                   build: "${BUILD_NUMBER}"
                   image: "$IMAGE:$TAG"
                   commit: "${GIT_COMMIT}"
                   branch: "${GIT_BRANCH}"
                   url: "${BUILD_URL}"
                   EOF
                '''
                archiveArtifacts artifacts: 'deploy-info-${BUILD_NUMBER}.txt', fingerprint: true, followSymlinks: false
            }
        }
        stage("accessing the app") {
            steps {
                sh 'sleep 10'
                sh 'echo "http://100.62.100.191:5000"'
            }
        }
        stage("Cleanup") {
            steps {
                cleanWs()
            }
        }
    }
}