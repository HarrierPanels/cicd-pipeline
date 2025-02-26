pipeline { 
    agent {
 
	label 'aws-linux2'
 
    }
    environment {
       MAIN_PORT = '3000'
       DEV_PORT = '3001'

    } 
    tools {nodejs "node"} 
    stages { 
        stage('Checkout') { 
            steps { checkout scm } 
            
        } 
        stage('Build') { 
            steps {
                timeout(time: 2, unit: 'MINUTES') { 
                    sh 'chmod +x scripts/build.sh && ./scripts/build.sh'
                } 
                
            } 
            
        } 
        stage('Test') { 
            steps { 
                sh 'chmod +x scripts/test.sh && ./scripts/test.sh' 
                
            } 
            
        } 
        stage('Generate Logo main') { 
            when { branch 'main' } 
            steps { 
                sh label: 'Generate Logo', script: '''
cat <<EOF > main_logo.svg
<svg width="150" height="150" xmlns="http://www.w3.org/2000/svg"> \
<circle cx="75" cy="75" r="60" fill="#25f363" /> </svg>
EOF
                '''
                sh 'cp main_logo.svg src/logo.svg' 
                
            } 
            
        } 
        stage('Build Docker Image nodemain:v1.0') {
            when { branch 'main' }
            steps { 
                sh 'docker build -t nodemain:v1.0 .' 
                
            } 
            
        }
        stage('Generate Logo dev') { 
            when { branch 'dev' } 
            steps { 
                sh label: 'Generate Logo', script: '''
cat <<EOF > dev_logo.svg
<svg width="150" height="150" xmlns="http://www.w3.org/2000/svg"> \
<circle cx="75" cy="75" r="60" fill="#F36D25" /> </svg>
EOF
                ''' 
                sh 'cp dev_logo.svg src/logo.svg' 
                
            } 
            
        }
        stage('Build Docker Image nodedev:v1.0') {
            when { branch "dev" }
            steps {
                sh 'docker build -t nodedev:v1.0 .'

            }

        } 
        stage('Deploy dev') { 
            when { branch 'dev' } 
            steps { 
                sh "docker run -d -p ${env.DEV_PORT}:3000 nodedev:v1.0"
                
            } 
            
        } 
        stage('Deploy nain') {
            when { branch 'main' } 
            steps {
                sh "docker run -d -p ${env.MAIN_PORT}:3000 nodemain:v1.0" 
                
            } 
            
        } 
        
    } 
    
}
