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
						script{
							dir('DevOpsLab1') {
							sh'''
							//echo "trivy currently disabled"
							git credentialsId: 'git', url: 'https://github.com/DuscraperRn/DevOpsLab1.git'
							git config user.name "DuscraperRn"
							git config user.email "duscraper@gmail.com"
							pwd
							ls -lrth
							mv /var/lib/jenkins/workspace/maven-app_master/target/inpage.war .
							git add .
							git commit -m "Added WAR file from pipeline ${BUILD_ID}"
							git push origin main

							'''
							}
						}
					}
				}
			}
		}
	}
}
