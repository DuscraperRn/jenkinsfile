pipeline{
    agent any
    environment{
        VARI="VARIABLE AA"
        VARU="VARIABLE BB"
    }
    stages{
        stage('SCM Checkout'){
            steps{
                echo "I am doing SCM checkout ${BUILD_NUMBER} ${VARU}"
            }
        }
        
        stage('nested'){
           
            stages{
                stage('A'){
                    steps{
                        echo 'Nested A ${VARI}'
                    }
                }
                stage('B'){
                    steps{
                        echo 'Nested B ${VARU}'
                    }
                }
            }
        }
        
        stage('Parallel'){
            parallel{
                stage('P1'){
                    options{
                        timeout(time:10, unit: 'SECONDS')
                    }
                    steps{
                        echo "Parallel 1"
                        sh 'sleep 20'
                        }
                }
                stage('P2'){
                    steps{
                        echo "Parallel 2"
                    }
                }
                stage('P3'){
                    steps{
                        //def aaaa = echo "MY name is car"
                        echo "{aaaa}"
                    }
                }
            }
        }
    }
    post{
        failure{
            echo "FAILEDDDD"
        }
        success{
            echo "Ohlala"
        }
    }
}
