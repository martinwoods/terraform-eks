@Library("vectorShared") _

import groovy.json.JsonSlurper

def buildHelper=new com.retailinmotion.buildHelper()
def branchName="$env.BRANCH_NAME"

def octopusHelperJenkinsUrl="${env.JENKINS_URL}"

def changes
def changesFile="changes.txt"
def dockerPullRim = env.DockerPullRIM

pipeline {
    agent { label 'docker'}
	options { skipDefaultCheckout() }

	stages {
		/*
		* Clean up artifacts that are possibly left over from a previous build
		*/			
		stage('Clean and Checkout'){
        	when { anyOf { branch 'master'; changeRequest() } }
			steps {
				cleanWs()
				checkout scm
			}
		}
		
		/*
		* Call GitVersion to get version information
		*/ 
		stage ('Get Version Info'){
            when { anyOf { branch 'master'; changeRequest() } }
			steps {
				script {
					versionInfo = buildHelper.getGitVersionInfo(env.GitVersionImage, docker, null, env.CHANGE_BRANCH)
					echo "Version Info:"
					echo versionInfo.toString()
					packageString=versionInfo.SafeInformationalVersion.toString()
					currentBuild.displayName = "#${versionInfo.FullSemVer}"
					currentBuild.description = "${versionInfo.InformationalVersion}"
				}
			}
	    }

		/*
		* Scan with TFSec
		*/
		stage ('TFSec scan'){
		    when { anyOf { branch 'master'; changeRequest() } }
            steps {
				script{
					buildHelper.runTfsec(env.WORKSPACE, "${dockerPullRim}/tfsec/tfsec:latest", "--force-all-dirs --no-colour --soft-fail")
				}
            }
		}

		/*
		* Package up the build artifacts into zip files
		*/
		stage ('Package') {
            when { anyOf { branch 'master'; changeRequest() } }
			steps{
				// Create zip artifacts
				script {
					codebaseZip="terraform_eks.${packageString}.zip"
				}
				zip zipFile: codebaseZip, archive: false, dir: '', glob: '**/*.tf, **/octopus.tfvars'
			}
		}

		/*
		* Store the build artifacts in Octopus package repository
		*/
        stage ('Deploy to Octopus') {
            when { anyOf { branch 'master'; changeRequest() } }
			steps {
				script {
						octopusHelper=new com.retailinmotion.OctopusHelper()
						octopusHelper.pushPackage(octopusHelperJenkinsUrl, codebaseZip)

					}
			}
		}

		/*
		* Write a Change Log
		*/			
		stage ('Write Changelog'){
            when { anyOf { branch 'master'; changeRequest() } }
			steps {
				script {
					changes=buildHelper.getChangeString()
					writeFile file: changesFile, text: changes
				}
			}
		}

		/*
		* Create a Release
		*/				
		stage ('Create Release'){
            when { anyOf { branch 'master'; changeRequest() } }
			steps {
				script {
					octopusHelper.createReleaseFromFolder(octopusHelperJenkinsUrl, "Terraform EKS", "${packageString}", "./", "--releasenotesfile=\"$changesFile\" --package=\"Configure kafka client key\":13.0.1-windows-x64-bin")
				}
			}
				
		}
		/*
		* Clean up artifacts that are possibly at the end of build
		*/			
		stage('Clean workspace'){
        	when { anyOf { branch 'master'; changeRequest() } }
			steps {
				cleanWs()
			}
		}
	}
}

