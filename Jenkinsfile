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
				stage('Docker file prepration'){
					steps{
						dir('DevOpsLab1'){
							git credentialsId: 'git', url: 'https://github.com/DuscraperRn/DevOpsLab1.git'
						}
						dir('DevOpsLab1'){
							script{
							sh "cp /var/lib/jenkins/workspace/maven-app_master/target/inpage.war ."
							sh ''' git config user.name "DuscraperRn" '''
							sh ''' git config user.email "duscraper@gmail.com" '''
							sh "ls -lrth;pwd"
							sh "git add . ; git commit -m 'Added WAR file from pipeline ${BUILD_ID}' ; git push origin master"
							sh "rm -rf DevOpsLab1*"
							}
						}
					}
				}
			}
		}
	}
}
