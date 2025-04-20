pipeline{
	agent any
	environment{
		image="real"
		version="latest"
	}
	stages{
		stage('Initialize'){
			steps{
				echo """
					#####################################
					#    Starting SCM Initialization    #
					#####################################
				"""
			}
		}
		stage('SCM checkout'){
			steps{
				git credentialsId: 'git', url: 'https://github.com/DuscraperRn/softwarefiles.git'
			}
		}
		stage('SonarQube Analysis') {
			steps{
				script{
					def mvn = tool "maven"
					withSonarQubeEnv() {
						sh "${mvn}/bin/mvn clean verify sonar:sonar -Dsonar.projectKey=DuscraperRn_softwarefiles_b69d2ce3-a447-4875-8a32-db9687eb4ddf -Dsonar.projectName='softwarefiles'"
					}
				}
			}
		}
		stage('Image'){
			stages{
				stage('Build'){
					steps{
						script{
							def generatedImage=docker.build("duscraperrn/${image}:${BUILD_NUMBER}", "--no-cache .")
							//docker.withRegistry('https://index.docker.io/v1/','dockercreds'){
							//	generatedImage.push()
							//}
						}
					}
				}
				stage('Security check'){
					steps{
						script{
							echo "trivy currently disabled"
							//sh "trivy image duscraperrn/${image}:${version}"
							//sh "trivy image duscraperrn/${image}:${version} -o /tmp/report-${image}-${version}-${BUILD_NUMBER}.txt"
						}
					}
				}
				stage('Push'){
					steps{
						script{
							docker.withRegistry('https://index.docker.io/v1/','dockerhub'){
								generatedImage.push()
							//sh "kubectl create ns calculator${BUILD_NUMBER}"
							}
						}
					}
				}
			}
		}
	}
}
