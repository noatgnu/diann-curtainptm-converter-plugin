#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { DIANN_CURTAINPTM_CONVERTER } from './modules/local/diann-curtainptm-converter/main'

workflow PIPELINE {
    main:
    DIANN_CURTAINPTM_CONVERTER (
        params.pr_file ? Channel.fromPath(params.pr_file).collect() : Channel.of([]),
        params.report_file ? Channel.fromPath(params.report_file).collect() : Channel.of([]),
        Channel.value(params.modification_type ?: ''),
        params.fasta_file ? Channel.fromPath(params.fasta_file).collect() : Channel.of([]),
        Channel.value(params.localization_score_col ?: ''),
        Channel.value(params.multiple_site ?: ''),
        Channel.value(params.uniprot_columns ?: ''),
        Channel.value(params.output_filename ?: ''),
        Channel.value(params.output_meta ?: ''),
        Channel.value(params.sequence_window_size ?: ''),
    )
}

workflow {
    PIPELINE ()
}
