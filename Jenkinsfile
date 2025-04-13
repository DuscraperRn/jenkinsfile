pipeline {
    agent any
    environment {
        image = "real"
        version = "${BUILD_NUMBER}"
    }
    stages {
        stage('Initialize Rocket') {
            steps {
                echo 'Initializing pipeline...'
            }
        }
        stage('SCM Checkout') {
            steps {
                git credentialsId: 'git', url: 'https://github.com/DuscraperRn/Test.git'
            }
        }
        stage('Building image') {
            steps{
                script{
                    def reg_image = docker.build("duscraperrn/${image}:${version}","--no-cache .")
                    docker.withRegistry('https://index.docker.io/v1/', 'dockercreds') {
                    //withDockerRegistry(credentialsId: 'dockercreds', url: 'https://registry.hub.docker.com') {
                        reg_image.push()
                    }
                }
            }
        }
        stage('Container run'){
            steps{
                script{
                    def image = docker.image("duscraperrn/${image}:${version}")
                    def container = image.run("-itd -p 8082:8080 --name=kraken")
                    echo "Container started with ID: ${container.id}"
                }
            }
        }
        stage('Security check'){
            steps{
                script{
                    sh "trivy image duscraperrn/${image}:${version} -o /tmp/report-${BUILD_NUMBER}.html"
                }
            }
        }
    }
}
