pipeline {
  options {
    timestamps()
    disableConcurrentBuilds()
    timeout(time: 180, unit: 'MINUTES')
  }
  parameters {
    string(defaultValue: '', description: 'The location of the composite repository build folder relative to the root of the orbit folder. (eg. S-builds/S20161021172207/ ).', name: 'SRC_LOCATION')
    string(defaultValue: 'downloads/drops', description: 'The destination for the composite repository.', name: 'DST_LOCATION')
    string(defaultValue: '', description: 'Optional parameter to specify the name for the destination directory (eg. latest-N). If empty, the name of the destination directory will be the same as the source location.', name: 'NEW_NAME')
  }
  agent {
    kubernetes {
      defaultContainer 'jnlp'
      yamlFile 'pod.yaml'
    }
  }
  environment {
    MAVEN_OPTS = "-Xmx2G"
    scriptDir= "releng/scripts"
    repoDir = "releng/repository/target/repository"
  }
  stages {
    stage ('Promote') {
      steps {
        container('container') {
          sshagent ( ['projects-storage.eclipse.org-bot-ssh']) {
            sh '${scriptDir}/promote-to-downloads.sh'
          }
        }
      }
    }
  }
}
