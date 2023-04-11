pipeline { 
    agent any 
    stages { 
        stage('Checkout') { 
            steps { checkout scm } 
            
        } 
        stage('Build') { 
            steps { 
                sh 'npm install' 
                
            } 
            
        } 
        stage('Test') { 
            steps { 
                sh 'npm test' 
                
            } 
            
        } 
        stage('Generate Logo') { 
            when { branch 'main' } 
            steps { 
                sh 'python3 generate_logo.py main_logo.svg' 
                sh 'cp main_logo.svg src/logo.svg' 
                
            } 
            
        } 
        stage('Build Docker Image') { 
            steps { 
                sh 'docker build -t cicd-pipeline .' 
                
            } 
            
        } 
        stage('Generate Logo') { 
            when { branch 'dev' } 
            steps { 
                sh 'python3 generate_logo.py dev_logo.svg' 
                sh 'cp dev_logo.svg src/logo.svg' 
                
            } 
            
        } 
        stage('Deploy') { 
            when { changeset "dev/**" } 
            steps { 
                sh 'docker run -d -p 3001:3000 -v $(pwd)/src:/usr/src/app/src cicd-pipeline' 
                
            } 
            
        } 
        stage('Deploy') { 
            when { changeset "main/**" } 
            steps { 
                sh 'docker run -d -p 3000:3000 -v $(pwd)/src:/usr/src/app/src cicd-pipeline' 
                
            } 
            
        } 
        
    } 
    
}
