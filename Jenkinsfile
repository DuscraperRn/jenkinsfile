pipeline{
	agent any
	//agent {
	//	label 'bond'
	//}
	environment{	
	    image="real"
	    file_build = "yes"
	}
	stages{
		stage('SCM checkout AWS'){
			steps{
				withCredentials([gitUsernamePassword(credentialsId: 'git', gitToolName: 'Default')]) {
					git url: 'https://github.com/DuscraperRn/maven-app.git'
				}
				
			}
		}
		stage('SonarQube Analysis') {
			steps{
				script{
					def mvn = tool "Maven 3.9.9"
					withSonarQubeEnv() {
						sh "${mvn}/bin/mvn clean verify sonar:sonar -Dsonar.projectKey=DuscraperRn_maven-app_33e0c9d6-8052-4114-87bc-5334b55ab6c4 -Dsonar.projectName='maven-app'"
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
				stage('Docker file prepration'){
					steps{
						dir('DevOpsLab1'){
							withCredentials([gitUsernamePassword(credentialsId: 'git', gitToolName: 'Default')]) {
								git url: 'https://github.com/DuscraperRn/Dockerfile.git'
							}
						}
						dir('DevOpsLab1'){
							script{
								try{
									sh 'cp ${WORKSPACE}/target/inpage.war .'
									
									sh "ls -lrth;pwd"
								
									withCredentials([gitUsernamePassword(credentialsId: 'git_local')]) {
										sh '''
										pwd
										git config user.name "DuscraperRn" 
										git config user.email "duscraper@gmail.com"  
										git add . 
										git show | head
										git commit -m 'Added WAR file from pipeline ${BUILD_ID}' 
										
										#git remote set-url origin https://$GIT_USERNAME:$GIT_PASSWORD@github.com/DuscraperRn/Dockerfile.git
										#git remote set-url origin git@github.com:DuscraperRn/Dockerfile.git
										
										git config --global --add safe.directory /var/lib/jenkins/workspace/${JOB_NAME}
										git push origin master
										'''
									}
								}
								catch (err) {
									echo "Caught an error: ${err}"
								}
								def myimage=docker.build("duscraperrn/${image}:${BUILD_ID}","--no-cache .")
								docker.withRegistry('https://index.docker.io/v1/','dockerhub'){
									myimage.push()
								}
								sh "rm -rf DevOpsLab1*"
							}
						}
					}
				}
			//
			}
		}
		stage('Image scanning'){
			steps{
				script{
					try {
						sh 'trivy image duscraperrn/${image}:${BUILD_ID} -o /tmp/${image}_${BUILD_ID}.log'
					}
					catch (e){
						echo "Caught an error: ${e}"
					}
				}
			}
		}
	}
	post{
		success{
			sh 'echo "Pipeline successfully completed."'
		}
		failure{
			sh 'echo "Kindly refer the logs for failure analyis."'
		}
		always{
			sh 'echo "New application has been created, kindly refer agent used to create docker image."'
		}
	}
}
