pipeline{
	agent any
	environment{	image="real"	}
	stages{
		stage('SCM checkout'){
			steps{
				git credentialsId: 'git', url: 'https://github.com/DuscraperRn/maven-app.git'
			}
		}
		stage('SonarQube Analysis') {
			steps{
				script{
					def mvn = tool "Maven 3.9.9"
					withSonarQubeEnv() {
						sh "${mvn}/bin/mvn clean verify sonar:sonar -Dsonar.projectKey=DuscraperRn_maven-app_16b82eec-2db1-49dd-a59c-9968ff54a2e5 -Dsonar.projectName='maven-app'"
					}
				}
			}
		}
		stage('Maven'){
			stages{
				stage('Build'){
					steps{
						script{
								sh 'mvn clean package'
						}
					}
				}
				stage('Security check'){
					steps{
						script{
							echo "trivy currently disabled"
							//sh "trivy image duscraperrn/${image}:${version}"
							//sh "trivy image duscraperrn/${image}:${version} -o /tmp/report-${image}-${BUILD_NUMBER}.txt"
						}
					}
				}
			}
		}
	}
}
