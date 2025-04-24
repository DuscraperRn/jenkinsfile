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
						sh "${mvn}/bin/mvn clean verify sonar:sonar -Dsonar.projectKey=DuscraperRn_maven-app_2efd0cbe-fce7-4ada-8798-01b6847d9712 -Dsonar.projectName='maven-app'"
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
							git credentialsId: 'git', url: 'https://github.com/DuscraperRn/DevOpsLab1.git'
						}
						dir('DevOpsLab1'){
							script{
							sh "cp /var/lib/jenkins/workspace/pyar_master/target/inpage.war ."
							sh "ls -lrth;pwd"
							withCredentials([gitUsernamePassword(credentialsId: 'git', gitToolName: 'Default')]) {
								sh '''
								  git config user.name "DuscraperRn" 
								  git config user.email "duscraper@gmail.com"  
								  git add . 
								  git commit -m 'Added WAR file from pipeline ${BUILD_ID}' 
								  git push origin master"
								'''
							}
							sh '''echo "duscraperrn/${image}:${BUILD_NUMBER}##${BUILD_ID}" '''
							def myimage=docker.build("duscraperrn/${image}:${BUILD_ID}","--no-cache .")
							//def myimage=docker.build("duscraperrn/${image}:32","--no-cache .")
							docker.withRegistry('https://index.docker.io/v1/','dockerhub'){
								myimage.push()
							}
							sh "rm -rf DevOpsLab1*"
							}
						}
					}
				}
				stage('SCM Push'){
					steps{
						sh ''' echo "Updating YAML files" '''
					}
				}
			}
		}
	}
}
