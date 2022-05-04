pipeline {
  options {
    timestamps()
    disableConcurrentBuilds()
    timeout(time: 180, unit: 'MINUTES')
  }
  parameters {
    booleanParam(defaultValue: true, description: 'Whether the latest-X repository should reference this build, if it succeeds. Enabled by default. Generally this is disabled when building for a service release.', name: 'UPDATE_LATEST_X')
    string(defaultValue: 'master', description: 'The branch of the Git repositories that will be build. Committers should not need to touch this field.', name: 'BUILD_BRANCH')
    string(defaultValue: '', description: 'If a value is set, this will create a composite p2 repository pointing to this resulting build (if successful), at the given name under the downloads page.<br/><br/>This is only ever set to the release name (eg. 2019-06) for a milestone (S) build. The purpose is to give consumers a static location that tracks the release.', name: 'SIMREL_NAME')
    choice(choices: ['I', 'S', 'M', 'R'], description: 'Valid options : I, S, M, or R. Most committers should be using I. S, M, or R should be done by a project lead, or someone tasked with putting together the release.', name: 'BUILD_LABEL')
    string(defaultValue: '', description: 'Description to appear on the downloads page.', name: 'DESCRIPTION')
  }
  agent {
    kubernetes {
      defaultContainer 'jnlp'
      yamlFile 'pod.yml'
    }
  }
  environment {
    MAVEN_OPTS = "-Xmx2G"
    scriptDir= "./releng/scripts"
    repoDir = "releng/repository/target/repository"
  }
  stages {
    stage('Prepare') {
      steps {
        script {
            currentBuild.displayName = env.SIMREL_NAME + " " + env.BUILD_LABEL + "-build (#" + env.BUILD_NUMBER + ")"
            currentBuild.description = env.DESCRIPTION
        }
        container('container') {
          git branch: "${BUILD_BRANCH}", url: 'https://git.eclipse.org/r/orbit/orbit-recipes'
        }
      }
    }
    stage('Build') {
      steps {
        container('container') {
          sh 'mvn -V -B -e clean install -Declipse-sign=true -Dartifact-comparator=true'
          sh 'mvn -V -B -e clean install -Declipse-sign=true -Dartifact-comparator=true -f releng/aggregationfeature/pom.xml'
        }
      }
    }
    stage('Generate-Repositories') {
      steps {
        container('container') {
          sh 'mvn -V -B -e clean verify -Declipse-sign=true -Dartifact-comparator=true -DbuildType=${BUILD_LABEL} -f releng/pom.xml'
        }
      }
    }
    stage ('Deploy') {
      steps {
        container('container') {
          sshagent ( ['projects-storage.eclipse.org-bot-ssh']) {
            sh '${scriptDir}/deploy.sh'
          }
        }
      }
      post {
        always {
          archiveArtifacts artifacts: 'releng/repository/target/repository/**'
        }
      }
    }
  }
}
