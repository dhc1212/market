#!/usr/bin/env groovy 

/*
 * This file bootstraps the codified Continuous Delivery pipeline for extensions of SAP solutions such as SAP S/4HANA.
 * The pipeline helps you to deliver software changes quickly and in a reliable manner.
 * A suitable Jenkins instance is required to run the pipeline.
 * More information on getting started with Continuous Delivery can be found here: https://sap.github.io/jenkins-library/
 */

// @Library('piper-lib-os') _

// piperPipeline script: this


/* MDPERT Jenkins Guide : 2023.04.04
 *
 */
@Library('piper-lib-os') _
node() {
    stage('prepare') {
        deleteDir()
        checkout scm
        setupCommonPipelineEnvironment script:this
    }

    stage('build') {
        mtaBuild script: this
    }

    stage('deploy') {
        cloudFoundryDeploy script: this
    }

    // stage('tmsupload') {
    //     tmsUpload script: this
    // }
}

