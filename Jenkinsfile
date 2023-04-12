pipeline { 
    agent {
 
	label 'slave1'
 
    } 
    tools {nodejs "node"} 
    stages { 
        stage('Checkout') { 
            steps { checkout scm } 
            
        } 
        stage('Build') { 
            steps {
                timeout(time: 35, unit: 'MINUTES') { 
                    sh 'npm install'
                } 
                
            } 
            
        } 
        stage('Test') { 
            steps { 
                sh 'npm test' 
                
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
        stage('Build Docker Image') { 
            steps { 
                sh 'docker build -t cicd-pipeline .' 
                
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
        stage('Deploy dev') { 
            when { changeset "dev/**" } 
            steps { 
                sh 'docker run -d -p 3001:3000 -v $(pwd)/src:/usr/src/app/src cicd-pipeline' 
                
            } 
            
        } 
        stage('Deploy nain') { 
            when { changeset "main/**" } 
            steps { 
                sh 'docker run -d -p 3000:3000 -v $(pwd)/src:/usr/src/app/src cicd-pipeline' 
                
            } 
            
        } 
        
    } 
    
}
