@Library('jenkins-library') _
pipeline{
    agent any
    stages{
        stage('Lib Call'){
            steps{
                echo "Executing important stage"
            }
        }
        stage('Actual call'){
            steps{
                script{
                    def c = customer()  // call() is invoked
                    c.greet()
                    //c.getList()
                    def list = c.getList()
                    echo "${list}"
                    echo "Asset list: ${list.join(', ')}"
                }
            }
        }
    }
    post{
        always{
            cleanWs()
        }
    }
}
