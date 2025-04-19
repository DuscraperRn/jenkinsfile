pipeline{
	agent any
	environment{
		image="real"
		version="latest"
		generatedImage="NA"
	}
	stages{
		stage('Initialize'){
			steps{
				echo """
					############
					# Starting #
					############
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
				def mvn = tool 'maven';
				withSonarQubeEnv() {
					sh "${mvn}/bin/mvn clean verify sonar:sonar -Dsonar.projectKey=DuscraperRn_softwarefiles_4d1e1f7f-7163-4a0f-a282-2f8b1827d97d -Dsonar.projectName='softwarefiles'"
				}
			}
		}
		stage('Image'){
			stages{
				stage('Build'){
					steps{
						script{
							def generatedImage=docker.build("duscraperrn/${image}:${BUILD_NUMBER}", "--no-cache .")
							env.gi=generatedImage
							docker.withRegistry('https://index.docker.io/v1/','dockercreds'){
								generatedImage.push()
							}
						}
					}
				}
				stage('Security check'){
					steps{
						script{
							//sh "trivy image duscraperrn/${image}:${version}"
							sh "trivy image duscraperrn/${image}:${version} -o /tmp/report-${image}-${version}-${BUILD_NUMBER}.txt"
						}
					}
				}
				stage('Push'){
					steps{
						script{
							//docker.withRegistry('https://index.docker.io/v1/','dockercreds'){
							//	env.gi.push()
							sh "kubectl create ns calculator${BUILD_NUMBER}"
							//}
						}
					}
				}
			}
		}
	}
}
